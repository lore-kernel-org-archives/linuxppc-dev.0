Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryT2l3d2vzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:35:43 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so10696854pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:35:43 -0700 (PDT)
Date: Mon, 25 Jul 2016 14:35:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: implement a slice mask cache
Message-ID: <20160725143534.78bbf834@roar.ozlabs.ibm.com>
In-Reply-To: <20160723103642.GB13796@350D>
References: <1469192248-25141-1-git-send-email-npiggin@gmail.com>
 <20160723021937.GA13796@350D>
 <20160723171036.67144c5d@roar.ozlabs.ibm.com>
 <20160723103642.GB13796@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 23 Jul 2016 20:36:42 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On Sat, Jul 23, 2016 at 05:10:36PM +1000, Nicholas Piggin wrote:
> > On Sat, 23 Jul 2016 12:19:37 +1000
> > Balbir Singh <bsingharora@gmail.com> wrote:
> >   
> > > On Fri, Jul 22, 2016 at 10:57:28PM +1000, Nicholas Piggin wrote:  
> > > > Calculating the slice mask can become a signifcant overhead for
> > > > get_unmapped_area. The mask is relatively small and does not
> > > > change frequently, so we can cache it in the mm context.
> > > > 
> > > > This saves about 30% kernel time on a 4K user address allocation
> > > > in a microbenchmark.
> > > > 
> > > > Comments on the approach taken? I think there is the option for
> > > > fixed allocations to avoid some of the slice calculation
> > > > entirely, but first I think it will be good to have a general
> > > > speedup that covers all mmaps.
> > > > 
> > > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > Cc: Anton Blanchard <anton@samba.org>
> > > > ---
> > > >  arch/powerpc/include/asm/book3s/64/mmu.h |  8 +++++++
> > > >  arch/powerpc/mm/slice.c                  | 39
> > > > ++++++++++++++++++++++++++++++-- 2 files changed, 45
> > > > insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h
> > > > b/arch/powerpc/include/asm/book3s/64/mmu.h index
> > > > 5854263..0d15af4 100644 ---
> > > > a/arch/powerpc/include/asm/book3s/64/mmu.h +++
> > > > b/arch/powerpc/include/asm/book3s/64/mmu.h @@ -71,6 +71,14 @@
> > > > typedef struct { #ifdef CONFIG_PPC_MM_SLICES
> > > >  	u64 low_slices_psize;	/* SLB page size
> > > > encodings */ unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
> > > > +	struct slice_mask mask_4k;
> > > > +# ifdef CONFIG_PPC_64K_PAGES
> > > > +	struct slice_mask mask_64k;
> > > > +# endif
> > > > +# ifdef CONFIG_HUGETLB_PAGE
> > > > +	struct slice_mask mask_16m;
> > > > +	struct slice_mask mask_16g;
> > > > +# endif    
> > > 
> > > Should we cache these in mmu_psize_defs? I am not 100% sure
> > > if want to overload that structure, but it provides a convient
> > > way of saying mmu_psize_defs[psize].mask instead of all
> > > the if checks  
> > 
> > I'm not sure if we can, can we? mmu_psize_defs is global
> > whereas we need per-process structure.
> >  
> 
> Oh! sorry, I meant a structure like mmu_psize_defs.

In that case, sure. Avoiding the branches might be worthwhile.


> > The branches are a bit annoying, but we can't directly use an array
> > because it's too big. But see the comment at MMU_PAGE_* defines.
> > Perhaps we could change this structure to be sized at compile time
> > to only include possible page sizes, and would enable building a
> > structure like the above with simply
> > 
> > struct type blah[MMU_POSSIBLE_PAGE_COUNT];
> > 
> > Perhaps we can consider that as a follow on patch? It's probably a
> > bit more work to implement.
> >   
> 
> 
> Yeah.. good idea
> MMU_PAGE_COUNT is 15, the size is going to be 15*8 bytes?

Unfortunately, slice_mask is 16 bytes. Only 10 are used, but it
seemed too ugly to try squashing things together.


> > Good question. The slice_convert_lock is... interesting. It only
> > protects the update-side of the slice page size arrays. I thought
> > this was okay last time I looked, but now you make me think again
> > maybe it is not. I need to check again what's providing exclusion
> > on the read side too.
> > 
> > I wanted to avoid doing more work under slice_convert_lock, but
> > we should just make that a per-mm lock anyway shouldn't we?
> >  
> 
> Yeah and Ben's comment in the reply suggest we already hold a
> per mm lock on the read side.

Let's discuss this further in my reply to Ben.

Thanks,
Nick
