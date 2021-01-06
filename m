Return-Path: <SRS0=DrE0=GJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE7C433E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Jan 2021 07:52:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F212A2070C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Jan 2021 07:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F212A2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D9hR72gYBzDqdL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Jan 2021 18:52:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=STtQBirT; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D9hNh2RcMzDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2021 18:50:10 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7129D2070C;
 Wed,  6 Jan 2021 07:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1609919407;
 bh=Piu5gusr/UGLicaCqANy6GNdwM1M9LXLgq30KLvh2D4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=STtQBirTvMJHJfy3BDpBJr1nF4y3j9P09tA52QukFa2+zVDJOvZxlpH0YuQb1dKaI
 tkZ/1YHajtxpOZBb2tYYK9x5sW39V1FMN5v9MY2fd4frFWPosjKHysaj5P3pqOj5H4
 cLt1ndn2T4gOT+l7NViKlEBYi94u2sh/OTHke2vk=
Date: Wed, 6 Jan 2021 08:50:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Message-ID: <X/VrqxcaAMi65CF0@kroah.com>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-3-tientzu@chromium.org>
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
 dan.j.williams@intel.com, robh+dt@kernel.org, boris.ostrovsky@oracle.com,
 andriy.shevchenko@linux.intel.com, jgross@suse.com, drinkcat@chromium.org,
 linuxppc-dev@lists.ozlabs.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 iommu@lists.linux-foundation.org, xypron.glpk@gmx.de, robin.murphy@arm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 06, 2021 at 11:41:20AM +0800, Claire Chang wrote:
> Add the initialization function to create restricted DMA pools from
> matching reserved-memory nodes in the device tree.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  include/linux/device.h  |   4 ++
>  include/linux/swiotlb.h |   7 +-
>  kernel/dma/Kconfig      |   1 +
>  kernel/dma/swiotlb.c    | 144 ++++++++++++++++++++++++++++++++++------
>  4 files changed, 131 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 89bb8b84173e..ca6f71ec8871 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -413,6 +413,7 @@ struct dev_links_info {
>   * @dma_pools:	Dma pools (if dma'ble device).
>   * @dma_mem:	Internal for coherent mem override.
>   * @cma_area:	Contiguous memory area for dma allocations
> + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.

Why does this have to be added here?  Shouldn't the platform-specific
code handle it instead?

thanks,

greg k-h
