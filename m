Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id D66A62C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 01:17:10 +1000 (EST)
Subject: Re: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 3 Jul 2013 17:17:05 +0200
Message-Id: <BE4790D6-AC7E-4483-9853-139B8BFBCFD7@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
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

> Add KVM Book3E AltiVec support. KVM Book3E FPU support gracefully =
reuse host
> infrastructure so follow the same approach for AltiVec.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/booke.c |   72 =
++++++++++++++++++++++++++++++++++++++++++++-
> 1 files changed, 70 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 3cae2e3..c3c3af6 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -98,6 +98,19 @@ static inline bool kvmppc_supports_spe(void)
> 	return false;
> }
>=20
> +/*
> + * Always returns true is AltiVec unit is present, see
> + * kvmppc_core_check_processor_compat().
> + */
> +static inline bool kvmppc_supports_altivec(void)
> +{
> +#ifdef CONFIG_ALTIVEC
> +		if (cpu_has_feature(CPU_FTR_ALTIVEC))
> +			return true;
> +#endif
> +	return false;
> +}
> +
> #ifdef CONFIG_SPE
> void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
> {
> @@ -151,6 +164,21 @@ static void kvmppc_vcpu_sync_fpu(struct kvm_vcpu =
*vcpu)
> }
>=20
> /*
> + * Simulate AltiVec unavailable fault to load guest state
> + * from thread to AltiVec unit.
> + * It requires to be called with preemption disabled.
> + */
> +static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
> +{
> +	if (kvmppc_supports_altivec()) {
> +		if (!(current->thread.regs->msr & MSR_VEC)) {
> +			load_up_altivec(NULL);
> +			current->thread.regs->msr |=3D MSR_VEC;

Does this ensure that the kernel saves / restores all altivec state on =
task switch? Does it load it again when it schedules us in? Would =
definitely be worth a comment.

> +		}
> +	}
> +}
> +
> +/*
>  * Helper function for "full" MSR writes.  No need to call this if =
only
>  * EE/CE/ME/DE/RI are changing.
>  */
> @@ -678,6 +706,12 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =
struct kvm_vcpu *vcpu)
> 	u64 fpr[32];
> #endif
>=20
> +#ifdef CONFIG_ALTIVEC
> +	vector128 vr[32];
> +	vector128 vscr;
> +	int used_vr =3D 0;

bool

> +#endif
> +
> 	if (!vcpu->arch.sane) {
> 		kvm_run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
> 		return -EINVAL;
> @@ -716,6 +750,22 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =
struct kvm_vcpu *vcpu)
> 	kvmppc_load_guest_fp(vcpu);
> #endif
>=20
> +#ifdef CONFIG_ALTIVEC

/* Switch from user space Altivec to guest Altivec state */

> +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {

Why not use your kvmppc_supports_altivec() helper here?

> +		/* Save userspace VEC state in stack */
> +		enable_kernel_altivec();

Can't you hide this in the load function? We only want to enable kernel =
altivec for a short time while we shuffle the registers around.

> +		memcpy(vr, current->thread.vr, =
sizeof(current->thread.vr));

vr =3D current->thread.vr;

> +		vscr =3D current->thread.vscr;
> +		used_vr =3D current->thread.used_vr;
> +
> +		/* Restore guest VEC state to thread */
> +		memcpy(current->thread.vr, vcpu->arch.vr, =
sizeof(vcpu->arch.vr));

current->thread.vr =3D vcpu->arch.vr;

> +		current->thread.vscr =3D vcpu->arch.vscr;
> +
> +		kvmppc_load_guest_altivec(vcpu);
> +	}

Do we need to do this even when the guest doesn't use Altivec? Can't we =
just load it on demand then once we fault? This code path really should =
only be a prefetch enable when MSR_VEC is already set in guest context.

> +#endif
> +
> 	ret =3D __kvmppc_vcpu_run(kvm_run, vcpu);
>=20
> 	/* No need for kvm_guest_exit. It's done in handle_exit.
> @@ -736,6 +786,23 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =
struct kvm_vcpu *vcpu)
> 	current->thread.fpexc_mode =3D fpexc_mode;
> #endif
>=20
> +#ifdef CONFIG_ALTIVEC

/* Switch from guest Altivec to user space Altivec state */

> +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
> +		/* Save AltiVec state to thread */
> +		if (current->thread.regs->msr & MSR_VEC)
> +			giveup_altivec(current);
> +
> +		/* Save guest state */
> +		memcpy(vcpu->arch.vr, current->thread.vr, =
sizeof(vcpu->arch.vr));
> +		vcpu->arch.vscr =3D current->thread.vscr;
> +
> +		/* Restore userspace state */
> +		memcpy(current->thread.vr, vr, =
sizeof(current->thread.vr));
> +		current->thread.vscr =3D vscr;
> +		current->thread.used_vr =3D used_vr;
> +	}

Same comments here. If the guest never touched Altivec state, don't =
bother restoring it, as it's still good.


Alex

> +#endif
> +
> out:
> 	vcpu->mode =3D OUTSIDE_GUEST_MODE;
> 	return ret;
> @@ -961,7 +1028,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 		break;
>=20
> 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
> -		if (kvmppc_supports_spe()) {
> +		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) =
{
> 			bool enabled =3D false;
>=20
> #ifndef CONFIG_KVM_BOOKE_HV
> @@ -987,7 +1054,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 	}
>=20
> 	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
> -		if (kvmppc_supports_spe()) {
> +		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) =
{
> 			kvmppc_booke_queue_irqprio(vcpu,
> 				=
BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
> 			r =3D RESUME_GUEST;
> @@ -1205,6 +1272,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 		} else {
> 			kvmppc_lazy_ee_enable();
> 			kvmppc_load_guest_fp(vcpu);
> +			kvmppc_load_guest_altivec(vcpu);
> 		}
> 	}
>=20
> --=20
> 1.7.3.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
