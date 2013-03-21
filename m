Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 78CA22C0104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 21:07:14 +1100 (EST)
Subject: Re: [PATCH] KVM: PPC: e500: Add separate functions for vcpu's MMU
 configuration
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1363713407-27886-1-git-send-email-mihai.caraman@freescale.com>
Date: Thu, 21 Mar 2013 11:07:11 +0100
Message-Id: <90E4FFA9-97C8-4D7D-910E-2E5DB273C88C@suse.de>
References: <1363713407-27886-1-git-send-email-mihai.caraman@freescale.com>
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


On 19.03.2013, at 18:16, Mihai Caraman wrote:

> Move vcpu's MMU default configuration and geometry update into their =
own
> functions.

Mind to explain why?


Alex

>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/e500_mmu.c |   59 =
+++++++++++++++++++++++++++----------------
> 1 files changed, 37 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index 5c44759..66b6e31 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -596,6 +596,20 @@ int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu =
*vcpu, struct kvm_sregs *sregs)
> 	return 0;
> }
>=20
> +static int vcpu_mmu_geometry_update(struct kvm_vcpu *vcpu,
> +		struct kvm_book3e_206_tlb_params *params)
> +{
> +	vcpu->arch.tlbcfg[0] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +	if (params->tlb_sizes[0] <=3D 2048)
> +		vcpu->arch.tlbcfg[0] |=3D params->tlb_sizes[0];
> +	vcpu->arch.tlbcfg[0] |=3D params->tlb_ways[0] << =
TLBnCFG_ASSOC_SHIFT;
> +
> +	vcpu->arch.tlbcfg[1] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +	vcpu->arch.tlbcfg[1] |=3D params->tlb_sizes[1];
> +	vcpu->arch.tlbcfg[1] |=3D params->tlb_ways[1] << =
TLBnCFG_ASSOC_SHIFT;
> +	return 0;	=09
> +}
> +
> int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
> 			      struct kvm_config_tlb *cfg)
> {
> @@ -692,16 +706,8 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu =
*vcpu,
> 	vcpu_e500->gtlb_offset[0] =3D 0;
> 	vcpu_e500->gtlb_offset[1] =3D params.tlb_sizes[0];
>=20
> -	vcpu->arch.mmucfg =3D mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
> -
> -	vcpu->arch.tlbcfg[0] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> -	if (params.tlb_sizes[0] <=3D 2048)
> -		vcpu->arch.tlbcfg[0] |=3D params.tlb_sizes[0];
> -	vcpu->arch.tlbcfg[0] |=3D params.tlb_ways[0] << =
TLBnCFG_ASSOC_SHIFT;
> -
> -	vcpu->arch.tlbcfg[1] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> -	vcpu->arch.tlbcfg[1] |=3D params.tlb_sizes[1];
> -	vcpu->arch.tlbcfg[1] |=3D params.tlb_ways[1] << =
TLBnCFG_ASSOC_SHIFT;
> +	/* Update vcpu's MMU geometry based on SW_TLB input */
> +	vcpu_mmu_geometry_update(vcpu, &params);
>=20
> 	vcpu_e500->shared_tlb_pages =3D pages;
> 	vcpu_e500->num_shared_tlb_pages =3D num_pages;
> @@ -737,6 +743,26 @@ int kvm_vcpu_ioctl_dirty_tlb(struct kvm_vcpu =
*vcpu,
> 	return 0;
> }
>=20
> +/* vcpu's MMU default configuration */
> +static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
> +		       struct kvmppc_e500_tlb_params *params)
> +{
> +	/* Initialize RASIZE, PIDSIZE, NTLBS and MAVN fields with host =
values*/
> +	vcpu->arch.mmucfg =3D mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
> +
> +	/* Initialize IPROT field with host value*/
> +	vcpu->arch.tlbcfg[0] =3D mfspr(SPRN_TLB0CFG) &
> +			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +	vcpu->arch.tlbcfg[0] |=3D params[0].entries;
> +	vcpu->arch.tlbcfg[0] |=3D params[0].ways << TLBnCFG_ASSOC_SHIFT;
> +
> +	vcpu->arch.tlbcfg[1] =3D mfspr(SPRN_TLB1CFG) &
> +			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +	vcpu->arch.tlbcfg[1] |=3D params[1].entries;
> +	vcpu->arch.tlbcfg[1] |=3D params[1].ways << TLBnCFG_ASSOC_SHIFT;
> +	return 0;
> +}
> +
> int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
> {
> 	struct kvm_vcpu *vcpu =3D &vcpu_e500->vcpu;
> @@ -781,18 +807,7 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 =
*vcpu_e500)
> 	if (!vcpu_e500->g2h_tlb1_map)
> 		goto err;
>=20
> -	/* Init TLB configuration register */
> -	vcpu->arch.tlbcfg[0] =3D mfspr(SPRN_TLB0CFG) &
> -			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> -	vcpu->arch.tlbcfg[0] |=3D vcpu_e500->gtlb_params[0].entries;
> -	vcpu->arch.tlbcfg[0] |=3D
> -		vcpu_e500->gtlb_params[0].ways << TLBnCFG_ASSOC_SHIFT;
> -
> -	vcpu->arch.tlbcfg[1] =3D mfspr(SPRN_TLB1CFG) &
> -			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> -	vcpu->arch.tlbcfg[1] |=3D vcpu_e500->gtlb_params[1].entries;
> -	vcpu->arch.tlbcfg[1] |=3D
> -		vcpu_e500->gtlb_params[1].ways << TLBnCFG_ASSOC_SHIFT;
> +	vcpu_mmu_init(vcpu, vcpu_e500->gtlb_params);
>=20
> 	kvmppc_recalc_tlb1map_range(vcpu_e500);
> 	return 0;
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
