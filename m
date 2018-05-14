Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40knBl06R1zF2mS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 14:04:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] KVM: PPC: Book3S HV: lockless tlbie for HPT hcalls
In-Reply-To: <20180510053042.GA14286@fergus.ozlabs.ibm.com>
References: <20180405175631.31381-1-npiggin@gmail.com>
 <20180405175631.31381-3-npiggin@gmail.com>
 <87a7ugeucv.fsf@concordia.ellerman.id.au>
 <20180510053042.GA14286@fergus.ozlabs.ibm.com>
Date: Mon, 14 May 2018 14:04:10 +1000
Message-ID: <874ljarih1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Fri, Apr 06, 2018 at 04:12:32PM +1000, Michael Ellerman wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
>> > index 78e6a392330f..0221a0f74f07 100644
>> > --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
>> > +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
>> > @@ -439,6 +439,9 @@ static inline int try_lock_tlbie(unsigned int *lock)
>> >  	unsigned int tmp, old;
>> >  	unsigned int token = LOCK_TOKEN;
>> >  
>> > +	if (mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
>> > +		return 1;
>> > +
>> >  	asm volatile("1:lwarx	%1,0,%2\n"
>> >  		     "	cmpwi	cr0,%1,0\n"
>> >  		     "	bne	2f\n"
>> > @@ -452,6 +455,12 @@ static inline int try_lock_tlbie(unsigned int *lock)
>> >  	return old == 0;
>> >  }
>> >  
>> > +static inline void unlock_tlbie_after_sync(unsigned int *lock)
>> > +{
>> > +	if (mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
>> > +		return;
>> > +}
>> 
>> So this is a bit hard to follow:
>> 
>> #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
>> 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
>> #define MMU_FTRS_POWER		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
>> #define MMU_FTRS_PPC970		MMU_FTRS_POWER | MMU_FTR_TLBIE_CROP_VA			// does NOT
>> #define MMU_FTRS_POWER5		MMU_FTRS_POWER | MMU_FTR_LOCKLESS_TLBIE
>> #define MMU_FTRS_POWER6		MMU_FTRS_POWER5 | MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA	// includes lockless TLBIE
>> #define MMU_FTRS_POWER7		MMU_FTRS_POWER6						// includes lockless TLBIE
>> #define MMU_FTRS_POWER8		MMU_FTRS_POWER6						// includes lockless TLBIE
>> #define MMU_FTRS_POWER9		MMU_FTRS_POWER6						// includes lockless TLBIE
>> #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | 			// does NOT
>> 				MMU_FTR_CI_LARGE_PAGE
>> #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \			// does NOT
>> 				MMU_FTR_CI_LARGE_PAGE | MMU_FTR_NO_SLBIE_B
>> 
>> 
>> So it's only 970, Cell and Pasemi that *don't* have lockless TLBIE.
>> 
>> And KVM HV doesn't doesn't run on any of those.
>> 
>> So we can just not check for the feature in the KVM HV code.
>> 
>> Am I right?
>
> Yes; that code was written when we still supported HV KVM on 970,
> but we ripped that out some time ago.

OK good, in commit:

c17b98cf6028 ("KVM: PPC: Book3S HV: Remove code for PPC970 processors") (Dec 2014)

So we should be able to do the patch below.

cheers


diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 17498e9a26e4..7756b0c6da75 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -269,7 +269,6 @@ struct kvm_arch {
 	unsigned long host_lpcr;
 	unsigned long sdr1;
 	unsigned long host_sdr1;
-	int tlbie_lock;
 	unsigned long lpcr;
 	unsigned long vrma_slb_v;
 	int mmu_ready;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 78e6a392330f..89d909b3b881 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -434,24 +434,6 @@ static inline int is_mmio_hpte(unsigned long v, unsigned long r)
 		(HPTE_R_KEY_HI | HPTE_R_KEY_LO));
 }
 
-static inline int try_lock_tlbie(unsigned int *lock)
-{
-	unsigned int tmp, old;
-	unsigned int token = LOCK_TOKEN;
-
-	asm volatile("1:lwarx	%1,0,%2\n"
-		     "	cmpwi	cr0,%1,0\n"
-		     "	bne	2f\n"
-		     "  stwcx.	%3,0,%2\n"
-		     "	bne-	1b\n"
-		     "  isync\n"
-		     "2:"
-		     : "=&r" (tmp), "=&r" (old)
-		     : "r" (lock), "r" (token)
-		     : "cc", "memory");
-	return old == 0;
-}
-
 static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		      long npages, int global, bool need_sync)
 {
@@ -463,8 +445,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 	 * the RS field, this is backwards-compatible with P7 and P8.
 	 */
 	if (global) {
-		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
-			cpu_relax();
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
 		for (i = 0; i < npages; ++i) {
@@ -483,7 +463,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		}
 
 		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-		kvm->arch.tlbie_lock = 0;
 	} else {
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
