Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 09C37DDF97
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 06:30:40 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so5303142pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 11:30:38 -0800 (PST)
Message-ID: <5ee408090802121130m2a641637s4b75a8a144ec2efc@mail.gmail.com>
Date: Tue, 12 Feb 2008 17:30:38 -0200
From: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Howto get __log_buf on a Xilinx FPGA
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm trying to boot linux 2.6.24 on a XUP Virtex II Pro evaluation
board. It uncompresses ok but doesn't show nothing more on the
console. I tried to change the console to ttyS0 and ttyUL0. Now I want
to see the __log_buf but I don't if I am doing it the right way, it
only returns trash. What I'm doing is the following:

$ grep __log_buf System.map
c01f3d5c b __log_buf

$ xmd -xmp system.xmp -opt etc/xmd_ppc405_0.opt
(xmd starts ok, mdm is not enabled)

$ powerpc-eabi-gdb arch/ppc/boot/images/zImage.elf
(click on run, the image is loaded and started)

this is the output on the terminal:
---output start---
loaded at:     00400000 004F119C

board data at: 00000000 0000007C

relocated to:  00404048 004040C4

zimage at:     00404E34 004EE12C

avail ram:     004F2000 7C9E2378


Linux/PPC load: console=ttyS0,9600

Uncompressing Linux...done.

Now booting the kernel
---output end---

after a while I stop the debugger and type rst in xmd.
then I ask gdb to dump the memory from position 0x1f3d5c to 0x1f3fff
and only trash is returned.

What am I doing wrong? Or the kernel really isn't being executed?

Thanks,

-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
