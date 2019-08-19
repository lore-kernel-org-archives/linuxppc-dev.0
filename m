Return-Path: <SRS0=1Kal=WP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78481C3A5A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 14:33:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0224C20651
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 14:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0224C20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BxHP03kyzDqV1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Bx6G55t6zDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2019 00:25:24 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B1550227A81; Mon, 19 Aug 2019 16:25:16 +0200 (CEST)
Date: Mon, 19 Aug 2019 16:25:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Message-ID: <20190819142516.GA6366@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
 <20190808160005.10325-8-hch@lst.de>
 <1565861152.2963.7.camel@HansenPartnership.com>
 <20190815105002.GA30805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815105002.GA30805@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
 Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Does my explanation from Thursday make sense or is it completely
off?  Does the patch description need some update to be less
confusing to those used to different terminology?

On Thu, Aug 15, 2019 at 12:50:02PM +0200, Christoph Hellwig wrote:
> Except for the different naming scheme vs the code this matches my
> assumptions.
> 
> In the code we have three cases (and a fourth EISA case mention in
> comments, but not actually implemented as far as I can tell):
> 
> arch/parisc/kernel/pci-dma.c says in the top of file comments:
> 
> ** AFAIK, all PA7100LC and PA7300LC platforms can use this code.
> 
> and the handles two different case.  for cpu_type == pcxl or pcxl2
> it maps the memory as uncached for dma_alloc_coherent, and for all
> other cpu types it fails the coherent allocations.
> 
> In addition to that there are the ccio and sba iommu drivers, of which
> according to your above comment one is always present for pa8xxx.
> 
> Which brings us back to this patch, which ensures that no cacheable
> memory is exported to userspace by removing ->mmap from ccio and sba.
> It then enabled dma_mmap_coherent for the pcxl or pcxl2 case that
> allocates uncached memory, which dma_mmap_coherent does not work
> because dma_alloc_coherent already failed for the !pcxl && !pcxl2
> and thus there is no memory to mmap.
> 
> So if the description is too confusing please suggest a better
> one, I'm a little lost between all these code names and product
> names (arch/parisc/include/asm/dma-mapping.h uses yet another set).
---end quoted text---
