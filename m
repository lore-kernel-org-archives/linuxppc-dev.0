Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD83BB6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 06:28:42 +1100 (EST)
Message-ID: <4F4BD95B.9010809@freescale.com>
Date: Mon, 27 Feb 2012 13:28:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-25-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-25-git-send-email-agraf@suse.de>
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

On 02/24/2012 08:26 AM, Alexander Graf wrote:
> -void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
> +int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long *pending = &vcpu->arch.pending_exceptions;
>  	unsigned long old_pending = vcpu->arch.pending_exceptions;
> @@ -283,6 +283,8 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>  
>  	/* Tell the guest about our interrupt status */
>  	kvmppc_update_int_pending(vcpu, *pending, old_pending);
> +
> +	return 0;
>  }
>  
>  pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn)
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 9979be1..3fcec2c 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -439,8 +439,9 @@ static void kvmppc_core_check_exceptions(struct kvm_vcpu *vcpu)
>  }
>  
>  /* Check pending exceptions and deliver one, if possible. */
> -void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
> +int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>  {
> +	int r = 0;
>  	WARN_ON_ONCE(!irqs_disabled());
>  
>  	kvmppc_core_check_exceptions(vcpu);
> @@ -451,8 +452,44 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>  		local_irq_disable();
>  
>  		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
> -		kvmppc_core_check_exceptions(vcpu);
> +		r = 1;
>  	};
> +
> +	return r;
> +}
> +
> +/*
> + * Common checks before entering the guest world.  Call with interrupts
> + * disabled.
> + *
> + * returns !0 if a signal is pending and check_signal is true
> + */
> +static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool check_signal)
> +{
> +	int r = 0;
> +
> +	WARN_ON_ONCE(!irqs_disabled());
> +	while (true) {
> +		if (need_resched()) {
> +			local_irq_enable();
> +			cond_resched();
> +			local_irq_disable();
> +			continue;
> +		}
> +
> +		if (kvmppc_core_prepare_to_enter(vcpu)) {
> +			/* interrupts got enabled in between, so we
> +			   are back at square 1 */
> +			continue;
> +		}
> +
> +
> +		if (check_signal && signal_pending(current))
> +			r = 1;

If there is a signal pending and MSR[WE] is set, we'll loop forever
without reaching this check.

-Scott
