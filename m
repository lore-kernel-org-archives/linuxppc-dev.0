Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00872DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 17:17:23 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I9FOw-0000EW-LL
	for linuxppc-embedded@ozlabs.org; Fri, 13 Jul 2007 00:17:18 -0700
Message-ID: <11574529.post@talk.nabble.com>
Date: Fri, 13 Jul 2007 00:17:18 -0700 (PDT)
From: meerkat <yiming@windriver.com>
To: linuxppc-embedded@ozlabs.org
Subject: boottime kernel relocation, what I missed?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Good day all,

For the first time I begin working on PPC, and on low level, and right start
from boot sequence, one issue puzzled me.

After bootstrap code (zImage) uncompressed the kernel vmLinux to physical
memory (say from addr 0),
it jumps to the kernel entry point, _start, using physically address. 

 At this time, the MMU is not yet setup to map the kernel virtual address 
(which is statically linked against base address KERNELBASE) to the
physically address.

$ nm vmlinux |grep early_init
c038b8e0 T early_init


_start calls early_init before mmu is on to map the KERNEL_BASE to
physically address

The question is how "bl  early_init"  can branch to the early_init entry
point, properly, as early_init is still a virtual address?

Thanks

Jim
-- 
View this message in context: http://www.nabble.com/boottime-kernel-relocation%2C-what-I-missed--tf4072673.html#a11574529
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
