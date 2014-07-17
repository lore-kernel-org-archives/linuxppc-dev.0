Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 736301A01CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 23:56:41 +1000 (EST)
Message-ID: <53C7D614.6010907@suse.de>
Date: Thu, 17 Jul 2014 15:56:36 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v5 3/5] KVM: PPC: Book3s: Remove kvmppc_read_inst()
 function
References: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
 <1405596148-1507-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1405596148-1507-4-git-send-email-mihai.caraman@freescale.com>
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


On 17.07.14 13:22, Mihai Caraman wrote:
> In the context of replacing kvmppc_ld() function calls with a version of
> kvmppc_get_last_inst() which allow to fail, Alex Graf suggested this:
>
> "If we get EMULATE_AGAIN, we just have to make sure we go back into the guest.
> No need to inject an ISI into  the guest - it'll do that all by itself.
> With an error returning kvmppc_get_last_inst we can just use completely
> get rid of kvmppc_read_inst() and only use kvmppc_get_last_inst() instead."
>
> As a intermediate step get rid of kvmppc_read_inst() and only use kvmppc_ld()
> instead.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v5:
>   - make paired single emulation the unusual
>
> v4:
>   - new patch
>
>   arch/powerpc/kvm/book3s_pr.c | 91 ++++++++++++++++++--------------------------
>   1 file changed, 37 insertions(+), 54 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index e40765f..02a983e 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -710,42 +710,6 @@ static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
>   #endif
>   }
>   
> -static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
> -{
> -	ulong srr0 = kvmppc_get_pc(vcpu);
> -	u32 last_inst = kvmppc_get_last_inst(vcpu);
> -	int ret;
> -
> -	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
> -	if (ret == -ENOENT) {
> -		ulong msr = kvmppc_get_msr(vcpu);
> -
> -		msr = kvmppc_set_field(msr, 33, 33, 1);
> -		msr = kvmppc_set_field(msr, 34, 36, 0);
> -		msr = kvmppc_set_field(msr, 42, 47, 0);
> -		kvmppc_set_msr_fast(vcpu, msr);
> -		kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_INST_STORAGE);
> -		return EMULATE_AGAIN;
> -	}
> -
> -	return EMULATE_DONE;
> -}
> -
> -static int kvmppc_check_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr)
> -{
> -
> -	/* Need to do paired single emulation? */
> -	if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE))
> -		return EMULATE_DONE;
> -
> -	/* Read out the instruction */
> -	if (kvmppc_read_inst(vcpu) == EMULATE_DONE)
> -		/* Need to emulate */
> -		return EMULATE_FAIL;
> -
> -	return EMULATE_AGAIN;
> -}
> -
>   /* Handle external providers (FPU, Altivec, VSX) */
>   static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
>   			     ulong msr)
> @@ -1149,31 +1113,49 @@ program_interrupt:
>   	case BOOK3S_INTERRUPT_VSX:
>   	{
>   		int ext_msr = 0;
> +		int emul;
> +		ulong pc;
> +		u32 last_inst;
> +
> +		if (vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE) {
> +			/* Emulate the instruction */

If the flag is set we do paired single instruction emulation.

> +
> +			pc = kvmppc_get_pc(vcpu);
> +			last_inst = kvmppc_get_last_inst(vcpu);
> +			emul = kvmppc_ld(vcpu, &pc, sizeof(u32), &last_inst,
> +					 false);
> +			if (emul == EMULATE_DONE)
> +				goto program_interrupt;
> +			else
> +				r = RESUME_GUEST;
> +		} else {
> +			/* Do paired single emulation */

otherwise we deflect the interrupt into our guest.


Alex

>   
> -		switch (exit_nr) {
> -		case BOOK3S_INTERRUPT_FP_UNAVAIL: ext_msr = MSR_FP;  break;
> -		case BOOK3S_INTERRUPT_ALTIVEC:    ext_msr = MSR_VEC; break;
> -		case BOOK3S_INTERRUPT_VSX:        ext_msr = MSR_VSX; break;
> -		}
> +			switch (exit_nr) {
> +			case BOOK3S_INTERRUPT_FP_UNAVAIL:
> +				ext_msr = MSR_FP;
> +				break;
> +
> +			case BOOK3S_INTERRUPT_ALTIVEC:
> +				ext_msr = MSR_VEC;
> +				break;
> +
> +			case BOOK3S_INTERRUPT_VSX:
> +				ext_msr = MSR_VSX;
> +				break;
> +			}
>   
> -		switch (kvmppc_check_ext(vcpu, exit_nr)) {
> -		case EMULATE_DONE:
> -			/* everything ok - let's enable the ext */
>   			r = kvmppc_handle_ext(vcpu, exit_nr, ext_msr);
> -			break;
> -		case EMULATE_FAIL:
> -			/* we need to emulate this instruction */
> -			goto program_interrupt;
> -			break;
> -		default:
> -			/* nothing to worry about - go again */
> -			break;
>   		}
>   		break;
>   	}
>   	case BOOK3S_INTERRUPT_ALIGNMENT:
> -		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {
> -			u32 last_inst = kvmppc_get_last_inst(vcpu);
> +	{
> +		ulong pc = kvmppc_get_pc(vcpu);
> +		u32 last_inst = kvmppc_get_last_inst(vcpu);
> +		int emul = kvmppc_ld(vcpu, &pc, sizeof(u32), &last_inst, false);
> +
> +		if (emul == EMULATE_DONE) {
>   			u32 dsisr;
>   			u64 dar;
>   
> @@ -1187,6 +1169,7 @@ program_interrupt:
>   		}
>   		r = RESUME_GUEST;
>   		break;
> +	}
>   #ifdef CONFIG_PPC_BOOK3S_64
>   	case BOOK3S_INTERRUPT_FAC_UNAVAIL:
>   		kvmppc_handle_fac(vcpu, vcpu->arch.shadow_fscr >> 56);
