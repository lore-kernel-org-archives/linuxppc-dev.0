Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 87E6EB6F69
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2011 05:32:58 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl-booke: Fix settlbcam for 64-bit
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <13184437244040-git-send-email-beckyb@kernel.crashing.org>
Date: Wed, 12 Oct 2011 13:32:54 -0500
Message-Id: <AC82FC28-F113-4C5B-ABB2-559DA88DEC84@kernel.crashing.org>
References: <13184437244040-git-send-email-beckyb@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2011, at 1:22 PM, Becky Bruce wrote:

> From: Becky Bruce <beckyb@kernel.crashing.org>
>=20
> Currently, it does a cntlzd on the size and then subtracts it from
> 21.... this doesn't take into account the varying size of a "long".
> Just use __ilog instead (and subtract the 10 we have to subtract
> to get to the tsize encoding).
>=20
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> arch/powerpc/mm/fsl_booke_mmu.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c =
b/arch/powerpc/mm/fsl_booke_mmu.c
> index f7802c8..54897c0 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -111,7 +111,7 @@ static void settlbcam(int index, unsigned long =
virt, phys_addr_t phys,
> 	unsigned int tsize, lz;
>=20
> 	asm (PPC_CNTLZL "%0,%1" : "=3Dr" (lz) : "r" (size));
> -	tsize =3D 21 - lz;
> +	tsize =3D __ilog2(size) - 10;

If you do this you don't need 'lz' or the asm() statement.

>=20
> #ifdef CONFIG_SMP
> 	if ((flags & _PAGE_NO_CACHE) =3D=3D 0)
> --=20
> 1.5.6.5
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
