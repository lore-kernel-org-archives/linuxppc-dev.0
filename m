Return-Path: <rza1@so-logic.net>
Received: from smtp01.so-logic.net (unknown [62.99.208.151])
	by ozlabs.org (Postfix) with ESMTP id 6E80BDE07D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 02:45:56 +1100 (EST)
Received: from freak-2.local (62-99-208-157.c-vbergg.xdsl-line.inode.at
	[62.99.208.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp01.so-logic.net (Postfix) with ESMTP id AD5078FD18E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 16:45:55 +0100 (CET)
Message-ID: <47D6A933.8050601@so-logic.net>
Date: Tue, 11 Mar 2008 16:45:55 +0100
From: rza1 <rza1@so-logic.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: bootstrap loader + gzip 1.3.5 --> huge image!?
References: <47D6992B.6060208@so-logic.net>
In-Reply-To: <47D6992B.6060208@so-logic.net>
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

I just recognized that gzip does his job right.
But objcopy of all binutils > 2.16.1 has problems during binary copy:
powerpc-linux-objcopy -O binary vmlinux arch/ppc/boot/images/vmlinux.bin

The vmlinux file does look good (what i can see with vi) but the 
generated vmlinux.bin file is strange. Windows machines say that the 
vmlinux.bin file is > then 3GByte, but linux says 1,5Mbyte. But, I can't 
open it with vi...

Anywhay i think binutils > 2.16.1 has some problems with ppc.

Does anyone else use buildroot for ppc405 platform and solved the 
problems with actual binutils versions?
cheers!
robert

Robert Zach wrote:
> hi list!
>
> I am using the xilinx git tree with the included bootstrap loader.
> Everthing works fine when i use binutils-2.16.1-gcc-3.4.6-uClibc-0.9.29.
>
> But when useing binutils-2.18.50-gcc-4.2.0-uClibc-0.9.29  (generated 
> with buildroot) i get the following problem:
>
> At the end of the kernel build process the vmlinux image gets 
> compressed (for the bootstrap loader).
> something like:
> gzip -f -9 < arch/ppc/boot/images/vmlinux.bin > 
> arch/ppc/boot/images/vmlinux.gz.$$
> when i compiled the kernel with 
> binutils-2.16.1-gcc-3.4.6-uClibc-0.9.29 the resulting image size is 
> smaller then the original and everything works (the bootstrap loader 
> uncompresses, the kernel boots, ..)
>
> But when using the binutils-2.18.50-gcc-4.2.0-uClibc-0.9.29 
> cross-toolchain i get the following:
> du arch/ppc/boot/images/vmlinux.bin
> 1264    arch/ppc/boot/images/vmlinux.bin
> gzip -f -9 < arch/ppc/boot/images/vmlinux.bin > 
> arch/ppc/boot/images/vmlinux.gz.$$
> du arch/ppc/boot/images/vmlinux.gz.$$
> 3640    arch/ppc/boot/images/vmlinux.gz
>
> The resulting huge zImage.elf file does not work (the bootstraploader 
> stops somewhere early).
> Its the same for all other toolchains i tryed using binutils > 2.16.
>
> what does gzip do?
> I use the following version
> gzip --version
> gzip 1.3.5
> (2002-09-30)
> Copyright 2002 Free Software Foundation
> Copyright 1992-1993 Jean-loup Gailly
>
> Does anybody know this problem?
> any suggestions for a solution.
>
> thanks in advanced!
> greets!
> robert
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
