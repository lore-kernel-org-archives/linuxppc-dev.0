Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id BB5B5DDF1D
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 17:56:45 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Mon, 9 Jun 2008 09:56:31 +0200
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<fa686aa40806081628s2632bcb3he21b26e49873a65f@mail.gmail.com>
In-Reply-To: <fa686aa40806081628s2632bcb3he21b26e49873a65f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806090956.32160.jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
Cc: wsa@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 09 June 2008 01:28, Grant Likely wrote:
> On Sun, Jun 8, 2008 at 1:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Why not a compatible field in the top of the tree? Then you wouldn't
> > need to list the boards in mpc5200_simple.c.
> >        compatible =3D "phytec,pcm030","simple-mpc5200";
>
> Here's the problem; what does compatible really mean at the board
> level?  Does it mean the board has 100% of the same capabilities?
> Does it mean that it uses the same chip?  Does it mean that the chip
> is configured in a particular way?  It is really hard to define what a
> compatible value means at the board level.  The meaning of compatible
> at the device level is very well defined, but that meaning does not
> extend well to the board level.
>
> Therefore, it is best to be conservative here and require a specific
> list of supported boards in platform code.
>
> Besides, it is really a Linux specific thing that is trying to be
> described.  In Linux, we've decided to support as many 5200 boards as
> possible using the same platform code, but that may not be true, or it
> may be a different set of boards, when a different OS is used.  To
> attempt to encode those decisions is overreaching the intent of using
> the device tree.
>
> > Device tree has an entry for AC97 on PSC1. I don't think the Phytec
> > module or carrier board has AC97 hardware.
>
> Might be a bug

NACK. The baseboard for the pcm030 CPU board has AC97 hardware connected to=
=20
PSC1. And it plays audio...

> > The RTC chip says pcf8563, phytec doc says it is a pcf8564.
>
> Sounds like a bug

These devices are mostly the same. You can use the pcf8563 driver for the=20
pcf8564.

> > There should be an i2c entry for the eeprom but I don't know the part
> > number for it.
>
> Yes, i2c devices should be described.

Its a 24C32.

I believe Wolfram has a newer OFtree for the pcm030 so I add him as CC.

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
