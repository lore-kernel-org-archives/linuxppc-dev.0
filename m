Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 598402C0330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 16:06:21 +1000 (EST)
Message-ID: <1343023569.2957.19.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Date: Mon, 23 Jul 2012 16:06:09 +1000
In-Reply-To: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mingkai Hu <Mingkai.hu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Chen Yuanquan <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-07-20 at 20:21 +0800, Shaohui Xie wrote:
> PowerPC platform only supports ZONE_DMA zone for 64bit kernel, so all the
> memory will be put into this zone. If the memory size is greater than
> the device's DMA capability and device uses dma_alloc_coherent to allocate
> memory, it will get an address which is over the device's DMA addressing,
> the device will fail.
> 
> So we split the memory to two zones by adding a zone ZONE_NORMAL, since
> we already allocate PCICSRBAR/PEXCSRBAR right below the 4G boundary (if the
> lowest PCI address is above 4G), so we constrain the DMA zone ZONE_DMA
> to 2GB, also, we clear the flag __GFP_DMA and set it only if the device's
> dma_mask < total memory size. By doing this, devices which cannot DMA all
> the memory will be limited to ZONE_DMA, but devices which can DMA all the
> memory will not be affected by this limitation.

This is wrong. Don't you have an iommu do deal with those devices
anyway ? What about swiotlb ?

If you *really* need to honor 32 (or 31 even) bit DMAs, what you -may-
want to do is create a ZONE_DMA32 like other architectures, do not
hijack the historical ZONE_DMA.

But even then, I'm dubious this is really needed.

Cheers,
Ben.
