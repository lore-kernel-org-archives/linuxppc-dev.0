Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B93F2C023E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 15:01:53 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH v2 4/4] kvm/ppc: IRQ disabling cleanup
Date: Fri, 10 May 2013 05:01:38 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0700F859@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-5-git-send-email-scottwood@freescale.com>
In-Reply-To: <1368155384-11035-5-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-owner@vger.kernel.org=
] On
> Behalf Of Scott Wood
> Sent: Friday, May 10, 2013 8:40 AM
> To: Alexander Graf; Benjamin Herrenschmidt
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-dev@lists.ozla=
bs.org;
> Wood Scott-B07421
> Subject: [PATCH v2 4/4] kvm/ppc: IRQ disabling cleanup
>=20
> Simplify the handling of lazy EE by going directly from fully-enabled
> to hard-disabled.  This replaces the lazy_irq_pending() check
> (including its misplaced kvm_guest_exit() call).
>=20
> As suggested by Tiejun Chen, move the interrupt disabling into
> kvmppc_prepare_to_enter() rather than have each caller do it.  Also
> move the IRQ enabling on heavyweight exit into
> kvmppc_prepare_to_enter().
>=20
> Don't move kvmppc_fix_ee_before_entry() into kvmppc_prepare_to_enter(),
> so that the caller can avoid marking interrupts enabled earlier than
> necessary (e.g. book3s_pr waits until after FP save/restore is done).
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h |    6 ++++++
>  arch/powerpc/kvm/book3s_pr.c       |   12 +++---------
>  arch/powerpc/kvm/booke.c           |    9 ++-------
>  arch/powerpc/kvm/powerpc.c         |   21 ++++++++-------------
>  4 files changed, 19 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h
> b/arch/powerpc/include/asm/kvm_ppc.h
> index 6885846..e4474f8 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -404,6 +404,12 @@ static inline void kvmppc_fix_ee_before_entry(void)
>  	trace_hardirqs_on();
>=20
>  #ifdef CONFIG_PPC64
> +	/*
> +	 * To avoid races, the caller must have gone directly from having
> +	 * interrupts fully-enabled to hard-disabled.
> +	 */
> +	WARN_ON(local_paca->irq_happened !=3D PACA_IRQ_HARD_DIS);
> +
>  	/* Only need to enable IRQs by hard enabling them after this */
>  	local_paca->irq_happened =3D 0;
>  	local_paca->soft_enabled =3D 1;
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 0b97ce4..e61e39e 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -884,14 +884,11 @@ program_interrupt:
>  		 * and if we really did time things so badly, then we just exit
>  		 * again due to a host external interrupt.
>  		 */
> -		local_irq_disable();
>  		s =3D kvmppc_prepare_to_enter(vcpu);
> -		if (s <=3D 0) {
> -			local_irq_enable();
> +		if (s <=3D 0)
>  			r =3D s;
> -		} else {
> +		else
>  			kvmppc_fix_ee_before_entry();
> -		}
>  	}
>=20
>  	trace_kvm_book3s_reenter(r, vcpu);
> @@ -1121,12 +1118,9 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struc=
t
> kvm_vcpu *vcpu)
>  	 * really did time things so badly, then we just exit again due to
>  	 * a host external interrupt.
>  	 */
> -	local_irq_disable();
>  	ret =3D kvmppc_prepare_to_enter(vcpu);
> -	if (ret <=3D 0) {
> -		local_irq_enable();
> +	if (ret <=3D 0)
>  		goto out;
> -	}
>=20
>  	/* Save FPU state in stack */
>  	if (current->thread.regs->msr & MSR_FP)
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index eb89b83..f7c0111 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -666,10 +666,8 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct
> kvm_vcpu *vcpu)
>  		return -EINVAL;
>  	}
>=20
> -	local_irq_disable();
>  	s =3D kvmppc_prepare_to_enter(vcpu);
>  	if (s <=3D 0) {
> -		local_irq_enable();
>  		ret =3D s;
>  		goto out;
>  	}
> @@ -1148,14 +1146,11 @@ int kvmppc_handle_exit(struct kvm_run *run, struc=
t
> kvm_vcpu *vcpu,
>  	 * aren't already exiting to userspace for some other reason.
>  	 */
>  	if (!(r & RESUME_HOST)) {
> -		local_irq_disable();

Ok, Now we do not soft disable before kvmppc_prapare_to_enter().

>  		s =3D kvmppc_prepare_to_enter(vcpu);
> -		if (s <=3D 0) {
> -			local_irq_enable();
> +		if (s <=3D 0)
>  			r =3D (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
> -		} else {
> +		else
>  			kvmppc_fix_ee_before_entry();
> -		}
>  	}
>=20
>  	return r;
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 4e05f8c..f8659aa 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -64,12 +64,14 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  {
>  	int r =3D 1;
>=20
> -	WARN_ON_ONCE(!irqs_disabled());
> +	WARN_ON(irqs_disabled());
> +	hard_irq_disable();

Here we hard disable in kvmppc_prepare_to_enter(), so my comment in other p=
atch about interrupt loss is no more valid.

So here
  MSR.EE =3D 0
  local_paca->soft_enabled =3D 0
  local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;

> +
>  	while (true) {
>  		if (need_resched()) {
>  			local_irq_enable();

This will make the state:
  MSR.EE =3D 1
  local_paca->soft_enabled =3D 1
  local_paca->irq_happened =3D PACA_IRQ_HARD_DIS;  //same as before

Is that a valid state where interrupts are fully enabled and irq_happend in=
 not 0?

>  			cond_resched();
> -			local_irq_disable();
> +			hard_irq_disable();
>  			continue;
>  		}
>=20
> @@ -95,7 +97,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  			local_irq_enable();
>  			trace_kvm_check_requests(vcpu);
>  			r =3D kvmppc_core_check_requests(vcpu);
> -			local_irq_disable();
> +			hard_irq_disable();
>  			if (r > 0)
>  				continue;
>  			break;
> @@ -108,21 +110,14 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  		}
>=20
>  #ifdef CONFIG_PPC64
> -		/* lazy EE magic */
> -		hard_irq_disable();
> -		if (lazy_irq_pending()) {
> -			/* Got an interrupt in between, try again */
> -			local_irq_enable();
> -			local_irq_disable();
> -			kvm_guest_exit();
> -			continue;
> -		}
> +		WARN_ON(lazy_irq_pending());
>  #endif
>=20
>  		kvm_guest_enter();
> -		break;
> +		return r;
>  	}
>=20
> +	local_irq_enable();
>  	return r;
>  }


int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
{
        int r =3D 0;
        WARN_ON_ONCE(!irqs_disabled());

        kvmppc_core_check_exceptions(vcpu);

        if (vcpu->requests) {
                /* Exception delivery raised request; start over */
                return 1;
        }

        if (vcpu->arch.shared->msr & MSR_WE) {
                local_irq_enable();
                kvm_vcpu_block(vcpu);
                clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
                local_irq_disable();
^^^
We do not require hard_irq_disable() here?

-Bharat

>  #endif /* CONFIG_KVM_BOOK3S_64_HV */
> --
> 1.7.10.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
