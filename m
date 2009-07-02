Return-Path: <Yu.Liu@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 19A96B7107
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 13:09:34 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EFEDDDD1C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 13:09:33 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6239C3R005055
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 20:09:24 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n6239Aa7019300
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 22:09:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] KVM/PPC: Fix PPC KVM e500_tlb.c build error
Date: Thu, 2 Jul 2009 11:09:09 +0800
Message-ID: <0A1FE637C2C7E148B9573BB60CC630E531C59D@zch01exm26.fsl.freescale.net>
In-Reply-To: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
References: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
From: "Liu Yu-B13201" <Yu.Liu@freescale.com>
To: "Yang Shi" <yang.shi@windriver.com>, <hollisb@us.ibm.com>, <avi@redhat.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This fix is already accepted in kvm.git=20

> -----Original Message-----
> From: Yang Shi [mailto:yang.shi@windriver.com]=20
> Sent: Thursday, July 02, 2009 10:55 AM
> To: Liu Yu-B13201; hollisb@us.ibm.com; avi@redhat.com
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;=20
> linuxppc-dev@ozlabs.org
> Subject: [PATCH 1/2] KVM/PPC: Fix PPC KVM e500_tlb.c build error
>=20
> Since include/asm/mmu-fsl-booke.h was replaced by=20
> include/asm/mmu-book3e.h,
> fix e500_tlb.h to reflect the change and fix e500_tlb.c to=20
> align with the
> new page size macro definition in include/asm/mmu-book3e.h.
>=20
> Signed-off-by: Yang Shi <yang.shi@windriver.com>
> ---
>  arch/powerpc/kvm/e500_tlb.c |    8 ++++----
>  arch/powerpc/kvm/e500_tlb.h |    2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
> index 0e773fc..616762b 100644
> --- a/arch/powerpc/kvm/e500_tlb.c
> +++ b/arch/powerpc/kvm/e500_tlb.c
> @@ -309,7 +309,7 @@ static inline void=20
> kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  	vcpu_e500->shadow_pages[tlbsel][esel] =3D new_page;
> =20
>  	/* Force TS=3D1 IPROT=3D0 TSIZE=3D4KB for all guest mappings. */
> -	stlbe->mas1 =3D MAS1_TSIZE(BOOKE_PAGESZ_4K)
> +	stlbe->mas1 =3D MAS1_TSIZE(BOOK3E_PAGESZ_4K)
>  		| MAS1_TID(get_tlb_tid(gtlbe)) | MAS1_TS | MAS1_VALID;
>  	stlbe->mas2 =3D (gvaddr & MAS2_EPN)
>  		| e500_shadow_mas2_attrib(gtlbe->mas2,
> @@ -545,7 +545,7 @@ int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu)
>  		case 0:
>  			/* TLB0 */
>  			gtlbe->mas1 &=3D ~MAS1_TSIZE(~0);
> -			gtlbe->mas1 |=3D MAS1_TSIZE(BOOKE_PAGESZ_4K);
> +			gtlbe->mas1 |=3D MAS1_TSIZE(BOOK3E_PAGESZ_4K);
> =20
>  			stlbsel =3D 0;
>  			sesel =3D=20
> kvmppc_e500_stlbe_map(vcpu_e500, 0, esel);
> @@ -679,14 +679,14 @@ void kvmppc_e500_tlb_setup(struct=20
> kvmppc_vcpu_e500 *vcpu_e500)
> =20
>  	/* Insert large initial mapping for guest. */
>  	tlbe =3D &vcpu_e500->guest_tlb[1][0];
> -	tlbe->mas1 =3D MAS1_VALID | MAS1_TSIZE(BOOKE_PAGESZ_256M);
> +	tlbe->mas1 =3D MAS1_VALID | MAS1_TSIZE(BOOK3E_PAGESZ_256M);
>  	tlbe->mas2 =3D 0;
>  	tlbe->mas3 =3D E500_TLB_SUPER_PERM_MASK;
>  	tlbe->mas7 =3D 0;
> =20
>  	/* 4K map for serial output. Used by kernel wrapper. */
>  	tlbe =3D &vcpu_e500->guest_tlb[1][1];
> -	tlbe->mas1 =3D MAS1_VALID | MAS1_TSIZE(BOOKE_PAGESZ_4K);
> +	tlbe->mas1 =3D MAS1_VALID | MAS1_TSIZE(BOOK3E_PAGESZ_4K);
>  	tlbe->mas2 =3D (0xe0004500 & 0xFFFFF000) | MAS2_I | MAS2_G;
>  	tlbe->mas3 =3D (0xe0004500 & 0xFFFFF000) |=20
> E500_TLB_SUPER_PERM_MASK;
>  	tlbe->mas7 =3D 0;
> diff --git a/arch/powerpc/kvm/e500_tlb.h b/arch/powerpc/kvm/e500_tlb.h
> index 45b064b..abb1bf8 100644
> --- a/arch/powerpc/kvm/e500_tlb.h
> +++ b/arch/powerpc/kvm/e500_tlb.h
> @@ -16,7 +16,7 @@
>  #define __KVM_E500_TLB_H__
> =20
>  #include <linux/kvm_host.h>
> -#include <asm/mmu-fsl-booke.h>
> +#include <asm/mmu-book3e.h>
>  #include <asm/tlb.h>
>  #include <asm/kvm_e500.h>
> =20
> --=20
> 1.6.0.4
>=20
>=20
