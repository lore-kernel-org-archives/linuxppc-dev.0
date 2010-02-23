Return-Path: <BATV+54e4ee8a974e2d9aaca0+2375+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75528B7D09
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Feb 2010 23:47:16 +1100 (EST)
Subject: Re: [PATCH 1/4] Add ps3_storage module alias
From: David Woodhouse <dwmw2@infradead.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.1002051446280.5981@mink.sonytel.be>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205134235.GG12001@hansolo.jdub.homelinux.org>
	<alpine.LRH.2.00.1002051446280.5981@mink.sonytel.be>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 12:47:09 +0000
Message-ID: <1266929229.30247.2579.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-05 at 14:49 +0100, Geert Uytterhoeven wrote:
> On Fri, 5 Feb 2010, Josh Boyer wrote:
> > This allows the upgrade path from older kernel releases to work
> > with the Fedora mkinitrd tool.
> > 
> > ---
> > 
> > --- linux-2.6.22.ppc64/drivers/block/ps3disk.c~       2007-07-25 16:06:16.000000000 +0100
> > +++ linux-2.6.22.ppc64/drivers/block/ps3disk.c        2007-07-26 08:49:44.000000000 +0100
> > @@ -628,3 +628,4 @@ MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("PS3 Disk Storage Driver");
> >  MODULE_AUTHOR("Sony Corporation");
> >  MODULE_ALIAS(PS3_MODULE_ALIAS_STOR_DISK);
> > +MODULE_ALIAS("ps3_storage");
> 
> NAKed-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> ps3_storage was replaced by 3 drivers: ps3disk, ps3rom, and ps3flash. These are
> automatically loaded by udev.
> 
> How does mkinitrd determine the driver for the root file system on other
> systems? Does it really contain a big list of e.g. all SCSI drivers?

It pokes about in sysfs and works out the driver which is used for the
current root devices.

This hack was only needed for the upgrade -- when you were running a
kernel with the ps3_storage kernel and you first installed a kernel with
the new ps3disk driver, you needed it to find the right module.

I think we can drop it now.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
