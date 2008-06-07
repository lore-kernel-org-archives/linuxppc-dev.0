Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id C1677DDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jun 2008 21:04:52 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K4wDx-00018O-Aa
	for linuxppc-embedded@ozlabs.org; Sat, 07 Jun 2008 11:04:41 +0000
Received: from p5497fe98.dip.t-dialin.net ([84.151.254.152])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 07 Jun 2008 11:04:41 +0000
Received: from dzu by p5497fe98.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 07 Jun 2008 11:04:41 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Is the linux-2.6.25.4 compatible with freescale lite5200b?
Date: Sat, 07 Jun 2008 13:03:17 +0200
Message-ID: <m2hcc54idm.fsf@ohwell.denx.de>
References: <70cc19fe0806031955v4478b886k94150ca9c9295a49@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A32FD@uss-am-xch-01.am.trimblecorp.net>
	<dc1bef900806052346k4a9134bo3a995c4bf3f7b3bc@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3550@uss-am-xch-01.am.trimblecorp.net>
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

Hi Mike,

> You are closer than you think with the ARCH=powerpc. You need to load one more
> binary file into ram and specify one more address for bootm. You need to load
> the device tree blob (DENX addresses this at http://www.denx.de/wiki/view/DULG/
> LinuxFDTBlob). Thanks again DENX?

As you may have noticed, this is a wiki, so many people participated in
writing up the documentation...

> Following your ARCH=powerpc build you should see a NEW file in your build
> output: rootfs/boot/lite5200b.dtb

Just as a reminder, as U-Boot needs to fill in at least the "chosen"
node in the fdt passed to the kernel, we have to reserve some space in
the .dtb file.  This can easily be done during the "normal" kernel
compilation by

export DTS_FLAGS="-R4 -S0x3000"

before the compilation.

> 1)       edit arch/powerpc/boot/dts/lite5200b.dts
>
> a.       change line 45 to:        reg = <00000000 8000000>   // change to 128M
> from 256M.

Someone needs to look into this, because usually the amount of RAM
should be passed correctly to the Linux kernel after dynamically finding
the correct amount.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
