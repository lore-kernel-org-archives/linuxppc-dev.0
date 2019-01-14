Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FCC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 14:18:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5103F20651
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 14:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5103F20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dbDM01ryzDqPd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 01:18:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dbBX5yTbzDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 01:16:51 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEA66A78;
 Mon, 14 Jan 2019 06:16:49 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3DB3F5AF;
 Mon, 14 Jan 2019 06:16:47 -0800 (PST)
Subject: Re: [PATCH 2/3] dma-mapping: don't BUG when calling dma_map_resource
 on RAM
To: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8f9e4f0-87fc-9f4f-37ea-39297acc8d31@arm.com>
Date: Mon, 14 Jan 2019 14:16:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111181731.11782-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/01/2019 18:17, Christoph Hellwig wrote:
> Use WARN_ON_ONCE to print a stack trace and return a proper error
> code instead.

I was racking my brain to remember the reasoning behind BUG_ON() being 
the only viable way to prevent errors getting through unhandled, but of 
course that was before we had a standardised DMA_MAPPING_ERROR that 
would work across all implementations.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d3087829a6df..91add0751aa5 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -353,7 +353,8 @@ static inline dma_addr_t dma_map_resource(struct device *dev,
>   	BUG_ON(!valid_dma_direction(dir));
>   
>   	/* Don't allow RAM to be mapped */

Ugh, I'm pretty sure that that "pfn_valid means RAM" misunderstanding 
originally came from me - it might be nice to have a less-misleading 
comment here, but off-hand I can't think of a succinct way to say "only 
for 'DMA' access to MMIO registers/SRAMs/etc. and not for anything the 
kernel knows as actual system/device memory" to better explain the WARN...

Either way, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> -	BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
> +	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> +		return DMA_MAPPING_ERROR;
>   
>   	if (dma_is_direct(ops))
>   		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
> 
