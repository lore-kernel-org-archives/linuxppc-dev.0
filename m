Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6315BDDF2B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 17:15:56 +1100 (EST)
Date: Tue, 30 Jan 2007 00:13:32 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: RFC: kprobes support for ppc32
Message-ID: <Pine.LNX.4.64.0701300010550.32498@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, prasanna@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a first cut on ppc32 support for kprobes.  I haven't tested this, 
but I think I got all the places that needed fixing up.

- k

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d6abe49..db1e118 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1182,7 +1182,7 @@ source "arch/powerpc/oprofile/Kconfig"

  config KPROBES
  	bool "Kprobes (EXPERIMENTAL)"
-	depends on PPC64 && KALLSYMS && EXPERIMENTAL && MODULES
+	depends on !BOOKE && KALLSYMS && EXPERIMENTAL && MODULES
  	help
  	  Kprobes allows you to trap at almost any kernel address and
  	  execute a callback function.  register_kprobe() establishes
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 4657563..dd2886f 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -46,8 +46,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
  	if ((unsigned long)p->addr & 0x03) {
  		printk("Attempt to register kprobe at an unaligned address\n");
  		ret = -EINVAL;
-	} else if (IS_MTMSRD(insn) || IS_RFID(insn)) {
-		printk("Cannot register a kprobe on rfid or mtmsrd\n");
+	} else if (IS_MTMSRD(insn) || IS_RFID(insn) || IS_RFI(insn)) {
+		printk("Cannot register a kprobe on rfi/rfid or mtmsr[d]\n");
  		ret = -EINVAL;
  	}

@@ -483,8 +483,12 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
  	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));

  	/* setup return addr to the jprobe handler routine */
+#ifdef CONFIG_PPC64
  	regs->nip = (unsigned long)(((func_descr_t *)jp->entry)->entry);
  	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
+#else
+	regs->nip = (unsigned long)jp->entry;
+#endif

  	return 1;
  }
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a0360ae..116432f 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,10 +16,10 @@ obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
  			   strcase.o
  obj-$(CONFIG_QUICC_ENGINE) += rheap.o
  obj-$(CONFIG_XMON)	+= sstep.o
+obj-$(CONFIG_KPROBES) += sstep.o

  ifeq ($(CONFIG_PPC64),y)
  obj-$(CONFIG_SMP)	+= locks.o
-obj-$(CONFIG_DEBUG_KERNEL) += sstep.o
  endif

  # Temporary hack until we have migrated to asm-powerpc
diff --git a/include/asm-powerpc/kprobes.h b/include/asm-powerpc/kprobes.h
index 2dafa37..4658a95 100644
--- a/include/asm-powerpc/kprobes.h
+++ b/include/asm-powerpc/kprobes.h
@@ -66,7 +66,11 @@ typedef unsigned int kprobe_opcode_t;
  	}								\
  }

+#ifdef CONFIG_PPC64
  #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
+#else
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)(pentry)
+#endif

  #define is_trap(instr)	(IS_TW(instr) || IS_TD(instr) || \
  			IS_TWI(instr) || IS_TDI(instr))
diff --git a/include/asm-powerpc/sstep.h b/include/asm-powerpc/sstep.h
index 630a988..f593b0f 100644
--- a/include/asm-powerpc/sstep.h
+++ b/include/asm-powerpc/sstep.h
@@ -21,6 +21,7 @@ struct pt_regs;
   */
  #define IS_MTMSRD(instr)	(((instr) & 0xfc0007be) == 0x7c000124)
  #define IS_RFID(instr)		(((instr) & 0xfc0007fe) == 0x4c000024)
+#define IS_RFI(instr)		(((instr) & 0xfc0007fe) == 0x4c000064)

  /* Emulate instructions that cause a transfer of control. */
  extern int emulate_step(struct pt_regs *regs, unsigned int instr);
