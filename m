Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440FC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:48:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB79204FD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB79204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MGLB4pWdzF3G0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 01:48:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MGHp6ZXNzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 01:46:30 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id A299267358; Fri, 28 Sep 2018 17:46:26 +0200 (CEST)
Date: Fri, 28 Sep 2018 17:46:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Message-ID: <20180928154626.GA10234@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
 <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
 <20180927134922.GA8281@lst.de>
 <514bd29960cb1573ead2f3956f18e1cbaa5f32f7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514bd29960cb1573ead2f3956f18e1cbaa5f32f7.camel@kernel.crashing.org>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 28, 2018 at 10:06:48AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2018-09-27 at 15:49 +0200, Christoph Hellwig wrote:
> > On Thu, Sep 27, 2018 at 11:45:15AM +1000, Benjamin Herrenschmidt wrote:
> > > I'm not sure this is entirely right.
> > > 
> > > Let's say the mask is 30 bits. You will return GFP_DMA32, which will
> > > fail if you allocate something above 1G (which is legit for
> > > ZONE_DMA32).
> > 
> > And then we will try GFP_DMA further down in the function:
> > 
> > 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> > 		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> > 		    !(gfp & GFP_DMA)) {
> > 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
> > 			goto again;
> > 		}
> > 
> > This is and old optimization from x86, because chances are high that
> > GFP_DMA32 will give you suitable memory for the infamous 31-bit
> > dma mask devices (at least at boot time) and thus we don't have
> > to deplete the tiny ZONE_DMA pool.
> 
> I see, it's rather confusing :-) Wouldn't it be better to check against
> top of 32-bit memory instead here too ?

Where is here?  In __dma_direct_optimal_gfp_mask we already handled
it due to the optimistic zone selection we are discussing.

In the fallback quoted above there is no point for it, as with a
physical memory size smaller than ZONE_DMA32 (or ZONE_DMA for that matter)
we will have succeeded with the optimistic zone selection and not hit
the fallback path.

Either way this code probably needs much better comments.  I'll send
a patch on top of the recent series.
