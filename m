Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 24E4A67A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 20:17:58 +1100 (EST)
Date: Tue, 8 Feb 2005 10:17:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Jarno Manninen <manninej@students.cc.tut.fi>
In-Reply-To: <Pine.LNX.4.58.0502080941400.7250@amadeus.cc.tut.fi>
Message-ID: <Pine.GSO.4.61.0502081016050.19563@waterleaf.sonytel.be>
References: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B6E@TQ-MAILSRV-1>
	<Pine.LNX.4.58.0502080941400.7250@amadeus.cc.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Martin Krause <Martin.Krause@tqs.de>
Subject: Re: AW: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 8 Feb 2005, Jarno Manninen wrote:
> On Tue, 8 Feb 2005, Martin Krause wrote:
> > linuxppc-embedded-bounces@ozlabs.org wrote on :
> > > > This will not work. Microwindows can only  use  a  plain framebuffer
> > > > interface,  but  the Coral-P does not allow for such a driver
> > > > because of the fact that it has a little-endian register interface.
> > >
> > > Or is it because 5200 swaps bytes around on PCI.  It sure looks to me
> > > like Freescale has made a major screwup in their implementation of
> > > PCI on the 5200.  I'd love for somebody to prove me wrong about this,
> > > but I'm afraid I'm right.  I was under the impression that
> > > CoralP worked
> > > nicely on 5200, but now I see that it also requires software
> > > tweaks to work
> > > on 5200.
> >
> > I have similar problems with an MPC5200 board and a Silicon Motion
> > SM501 (Voyager) grafic controller. The controller has a PCI and a
> > local bus interface. We use the local bus interface to connect it
> > with the 5200. In 32 bit truecolor mode everything works fine, but
> > in 16 bit mode bytes are swapped: 0x12345678 => 0x34127856.
> > I'm not sure, if this problem has something to do with the CoralP
> > problem, but it is likely too similar to be completely independent.
> > Does anyone use an SM501 in 16 bit mode?
> 
> This is the problem with big-endian systems with PCI bus. I've seen this
> on sparc and on MPC5200 too. There is no other solution, but to swap the
> bytes in SW.

Yep, the Cybervision graphics cards on Amiga (S3 Trio or ViRGE) suffer from the
same problem.

> The problem is that the PCI bus and CPU must agree when thinking of
> arithmetic context. For example when talking about adresses, both parties
> have to see address numbers in the same way. Problem is that with graphics
> formats we are talking about bit masks, not actual numbers. So inner byte
> order _does_ have meaning while with plain numbers it does _not_, right?

If your graphics chip has separate apertures for big and little endian (and a
control register to `fix' swapping depending on the color depth), you may be
able to find a configuration that doesn't need any swapping on the CPU.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
