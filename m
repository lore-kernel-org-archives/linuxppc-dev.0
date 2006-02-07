Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-70-125.roch.qwest.net [67.41.70.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2667689C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 00:04:08 +1100 (EST)
Subject: Re: Common Flash Interface v1.4 and MTD support in Linux-2.4.4 kernel
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: David Antliff <David_Antliff@stratexnet.com>
In-Reply-To: <1139283195.26357.50.camel@theoden.middle_earth>
References: <1139283195.26357.50.camel@theoden.middle_earth>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 05:52:57 -0500
Message-Id: <1139309578.32218.7.camel@yoda.jdub.homelinux.org>
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

On Tue, 2006-02-07 at 16:33 +1300, David Antliff wrote:
> 
> 
> I am working on an MPC852 embedded platform based on the Denx
> Linux-2.4.4 port.

To note, 2.4.4 is ancient.  And this whole question would be better
asked on the MTD mailing list.

> 
> We have an existing device with a fixed-flash (AMD-type) conforming to
> CFI (Common Flash Interface) version 1.2. Linux-2.4.4 supports this
> device when used by the Memory Tech Device Driver (MTD). This device has
> a single region ('plane'?) or at least constant geometry across the
> device. MTD in 2.4.4 has no problems dividing this up into a bunch of
> block devices (partitions for read-only filesystems).

Yep.

> 
> A newer version has a different flash chip - an Intel P30 flash with
> multiple regions - it has two types of geometries as it is configured
> for 'boot' operation. It also conforms to CFI version 1.4. Unfortunately
> the Linux-2.4.4 MTD driver rejects this as unsupported based on CFI
> version and hard-coding it in "kinda" works - the partition devices are
> readable but the driver complains bitterly about non-alignment with
> erase blocks. I suspect the driver is picking up parameters from the
> first region (which covers the first set of blocks) and trying to use
> this across the device. One thing I don't understand yet - as the first
> region uses block sizes that are an integer division of those in the
> second region I'm not sure why the boundaries don't align when I am
> using the 2nd-region block size to define the partition boundaries.

P30 support was just recently added to the 2.6 kernel.

> 
> 
> What I am looking for is some advice please - what do you think is the
> best course of action in this situation? 
> 
> There will be others but so far I am considering:
> 
> 1. back-port the CFI code from a newer 2.4 kernel to support CFI v1.4.
>  - does anybody know the state of MTD in later versions? What would be a
> good version to source from?

There is no support for CFI 1.4 in any 2.4 kernel.  You'd have to
backport from 2.6

> 
> 2. integrate code found here and try and understand how it works:
> http://lists.infradead.org/pipermail/linux-mtd/2001-November/003645.html

That won't solve all of your problems.

> 
> 
> What would you suggest? Yes, I am happy for a 'quick fix' but if there
> isn't one or it's too risky I am willing to invest the time in doing it
> right.

'quick fix' is to pull the changes from cfi_cmdset_0001.c in MTD CVS
back into your kernel.  But I'm not sure how quick that will be given
that your kernel is very very old.

josh
