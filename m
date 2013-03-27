Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9D252C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 04:51:01 +1100 (EST)
Date: Wed, 27 Mar 2013 12:50:34 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/7 v2] KVM: PPC: e500: Remove E.PT and E.HV.LRAT
 categories from VCPUs
To: Mihai Caraman <mihai.caraman@freescale.com>
References: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
 <1364335512-28426-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1364335512-28426-6-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Tue Mar 26 17:05:10 2013)
Message-ID: <1364406634.31930.6@snotra>
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

On 03/26/2013 05:05:10 PM, Mihai Caraman wrote:
> Embedded.Page Table (E.PT) category in VMs requires indirect tlb =20
> entries
> emulation which is not supported yet. Configure TLBnCFG to remove E.PT
> and E.HV.LRAT categories from VCPUs.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v2:
>  - Remove E.HV.LRAT from vcpus
>=20
>  arch/powerpc/kvm/e500_mmu.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index cf60db1..0d2a293 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -867,11 +867,17 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
>  	vcpu->arch.tlbcfg[1] |=3D params[1].ways << TLBnCFG_ASSOC_SHIFT;
>=20
>  	if (has_feature(vcpu, VCPU_FTR_MMU_V2)) {
> +		vcpu->arch.mmucfg &=3D ~MMUCFG_LRAT;
> +
>  		if (has_feature(vcpu, VCPU_FTR_E_PT))
>  			vcpu->arch.eptcfg =3D mfspr(SPRN_EPTCFG);
>  		else
>  			vcpu->arch.eptcfg =3D 0;
>=20
> +		/* Guest mmu emulation currently doesn't handle E.PT */
> +		vcpu->arch.tlbcfg[0] &=3D ~TLBnCFG_PT;
> +		vcpu->arch.tlbcfg[1] &=3D ~TLBnCFG_IND;

You're clearing these bits *after* calling has_feature() -- doesn't =20
has_feature() depend on those bits being cleared to not advertise E_PT =20
support?

-Scott=
