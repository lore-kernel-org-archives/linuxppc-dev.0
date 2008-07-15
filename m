Return-Path: <neerajg@cdac.in>
Received: from mx2.cdac.in (mx1.cdac.in [203.199.132.35])
	by ozlabs.org (Postfix) with ESMTP id 7CA4EDDF60
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jul 2008 16:23:52 +1000 (EST)
Received: from mailhub.cdac.in (mailhub [196.1.109.254])by mailhub.cdac.in
	(8.13.4/8.13.4) with ESMTP id m6F6Nncl018466for
	<linuxppc-embedded@ozlabs.org>; Tue, 15 Jul 2008 11:53:49 +0530
Message-ID: <487C4326.9000000@cdac.in>
Date: Tue, 15 Jul 2008 11:56:46 +0530
From: Neeraj Garg <neerajg@cdac.in>
MIME-Version: 1.0
To: John Linn <John.Linn@xilinx.com>
Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found)
References: <48744475.2080605@cdac.in> <20080709143318.GB26524@secretlab.ca>
	<20080709160659.EE3F6E28065@mail118-va3.bigfish.com>
In-Reply-To: <20080709160659.EE3F6E28065@mail118-va3.bigfish.com>
Content-Type: multipart/alternative;
	boundary=------------060307000300070002040802
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060307000300070002040802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

--Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself. And 
shared libraries are present in lib/ . Now I have placed helloworld.elf 
(using printf to print helloworld, and linked with -static option) in 
bin/ and changed init=/bin/helloworld , again it says cannot execute 
/bin/helloworld.

--John, we are using our custom hardware board, not exactly ML405 but 
its more or less similar to ML405, so I cannot use bit file provided for 
ML405. Till now we were using xilkernel, but now onward we are planning 
to use Linux. For serial console I have no option other than uartlite. 
This is how I compiled kernel :

1) make ARCH=ppc ml405_defconfig
2) patched kernel src with EDK(10.1) , so as to change xparameter.h, and 
later made some changed in arch/ppc/boot/simple/embed_config.c and 
xparameters.h file.
3) make ARCH=ppc menuconfig , and selected uartlite to be console and 
ramdisk as file system.
4) Created ramdisk (as per Building embedded linux, Karim Yaghmour, 
however major and minor number for device nodes is similar to ramdisk 
provided at git.xilinx.com)
5) I have placed this ramdisk in arch/ppc/boot/images
6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- 
zImge.initrd


--I have downloaded   ELDK4.1 and installed it. And when I compile 
simple helloworld.c using cross compiler, it says unresolved symbol 
'printf' . Is there anything else to install with ELDK ?


-------------------------------------------------------------------
Neeraj Garg



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

--------------060307000300070002040802
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
--Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself.
And shared libraries are present in lib/ . Now I have placed
helloworld.elf (using printf to print helloworld, and linked with
-static option) in bin/ and changed init=/bin/helloworld , again it
says cannot execute /bin/helloworld. <br>
<br>
--John, we are using our custom hardware board, not exactly ML405 but
its more or less similar to ML405, so I cannot use bit file provided
for ML405. Till now we were using xilkernel, but now onward we are
planning to use Linux. For serial console I have no option other than
uartlite. This is how I compiled kernel :<br>
<br>
1) make ARCH=ppc ml405_defconfig<br>
2) patched kernel src with EDK(10.1) , so as to change xparameter.h,
and later made some changed in arch/ppc/boot/simple/embed_config.c and
xparameters.h file.<br>
3) make ARCH=ppc menuconfig , and selected uartlite to be console and
ramdisk as file system.<br>
4) Created ramdisk (as per Building embedded linux, Karim Yaghmour,
however major and minor number for device nodes is similar to ramdisk
provided at git.xilinx.com)<br>
5) I have placed this ramdisk in arch/ppc/boot/images<br>
6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu-
zImge.initrd<br>
<br>
<br>
--I have downloaded &nbsp; ELDK4.1 and installed it. And when I compile
simple helloworld.c using cross compiler, it says unresolved symbol
'printf' . Is there anything else to install with ELDK ?<br>
<br>
<br>
<div class="moz-signature">
<pre>-------------------------------------------------------------------
Neeraj Garg
</pre>
</div>
<br>
<br>
In addition to what John wrote, I would also investigate your ramdisk.
<br>
I would be sure to check that you have the permissions/owner set
correctly
<br>
on bin/busybox. &nbsp;Also, I would double check that, if you compiled
busybox
<br>
with shared libraries, the shared libraries are in the right place
<br>
on your ramdisk.<br>
<br>
<br>
Ron
<br>
<br>
&gt; <br>
&gt; Hi,
<br>
&gt; <br>
&gt; Yes I am using ARCH=ppc (actual line is $make ARCH=ppc <br>
&gt; CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I
have <br>
&gt; placed ramdisk.image.gz in arch/ppc/boot/images. In case of
ARCH=powerpc <br>
&gt; I cannot find processor type 405 , in make menuconfig. Thats why i
am <br>
&gt; using ARCH=ppc.
<br>
&gt; <br>
<font color="navy" face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial; color: navy;"></span></font>
</body>
</html>

--------------060307000300070002040802--
