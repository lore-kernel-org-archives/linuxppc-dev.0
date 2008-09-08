Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B41C8DDFEC
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:57:58 +1000 (EST)
Date: Mon, 8 Sep 2008 23:57:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 2/4] POWERPC: Move iommu dma ops from dma.c to dma-iommu.c
Message-ID: <20080908215750.GB1175@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 08, 2008 at 02:09:53PM -0500, Becky Bruce wrote:
> +/* We support DMA to/from any memory page via the iommu */
> +static int dma_iommu_dma_supported(struct device *dev, u64 mask)
> +{
> +	struct iommu_table *tbl = dev->archdata.dma_data;
> +
> +	if (!tbl || tbl->it_offset > mask) {
> +		printk(KERN_INFO
> +		       "Warning: IOMMU offset too big for device mask\n");
> +		if (tbl)
> +			printk(KERN_INFO
> +			       "mask: 0x%08lx, table offset: 0x%08lx\n",
> +				mask, tbl->it_offset);
> +		else
> +			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
> +				mask);
> +		return 0;
> +	} else
> +		return 1;
> +}

Small nitpick, but wouldn't a

	if (tbl && tbl->it_offset <= mask)
		return 1;

	< the rest>

be much easier to read?
