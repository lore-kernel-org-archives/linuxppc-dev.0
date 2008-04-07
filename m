Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0297DDFC8
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 01:33:45 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m37FXeKJ029917
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 17:33:41 +0200
Message-ID: <10a101c898c4$c183ee40$f52f9e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Booting a Xilinx board
Date: Mon, 7 Apr 2008 17:33:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,
sorry if this is an elementary question for most of you, but could you tell 
me where I'm going wrong in trying to boot a kernel 2.6.24 on a Xilinx ml405 
board ?

- I generate an ext2 partition with buildroot, cointaining busybox and 
uclibc.

- I copy it to my CF card:
sudo dd if=binaries/genepy/rootfs.test.ext2 of=/dev/sdc2

- I compile the git Xilinx kernel, with proper xparameters file from the BSP 
and proper .config options to match the design, using the cross compiler 
created by buildroot.

- I generate a sysace file from that kernel and put it on the 1st partition:
xmd -tcl genace.tcl -jprog -board ml405 -target ppc_hw -hw 
implementation/system.bit -elf 
~/kernels/linux-2.6.24/arch/ppc/boot/images/zImage.elf -ace Kernel26.ace

When I boot I get the following:

loaded at:     00400000 0050719C
board data at: 00505120 0050519C
relocated to:  00404054 004040D0
zimage at:     00404E40 0050484E
avail ram:     00508000 08000000

Linux/PPC load: console=ttyS0,9600 ip=on root=/dev/sysace/disc0/part2 rw
Uncompressing Linux...done.
Now booting the kernel

And then it stops.
I'm sure I've overlooked something obvious...
Thanks
-- 
Guillaume Dargaud
http://www.gdargaud.net/
