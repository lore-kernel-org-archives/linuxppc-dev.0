Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBE062C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 00:31:25 +1100 (EST)
Subject: Re: [PATCH 4/5] KVM: PPC: e500: Emulate EPTCFG register
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1359552584-17861-5-git-send-email-mihai.caraman@freescale.com>
Date: Thu, 31 Jan 2013 14:31:15 +0100
Message-Id: <911274D3-9188-45A5-81B0-643F5DB21653@suse.de>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-5-git-send-email-mihai.caraman@freescale.com>
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


On 30.01.2013, at 14:29, Mihai Caraman wrote:

> EPTCFG register defined by E.PT is accessed unconditionally by Linux =
guests
> in the presence of MAV 2.0. Emulate EPTCFG register now.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/include/asm/kvm_host.h |    1 +
> arch/powerpc/kvm/e500.h             |    6 ++++++
> arch/powerpc/kvm/e500_emulate.c     |    9 +++++++++
> arch/powerpc/kvm/e500_mmu.c         |    5 +++++
> 4 files changed, 21 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index 88fcfe6..f480b20 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -503,6 +503,7 @@ struct kvm_vcpu_arch {
> 	u32 tlbcfg[4];
> 	u32 tlbps[4];
> 	u32 mmucfg;
> +	u32 eptcfg;

This too needs to be settable through SW_TLB.

> 	u32 epr;
> 	struct kvmppc_booke_debug_reg dbg_reg;
> #endif
> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> index b9f76d8..983eb95 100644
> --- a/arch/powerpc/kvm/e500.h
> +++ b/arch/powerpc/kvm/e500.h
> @@ -308,4 +308,10 @@ static inline unsigned int has_mmu_v2(const =
struct kvm_vcpu *vcpu)
> 	return ((vcpu->arch.mmucfg & MMUCFG_MAVN) =3D=3D =
MMUCFG_MAVN_V2);
> }
>=20
> +static inline unsigned int supports_page_tables(const struct kvm_vcpu =
*vcpu)

bool again. Can we generalize this a bit more? How about a small =
framework that allows us to differentiate across e.XX features?

if (has_feature(vcpu, FEATURE_E_PT))
   ...


> +{
> +	return ((vcpu->arch.tlbcfg[0] & TLBnCFG_IND)
> +		|| (vcpu->arch.tlbcfg[1] & TLBnCFG_IND));
> +}
> +
> #endif /* KVM_E500_H */
> diff --git a/arch/powerpc/kvm/e500_emulate.c =
b/arch/powerpc/kvm/e500_emulate.c
> index 5515dc5..493e231 100644
> --- a/arch/powerpc/kvm/e500_emulate.c
> +++ b/arch/powerpc/kvm/e500_emulate.c
> @@ -339,6 +339,15 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu =
*vcpu, int sprn, ulong *spr_val)
> 			return EMULATE_FAIL;
> 		*spr_val =3D vcpu->arch.tlbps[1];
> 		break;
> +	case SPRN_EPTCFG:
> +		if (!has_mmu_v2(vcpu))
> +			return EMULATE_FAIL;
> +		/*
> +		 * Legacy Linux guests access EPTCFG register even if =
the E.PT
> +		 * category is disabled in the VM. Give them a chance to =
live.
> +		 */
> +		*spr_val =3D vcpu->arch.eptcfg;
> +		break;
> 	default:
> 		emulated =3D kvmppc_booke_emulate_mfspr(vcpu, sprn, =
spr_val);
> 	}
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index 9a1f7b7..199c11e 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -799,6 +799,11 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 =
*vcpu_e500)
> 	if (has_mmu_v2(vcpu)) {
> 		vcpu->arch.tlbps[0] =3D mfspr(SPRN_TLB0PS);
> 		vcpu->arch.tlbps[1] =3D mfspr(SPRN_TLB1PS);
> +
> +		if (supports_page_tables(vcpu))
> +			vcpu->arch.eptcfg =3D mfspr(SPRN_EPTCFG);

Please don't introduce new mfspr()s here :). Just have user space set =
it.


Alex

> +		else
> +			vcpu->arch.eptcfg =3D 0;
> 	}
>=20
> 	kvmppc_recalc_tlb1map_range(vcpu_e500);
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
