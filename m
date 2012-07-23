Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 57CD22C0351
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 08:20:40 +1000 (EST)
Message-ID: <1343082030.2957.38.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 24 Jul 2012 08:20:30 +1000
In-Reply-To: <500D7921.6060804@freescale.com>
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop> <500D7921.6060804@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mingkai Hu <Mingkai.hu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Chen Yuanquan <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 11:17 -0500, Scott Wood wrote:
> > This is wrong.
> 
> How so?
> 
> > Don't you have an iommu do deal with those devices anyway ?
> 
> Yes, but we don't yet have DMA API support for it, it would lower
> performance because we'd have to use a lot of subwindows which are
> poorly cached (and even then we wouldn't be able to map more than 256
> pages at once on a given device), and the IOMMU may not be available at
> all if we're being virtualized.

Ugh ? You mean some designers need to be fired urgently and wasted
everybody's time implementing an unusable iommu ? Nice one ...

> > What about swiotlb ?
> 
> That doesn't help with alloc_coherent().

Somewhat... you can use the pool, but it sucks.

> > If you *really* need to honor 32 (or 31 even) bit DMAs,
> 
> 31-bit is to accommodate PCI, which has PEXCSRBAR that must live under 4
> GiB and can't be disabled.
> 
> > what you -may- want to do is create a ZONE_DMA32 like other architectures, do not
> > hijack the historical ZONE_DMA.
> 
> Could you point me to somewhere that clearly defines what ZONE_DMA is to
> be used for, such that this counts as hijacking (but using ZONE_DMA32 to
> mean 31-bit wouldn't)?

Habit and history. ZONE_DMA used to be about ISA DMA, doesn't apply to
us, and in general ZONE_NORMAL alias to it iirc. It's old stuff I
haven't looked for a long time.

However, my understanding is that what you are trying to solve is
exactly what ZONE_DMA32 was created for.

>   The only arches I see using ZONE_DMA32 (x86 and
> mips) also have a separate, more restrictive ZONE_DMA.

And ? Who cares ? Drivers who know about a 32-bit limitations use
GFP_DMA32, that's what is expected, don't mess around with ZONE_DMA.

>   PowerPC doesn't.
>  It uses ZONE_DMA to point to all of memory (except highmem on 32-bit)
> -- how is that not hijacking, if this is?  We can't have ZONE_DMA be
> less restrictive than ZONE_DMA32, because the fallback rules are
> hardcoded the other way around in generic code.
> 
> The exact threshold for ZONE_DMA could be made platform-configurable.
> 
> > But even then, I'm dubious this is really needed.
> 
> We'd like our drivers to stop crashing with more than 4GiB of RAM on 64-bit.

Fix your HW :-)

Cheers,
Ben.
