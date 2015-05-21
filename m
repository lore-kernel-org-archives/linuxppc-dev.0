Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBCCD1A0AD5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 16:13:03 +1000 (AEST)
Received: by pabru16 with SMTP id ru16so94120518pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 23:13:01 -0700 (PDT)
Message-ID: <1432188772.2911.15.camel@cyril>
Subject: Re: [PATCH] drivers/mtd: add powernv flash MTD abstraction driver
From: Cyril Bur <cyrilbur@gmail.com>
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 dwmw2@infradead.org, jk@ozlabs.org, Joel Stanley <joel@jms.id.au>
Date: Thu, 21 May 2015 16:12:52 +1000
In-Reply-To: <20150520211716.GM11598@ld-irv-0074>
References: <1430721739-17517-1-git-send-email-cyrilbur@gmail.com>
 <1430721739-17517-2-git-send-email-cyrilbur@gmail.com>
 <20150520211716.GM11598@ld-irv-0074>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wed, 2015-05-20 at 14:17 -0700, Brian Norris wrote:
> You might run this through checkpatch, as it caught several small
> things.
> 
Hi Brian,

Oops, sorry absolutely should have done checkpatch!

Thanks for the review, everything you've said is great, I've addressed
all that - I'll post a v2.

One question though,

> On Mon, May 04, 2015 at 04:42:19PM +1000, Cyril Bur wrote:
> > Powerpc powernv platforms allow access to certain system flash devices
> > through a firmwarwe interface. This change adds an mtd driver for these
> > flash devices.
> > 
> > Minor updates from Jeremy Kerr and Joel Stanley.
> > 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> 
> While I have Jeremy's attention, let me plug a friendly reminder for
> this unrelated comment:
> 
> http://patchwork.ozlabs.org/patch/413355/
> 
> Jeremy, you still haven't updated patchwork.git for your last round of
> supposed "merges".
> 
> > ---
> >  drivers/mtd/devices/Kconfig         |   6 +
> >  drivers/mtd/devices/Makefile        |   1 +
> >  drivers/mtd/devices/powernv_flash.c | 288 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 295 insertions(+)
> >  create mode 100644 drivers/mtd/devices/powernv_flash.c
> > 

[snip]

> > +
> > +/**
> > + * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
> > + * structure @pdev: The platform device
> > + * @mtd: The structure to fill
> > + */
> > +static int __init powernv_flash_set_driver_info(struct device *dev,
> > +		struct mtd_info *mtd)
> > +{
> > +	const __be32 *reg, *erase_size;
> > +	int count;
> > +
> > +	erase_size = of_get_property(dev->of_node,
> > +			"ibm,flash-block-size", NULL);
> > +	if (!erase_size) {
> > +		dev_err(dev, "no device property 'ibm,flash-block-size'\n");
> > +		return 1;
> > +	}
> > +
> > +	reg = of_get_property(dev->of_node, "reg", &count);
> > +	if (count / sizeof(__be32) != 2) {
> > +		dev_err(dev, "couldn't get resource information count=%d\n",
> > +				count);
> > +		return 1;
> > +	}
> > +
> > +	/* Going to have to check what details I need to set and how to
> > +	 * get them */
> > +	mtd->name = of_get_property(dev->of_node, "name", NULL);
> > +	mtd->type = MTD_NANDFLASH;
> > +	mtd->flags = MTD_CAP_NANDFLASH;
> 
> Is this really NAND flash? It doesn't look like it; I see no bad block
> implementation, and writesize==1.
> 

Correct, but the type here is a bit misleading, we have a firmware
interface for the low level read/write/erase functions, all this driver
does is pass the calls through to firmware, there isn't much that linux
or userspace can do since it doesn't actually do the hardware accesses. 

I've checked with Jeremy, turns out the hardware is actually NOR, no
idea how I ever thought it was NAND.

Perhaps just:
	mtd->type = MTD_RAM;
	mtd->flags = MTD_WRITEABLE;

I would have used MTD_NOR but Jeremy confirms that the backing flash may
not always be NOR on other platforms.

I would appreciate your thoughts here.

> > +	mtd->size = of_read_number(reg, 2);
> 
> of_property_read_u64()?
> 
> > +	mtd->erasesize = of_read_number(erase_size, 1);
> 
> Looking for of_property_read_u32()?
> 
> > +	mtd->writebufsize = mtd->writesize = 1;
> > +	mtd->owner = THIS_MODULE;
> > +	mtd->_erase = powernv_flash_erase;
> > +	mtd->_read = powernv_flash_read;
> > +	mtd->_write = powernv_flash_write;
> > +	mtd->dev.parent = dev;
> > +	return 0;
> > +}
> > +

[snip]

Thanks very much for the review,

Cyril
> 
> Brian
