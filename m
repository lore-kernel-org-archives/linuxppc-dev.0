Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm0Y21yQQzDr17
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 13:37:10 +1000 (AEST)
Message-ID: <1467949015.2874.7.camel@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/4] powerpc/64/kexec: Fix MMU cleanup on radix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@au1.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 08 Jul 2016 13:36:55 +1000
In-Reply-To: <4b35285e-88c3-7b96-2991-8b42ed50f267@gmail.com>
References: <1467779659.13965.101.camel@kernel.crashing.org>
 <4b35285e-88c3-7b96-2991-8b42ed50f267@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-07-08 at 12:55 +1000, Balbir Singh wrote:
> +
> > +/* For use by kexec */
> > +void mmu_cleanup_all(void)
> > +{
> > +     if (radix_enabled())
> > +             radix__mmu_cleanup_all();
> 
> 
> Should this be more than just radix -- cpu_has_feature(CPU_FTR_ARCH_300)?

I don't understand... We need to cleanup the radix if we use a radix, otherwise
we cleanup the hash ...

Basically this will switch back to hash mode before kexec.

> > +     else if (mmu_hash_ops.hpte_clear_all)
> > +             mmu_hash_ops.hpte_clear_all();
> > +}
> > diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> > index 3ababda..f127baa 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -366,6 +366,16 @@ void radix__early_init_mmu_secondary(void)
> >       }
> >  }
> >  
> > +void radix__mmu_cleanup_all(void)
> > +{
> > +     unsigned long lpcr;
> > +     if (!firmware_has_feature(FW_FEATURE_LPAR)) {
> > +             lpcr = mfspr(SPRN_LPCR);
> > +             mtspr(SPRN_LPCR, lpcr & ~LPCR_UPRT);
> > +             mtspr(SPRN_PTCR, 0);
> 
> Free up the patb data structure here?

Why do we care freeing it ? We're about to kexec.

> We also need tlbie's to invalidate any caches pointing to the patb entries

Yes, that would be definitely a useful addition, I shuld have mentioned this
is a stub so we don't crash due to a NULL pointer, but more work is needed
to properly support kexec, which I'll let Aneesh do.

On the other hand for safety, the new kernel should also flush its TLB on
entry I reckon. Especially since I don't think we do the cleanup on crashdump.

Cheers,
Ben.
