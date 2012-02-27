Return-Path: <R65777@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DC6EB6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 03:35:04 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexander Graf <agraf@suse.de>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
Date: Mon, 27 Feb 2012 16:34:54 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D141083@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-25-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-25-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Beh=
alf Of
> Alexander Graf
> Sent: Friday, February 24, 2012 7:56 PM
> To: kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421
> Subject: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
>=20
> Instead of checking whether we should reschedule only when we exited due =
to an
> interrupt, let's always check before entering the guest back again. This =
gets
> the target more in line with the other archs.
>=20
> Also while at it, generalize the whole thing so that eventually we could =
have a
> single kvmppc_prepare_to_enter function for all ppc targets that does sig=
nal and
> reschedule checking for us.
>=20
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h |    2 +-
>  arch/powerpc/kvm/book3s.c          |    4 ++-
>  arch/powerpc/kvm/booke.c           |   70 ++++++++++++++++++++++++------=
-----
>  3 files changed, 52 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h
> b/arch/powerpc/include/asm/kvm_ppc.h
> index e709975..7f0a3da 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -95,7 +95,7 @@ extern int kvmppc_core_vcpu_translate(struct kvm_vcpu *=
vcpu,
> extern void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu);  exter=
n void
> kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu);
>=20
> -extern void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu);
> +extern int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu);
>  extern int kvmppc_core_pending_dec(struct kvm_vcpu *vcpu);  extern void
> kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags);  extern vo=
id
> kvmppc_core_queue_dec(struct kvm_vcpu *vcpu); diff --git
> a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c index 7d54f4e..c8=
ead7b
> 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -258,7 +258,7 @@ static bool clear_irqprio(struct kvm_vcpu *vcpu, unsi=
gned
> int priority)
>  	return true;
>  }
>=20
> -void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
> +int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long *pending =3D &vcpu->arch.pending_exceptions;
>  	unsigned long old_pending =3D vcpu->arch.pending_exceptions; @@ -283,6
> +283,8 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>=20
>  	/* Tell the guest about our interrupt status */
>  	kvmppc_update_int_pending(vcpu, *pending, old_pending);
> +
> +	return 0;
>  }
>=20
>  pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn) diff --git
> a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c index 9979be1..3fce=
c2c
> 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -439,8 +439,9 @@ static void kvmppc_core_check_exceptions(struct kvm_v=
cpu
> *vcpu)  }
>=20
>  /* Check pending exceptions and deliver one, if possible. */ -void
> kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
> +int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>  {
> +	int r =3D 0;
>  	WARN_ON_ONCE(!irqs_disabled());
>=20
>  	kvmppc_core_check_exceptions(vcpu);
> @@ -451,8 +452,44 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu *v=
cpu)
>  		local_irq_disable();
>=20
>  		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
> -		kvmppc_core_check_exceptions(vcpu);
> +		r =3D 1;
>  	};
> +
> +	return r;
> +}
> +
> +/*
> + * Common checks before entering the guest world.  Call with interrupts
> + * disabled.
> + *
> + * returns !0 if a signal is pending and check_signal is true  */
> +static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool
> +check_signal) {
> +	int r =3D 0;
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

kvmppc_prepare_to_enter() is called even on heavyweight_exit. Should not th=
is be called only on lightweight_exit?

Thanks
-Bharat

> +			/* interrupts got enabled in between, so we
> +			   are back at square 1 */
> +			continue;
> +		}
> +
> +		if (check_signal && signal_pending(current))
> +			r =3D 1;
> +
> +		break;
> +	}
> +
> +	return r;
>  }
>=20
>  int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu) @@ -=
470,10
> +507,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *v=
cpu)
>  	}
>=20
>  	local_irq_disable();
> -
> -	kvmppc_core_prepare_to_enter(vcpu);
> -
> -	if (signal_pending(current)) {
> +	if (kvmppc_prepare_to_enter(vcpu, true)) {
>  		kvm_run->exit_reason =3D KVM_EXIT_INTR;
>  		ret =3D -EINTR;
>  		goto out;
> @@ -598,25 +632,21 @@ int kvmppc_handle_exit(struct kvm_run *run, struct
> kvm_vcpu *vcpu,
>=20
>  	switch (exit_nr) {
>  	case BOOKE_INTERRUPT_MACHINE_CHECK:
> -		kvm_resched(vcpu);
>  		r =3D RESUME_GUEST;
>  		break;
>=20
>  	case BOOKE_INTERRUPT_EXTERNAL:
>  		kvmppc_account_exit(vcpu, EXT_INTR_EXITS);
> -		kvm_resched(vcpu);
>  		r =3D RESUME_GUEST;
>  		break;
>=20
>  	case BOOKE_INTERRUPT_DECREMENTER:
>  		kvmppc_account_exit(vcpu, DEC_EXITS);
> -		kvm_resched(vcpu);
>  		r =3D RESUME_GUEST;
>  		break;
>=20
>  	case BOOKE_INTERRUPT_DOORBELL:
>  		kvmppc_account_exit(vcpu, DBELL_EXITS);
> -		kvm_resched(vcpu);
>  		r =3D RESUME_GUEST;
>  		break;
>=20
> @@ -865,19 +895,15 @@ int kvmppc_handle_exit(struct kvm_run *run, struct
> kvm_vcpu *vcpu,
>  		BUG();
>  	}
>=20
> +	/*
> +	 * To avoid clobbering exit_reason, only check for signals if we
> +	 * aren't already exiting to userspace for some other reason.
> +	 */
>  	local_irq_disable();
> -
> -	kvmppc_core_prepare_to_enter(vcpu);
> -
> -	if (!(r & RESUME_HOST)) {
> -		/* To avoid clobbering exit_reason, only check for signals if
> -		 * we aren't already exiting to userspace for some other
> -		 * reason. */
> -		if (signal_pending(current)) {
> -			run->exit_reason =3D KVM_EXIT_INTR;
> -			r =3D (-EINTR << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
> -			kvmppc_account_exit(vcpu, SIGNAL_EXITS);
> -		}
> +	if (kvmppc_prepare_to_enter(vcpu, !(r & RESUME_HOST))) {
> +		run->exit_reason =3D KVM_EXIT_INTR;
> +		r =3D (-EINTR << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
> +		kvmppc_account_exit(vcpu, SIGNAL_EXITS);
>  	}
>=20
>  	return r;
> --
> 1.6.0.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in the bod=
y of a
> message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
