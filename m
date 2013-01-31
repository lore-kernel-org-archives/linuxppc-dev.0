Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC54D2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 00:27:20 +1100 (EST)
Subject: Re: [PATCH 3/5] KVM: PPC: e500: Remove E.PT category from VCPUs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1359552584-17861-4-git-send-email-mihai.caraman@freescale.com>
Date: Thu, 31 Jan 2013 14:27:10 +0100
Message-Id: <9CEBFDF3-7674-447E-9847-0CAF8D97BF32@suse.de>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-4-git-send-email-mihai.caraman@freescale.com>
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

> Embedded.Page Table (E.PT) category in VMs requires indirect tlb =
entries
> emulation which is not supported yet. Configure TLBnCFG to remove E.PT
> category from VCPUs.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Please do this in a separate function that you call from these =
locations. That way the code is self-documenting on what it actually =
does.

Also add a comment to this one function that removes E.PT related bits =
from TLBCFG that our _guest_ mmu emulation currently doesn't handle =
E.PT.


Alex

> ---
> arch/powerpc/kvm/e500_mmu.c |   10 ++++++----
> 1 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index 129299a..9a1f7b7 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -692,12 +692,14 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu =
*vcpu,
> 	vcpu_e500->gtlb_offset[0] =3D 0;
> 	vcpu_e500->gtlb_offset[1] =3D params.tlb_sizes[0];
>=20
> -	vcpu->arch.tlbcfg[0] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +	vcpu->arch.tlbcfg[0] &=3D
> +			      ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | =
TLBnCFG_IND);
> 	if (params.tlb_sizes[0] <=3D 2048)
> 		vcpu->arch.tlbcfg[0] |=3D params.tlb_sizes[0];
> 	vcpu->arch.tlbcfg[0] |=3D params.tlb_ways[0] << =
TLBnCFG_ASSOC_SHIFT;
>=20
> -	vcpu->arch.tlbcfg[1] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +	vcpu->arch.tlbcfg[1] &=3D
> +			      ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | =
TLBnCFG_IND);
> 	vcpu->arch.tlbcfg[1] |=3D params.tlb_sizes[1];
> 	vcpu->arch.tlbcfg[1] |=3D params.tlb_ways[1] << =
TLBnCFG_ASSOC_SHIFT;
>=20
> @@ -783,13 +785,13 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 =
*vcpu_e500)
>=20
> 	/* Init TLB configuration register */
> 	vcpu->arch.tlbcfg[0] =3D mfspr(SPRN_TLB0CFG) &
> -			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | =
TLBnCFG_IND);
> 	vcpu->arch.tlbcfg[0] |=3D vcpu_e500->gtlb_params[0].entries;
> 	vcpu->arch.tlbcfg[0] |=3D
> 		vcpu_e500->gtlb_params[0].ways << TLBnCFG_ASSOC_SHIFT;
>=20
> 	vcpu->arch.tlbcfg[1] =3D mfspr(SPRN_TLB1CFG) &
> -			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> +			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC | =
TLBnCFG_IND);
> 	vcpu->arch.tlbcfg[1] |=3D vcpu_e500->gtlb_params[1].entries;
> 	vcpu->arch.tlbcfg[1] |=3D
> 		vcpu_e500->gtlb_params[1].ways << TLBnCFG_ASSOC_SHIFT;
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
