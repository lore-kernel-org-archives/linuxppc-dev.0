Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 043A62C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 22:20:21 +1100 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH] KVM: PPC: e500: Add separate functions for vcpu's MMU
 configuration
Date: Thu, 21 Mar 2013 11:19:58 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF373151@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1363713407-27886-1-git-send-email-mihai.caraman@freescale.com>
 <90E4FFA9-97C8-4D7D-910E-2E5DB273C88C@suse.de>
In-Reply-To: <90E4FFA9-97C8-4D7D-910E-2E5DB273C88C@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
> owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Thursday, March 21, 2013 12:07 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH] KVM: PPC: e500: Add separate functions for vcpu's
> MMU configuration
>=20
>=20
> On 19.03.2013, at 18:16, Mihai Caraman wrote:
>=20
> > Move vcpu's MMU default configuration and geometry update into their
> own
> > functions.
>=20
> Mind to explain why?

You requested a separate function for clearing TLBnCFG_IND bit (E.PT remova=
l)
to self-document the code. The existing logic (that TLBnCFG_IND relies on)
was buried in a chunk of code and I thought this will add more clarity.
If you don't agree I would document the code at least.

-Mike

>=20
>=20
> Alex
>=20
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > arch/powerpc/kvm/e500_mmu.c |   59 +++++++++++++++++++++++++++---------
> -------
> > 1 files changed, 37 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> > index 5c44759..66b6e31 100644
> > --- a/arch/powerpc/kvm/e500_mmu.c
> > +++ b/arch/powerpc/kvm/e500_mmu.c
> > @@ -596,6 +596,20 @@ int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu
> *vcpu, struct kvm_sregs *sregs)
> > 	return 0;
> > }
> >
> > +static int vcpu_mmu_geometry_update(struct kvm_vcpu *vcpu,
> > +		struct kvm_book3e_206_tlb_params *params)
> > +{
> > +	vcpu->arch.tlbcfg[0] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > +	if (params->tlb_sizes[0] <=3D 2048)
> > +		vcpu->arch.tlbcfg[0] |=3D params->tlb_sizes[0];
> > +	vcpu->arch.tlbcfg[0] |=3D params->tlb_ways[0] << TLBnCFG_ASSOC_SHIFT;
> > +
> > +	vcpu->arch.tlbcfg[1] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > +	vcpu->arch.tlbcfg[1] |=3D params->tlb_sizes[1];
> > +	vcpu->arch.tlbcfg[1] |=3D params->tlb_ways[1] << TLBnCFG_ASSOC_SHIFT;
> > +	return 0;
> > +}
> > +
> > int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
> > 			      struct kvm_config_tlb *cfg)
> > {
> > @@ -692,16 +706,8 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu
> *vcpu,
> > 	vcpu_e500->gtlb_offset[0] =3D 0;
> > 	vcpu_e500->gtlb_offset[1] =3D params.tlb_sizes[0];
> >
> > -	vcpu->arch.mmucfg =3D mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
> > -
> > -	vcpu->arch.tlbcfg[0] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > -	if (params.tlb_sizes[0] <=3D 2048)
> > -		vcpu->arch.tlbcfg[0] |=3D params.tlb_sizes[0];
> > -	vcpu->arch.tlbcfg[0] |=3D params.tlb_ways[0] << TLBnCFG_ASSOC_SHIFT;
> > -
> > -	vcpu->arch.tlbcfg[1] &=3D ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > -	vcpu->arch.tlbcfg[1] |=3D params.tlb_sizes[1];
> > -	vcpu->arch.tlbcfg[1] |=3D params.tlb_ways[1] << TLBnCFG_ASSOC_SHIFT;
> > +	/* Update vcpu's MMU geometry based on SW_TLB input */
> > +	vcpu_mmu_geometry_update(vcpu, &params);
> >
> > 	vcpu_e500->shared_tlb_pages =3D pages;
> > 	vcpu_e500->num_shared_tlb_pages =3D num_pages;
> > @@ -737,6 +743,26 @@ int kvm_vcpu_ioctl_dirty_tlb(struct kvm_vcpu
> *vcpu,
> > 	return 0;
> > }
> >
> > +/* vcpu's MMU default configuration */
> > +static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
> > +		       struct kvmppc_e500_tlb_params *params)
> > +{
> > +	/* Initialize RASIZE, PIDSIZE, NTLBS and MAVN fields with host
> values*/
> > +	vcpu->arch.mmucfg =3D mfspr(SPRN_MMUCFG) & ~MMUCFG_LPIDSIZE;
> > +
> > +	/* Initialize IPROT field with host value*/
> > +	vcpu->arch.tlbcfg[0] =3D mfspr(SPRN_TLB0CFG) &
> > +			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > +	vcpu->arch.tlbcfg[0] |=3D params[0].entries;
> > +	vcpu->arch.tlbcfg[0] |=3D params[0].ways << TLBnCFG_ASSOC_SHIFT;
> > +
> > +	vcpu->arch.tlbcfg[1] =3D mfspr(SPRN_TLB1CFG) &
> > +			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > +	vcpu->arch.tlbcfg[1] |=3D params[1].entries;
> > +	vcpu->arch.tlbcfg[1] |=3D params[1].ways << TLBnCFG_ASSOC_SHIFT;
> > +	return 0;
> > +}
> > +
> > int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
> > {
> > 	struct kvm_vcpu *vcpu =3D &vcpu_e500->vcpu;
> > @@ -781,18 +807,7 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500
> *vcpu_e500)
> > 	if (!vcpu_e500->g2h_tlb1_map)
> > 		goto err;
> >
> > -	/* Init TLB configuration register */
> > -	vcpu->arch.tlbcfg[0] =3D mfspr(SPRN_TLB0CFG) &
> > -			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > -	vcpu->arch.tlbcfg[0] |=3D vcpu_e500->gtlb_params[0].entries;
> > -	vcpu->arch.tlbcfg[0] |=3D
> > -		vcpu_e500->gtlb_params[0].ways << TLBnCFG_ASSOC_SHIFT;
> > -
> > -	vcpu->arch.tlbcfg[1] =3D mfspr(SPRN_TLB1CFG) &
> > -			     ~(TLBnCFG_N_ENTRY | TLBnCFG_ASSOC);
> > -	vcpu->arch.tlbcfg[1] |=3D vcpu_e500->gtlb_params[1].entries;
> > -	vcpu->arch.tlbcfg[1] |=3D
> > -		vcpu_e500->gtlb_params[1].ways << TLBnCFG_ASSOC_SHIFT;
> > +	vcpu_mmu_init(vcpu, vcpu_e500->gtlb_params);
> >
> > 	kvmppc_recalc_tlb1map_range(vcpu_e500);
> > 	return 0;
> > --
> > 1.7.4.1
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
