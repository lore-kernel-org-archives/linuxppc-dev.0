Message-ID: <3816BEA7.23AF7175@agelectronics.co.uk>
Date: Wed, 27 Oct 1999 09:58:15 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Kumar Gala <kumar@chaos.ph.utexas.edu>
CC: Jim Terman <terman@ddi.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
References: <Pine.LNX.4.10.9910261733160.10102-100000@chaos.ph.utexas.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kumar Gala wrote:

> The AltiVec registers have to be saved and restore explicitly, if you look
> at /arch/ppc/kernel/head.S and look for load_up_fp you will see how the
> floating point unit is handled on exceptions.  Essential what is done is
> there are some checks done, and a pointer is kept to the last
> process using the FP unit (last_task_used_fp) which then if needed the FP
> regs are saved in to that processes context and the FPs for the incoming
> are restored.

Linux on PowerPC should end up doing a classic lazy save/restore for the
vector context, as it already does for the floating point registers. On
SMP systems this simple approach isn't possible, but a quick
approximation is to detect the first time a process uses Altivec, and
marking it to always save and restore vector context from then on.

I'd recommend that compiler writers use the vrsave register to mark
which vector registers they use, as a precaution against future kernels
which may look at this. Note that the G4 is extremely fast at linear
sequences of cacheable stores (store miss merging), and it is probably
cheaper for the kernel to ignore vrsave and avoid branches in the save
and restore sequence.  Of course, it is correct to simply set every bit
in vrsave at the start of your application, and never change it again.
It may be non-optimal on future systems, but it should remain correct.

As for the cache thrashing effect, remember that 512 bytes going in and
out of the L2 cache is not very expensive, and that there is probably 1
or 2MB of L2 fitted.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
