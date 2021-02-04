Return-Path: <SRS0=TUcR=HG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 08:42:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0ED64F3E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 08:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0ED64F3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DWX9S2qvBzDwhD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 19:42:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DWX7L1V04zDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2021 19:40:29 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 77E4067373; Thu,  4 Feb 2021 09:40:23 +0100 (CET)
Date: Thu, 4 Feb 2021 09:40:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH RFC v1 5/6] xen-swiotlb: convert variables to arrays
Message-ID: <20210204084023.GA32328@lst.de>
References: <20210203233709.19819-1-dongli.zhang@oracle.com>
 <20210203233709.19819-6-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203233709.19819-6-dongli.zhang@oracle.com>
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
Cc: ulf.hansson@linaro.org, airlied@linux.ie, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, paulus@samba.org, hpa@zytor.com, hch@lst.de,
 m.szyprowski@samsung.com, sstabellini@kernel.org, adrian.hunter@intel.com,
 x86@kernel.org, joe.jin@oracle.com, mingo@kernel.org, peterz@infradead.org,
 mingo@redhat.com, bskeggs@redhat.com, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, matthew.auld@intel.com,
 thomas.lendacky@amd.com, konrad.wilk@oracle.com,
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, bp@alien8.de,
 rodrigo.vivi@intel.com, nouveau@lists.freedesktop.org,
 boris.ostrovsky@oracle.com, chris@chris-wilson.co.uk, jgross@suse.com,
 tsbogend@alpha.franken.de, robin.murphy@arm.com, linux-mmc@vger.kernel.org,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
 tglx@linutronix.de, bauerman@linux.ibm.com, daniel@ffwll.ch,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, rppt@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

So one thing that has been on my mind for a while:  I'd really like
to kill the separate dma ops in Xen swiotlb.  If we compare xen-swiotlb
to swiotlb the main difference seems to be:

 - additional reasons to bounce I/O vs the plain DMA capable
 - the possibility to do a hypercall on arm/arm64
 - an extra translation layer before doing the phys_to_dma and vice
   versa
 - an special memory allocator

I wonder if inbetween a few jump labels or other no overhead enablement
options and possibly better use of the dma_range_map we could kill
off most of swiotlb-xen instead of maintaining all this code duplication?
