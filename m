Date: Wed, 29 Sep 1999 11:52:27 -0500 (CDT)
From: Kumar Gala <kumar@chaos.ph.utexas.edu>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: can someone explain this?
Message-ID: <Pine.LNX.4.10.9909291150140.12336-100000@chaos.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was looking around the ppc kernel source in arch/ppc/kernel/process.c
and was looking at how copy_thread() works.

I was wondering why so much space is stored off for copies of pt_regs

I can understand needing one copy for the process in user space, and 2nd
for the process in kernel space, but why a third?

copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
            struct task_struct * p, struct pt_regs * regs)
{
        struct pt_regs * childregs, *kregs;
#ifdef __SMP__
        extern void ret_from_smpfork(void);
#else
        extern void ret_from_syscall(void);
#endif
        /* Copy registers */
        childregs = ((struct pt_regs *)
                     ((unsigned long)p + sizeof(union task_union)
                      - STACK_FRAME_OVERHEAD)) - 2;
        *childregs = *regs;
        if ((childregs->msr & MSR_PR) == 0)
                childregs->gpr[2] = (unsigned long) p;  /* `current' in
new task */
        childregs->gpr[3] = 0;  /* Result from fork() */
        p->tss.regs = childregs;
        p->tss.ksp = (unsigned long) childregs - STACK_FRAME_OVERHEAD;
        p->tss.ksp -= sizeof(struct pt_regs ) + STACK_FRAME_OVERHEAD;
        kregs = (struct pt_regs *)(p->tss.ksp + STACK_FRAME_OVERHEAD);

and what is going on with STACK_FRAME_OVERHEAD all over the place

thanks

 - kumar



ignorance is bliss.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
