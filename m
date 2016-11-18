Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tL1Cg6rzyzDqV5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 01:51:27 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tL1Cg34LYz9t2p
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 01:51:27 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIEnWLx018181
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:25 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26t2ud2xx9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:25 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 09:51:23 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 09/13] KVM: PPC: Book3S HV: Adapt TLB invalidations to
 work on POWER9
In-Reply-To: <1479454122-26994-10-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-10-git-send-email-paulus@ozlabs.org>
Date: Fri, 18 Nov 2016 20:11:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y40gn941.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> POWER9 adds new capabilities to the tlbie (TLB invalidate entry)
> and tlbiel (local tlbie) instructions.  Both instructions get a
> set of new parameters (RIC, PRS and R) which appear as bits in the
> instruction word.  The tlbiel instruction now has a second register
> operand, which contains a PID and/or LPID value if needed, and
> should otherwise contain 0.
>
> This adapts KVM-HV's usage of tlbie and tlbiel to work on POWER9
> as well as older processors.  Since we only handle HPT guests so
> far, we need RIC=0 PRS=0 R=0, which ends up with the same instruction
> word as on previous processors, so we don't need to conditionally
> execute different instructions depending on the processor.
>
> The local flush on first entry to a guest in book3s_hv_rmhandlers.S
> is a loop which depends on the number of TLB sets.  Rather than
> using feature sections to set the number of iterations based on
> which CPU we're on, we now work out this number at VM creation time
> and store it in the kvm_arch struct.  That will make it possible to
> get the number from the device tree in future, which will help with
> compatibility with future processors.
>
> Since mmu_partition_table_set_entry() does a global flush of the
> whole LPID, we don't need to do the TLB flush on first entry to the
> guest on each processor.  Therefore we don't set all bits in the
> tlb_need_flush bitmap on VM startup on POWER9.
>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/kvm_host.h     |  1 +
>  arch/powerpc/kernel/asm-offsets.c       |  1 +
>  arch/powerpc/kvm/book3s_hv.c            | 17 ++++++++++++++++-
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c     | 10 ++++++++--
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |  8 ++------
>  5 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 0d94608..ea78864 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -244,6 +244,7 @@ struct kvm_arch_memory_slot {
>  struct kvm_arch {
>  	unsigned int lpid;
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	unsigned int tlb_sets;
>  	unsigned long hpt_virt;
>  	struct revmap_entry *revmap;
>  	atomic64_t mmio_update;
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 494241b..b9c8386 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -487,6 +487,7 @@ int main(void)
>  
>  	/* book3s */
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	DEFINE(KVM_TLB_SETS, offsetof(struct kvm, arch.tlb_sets));
>  	DEFINE(KVM_SDR1, offsetof(struct kvm, arch.sdr1));
>  	DEFINE(KVM_HOST_LPID, offsetof(struct kvm, arch.host_lpid));
>  	DEFINE(KVM_HOST_LPCR, offsetof(struct kvm, arch.host_lpcr));
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 59e18dfb..8395a7f 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3260,8 +3260,11 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>  	 * Since we don't flush the TLB when tearing down a VM,
>  	 * and this lpid might have previously been used,
>  	 * make sure we flush on each core before running the new VM.
> +	 * On POWER9, the tlbie in mmu_partition_table_set_entry()
> +	 * does this flush for us.
>  	 */
> -	cpumask_setall(&kvm->arch.need_tlb_flush);
> +	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +		cpumask_setall(&kvm->arch.need_tlb_flush);
>  
>  	/* Start out with the default set of hcalls enabled */
>  	memcpy(kvm->arch.enabled_hcalls, default_enabled_hcalls,
> @@ -3287,6 +3290,17 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>  	kvm->arch.lpcr = lpcr;
>  
>  	/*
> +	 * Work out how many sets the TLB has, for the use of
> +	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
> +	 */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		kvm->arch.tlb_sets = 256;	/* POWER9 */
> +	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
> +		kvm->arch.tlb_sets = 512;	/* POWER8 */
> +	else
> +		kvm->arch.tlb_sets = 128;	/* POWER7 */
> +

We have 

#define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
#define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
#define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9 TLB Hash mode */
#define POWER9_TLB_SETS_RADIX	128	/* # sets in POWER9 TLB Radix mode */

May be use that instead of opencoding ?


> +	/*
>  	 * Track that we now have a HV mode VM active. This blocks secondary
>  	 * CPU threads from coming online.
>  	 */
> @@ -3728,3 +3742,4 @@ module_exit(kvmppc_book3s_exit_hv);
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_MISCDEV(KVM_MINOR);
>  MODULE_ALIAS("devname:kvm");
> +
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 1179e40..9ef3c4b 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -424,13 +424,18 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
>  {
>  	long i;
>  
> +	/*
> +	 * We use the POWER9 5-operand versions of tlbie and tlbiel here.
> +	 * Since we are using RIC=0 PRS=0 R=0, and P7/P8 tlbiel ignores
> +	 * the RS field, this is backwards-compatible with P7 and P8.
> +	 */
>  	if (global) {
>  		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
>  			cpu_relax();
>  		if (need_sync)
>  			asm volatile("ptesync" : : : "memory");
>  		for (i = 0; i < npages; ++i)
> -			asm volatile(PPC_TLBIE(%1,%0) : :
> +			asm volatile(PPC_TLBIE_5(%0,%1,0,0,0) : :
>  				     "r" (rbvalues[i]), "r" (kvm->arch.lpid));
>  		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
>  		kvm->arch.tlbie_lock = 0;
> @@ -438,7 +443,8 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
>  		if (need_sync)
>  			asm volatile("ptesync" : : : "memory");
>  		for (i = 0; i < npages; ++i)
> -			asm volatile("tlbiel %0" : : "r" (rbvalues[i]));
> +			asm volatile(PPC_TLBIEL(%0,%1,0,0,0) : :
> +				     "r" (rbvalues[i]), "r" (0));
>  		asm volatile("ptesync" : : : "memory");
>  	}
>  }
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 219a04f..acae5c3 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -613,12 +613,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  	stdcx.	r7,0,r6
>  	bne	23b
>  	/* Flush the TLB of any entries for this LPID */
> -	/* use arch 2.07S as a proxy for POWER8 */
> -BEGIN_FTR_SECTION
> -	li	r6,512			/* POWER8 has 512 sets */
> -FTR_SECTION_ELSE
> -	li	r6,128			/* POWER7 has 128 sets */
> -ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_207S)
> +	lwz	r6,KVM_TLB_SETS(r9)
> +	li	r0,0			/* RS for P9 version of tlbiel */
>  	mtctr	r6
>  	li	r7,0x800		/* IS field = 0b10 */
>  	ptesync
> -- 
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
