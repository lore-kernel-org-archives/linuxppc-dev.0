Message-Id: <v03110700b52cb98e15b9@[129.100.29.243]>
In-Reply-To: <3906F63F.7AD7A052@lightning.ch>
References: <v03110700b52c8481fb7e@[209.183.131.177]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 26 Apr 2000 11:24:16 -0400
To: Giovanna Ambrosini <ambrosini@lightning.ch>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: patch: POSIX.1b signals for ppc
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Giovanna,

I need to keep using a stable kernel so I have attempted to backport your
POSIX.1b.patch back to Paul's latest 2.2.15pre19 kernel.

Here is the patch.  It compiles cleanly but I have not attempted to boot
with it yet (but will soon).

If this works, I would like to get your changes into both Paul's stable and
devel trees as soon as possible.  This functionality has been in the x86
kernel since at least the beginning of the 2.2 kernel series.

Thanks,

Kevin

--- arch/ppc/kernel/head.S.prev	Wed Apr 26 10:38:24 2000
+++ arch/ppc/kernel/head.S	Wed Apr 26 11:02:18 2000
@@ -23,6 +23,10 @@
  *  modify it under the terms of the GNU General Public License
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
+ *
+ *  2000-04-10.
+ *  Add sys_rt_sigreturn in DoSyscall Handler.
+ *  Giovanna Ambrosini (ambrosini@lightning.ch).
  *
  */

@@ -2169,6 +2173,8 @@
 #endif /* SHOW_SYSCALLS */
 	cmpi	0,r0,0x7777	/* Special case for 'sys_sigreturn' */
 	beq-	10f
+        cmpi    0,r0,0x6666     /* Special case for 'sys_rt_sigreturn' */
+        beq-    16f
 	lwz	r10,TASK_FLAGS(r2)
 	andi.	r10,r10,PF_TRACESYS
 	bne-	50f
@@ -2215,6 +2221,12 @@
 /* sys_sigreturn */
 10:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	sys_sigreturn
+        cmpi    0,r3,0          /* Check for restarted system call */
+        bge     int_return
+        b       20b
+/* sys_rt_sigreturn */
+16:     addi    r3,r1,STACK_FRAME_OVERHEAD
+        bl      sys_rt_sigreturn
 	cmpi	0,r3,0		/* Check for restarted system call */
 	bge	int_return
 	b	20b
--- arch/ppc/kernel/signal.c.prev	Wed Apr 26 10:38:39 2000
+++ arch/ppc/kernel/signal.c	Wed Apr 26 10:56:47 2000
@@ -14,6 +14,16 @@
  *  modify it under the terms of the GNU General Public License
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
+ *
+ *
+ * 2000-04-7.
+ * Define a real-time signal frame with siginfo and ucontext
+ * structures (setup_rt_frame()).
+ * Stuck up a real-time signal frame when setting the signal
+ * frame with SA_SIGINFO flags.
+ * Add sys_rt_sigreturn() to undo the signal stack.
+ *
+ * Giovanna Ambrosini (ambrosini@lightning.ch)
  */

 #include <linux/sched.h>
@@ -121,13 +131,6 @@
 }


-asmlinkage int sys_rt_sigreturn(unsigned long __unused)
-{
-	printk("sys_rt_sigreturn(): %s/%d not yet implemented.\n",
-	       current->comm,current->pid);
-	do_exit(SIGSEGV);
-}
-
 asmlinkage int
 sys_sigaltstack(const stack_t *uss, stack_t *uoss)
 {
@@ -171,13 +174,11 @@
  * When we have signals to deliver, we set up on the
  * user stack, going down from the original stack pointer:
  *	a sigregs struct
- *	one or more sigcontext structs
+ * one or more sigcontext structs with
  *	a gap of __SIGNAL_FRAMESIZE bytes
  *
  * Each of these things must be a multiple of 16 bytes in size.
  *
- * XXX ultimately we will have to stack up a siginfo and ucontext
- * for each rt signal.
  */
 struct sigregs {
 	elf_gregset_t	gp_regs;
@@ -188,6 +189,15 @@
 	int		abigap[56];
 };

+struct rt_sigframe
+{
+ unsigned long _unused[2];
+ struct siginfo *pinfo;
+ void *puc;
+ struct siginfo info;
+ struct ucontext uc;
+};
+
 /*
  * Do a signal return; undo the signal stack.
  */
@@ -259,6 +269,91 @@
 	do_exit(SIGSEGV);
 }

+
+/*
+ *  When we have rt signals to deliver, we set up on the
+ *  user stack, going down from the original stack pointer:
+ *    a sigregs struct
+ *    one rt_sigframe struct (siginfo + ucontext)
+ *    a gap of __SIGNAL_FRAMESIZE bytes
+ *
+ *  Each of these things must be a multiple of 16 bytes in size.
+ *
+ */
+asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
+{
+ struct rt_sigframe *rt_sf;
+ struct sigcontext_struct sigctx;
+ struct sigregs *sr;
+ int ret;
+ elf_gregset_t saved_regs;  /* an array of ELF_NGREG unsigned longs */
+ sigset_t set;
+ stack_t st;
+ unsigned long prevsp;
+
+ rt_sf = (struct rt_sigframe *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
+ if (copy_from_user(&sigctx, &rt_sf->uc.uc_mcontext, sizeof(sigctx))
+     || copy_from_user(&set, &rt_sf->uc.uc_sigmask, sizeof(set))
+     || copy_from_user(&st, &rt_sf->uc.uc_stack, sizeof(st)))
+  goto badframe;
+ sigdelsetmask(&set, ~_BLOCKABLE);
+ spin_lock_irq(&current->sigmask_lock);
+ current->blocked = set;
+ recalc_sigpending(current);
+ spin_unlock_irq(&current->sigmask_lock);
+
+ rt_sf++;   /* Look at next rt_sigframe */
+ if (rt_sf == (struct rt_sigframe *)(sigctx.regs)) {
+  /* Last stacked signal - restore registers -
+   * sigctx is initialized to point to the
+   * preamble frame (where registers are stored)
+   * see handle_signal()
+   */
+  sr = (struct sigregs *) sigctx.regs;
+  if (regs->msr & MSR_FP )
+   giveup_fpu(current);
+  if (copy_from_user(saved_regs, &sr->gp_regs,
+       sizeof(sr->gp_regs)))
+   goto badframe;
+  saved_regs[PT_MSR] = (regs->msr & ~MSR_USERCHANGE)
+   | (saved_regs[PT_MSR] & MSR_USERCHANGE);
+  memcpy(regs, saved_regs, GP_REGS_SIZE);
+  if (copy_from_user(current->tss.fpr, &sr->fp_regs,
+       sizeof(sr->fp_regs)))
+   goto badframe;
+  /* This function sets back the stack flags into
+     the current task structure.  */
+  sys_sigaltstack(&st, NULL);
+
+  ret = regs->result;
+ } else {
+  /* More signals to go */
+  /* Set up registers for next signal handler */
+  regs->gpr[1] = (unsigned long)rt_sf - __SIGNAL_FRAMESIZE;
+  if (copy_from_user(&sigctx, &rt_sf->uc.uc_mcontext, sizeof(sigctx)))
+   goto badframe;
+  sr = (struct sigregs *) sigctx.regs;
+  regs->gpr[3] = ret = sigctx.signal;
+  /* Get the siginfo   */
+  get_user(regs->gpr[4], (unsigned long *)&rt_sf->pinfo);
+  /* Get the ucontext */
+  get_user(regs->gpr[5], (unsigned long *)&rt_sf->puc);
+  regs->gpr[6] = (unsigned long) rt_sf;
+
+  regs->link = (unsigned long) &sr->tramp;
+  regs->nip = sigctx.handler;
+  if (get_user(prevsp, &sr->gp_regs[PT_R1])
+      || put_user(prevsp, (unsigned long *) regs->gpr[1]))
+   goto badframe;
+ }
+ return ret;
+
+badframe:
+ lock_kernel();
+ do_exit(SIGSEGV);
+}
+
+
 /*
  * Set up a signal frame.
  */
@@ -305,6 +400,57 @@
 	do_exit(SIGSEGV);
 }

+
+static void
+setup_rt_frame(struct pt_regs *regs, struct sigregs *frame,
+        signed long newsp)
+{
+ struct rt_sigframe *rt_sf = (struct rt_sigframe *) newsp;
+
+ /* Set up preamble frame */
+ if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
+  goto badframe;
+ if (regs->msr & MSR_FP)
+  giveup_fpu(current);
+ if (__copy_to_user(&frame->gp_regs, regs, GP_REGS_SIZE)
+     || __copy_to_user(&frame->fp_regs, current->tss.fpr,
+         ELF_NFPREG * sizeof(double))
+ /* Set up to return from user space.
+    It calls the sc exception at offset 0x9999
+    for sys_rt_sigreturn().
+ */
+     || __put_user(0x38006666UL, &frame->tramp[0]) /* li r0,0x6666 */
+     || __put_user(0x44000002UL, &frame->tramp[1])) /* sc */
+  goto badframe;
+ flush_icache_range((unsigned long) &frame->tramp[0],
+      (unsigned long) &frame->tramp[2]);
+
+ /* Retrieve rt_sigframe from stack and
+    set up registers for signal handler
+ */
+ newsp -= __SIGNAL_FRAMESIZE;
+ if (put_user(regs->gpr[1], (unsigned long *)newsp)
+     || get_user(regs->nip, &rt_sf->uc.uc_mcontext.handler)
+     || get_user(regs->gpr[3], &rt_sf->uc.uc_mcontext.signal)
+     || get_user(regs->gpr[4], (unsigned long *)&rt_sf->pinfo)
+     || get_user(regs->gpr[5], (unsigned long *)&rt_sf->puc))
+  goto badframe;
+
+ regs->gpr[1] = newsp;
+ regs->gpr[6] = (unsigned long) rt_sf;
+ regs->link = (unsigned long) frame->tramp;
+
+ return;
+
+badframe:
+#if DEBUG_SIG
+ printk("badframe in setup_rt_frame, regs=%p frame=%p newsp=%lx\n",
+        regs, frame, newsp);
+#endif
+ lock_kernel();
+ do_exit(SIGSEGV);
+}
+
 /*
  * OK, we're invoking a handler
  */
@@ -314,6 +460,7 @@
 	      unsigned long *newspp, unsigned long frame)
 {
 	struct sigcontext_struct *sc;
+ struct rt_sigframe *rt_sf;

 	if (regs->trap == 0x0C00 /* System Call! */
 	    && ((int)regs->result == -ERESTARTNOHAND ||
@@ -321,20 +468,47 @@
 		 !(ka->sa.sa_flags & SA_RESTART))))
 		regs->result = -EINTR;

-	/* Put another sigcontext on the stack */
-	*newspp -= sizeof(*sc);
-	sc = (struct sigcontext_struct *) *newspp;
-	if (verify_area(VERIFY_WRITE, sc, sizeof(*sc)))
-		goto badframe;
+ /* Set up Signal Frame */
+ if (ka->sa.sa_flags & SA_SIGINFO) {
+  /* Put a Real Time Context onto stack */
+  *newspp -= sizeof(*rt_sf);
+  rt_sf = (struct rt_sigframe *) *newspp;
+  if (verify_area(VERIFY_WRITE, rt_sf, sizeof(*rt_sf)))
+   goto badframe;
+
+  if (__put_user((unsigned long) ka->sa.sa_handler,
&rt_sf->uc.uc_mcontext.handler)
+      || __put_user(&rt_sf->info, &rt_sf->pinfo)
+      || __put_user(&rt_sf->uc, &rt_sf->puc)
+      /* Put the siginfo */
+      || __copy_to_user(&rt_sf->info, info, sizeof(*info))
+      /* Create the ucontext */
+      || __put_user(0, &rt_sf->uc.uc_flags)
+      || __put_user(0, &rt_sf->uc.uc_link)
+      || __put_user(current->sas_ss_sp, &rt_sf->uc.uc_stack.ss_sp)
+      || __put_user(sas_ss_flags(regs->gpr[1]),
+      &rt_sf->uc.uc_stack.ss_flags)
+      || __put_user(current->sas_ss_size, &rt_sf->uc.uc_stack.ss_size)
+      || __copy_to_user(&rt_sf->uc.uc_sigmask, oldset, sizeof(*oldset))
+      /* mcontext.regs points to preamble register frame */
+      || __put_user((struct pt_regs *)frame, &rt_sf->uc.uc_mcontext.regs)
+      || __put_user(sig, &rt_sf->uc.uc_mcontext.signal))
+   goto badframe;
+ } else {
+  /* Put another sigcontext on the stack */
+  *newspp -= sizeof(*sc);
+  sc = (struct sigcontext_struct *) *newspp;
+  if (verify_area(VERIFY_WRITE, sc, sizeof(*sc)))
+   goto badframe;

-	if (__put_user((unsigned long) ka->sa.sa_handler, &sc->handler)
-	    || __put_user(oldset->sig[0], &sc->oldmask)
+  if (__put_user((unsigned long) ka->sa.sa_handler, &sc->handler)
+      || __put_user(oldset->sig[0], &sc->oldmask)
 #if _NSIG_WORDS > 1
-	    || __put_user(oldset->sig[1], &sc->_unused[3])
+      || __put_user(oldset->sig[1], &sc->_unused[3])
 #endif
-	    || __put_user((struct pt_regs *)frame, &sc->regs)
-	    || __put_user(sig, &sc->signal))
-		goto badframe;
+      || __put_user((struct pt_regs *)frame, &sc->regs)
+      || __put_user(sig, &sc->signal))
+   goto badframe;
+ }

 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
@@ -494,7 +668,10 @@
 	if (newsp == frame)
 		return 0;		/* no signals delivered */

-	setup_frame(regs, (struct sigregs *) frame, newsp);
+ if (ka->sa.sa_flags & SA_SIGINFO)
+  setup_rt_frame(regs, (struct sigregs *) frame, newsp);
+ else
+  setup_frame(regs, (struct sigregs *) frame, newsp);
 	return 1;

 }
--- include/asm-ppc/ucontext.h.prev	Wed Apr 26 10:39:24 2000
+++ include/asm-ppc/ucontext.h	Wed Apr 26 10:39:36 2000
@@ -7,6 +7,7 @@
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
 	stack_t		  uc_stack;
+       struct sigcontext_struct uc_mcontext;
 	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };



--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
