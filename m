Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1AEF1A002F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 18:15:11 +1000 (EST)
Message-ID: <53B6628B.6020001@suse.de>
Date: Fri, 04 Jul 2014 10:15:07 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] KVM: PPC: Book3E: Handle LRAT error exception
References: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
 <1404398727-12844-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404398727-12844-3-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.14 16:45, Mihai Caraman wrote:
> Handle LRAT error exception with support for lrat mapping and invalidation.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>   arch/powerpc/include/asm/kvm_host.h   |   1 +
>   arch/powerpc/include/asm/kvm_ppc.h    |   2 +
>   arch/powerpc/include/asm/mmu-book3e.h |   3 +
>   arch/powerpc/include/asm/reg_booke.h  |  13 ++++
>   arch/powerpc/kernel/asm-offsets.c     |   1 +
>   arch/powerpc/kvm/booke.c              |  40 +++++++++++
>   arch/powerpc/kvm/bookehv_interrupts.S |   9 ++-
>   arch/powerpc/kvm/e500_mmu_host.c      | 125 ++++++++++++++++++++++++++++++++++
>   arch/powerpc/kvm/e500mc.c             |   2 +
>   9 files changed, 195 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index bb66d8b..7b6b2ec 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -433,6 +433,7 @@ struct kvm_vcpu_arch {
>   	u32 eplc;
>   	u32 epsc;
>   	u32 oldpir;
> +	u64 fault_lper;
>   #endif
>   
>   #if defined(CONFIG_BOOKE)
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 9c89cdd..2730a29 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -86,6 +86,8 @@ extern gpa_t kvmppc_mmu_xlate(struct kvm_vcpu *vcpu, unsigned int gtlb_index,
>                                 gva_t eaddr);
>   extern void kvmppc_mmu_dtlb_miss(struct kvm_vcpu *vcpu);
>   extern void kvmppc_mmu_itlb_miss(struct kvm_vcpu *vcpu);
> +extern void kvmppc_lrat_map(struct kvm_vcpu *vcpu, gfn_t gfn);
> +extern void kvmppc_lrat_invalidate(struct kvm_vcpu *vcpu);
>   
>   extern struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm,
>                                                   unsigned int id);
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
> index 088fd9f..ac6acf7 100644
> --- a/arch/powerpc/include/asm/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/mmu-book3e.h
> @@ -40,6 +40,8 @@
>   
>   /* MAS registers bit definitions */
>   
> +#define MAS0_ATSEL		0x80000000
> +#define MAS0_ATSEL_SHIFT	31
>   #define MAS0_TLBSEL_MASK        0x30000000
>   #define MAS0_TLBSEL_SHIFT       28
>   #define MAS0_TLBSEL(x)          (((x) << MAS0_TLBSEL_SHIFT) & MAS0_TLBSEL_MASK)
> @@ -53,6 +55,7 @@
>   #define MAS0_WQ_CLR_RSRV       	0x00002000
>   
>   #define MAS1_VALID		0x80000000
> +#define MAS1_VALID_SHIFT	31
>   #define MAS1_IPROT		0x40000000
>   #define MAS1_TID(x)		(((x) << 16) & 0x3FFF0000)
>   #define MAS1_IND		0x00002000
> diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
> index 75bda23..783d617 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -43,6 +43,8 @@
>   
>   /* Special Purpose Registers (SPRNs)*/
>   #define SPRN_DECAR	0x036	/* Decrementer Auto Reload Register */
> +#define SPRN_LPER	0x038	/* Logical Page Exception Register */
> +#define SPRN_LPERU	0x039	/* Logical Page Exception Register Upper */
>   #define SPRN_IVPR	0x03F	/* Interrupt Vector Prefix Register */
>   #define SPRN_USPRG0	0x100	/* User Special Purpose Register General 0 */
>   #define SPRN_SPRG3R	0x103	/* Special Purpose Register General 3 Read */
> @@ -358,6 +360,9 @@
>   #define ESR_ILK		0x00100000	/* Instr. Cache Locking */
>   #define ESR_PUO		0x00040000	/* Unimplemented Operation exception */
>   #define ESR_BO		0x00020000	/* Byte Ordering */
> +#define ESR_DATA	0x00000400	/* Page Table Data Access */
> +#define ESR_TLBI	0x00000200	/* Page Table TLB Ineligible */
> +#define ESR_PT		0x00000100	/* Page Table Translation */
>   #define ESR_SPV		0x00000080	/* Signal Processing operation */
>   
>   /* Bit definitions related to the DBCR0. */
> @@ -649,6 +654,14 @@
>   #define EPC_EPID	0x00003fff
>   #define EPC_EPID_SHIFT	0
>   
> +/* Bit definitions for LPER */
> +#define LPER_ALPN		0x000FFFFFFFFFF000ULL
> +#define LPER_ALPN_SHIFT		12
> +#define LPER_WIMGE		0x00000F80
> +#define LPER_WIMGE_SHIFT	7
> +#define LPER_LPS		0x0000000F
> +#define LPER_LPS_SHIFT		0
> +
>   /*
>    * The IBM-403 is an even more odd special case, as it is much
>    * older than the IBM-405 series.  We put these down here incase someone
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index f5995a9..be6e329 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -713,6 +713,7 @@ int main(void)
>   	DEFINE(VCPU_HOST_MAS4, offsetof(struct kvm_vcpu, arch.host_mas4));
>   	DEFINE(VCPU_HOST_MAS6, offsetof(struct kvm_vcpu, arch.host_mas6));
>   	DEFINE(VCPU_EPLC, offsetof(struct kvm_vcpu, arch.eplc));
> +	DEFINE(VCPU_FAULT_LPER, offsetof(struct kvm_vcpu, arch.fault_lper));
>   #endif
>   
>   #ifdef CONFIG_KVM_EXIT_TIMING
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index a192975..ab1077f 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1286,6 +1286,46 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   		break;
>   	}
>   
> +#ifdef CONFIG_KVM_BOOKE_HV
> +	case BOOKE_INTERRUPT_LRAT_ERROR:
> +	{
> +		gfn_t gfn;
> +
> +		/*
> +		 * Guest TLB management instructions (EPCR.DGTMI == 0) is not
> +		 * supported for now
> +		 */
> +		if (!(vcpu->arch.fault_esr & ESR_PT)) {
> +			WARN(1, "%s: Guest TLB management instructions not supported!\n", __func__);

Wouldn't this allow a guest to flood the host's kernel log?

> +			break;
> +		}
> +
> +		gfn = (vcpu->arch.fault_lper & LPER_ALPN) >> LPER_ALPN_SHIFT;

Maybe add an #ifdef and #error check to make sure that LPER_ALPN_SHIFT 
== PAGE_SHIFT?

> +
> +		idx = srcu_read_lock(&vcpu->kvm->srcu);
> +
> +		if (kvm_is_visible_gfn(vcpu->kvm, gfn)) {
> +			kvmppc_lrat_map(vcpu, gfn);
> +			r = RESUME_GUEST;
> +		} else if (vcpu->arch.fault_esr & ESR_DATA) {
> +			vcpu->arch.paddr_accessed = (gfn << PAGE_SHIFT)
> +				| (vcpu->arch.fault_dear & (PAGE_SIZE - 1));
> +			vcpu->arch.vaddr_accessed =
> +				vcpu->arch.fault_dear;
> +
> +			r = kvmppc_emulate_mmio(run, vcpu);
> +			kvmppc_account_exit(vcpu, MMIO_EXITS);

It's a shame we have to duplicate that logic from the normal TLB miss 
path, but I can't see any good way to combine them either.

> +		} else {
> +			kvmppc_booke_queue_irqprio(vcpu,
> +						BOOKE_IRQPRIO_MACHINE_CHECK);
> +			r = RESUME_GUEST;
> +		}
> +
> +		srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +		break;
> +	}
> +#endif
> +
>   	case BOOKE_INTERRUPT_DEBUG: {
>   		r = kvmppc_handle_debug(run, vcpu);
>   		if (r == RESUME_HOST)
> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
> index b3ecdd6..341c3a8 100644
> --- a/arch/powerpc/kvm/bookehv_interrupts.S
> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> @@ -64,6 +64,7 @@
>   #define NEED_EMU		0x00000001 /* emulation -- save nv regs */
>   #define NEED_DEAR		0x00000002 /* save faulting DEAR */
>   #define NEED_ESR		0x00000004 /* save faulting ESR */
> +#define NEED_LPER		0x00000008 /* save faulting LPER */
>   
>   /*
>    * On entry:
> @@ -203,6 +204,12 @@
>   	PPC_STL	r9, VCPU_FAULT_DEAR(r4)
>   	.endif
>   
> +	/* Only suppported on 64-bit cores for now */
> +	.if	\flags & NEED_LPER
> +	mfspr	r7, SPRN_LPER
> +	std	r7, VCPU_FAULT_LPER(r4)
> +	.endif
> +
>   	b	kvmppc_resume_host
>   .endm
>   
> @@ -325,7 +332,7 @@ kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(DBG), \
>   kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(CRIT), \
>   	SPRN_CSRR0, SPRN_CSRR1, 0
>   kvm_handler BOOKE_INTERRUPT_LRAT_ERROR, EX_PARAMS(GEN), \
> -	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
> +	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR | NEED_LPER)
>   #else
>   /*
>    * For input register values, see arch/powerpc/include/asm/kvm_booke_hv_asm.h
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 79677d7..be1454b 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -95,6 +95,131 @@ static inline void __write_host_tlbe(struct kvm_book3e_206_tlb_entry *stlbe,
>   	                              stlbe->mas2, stlbe->mas7_3);
>   }
>   
> +#ifdef CONFIG_KVM_BOOKE_HV
> +#ifdef CONFIG_64BIT
> +static inline int lrat_next(void)

No inline in .c files please. Just only make them "static".

> +{
> +	int this, next;
> +
> +	this = local_paca->tcd.lrat_next;
> +	next = (this + 1) % local_paca->tcd.lrat_max;

Can we assume that lrat_max is always a power of 2? IIRC modulo 
functions with variables can be quite expensive. So if we can instead do

   next = (this + 1) & local_paca->tcd.lrat_mask;

we should be faster and not rely on division helpers.

> +	local_paca->tcd.lrat_next = next;
> +
> +	return this;
> +}
> +
> +static inline int lrat_size(void)
> +{
> +	return local_paca->tcd.lrat_max;
> +}
> +#else
> +/* LRAT is only supported in 64-bit kernel for now */
> +static inline int lrat_next(void)
> +{
> +	BUG();
> +}
> +
> +static inline int lrat_size(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +void write_host_lrate(int tsize, gfn_t gfn, unsigned long pfn, uint32_t lpid,
> +		      int valid, int lrat_entry)
> +{
> +	struct kvm_book3e_206_tlb_entry stlbe;
> +	int esel = lrat_entry;
> +	unsigned long flags;
> +
> +	stlbe.mas1 = (valid ? MAS1_VALID : 0) | MAS1_TSIZE(tsize);
> +	stlbe.mas2 = ((u64)gfn << PAGE_SHIFT);
> +	stlbe.mas7_3 = ((u64)pfn << PAGE_SHIFT);
> +	stlbe.mas8 = MAS8_TGS | lpid;
> +
> +	local_irq_save(flags);
> +	/* book3e_tlb_lock(); */

Hm?

> +
> +	if (esel == -1)
> +		esel = lrat_next();
> +	__write_host_tlbe(&stlbe, MAS0_ATSEL | MAS0_ESEL(esel));
> +
> +	/* book3e_tlb_unlock(); */
> +	local_irq_restore(flags);
> +}
> +
> +void kvmppc_lrat_map(struct kvm_vcpu *vcpu, gfn_t gfn)
> +{
> +	struct kvm_memory_slot *slot;
> +	unsigned long pfn;
> +	unsigned long hva;
> +	struct vm_area_struct *vma;
> +	unsigned long psize;
> +	int tsize;
> +	unsigned long tsize_pages;
> +
> +	slot = gfn_to_memslot(vcpu->kvm, gfn);
> +	if (!slot) {
> +		pr_err_ratelimited("%s: couldn't find memslot for gfn %lx!\n",
> +				   __func__, (long)gfn);
> +		return;
> +	}
> +
> +	hva = slot->userspace_addr;
> +
> +	down_read(&current->mm->mmap_sem);
> +	vma = find_vma(current->mm, hva);
> +	if (vma && (hva >= vma->vm_start)) {
> +		psize = vma_kernel_pagesize(vma);
> +	} else {
> +		pr_err_ratelimited("%s: couldn't find virtual memory address for gfn %lx!\n", __func__, (long)gfn);
> +		return;
> +	}
> +	up_read(&current->mm->mmap_sem);
> +
> +	pfn = gfn_to_pfn_memslot(slot, gfn);
> +	if (is_error_noslot_pfn(pfn)) {
> +		pr_err_ratelimited("%s: couldn't get real page for gfn %lx!\n",
> +				   __func__, (long)gfn);
> +		return;
> +	}
> +
> +	tsize = __ilog2(psize) - 10;
> +	tsize_pages = 1 << (tsize + 10 - PAGE_SHIFT);
> +	gfn &= ~(tsize_pages - 1);
> +	pfn &= ~(tsize_pages - 1);
> +
> +	write_host_lrate(tsize, gfn, pfn, vcpu->kvm->arch.lpid, 1, -1);
> +	kvm_release_pfn_clean(pfn);

Don't we have to keep the page locked so it doesn't get swapped away?


Alex

> +}
> +
> +void kvmppc_lrat_invalidate(struct kvm_vcpu *vcpu)
> +{
> +	uint32_t mas0, mas1 = 0;
> +	int esel;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	/* book3e_tlb_lock(); */
> +
> +	/* LRAT does not have a dedicated instruction for invalidation */
> +	for (esel = 0; esel < lrat_size(); esel++) {
> +		mas0 = MAS0_ATSEL | MAS0_ESEL(esel);
> +		mtspr(SPRN_MAS0, mas0);
> +		asm volatile("isync; tlbre" : : : "memory");
> +		mas1 = mfspr(SPRN_MAS1) & ~MAS1_VALID;
> +		mtspr(SPRN_MAS1, mas1);
> +		asm volatile("isync; tlbwe" : : : "memory");
> +	}
> +	/* Must clear mas8 for other host tlbwe's */
> +	mtspr(SPRN_MAS8, 0);
> +	isync();
> +
> +	/* book3e_tlb_unlock(); */
> +	local_irq_restore(flags);
> +}
> +#endif
> +
>   /*
>    * Acquire a mas0 with victim hint, as if we just took a TLB miss.
>    *
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index b1d9939..5622d9a 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -99,6 +99,8 @@ void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500)
>   	asm volatile("tlbilxlpid");
>   	mtspr(SPRN_MAS5, 0);
>   	local_irq_restore(flags);
> +
> +	kvmppc_lrat_invalidate(&vcpu_e500->vcpu);
>   }
>   
>   void kvmppc_set_pid(struct kvm_vcpu *vcpu, u32 pid)
