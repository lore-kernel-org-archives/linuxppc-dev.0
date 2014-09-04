Return-Path: <thellstrom@vmware.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 184941A015B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 17:56:30 +1000 (EST)
Received: from smtp-outbound-2.vmware.com (smtp-outbound-2.vmware.com
 [208.91.2.13])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 761A81401F6
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 17:56:28 +1000 (EST)
Message-ID: <54081844.7000604@vmware.com>
Date: Thu, 4 Sep 2014 09:44:04 +0200
From: Thomas Hellstrom <thellstrom@vmware.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: TTM placement & caching issue/questions
References: <1409789547.30640.136.camel@pasglop>
In-Reply-To: <1409789547.30640.136.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Jerome Glisse <j.glisse@gmail.com>, linuxppc-dev@ozlabs.org,
 Michel Danzer <daenzer@vmware.com>, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

Let me try to bring some clarity and suggestions into this.

On 09/04/2014 02:12 AM, Benjamin Herrenschmidt wrote:
> Hi folks !
>
> I've been tracking down some problems with the recent DRI on powerpc and
> stumbled upon something that doesn't look right, and not necessarily
> only for us.
>
> Now it's possible that I haven't fully understood the code here and I
> also don't know to what extent some of that behaviour is necessary for
> some platforms such as Intel GTT bits.
>
> What I've observed with a simple/dumb (no DMA) driver like AST (but this
> probably happens more generally) is that when evicting a BO from VRAM
> into System memory, the TTM tries to preserve the existing caching
> attributes of the VRAM object.
>
> >From what I can tell, we end up with going from VRAM to System memory
> type, and we eventually call ttm_bo_select_caching() to select the
> caching option for the target.
>
> This will, from what I can tell, try to use the same caching mode as the
> original object:
>
> 	if ((cur_placement & caching) != 0)
> 		result |= (cur_placement & caching);
>
> And cur_placement comes from bo->mem.placement which as far as I can
> tell is based on the placement array which the drivers set up.

This originates from the fact that when evicting GTT memory, on x86 it's
unnecessary and undesirable to switch caching mode when going to system.

>
> Now they tend to uniformly setup the placement for System memory as
> TTM_PL_MASK_CACHING which enables all caching modes.
>
> So I end up with, for example, my System memory BOs having
> TTM_PL_FLAG_CACHED not set (though they also don't have
> TTM_PL_FLAG_UNCACHED) and TTM_PL_FLAG_WC.
>
> We don't seem to use the man->default_caching (which will have
> TTM_PL_FLAG_CACHED) unless there is no matching bit at all between the
> proposed placement and the existing caching mode.
>
> Now this is a problem for several reason that I can think of:
>
>  - On a number of powerpc platforms, such as all our server 64-bit one
> for example, it's actually illegal to map system memory non-cached. The
> system is fully cache coherent for all possible DMA originators (that we
> care about at least) and mapping memory non-cachable while it's mapped
> cachable in the linear mapping can cause nasty cache paradox which, when
> detected by HW, can checkstop the system.
>
>  - A similar issue exists, afaik, on ARM >= v7, so anything mapped
> non-cachable must be removed from the linear mapping explicitly since
> otherwise it can be speculatively prefetched into the cache.
>
>  - I don't know about x86, but even then, it looks quite sub-optimal to
> map the memory backing of the BOs and access it using a WC rather than a
> cachable mapping attribute.

Last time I tested, (and it seems like Michel is on the same track),
writing with the CPU to write-combined memory was substantially faster
than writing to cached memory, with the additional side-effect that CPU
caches are left unpolluted.

Moreover (although only tested on Intel's embedded chipsets), texturing
from cpu-cache-coherent PCI memory was a real GPU performance hog
compared to texturing from non-snooped memory. Hence, whenever a buffer
could be classified as GPU-read-only (or almost at least), it should be
placed in write-combined memory.

>
> Now, some folks on IRC mentioned that there might be reasons for the
> current behaviour as to not change the caching attributes when going
> in/out of the GTT on Intel, I don't know how that relates and how that
> works, but maybe that should be enforced by having a different placement
> mask specifically on those chipsets.
>
> Dave, should we change the various PCI drivers for generally coherent
> devices such that the System memory type doesn't allow placements
> without CACHED attribute ? Or at least on coherent platforms ? How do
> detect that ? Should we have a TTM helper to establish the default
> memory placement attributes that "normal PCI" drivers call to set that
> up so we can have all the necessary arch ifdefs in one single place, at
> least for "classic PCI/PCIe" stuff (AGP might need additional tweaks) ?
>
> Non-PCI and "special" drivers like Intel can use a different set of
> placement attributes to represent the requirements of those specific
> platforms (mostly thinking of embedded ARM here which under some
> circumstances might actually require non-cached mappings).
> Or am I missing another part of the puzzle ?
>
> As it-is, things are broken for me even for dumb drivers, and I suspect
> to a large extent with radeon and nouveau too, though in some case we
> might get away with it most of the time ... until the machine locks up
> for some unexplainable reason... This might cause problems on existing
> distros such as RHEL7 with our radeon adapters even.
>
> Any suggestion of what's the best approach to fix it ? I'm happy to
> produce the patches but I'm not that familiar with the TTM so I would
> like to make sure I'm the right track first :-)

I dislike the approach of rewriting placements. In some cases I think it
won't even work, because placements are declared 'static const'

What I'd suggest is instead to intercept the driver response from
init_mem_type() and filter out undesired caching modes from
available_caching and default_caching, perhaps also looking at whether
the memory type is mappable or not. This should have the additional
benefit of working everywhere, and if a caching mode is selected that's
not available on the platform, you'll simply get an error. (I guess?)

/Thomas


>
> Cheers,
> Ben.
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
