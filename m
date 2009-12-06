Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 324E5B7BCA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Dec 2009 18:01:32 +1100 (EST)
From: Rob Landley <rob@landley.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: ZILOG serial port broken in 2.6.32
Date: Sun, 6 Dec 2009 01:01:21 -0600
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200912060101.22515.rob@landley.net>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Trying again with a few likely-looking cc's from the MAINTAINERS file:

Summary: 

The PMACZILOG serial driver last worked in 2.6.28.  It was broken by commit 
f751928e0ddf54ea4fe5546f35e99efc5b5d9938 by Alan Cox making bits of the tty 
layer dynamically allocated.  The PMACZILOG driver wasn't properly converted, 
it works with interrupts disabled (for boot messages), but as soon as 
interrupts are enabled (PID 1 spawns) the next write to the serial console 
panics the kernel.

Up through 2.6.31 I could fix it by reverting that patch (which isn't a proper 
fix but it made it work).  In 2.6.32 the patch no longer cleanly reverts.

I reported the issue here (with a cut and paste of the panic trace):

  http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/076727.html

And reported the results of bisecting the issue here:

  http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/077059.html

I noted that 2.6.32-pre had broken my workaround here:

  http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/078498.html

Background:

I have a project that builds the same native Linux development environment for 
multiple hardware targets.  It aims to support all the targets QEMU system 
emulation can boot Linux under, although I'm still a few short.  It creates a 
cross compiler and uses it to build a root filesystem from uClibc and busybox, 
adds a native toolchain, and packages it up into a system image (squashfs, 
ext2, or initramfs depending on the config you selected).

Anyone can then boot the resulting system image under qemu and use it to wet 
source and compile stuff natively.   (If the cross compiler is in the $PATH on 
the host, it will even configure distcc to call out to that cross compiler to 
speed up the builds to merely "painfully slow", with some pretense of SMP 
scalability).

Prebuilt binaries of all the targets I had working last release are at 
http://impactlinux.com/fwl/downloads/binaries (with obligatory screenshots at 
http://impactlinux.com/fwl/screenshots/ even).  They use the 2.6.31 kernel.

It supports powerpc.  If you look at system-image-powerpc.tar.bz2 you'll see 
that the run-emulator.sh script has been using qemu's "g3beige" target board 
emulation, which provides all the hardware I need for a development 
environment (hard drive, network card, at least 256 megs of memory, working 
clock chip, and of course a serial console).  Userspace doesn't care what I 
use, it's the same processor instruction set and same C library either way, 
the board emulation's just something to boot it on, only the kernel .config 
really cares as long as the appropriate resources are there.

Unfortunately, g3beige seems to have bit-rotted, and thus the serial console 
is now panicing.  This is a regression, and thus blocking a release of my 
project using the 2.6.32 kernel.  Is this of interest to anyone other than me?

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
