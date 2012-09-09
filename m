Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA0E42C0089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 09:38:01 +1000 (EST)
Message-ID: <1347233868.2385.128.camel@pasglop>
Subject: Re: [PATCH][v2] powerpc/mm: using two zones for freescale 64 bit
 kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 10 Sep 2012 09:37:48 +1000
In-Reply-To: <9EADE983-F25D-41BC-8A04-E69A20BF68E3@kernel.crashing.org>
References: <1345805425-3829-1-git-send-email-Shaohui.Xie@freescale.com>
 <9EADE983-F25D-41BC-8A04-E69A20BF68E3@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mingkai Hu <Mingkai.hu@freescale.com>, "linuxppc-dev@lists.ozlabs.org
 list" <linuxppc-dev@lists.ozlabs.org>, Shaohui Xie <Shaohui.Xie@freescale.com>,
 Chen Yuanquan <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-30 at 15:49 -0500, Kumar Gala wrote:
> On Aug 24, 2012, at 5:50 AM, Shaohui Xie wrote:
> 
> > PowerPC platform only supports ZONE_DMA zone for 64bit kernel, so all the
> > memory will be put into this zone. If the memory size is greater than
> > the device's DMA capability and device uses dma_alloc_coherent to allocate
> > memory, it will get an address which is over the device's DMA addressing,
> > the device will fail.
> > 
> > So we split the memory to two zones: zone ZONE_DMA32 & ZONE_NORMAL, since
> > we already allocate PCICSRBAR/PEXCSRBAR right below the 4G boundary (if the
> > lowest PCI address is above 4G), so we constrain the DMA zone ZONE_DMA32
> > to 2GB, also, we clear flag __GFP_DMA & __GFP_DMA32 and set __GFP_DMA32 only
> > if the device's dma_mask < total memory size. By doing this, devices which
> > cannot DMA all the memory will be limited to ZONE_DMA32, but devices which
> > can DMA all the memory will not be affected by this limitation.
> > 
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > Signed-off-by: Chen Yuanquan <B41889@freescale.com>
> > ---
> > changes for v2:
> > 1. use a config option for using two zones (ZONE_DMA32 & ZONE_NORMAL) in
> > freescale 64 bit kernel.
> > 

There must have been a misunderstanding. I think this should be a
runtime choice, possibly by the platform code. Any reason that can't be
done ?

Also how does Intel do it ? Do they have iommu and ZONE_DMA32 co-exist ?

Cheers,
Ben.
