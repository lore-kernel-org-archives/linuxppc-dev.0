Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 01255DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 18:21:14 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 10 Jun 2008 10:20:37 +0200
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<200806091831.25200.jbe@pengutronix.de>
	<9e4733910806091430j56aeb06bpa090b0c8242e2041@mail.gmail.com>
In-Reply-To: <9e4733910806091430j56aeb06bpa090b0c8242e2041@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806101020.38788.jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon,

hmm, I tried the same, but with a 32MiB flash instead. And Linux-2.6.26-rc5=
=20
and the dtc-1.1.0.

On Monday 09 June 2008 23:30, Jon Smirl wrote:
> This is my boot log:
>
> ff000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
>  Intel/Sharp Extended Query Table at 0x0031
> Using buffer write method
> cfi_cmdset_0001: Erase suspend on write enabled
> RedBoot partition parsing not available
> Creating 6 MTD partitions on "ff000000.flash":
> 0x00000000-0x00040000 : "ubootl"
> 0x00040000-0x00200000 : "kernel"
> 0x00200000-0x00f00000 : "jffs2"
> 0x00f00000-0x00f40000 : "uboot"
> 0x00f40000-0x00f80000 : "oftree"
> 0x00f80000-0x01000000 : "space"


Here is mine (with DEBUG on in physmap_of.c):

[...]
mpc52xx MII bus: probed
net eth0: Using PHY at MDIO address 0
of-flash fe000000.flash: of_flash device: fe000000-fdffffff
of-flash: probe of fe000000.flash failed with error -16
TCP cubic registered
[...]

I'm confused about the "fe00000-fdffffff". These are the return values from=
=20
the of_address_to_resource() call (in of_flash_probe() ). It should=20
be "fe00000-ffffffff" instead.

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
