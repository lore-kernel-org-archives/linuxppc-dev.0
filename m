Return-Path: <SRS0=VIHX=6D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B4C38A30
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2020 12:28:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5C3214AF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2020 12:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5C3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 494pz44PcczDr0T
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2020 22:28:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=8bytes.org (client-ip=2a01:238:4383:600:38bc:a715:4b6d:a889;
 helo=theia.8bytes.org; envelope-from=joro@8bytes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=8bytes.org
X-Greylist: delayed 85366 seconds by postgrey-1.36 at bilbo;
 Sun, 19 Apr 2020 22:25:14 AEST
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494ptz0QynzDr0K
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2020 22:25:12 +1000 (AEST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id EB734342; Sun, 19 Apr 2020 14:25:03 +0200 (CEST)
Date: Sun, 19 Apr 2020 14:25:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200419122502.GI21900@8bytes.org>
References: <20200414122506.438134-1-hch@lst.de>
 <20200414122506.438134-4-hch@lst.de>
 <20200418124205.GD6113@8bytes.org> <20200419080058.GB12222@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419080058.GB12222@lst.de>
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

On Sun, Apr 19, 2020 at 10:00:58AM +0200, Christoph Hellwig wrote:
> The difference is that NULL ops mean imply the direct mapping is always
> used, dma_ops_bypass means a direct mapping is used if no bounce buffering
> using swiotlb is needed, which should also answer your first question.
> The idea is to consolidate code in the core to use an opportunistic
> direct mapping instead of the dynamic iommu mapping.  I though the cover
> letter and commit log explained this well enough, but maybe I need to
> do a better job.

Ah right, now I see it, when dma_ops_bypass is set it will only use
direct mapping when the available memory fits into the device's
dma_masks, and calls into dma_ops otherwise.

I wonder how that will interact with an IOMMU driver, which has to make
sure that the direct mapping is accessible for the device at all.  It
can either put the device into a passthrough domain for direct mapping
or into a re-mapped domain, but then all DMA-API calls need to use dma-ops.
When the dma_mask covers available memory but coherent_mask doesn't,
the streaming calls will use dma-direct and alloc_coherent() calls into
dma-ops. There is no way for the IOMMU driver to ensure both works.

So what are the conditions under which an IOMMU driver would set
dma_ops_bypass to 1 and get a different result as to when setting
dev->dma_ops to NULL?

Regards,

	Joerg
