Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id EEC9267AA9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 01:39:20 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id 6A4613C36
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 15:39:19 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 8 Feb 2005 15:39:19 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B73@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: AW: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > I have similar problems with an MPC5200 board and a Silicon Motion
> > SM501 (Voyager) grafic controller. The controller has a PCI and a
> > local bus interface. We use the local bus interface to connect it
> > with the 5200. In 32 bit truecolor mode everything works fine, but
> > in 16 bit mode bytes are swapped: 0x12345678 =3D> 0x34127856.
> > I'm not sure, if this problem has something to do with the CoralP
> > problem, but it is likely too similar to be completely independent.
>=20
> Two questions:  Is your local bus set up as 32 bits wide, and are
> you writing 32 bits at a time?  The little/big endian issue only

Yes, the bus is 32 bits wide and there should be only 32 bit wide=20
accesses. The SM501 configuration registers are always accessed 32
bit wide (I checked the fb driver). But I couldn't tell how the=20
linux console driver accesses the framebuffer. But the Problem even
occours, if I use my BDI2000 or U-Boot to write directly to the=20
framebuffer. It makes no difference, if I read or write bytes, halfs
or words. A hexdump of the framebuffer allways looks correct, but=20
the SM501 swapps Pixels in 16 bpp mode. Example:

In 16 bpp mode the color of a pixel is composed like this:

	MSB          LSB
	rrrrrggggggbbbbb

I wrote 0xF000 to the start of the framebuffer (in U-Boot, but with
BDI2000 it is the same):

=3D> mw.w e0000000 f000
=3D> md.l e0000000 8
e0000000: f0000000 00000000 00000000 00000000    ................
e0000010: 00000000 00000000 00000000 00000000    ................
=3D>

This sets a red Pixel -> OK

Then I write 0x001F to the next pixel position

=3D> mw.b e0000003 1f
=3D> md.l e0000000 8
e0000000: f000001f 00000000 00000000 00000000    ................
e0000010: 00000000 00000000 00000000 00000000    ................

A blue pixel should be set right beside the red pixel. But the
blue Pixel is set left besides the red pixel.

Then the next pixel:

=3D> mw.w e0000004 f000
=3D> md.l e0000000 8
e0000000: f000001f f0000000 00000000 00000000    ................
e0000010: 00000000 00000000 00000000 00000000    ................
=3D> md.w e0000000 8
e0000000: f000 001f f000 0000 0000 0000 0000 0000    ................
=3D>

This prints a red pixel right besides the other red pixel, but
with a black pixle between it.=20

Then again a blue pixel to the next postion:

=3D> mw.w e0000006 001f
=3D> md e0000000
e0000000: f000001f f000001f 00000000 00000000    ................
e0000010: 00000000 00000000 00000000 00000000    ................
=3D>

This sets a blue pixle between the two red pixels

The screen now looks like this:

brbr

And it sould be:

rbrb

In the examples above I mixed byte, word and long accesses
to show, that this has no impact.=20

> shows up when writing smaller values than the width of the
> interface.  In other words, an x86 and a PPC will write a 32bit
> word to 32bit memory in exactly the same way.  The difference
> comes in how they address bytes or words within that 32bit data
> lane.  So if you, for instance, are writing longs in truecolor mode
> and bytes in 16 bit mode that could explain what you are seeing.
>=20
> On the 5200 you've got two issues to deal with:  You've got
> the byte/short addressing mismatches that might show up, then
> you've also got to take into account that 5200 swaps the
> byte lanes around.

The Bytes are swapped in combinations of two:

12345678 -> 34127856

This means in 16 bpp mode the colors are displayed correct, but=20
the pixel positions are swapped.

In 32 bpp mode there seems to bee no byte swapping. At least the
colors of the resulting Images look good. If bytes were swapped
like in 16 bpp mode, then the colours should be wrong.

I wonder if someone else ever used a SM501 with 16 bpp in local
bus mode?

regards,
Martin Krause
