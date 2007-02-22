Return-Path: <juergen.beisert@weihenstephan.org>
Received: from bill.weihenstephan.org (bill.weihenstephan.org [82.135.35.21])
	by ozlabs.org (Postfix) with ESMTP id B3064DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 22:29:55 +1100 (EST)
From: Juergen Beisert <juergen.beisert@weihenstephan.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] jffs2 file system
Date: Thu, 22 Feb 2007 12:29:46 +0100
References: <9097247.post@talk.nabble.com>
	<200702221128.02970.juergen.beisert@weihenstephan.org>
	<9097618.post@talk.nabble.com>
In-Reply-To: <9097618.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702221229.51830.juergen.beisert@weihenstephan.org>
Cc: Nethra <nethra_gmit@yahoo.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 22 February 2007 11:58, Nethra wrote:
> do i need to mention mtdparts in command line....i thought that it is
> enabled in case if we want we can specify partitions in command line
> itself.

The kernel does not know anything about your flash partitioning. Where is mtd0 
starting in your flash? At the baseaddress of the flash?

> do i need to disable ramdisk option in kernel config for jffs2 booting?

No.

On my MPC5200 based system I start the kernel with this partition command:

mtdparts=phys_mapped_flash:256k(ubootl),1792k(kernel),13312k(jffs2),256k(uboot)ro,-(space)
root=/dev/mtdblock2 rootfstype=jffs2

Juergen
