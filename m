Date: Sun, 30 Jul 2000 07:29:57 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Stealth port problems
In-Reply-To: <398426BC.67FCDC6E@denise.shiny.it>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000730071543.1508E-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Jul 2000, Giuliano Pochini wrote:

> > >Hi!  I have troubles with my stealth port on a G3-blue. When it runs at
> > 115200
> > >ifconfig
> > >shows a lot of overruns. At 57600 it works fine, but it's slow :-((
> > >
> > >Does any of you own that serial port ?  Suggestions ??
> >
> > Which kernel ? With the DMA serial driver, it should work better than
> > that... The Stealth hardware is probaly not responsible, it's just a line
> > driver plugged instead of the modem, the actual zilog SCC is part of
> > Apple's ASIC.
>
>
> I've just tried the old non-dma code. Same problem :-(((

If so, could you check if you have DMA enabled with dma code?

	$ cat /proc/interrupts
           CPU0
	  2:          0   PMAC-PIC      MACE-txdma
	  3:          0   PMAC-PIC      MACE-rxdma
	  4:          0   PMAC-PIC      SCC-txdma
	  5:          0   PMAC-PIC      SCC-rxdma
	  6:          0   PMAC-PIC      SCC-txdma
	  7:      15593   PMAC-PIC      SCC-rxdma
	  8:         17   PMAC-PIC      AWACS out
	 12:          7   PMAC-PIC      53C94
	 13:    3411091   PMAC-PIC      MESH
	 14:          0   PMAC-PIC      MACE
	 15:          0   PMAC-PIC      SCC
	 16:     594667   PMAC-PIC      SCC
	 17:          0   PMAC-PIC      AWACS
	 18:     991629   PMAC-PIC      VIA
	 19:          0   PMAC-PIC      SWIM3
	 25:          0   PMAC-PIC      usb-ohci, ohci-usb
	BAD:          0
	$

If you don't see "SCC-rxdma", then it's not enabled.  The reason I ask is
that a G3-blue's SCC device node has more than three addresses if I
remember correctly, and, if that's the case, the dma code won't be enabled
due to the following sniplet in chan_init() of macserial.c:

#if !defined(CONFIG_KGDB) && defined(SUPPORT_SERIAL_DMA)
	if (ch->n_addrs == 3 && ch->n_intrs == 3)
		zss->has_dma = 1;
#endif

It can be fixed if the above is changed to something like:

#if !defined(CONFIG_KGDB) && defined(SUPPORT_SERIAL_DMA)
	if (ch->n_addrs >= 3 && ch->n_intrs == 3)
		zss->has_dma = 1;
#endif

I think the last two addresses correspond to DMA addresses for all
SCC capable machines so far, so this change should be ok.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
