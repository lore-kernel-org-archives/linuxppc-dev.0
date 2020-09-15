Return-Path: <SRS0=6Pj3=CY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851FC433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 06:52:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A365720829
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 06:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A365720829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BrDS52S0fzDqRm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 16:52:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BrDPx0BqJzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2020 16:50:27 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 424FC6736F; Tue, 15 Sep 2020 08:50:22 +0200 (CEST)
Date: Tue, 15 Sep 2020 08:50:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/dma: Fix dma_map_ops::get_required_mask
Message-ID: <20200915065022.GA19658@lst.de>
References: <20200908015106.79661-1-aik@ozlabs.ru>
 <20200908054416.GA13585@lst.de>
 <94353228-2262-cfa1-7177-7eed2288ca63@ozlabs.ru>
 <20200908121937.GA31559@lst.de>
 <1746dd66810.27bb.1ca38dd7e845b990cd13d431eb58563d@ozlabs.ru>
 <20200909075849.GA12282@lst.de>
 <0a7a992f-ad2e-e76a-7bee-1ed4ed607748@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7a992f-ad2e-e76a-7bee-1ed4ed607748@ozlabs.ru>
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
Cc: Oliver OHalloran <oliveroh@au1.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 09, 2020 at 07:36:04PM +1000, Alexey Kardashevskiy wrote:
> I want dma_get_required_mask() to return the bigger mask always.
> 
> Now it depends on (in dma_alloc_direct()):
> 1. dev->dma_ops_bypass: set via pci_set_(coherent_)dma_mask();
> 2. dev->coherent_dma_mask - the same;
> 3. dev->bus_dma_limit - usually not set at all.
> 
> So until we set the mask, dma_get_required_mask() returns smaller mask.
> So aacraid and likes (which calls dma_get_required_mask() before setting
> it) will remain prone for breaks.

Well, the original intent of dma_get_required_mask is to return the
mask that the driver then uses to figure out what to set, so what aacraid
does fits that use case.  Of course that idea is pretty bogus for
PCIe devices.

I suspect the right fix is to just not query dma_get_required_mask for
PCIe devices in aacraid (and other drivers that do something similar).
