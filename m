Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E222A1A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 23:37:10 +1000 (EST)
Message-ID: <53B55C81.8040300@suse.de>
Date: Thu, 03 Jul 2014 15:37:05 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 3/5 v4] KVM: PPC: Book3s: Remove kvmppc_read_inst()
 function
References: <1403909347-31622-1-git-send-email-mihai.caraman@freescale.com>
 <1403909347-31622-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1403909347-31622-4-git-send-email-mihai.caraman@freescale.com>
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


On 28.06.14 00:49, Mihai Caraman wrote:
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
> v4:
>   - new patch
>
>   arch/powerpc/kvm/book3s_pr.c | 85 ++++++++++++++++++--------------------------
>   1 file changed, 35 insertions(+), 50 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 15fd6c2..d247d88 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -665,42 +665,6 @@ static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
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
> @@ -1101,31 +1065,51 @@ program_interrupt:
>   	case BOOK3S_INTERRUPT_VSX:
>   	{
>   		int ext_msr = 0;
> +		int emul;
> +		ulong pc;
> +		u32 last_inst;
>   
> -		switch (exit_nr) {
> -		case BOOK3S_INTERRUPT_FP_UNAVAIL: ext_msr = MSR_FP;  break;
> -		case BOOK3S_INTERRUPT_ALTIVEC:    ext_msr = MSR_VEC; break;
> -		case BOOK3S_INTERRUPT_VSX:        ext_msr = MSR_VSX; break;
> -		}
> +		if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE)) {

Please make paired single emulation the unusual, if()'ed case, not the 
normal exit path :).


Alex
