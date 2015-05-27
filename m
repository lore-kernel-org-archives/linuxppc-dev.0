Return-Path: <computersforpeace@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CD221A08A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 06:57:02 +1000 (AEST)
Received: by pdbki1 with SMTP id ki1so25429162pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 13:57:00 -0700 (PDT)
Date: Wed, 27 May 2015 13:56:57 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 dwmw2@infradead.org, jk@ozlabs.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] drivers/mtd: add powernv flash MTD abstraction driver
Message-ID: <20150527205559.GK27753@ld-irv-0074>
References: <1430721739-17517-1-git-send-email-cyrilbur@gmail.com>
 <1430721739-17517-2-git-send-email-cyrilbur@gmail.com>
 <20150520211716.GM11598@ld-irv-0074>
 <1432188772.2911.15.camel@cyril>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432188772.2911.15.camel@cyril>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

On Thu, May 21, 2015 at 04:12:52PM +1000, Cyril Bur wrote:
> One question though,
> 
> On Wed, 2015-05-20 at 14:17 -0700, Brian Norris wrote:
> > On Mon, May 04, 2015 at 04:42:19PM +1000, Cyril Bur wrote:
> > > Powerpc powernv platforms allow access to certain system flash devices
> > > through a firmwarwe interface. This change adds an mtd driver for these
> > > flash devices.
> > > 
> > > Minor updates from Jeremy Kerr and Joel Stanley.
> > > 
> > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> > > ---
> > >  drivers/mtd/devices/Kconfig         |   6 +
> > >  drivers/mtd/devices/Makefile        |   1 +
> > >  drivers/mtd/devices/powernv_flash.c | 288 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 295 insertions(+)
> > >  create mode 100644 drivers/mtd/devices/powernv_flash.c
> > > 
> 
> [snip]
> 
> > > +
> > > +/**
> > > + * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
> > > + * structure @pdev: The platform device
> > > + * @mtd: The structure to fill
> > > + */
> > > +static int __init powernv_flash_set_driver_info(struct device *dev,
> > > +		struct mtd_info *mtd)
> > > +{
...
> > > +	/* Going to have to check what details I need to set and how to
> > > +	 * get them */
> > > +	mtd->name = of_get_property(dev->of_node, "name", NULL);
> > > +	mtd->type = MTD_NANDFLASH;
> > > +	mtd->flags = MTD_CAP_NANDFLASH;
> > 
> > Is this really NAND flash? It doesn't look like it; I see no bad block
> > implementation, and writesize==1.
> 
> Correct, but the type here is a bit misleading, we have a firmware
> interface for the low level read/write/erase functions, all this driver
> does is pass the calls through to firmware, there isn't much that linux
> or userspace can do since it doesn't actually do the hardware accesses. 
> 
> I've checked with Jeremy, turns out the hardware is actually NOR, no
> idea how I ever thought it was NAND.
> 
> Perhaps just:
> 	mtd->type = MTD_RAM;
> 	mtd->flags = MTD_WRITEABLE;
> 
> I would have used MTD_NOR but Jeremy confirms that the backing flash may
> not always be NOR on other platforms.

Well, it definitely shouldn't have a type of MTD_NANDFLASH if it's
actually NOR. MTD users may very well treat NAND differently than
anything else. And MTD_RAM is also pretty misleading.

Also, the comments throughout the driver about PNOR will be misleading
if it's not always PNOR.

What other type of memory might be used? Would it act any differently
than PNOR? If so, then I'd expect the driver would need to account for
this anyway (at a minimum, just by exposing that information through an
MTD API, so users can treat it differently) so we'd have a chance to
change the mtd->type.

Brian
