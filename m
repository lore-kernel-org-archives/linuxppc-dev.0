Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xbwZX0dm4zDrJV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 13:11:48 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, clombard@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] powerpc/mm: Add marker for contexts requiring
 global TLB invalidations
Date: Tue, 22 Aug 2017 13:11:47 +1000
Message-ID: <2909611.I3R1v22EFs@new-mexico>
In-Reply-To: <CAKTCnzk-+UN56QJg9gtCP61nzFb1LL12mZ4gDvaNWLOL_cJT3Q@mail.gmail.com>
References: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
 <20170802202930.5616-2-fbarrat@linux.vnet.ibm.com>
 <CAKTCnzk-+UN56QJg9gtCP61nzFb1LL12mZ4gDvaNWLOL_cJT3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For what it's worth this worked fine when testing with the NPU as well.

Tested-by: Alistair Popple <alistair@popple.id.au>

On Thu, 3 Aug 2017 05:16:35 PM Balbir Singh wrote:
> On Thu, Aug 3, 2017 at 6:29 AM, Frederic Barrat
> <fbarrat@linux.vnet.ibm.com> wrote:
> > Introduce a new 'flags' attribute per context and define its first bit
> > to be a marker requiring all TLBIs for that context to be broadcasted
> > globally. Once that marker is set on a context, it cannot be removed.
> >
> > Such a marker is useful for memory contexts used by devices behind the
> > NPU and CAPP/PSL. The NPU and the PSL keep their own translation cache
> > so they need to see all the TLBIs for those contexts.
> >
> > Rename mm_is_thread_local() to mm_is_invalidation_local() to better
> > describe what it's doing.
> 
> mm_is_tlb_local? Just nitpicking
> 
> >
> > Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu.h | 18 ++++++++++++++++++
> >  arch/powerpc/include/asm/tlb.h           | 27 +++++++++++++++++++++++----
> >  arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
> >  arch/powerpc/mm/tlb-radix.c              |  8 ++++----
> >  arch/powerpc/mm/tlb_hash64.c             |  3 ++-
> >  5 files changed, 48 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> > index 5b4023c616f7..03d4515ecfa6 100644
> > --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> > +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> > @@ -79,8 +79,12 @@ struct spinlock;
> >  /* Maximum possible number of NPUs in a system. */
> >  #define NV_MAX_NPUS 8
> >
> > +/* Bits definition for the context flags */
> > +#define MM_GLOBAL_TLBIE        0       /* TLBI must be global */
> > +
> >  typedef struct {
> >         mm_context_id_t id;
> > +       unsigned long flags;
> >         u16 user_psize;         /* page size index */
> >
> >         /* NPU NMMU context */
> > @@ -165,5 +169,19 @@ extern void radix_init_pseries(void);
> >  static inline void radix_init_pseries(void) { };
> >  #endif
> >
> > +/*
> > + * Mark the memory context as requiring global TLBIs, when used by
> > + * GPUs or CAPI accelerators managing their own TLB or ERAT.
> > + */
> > +static inline void mm_context_set_global_tlbi(mm_context_t *ctx)
> > +{
> > +       set_bit(MM_GLOBAL_TLBIE, &ctx->flags);
> > +}
> > +
> > +static inline bool mm_context_get_global_tlbi(mm_context_t *ctx)
> > +{
> > +       return test_bit(MM_GLOBAL_TLBIE, &ctx->flags);
> > +}
> > +
> >  #endif /* __ASSEMBLY__ */
> >  #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
> > diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> > index 609557569f65..f06dcac82097 100644
> > --- a/arch/powerpc/include/asm/tlb.h
> > +++ b/arch/powerpc/include/asm/tlb.h
> > @@ -69,10 +69,29 @@ static inline int mm_is_core_local(struct mm_struct *mm)
> >                               topology_sibling_cpumask(smp_processor_id()));
> >  }
> >
> > -static inline int mm_is_thread_local(struct mm_struct *mm)
> > +static inline int mm_is_invalidation_local(struct mm_struct *mm)
> >  {
> > -       return cpumask_equal(mm_cpumask(mm),
> > -                             cpumask_of(smp_processor_id()));
> > +       int rc;
> > +
> > +       rc = cpumask_equal(mm_cpumask(mm),
> > +                       cpumask_of(smp_processor_id()));
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > +       if (rc) {
> > +               /*
> > +                * Check if context requires global TLBI.
> > +                *
> > +                * We need to make sure the PTE update is happening
> > +                * before reading the context global flag. Otherwise,
> > +                * reading the flag may be re-ordered and happen
> > +                * first, and we could end up in a situation where the
> > +                * old PTE was seen by the NPU/PSL/device, but the
> > +                * TLBI is local.
> > +                */
> > +               mb();
> 
> smp_mb()?
> 
> > +               rc = !mm_context_get_global_tlbi(&mm->context);
> > +       }
> 
> Otherwise looks good!
> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>
