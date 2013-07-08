Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id B117B2C016A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 04:46:04 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372858255-19708-2-git-send-email-mihai.caraman@freescale.com>
Date: Mon, 8 Jul 2013 20:45:58 +0200
Message-Id: <1C2B7183-EF0F-4D97-9287-1068C9E97471@suse.de>
References: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
 <1372858255-19708-2-git-send-email-mihai.caraman@freescale.com>
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


On 03.07.2013, at 15:30, Mihai Caraman wrote:

> Some guests are making use of return from machine check instruction
> to do crazy things even though the 64-bit kernel doesn't handle yet
> this interrupt. Emulate MCSRR0/1 SPR and rfmci instruction =
accordingly.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/include/asm/kvm_host.h |    1 +
> arch/powerpc/kvm/booke_emulate.c    |   25 +++++++++++++++++++++++++
> arch/powerpc/kvm/timing.c           |    1 +
> 3 files changed, 27 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index af326cd..0466789 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -148,6 +148,7 @@ enum kvm_exit_types {
> 	EMULATED_TLBWE_EXITS,
> 	EMULATED_RFI_EXITS,
> 	EMULATED_RFCI_EXITS,
> +	EMULATED_RFMCI_EXITS,

I would quite frankly prefer to see us abandon the whole exit timing =
framework in the kernel and instead use trace points. Then we don't have =
to maintain all of this randomly exercised code.

FWIW I think in this case however, treating RFMCI the same as RFI or =
random "instruction emulation" shouldn't hurt. This whole table is only =
about timing measurements. If you want to know for real what's going on, =
use trace points.

Otherwise looks good.


Alex

> 	DEC_EXITS,
> 	EXT_INTR_EXITS,
> 	HALT_WAKEUP,
> diff --git a/arch/powerpc/kvm/booke_emulate.c =
b/arch/powerpc/kvm/booke_emulate.c
> index 27a4b28..aaff1b7 100644
> --- a/arch/powerpc/kvm/booke_emulate.c
> +++ b/arch/powerpc/kvm/booke_emulate.c
> @@ -23,6 +23,7 @@
>=20
> #include "booke.h"
>=20
> +#define OP_19_XOP_RFMCI   38
> #define OP_19_XOP_RFI     50
> #define OP_19_XOP_RFCI    51
>=20
> @@ -43,6 +44,12 @@ static void kvmppc_emul_rfci(struct kvm_vcpu *vcpu)
> 	kvmppc_set_msr(vcpu, vcpu->arch.csrr1);
> }
>=20
> +static void kvmppc_emul_rfmci(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.pc =3D vcpu->arch.mcsrr0;
> +	kvmppc_set_msr(vcpu, vcpu->arch.mcsrr1);
> +}
> +
> int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu =
*vcpu,
>                             unsigned int inst, int *advance)
> {
> @@ -65,6 +72,12 @@ int kvmppc_booke_emulate_op(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 			*advance =3D 0;
> 			break;
>=20
> +		case OP_19_XOP_RFMCI:
> +			kvmppc_emul_rfmci(vcpu);
> +			kvmppc_set_exit_type(vcpu, =
EMULATED_RFMCI_EXITS);
> +			*advance =3D 0;
> +			break;
> +
> 		default:
> 			emulated =3D EMULATE_FAIL;
> 			break;
> @@ -138,6 +151,12 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu =
*vcpu, int sprn, ulong spr_val)
> 	case SPRN_DBCR1:
> 		vcpu->arch.dbg_reg.dbcr1 =3D spr_val;
> 		break;
> +	case SPRN_MCSRR0:
> +		vcpu->arch.mcsrr0 =3D spr_val;
> +		break;
> +	case SPRN_MCSRR1:
> +		vcpu->arch.mcsrr1 =3D spr_val;
> +		break;
> 	case SPRN_DBSR:
> 		vcpu->arch.dbsr &=3D ~spr_val;
> 		break;
> @@ -284,6 +303,12 @@ int kvmppc_booke_emulate_mfspr(struct kvm_vcpu =
*vcpu, int sprn, ulong *spr_val)
> 	case SPRN_DBCR1:
> 		*spr_val =3D vcpu->arch.dbg_reg.dbcr1;
> 		break;
> +	case SPRN_MCSRR0:
> +		*spr_val =3D vcpu->arch.mcsrr0;
> +		break;
> +	case SPRN_MCSRR1:
> +		*spr_val =3D vcpu->arch.mcsrr1;
> +		break;
> 	case SPRN_DBSR:
> 		*spr_val =3D vcpu->arch.dbsr;
> 		break;
> diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
> index c392d26..670f63d 100644
> --- a/arch/powerpc/kvm/timing.c
> +++ b/arch/powerpc/kvm/timing.c
> @@ -129,6 +129,7 @@ static const char =
*kvm_exit_names[__NUMBER_OF_KVM_EXIT_TYPES] =3D {
> 	[EMULATED_TLBSX_EXITS] =3D    "EMUL_TLBSX",
> 	[EMULATED_TLBWE_EXITS] =3D    "EMUL_TLBWE",
> 	[EMULATED_RFI_EXITS] =3D      "EMUL_RFI",
> +	[EMULATED_RFMCI_EXITS] =3D    "EMUL_RFMCI",
> 	[DEC_EXITS] =3D               "DEC",
> 	[EXT_INTR_EXITS] =3D          "EXTINT",
> 	[HALT_WAKEUP] =3D             "HALT",
> --=20
> 1.7.3.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
