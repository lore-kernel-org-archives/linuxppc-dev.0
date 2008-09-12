Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FBC0DE046
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 01:33:14 +1000 (EST)
Message-Id: <3761F3E7-2FE5-4BFF-873C-8D8559A43B33@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080908215750.GB1175@lst.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 2/4] POWERPC: Move iommu dma ops from dma.c to dma-iommu.c
Date: Fri, 12 Sep 2008 10:32:54 -0500
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<20080908215750.GB1175@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2008, at 4:57 PM, Christoph Hellwig wrote:

> On Mon, Sep 08, 2008 at 02:09:53PM -0500, Becky Bruce wrote:
>> +/* We support DMA to/from any memory page via the iommu */
>> +static int dma_iommu_dma_supported(struct device *dev, u64 mask)
>> +{
>> +	struct iommu_table *tbl = dev->archdata.dma_data;
>> +
>> +	if (!tbl || tbl->it_offset > mask) {
>> +		printk(KERN_INFO
>> +		       "Warning: IOMMU offset too big for device mask\n");
>> +		if (tbl)
>> +			printk(KERN_INFO
>> +			       "mask: 0x%08lx, table offset: 0x%08lx\n",
>> +				mask, tbl->it_offset);
>> +		else
>> +			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
>> +				mask);
>> +		return 0;
>> +	} else
>> +		return 1;
>> +}
>
> Small nitpick, but wouldn't a
>
> 	if (tbl && tbl->it_offset <= mask)
> 		return 1;
>
> 	< the rest>
>
> be much easier to read?

Seems cleaner to me..... but I want this patch, which is a move of the  
iommu code, to be *just* a move.  So I'm going to leave this as-is for  
now.

Thanks!
-Becky
