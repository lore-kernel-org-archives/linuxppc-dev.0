Message-ID: <38FC487D.86AF34FF@lightning.ch>
Date: Tue, 18 Apr 2000 13:35:25 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>,
        Linux PowerPC development mailing list
 <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH 2.3.99-pre5-dm3] Math and AltiVec cleanup
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan,

This patch introduces CONFIG_MATH. CONFIG_MATH is set on PPC CPUs which
have floating-point or if CONFIG_MATH_EMULATION is selected. Every piece
of code in the kernel which depends on floating-point is now in a
"#ifdef CONFIG_MATH" / "#endif" pair. Same goes for AltiVec.


				Daniel Marmier



diff -urN linux-2.3.99-pre5/arch/ppc/config.in linux-2.3.99-pre5-dm/arch/ppc/config.in
--- linux-2.3.99-pre5/arch/ppc/config.in	Wed Apr 12 09:32:28 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/config.in	Tue Apr 18 12:09:29 2000
@@ -68,6 +68,11 @@
 if [ "$CONFIG_4xx" = "y" -o "$CONFIG_8xx" = "y" ]; then
   bool 'Math emulation' CONFIG_MATH_EMULATION
 fi
+if [ "$CONFIG_4xx" = "y" -o "$CONFIG_8xx" = "y" ]; then
+  define_bool CONFIG_MATH $CONFIG_MATH_EMULATION
+else
+  define_bool CONFIG_MATH y
+fi
 endmenu

 mainmenu_option next_comment
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/align.c linux-2.3.99-pre5-dm/arch/ppc/kernel/align.c
--- linux-2.3.99-pre5/arch/ppc/kernel/align.c	Tue Dec 14 16:22:58 1999
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/align.c	Tue Apr 18 11:16:49 2000
@@ -237,8 +237,10 @@
 			return -EFAULT;	/* bad address */
 	}

+#ifdef CONFIG_MATH
 	if ((flags & F) && (regs->msr & MSR_FP))
 		giveup_fpu(current);
+#endif /* CONFIG_MATH */
 	if (flags & M)
 		return 0;		/* too hard for now */

@@ -285,6 +287,7 @@
 			SWAP(data.v[1], data.v[2]);
 		}
 		break;
+#ifdef CONFIG_MATH
 	case LD+F:
 		current->thread.fpr[reg] = data.d;
 		break;
@@ -305,6 +308,7 @@
 		cvt_df(&current->thread.fpr[reg], &data.f, &current->thread.fpscr);
 		/* data.f = current->thread.fpr[reg]; */
 		break;
+#endif /* CONFIG_MATH */
 	default:
 		printk("align: can't handle flags=%x\n", flags);
 		return 0;
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/entry.S linux-2.3.99-pre5-dm/arch/ppc/kernel/entry.S
--- linux-2.3.99-pre5/arch/ppc/kernel/entry.S	Mon Mar  6 16:52:14 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/entry.S	Tue Apr 18 11:45:11 2000
@@ -209,10 +209,17 @@
 	mflr	r20		/* Return to switch caller */
 	mfmsr	r22
 	li	r0,MSR_FP	/* Disable floating-point */
-#ifdef CONFIG_ALTIVEC
-	oris	r0,r0,MSR_VEC@h
-#endif /* CONFIG_ALTIVEC */
-	andc	r22,r22,r0
+#if defined(CONFIG_MATH) && defined(CONFIG_ALTIVEC)
+	li      r0,MSR_FP       /* Disable floating-point */
+	oris    r0,r0,MSR_VEC@h
+	andc    r22,r22,r0
+#elif defined (CONFIG_MATH)
+	li      r0,MSR_FP       /* Disable floating-point */
+	andc    r22,r22,r0
+#elif defined(CONFIG_ALTIVEC)
+	lis     r0,MSR_VEC@h
+	andc    r22,r22,r0
+#endif
 	stw	r20,_NIP(r1)
 	stw	r22,_MSR(r1)
 	stw	r20,_LINK(r1)
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/head_8xx.S linux-2.3.99-pre5-dm/arch/ppc/kernel/head_8xx.S
--- linux-2.3.99-pre5/arch/ppc/kernel/head_8xx.S	Fri Jan 21 13:35:57 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/head_8xx.S	Tue Apr 18 11:47:56 2000
@@ -612,9 +612,11 @@
 	SYNC
 	rfi

+#ifdef CONFIG_MATH
 	.globl	giveup_fpu
 giveup_fpu:
 	blr
+#endif

 /*
  * This code is jumped to from the startup code to copy
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/mk_defs.c linux-2.3.99-pre5-dm/arch/ppc/kernel/mk_defs.c
--- linux-2.3.99-pre5/arch/ppc/kernel/mk_defs.c	Mon Mar  6 16:52:14 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/mk_defs.c	Tue Apr 18 11:49:28 2000
@@ -47,8 +47,10 @@
 	DEFINE(PF_TRACESYS, PF_TRACESYS);
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(NEED_RESCHED, offsetof(struct task_struct, need_resched));
+#ifdef CONFIG_MATH
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
 	DEFINE(THREAD_FPSCR, offsetof(struct thread_struct, fpscr));
+#endif /* CONFIG_MATH */
 #ifdef CONFIG_ALTIVEC
 	DEFINE(THREAD_VR0, offsetof(struct thread_struct, vr[0]));
 	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/process.c linux-2.3.99-pre5-dm/arch/ppc/kernel/process.c
--- linux-2.3.99-pre5/arch/ppc/kernel/process.c	Mon Mar  6 16:52:14 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/process.c	Tue Apr 18 13:24:16 2000
@@ -45,8 +45,12 @@
 int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs);
 extern unsigned long _get_SP(void);

+#ifdef CONFIG_MATH
 struct task_struct *last_task_used_math = NULL;
+#endif /* CONFIG_MATH */
+#ifdef CONFIG_ALTIVEC
 struct task_struct *last_task_used_altivec = NULL;
+#endif /* CONFIG_ALTIVEC */
 static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
@@ -166,6 +170,7 @@
 }
 #endif /* CONFIG_ALTIVEC */

+#ifdef CONFIG_MATH
 void
 enable_kernel_fp(void)
 {
@@ -178,14 +183,19 @@
 	giveup_fpu(last_task_used_math);
 #endif /* __SMP__ */
 }
+#endif /* CONFIG_MATH */

 int
 dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
 {
+#ifdef CONFIG_MATH
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 	memcpy(fpregs, &current->thread.fpr[0], sizeof(*fpregs));
 	return 1;
+#else /* CONFIG_MATH */
+	return 0;
+#endif /* CONFIG_MATH */
 }

 void
@@ -209,6 +219,7 @@
 	       new->fs->root,prev->fs->root);
 #endif
 #ifdef __SMP__
+#ifdef CONFIG_MATH
 	/* avoid complexity of lazy save/restore of fpu
 	 * by just saving it every time we switch out if
 	 * this task used the fpu during the last quantum.
@@ -220,6 +231,7 @@
 	 */
 	if ( prev->thread.regs && (prev->thread.regs->msr & MSR_FP) )
 		giveup_fpu(prev);
+#endif /* CONFIG_MATH */
 #ifdef CONFIG_ALTIVEC
 	/*
 	 * If the previous thread 1) has some altivec regs it wants saved
@@ -237,11 +249,13 @@
 	prev->last_processor = prev->processor;
 	current_set[smp_processor_id()] = new;
 #endif /* __SMP__ */
+#ifdef CONFIG_ALTIVEC
 	/* Avoid the trap.  On smp this this never happens since
 	 * we don't set last_task_used_altivec -- Cort
 	 */
 	if ( last_task_used_altivec == new )
 		new->thread.regs->msr |= MSR_VEC;
+#endif /* CONFIG_ALTIVEC */
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 	*last = _switch(old_thread, new_thread);
@@ -255,15 +269,19 @@
 	printk("NIP: %08lX XER: %08lX LR: %08lX REGS: %p TRAP: %04lx\n",
 	       regs->nip, regs->xer, regs->link, regs,regs->trap);
 	printk("MSR: %08lx EE: %01x PR: %01x FP: %01x ME: %01x IR/DR: %01x%01x\n",
-	       regs->msr, regs->msr&MSR_EE ? 1 : 0, regs->msr&MSR_PR ? 1 : 0,
-	       regs->msr & MSR_FP ? 1 : 0,regs->msr&MSR_ME ? 1 : 0,
-	       regs->msr&MSR_IR ? 1 : 0,
-	       regs->msr&MSR_DR ? 1 : 0);
+	       regs->msr,
+	       regs->msr & MSR_EE ? 1 : 0, regs->msr & MSR_PR ? 1 : 0,
+	       regs->msr & MSR_FP ? 1 : 0, regs->msr & MSR_ME ? 1 : 0,
+	       regs->msr & MSR_IR ? 1 : 0, regs->msr & MSR_DR ? 1 : 0);
 	printk("TASK = %p[%d] '%s' ",
 	       current, current->pid, current->comm);
-	printk("Last syscall: %ld ", current->thread.last_syscall);
-	printk("\nlast math %p last altivec %p", last_task_used_math,
-	       last_task_used_altivec);
+	printk("Last syscall: %ld\n", current->thread.last_syscall);
+#ifdef CONFIG_MATH
+	printk("last math %p", last_task_used_math);
+#endif /* CONFIG_MATH */
+#ifdef CONFIG_ALTIVEC
+	printk(" last altivec %p", last_task_used_altivec);
+#endif /* CONFIG_ALTIVEC */

 #ifdef __SMP__
 	printk(" CPU: %d last CPU: %d", current->processor,current->last_processor);
@@ -291,18 +309,26 @@

 void exit_thread(void)
 {
+#ifdef CONFIG_MATH
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
+#endif /* CONFIG_MATH */
+#ifdef CONFIG_ALTIVEC
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = NULL;
+#endif /* CONFIG_ALTIVEC */
 }

 void flush_thread(void)
 {
+#ifdef CONFIG_MATH
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
+#endif /* CONFIG_MATH */
+#ifdef CONFIG_ALTIVEC
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = NULL;
+#endif /* CONFIG_ALTIVEC */
 }

 void
@@ -355,6 +381,7 @@
 	}
 	p->thread.last_syscall = -1;

+#ifdef CONFIG_MATH
 	/*
 	 * copy fpu info - assume lazy fpu switch now always
 	 *  -- Cort
@@ -364,6 +391,7 @@
 	memcpy(&p->thread.fpr, &current->thread.fpr, sizeof(p->thread.fpr));
 	p->thread.fpscr = current->thread.fpscr;
 	childregs->msr &= ~MSR_FP;
+#endif /* CONFIG_MATH */

 #ifdef CONFIG_ALTIVEC
 	/*
@@ -433,11 +461,15 @@
 	regs->gpr[1] = sp;
 	regs->msr = MSR_USER;
 	shove_aux_table(sp);
+#ifdef CONFIG_MATH
+	current->thread.fpscr = 0;
 	if (last_task_used_math == current)
 		last_task_used_math = 0;
+#endif /* CONFIG_MATH */
+#ifdef CONFIG_ALTIVEC
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = 0;
-	current->thread.fpscr = 0;
+#endif /* CONFIG_ALTIVEC */
 }

 asmlinkage int sys_clone(int p1, int p2, int p3, int p4, int p5, int p6,
@@ -494,8 +526,10 @@
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
+#ifdef CONFIG_MATH
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
+#endif /* CONFIG_MATH */
 #ifdef CONFIG_ALTIVEC
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/ptrace.c linux-2.3.99-pre5-dm/arch/ppc/kernel/ptrace.c
--- linux-2.3.99-pre5/arch/ppc/kernel/ptrace.c	Fri Dec  3 14:54:42 1999
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/ptrace.c	Tue Apr 18 11:51:52 2000
@@ -383,11 +383,13 @@
 			if (addr < PT_FPR0) {
 				tmp = get_reg(child, addr);
 			}
+#ifdef CONFIG_MATH
 			else if (addr >= PT_FPR0 && addr <= PT_FPSCR) {
 				if (child->thread.regs->msr & MSR_FP)
 					giveup_fpu(child);
 				tmp = ((long *)child->thread.fpr)[addr - PT_FPR0];
 			}
+#endif /* CONFIG_MATH */
 			else
 				ret = -EIO;
 			if (!ret)
@@ -418,6 +420,7 @@
 				ret = 0;
 				goto out;
 			}
+#ifdef CONFIG_MATH
 			if (addr >= PT_FPR0 && addr < PT_FPR0 + 64) {
 				if (child->thread.regs->msr & MSR_FP)
 					giveup_fpu(child);
@@ -425,6 +428,7 @@
 				ret = 0;
 				goto out;
 			}
+#endif /* CONFIG_MATH */
 			goto out;

 		case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/signal.c linux-2.3.99-pre5-dm/arch/ppc/kernel/signal.c
--- linux-2.3.99-pre5/arch/ppc/kernel/signal.c	Tue Dec 14 15:40:29 1999
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/signal.c	Tue Apr 18 11:57:13 2000
@@ -218,8 +218,10 @@
 	if (sc == (struct sigcontext_struct *)(sigctx.regs)) {
 		/* Last stacked signal - restore registers */
 		sr = (struct sigregs *) sigctx.regs;
+#ifdef CONFIG_MATH
 		if (regs->msr & MSR_FP )
 			giveup_fpu(current);
+#endif /* CONFIG_MATH */
 		if (copy_from_user(saved_regs, &sr->gp_regs,
 				   sizeof(sr->gp_regs)))
 			goto badframe;
@@ -227,9 +229,11 @@
 			| (saved_regs[PT_MSR] & MSR_USERCHANGE);
 		memcpy(regs, saved_regs, GP_REGS_SIZE);

+#ifdef CONFIG_MATH
 		if (copy_from_user(current->thread.fpr, &sr->fp_regs,
 				   sizeof(sr->fp_regs)))
 			goto badframe;
+#endif /* CONFIG_MATH */

 		ret = regs->result;

@@ -266,11 +270,15 @@

 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto badframe;
-		if (regs->msr & MSR_FP)
-			giveup_fpu(current);
+#ifdef CONFIG_MATH
+	if (regs->msr & MSR_FP)
+		giveup_fpu(current);
+#endif /* CONFIG_MATH */
 	if (__copy_to_user(&frame->gp_regs, regs, GP_REGS_SIZE)
+#ifdef CONFIG_MATH
 	    || __copy_to_user(&frame->fp_regs, current->thread.fpr,
 			      ELF_NFPREG * sizeof(double))
+#endif /* CONFIG_MATH */
 	    || __put_user(0x38007777UL, &frame->tramp[0])    /* li r0,0x7777 */
 	    || __put_user(0x44000002UL, &frame->tramp[1]))   /* sc */
 		goto badframe;
diff -urN linux-2.3.99-pre5/arch/ppc/kernel/traps.c linux-2.3.99-pre5-dm/arch/ppc/kernel/traps.c
--- linux-2.3.99-pre5/arch/ppc/kernel/traps.c	Mon Mar  6 09:18:54 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/traps.c	Tue Apr 18 11:59:36 2000
@@ -214,8 +214,10 @@
 {
 	int fixed;

+#ifdef CONFIG_MATH
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
+#endif /* CONFIG_MATH */
 	fixed = fix_alignment(regs);
 	if (fixed == 1) {
 		regs->nip += 4;	/* skip over emulated instruction */
diff -urN linux-2.3.99-pre5/arch/ppc/mm/init.c linux-2.3.99-pre5-dm/arch/ppc/mm/init.c
--- linux-2.3.99-pre5/arch/ppc/mm/init.c	Sat Mar 11 11:55:50 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/mm/init.c	Tue Apr 18 12:01:02 2000
@@ -309,12 +309,14 @@
 				printk("current");
 			}

+#ifdef CONFIG_MATH
 			if ( p == last_task_used_math )
 			{
 				if ( iscur )
 					printk(",");
 				printk("last math");
 			}
+#endif /* CONFIG_MATH */
 #endif /* __SMP__ */
 			printk("\n");
 		}
diff -urN linux-2.3.99-pre5/include/asm-ppc/elf.h linux-2.3.99-pre5-dm/include/asm-ppc/elf.h
--- linux-2.3.99-pre5/include/asm-ppc/elf.h	Thu Apr  6 10:40:13 2000
+++ linux-2.3.99-pre5-dm/include/asm-ppc/elf.h	Tue Apr 18 13:13:07 2000
@@ -4,11 +4,20 @@
 /*
  * ELF register definitions..
  */
+#include <linux/config.h>
 #include <asm/ptrace.h>

 #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
+#ifdef CONFIG_MATH
 #define ELF_NFPREG	33	/* includes fpscr */
+#else
+#define ELF_NFPREG	0
+#endif /* CONFIG_MATH */
+#ifdef CONFIG_ALTIVEC
 #define ELF_NVRREG	33	/* includes vscr */
+#else
+#define ELF_NVRREG	0
+#endif /* CONFIG_ALTIVEC */

 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff -urN linux-2.3.99-pre5/include/asm-ppc/processor.h linux-2.3.99-pre5-dm/include/asm-ppc/processor.h
--- linux-2.3.99-pre5/include/asm-ppc/processor.h	Mon Mar  6 16:52:35 2000
+++ linux-2.3.99-pre5-dm/include/asm-ppc/processor.h	Tue Apr 18 13:11:52 2000
@@ -596,8 +596,12 @@
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */

 /* Lazy FPU handling on uni-processor */
+#ifdef CONFIG_MATH
 extern struct task_struct *last_task_used_math;
+#endif /* CONFIG_MATH */
+#ifdef CONFIG_ALTIVEC
 extern struct task_struct *last_task_used_altivec;
+#endif /* CONFIG_ALTIVEC */

 /*
  * this is the minimum allowable io space due to the location
@@ -623,9 +627,11 @@
 	mm_segment_t	fs;		/* for get_fs() validation */
 	void		*pgdir;		/* root of page-table tree */
 	signed long     last_syscall;
+#ifdef CONFIG_MATH
 	double		fpr[32];	/* Complete floating point set */
 	unsigned long	fpscr_pad;	/* fpr ... fpscr must be contiguous */
 	unsigned long	fpscr;		/* Floating point status */
+#endif /* CONFIG_MATH */
 #ifdef CONFIG_ALTIVEC
 	vector128	vr[32];		/* Complete AltiVec set */
 	vector128	vscr;		/* AltiVec status */
@@ -642,7 +648,6 @@
 	KERNEL_DS, /*fs*/ \
 	swapper_pg_dir, /* pgdir */ \
 	0, /* last_syscall */ \
-	{0}, 0, 0 \
 }

 /*

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
