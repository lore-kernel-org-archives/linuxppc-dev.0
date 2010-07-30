Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 1905FB70A4
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 03:04:30 +1000 (EST)
Received: from mail176-tx2 (localhost.localdomain [127.0.0.1])	by
	mail176-tx2-R.bigfish.com (Postfix) with ESMTP id 9070BA4008A	for
	<linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:04:27 +0000 (UTC)
Received: from TX2EHSMHS014.bigfish.com (unknown [10.9.14.245])	by
	mail176-tx2.bigfish.com (Postfix) with ESMTP id 504D462004C	for
	<linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:04:27 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6UH4PPl016112	for <linuxppc-dev@ozlabs.org>;
	Fri, 30 Jul 2010 10:04:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6UHFb1J014268	for <linuxppc-dev@ozlabs.org>;
	Fri, 30 Jul 2010 12:15:37 -0500 (CDT)
Date: Fri, 30 Jul 2010 12:04:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: ramdisk size is larger than 4MB
Message-ID: <20100730120424.6db4139f@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTinKb8E_McVAv5epg+4acb8H1+8HNsKHJYDr9B10@mail.gmail.com>
References: <AANLkTinKb8E_McVAv5epg+4acb8H1+8HNsKHJYDr9B10@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 30 Jul 2010 00:00:52 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> Hi,
> 
> I have a ramdisk as RFS much larger than 4MB in a 2.4 kernel. In
> recent 2.6 kernels ramdisk is no longer supported so I decided to go
> with initramfs. However I found the initial RFS for initramfs is
> limited to 4MB since the bootwrapper locates at 0x400000.

The uncompressed image, including both ramfs and kernel must fit below
4MB.

> One way to lift this limitation is to relocate the bootwrapper to
> somewhere else, say for example, 0x1000000 so that a 16MB initramfs
> can be loaded. If the bootwrapper is relocated, what else would be
> affected by this relocation?

It should be fine to just change it locally.  It would be a problem to
change it upstream for all boards, since some supported boards have
only 16MB (or even 8MB) of RAM.

Another option is to provide a vmlinux_alloc callback to stick the
kernel somewhere other than zero, at the cost of an extra image copy
once the kernel runs to get itself back down to zero.  This wasn't done
in cuboot because it was considered better to adjust the bootwrapper
link address at build time based on the kernel+ramfs image size, but
that never got implemented.

Perhaps a reasonable compromise is a vmlinux_alloc that returns zero if
the image fits there, and calls malloc otherwise?

-Scott
