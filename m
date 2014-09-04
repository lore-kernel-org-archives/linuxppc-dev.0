Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E793F1A00FF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 19:43:53 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 061B1140274
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 19:43:52 +1000 (EST)
Message-ID: <1409823823.4246.61.camel@pasglop>
Subject: Re: TTM placement & caching issue/questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 04 Sep 2014 19:43:43 +1000
In-Reply-To: <20140904093454.GG15520@phenom.ffwll.local>
References: <1409789547.30640.136.camel@pasglop>
 <54081844.7000604@vmware.com> <20140904093454.GG15520@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Hellstrom <thellstrom@vmware.com>,
 dri-devel@lists.freedesktop.org, Michel Danzer <daenzer@vmware.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-04 at 11:34 +0200, Daniel Vetter wrote:
> On Thu, Sep 04, 2014 at 09:44:04AM +0200, Thomas Hellstrom wrote:
> > Last time I tested, (and it seems like Michel is on the same track),
> > writing with the CPU to write-combined memory was substantially faster
> > than writing to cached memory, with the additional side-effect that CPU
> > caches are left unpolluted.
> > 
> > Moreover (although only tested on Intel's embedded chipsets), texturing
> > from cpu-cache-coherent PCI memory was a real GPU performance hog
> > compared to texturing from non-snooped memory. Hence, whenever a buffer
> > could be classified as GPU-read-only (or almost at least), it should be
> > placed in write-combined memory.
> 
> Just a quick comment since this explicitly referes to intel chips: On
> desktop/laptop chips with the big shared l3/l4 caches it's the other way
> round. Cached uploads are substantially faster than wc and not using
> coherent access is a severe perf hit for texturing. I guess the hw guys
> worked really hard to hide the snooping costs so that the gpu can benefit
> from the massive bandwidth these caches can provide.

This is similar to modern POWER chips as well. We have pretty big L3's
(though not technically shared they are in a separate quadrant and we
have a shared L4 in the memory buffer) and our fabric is generally
optimized for cachable/coherent access performance. In fact, we only
have so many credits for NC accesses on the bus...

What that tells me is that when setting up the desired cachability
attributes for the mapping of a memory object, we need to consider these
things here:

  - The hard requirement of the HW (non-coherent GPUs require NC, AGP
does in some cases, etc...) which I think is basically already handled
using the placement attributes set by the GPU driver for the memory type

  - The optimal attributes (and platform hard requirements) for fast
memory accesses to an object by the processor.  From what I read here,
this can be NC+WC on older Intel, cachable on newer, etc...)

  - The optimal attributes for fast GPU DMA accesses to the object in
system memory. Here too, this is fairly platform/chipset dependent.

Do we have flags in the DRM that tell us whether an object in memory is
more likely to be used by the GPU via DMA vs by the CPU via MMIO ? On
powerpc (except in the old AGP case), I wouldn't care about require
cachable in both case, but I can see the low latency crowd wanting the
former to be non-cachable while the dumb GPUs like AST who don't do DMA
would benefit greatly from the latter...

Cheers,
Ben.
