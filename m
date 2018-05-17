Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mcqX23xqzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 13:54:00 +1000 (AEST)
Date: Thu, 17 May 2018 13:53:56 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] KVM: PPC: Book3S HV: lockless tlbie for HPT hcalls
Message-ID: <20180517035356.GA31160@fergus.ozlabs.ibm.com>
References: <20180405175631.31381-1-npiggin@gmail.com>
 <20180405175631.31381-3-npiggin@gmail.com>
 <87a7ugeucv.fsf@concordia.ellerman.id.au>
 <20180510053042.GA14286@fergus.ozlabs.ibm.com>
 <874ljarih1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874ljarih1.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 14, 2018 at 02:04:10PM +1000, Michael Ellerman wrote:
[snip]
> OK good, in commit:
> 
> c17b98cf6028 ("KVM: PPC: Book3S HV: Remove code for PPC970 processors") (Dec 2014)
> 
> So we should be able to do the patch below.
> 
> cheers
> 
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 17498e9a26e4..7756b0c6da75 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -269,7 +269,6 @@ struct kvm_arch {
>  	unsigned long host_lpcr;
>  	unsigned long sdr1;
>  	unsigned long host_sdr1;
> -	int tlbie_lock;
>  	unsigned long lpcr;
>  	unsigned long vrma_slb_v;
>  	int mmu_ready;
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 78e6a392330f..89d909b3b881 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -434,24 +434,6 @@ static inline int is_mmio_hpte(unsigned long v, unsigned long r)
>  		(HPTE_R_KEY_HI | HPTE_R_KEY_LO));
>  }
>  
> -static inline int try_lock_tlbie(unsigned int *lock)
> -{
> -	unsigned int tmp, old;
> -	unsigned int token = LOCK_TOKEN;
> -
> -	asm volatile("1:lwarx	%1,0,%2\n"
> -		     "	cmpwi	cr0,%1,0\n"
> -		     "	bne	2f\n"
> -		     "  stwcx.	%3,0,%2\n"
> -		     "	bne-	1b\n"
> -		     "  isync\n"
> -		     "2:"
> -		     : "=&r" (tmp), "=&r" (old)
> -		     : "r" (lock), "r" (token)
> -		     : "cc", "memory");
> -	return old == 0;
> -}
> -
>  static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
>  		      long npages, int global, bool need_sync)
>  {
> @@ -463,8 +445,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
>  	 * the RS field, this is backwards-compatible with P7 and P8.
>  	 */
>  	if (global) {
> -		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
> -			cpu_relax();
>  		if (need_sync)
>  			asm volatile("ptesync" : : : "memory");
>  		for (i = 0; i < npages; ++i) {
> @@ -483,7 +463,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
>  		}
>  
>  		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
> -		kvm->arch.tlbie_lock = 0;
>  	} else {
>  		if (need_sync)
>  			asm volatile("ptesync" : : : "memory");

Seems reasonable; is that a patch submission? :)

Paul.
