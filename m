Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC7832C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 08:40:32 +1000 (EST)
Date: Tue, 4 Jun 2013 17:40:22 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 5/6] KVM: PPC: Book3E: Add ONE_REG AltiVec support
To: Mihai Caraman <mihai.caraman@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 <1370292868-2697-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-6-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:27 2013)
Message-ID: <1370385622.748.21@snotra>
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

On 06/03/2013 03:54:27 PM, Mihai Caraman wrote:
> Add ONE_REG support for AltiVec on Book3E.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 01eb635..019496d 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1570,6 +1570,22 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu =20
> *vcpu, struct kvm_one_reg *reg)
>  	case KVM_REG_PPC_DEBUG_INST:
>  		val =3D get_reg_val(reg->id, KVMPPC_INST_EHPRIV);
>  		break;
> +#ifdef CONFIG_ALTIVEC
> +	case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
> +		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
> +			r =3D -ENXIO;
> +			break;
> +		}
> +		val.vval =3D vcpu->arch.vr[reg->id - KVM_REG_PPC_VR0];
> +		break;
> +	case KVM_REG_PPC_VSCR:
> +		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
> +			r =3D -ENXIO;
> +			break;
> +		}
> +		val =3D get_reg_val(reg->id, vcpu->arch.vscr.u[3]);
> +		break;

Why u[3]?

-Scott=
