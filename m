Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0657B2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 09:48:45 +1100 (EST)
Date: Tue, 26 Mar 2013 17:48:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/7 v2] KVM: PPC: e500: Add support for TLBnPS registers
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1364335512-28426-4-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Tue Mar 26 17:05:08 2013)
Message-ID: <1364338111.469.17@snotra>
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

On 03/26/2013 05:05:08 PM, Mihai Caraman wrote:
> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> index b73ca7a..795934d 100644
> --- a/arch/powerpc/kvm/e500.h
> +++ b/arch/powerpc/kvm/e500.h
> @@ -23,6 +23,8 @@
>  #include <asm/mmu-book3e.h>
>  #include <asm/tlb.h>
>=20
> +#define VCPU_FTR_MMU_V2		0

enum?  We don't care about the actual value here.

>  #define E500_PID_NUM   3
>  #define E500_TLB_NUM   2
>=20
> @@ -299,4 +301,18 @@ static inline unsigned int =20
> get_tlbmiss_tid(struct kvm_vcpu *vcpu)
>  #define get_tlb_sts(gtlbe)              (MAS1_TS)
>  #endif /* !BOOKE_HV */
>=20
> +static inline bool has_feature(const struct kvm_vcpu *vcpu,
> +			       unsigned long vcpu_ftr)
> +{
> +	bool has_ftr;
> +	switch (vcpu_ftr) {
> +	case VCPU_FTR_MMU_V2:
> +		has_ftr =3D ((vcpu->arch.mmucfg & MMUCFG_MAVN) =3D=3D =20
> MMUCFG_MAVN_V2);
> +		break;
> +	default:
> +		has_ftr =3D false;
> +	}
> +	return has_ftr;
> +}

vcpu_has_feature()

Can simplify by replacing has_ftr with "return true" and "return false".

-Scott=
