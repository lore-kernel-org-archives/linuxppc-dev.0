Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03D77DE18C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:23:31 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9B7N4HD015719
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:23:04 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9B7N4FG4300934
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:23:04 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9B7KCkP031684
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:20:12 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av01.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9B7KBCR030866
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:20:11 +1000
Received: from ubrain (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with SMTP id 9D81F73602
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:22:31 +1000 (EST)
Message-Id: <20071011072208.581048790@au1.ibm.com>
References: <20071011071558.676463639@au1.ibm.com>
Date: Thu, 11 Oct 2007 17:16:00 +1000
From: markn@au1.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [patch 2/2] add Altivec/VMX state to coredumps
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update dump_task_altivec() (that has so far never been put to use)
so that it dumps the Altivec/VMX registers (VR[0] - VR[31], VSCR
and VRSAVE) in the same format as the ptrace get_vrregs() and add
the appropriate glue typedef and #defines to make it work.

A new note type of NT_PPC_VMX was chosen to be 0x100 (arbitrarily)
because it allows the low range values to be used for more generic
purposes and 0x100 seems an adequate starting point for PowerPC
extensions.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/kernel/process.c |   28 +++++++++++++++++++++++++---
 include/asm-powerpc/elf.h     |    8 ++++++++
 include/linux/elf.h           |    1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

Index: linux/arch/powerpc/kernel/process.c
===================================================================
--- linux.orig/arch/powerpc/kernel/process.c
+++ linux/arch/powerpc/kernel/process.c
@@ -149,10 +149,32 @@ void flush_altivec_to_thread(struct task
 	}
 }
 
-int dump_task_altivec(struct pt_regs *regs, elf_vrregset_t *vrregs)
+int dump_task_altivec(struct task_struct *tsk, elf_vrregset_t *vrregs)
 {
-	flush_altivec_to_thread(current);
-	memcpy(vrregs, &current->thread.vr[0], sizeof(*vrregs));
+	/* ELF_NVRREG includes the VSCR and VRSAVE which we need to save
+	 * separately, see below */
+	const int nregs = ELF_NVRREG - 2;
+	elf_vrreg_t *reg;
+	u32 *dest;
+
+	if (tsk == current)
+		flush_altivec_to_thread(tsk);
+
+	reg = (elf_vrreg_t *)vrregs;
+
+	/* copy the 32 vr registers */
+	memcpy(reg, &tsk->thread.vr[0], nregs * sizeof(*reg));
+	reg += nregs;
+
+	/* copy the vscr */
+	memcpy(reg, &tsk->thread.vscr, sizeof(*reg));
+	reg++;
+
+	/* vrsave is stored in the high 32bit slot of the final 128bits */
+	memset(reg, 0, sizeof(*reg));
+	dest = (u32 *)reg;
+	*dest = tsk->thread.vrsave;
+
 	return 1;
 }
 #endif /* CONFIG_ALTIVEC */
Index: linux/include/asm-powerpc/elf.h
===================================================================
--- linux.orig/include/asm-powerpc/elf.h
+++ linux/include/asm-powerpc/elf.h
@@ -212,6 +212,14 @@ static inline int dump_task_regs(struct 
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *); 
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 
+typedef elf_vrregset_t elf_fpxregset_t;
+
+#ifdef CONFIG_ALTIVEC
+extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
+#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_altivec(tsk, regs)
+#define ELF_CORE_XFPREG_TYPE NT_PPC_VMX
+#endif
+
 #endif /* __KERNEL__ */
 
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
Index: linux/include/linux/elf.h
===================================================================
--- linux.orig/include/linux/elf.h
+++ linux/include/linux/elf.h
@@ -355,6 +355,7 @@ typedef struct elf64_shdr {
 #define NT_TASKSTRUCT	4
 #define NT_AUXV		6
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
+#define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
 
 
 /* Note header in a PT_NOTE section */

-- 
