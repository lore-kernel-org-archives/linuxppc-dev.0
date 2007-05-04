Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61FA8DDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 May 2007 05:03:30 +1000 (EST)
Message-ID: <463B833E.6070401@dlasys.net>
Date: Fri, 04 May 2007 15:02:22 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Richard Danter <richard.danter@ntlworld.com>
Subject: Re: initramfs on PowerPC
References: <200705041332.27296.richard.danter@ntlworld.com>
In-Reply-To: <200705041332.27296.richard.danter@ntlworld.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 I tried numerous approaches, I never got anything to work except pointing
CONFIG_INITRAMFS_SOURCE at a directory with my intramfs tree in it.
I am sure other ways work, but I never managed to figure out what I was
doing
wrong. Regardless that has worked well for me.

When I build I end up with a single file - zImage,.elf that has both my
kernel
and the initramfs tree in it. While there are a number of distro's that
seem to
use initramfs as a separate file - much like initrd, my loader has no
provisions for a 2nd file, and the kernel build process wraps everything
together
which works fine for me.

I have never seen your "junk in compressed archive" error, and I have
been doing this
for almost 2 years. But I have frequently had decompression errors.
These typically
have been the result of errors in the PPC zlib libraries. I beleive
somewhere between
2.6.16 and 2.6.18 these libraries got updated, and the PPC version of
the new ones
had problems. Anyway, after 2.6.18 the new ones are good - though somehow
once in a while the broken ones seem to creep into my development tree,
but updating it usually fixes things.

There also may be a total size issue. I am hazy on the details, but I
beleive if the
size of size of the kernel goes over 3mb that there are CONFIG values that
may need to be changed. I am not sure whether that is compressed size
decompressed size, kernel size, or combined kernel + initramfs size.

Regardless, one suguestion would be to try with a very minimal initramfs
tree
and add things until it blows up.






Richard Danter wrote:
> Hi all,
>
> I am having a problem booting a kernel with an initramfs. The kernel version 
> is 2.6.14. The target is a ppc 82xx board.
>
> I have tried both generating the cpio.gz file myself (find . | copi -o -H 
> newc | gzip > ../initramfs_data.cpio.gz) and pointing initramfs source to a 
> root FS directory (using xconfig) and then re-building my kernel.
>
> Usually the error is "junk in compressed archive" though I also see an 
> occasional error about padding.
>
> I am using U-Boot to load the kernel image (uImage).
>
> My host is SuSE 10.0 (x86), though I guess that shouldn't make any difference 
> (endianism?).
>
> Any thoughts on what I may be doing wrong?
>
> Thanks
> Rich
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   
