Subject: Re: check MMU state
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200304051823.30693.tglx@linutronix.de>
References: <200304051735.25831.tglx@linutronix.de>
	 <200304051815.40797.tglx@linutronix.de>
	 <1049556246.654.7.camel@zion.wanadoo.fr>
	 <200304051823.30693.tglx@linutronix.de>
Content-Type: text/plain
Message-Id: <1049558593.654.9.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 05 Apr 2003 18:03:14 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-04-05 at 18:23, Thomas Gleixner wrote:
> On Saturday 05 April 2003 17:24, Benjamin Herrenschmidt wrote:
> > On Sat, 2003-04-05 at 18:15, Thomas Gleixner wrote:
> > > On Saturday 05 April 2003 16:49, Benjamin Herrenschmidt wrote:
> > > > > Is there a clean way to check, if the MMU is enabled on kernel entry
> > > > > ? I have to port Linux to a PMC-module, where the bootloader code
> > > > > should not be changed.
> > > >
> > > > The kernel entry can cope with both cases, provided that early_init
> > > > properly returns the physical address where the kernel is loaded,
> > > > regardless of the translations setup by the bootloader. Also, the
> > > > kernel has to be contiguous in physical memory.
> > >
> > > I don't reach early_init. The CPU is a 860 and I'm using 2.4.20-ben8. I
> > > get lost in initial_mmu. If I turn off the mmu before "bl initial_mmu"
> > > everything is fine.
> >
> > Ah well, I was talking about the "common" CPU case (CONFIG_6xx), I don't
> > know about 8xx but since the first thing the code  in head_8xx.S does is
> > "tlbia", I think you are in a bad situation running that with
> > translation enabled and no vectors around to handle the TLB miss...
> >
> > For machines without BATs, I tend to think that a bootloader loading
> > you with MMU on shall be shot. What I'd suggest is that you hack a piggy
> > back loader in the zImage wrapper that shuts MMU off before entering the
> > kernel. If you _have_ to run vmlinux as is, then stuff a bl to some code
> > to disable the MMU before reaching initial_mmu in head_8xx.S
> I have done this already, but just wanted to know, if there is a way to check
> the mmu-state in case that the bootloader code is corrected some day.

Just check MSR:IR/DR

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
