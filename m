Date: Mon, 10 Nov 2003 10:56:08 -0500
Subject: Bad code path in DoSyscall
From: John Whitney <john.whitney@timesys.com>
To: "Mailing List: linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Message-ID: <BBD51F48.2329%john.whitney@timesys.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There seems to be a bad code path in the assembly routine DoSyscall()
(arch/ppc/kernel/entry.S).  In the case of an invalid syscall being made (in
my case, from user space), DoSyscall is called and eventually branches to
label 66.  Note that before the branch, r12 is set to zero.

_GLOBAL(DoSyscall)
    stw r0,THREAD+LAST_SYSCALL(r2)
    stw r3,ORIG_GPR3(r1)
    li  r12,0
    stw r12,RESULT(r1)
    lwz r11,_CCR(r1)    /* Clear SO bit in CR */
    rlwinm  r11,r11,0,4,2
    stw r11,_CCR(r1)
#ifdef SHOW_SYSCALLS
    bl  do_show_syscall
#endif /* SHOW_SYSCALLS */
    cmpli   0,r0,NR_syscalls
    bge-    66f

Code at label 66 sets ENOSYS, and branches to label 22.

66: li  r3,ENOSYS
    b   22b

Code after label 22 presumes that r12 is set to the current thread, and
tries to access off of it:

22: lwz r10,_CCR(r1)    /* Set SO bit in CR */
    oris    r10,r10,0x1000
    stw r10,_CCR(r1)

    /* disable interrupts so current_thread_info()->flags can't change */
30: LOAD_MSR_KERNEL(r10,MSR_KERNEL) /* doesn't include MSR_EE */
    SYNC
    MTMSRD(r10)
    lwz r9,TI_FLAGS(r12)

Which immediately causes a bad page fault kernel oops.  I haven't come up
with a patch yet, but will try to when I get the time unless someone with
more knowledge in this area wants to do it.  Just wanted to let the list
know about the problem.

John Whitney
TimeSys corporation


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
