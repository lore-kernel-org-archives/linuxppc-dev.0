Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id C3FE02C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 04:23:36 +1100 (EST)
Subject: Re: [PATCH 5/7 v2] KVM: PPC: e500: Remove E.PT and E.HV.LRAT
 categories from VCPUs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1364335512-28426-6-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 27 Mar 2013 18:23:31 +0100
Message-Id: <C1061902-E434-45CC-896D-F766F3CAEEA2@suse.de>
References: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
 <1364335512-28426-6-git-send-email-mihai.caraman@freescale.com>
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

> Embedded.Page Table (E.PT) category in VMs requires indirect tlb =
entries
> emulation which is not supported yet. Configure TLBnCFG to remove E.PT
> and E.HV.LRAT categories from VCPUs.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v2:
> - Remove E.HV.LRAT from vcpus
>=20
> arch/powerpc/kvm/e500_mmu.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index cf60db1..0d2a293 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -867,11 +867,17 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
> 	vcpu->arch.tlbcfg[1] |=3D params[1].ways << TLBnCFG_ASSOC_SHIFT;
>=20
> 	if (has_feature(vcpu, VCPU_FTR_MMU_V2)) {
> +		vcpu->arch.mmucfg &=3D ~MMUCFG_LRAT;
> +
> 		if (has_feature(vcpu, VCPU_FTR_E_PT))
> 			vcpu->arch.eptcfg =3D mfspr(SPRN_EPTCFG);
> 		else
> 			vcpu->arch.eptcfg =3D 0;
>=20
> +		/* Guest mmu emulation currently doesn't handle E.PT */
> +		vcpu->arch.tlbcfg[0] &=3D ~TLBnCFG_PT;
> +		vcpu->arch.tlbcfg[1] &=3D ~TLBnCFG_IND;

Can we make this conditional on bits in EPTCFG? Then by initializing it =
to 0 today, we always mask PT/IND out, but later when we support EPT, we =
only have to set the bit in EPTCFG and everyone's happy?


Alex

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
