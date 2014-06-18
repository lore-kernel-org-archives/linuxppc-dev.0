Return-Path: <Bharat.Bhushan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB6341A032C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 02:01:10 +1000 (EST)
From: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH] KVM: PPC: Book3E: Unlock mmu_lock when setting caching
 atttribute
Date: Wed, 18 Jun 2014 16:01:02 +0000
Message-ID: <aecdf3dd06214788862b7c53f080f559@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1403106305-11565-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1403106305-11565-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Mihai Caraman [mailto:mihai.caraman@freescale.com]
> Sent: Wednesday, June 18, 2014 9:15 PM
> To: kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Caraman Mihai Cla=
udiu-
> B02008; Bhushan Bharat-R65777
> Subject: [PATCH] KVM: PPC: Book3E: Unlock mmu_lock when setting caching
> atttribute
>=20
> The patch 08c9a188d0d0fc0f0c5e17d89a06bb59c493110f
>   	kvm: powerpc: use caching attributes as per linux pte
> do not handle properly the error case, letting mmu_lock locked. The lock
> will further generate a RCU stall from kvmppc_e500_emul_tlbwe() caller.
>=20
> In case of an error go to out label.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Cc: Bharat Bhushan <bharat.bhushan@freescale.com>

Thanks mike for fixing this; I am curious to know how you reached to this p=
oint :)

Reviewed-by: Bharat Bhushan <bharat.bhushan@freescale.com>

Regards
-Bharat

> ---
>  arch/powerpc/kvm/e500_mmu_host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu=
_host.c
> index 0528fe5..54144c7 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -473,7 +473,8 @@ static inline int kvmppc_e500_shadow_map(struct
> kvmppc_vcpu_e500 *vcpu_e500,
>  		if (printk_ratelimit())
>  			pr_err("%s: pte not present: gfn %lx, pfn %lx\n",
>  				__func__, (long)gfn, pfn);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto out;
>  	}
>  	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
>=20
> --
> 1.7.11.7
