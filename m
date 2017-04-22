Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9T2v56Q3zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 09:14:47 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id x188so6128711itb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 16:14:46 -0700 (PDT)
Date: Sun, 23 Apr 2017 09:14:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
Message-ID: <20170423091428.16fc298f@roar.ozlabs.ibm.com>
In-Reply-To: <1492848130.25766.185.camel@kernel.crashing.org>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <1492848130.25766.185.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 22 Apr 2017 18:02:10 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2017-04-22 at 10:58 +1000, Nicholas Piggin wrote:
> > +static void __init init_mmu_tlb_sets_hash(unsigned long node)
> > +{
> > +       const __be32 *ptr;
> > +
> > +       ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-hash", NULL);
> > +       if (ptr)
> > +               cur_cpu_spec->tlb_sets_hash = be32_to_cpup(ptr);
> > +}
> > +
> > +static void __init init_mmu_tlb_sets_radix(unsigned long node)
> > +{
> > +       const __be32 *ptr;
> > +
> > +       ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-radix", NULL);
> > +       if (ptr)
> > +               cur_cpu_spec->tlb_sets_radix = be32_to_cpup(ptr);
> > +}
> >  #else
> >  #define init_mmu_slb_size(node) do { } while(0)
> > +#define init_mmu_hash_sets(node) do { } while(0)
> > +#define init_mmu_radix_sets(node) do { } while(0)
> >  #endif  
> 
> Why 2 functions ? I would have done one checking both props :-)

Probably mindless copy paste. I'll consolidate.


> Anothe thing to do is remove the assembly TLB flush from cpu_setup_power.S.
> 
> That happens too early anyway and do it later, at MMU init.
> 
> In fact, I wonder ... a lot of the stuff in there still requires us to more
> or less know the PVR of the CPU. We could move the call to after we've done
> the early DT parsing I reckon.
> 
> That way we can use arch level to set things like LPCR appropriately.

I think we were going to take another look at moving the setup code later,
but I think that might wait until 4.13.
