Return-Path: <jangiels@speakeasy.net>
Received: from mail8.sea5.speakeasy.net (mail8.sea5.speakeasy.net
	[69.17.117.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5F27367B7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 08:14:26 +1000 (EST)
Subject: Re: Linux hanging on Xilinx SystemACE
From: Jeff Angielski <jangiels@speakeasy.net>
To: Clint Thomas <cthomas@Soneticom.com>
In-Reply-To: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
References: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 18:07:58 -0400
Message-Id: <1155766078.10357.16.camel@sumo-jaa>
Mime-Version: 1.0
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

On Wed, 2006-08-16 at 17:06 -0400, Clint Thomas wrote:

> Using the powerpc development tree of Linux 2.4, I am trying to boot
> my system from CompactFlash using Xilinx SystemACE. My compact flash
> card has two partitions, a 16MB FAT16 that holds the combination FPGA
> image / Linux Kernel ELF file, and an Ext2 partition that holds the
> root file system. The system starts the boot process, uncompresses the
> Linux kernel and begins loading drivers. Part way into this process,
> it conducts a partition check of the drive being reported to it by
> SystemACE, however, it hangs at that point. No kernel panic, no error
> message, it simply hangs. Here is the output at that point...
> 
> Partition check:
>  xsysacea:
>  
> what I am trying to find out is if this problem has been seen/fixed in
> the past? or did I format the CF card incorrectly?

Can u-boot see the partition formatted with ext2? 

Can you mount an NFS root filesystem and access the card normally?  Or
is it just when you use it as your rootfs?

How did you create you partitions and format the CF card?

And like somebody else mentioned, if you are really going to use this
for an embedded system, you are going to want to rethink your
partitioning scheme.

Maybe something like:

p1 fat12 - kernel and binary image
p2 ext2 - read only rootfs
p3 ext3 - non volatile, slow rate data rootfs
p4 tmpfs - volatile, high rate data rootfs


Jeff Angielski
The PTR Group
