Date: Thu, 11 Mar 1999 17:08:20 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Charles Lepple <clepple@ee.vt.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ handling in port to DY4 SVME-177
In-Reply-To: <Pine.GSO.3.96.990311095123.13324B-100000@birch.ee.vt.edu>
Message-ID: <Pine.LNX.4.03.9903111705580.7717-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Mar 1999, Charles Lepple wrote:
> I'm working on porting the kernel to a DY4 SVME-177 board, a mil-spec 603e
> single-board system (no PCI, nonstandard I/O, the works).
> 
> Anyway, the problem is with the interrupt controller, and it's more of an
> architectural question. A Tundra SCV64 has several 'local IRQ' lines, but
> as it turns out, they put all the useful stuff (serial, ethernet, SCSI) on
> the same level IRQ level (LIRQ5). The RTC and other timers each get their
> own IRQ level, as does the MAXpack interface. Is it probable that I can
> get by with this sharing arrangement in arch/ppc/kernel/irq.c, or am I
> going to have to create pseudo-IRQs for each device, and make it look like
> a cascaded interrupt? The IRQ lines themselves are all level-sensitive,
> but I'm wondering if the IRQ mask code in irq.c is going to be enough.
> After all, am I losing anything but performance by using the same
> interrupt line? (not that I would have designed it this way...)

Is it easy to find out which interrupt source caused interrupt 5, e.g. by just
looking at a bit mask in a Tundra register? If yes, I think the best way is to
create pseudo-IRQs for each device. If not, you'll have `real' shared
interrupts and have to walk through all possible interrupt sources for
interrupt 5 to find out which caused the interrupt, which is more expensive.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
