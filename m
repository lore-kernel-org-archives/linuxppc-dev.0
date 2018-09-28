Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D89FC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 00:08:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2882172C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 00:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2882172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LsTx53FXzF39K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 10:08:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LsRs14s0zF38s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 10:07:04 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8S06mRi025169;
 Thu, 27 Sep 2018 19:06:49 -0500
Message-ID: <514bd29960cb1573ead2f3956f18e1cbaa5f32f7.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Date: Fri, 28 Sep 2018 10:06:48 +1000
In-Reply-To: <20180927134922.GA8281@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
 <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
 <20180927134922.GA8281@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-09-27 at 15:49 +0200, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 11:45:15AM +1000, Benjamin Herrenschmidt wrote:
> > I'm not sure this is entirely right.
> > 
> > Let's say the mask is 30 bits. You will return GFP_DMA32, which will
> > fail if you allocate something above 1G (which is legit for
> > ZONE_DMA32).
> 
> And then we will try GFP_DMA further down in the function:
> 
> 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> 		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> 		    !(gfp & GFP_DMA)) {
> 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
> 			goto again;
> 		}
> 
> This is and old optimization from x86, because chances are high that
> GFP_DMA32 will give you suitable memory for the infamous 31-bit
> dma mask devices (at least at boot time) and thus we don't have
> to deplete the tiny ZONE_DMA pool.

I see, it's rather confusing :-) Wouldn't it be better to check against
top of 32-bit memory instead here too ?


Cheers,
Ben.

