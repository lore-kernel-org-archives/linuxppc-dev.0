Return-Path: <SRS0=MUiv=6C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB751C38A2E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 12:53:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7892321D79
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 12:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7892321D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 494CYR0XNSzDqxL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 22:52:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=8bytes.org (client-ip=81.169.241.247; helo=theia.8bytes.org;
 envelope-from=joro@8bytes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=8bytes.org
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494CVz1yfSzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2020 22:50:49 +1000 (AEST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B57C0342; Sat, 18 Apr 2020 14:42:06 +0200 (CEST)
Date: Sat, 18 Apr 2020 14:42:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200418124205.GD6113@8bytes.org>
References: <20200414122506.438134-1-hch@lst.de>
 <20200414122506.438134-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414122506.438134-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On Tue, Apr 14, 2020 at 02:25:05PM +0200, Christoph Hellwig wrote:
> +static inline bool dma_map_direct(struct device *dev,
> +		const struct dma_map_ops *ops)
> +{
> +	if (likely(!ops))
> +		return true;
> +	if (!dev->dma_ops_bypass)
> +		return false;
> +
> +	return min_not_zero(*dev->dma_mask, dev->bus_dma_limit) >=
> +			    dma_direct_get_required_mask(dev);

Why is the dma-mask check done here? The dma-direct code handles memory
outside of the devices dma-mask with swiotlb, no?

I also don't quite get what the difference between setting the
dma_ops_bypass flag non-zero and setting ops to NULL is.


	Joerg


