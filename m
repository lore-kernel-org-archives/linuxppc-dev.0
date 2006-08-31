Return-Path: <skaiser.uci@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id 0984667B72
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 08:55:27 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so388172nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 15:55:26 -0700 (PDT)
From: "Steven Kaiser" <skaiser.uci@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Simple module, but won't build
Date: Thu, 31 Aug 2006 15:55:24 -0700
Message-ID: <000001c6cd50$8c0196f0$6e4ec880@volt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi gurus:

Newbie here.  I am using ELDK 3.1.1, 2.4.25 kernel, and a Lite5200b board.
I run the kernel in RAM, and mount a filesystem via NFS.  So far so good,
and I move on to trying to build a simple module to write to a few LEDs.

Simple hello world modules compile and insmod/rmmod fine, but when I try to
#include <asm/io.h>, here I have the exact same problem as Richard Danter
did: CONFIG_KERNEL_START and CONFIG_TASK_SIZE are not defined anywhere in
any headers-- just in the config files.

http://ozlabs.org/pipermail/linuxppc-embedded/2004-May/014037.html

My little wrinkle to add to this problem is I have recompiled the kernel, as
advised in the replies to Richard's post, with the 'Set Custom Kernel Base
Address' and 'Set Custom user task size' options enabled, but in my case I
still I cannot find CONFIG_KERNEL_START and CONFIG_TASK_SIZE defined
anywhere noteworthy.

My 'include/linux/autoconf.h' file is empty, and I don't even have an
'include/config/' directory at all.  Where in the steps of recompiling the
kernel should these files and directories get generated?

My process for building the kernel is:

$ cd /opt/eldk/usr/src/linuxppc_2_4_devel
$ make mrproper
$ make lite5200b_config
$ make menuconfig
$ make dep
$ make uImage
$ cp arch/ppc/boot/images/uImage /tftpboot/MPC5200/uImage

I can manually include CONFIG_KERNEL_START and CONFIG_TASK_SIZE in my module
source, compile, insmod, and all goes well (except my LEDs don't light up
but first things first).

When my kernel boots, I get a few gripes which I think are related to this
issue:

Finding module dependencies:  depmod: Can't open
/lib/modules/2.4.25/modules.deg [FAILED]
modprobe: Can't open dependencies file /lib/modules/2.4.25/modules.dep (No
such)

Young and foolish, I figured maybe I should try:

$ make modules
$ make modules_install

Oops.  That was bad.  Now I cannot even compile the simplest hello.c module
without a page of errors, the first being a complaint of not being able to
find linux/autoconf.h.  Before I only had trouble when I tried to #include
<asm/io.h>, now it happens 100% of the time.

So I went back and turned off module support, recompiled the kernel, and
still cannot compile hello.c.  I also tried recompiling the kernel after
doing a "make oldconfig", and still cannot compile a simple module anymore.
I think I am going to have to go back to square 1 and reinstall ELDK and
everything from scratch.  But before I do:

Any insight into the generation of autoconf.h, and whereabouts this file
should come from?  I will watch for it when I redo the whole process.

Steven Kaiser
Chemistry Electronics Facility
University of California, Irvine
2347 Natural Sciences 2
Irvine, CA  92697-2025
(949)824-7520
