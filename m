Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DFCC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 17:10:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF77E20659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 17:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF77E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dg326hzmzDqWX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:10:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dg191M3tzDqW5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 04:09:00 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 0861268D93; Mon, 14 Jan 2019 18:08:56 +0100 (CET)
Date: Mon, 14 Jan 2019 18:08:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/3] dma-mapping: remove the default map_resource
 implementation
Message-ID: <20190114170855.GA7485@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-2-hch@lst.de>
 <c882430e-1dbd-df86-d686-0381dcaa668e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c882430e-1dbd-df86-d686-0381dcaa668e@arm.com>
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
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, linux-media@vger.kernel.org,
 Pawel Osciak <pawel@osciak.com>, Russell King <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 14, 2019 at 01:12:33PM +0000, Robin Murphy wrote:
> Ignoring the offset was kind of intentional there, because at the time I 
> was primarily thinking about it in terms of the Keystone 2 platform where 
> the peripherals are all in the same place (0-2GB) in both the bus and CPU 
> physical address maps, and only the view of RAM differs between the two 
> (2-4GB vs. 32-34GB). However, on something like BCM283x, the peripherals 
> region is also offset from its bus address in the CPU view, but at a 
> *different* offset relative to that of RAM.

I was more thinking of the PCIe P2P case, where we need to apply a
consistent offset to translate between the CPU and the bus view.

But this isn't really used for PCIe P2P, so I guess keeping the original
sematics might be a better idea.  That being said the videobuf code seems
to rely on these offsets, so we might be between a rock and a hard place.

> Fortunately, I'm not aware of any platform which has a DMA engine behind an 
> IOMMU (and thus *needs* to use dma_map_resource() to avoid said IOMMU 
> blocking the slave device register reads/writes) and also has any nonzero 
> offsets, and AFAIK the IOMMU-less platforms above aren't using 
> dma_map_resource() at all, so this change shouldn't actually break 
> anything, but I guess we have a bit of a problem making it truly generic 
> and robust :(

Note that we don't actually use the code in this patch for ARM/ARM64
platforms with IOMMUs, as both the ARM and the ARM64 iommu code have
their own implementations of ->map_resource that actually program
the iommu (which at least for the PCIe P2P case would be wrong).

> Is this perhaps another shove in the direction of overhauling 
> dma_pfn_offset into an arbitrary "DMA ranges" lookup table?

It is long overdue anyway.

>>   		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
>
> Might it be reasonable to do:
>
> 	if (!dma_is_direct(ops) && ops->map_resource)
> 		addr = ops->map_resource(...);
> 	else
> 		addr = dma_direct_map_resource(...);
>
> and avoid having to explicitly wire up the dma_direct callback elsewhere?

No, I absolutely _want_ the callback explicitly wired up.  That is the
only way to ensure we actually intentionally support it and don't just
get a default that often won't work.  Same issue for ->mmap and
->get_sgtable.
