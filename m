Date: Thu, 12 Aug 2004 17:07:30 -0500
From: "Cordes, Aaron M" <aaron.m.cordes@lmco.com>
Subject: RE: Linux 2.4.27-pre6-bk hangs on MPC8540 board
To: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <EE7CAF713952AC4A970DD7CD8B4C12A042DCAD@emss09m06.us.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I completely disabled L1 and L2 cache in the processor and I am not
seeing the memory corruption anymore.  So, good news is board is now
booting, bad news is it's dog slow and we have a memory design to debug.
Thanks to everyone for your prompt and helpful advice.

Aaron


-----Original Message-----
From: VanBaren, Gerald (AGRE)
[mailto:Gerald.VanBaren@smiths-aerospace.com]
Sent: Thursday, August 12, 2004 3:32 PM
To: Cordes, Aaron M
Subject: RE: Linux 2.4.27-pre6-bk hangs on MPC8540 board



On 8xx and 82xx and, I presume, 85xx processors, disabling cache
inhibits burst mode.  It is the cache line filling  and flushing that
causes burst accesses.  Note that DMA also causes bursts, but that
becomes a problem much later.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> Cordes, Aaron M
> Sent: Thursday, August 12, 2004 3:34 PM
> To: wd@denx.de
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: Linux 2.4.27-pre6-bk hangs on MPC8540 board
>
>
>
> Is there a way in Linux or the 8540 to prevent burst accesses, in
> order to test whether they are the problem?  I scanned the processor's
> reference manual, but I didn't see anything that would let me do this.
>
> Thanks
> Aaron
>
> Aaron Cordes
>
> -----Original Message-----
> From: wd@denx.de [mailto:wd@denx.de]
> Sent: Thursday, August 12, 2004 9:08 AM
> To: Cordes, Aaron M
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Linux 2.4.27-pre6-bk hangs on MPC8540 board
>
>
> In message
> <EE7CAF713952AC4A970DD7CD8B4C12A042DCA7@emss09m06.us.lmco.com> you
> wrote:
> >
> > We are bringing up an 8540-based board, and are getting hangs at
> > random spots when booting Linux.  Sometimes the hangs occur
> while the
> > kernel is initializing, sometimes the boot gets far enough
> where I can
>
> > log in and run a couple of programs.  Eventually the board locks up
> > with no oopses or panics.  If I connect to the board with a
> debugger,
> > the processor is usually stopped in the Data miss exception handler,

> > and there is usually memory corruption in the kernel code.
>
> That's it: memory problems.
>
> > I ran memory tests using both Edink and U-boot and they all
> passed, so
>
> > I'm reluctant to blame hardware for the memory corruption.
> Has anyone
>
> > seen similar behavior, or have any suggestions of things I
> might try?
>
> All those memory tests only can test simple read and write  accesses;
> they  all  fail to access burst mode accesses, which will happen when
> Linux starts runing, and which are failing.
>
> Your SDRAM initialization is bad, and  the  system  crashes  when  it
> tries to fetch instructions from RAM. Note that simple read and write
> accesses may still work, it's the burst mode that is failing.
>
> It is NOT sufficient to program the memory controller  of  your  CPU;
> each  SDRAM  chip  also  requires  a specific initialization sequence
> which you must adhere  to  to  the  letter  -  check  with  the  chip
> manufacturer's manual.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> If this is a service economy, why is the service so bad?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
