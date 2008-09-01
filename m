Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 97F2FDDFFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 01:15:03 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KaAc2-0002FY-15
	for linuxppc-embedded@ozlabs.org; Mon, 01 Sep 2008 14:42:38 +0000
Received: from p5497fc34.dip.t-dialin.net ([84.151.252.52])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 01 Sep 2008 14:42:38 +0000
Received: from dzu by p5497fc34.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 01 Sep 2008 14:42:38 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Compile new kernel for 5200B w/ ELDK
Date: Mon, 01 Sep 2008 16:42:11 +0200
Message-ID: <m2bpz8j5bw.fsf@ohwell.denx.de>
References: <1219770125l.5709l.0l@antares>
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

Hi Albrecht,

> please excuse a probably really dumb question about compiling a new  
> kernel for a Freescale 5200B using the ELDK 4.2...
>
> I am playing with a Lite5200B eval board.  The software coming from  
> Freescale, including an older kernel (2.6.16.11-rt18), works fine.
>
> I installed ELDK 4.2 on a FC box, and first compiled u-boot 1.3.4.   
> Wrote it to flash, and it works nicely afaict.
>
> Then I compiled the 2.6.24.2 kernel coming with the ELDK, using the  
> commands "make ARCH=powerpc CROSS_COMPILE=ppc_6xx- lite5200_defconfig ;  
> make ARCH=powerpc CROSS_COMPILE=ppc_6xx- uImage".  The kernel loads,  
> decompresses, but then there is no output any more after "Uncompressing  
> Kernel Image ... OK".  The u-boot environment contains (quoted from  
> printenv) "bootargs=console=ttyPSC0,115200 root=/dev/mtdblock0 rw  
> rootfstype=jffs2 verbose" (and, again, the Freescale kernel is not  
> silent).
>
> I found a message which stated that I should include
>
> <snip>
>          chosen {
>                  linux,stdout-path = "/soc5200@f0000000/serial@2000";
> 	};
> </snip>
>
> in the file arch/powerpc/boot/dts/lite5200.dts.  Recompiled, but  
> without success.  I believe it's a minor tweak I need to add, but I  
> don't have a clue what.  Unfortunately neither the wiki nor Google gave  
> answers.  Can anyone enlighten me??

Use a recent kernel version.  2.6.26 should work out of the box without
too much hassle.  Some of the older versions had problems effectively
stalling Linux very early without any output on the console.

Do not put any more effort in such an old kernel.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
