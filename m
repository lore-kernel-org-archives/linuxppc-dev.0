Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8AB66B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 21:18:10 +1000 (EST)
Message-ID: <1334747877.3143.12.camel@pasglop>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Wed, 18 Apr 2012 21:17:57 +1000
In-Reply-To: <1334745292.5989.291.camel@thor.local>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <1334744414.3143.2.camel@pasglop> <1334745292.5989.291.camel@thor.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, o jordan <ojordan12345@hotmail.co.uk>,
 Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-18 at 12:34 +0200, Michel Dänzer wrote:
> On Mit, 2012-04-18 at 20:20 +1000, Benjamin Herrenschmidt wrote: 
> > On Wed, 2012-04-18 at 10:02 +0200, Michel Dänzer wrote:
> > > 
> > > > GPU lockup appears to be a common problem with the radeon driver.
> > > 
> > > It's what happens when anything goes wrong with the GPU. If it doesn't
> > > happen with agpmode=-1, it's probably an AGP related coherency issue. 
> > 
> > I had some success hacking the DRM to do an in_le32 from the ring head
> > after writing it. Just a gross hack but it seemed to help on a G5.
> 
> AFAICT radeon_ring_commit() does that already:
> 
>         DRM_MEMORYBARRIER();
>         WREG32(ring->wptr_reg, (ring->wptr << ring->ptr_reg_shift) & ring->ptr_reg_mask);
>         (void)RREG32(ring->wptr_reg);
> 
> We added the readback about a decade ago. :)

Hrm, I have a different hack in that old tree I was playing with a while
back, let me see...

--- a/drivers/gpu/drm/radeon/radeon_cp.c
+++ b/drivers/gpu/drm/radeon/radeon_cp.c
@@ -2245,6 +2245,9 @@ void radeon_commit_ring(drm_radeon_private_t
*dev_priv)
        DRM_MEMORYBARRIER();
        GET_RING_HEAD( dev_priv );
 
+#ifdef CONFIG_PPC
+       in_be32(dev_priv->ring.start);
+#endif
        if ((dev_priv->flags & RADEON_FAMILY_MASK) >= CHIP_R600) {


I think that my rational was to ensure that all previous stores to
AGP (indirect buffers etc...) were pushed out & ordered vs the ring
wptr update or something like that, bcs I think those path aren't well
ordered in HW. In fact I suspect we might even need a bigger hammer than
that in_be32().

Another hack I had around was removing the SBA reset from agp-uninorth
completely on binding new pages, it seemed to cause hangs.

> > I suspect there's a fundamental design issue with apple bridge in that
> > the CPU to memory path isn't coherent at all with the GPU to memory path
> > ie. even vs. cache flush instructions (ie buffers in the memory
> > controllers can still be out of sync).
> > 
> > Darwin does some gross hacks to work around that, some of them visible
> > in the AGP drivers, some burried in the Apple driver, I don't know for
> > sure. It's possible that they end up mapping all AGP memory as cache
> > inhibited, but we can't do that because of our linear mapping.
> 
> We are doing that though...

Are we really ? I thought we were taking existing cachable RAM objects
and mapping them into the AGP gart. Are we replacing both kernel & user
mappings for those objects with an equivalent cache inhibited mapping ?

I'm not -that- familiar with how ttm works here. In any case it can
cause bus checkstops because the same pages can be prefetched into the
cache via the linear mapping which is covered by BATs (unless you make
your graphic objects HIGHMEM only but good luck with that :-)

To make that work reliably we should disable the BAT mapping so the
linear mapping can then be controlled on a per-page basis (on 32-bit)
and this is complicated .... we have code that more/less relies on the
BAT mapping being there elsewhere. On 64-bit it's even nastier because
we use 16M pages for the linear mapping.

Cheers,
Ben.
