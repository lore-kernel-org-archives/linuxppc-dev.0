Return-Path: <richard.danter@ntlworld.com>
Received: from mtaout02-winn.ispmail.ntl.com (mtaout02-winn.ispmail.ntl.com
	[81.103.221.48]) by ozlabs.org (Postfix) with ESMTP id B09F3DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 May 2007 22:41:42 +1000 (EST)
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
	by mtaout02-winn.ispmail.ntl.com with ESMTP id
	<20070508124139.WUHG12560.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 May 2007 13:41:39 +0100
Received: from dhcp-1-205 ([82.18.130.18])
	by aamtaout03-winn.ispmail.ntl.com with ESMTP id
	<20070508124138.VQPP26699.aamtaout03-winn.ispmail.ntl.com@dhcp-1-205>
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 May 2007 13:41:38 +0100
From: Richard Danter <richard.danter@ntlworld.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: initramfs on PowerPC
Date: Tue, 8 May 2007 13:41:36 +0100
References: <200705041332.27296.richard.danter@ntlworld.com>
	<463B833E.6070401@dlasys.net>
In-Reply-To: <463B833E.6070401@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705081341.36543.richard.danter@ntlworld.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

I did as you suggested, made a very small initramfs, and it worked!

All it contained was a simple "hello world" file plus a /dev/console node.

I then tried to increase the size of this small fs by adding a file (dd 
if=/dev/urandom of=bigfatfile bs=1M count=1) but this then gives a CRC error 
when I try to boot.

I have also tried increasing the default ramdisk size to 16MB but that makes 
no difference.

Are there any limitrations to the size of the initramfs or on the contents of 
this fs?

Any other suggestions?
Thanks!
Rich


On Friday 04 May 2007 20:02, David H. Lynch Jr. wrote:
>  I tried numerous approaches, I never got anything to work except pointing
> CONFIG_INITRAMFS_SOURCE at a directory with my intramfs tree in it.
> I am sure other ways work, but I never managed to figure out what I was
> doing
> wrong. Regardless that has worked well for me.
>
> When I build I end up with a single file - zImage,.elf that has both my
> kernel
> and the initramfs tree in it. While there are a number of distro's that
> seem to
> use initramfs as a separate file - much like initrd, my loader has no
> provisions for a 2nd file, and the kernel build process wraps everything
> together
> which works fine for me.
>
> I have never seen your "junk in compressed archive" error, and I have
> been doing this
> for almost 2 years. But I have frequently had decompression errors.
> These typically
> have been the result of errors in the PPC zlib libraries. I beleive
> somewhere between
> 2.6.16 and 2.6.18 these libraries got updated, and the PPC version of
> the new ones
> had problems. Anyway, after 2.6.18 the new ones are good - though somehow
> once in a while the broken ones seem to creep into my development tree,
> but updating it usually fixes things.
>
> There also may be a total size issue. I am hazy on the details, but I
> beleive if the
> size of size of the kernel goes over 3mb that there are CONFIG values that
> may need to be changed. I am not sure whether that is compressed size
> decompressed size, kernel size, or combined kernel + initramfs size.
>
> Regardless, one suguestion would be to try with a very minimal initramfs
> tree
> and add things until it blows up.
>
> Richard Danter wrote:
> > Hi all,
> >
> > I am having a problem booting a kernel with an initramfs. The kernel
> > version is 2.6.14. The target is a ppc 82xx board.
> >
> > I have tried both generating the cpio.gz file myself (find . | copi -o -H
> > newc | gzip > ../initramfs_data.cpio.gz) and pointing initramfs source to
> > a root FS directory (using xconfig) and then re-building my kernel.
> >
> > Usually the error is "junk in compressed archive" though I also see an
> > occasional error about padding.
> >
> > I am using U-Boot to load the kernel image (uImage).
> >
> > My host is SuSE 10.0 (x86), though I guess that shouldn't make any
> > difference (endianism?).
> >
> > Any thoughts on what I may be doing wrong?
> >
> > Thanks
> > Rich
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
