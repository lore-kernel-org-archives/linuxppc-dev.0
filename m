Return-Path: <rsass@uncc.edu>
Received: from rsass-homer.uncc.edu (rsass-homer.uncc.edu [152.15.91.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57F55DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 02:39:21 +1000 (EST)
Message-Id: <200807101554.m6AFs8w1029603@rsass-homer.uncc.edu>
To: neeraj garg <neerajg@cdac.in>
Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found) 
In-reply-to: <4875B95C.8020809@cdac.in> 
References: <48744475.2080605@cdac.in> <20080709143318.GB26524@secretlab.ca>
	<4875B95C.8020809@cdac.in>
Date: Thu, 10 Jul 2008 11:54:08 -0400
From: Ron Sass <rsass@uncc.edu>
Cc: linuxppc-embedded@ozlabs.org, John.Linn@xilinx.com,
	marco.stornelli@coritel.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


In addition to what John wrote, I would also investigate your ramdisk.
I would be sure to check that you have the permissions/owner set correctly
on bin/busybox.  Also, I would double check that, if you compiled busybox
with shared libraries, the shared libraries are in the right place
on your ramdisk.

Ron

> 
> Hi,
> 
> Yes I am using ARCH=ppc (actual line is $make ARCH=ppc 
> CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I have 
> placed ramdisk.image.gz in arch/ppc/boot/images. In case of ARCH=powerpc 
> I cannot find processor type 405 , in make menuconfig. Thats why i am 
> using ARCH=ppc.
> 
> And when I give kernel command string as init=/bin/sh , it says :
>  >Failed to execute /bin/sh.  Attempting defaults...
> [    3.744035] Kernel panic - not syncing: No init found.  Try passing 
> init= option to kernel.
> [    3.768073] Rebooting in 30 seconds..
> 
> --init is present in sbin/init which is a soft link to ../bin/busybox
> 
> --I used powepc-405-gnu-readelf -h bin/sh to verify that it is compiled 
> for powerpc itself.
> 
> Any other suggestions ?
> 
