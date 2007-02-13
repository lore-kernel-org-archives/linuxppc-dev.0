Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9FA05DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 03:07:47 +1100 (EST)
Date: Tue, 13 Feb 2007 10:07:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org
Subject: Re: [PATCH 15/19] bootwrapper: Add initrd information to the device
	tree in ft_finalize().
Message-ID: <20070213160723.GC24815@ld0162-tx32.am.freescale.net>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230140.GO3849@ld0162-tx32.am.freescale.net>
	<20070209230207.GA12035@mag.az.mvista.com>
	<45D098E5.3090109@freescale.com>
	<20070213042937.GC5345@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070213042937.GC5345@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 03:29:37PM +1100, David Gibson wrote:
> Why is cuboot's malloc() allocating the flat tree in a place that's in
> danger of being clobbered by the kernel in the first place?

As the comment in cuboot.c explains, there's not enough room to do it any
other way and still run on boards with only 8MiB of RAM -- the dts has to
go above the wrapper image, and the "uncompressed" kernel has to go
below, but the same heap is used for both.  I believe there are some 8xx
boards out there with only this much; even if not, 8xx currently only
maps 8MiB by default.  8xx isn't supported by this patchset, but I'd like
to support it eventually.

-Scott
