Return-Path: <aik@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1E29B711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 16:38:51 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p1G5coc5007149
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2011 16:38:50 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1G5cnHr2416682
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2011 16:38:49 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p1G5cmpt022578
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2011 16:38:48 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p1G5cmaZ022575
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2011 16:38:48 +1100
Received: from [10.61.2.175] (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id AE28A73440
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 16:38:48 +1100 (EST)
Message-ID: <4D5B62F2.3020709@au1.ibm.com>
Date: Wed, 16 Feb 2011 16:38:58 +1100
From: Alexey Kardashevskiy <aik@au1.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Per process DSCR + somefixes (try#3)
Content-Type: multipart/mixed; boundary="------------070901000907060004040407"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070901000907060004040407
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

step1: http://patchwork.ozlabs.org/patch/71489/
step2: http://patchwork.ozlabs.org/patch/81423/

In step2 I defined sysfs node as:

static SYSDEV_ATTR(dscr_default, 0600, show_dscr_default, 
store_dscr_default);

and it caused problems with rhel6.
Now it is:

static SYSDEV_CLASS_ATTR(dscr_default, 0600, show_dscr_default, 
store_dscr_default);

It works now on both 2.6.32 and 2.6.36 but is that correct?

-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail/sametime: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM



--------------070901000907060004040407
Content-Type: text/x-patch;
 name="dscr.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dscr.2.patch"

diff -Nuar ../linus-before-dscr/arch/powerpc//include/asm/emulated_ops.h linus-dscr/arch/powerpc//include/asm/emulated_ops.h
--- ../linus-before-dscr/arch/powerpc//include/asm/emulated_ops.h	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//include/asm/emulated_ops.h	2011-01-04 12:53:50.000000000 +1100
@@ -52,6 +52,10 @@
 #ifdef CONFIG_VSX
 	struct ppc_emulated_entry vsx;
 #endif
+#ifdef CONFIG_PPC64
+	struct ppc_emulated_entry mfdscr;
+	struct ppc_emulated_entry mtdscr;
+#endif
 } ppc_emulated;
 
 extern u32 ppc_warn_emulated;
diff -Nuar ../linus-before-dscr/arch/powerpc//include/asm/ppc-opcode.h linus-dscr/arch/powerpc//include/asm/ppc-opcode.h
--- ../linus-before-dscr/arch/powerpc//include/asm/ppc-opcode.h	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//include/asm/ppc-opcode.h	2011-01-04 12:53:50.000000000 +1100
@@ -39,6 +39,10 @@
 #define PPC_INST_RFCI			0x4c000066
 #define PPC_INST_RFDI			0x4c00004e
 #define PPC_INST_RFMCI			0x4c00004c
+#define PPC_INST_MFSPR_DSCR		0x7c1102a6
+#define PPC_INST_MFSPR_DSCR_MASK	0xfc1fffff
+#define PPC_INST_MTSPR_DSCR		0x7c1103a6
+#define PPC_INST_MTSPR_DSCR_MASK	0xfc1fffff
 
 #define PPC_INST_STRING			0x7c00042a
 #define PPC_INST_STRING_MASK		0xfc0007fe
diff -Nuar ../linus-before-dscr/arch/powerpc//include/asm/processor.h linus-dscr/arch/powerpc//include/asm/processor.h
--- ../linus-before-dscr/arch/powerpc//include/asm/processor.h	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//include/asm/processor.h	2011-02-02 10:36:21.000000000 +1100
@@ -240,6 +240,10 @@
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
 #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
+#ifdef CONFIG_PPC64
+	unsigned long	dscr;
+	int		dscr_inherit;
+#endif
 };
 
 #define ARCH_MIN_TASKALIGN 16
diff -Nuar ../linus-before-dscr/arch/powerpc//kernel/asm-offsets.c linus-dscr/arch/powerpc//kernel/asm-offsets.c
--- ../linus-before-dscr/arch/powerpc//kernel/asm-offsets.c	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//kernel/asm-offsets.c	2011-01-04 12:53:50.000000000 +1100
@@ -74,6 +74,7 @@
 	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
+	DEFINE(THREAD_DSCR, offsetof(struct thread_struct, dscr));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
 #endif /* CONFIG_PPC64 */
diff -Nuar ../linus-before-dscr/arch/powerpc//kernel/entry_64.S linus-dscr/arch/powerpc//kernel/entry_64.S
--- ../linus-before-dscr/arch/powerpc//kernel/entry_64.S	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//kernel/entry_64.S	2011-02-02 06:13:17.000000000 +1100
@@ -421,6 +421,12 @@
 	std	r24,THREAD_VRSAVE(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+BEGIN_FTR_SECTION
+	mfspr	r25,SPRN_DSCR
+	std	r25,THREAD_DSCR(r3)
+END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
+#endif
 	and.	r0,r0,r22
 	beq+	1f
 	andc	r22,r22,r0
@@ -522,6 +528,15 @@
 	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+BEGIN_FTR_SECTION
+	ld	r0,THREAD_DSCR(r4)
+	cmpd	r0,r25
+	beq	1f
+	mtspr	SPRN_DSCR,r0
+1:	
+END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
+#endif
 
 	/* r3-r13 are destroyed -- Cort */
 	REST_8GPRS(14, r1)
diff -Nuar ../linus-before-dscr/arch/powerpc//kernel/process.c linus-dscr/arch/powerpc//kernel/process.c
--- ../linus-before-dscr/arch/powerpc//kernel/process.c	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//kernel/process.c	2011-02-16 16:27:37.000000000 +1100
@@ -700,6 +700,8 @@
 /*
  * Copy a thread..
  */
+extern unsigned long dscr_default; /* defined in arch/powerpc/kernel/sysfs.c */
+
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused, struct task_struct *p,
 		struct pt_regs *regs)
@@ -767,6 +769,20 @@
 		p->thread.ksp_vsid = sp_vsid;
 	}
 #endif /* CONFIG_PPC_STD_MMU_64 */
+#ifdef CONFIG_PPC64 
+	if (cpu_has_feature(CPU_FTR_DSCR)) {
+		if (current->thread.dscr_inherit) {
+			p->thread.dscr_inherit = 1;
+			p->thread.dscr = current->thread.dscr;
+		} else if (0 != dscr_default) {
+			p->thread.dscr_inherit = 1;
+			p->thread.dscr = dscr_default;
+		} else {
+			p->thread.dscr_inherit = 0;
+			p->thread.dscr = 0;
+		}
+	}
+#endif
 
 	/*
 	 * The PPC64 ABI makes use of a TOC to contain function 
diff -Nuar ../linus-before-dscr/arch/powerpc//kernel/sysfs.c linus-dscr/arch/powerpc//kernel/sysfs.c
--- ../linus-before-dscr/arch/powerpc//kernel/sysfs.c	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//kernel/sysfs.c	2011-02-16 16:27:58.000000000 +1100
@@ -182,6 +182,41 @@
 static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
 static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
 static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
+
+unsigned long dscr_default = 0;
+EXPORT_SYMBOL(dscr_default);
+
+static ssize_t show_dscr_default(struct sysdev_class *class,
+		struct sysdev_class_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lx\n", dscr_default);
+}
+
+static ssize_t __used store_dscr_default(struct sysdev_class *class,
+		struct sysdev_class_attribute *attr, const char *buf,
+		size_t count)
+{
+	unsigned long val;
+	int ret = 0;
+	
+	ret = sscanf(buf, "%lx", &val);
+	if (ret != 1)
+		return -EINVAL;
+	dscr_default = val;
+
+	return count;
+}
+
+static SYSDEV_CLASS_ATTR(dscr_default, 0600,
+		show_dscr_default, store_dscr_default);
+
+static void sysfs_create_dscr_default(void)
+{
+	int err = 0;
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+			&attr_dscr_default.attr);
+}
 #endif /* CONFIG_PPC64 */
 
 #ifdef HAS_PPC_PMC_PA6T
@@ -617,6 +652,9 @@
 		if (cpu_online(cpu))
 			register_cpu_online(cpu);
 	}
+#ifdef CONFIG_PPC64
+	sysfs_create_dscr_default();
+#endif /* CONFIG_PPC64 */
 
 	return 0;
 }
diff -Nuar ../linus-before-dscr/arch/powerpc//kernel/traps.c linus-dscr/arch/powerpc//kernel/traps.c
--- ../linus-before-dscr/arch/powerpc//kernel/traps.c	2010-10-27 14:25:45.000000000 +1100
+++ linus-dscr/arch/powerpc//kernel/traps.c	2011-02-16 16:00:18.000000000 +1100
@@ -919,6 +919,26 @@
 		return emulate_isel(regs, instword);
 	}
 
+#ifdef CONFIG_PPC64
+	/* Emulate the mfspr rD, DSCR. */
+	if (((instword & PPC_INST_MFSPR_DSCR_MASK) == PPC_INST_MFSPR_DSCR) &&
+			cpu_has_feature(CPU_FTR_DSCR)) {
+		PPC_WARN_EMULATED(mfdscr, regs);
+		rd = (instword >> 21) & 0x1f;
+		regs->gpr[rd] = mfspr(SPRN_DSCR);
+		return 0;
+	}
+	/* Emulate the mtspr DSCR, rD. */
+	if (((instword & PPC_INST_MTSPR_DSCR_MASK) == PPC_INST_MTSPR_DSCR) &&
+			cpu_has_feature(CPU_FTR_DSCR)) {
+		PPC_WARN_EMULATED(mtdscr, regs);
+		rd = (instword >> 21) & 0x1f;
+		mtspr(SPRN_DSCR, regs->gpr[rd]);
+		current->thread.dscr_inherit = 1;
+		return 0;
+	}
+#endif
+
 	return -EINVAL;
 }
 
@@ -1516,6 +1536,10 @@
 #ifdef CONFIG_VSX
 	WARN_EMULATED_SETUP(vsx),
 #endif
+#ifdef CONFIG_PPC64
+	WARN_EMULATED_SETUP(mfdscr),
+	WARN_EMULATED_SETUP(mtdscr),
+#endif
 };
 
 u32 ppc_warn_emulated;

--------------070901000907060004040407--
