Return-Path: <SRS0=to3W=WL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EEFC31E40
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 10:52:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C13208C2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 10:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C13208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468NYq4S4WzDr7h
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 20:51:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468NWq4kr8zDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 20:50:13 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9FC9468AFE; Thu, 15 Aug 2019 12:50:03 +0200 (CEST)
Date: Thu, 15 Aug 2019 12:50:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Message-ID: <20190815105002.GA30805@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
 <20190808160005.10325-8-hch@lst.de>
 <1565861152.2963.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565861152.2963.7.camel@HansenPartnership.com>
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

On Thu, Aug 15, 2019 at 10:25:52AM +0100, James Bottomley wrote:
> >  which means exporting normally cachable memory to userspace is
> > relatively dangrous due to cache aliasing.
> > 
> > But normally cachable memory is only allocated by dma_alloc_coherent
> > on parisc when using the sba_iommu or ccio_iommu drivers, so just
> > remove the .mmap implementation for them so that we don't have to set
> > ARCH_NO_COHERENT_DMA_MMAP, which I plan to get rid of.
> 
> So I don't think this is quite right.  We have three architectural
> variants essentially (hidden behind about 12 cpu types):
> 
>    1. pa70xx: These can't turn off page caching, so they were the non
>       coherent problem case
>    2. pa71xx: These can manufacture coherent memory simply by turning off
>       the cache on a per page basis
>    3. pa8xxx: these have a full cache flush coherence mechanism.
> 
> (I might have this slightly wrong: I vaguely remember the pa71xxlc
> variants have some weird cache quirks for DMA as well)
> 
> So I think pa70xx we can't mmap.  pa71xx we can provided we mark the
> page as uncached ... which should already have happened in the allocate
> and pa8xxx which can always mmap dma memory without any special tricks.

Except for the different naming scheme vs the code this matches my
assumptions.

In the code we have three cases (and a fourth EISA case mention in
comments, but not actually implemented as far as I can tell):

arch/parisc/kernel/pci-dma.c says in the top of file comments:

** AFAIK, all PA7100LC and PA7300LC platforms can use this code.

and the handles two different case.  for cpu_type == pcxl or pcxl2
it maps the memory as uncached for dma_alloc_coherent, and for all
other cpu types it fails the coherent allocations.

In addition to that there are the ccio and sba iommu drivers, of which
according to your above comment one is always present for pa8xxx.

Which brings us back to this patch, which ensures that no cacheable
memory is exported to userspace by removing ->mmap from ccio and sba.
It then enabled dma_mmap_coherent for the pcxl or pcxl2 case that
allocates uncached memory, which dma_mmap_coherent does not work
because dma_alloc_coherent already failed for the !pcxl && !pcxl2
and thus there is no memory to mmap.

So if the description is too confusing please suggest a better
one, I'm a little lost between all these code names and product
names (arch/parisc/include/asm/dma-mapping.h uses yet another set).
