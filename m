Return-Path: <rsass@uncc.edu>
Received: from rsass-homer.uncc.edu (rsass-homer.uncc.edu [152.15.91.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5ABDDE3D0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 00:47:49 +1000 (EST)
Message-Id: <200807161447.m6GElde4032109@rsass-homer.uncc.edu>
To: Neeraj Garg <neerajg@cdac.in>
Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found) 
In-reply-to: <487C4326.9000000@cdac.in> 
References: <48744475.2080605@cdac.in> <20080709143318.GB26524@secretlab.ca>
	<20080709160659.EE3F6E28065@mail118-va3.bigfish.com>
	<487C4326.9000000@cdac.in>
Date: Wed, 16 Jul 2008 10:47:39 -0400
From: Ron Sass <rsass@uncc.edu>
Cc: John Linn <John.Linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hmmm... I think you've got a problem with your ramdisk.  There are
a couple of issues but these alone don't explain your helloworld test.

1.  busybox should be set to root not neeraj 
2.  you need to setuid busybox for some apps to run
    (chmod 4775 bin/busybox so that it is srwxrwxr-x-r)
3.  I would be wary of Yaghmour's text... it is a little dated
    and if I remember correctly, he uses some regular expressions
    to copy "just" the libraries you need to lib; but with
    newer versions of gcc/glibc these regular expressions
    don't catch everything

Two questions:

Can you tell me exactly what your cross-compile command-line looks
like?  How are compiling helloworld?

How are you creating the ramdisk?  How do you go from directory
structure to ramdisk.image.gz?

Ron

> 
> Hi,
> 
> --Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself. And 
> shared libraries are present in lib/ . Now I have placed helloworld.elf 
> (using printf to print helloworld, and linked with -static option) in 
> bin/ and changed init=/bin/helloworld , again it says cannot execute 
> /bin/helloworld.
> 
> --John, we are using our custom hardware board, not exactly ML405 but 
> its more or less similar to ML405, so I cannot use bit file provided for 
> ML405. Till now we were using xilkernel, but now onward we are planning 
> to use Linux. For serial console I have no option other than uartlite. 
> This is how I compiled kernel :
> 
> 1) make ARCH=ppc ml405_defconfig
> 2) patched kernel src with EDK(10.1) , so as to change xparameter.h, and 
> later made some changed in arch/ppc/boot/simple/embed_config.c and 
> xparameters.h file.
> 3) make ARCH=ppc menuconfig , and selected uartlite to be console and 
> ramdisk as file system.
> 4) Created ramdisk (as per Building embedded linux, Karim Yaghmour, 
> however major and minor number for device nodes is similar to ramdisk 
> provided at git.xilinx.com)
> 5) I have placed this ramdisk in arch/ppc/boot/images
> 6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- 
> zImge.initrd
> 
> 
> --I have downloaded   ELDK4.1 and installed it. And when I compile 
> simple helloworld.c using cross compiler, it says unresolved symbol 
> 'printf' . Is there anything else to install with ELDK ?
> 
> 
> -------------------------------------------------------------------
> Neeraj Garg
> 
> 
> 
> In addition to what John wrote, I would also investigate your ramdisk.
> I would be sure to check that you have the permissions/owner set correctly
> on bin/busybox.  Also, I would double check that, if you compiled busybox
> with shared libraries, the shared libraries are in the right place
> on your ramdisk.
> 
> 
> Ron
> 
>  >
>  > Hi,
>  >
>  > Yes I am using ARCH=ppc (actual line is $make ARCH=ppc
>  > CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I have
>  > placed ramdisk.image.gz in arch/ppc/boot/images. In case of ARCH=powerpc
>  > I cannot find processor type 405 , in make menuconfig. Thats why i am
>  > using ARCH=ppc.
>  >
> 
> --------------060307000300070002040802
> Content-Type: text/html; charset=ISO-8859-1
> Content-Transfer-Encoding: 7bit
> 
> <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
> <html>
> <head>
>   <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
> </head>
> <body bgcolor="#ffffff" text="#000000">
> Hi,<br>
> <br>
> --Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself.
> And shared libraries are present in lib/ . Now I have placed
> helloworld.elf (using printf to print helloworld, and linked with
> -static option) in bin/ and changed init=/bin/helloworld , again it
> says cannot execute /bin/helloworld. <br>
> <br>
> --John, we are using our custom hardware board, not exactly ML405 but
> its more or less similar to ML405, so I cannot use bit file provided
> for ML405. Till now we were using xilkernel, but now onward we are
> planning to use Linux. For serial console I have no option other than
> uartlite. This is how I compiled kernel :<br>
> <br>
> 1) make ARCH=ppc ml405_defconfig<br>
> 2) patched kernel src with EDK(10.1) , so as to change xparameter.h,
> and later made some changed in arch/ppc/boot/simple/embed_config.c and
> xparameters.h file.<br>
> 3) make ARCH=ppc menuconfig , and selected uartlite to be console and
> ramdisk as file system.<br>
> 4) Created ramdisk (as per Building embedded linux, Karim Yaghmour,
> however major and minor number for device nodes is similar to ramdisk
> provided at git.xilinx.com)<br>
> 5) I have placed this ramdisk in arch/ppc/boot/images<br>
> 6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu-
> zImge.initrd<br>
> <br>
> <br>
> --I have downloaded &nbsp; ELDK4.1 and installed it. And when I compile
> simple helloworld.c using cross compiler, it says unresolved symbol
> 'printf' . Is there anything else to install with ELDK ?<br>
> <br>
> <br>
> <div class="moz-signature">
> <pre>-------------------------------------------------------------------
> Neeraj Garg
> </pre>
> </div>
> <br>
> <br>
> In addition to what John wrote, I would also investigate your ramdisk.
> <br>
> I would be sure to check that you have the permissions/owner set
> correctly
> <br>
> on bin/busybox. &nbsp;Also, I would double check that, if you compiled
> busybox
> <br>
> with shared libraries, the shared libraries are in the right place
> <br>
> on your ramdisk.<br>
> <br>
> <br>
> Ron
> <br>
> <br>
> &gt; <br>
> &gt; Hi,
> <br>
> &gt; <br>
> &gt; Yes I am using ARCH=ppc (actual line is $make ARCH=ppc <br>
> &gt; CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I
> have <br>
> &gt; placed ramdisk.image.gz in arch/ppc/boot/images. In case of
> ARCH=powerpc <br>
> &gt; I cannot find processor type 405 , in make menuconfig. Thats why i
> am <br>
> &gt; using ARCH=ppc.
> <br>
> &gt; <br>
> <font color="navy" face="Arial" size="2"><span
>  style="font-size: 10pt; font-family: Arial; color: navy;"></span></font>
> </body>
> </html>
> 
> --------------060307000300070002040802--
> 
> 
> --===============0970715627==
> Content-Type: text/plain; charset="us-ascii"
> MIME-Version: 1.0
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> --===============0970715627==--
> 
