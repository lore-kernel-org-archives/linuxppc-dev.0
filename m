Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5AB672C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 04:22:04 +1100 (EST)
Subject: Re: [PATCH 4/7 v2] KVM: PPC: e500: Add support for EPTCFG register
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1364335512-28426-5-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 27 Mar 2013 18:21:58 +0100
Message-Id: <A7A78B5F-10C8-4136-AB2A-4CBA4FE2F9BB@suse.de>
References: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
 <1364335512-28426-5-git-send-email-mihai.caraman@freescale.com>
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


On 26.03.2013, at 23:05, Mihai Caraman wrote:

> EPTCFG register defined by E.PT is accessed unconditionally by Linux =
guests
> in the presence of MAV 2.0. Support it now.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v2:
> - Use has_feature() function
>=20
> Documentation/virtual/kvm/api.txt   |    1 +
> arch/powerpc/include/asm/kvm_host.h |    1 +
> arch/powerpc/include/uapi/asm/kvm.h |    1 +
> arch/powerpc/kvm/e500.h             |    5 +++++
> arch/powerpc/kvm/e500_emulate.c     |    9 +++++++++
> arch/powerpc/kvm/e500_mmu.c         |   11 +++++++++++
> 6 files changed, 28 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt =
b/Documentation/virtual/kvm/api.txt
> index f045377..a1f2200 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1807,6 +1807,7 @@ registers, find a list below:
>   PPC   | KVM_REG_PPC_TLB1PS	| 32
>   PPC   | KVM_REG_PPC_TLB2PS	| 32
>   PPC   | KVM_REG_PPC_TLB3PS	| 32
> +  PPC   | KVM_REG_PPC_EPTCFG	| 32
>=20
> ARM registers are mapped using the lower 32 bits.  The upper 16 of =
that
> is the register group type, or coprocessor number:
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index 3b6cee3..8a48e68 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -504,6 +504,7 @@ struct kvm_vcpu_arch {
> 	u32 tlbcfg[4];
> 	u32 tlbps[4];
> 	u32 mmucfg;
> +	u32 eptcfg;
> 	u32 epr;
> 	u32 crit_save;
> 	struct kvmppc_booke_debug_reg dbg_reg;
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h =
b/arch/powerpc/include/uapi/asm/kvm.h
> index 7cfd13f..9d7fbf0 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -443,4 +443,5 @@ struct kvm_get_htab_header {
> #define KVM_REG_PPC_TLB1PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x97)
> #define KVM_REG_PPC_TLB2PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x98)
> #define KVM_REG_PPC_TLB3PS	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x99)
> +#define KVM_REG_PPC_EPTCFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x9a)
> #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> index 795934d..6cfc669 100644
> --- a/arch/powerpc/kvm/e500.h
> +++ b/arch/powerpc/kvm/e500.h
> @@ -24,6 +24,7 @@
> #include <asm/tlb.h>
>=20
> #define VCPU_FTR_MMU_V2		0
> +#define VCPU_FTR_E_PT		1
>=20
> #define E500_PID_NUM   3
> #define E500_TLB_NUM   2
> @@ -309,6 +310,10 @@ static inline bool has_feature(const struct =
kvm_vcpu *vcpu,
> 	case VCPU_FTR_MMU_V2:
> 		has_ftr =3D ((vcpu->arch.mmucfg & MMUCFG_MAVN) =3D=3D =
MMUCFG_MAVN_V2);
> 		break;
> +	case VCPU_FTR_E_PT:
> +		has_ftr =3D ((vcpu->arch.tlbcfg[1] & TLBnCFG_IND) &&
> +			   (vcpu->arch.tlbcfg[0] & TLBnCFG_PT));
> +		break;
> 	default:
> 		has_ftr =3D false;
> 	}
> diff --git a/arch/powerpc/kvm/e500_emulate.c =
b/arch/powerpc/kvm/e500_emulate.c
> index 12b8de2..b10a012 100644
> --- a/arch/powerpc/kvm/e500_emulate.c
> +++ b/arch/powerpc/kvm/e500_emulate.c
> @@ -317,6 +317,15 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu =
*vcpu, int sprn, ulong *spr_val)
> 	case SPRN_MMUCFG:
> 		*spr_val =3D vcpu->arch.mmucfg;
> 		break;
> +	case SPRN_EPTCFG:
> +		if (!has_feature(vcpu, VCPU_FTR_MMU_V2))
> +			return EMULATE_FAIL;
> +		/*
> +		 * Legacy Linux guests access EPTCFG register even if =
the E.PT
> +		 * category is disabled in the VM. Give them a chance to =
live.
> +		 */
> +		*spr_val =3D vcpu->arch.eptcfg;
> +		break;
>=20
> 	/* extra exceptions */
> 	case SPRN_IVOR32:
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index e354fa1..cf60db1 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -617,6 +617,8 @@ int kvmppc_get_one_reg_e500_tlb(struct kvm_vcpu =
*vcpu, u64 id,
> 		*val =3D get_reg_val(id, vcpu->arch.shared->mas6);
> 	case KVM_REG_PPC_MMUCFG:
> 		*val =3D get_reg_val(id, vcpu->arch.mmucfg);
> +	case KVM_REG_PPC_EPTCFG:
> +		*val =3D get_reg_val(id, vcpu->arch.eptcfg);
> 	case KVM_REG_PPC_TLB0CFG:
> 	case KVM_REG_PPC_TLB1CFG:
> 	case KVM_REG_PPC_TLB2CFG:
> @@ -668,6 +670,10 @@ int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu =
*vcpu, u64 id,
> 			r =3D -EINVAL;
> 		break;
> 	}
> +	case KVM_REG_PPC_EPTCFG:
> +		if (set_reg_val(id, *val) !=3D vcpu->arch.eptcfg)
> +			r =3D -EINVAL;
> +		break;
> 	case KVM_REG_PPC_TLB0CFG:
> 	case KVM_REG_PPC_TLB1CFG:
> 	case KVM_REG_PPC_TLB2CFG:
> @@ -861,6 +867,11 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
> 	vcpu->arch.tlbcfg[1] |=3D params[1].ways << TLBnCFG_ASSOC_SHIFT;
>=20
> 	if (has_feature(vcpu, VCPU_FTR_MMU_V2)) {
> +		if (has_feature(vcpu, VCPU_FTR_E_PT))
> +			vcpu->arch.eptcfg =3D mfspr(SPRN_EPTCFG);

Can't we just always set it to 0?


Alex

> +		else
> +			vcpu->arch.eptcfg =3D 0;
> +
> 		vcpu->arch.tlbps[0] =3D mfspr(SPRN_TLB0PS);
> 		vcpu->arch.tlbps[1] =3D mfspr(SPRN_TLB1PS);
> 	}
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
