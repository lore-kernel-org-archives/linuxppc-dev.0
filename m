Subject: Re: cache coherence problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Juergen Kienhoefer <juergen@kienhoefer.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <3FB9A77C.3030101@kienhoefer.com>
References: <3FB972E8.5090701@kienhoefer.com>
	 <1069122238.7168.63.camel@gaston>  <3FB9A77C.3030101@kienhoefer.com>
Content-Type: text/plain
Message-Id: <1069132955.7170.120.camel@gaston>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 16:22:35 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-11-18 at 16:00, Juergen Kienhoefer wrote:
> Guys,
> Thank you very much for the ideas.
> Basically, what I need to do is:
> dcbst
> sync
> iccci
^^^^^^^
No: icbi

> sync
> isync
> for every 32 bytes of the memory block I put code in.
> Right?
> Cheers
> Juergen
>
>
> Benjamin Herrenschmidt wrote:
>
> >On Tue, 2003-11-18 at 12:16, Juergen Kienhoefer wrote:
> >
> >
> >>Guys,
> >>Look at the folloging test program. It mmaps memory, puts some
> >>instructions in it and executes it.
> >>Sometimes it works, sometimes it crashes with illegal instruction.
> >>This smells like cache problems.
> >>Should the kernel clean the instruction cache for these addresses
> >>in mmap system call?
> >>Thanks for any thoughts!
> >>Juergen
> >>
> >>
> >
> >It's your duty to ensure cache coherency. Actually, the kernel
> >will eventually clean the icache for newly mapped in blank pages,
> >but it will certainly not enforce flush of your writes to memory.
> >
> >You need to first flush the data cache to memory using dcbf or
> >dcbst, then sync for this to complete, then invalidate the
> >instruction cache, sync and isync.
> >
> >Ben.
> >
> >
> >
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
