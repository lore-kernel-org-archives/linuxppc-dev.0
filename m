Return-Path: <jreiser@BitWagon.com>
Received: from jade.aracnet.com (jade.aracnet.com [216.99.193.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AA29DDF6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 01:56:26 +1000 (EST)
Received: from [192.168.0.4] (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by jade.aracnet.com (8.13.6/8.12.8) with ESMTP id l42FnUmU009548
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 May 2007 08:49:30 -0700
Message-ID: <4638B319.6080005@BitWagon.com>
Date: Wed, 02 May 2007 08:49:45 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: better compression: 1.0MB for defconfig-minimal kernel
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

upx --lzma compresses much tighter than gzip.
A user-mode test jig succesfully handles the 2.6.21.1 kernel
configured with defconfig-minimal in 1,018,237 bytes total,
in contrast to the 1,390,765 bytes of vmlinux.bin.gz (and the .gz
does not include 34,795 bytes for compiled arch/powerpc/boot/*.c.)
However, I cannot figure out how to get a real bootable kernel
that uses compression.  I'd like to test it on an Apple PowerMac G4
that now runs Fedora Core 6.  The FC6 kernel calls itself "vmlinuz"
but does _not_ use any compression; I double-checked by rebuilding
from the .src.rpm.

A plain "make" in a kernel.org-2.6.21.1 tree gives a vmlinux that is
not compressed.  A "make zImage" produces arch/powerpc/boot/uImage
[with no thanks to the *undocumented* mkimage] that uses gzip,
but does not use any code from arch/powerpc/boot/*.c; so where is
the decompression code?

linux/Documentation/powerpc/*.txt does not shed light on these issues.
Please point me at a description of the flow of control for
building and booting a compressed Linux kernel for powerpc.  Thank you.

-- 
