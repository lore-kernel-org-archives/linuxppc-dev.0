Return-Path: <markn@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C319CDDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:05:41 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8P45ele017801
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:05:40 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8P49Fi0065204
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:09:15 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8P45O7g016848
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:05:24 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av04.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l8P45OWN016389
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:05:24 +1000
Received: from [10.61.2.140] (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id 645B5735FA
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:05:06 +1000 (EST)
Message-ID: <46F88896.50706@au1.ibm.com>
Date: Tue, 25 Sep 2007 14:03:34 +1000
From: Mark Nelson <markn@au1.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add Altivec/VMX state to coredumps
Content-Type: text/plain; charset=ISO-8859-1
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
the appropriate glue typedefs and #defines to
include/asm-powerpc/elf.h for it to work.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/kernel/process.c |   28 +++++++++++++++++++++++++---
 include/asm-powerpc/elf.h     |    7 +++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

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
@@ -212,6 +212,13 @@ static inline int dump_task_regs(struct 
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *); 
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 
+typedef elf_vrregset_t elf_fpxregset_t;
+
+#ifdef CONFIG_ALTIVEC
+extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
+#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_altivec(tsk, regs)
+#endif
+
 #endif /* __KERNEL__ */
 
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
