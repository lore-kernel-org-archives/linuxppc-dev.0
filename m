Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BFAA2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 08:36:19 +1000 (EST)
Date: Tue, 4 Jun 2013 17:36:05 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-5-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:26 2013)
Message-ID: <1370385365.748.19@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2013 03:54:26 PM, Mihai Caraman wrote:
> KVM Book3E FPU support gracefully reuse host infrastructure so we do =20
> the
> same for AltiVec. To keep AltiVec lazy call =20
> kvmppc_load_guest_altivec()
> just when returning to guest instead of each sched in.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c  |   74 =20
> +++++++++++++++++++++++++++++++++++++++++++-
>  arch/powerpc/kvm/e500mc.c |    8 +++++
>  2 files changed, 80 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index c08b04b..01eb635 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -134,6 +134,23 @@ static void kvmppc_vcpu_sync_fpu(struct kvm_vcpu =20
> *vcpu)
>  }
>=20
>  /*
> + * Simulate AltiVec unavailable fault to load guest state
> + * from thread to AltiVec unit.
> + * It requires to be called with preemption disabled.
> + */
> +static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
> +{
> +#ifdef CONFIG_ALTIVEC
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
> +		if (!(current->thread.regs->msr & MSR_VEC)) {
> +			load_up_altivec(NULL);
> +			current->thread.regs->msr |=3D MSR_VEC;
> +		}
> +	}
> +#endif

Why not use kvmppc_supports_altivec()?  In fact, there's nothing =20
KVM-specific about these functions...

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

Whitespace

>  static inline bool kvmppc_supports_spe(void)
>  {
>  #ifdef CONFIG_SPE
> @@ -947,7 +1016,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =20
> struct kvm_vcpu *vcpu,
>  		 */
>  		bool handled =3D false;
>=20
> -		if (kvmppc_supports_spe()) {
> +		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) =20
> {
>  #ifdef CONFIG_SPE
>  			if (cpu_has_feature(CPU_FTR_SPE))
>  				if (vcpu->arch.shared->msr & MSR_SPE) {
> @@ -976,7 +1045,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =20
> struct kvm_vcpu *vcpu,
>  		 * The interrupt is shared, KVM support for the =20
> featured unit
>  		 * is detected at run-time.
>  		 */
> -		if (kvmppc_supports_spe()) {
> +		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) =20
> {
>  			kvmppc_booke_queue_irqprio(vcpu,
>  				=20
> BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
>  			r =3D RESUME_GUEST;

The distinction between how you're handling SPE and Altivec here =20
doesn't really have anything to do with SPE versus Altivec -- it's =20
PR-mode versus HV-mode.

> @@ -1188,6 +1257,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =20
> struct kvm_vcpu *vcpu,
>  			r =3D (s << 2) | RESUME_HOST | (r & =20
> RESUME_FLAG_NV);
>  		} else {
>  			kvmppc_lazy_ee_enable();
> +			kvmppc_load_guest_altivec(vcpu);
>  		}
>  	}
>=20

Why do you need to call an Altivec function here if we don't need to =20
call an ordinary FPU function here?

-Scott=
