Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE113C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 11:28:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DCC20877
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 11:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DCC20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QrH02tTdzF3JY
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 21:28:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42QrDN45xbzF3Jm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:25:54 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505D37A9;
 Thu,  4 Oct 2018 04:25:50 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 036B03F5A0;
 Thu,  4 Oct 2018 04:25:48 -0700 (PDT)
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 iommu@lists.linux-foundation.org
References: <20181003234746.3586.42014.stgit@localhost.localdomain>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
Date: Thu, 4 Oct 2018 12:25:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003234746.3586.42014.stgit@localhost.localdomain>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04/10/18 00:48, Alexander Duyck wrote:
> It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
> <= physiscal memory size") the logic of the test was changed from a "<" to
> a ">=" however I don't see any reason for that change. I am assuming that
> there was some additional change planned, specifically I suspect the logic
> was intended to be reversed and possibly used for a return. Since that is
> the case I have gone ahead and done that.

Bah, seems I got hung up on the min_mask code above it and totally 
overlooked that the condition itself got flipped. It probably also can't 
help that it's an int return type, but treated as a bool by callers 
rather than "0 for success" as int tends to imply in isolation.

Anyway, paying a bit more attention this time, I think this looks like 
the right fix - cheers Alex.

Robin.

> This addresses issues I had on my system that prevented me from booting
> with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.
> 
> Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>   kernel/dma/direct.c |    4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5a0806b5351b..65872f6c2e93 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>   
>   	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
>   
> -	if (mask >= phys_to_dma(dev, min_mask))
> -		return 0;
> -	return 1;
> +	return mask >= phys_to_dma(dev, min_mask);
>   }
>   
>   int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
