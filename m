Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E4AA2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 08:14:59 +1000 (EST)
Date: Tue, 4 Jun 2013 17:14:48 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 2/6] KVM: PPC: Book3E: Refactor SPE_FP exit handling
To: Mihai Caraman <mihai.caraman@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 <1370292868-2697-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-3-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:24 2013)
Message-ID: <1370384088.748.17@snotra>
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

On 06/03/2013 03:54:24 PM, Mihai Caraman wrote:
> SPE_FP interrupts are shared with ALTIVEC. Refactor SPE_FP exit =20
> handling
> to detect KVM support for the featured unit at run-time, in order to
> accommodate ALTIVEC later.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c |   80 =20
> ++++++++++++++++++++++++++++++++++------------
>  1 files changed, 59 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1020119..d082bbc 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -822,6 +822,15 @@ static void kvmppc_restart_interrupt(struct =20
> kvm_vcpu *vcpu,
>  	}
>  }
>=20
> +static inline bool kvmppc_supports_spe(void)
> +{
> +#ifdef CONFIG_SPE
> +		if (cpu_has_feature(CPU_FTR_SPE))
> +			return true;
> +#endif
> +	return false;
> +}

Whitespace

>  /**
>   * kvmppc_handle_exit
>   *
> @@ -931,42 +940,71 @@ int kvmppc_handle_exit(struct kvm_run *run, =20
> struct kvm_vcpu *vcpu,
>  		r =3D RESUME_GUEST;
>  		break;
>=20
> -#ifdef CONFIG_SPE
>  	case BOOKE_INTERRUPT_SPE_UNAVAIL: {
> -		if (vcpu->arch.shared->msr & MSR_SPE)
> -			kvmppc_vcpu_enable_spe(vcpu);
> -		else
> -			kvmppc_booke_queue_irqprio(vcpu,
> -						   =20
> BOOKE_IRQPRIO_SPE_UNAVAIL);
> +		/*
> +		 * The interrupt is shared, KVM support for the =20
> featured unit
> +		 * is detected at run-time.
> +		 */

This is a decent comment for the changelog, but for the code itself it =20
seems fairly obvious if you look at the definition of =20
kvmppc_supports_spe().

> +		bool handled =3D false;
> +
> +		if (kvmppc_supports_spe()) {
> +#ifdef CONFIG_SPE
> +			if (cpu_has_feature(CPU_FTR_SPE))

Didn't you already check this using kvmppc_supports_spe()?

>  	case BOOKE_INTERRUPT_SPE_FP_ROUND:
> +#ifdef CONFIG_SPE
>  		kvmppc_booke_queue_irqprio(vcpu, =20
> BOOKE_IRQPRIO_SPE_FP_ROUND);
>  		r =3D RESUME_GUEST;
>  		break;

Why not use kvmppc_supports_spe() here, for consistency?

-Scott=
