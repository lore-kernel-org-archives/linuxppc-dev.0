Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id 7D5C4B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 07:49:54 +1000 (EST)
Received: from mail149-va3 (localhost.localdomain [127.0.0.1])	by
	mail149-va3-R.bigfish.com (Postfix) with ESMTP id E8CB733019B	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 21:49:47 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.243])	by
	mail149-va3.bigfish.com (Postfix) with ESMTP id B734B13A804F	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 21:49:47 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8LLnlbZ026698	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 14:49:47 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8LM4CHa029190	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 17:04:12 -0500 (CDT)
Date: Tue, 21 Sep 2010 16:49:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
Message-ID: <20100921164944.164ed0af@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2010 16:43:12 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Tue, Sep 21, 2010 at 4:34 PM, Scott Wood <scottwood@freescale.com> wrote:
> 
> > This doesn't control allocation (it probably should with
> > dma_alloc_coherent, though I don't see it in the code), it controls
> > whether swiotlb will create a bounce buffer -- defeating the point of
> > using DMA to accelerate a memcpy.
> 
> But it would do that only for the 'dev' used in the dma_set_mask()
> call.  That dev is only used here:
> 
> 	chan->desc_pool = dma_pool_create("fsl_dma_engine_desc_pool",
> 					  chan->dev,
> 					  sizeof(struct fsl_desc_sw),
> 					  __alignof__(struct fsl_desc_sw), 0);
> 
> Since we don't DMA the descriptors themselves, I just don't see how
> this patch does anything.

Look in dmaengine.c, there are calls to dma_map_single() and
dma_map_page(), using what I assume is that same device pointer --
unless there's confusion between the channel and the controller.

-Scott
