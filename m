Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17542.28427.290805.584316@cargo.ozlabs.ibm.com>
Date: Wed, 7 Jun 2006 16:15:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc: Implement PR_[GS]ET_UNALIGN prctls for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This gives the ability to control whether alignment exceptions get
fixed up or reported to the process as a SIGBUS, using the existing
PR_SET_UNALIGN and PR_GET_UNALIGN prctls.  We do not implement the
option of logging a message on alignment exceptions.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -805,9 +805,11 @@ #endif /* CONFIG_MATH_EMULATION */
 
 void alignment_exception(struct pt_regs *regs)
 {
-	int fixed;
+	int fixed = 0;
 
-	fixed = fix_alignment(regs);
+	/* we don't implement logging of alignment exceptions */
+	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		fixed = fix_alignment(regs);
 
 	if (fixed == 1) {
 		regs->nip += 4;	/* skip over emulated instruction */
diff a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -752,6 +752,17 @@
 	return put_user(val, (unsigned int __user *)adr);
 }
 
+int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
+{
+	tsk->thread.align_ctl = val;
+	return 0;
+}
+
+int get_unalign_ctl(struct task_struct *tsk, unsigned long adr)
+{
+	return put_user(tsk->thread.align_ctl, (unsigned int __user *)adr);
+}
+
 #define TRUNC_PTR(x)	((typeof(x))(((unsigned long)(x)) & 0xffffffff))
 
 int sys_clone(unsigned long clone_flags, unsigned long usp,
diff a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
--- a/include/asm-powerpc/processor.h
+++ b/include/asm-powerpc/processor.h
@@ -149,6 +149,7 @@ #endif
 		unsigned int val;	/* Floating point status */
 	} fpscr;
 	int		fpexc_mode;	/* floating-point exception mode */
+	unsigned int	align_ctl;	/* alignment handling control */
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
@@ -218,6 +219,12 @@ #define SET_FPEXC_CTL(tsk, val) set_fpex
 extern int get_endian(struct task_struct *tsk, unsigned long adr);
 extern int set_endian(struct task_struct *tsk, unsigned int val);
 
+#define GET_UNALIGN_CTL(tsk, adr)	get_unalign_ctl((tsk), (adr))
+#define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
+
+extern int get_unalign_ctl(struct task_struct *tsk, unsigned long adr);
+extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
+
 static inline unsigned int __unpack_fe01(unsigned long msr_bits)
 {
 	return ((msr_bits & MSR_FE0) >> 10) | ((msr_bits & MSR_FE1) >> 8);
