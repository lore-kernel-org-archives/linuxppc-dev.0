Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from CA1EXBH01.adcorp.kla-tencor.com (mailout01.kla-tencor.com
	[192.146.1.171]) by ozlabs.org (Postfix) with ESMTP id 9F1162BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 13:56:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 11 Jan 2005 18:44:08 -0800
Message-ID: <91B22F93A880FA48879475E134D6F0BE316B8C@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Help with PPC440GX + MontaVista + uBoot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to boot Linux on the IBM (now AMCC) 440GX eval board.  Using
the latest MontaVista 3.1 toolset + 440GX eval board package (Linux
kernel =3D 2.4.20) I can create a ramdisk-only Linux glob and boot it
successfully using the IBM supplied PIBS bios.

PIBS isn't what we want to use long term, we'd rather use uBoot.  I've
downloaded and built the latest version of uBoot (1.1.2).  I then
created a multi-file image with mkimage.  I can download it via TFTP but
when I start to run it strange/bad things happen:

	Kernel command line: ip=3Don console=3DttyS0,115200 root=3D/dev/ram rw
	Warning: real time clock seems stuck!
	Calibrating delay loop... 37.27 BogoMIPS

...now the RTC is know to work and the mips calculation is seriously
off.  Then...

	IBM ZMII: EMAC 0: SMII mode
	OCP Reset timeout #2!
	eth0: Got bad Phy Read (repeats)
	.....
	eth0: No PHY device found.
	removing net dev

	.....

	cramfs: wrong magic
	Kernel panic: VFS: Unable to mount root fs on 01:00
 	<0>Rebooting in 180 seconds..

It actually reboots in about 10 seconds.

I realize that ocotea.c will have to be modified to grab command line
options from NVRAM (uBoot) instead of FLASH (PIBS) but that doesn't seem
to explain why the internal timer is way off and the ethernet PHYs can't
be found.

If anyone on the list has done this I'd appreciate hearing what else
needs to be modified to make this configuration work.

Thanks,


Marc W. Howard
