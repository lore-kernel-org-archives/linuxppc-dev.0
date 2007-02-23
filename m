Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E136DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 15:29:00 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HKS3F-0002OD-9K
	for linuxppc-embedded@ozlabs.org; Thu, 22 Feb 2007 20:28:57 -0800
Message-ID: <9113399.post@talk.nabble.com>
Date: Thu, 22 Feb 2007 20:28:57 -0800 (PST)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] jffs2 file system
In-Reply-To: <200702221229.51830.juergen.beisert@weihenstephan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <9097247.post@talk.nabble.com>
	<200702221128.02970.juergen.beisert@weihenstephan.org>
	<9097618.post@talk.nabble.com>
	<200702221229.51830.juergen.beisert@weihenstephan.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



thanks...

what are the steps to create jffs2 image?

do i need to disable nfs option in kernel?

what r steps for jffs2 mounting after nfs mounting on the board?

nethra

> do i need to mention mtdparts in command line....i thought that it is
> enabled in case if we want we can specify partitions in command line
> itself.

The kernel does not know anything about your flash partitioning. Where is
mtd0 
starting in your flash? At the baseaddress of the flash?

> do i need to disable ramdisk option in kernel config for jffs2 booting?

No.

On my MPC5200 based system I start the kernel with this partition command:

mtdparts=phys_mapped_flash:256k(ubootl),1792k(kernel),13312k(jffs2),256k(uboot)ro,-(space)
root=/dev/mtdblock2 rootfstype=jffs2

Juergen


-- 
View this message in context: http://www.nabble.com/jffs2-file-system-tf3271928.html#a9113399
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
