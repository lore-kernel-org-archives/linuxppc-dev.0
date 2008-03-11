Return-Path: <rza1@so-logic.net>
Received: from smtp01.so-logic.net (unknown [62.99.208.151])
	by ozlabs.org (Postfix) with ESMTP id 7A13FDE0DB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 01:47:00 +1100 (EST)
Received: from localhost.localdomain
	(62-99-208-157.c-vbergg.xdsl-line.inode.at [62.99.208.157])
	by smtp01.so-logic.net (Postfix) with ESMTP id 27ABC8FD18E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 15:37:32 +0100 (CET)
Message-ID: <47D6992B.6060208@so-logic.net>
Date: Tue, 11 Mar 2008 15:37:31 +0100
From: Robert Zach <rza1@so-logic.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: bootstrap loader + gzip 1.3.5 --> huge image!?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi list!

I am using the xilinx git tree with the included bootstrap loader.
Everthing works fine when i use binutils-2.16.1-gcc-3.4.6-uClibc-0.9.29.

But when useing binutils-2.18.50-gcc-4.2.0-uClibc-0.9.29  (generated 
with buildroot) i get the following problem:

At the end of the kernel build process the vmlinux image gets compressed 
(for the bootstrap loader).
something like:
gzip -f -9 < arch/ppc/boot/images/vmlinux.bin > 
arch/ppc/boot/images/vmlinux.gz.$$
when i compiled the kernel with binutils-2.16.1-gcc-3.4.6-uClibc-0.9.29 
the resulting image size is smaller then the original and everything 
works (the bootstrap loader uncompresses, the kernel boots, ..)

But when using the binutils-2.18.50-gcc-4.2.0-uClibc-0.9.29 
cross-toolchain i get the following:
du arch/ppc/boot/images/vmlinux.bin
1264    arch/ppc/boot/images/vmlinux.bin
gzip -f -9 < arch/ppc/boot/images/vmlinux.bin > 
arch/ppc/boot/images/vmlinux.gz.$$
du arch/ppc/boot/images/vmlinux.gz.$$
3640    arch/ppc/boot/images/vmlinux.gz

The resulting huge zImage.elf file does not work (the bootstraploader 
stops somewhere early).
Its the same for all other toolchains i tryed using binutils > 2.16.

what does gzip do?
I use the following version
gzip --version
gzip 1.3.5
(2002-09-30)
Copyright 2002 Free Software Foundation
Copyright 1992-1993 Jean-loup Gailly

Does anybody know this problem?
any suggestions for a solution.

thanks in advanced!
greets!
robert
