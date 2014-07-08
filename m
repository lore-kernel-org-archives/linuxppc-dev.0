Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE8CA1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 13:25:30 +1000 (EST)
Message-ID: <1404789919.21434.262.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH 3/4] KVM: PPC: e500: TLB emulation for IND entries
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Mon, 7 Jul 2014 22:25:19 -0500
In-Reply-To: <1404398727-12844-4-git-send-email-mihai.caraman@freescale.com>
References: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
 <1404398727-12844-4-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-03 at 17:45 +0300, Mihai Caraman wrote:
> Handle indirect entries (IND) in TLB emulation code. Translation size of IND
> entries differ from the size of referred Page Tables (Linux guests now use IND
> of 2MB for 4KB PTs) and this require careful tweak of the existing logic.
> 
> TLB search emulation requires additional search in HW TLB0 (since these entries
> are directly added by HTW) and found entries shoud be presented to the guest with
> RPN changed from PFN to GFN. There might be more GFNs pointing to the same PFN so
> the only way to get the corresponding GFN is to search it in guest's PTE. If IND
> entry for the corresponding PT is not available just invalidate guest's ea and
> report a tlbsx miss. This patch only implements the invalidation and let a TODO
> note for searching HW TLB0.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/include/asm/mmu-book3e.h |  2 +
>  arch/powerpc/kvm/e500.h               | 81 ++++++++++++++++++++++++++++-------
>  arch/powerpc/kvm/e500_mmu.c           | 78 +++++++++++++++++++++++++++------
>  arch/powerpc/kvm/e500_mmu_host.c      | 31 ++++++++++++--
>  arch/powerpc/kvm/e500mc.c             | 53 +++++++++++++++++++++--
>  5 files changed, 211 insertions(+), 34 deletions(-)

Please look at erratum A-008139.  A patch to work around it for the main
Linux tablewalk code is forthcoming.  You need to make sure to never
overwrite an indirect entry with tlbwe -- always use tlbilx.

> @@ -286,6 +336,22 @@ void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
>  void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500);
>  
>  #ifdef CONFIG_KVM_BOOKE_HV
> +void inval_tlb_on_host(struct kvm_vcpu *vcpu, int type, int pid);
> +
> +void inval_ea_on_host(struct kvm_vcpu *vcpu, gva_t ea, int pid, int sas,
> +		      int sind);
> +#else
> +/* TLB is fully virtualized */
> +static inline void inval_tlb_on_host(struct kvm_vcpu *vcpu,
> +				     int type, int pid)
> +{}
> +
> +static inline void inval_ea_on_host(struct kvm_vcpu *vcpu, gva_t ea, int pid,
> +				    int sas, int sind)
> +{}
> +#endif

Document exactly what these do, and explain why it's conceptually a
separate API from kvmppc_e500_tlbil_all/one(), and why "TLB is fully
virtualized" explains why we never need to do this on non-HV.

> @@ -290,21 +298,32 @@ static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
>  			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, esel);
>  		}
>  	}
> +
> +	/* Invalidate enties added by HTW */
> +	if (has_feature(&vcpu_e500->vcpu, VCPU_FTR_MMU_V2) && (!sind))

Unnecessary parens.

> @@ -368,6 +388,23 @@ int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea)
>  	} else {
>  		int victim;
>  
> +		if (has_feature(vcpu, VCPU_FTR_MMU_V2) &&
> +			get_cur_sind(vcpu) != 1) {
> +			/*

Never align the continuation line of an if or loop with the indentation
of the if/loop body.

get_cur_sind(vcpu) == 0 would be more natural, and probably slightly
faster.

> +			 * TLB0 entries are not cached in KVM being written
> +			 * directly by HTW. TLB0 entry found in HW TLB0 needs
> +			 * to be presented to the guest with RPN changed from
> +			 * PFN to GFN. There might be more GFNs pointing to the
> +			 * same PFN so the only way to get the corresponding GFN
> +			 * is to search it in guest's PTE. If IND entry for the
> +			 * corresponding PT is not available just invalidate
> +			 * guest's ea and report a tlbsx miss.
> +			 *
> +			 * TODO: search ea in HW TLB0
> +			 */
> +			inval_ea_on_host(vcpu, ea, pid, as, 0);

What if the guest is in a loop where it does an access followed by a
tlbsx, looping back if the tlbsx reports no entry (e.g. an exception
handler that wants to emulate retrying the faulting instruction on a
tlbsx miss)?  The architecture allows hypervisors to invalidate at
arbitrary times, but we should avoid doing this in ways that can block
forward progress.

How likely is it really that we have multiple GFNs per PFN?  How bad is
it really if we return an arbitrary matching GFN in such a case?

> @@ -516,12 +527,17 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  
>  			tsize = (gtlbe->mas1 & MAS1_TSIZE_MASK) >>
>  				MAS1_TSIZE_SHIFT;
> +			if (ind)
> +				tsize -= BOOK3E_PAGESZ_4K + 7;
>  
>  			/*
>  			 * e500 doesn't implement the lowest tsize bit,
>  			 * or 1K pages.
>  			 */
> -			tsize = max(BOOK3E_PAGESZ_4K, tsize & ~1);
> +			if (!has_feature(&vcpu_e500->vcpu, VCPU_FTR_MMU_V2))
> +				tsize &= ~1;

This looks like general e6500 support rathen than IND entry support.
Shouldn't there be a corresponding change to the "for (; tsize >
BOOK3E_PAGESZ_4K; tsize -= 2)" loop?

> -void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500)
> +void inval_ea_on_host(struct kvm_vcpu *vcpu, gva_t ea, int pid, int sas,
> +		      int sind)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
> +	mtspr(SPRN_MAS6, (pid << MAS6_SPID_SHIFT) |
> +		sas | (sind << MAS6_SIND_SHIFT));
> +	asm volatile("tlbilx 3, 0, %[ea]\n" : : [ea] "r" (ea));
> +	mtspr(SPRN_MAS5, 0);
> +	isync();
> +
> +	local_irq_restore(flags);
> +}

s/tlbilx 3/tlbilxva/

> +void inval_tlb_on_host(struct kvm_vcpu *vcpu, int type, int pid)
> +{
> +	if (type == 0)
> +		kvmppc_e500_tlbil_lpid(vcpu);
> +	else
> +		kvmppc_e500_tlbil_pid(vcpu, pid);
> +}

If type stays then please make it an enum, but why not have the caller
call kvmppc_e500_tlbil_lpid() or kvmppc_e500_tlbil_pid() directly?

-Scott
