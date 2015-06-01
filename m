Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 504D01A0762
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 13:18:38 +1000 (AEST)
Message-ID: <1433128704.2881.3.camel@cyril>
Subject: Re: [PATCH V3] drivers/mtd: add powernv flash MTD abstraction driver
From: Cyril Bur <cyrilbur@gmail.com>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Joel Stanley <joel@jms.id.au>, Jeremy Kerr
 <jk@ozlabs.org>
Date: Mon, 01 Jun 2015 13:18:24 +1000
In-Reply-To: <55682FDC.8030505@linux.vnet.ibm.com>
References: <1432884797-3056-1-git-send-email-cyrilbur@gmail.com>
 <55682FDC.8030505@linux.vnet.ibm.com>
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

On Fri, 2015-05-29 at 14:52 +0530, Neelesh Gupta wrote:
> 
> [...]
> 
> > +/**
> > + * @mtd: the device
> > + * @erase: the erase info
> > + * Returns 0 if erase successful or -ERRNO if an error occurred
> > + */
> > +static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
> > +{
> > +	int rc;
> > +
> > +	erase->state = MTD_ERASING;
> > +
> > +	/* todo: register our own notifier to do a true async implementation */
> > +	rc =  powernv_flash_async_op(mtd, FLASH_OP_ERASE, erase->addr,
> > +			erase->len, NULL, NULL);
> > +
> > +	if (rc) {
> > +		erase->fail_addr = erase->addr;
> > +		erase->state = MTD_ERASE_FAILED;
> > +	} else {
> > +		erase->state = MTD_ERASE_DONE;
> > +	}
> > +	mtd_erase_callback(erase);
> 
> return rc ? You also document the same  '.... or -ERRNO if an error
> occurred'
> 
Good catch, I'll amend.

> > +	return 0;
> > +}
> > +
> > +/**
> > + * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
> > + * structure @pdev: The platform device
> > + * @mtd: The structure to fill
> > + */
> > +static int powernv_flash_set_driver_info(struct device *dev,
> > +		struct mtd_info *mtd)
> > +{
> > +	u64 size;
> > +	u32 erase_size;
> > +	int rc;
> > +
> > +	rc = of_property_read_u32(dev->of_node, "ibm,flash-block-size",
> > +			&erase_size);
> > +	if (rc) {
> > +		dev_err(dev, "couldn't get resource block size information\n");
> > +		return rc;
> > +	}
> > +
> > +	rc = of_property_read_u64(dev->of_node, "reg", &size);
> > +	if (rc) {
> > +		dev_err(dev, "couldn't get resource size information\n");
> > +		return rc;
> > +	}
> > +
> > +	/*
> > +	 * Going to have to check what details I need to set and how to
> > +	 * get them
> > +	 */
> > +	mtd->name = of_get_property(dev->of_node, "name", NULL);
> > +	mtd->type = MTD_NORFLASH;
> > +	mtd->flags = MTD_WRITEABLE;
> > +	mtd->size = size;
> > +	mtd->erasesize = erase_size;
> > +	mtd->writebufsize = mtd->writesize = 1;
> > +	mtd->owner = THIS_MODULE;
> > +	mtd->_erase = powernv_flash_erase;
> > +	mtd->_read = powernv_flash_read;
> > +	mtd->_write = powernv_flash_write;
> > +	mtd->dev.parent = dev;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * powernv_flash_probe
> > + * @pdev: platform device
> > + *
> > + * Returns 0 on success, -ENOMEM, -ENXIO on error
> > + */
> > +static int powernv_flash_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct powernv_flash *data;
> > +	int ret;
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	data->mtd.priv = data;
> 
> 'mtd' is contained within the 'data' so you can cast 'mtd' to get the
> 'data'
> anywhere you want using container_of() macro.. 'priv' can be used to
> pass
> an unrelated structure ....  just a thought, you may ignore it.. :)

Yeah, I think I couldn't agree with myself when I wrote and I figured
there might be something I'd want to use priv for. There never was, that
stayed. I realised it got quite circular and there are now many ways of
getting back to data, I can't see any harm in leaving it like that,
except the strangeness of it.

Thanks,

Cyril
> Rest looks ok.
> 
> Neelesh.
> 
> 
