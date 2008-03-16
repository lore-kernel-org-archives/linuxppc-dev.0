Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id EF3DADDDED
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 06:32:06 +1100 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 706943CC723
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Mar 2008 20:15:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id D9911E3C09
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Mar 2008 20:14:54 +0100 (CET)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id BED00E3C09
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Mar 2008 20:14:54 +0100 (CET)
Received: from [192.168.240.6] (unknown [192.168.240.6])
	by hegemone (Postfix) with ESMTP id CE012536
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Mar 2008 20:13:42 +0100 (CET)
Message-ID: <47DD71D0.2010203@matrix-vision.de>
Date: Sun, 16 Mar 2008 20:15:28 +0100
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: simple MPC5200B system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

I'm quite stuck in getting our MPC5200B based systems work on 2.6.24+=20
... maybe someone could give me some hints.
Up to now the systems have been running on 2.6.19 without any problems.

This is what I've done so far :

- get a recent system with 2.6.19 running and keep the toolchain (gcc=20
4.0) including RFS uImage.
- latest bootloader (u-boot 1.3.2) is running fine with dtb support.
- Kernel and RFS images are available via bootp/tftp
- device tree blob seems ok, i.e. u-boot can display the blob and fill=20
in all clocks correctly.
- Kernel gets called with Kernel, RFS and dtb on suitable adresses=20
(0x100000, 0x600000, 0x5F0000).
- nothing more happens. It looks like the console isn't working properly=20
- maybe worse ...

We're using the latest git version from Wolfgang Denk.

The kernel has been build using the "MPC5200 simple" setup. I've added=20
our board identifier "mv,mvbluecougar" to the list of supported boards=20
in the "mpc52xx_simple.c" file. This identifier is used in the dtb as=20
well of course. This should be enough along with a valid device tree=20
blob, isn't it ? Did I miss anything already ?

As far as I did understand by reading the docs it should be possible=20
running a general MPC52xx kernel with a custom dtb ? Is this correct ?

The dts file has already been reduced to a minimum, i.e. only the cpu,=20
pic, xlb and a few nodes like psc1 and psc2 are present. No bestcomm,=20
pci, ata or "advanced" features like mtd partitions. All I want to get=20
working is the serial console on "/dev/ttyPSC0".

Are there any hidden stumbling blocks ?

Sorry for the "simple" questions but obviously there are many questions=20
coming up during move from "ppc" to "powerpc".

Any help is appreciated.

regards,
Andr=E9 Schwarz
Matrix Vision GmbH

MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
