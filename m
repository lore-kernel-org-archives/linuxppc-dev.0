Date: Mon, 10 Nov 2003 09:46:24 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: John Whitney <john.whitney@timesys.com>
Cc: "Mailing List: linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bad code path in DoSyscall
Message-ID: <20031110094624.A29465@home.com>
References: <BBD51F48.2329%john.whitney@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BBD51F48.2329%john.whitney@timesys.com>; from john.whitney@timesys.com on Mon, Nov 10, 2003 at 10:56:08AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 10, 2003 at 10:56:08AM -0500, John Whitney wrote:
>
> There seems to be a bad code path in the assembly routine DoSyscall()
> (arch/ppc/kernel/entry.S).  In the case of an invalid syscall being made (in
> my case, from user space), DoSyscall is called and eventually branches to
> label 66.  Note that before the branch, r12 is set to zero.

<snip>

>     /* disable interrupts so current_thread_info()->flags can't change */
> 30: LOAD_MSR_KERNEL(r10,MSR_KERNEL) /* doesn't include MSR_EE */
>     SYNC
>     MTMSRD(r10)
>     lwz r9,TI_FLAGS(r12)
>
> Which immediately causes a bad page fault kernel oops.  I haven't come up
> with a patch yet, but will try to when I get the time unless someone with
> more knowledge in this area wants to do it.  Just wanted to let the list
> know about the problem.

Thanks, here's a patch to grab the thread info when you go down the
no syscall path. This should cure the problem.

It's against linuxppc-2.5.  I think that's what you meant since this
bug isn't in 2.4.

-Matt

===== arch/ppc/kernel/entry.S 1.40 vs edited =====
--- 1.40/arch/ppc/kernel/entry.S        Sat Sep 27 03:58:48 2003
+++ edited/arch/ppc/kernel/entry.S      Mon Nov 10 09:36:55 2003
@@ -234,6 +234,7 @@
        RFI

 66:    li      r3,ENOSYS
+       rlwinm  r12,r1,0,0,18   /* current_thread_info() */
        b       22b

        .globl  ret_from_fork

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
