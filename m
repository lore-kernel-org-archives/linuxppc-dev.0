Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C713C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:52:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA91C2183F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA91C2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W4Tg3qRvzDqQh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 01:52:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44W4RZ5RDDzDqH5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:50:41 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEE4A78;
 Fri, 29 Mar 2019 07:50:38 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F028C3F557;
 Fri, 29 Mar 2019 07:50:36 -0700 (PDT)
Subject: Re: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
To: laurentiu.tudor@nxp.com, netdev@vger.kernel.org, madalin.bucur@nxp.com,
 roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
Date: Fri, 29 Mar 2019 14:50:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329140014.8126-3-laurentiu.tudor@nxp.com>
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
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 29/03/2019 14:00, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Add a one-to-one iommu mapping for bman private data memory (FBPR).
> This is required for BMAN to work without faults behind an iommu.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index 7c3cc968053c..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -29,6 +29,7 @@
>    */
>   
>   #include "bman_priv.h"
> +#include <linux/iommu.h>
>   
>   u16 bman_ip_rev;
>   EXPORT_SYMBOL(bman_ip_rev);
> @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>   	int ret, err_irq;
>   	struct device *dev = &pdev->dev;
>   	struct device_node *node = dev->of_node;
> +	struct iommu_domain *domain;
>   	struct resource *res;
>   	u16 id, bm_pool_cnt;
>   	u8 major, minor;
> @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device *pdev)
>   
>   	dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
>   
> +	/* Create an 1-to-1 iommu mapping for FBPR area */
> +	domain = iommu_get_domain_for_dev(dev);

If that's expected to be the default domain that you're grabbing, then 
this is *incredibly* fragile. There's nothing to stop the IOVA that you 
forcibly map from being automatically allocated later and causing some 
other DMA mapping to fail noisily and unexpectedly. Furthermore, have 
you tried this with "iommu.passthrough=1"?

That said, I really don't understand what's going on here anyway :/

As far as I can tell from qbman_init_private_mem(), fbpr_a comes from 
dma_alloc_coherent() and thus would already be a mapped IOVA - isn't 
this the stuff that Roy converted to nicely use shared-dma-pool regions 
a while ago?

Robin.

> +	if (domain) {
> +		ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> +		if (ret)
> +			dev_warn(dev, "failed to iommu_map() %d\n", ret);
> +	}
> +
>   	bm_set_memory(fbpr_a, fbpr_sz);
>   
>   	err_irq = platform_get_irq(pdev, 0);
> 
