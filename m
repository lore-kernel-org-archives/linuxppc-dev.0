Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 1744BDDF61
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Sep 2008 22:06:24 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KbDbH-0004TQ-Ms
	for linuxppc-embedded@ozlabs.org; Thu, 04 Sep 2008 12:06:11 +0000
Received: from p5497e12a.dip.t-dialin.net ([84.151.225.42])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 04 Sep 2008 12:06:11 +0000
Received: from dzu by p5497e12a.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 04 Sep 2008 12:06:11 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Boot 2.6.26 (or similar) on mpc5200 using powerpc
Date: Thu, 04 Sep 2008 14:05:44 +0200
Message-ID: <m28wu8f753.fsf@ohwell.denx.de>
References: <135716.58253.qm@web23107.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Angelo,

> Does anyone boots on mpc5200 board, the linux kernel 2.6.26 (or .24 .25) using
> ARCH=powerpc?

Sure, many people do this successfully.

> Looking on web i known that it's very different from ppc mode and the right
> procedure to follow is:
>
> 1 - make lite5200b_defconfig ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

Note that this changes to "make 52xx/lite5200b_defconfig ..." in recent kernels.

> 2 - make cuImage.lite5200b ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

Well, this is debatable.  Here you explicitely request a backward
compatability wrapped uImage (for firmwares being FDT ignorant):

> The output of second command is:
> ...
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CALL    arch/powerpc/kernel/systbl_chk.sh
>   CALL    arch/powerpc/kernel/prom_init_check.sh
> arch/powerpc/boot/dtc -O dtb -o arch/powerpc/boot/lite5200b.dtb -b 0  /home/
> asimmini/Scrivania/linux-2.6.26.3/arch/powerpc/boot/dts/lite5200b.dts
> DTC: dts->dtb  on file "/home/asimmini/Scrivania/linux-2.6.26.3/arch/powerpc/
> boot/dts/lite5200b.dts"
>   WRAP    arch/powerpc/boot/cuImage.lite5200b

    ^----  Here the wrapper gets added.

> Image Name:   Linux-2.6.26.3
> Created:      Wed Sep  3 15:56:16 2008
> Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> Data Size:    1597696 Bytes = 1560.25 kB = 1.52 MB
> Load Address: 0x00400000
> Entry Point:  0x00400550
> rm arch/powerpc/boot/lite5200b.dtb
>
> But, at this point, if i crosscompile in ppc mode i had to modify the Load
> Address wiht the mkimage tool because the SDRAM at the Bootloader time starts
> from 0xF8000000, while the uImage has a Load Address and Entry Point at
> 0x00000000.

Well still in newer kernels, uImage has load and entry address 0.  Its
only the cuImage.lite5200b (and I presume other wrapped kernels) that
have this load address.

> What should i do in powerpc mode??

I suggest that you use a recent U-Boot on your board which can
explicitely pass a .dtb to the kernel and use a plain uImage + flat
device tree blob.  I gather this is the best tested combination.  I
myself saw problems with the wrapped image that went away when passing
the device tree explicitely.

So in 2.6.26 I'd advise you to do a "make uImage" + "make lite5200b.dtb"
and use the results in a recent U-Boot.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
