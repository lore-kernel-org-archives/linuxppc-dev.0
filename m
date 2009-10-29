Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id B522EB7C1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 08:39:22 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Joerg Albert <jal2@gmx.de>
Date: Thu, 29 Oct 2009 15:39:14 -0600
Subject: RE: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330E22E7B@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
	<4AE7775D.8080502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>
	<1256723805.32158.241.camel@kenjo-laptop>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D36A50@midas.usurf.usu.edu>
	<4AEA0AD5.2040209@gmx.de>
In-Reply-To: <4AEA0AD5.2040209@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Kenneth Johansson <kenneth@southpole.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Looking through our notes and talking with the engineer=20
> who was performing the tests, it was exactly that - MTD was waiting
> for a signal that was produced differently than the hardware=20
> ready signal.  By simply polling the flash until the hardware
> ready signal toggled we were able to get a much faster read and write spe=
ed.
> Granted, most of our signals are being sent through a CPLD,
> so that may be why MTD did not work as well.

even if your problem is solved I'd like to understand this performance issu=
e.
I had a look into the datasheet of the S29GL Mirrorbit flash by Spansion as=
 an example. They provide a dedicated pin RY/BY#, which signals the end of =
an embedded algorithm (erase or programming). While figure 11.9 shows no ti=
ming advance of RY/BY# against Dout on the data line, figure 11.12 has one =
of unspecified length between RY/BY# and the end of data toggling.

If you had a 10-fold slowdown with MTD, either the CPLD really slows down t=
he read access to the flash or maybe your custom driver uses some accelerat=
ion (write buffer programming,
unlock bypass, accelerated program with 12V on the WP#/ACC pin) while MTD d=
oes not.

Which kernel version and flash device did you use in this comparsion?

We were using VxWorks when we did the comparison, so there may be a problem=
 in their driver.  We are using unlock bypass by the way.  Our flash chip i=
s from Spansion.  I do not have the datasheet right with me, so I do not ha=
ve the part number.
