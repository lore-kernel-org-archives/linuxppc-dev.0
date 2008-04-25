Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC19CDE580
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 23:38:13 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JpO7p-00032t-FA
	for linuxppc-embedded@ozlabs.org; Fri, 25 Apr 2008 13:38:06 +0000
Received: from p5497d382.dip.t-dialin.net ([84.151.211.130])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 Apr 2008 13:38:05 +0000
Received: from dzu by p5497d382.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 Apr 2008 13:38:05 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: ppc_4xx uImage - kernel boot problem
Date: Fri, 25 Apr 2008 15:37:11 +0200
Message-ID: <m2prseys1k.fsf@ohwell.denx.de>
References: <a399f0740804180036n189507cavd34f64891326bac1@mail.gmail.com>
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

Hi Ayhan,

> I have an AMCC 405gp board on which runs u-boot. I try to boot the Linux Kernel
> via network but can not. I download uImage using DHCPD/TFTP. Here is the 
> minicom console output:
>
>
> Type "run flash_nfs" to mount root filesystem over NFS
>
> Hit any key to stop autoboot:  0
> ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
> Using ppc_4xx_eth0 device
> TFTP from server 192.168.1.210; our IP address is 192.168.1.220
> Filename 'uImage'.
> Load address: 0x200000
> Loading: #################################################################
>          ###############
> done
> Bytes transferred = 1167936 (11d240 hex)
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.25-rc7-00000-ga1ba6f0
>    Created:      2008-04-07  12:32:44 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1167872 Bytes =  1.1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
>
> Here the console is frozen. It's the point where u-boot ends up and the kernel
> code starts. I think I have a mistake in addressing. I don't have sufficient
> knowledge about uImage format and the kernel compilation process. I followed
> the steps through the ELDK documantation from DENX software for cross-compiling
> the linux kernel as below:    
>
>       bash$ make mrproper
>       bash$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- walnut_defconfig
>       bash$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- uImage
>
> Could anyone help me solving the boot problem?

Very likely your kernel is booting, but you do not have specified a
serial console, so you do not see any output.

Can you show us the exact sequence of commands booting the kernel,
i.e. especially show us the bootargs U-Boot variable.

You can also try the post mortem log buffer examination[1] to see what
kernel messages were generated.

Cheers
  Detlev

[1] http://www.denx.de/wiki/view/DULG/LinuxPostMortemAnalysis

-- 
Greenspun's Tenth Rule of Programming: "Any sufficiently complicated C
or Fortran program contains an ad-hoc, informally-specified bug-ridden
slow implementation of half of Common Lisp."
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
