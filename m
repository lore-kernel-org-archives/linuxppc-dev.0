Date: Thu, 1 Mar 2001 14:33:36 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mporter@mvista.com>
Cc: xav <grave@ipno.in2p3.fr>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem requesting IRQ with 2.4.2 kernel
In-Reply-To: <20010227081059.B32137@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.HPX.4.10.10103011430150.1860-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Feb 2001, Matt Porter wrote:

> >   Bus  0, device  13, function  0:
> >     Bridge: Tundra Semiconductor Corp. CA91C042 [Universe]
> > (rev1).
> >       IRQ 16.
> >       Master Capable.  No bursts.  Min Gnt=3.
> >       Non-prefetchable 32 bit memory at 0xeffef000 [0xeffeffff].
> >       I/O at 0xfffe000 [0xfffefff].
> >
> >
> > How can avoid all this pci board to have the same IRQ ?
> > Is this an openPic related problem ?
>
> Interrupt routing problem.  IIRC, put a 5 for the interrupt line in
> the entry for Slot 13, Universe II LINT#0.  That should get you
> going.  Check the 2300 programmer's reference if that interrupt
>  doesn't work for you.  If the driver is using more LINT inputs than
> that then you'll have to fix the routing as appropriate.  It can all
> be rerouted via the Universe II but that's another game.

No problem with this. I decided to use only one interrupt line in the
Universe driver. Everything is routed to LINT#0 (DMA and VIRQ#1 to VIRQ#7
are the only ones used right now, but I route the others to LINT#0 too).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
