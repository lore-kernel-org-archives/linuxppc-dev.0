Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CFBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:48:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64632337F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64632337F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DG6gg69FQzDqJY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 23:48:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DG6Zw4mM7zDrQP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 23:44:24 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5DAEB68AFE; Wed, 13 Jan 2021 13:44:16 +0100 (CET)
Date: Wed, 13 Jan 2021 13:44:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 3/6] swiotlb: Use restricted DMA pool if available
Message-ID: <20210113124416.GB1383@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-4-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-4-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org, grant.likely@arm.com,
 paulus@samba.org, frowand.list@gmail.com, mingo@kernel.org,
 m.szyprowski@samsung.com, sstabellini@kernel.org, saravanak@google.com,
 joro@8bytes.org, rafael.j.wysocki@intel.com, hch@lst.de,
 bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org, treding@nvidia.com,
 devicetree@vger.kernel.org, will@kernel.org, konrad.wilk@oracle.com,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, jgross@suse.com,
 drinkcat@chromium.org, gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 iommu@lists.linux-foundation.org, xypron.glpk@gmx.de, robin.murphy@arm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> +#ifdef CONFIG_SWIOTLB
> +	if (unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dma_io_tlb_mem)
>  		return swiotlb_map(dev, phys, size, dir, attrs);
> +#endif

Please provide a wrapper for the dev->dma_io_tlb_mem check that
always returns false if the per-device swiotlb support is not enabled.

> index 7fb2ac087d23..1f05af09e61a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -222,7 +222,6 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  		mem->orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	mem->index = 0;
> -	no_iotlb_memory = false;

How does this fit in here?

