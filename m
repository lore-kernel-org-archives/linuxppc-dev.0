Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F13711007D9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 10:00:35 +1100 (EST)
Message-ID: <4F3EDC01.5000400@freescale.com>
Date: Fri, 17 Feb 2012 17:00:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 24/30] KVM: PPC: booke: call resched after every exit
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-25-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-25-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 11:13 AM, Alexander Graf wrote:
> Instead of checking whether we should reschedule only when we exited
> due to an interrupt, let's always check before entering the guest back
> again. This gets the target more in line with the other archs.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/booke.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index bfb2092..de30b6d 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -572,6 +572,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>                         unsigned int exit_nr)
>  {
>  	int r = RESUME_HOST;
> +	int resched_needed = 1;
>  
>  	/* update before a new last_exit_type is rewritten */
>  	kvmppc_update_timing_stats(vcpu);
> @@ -602,25 +603,21 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  
>  	switch (exit_nr) {
>  	case BOOKE_INTERRUPT_MACHINE_CHECK:
> -		kvm_resched(vcpu);
>  		r = RESUME_GUEST;
>  		break;
>  
>  	case BOOKE_INTERRUPT_EXTERNAL:
>  		kvmppc_account_exit(vcpu, EXT_INTR_EXITS);
> -		kvm_resched(vcpu);
>  		r = RESUME_GUEST;
>  		break;
>  
>  	case BOOKE_INTERRUPT_DECREMENTER:
>  		kvmppc_account_exit(vcpu, DEC_EXITS);
> -		kvm_resched(vcpu);
>  		r = RESUME_GUEST;
>  		break;
>  
>  	case BOOKE_INTERRUPT_DOORBELL:
>  		kvmppc_account_exit(vcpu, DBELL_EXITS);
> -		kvm_resched(vcpu);
>  		r = RESUME_GUEST;
>  		break;
>  
> @@ -869,8 +866,16 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		BUG();
>  	}
>  
> -	local_irq_disable();
> +	/* make sure we reschedule if we need to */
> +	while (resched_needed) {
> +		local_irq_disable();
>  
> +		resched_needed = need_resched();
> +		if (resched_needed) {
> +			local_irq_enable();
> +			cond_resched();
> +		}
> +	}
>  	kvmppc_core_prepare_to_enter(vcpu);
>  
>  	if (!(r & RESUME_HOST)) {

kvmppc_core_prepare_to_enter can enable interrupts (and block) if guest
MSR_WE is set.  We may take an interrupt that wants a resched after
waking but before interrupts are disabled again.

We also want to check for a resched in kvmppc_vcpu_run.  So, the resched
check belongs in kvmppc_core_prepare_to_enter, something like:

/* Check pending exceptions and deliver one, if possible. */
void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
{
	WARN_ON_ONCE(!irqs_disabled());

	while (true) {
		if (signal_pending(current))
			break;

		if (need_resched()) {
			local_irq_enable();
			cond_resched();
			local_irq_disable();
			continue;
		}

		kvmppc_core_check_exceptions(vcpu);

		if (vcpu->arch.shared->msr & MSR_WE) {
			local_irq_enable();
			kvm_vcpu_block(vcpu);
			local_irq_disable();
	
			kvmppc_set_exit_type(vcpu,
				EMULATED_MTMSRWE_EXITS);
			continue;
		}

		break;
	}
}

It would be simpler (both here and in the idle hcall) if we could just
drop support for CONFIG_PREEMPT=n. :-P

-Scott
