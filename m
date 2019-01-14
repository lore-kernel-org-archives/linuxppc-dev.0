Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA39C43612
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:33:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8BF20656
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8BF20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dVDV4b2rzDqPY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 21:33:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dVBl47KgzDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 21:31:42 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 8F14867358; Mon, 14 Jan 2019 11:31:39 +0100 (CET)
Date: Mon, 14 Jan 2019 11:31:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Message-ID: <20190114103139.GA31005@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-4-hch@lst.de> <20190111175416.7d291e25@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111175416.7d291e25@coco.lan>
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
 <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 11, 2019 at 05:54:16PM -0200, Mauro Carvalho Chehab wrote:
> Em Fri, 11 Jan 2019 19:17:31 +0100
> Christoph Hellwig <hch@lst.de> escreveu:
> 
> > vb2_dc_get_userptr pokes into arm direct mapping details to get the
> > resemblance of a dma address for a a physical address that does is
> > not backed by a page struct.  Not only is this not portable to other
> > architectures with dma direct mapping offsets, but also not to uses
> > of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> > dma_unmap_resource interface instead.
> 
> Makes sense to me. I'm assuming that you'll be pushing it together
> with other mm patches, so:

Not really mm, but rather DMA mapping, but yes, I'd love to take it
all together.

Thanks!
