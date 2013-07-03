Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id CD69B2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 23:30:25 +1000 (EST)
Subject: Re: [PATCH 2/6] KVM: PPC: Book3E: Refactor SPE/FP exit handling
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372855359-13452-3-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 3 Jul 2013 15:30:19 +0200
Message-Id: <97D96A79-E1E8-47FE-82DB-378AD7869C61@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-3-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 14:42, Mihai Caraman wrote:

> SPE/FP/AltiVec interrupts share the same numbers. Refactor SPE/FP exit =
handling
> to accommodate AltiVec later. Detect the targeted unit at run time =
since it can
> be configured in the kernel but not featured on hardware.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/booke.c |  102 =
+++++++++++++++++++++++++++++++---------------
> arch/powerpc/kvm/booke.h |    1 +
> 2 files changed, 70 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index fb47e85..113961f 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -89,6 +89,15 @@ void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
> 	}
> }
>=20
> +static inline bool kvmppc_supports_spe(void)
> +{
> +#ifdef CONFIG_SPE
> +		if (cpu_has_feature(CPU_FTR_SPE))
> +			return true;
> +#endif
> +	return false;
> +}
> +
> #ifdef CONFIG_SPE
> void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
> {
> @@ -99,7 +108,7 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
> 	preempt_enable();
> }
>=20
> -static void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
> +void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
> {
> 	preempt_disable();
> 	enable_kernel_spe();
> @@ -118,6 +127,14 @@ static void kvmppc_vcpu_sync_spe(struct kvm_vcpu =
*vcpu)
> 	}
> }
> #else
> +void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> static void kvmppc_vcpu_sync_spe(struct kvm_vcpu *vcpu)
> {
> }
> @@ -943,48 +960,67 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 		r =3D RESUME_GUEST;
> 		break;
>=20
> -#ifdef CONFIG_SPE
> 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
> -		if (vcpu->arch.shared->msr & MSR_SPE)
> -			kvmppc_vcpu_enable_spe(vcpu);
> -		else
> -			kvmppc_booke_queue_irqprio(vcpu,
> -						   =
BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
> +		if (kvmppc_supports_spe()) {
> +			bool enabled =3D false;
> +
> +#ifndef CONFIG_KVM_BOOKE_HV
> +			if (vcpu->arch.shared->msr & MSR_SPE) {
> +				kvmppc_vcpu_enable_spe(vcpu);
> +				enabled =3D true;
> +			}
> +#endif

Why the #ifdef? On HV capable systems kvmppc_supports_spe() will just =
always return false. And I don't really understand why HV would be =
special in the first place here. Is it because we're accessing =
shared->msr?

> +			if (!enabled)
> +				kvmppc_booke_queue_irqprio(vcpu,
> +					=
BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
> +		} else {
> +			/*
> +			 * Guest wants SPE, but host kernel doesn't =
support it.

host kernel or hardware


Alex
