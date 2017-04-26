Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCYJ96YrtzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 18:33:29 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id v1so9152137pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 01:33:29 -0700 (PDT)
Date: Wed, 26 Apr 2017 18:29:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
Message-ID: <20170426182948.1810998d@roar.ozlabs.ibm.com>
In-Reply-To: <8737cy2ozz.fsf@skywalker.in.ibm.com>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <8737cy2ozz.fsf@skywalker.in.ibm.com>
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

On Mon, 24 Apr 2017 13:53:12 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > tlbiel instruction with IS!=0 on POWER7 and later Book3s CPUs invalidate
> > TLBs belonging to a specified congruence class. In order to operate on
> > the entire TLB, all congruence classes must be specified, requiring a
> > software loop.
> >
> > This dt property specifies the number of classes that must be operated
> > on. Use this to set tlbiel loop counts. If the property does not exist,
> > fall back to hard coded values based on the cpu table.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >  	return 0;  
> .....
> .....
> 
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index d2f0afeae5a0..08ec2f431eff 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -236,8 +236,27 @@ static void __init init_mmu_slb_size(unsigned long node)
> >  	if (slb_size_ptr)
> >  		mmu_slb_size = be32_to_cpup(slb_size_ptr);
> >  }
> > +static void __init init_mmu_tlb_sets_hash(unsigned long node)
> > +{
> > +	const __be32 *ptr;
> > +
> > +	ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-hash", NULL);
> > +	if (ptr)
> > +		cur_cpu_spec->tlb_sets_hash = be32_to_cpup(ptr);
> > +}
> > +
> > +static void __init init_mmu_tlb_sets_radix(unsigned long node)
> > +{
> > +	const __be32 *ptr;
> > +
> > +	ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-radix", NULL);
> > +	if (ptr)
> > +		cur_cpu_spec->tlb_sets_radix = be32_to_cpup(ptr);
> > +}
> >  #else
> >  #define init_mmu_slb_size(node) do { } while(0)
> > +#define init_mmu_hash_sets(node) do { } while(0)
> > +#define init_mmu_radix_sets(node) do { } while(0)
> >  #endif
> >
> >  static struct feature_property {
> > @@ -385,6 +404,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
> >  	check_cpu_feature_properties(node);
> >  	check_cpu_pa_features(node);
> >  	init_mmu_slb_size(node);
> > +	init_mmu_tlb_sets_hash(node);
> > +	init_mmu_tlb_sets_radix(node);
> >  
> 
> 
> I thought cpu features patch series had a generic mechanism to parse all
> these based on dt_cpu_feature_match_table[] ?

It could in theory. We could have a feature node for this set-wise
invalidation behaviour, and make a custom property of that feature
to give the number of sets to loop over.

At the moment Ben preferred each feature to be just a "binary" (present
or absent), with the accompanying metadata just being for the
compatibility bits. But this is a policy decision, and we may reconsider
it as we start adding extra cpu-features for future hardware.

For these numbers I think it's okay to add this way for now.


> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index fadb75abfe37..2211cda5de90 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -3430,14 +3430,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
> >  	 * Work out how many sets the TLB has, for the use of
> >  	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
> >  	 */
> > -	if (kvm_is_radix(kvm))
> > -		kvm->arch.tlb_sets = POWER9_TLB_SETS_RADIX;	/* 128 */
> > -	else if (cpu_has_feature(CPU_FTR_ARCH_300))
> > -		kvm->arch.tlb_sets = POWER9_TLB_SETS_HASH;	/* 256 */
> > -	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > -		kvm->arch.tlb_sets = POWER8_TLB_SETS;		/* 512 */
> > -	else
> > -		kvm->arch.tlb_sets = POWER7_TLB_SETS;		/* 128 */
> > +	kvm->arch.tlb_sets = cur_cpu_spec->tlb_sets;  
> 
> 
> This should be based on guest mode right ? ie, we need to set
> kvm->arch.tlb_sets based on the mode kvm guest is running ?

You mean radix vs hash? Yes... Well, that's a reasonable assumption for
the behaviour of a CPU that supports guest mode != host mode, right? I'll
make the change.

> >  	/*
> >  	 * Track that we now have a HV mode VM active. This blocks secondary
> > diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
> > index 7ef0993214f3..f62798ce304b 100644
> > --- a/arch/powerpc/kvm/book3s_hv_ras.c
> > +++ b/arch/powerpc/kvm/book3s_hv_ras.c
> > @@ -87,8 +87,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
> >  				   DSISR_MC_SLB_PARITY | DSISR_MC_DERAT_MULTI);
> >  		}
> >  		if (dsisr & DSISR_MC_TLB_MULTI) {
> > -			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
> > -				cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
> > +			machine_check_flush_tlb(TLB_INVAL_SCOPE_LPID);
> >  			dsisr &= ~DSISR_MC_TLB_MULTI;
> >  		}
> >  		/* Any other errors we don't understand? */
> > @@ -105,8 +104,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
> >  		reload_slb(vcpu);
> >  		break;
> >  	case SRR1_MC_IFETCH_TLBMULTI:
> > -		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
> > -			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
> > +		machine_check_flush_tlb(TLB_INVAL_SCOPE_LPID);
> >  		break;
> >  	default:
> >  		handled = 0;
> > diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> > index ec84b31c6c86..a7c771170993 100644
> > --- a/arch/powerpc/mm/init_64.c
> > +++ b/arch/powerpc/mm/init_64.c
> > @@ -405,9 +405,15 @@ void __init mmu_early_init_devtree(void)
> >  	if (!(mfmsr() & MSR_HV))
> >  		early_check_vec5();
> >
> > -	if (early_radix_enabled())
> > +	if (early_radix_enabled()) {
> > +		cur_cpu_spec->tlb_sets = cur_cpu_spec->tlb_sets_radix;
> >  		radix__early_init_devtree();
> > -	else
> > +	} else {
> > +		cur_cpu_spec->tlb_sets = cur_cpu_spec->tlb_sets_hash;
> >  		hash__early_init_devtree();
> > +	}
> > +	/* This should not happen, but fall back to 1 set */
> > +	if (!cur_cpu_spec->tlb_sets)
> > +		cur_cpu_spec->tlb_sets = 1;
> >  }
> >  #endif /* CONFIG_PPC_STD_MMU_64 */
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index b68b5219cf45..76c8ed7549a7 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -38,15 +38,16 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
> >  		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
> >  }
> >
> > -/*
> > - * We use 128 set in radix mode and 256 set in hpt mode.
> > - */
> >  static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
> >  {
> >  	int set;
> >
> >  	asm volatile("ptesync": : :"memory");
> > -	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
> > +	/*
> > +	 * tlbiel with IS != 0 operates on a specified congruence class,
> > +	 * requiring a loop to invalidate the entire TLB (see ISA).
> > +	 */
> > +	for (set = 0; set < cur_cpu_spec->tlb_sets; set++) {
> >  		__tlbiel_pid(pid, set, ric);
> >  	}
> >  	asm volatile("ptesync": : :"memory");
> > -- 
> > 2.11.0  
> 
> This may need a rebase if mpe is going to take https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-April/157130.html

Yeah shouldn't be much problem.

Thanks,
Nick
