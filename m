Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 49E982C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 00:21:13 +1100 (EST)
Subject: Re: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
 initialization earlier
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1359552584-17861-2-git-send-email-mihai.caraman@freescale.com>
Date: Thu, 31 Jan 2013 14:21:00 +0100
Message-Id: <FE5499BE-EC13-47EA-806C-345F7135B677@suse.de>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-2-git-send-email-mihai.caraman@freescale.com>
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

> VCPU's MMUCFG register initialization should not depend on =
KVM_CAP_SW_TLB
> ioctl call. Move it earlier into tlb initalization phase.

Quite the contrary. The fact that there is an mfspr() in e500_mmu.c =
already tells us that the code is broken. The TLB guest code should only =
depend on input from the SW_TLB configuration. It's completely =
orthogonal to the host capabilities.


Alex

>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/e500_mmu.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index 5c44759..bb1b2b0 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -692,8 +692,6 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu =
*vcpu,
> 	vcpu_e500->gtlb_offset[0] =3D 0;
> 	vcpu_e500->gtlb_offset[1] =3D params.tlb_sizes[0];
>=20
> -	vcpu->arch.mmucfg =3D mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
> -
> 	vcpu->arch.tlbcfg[0] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> 	if (params.tlb_sizes[0] <=3D 2048)
> 		vcpu->arch.tlbcfg[0] |=3D params.tlb_sizes[0];
> @@ -781,6 +779,8 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 =
*vcpu_e500)
> 	if (!vcpu_e500->g2h_tlb1_map)
> 		goto err;
>=20
> +	vcpu->arch.mmucfg =3D mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
> +
> 	/* Init TLB configuration register */
> 	vcpu->arch.tlbcfg[0] =3D mfspr(SPRN_TLB0CFG) &
> 			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
