Return-Path: <timur.tabi@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id A57FEB70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 07:43:45 +1000 (EST)
Received: by gwj15 with SMTP id 15so2276465gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 14:43:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 21 Sep 2010 16:43:12 -0500
Message-ID: <AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Tue, Sep 21, 2010 at 4:34 PM, Scott Wood <scottwood@freescale.com> wrote:

> This doesn't control allocation (it probably should with
> dma_alloc_coherent, though I don't see it in the code), it controls
> whether swiotlb will create a bounce buffer -- defeating the point of
> using DMA to accelerate a memcpy.

But it would do that only for the 'dev' used in the dma_set_mask()
call.  That dev is only used here:

	chan->desc_pool = dma_pool_create("fsl_dma_engine_desc_pool",
					  chan->dev,
					  sizeof(struct fsl_desc_sw),
					  __alignof__(struct fsl_desc_sw), 0);

Since we don't DMA the descriptors themselves, I just don't see how
this patch does anything.

-- 
Timur Tabi
Linux kernel developer at Freescale
