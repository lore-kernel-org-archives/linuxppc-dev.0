Return-Path: <R65777@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 15974B70BD
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2011 14:54:38 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard SMP id
Date: Thu, 20 Oct 2011 03:53:57 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE6244FDF@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1318578771-16865-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1318578771-16865-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Kum=
ar
> Gala
> Sent: Friday, October 14, 2011 1:23 PM
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard SMP id
>=20
> Normally logical and hard cpu ID are the same, however in same cases like
> on the P3060 they may differ.  Where the logical is 0..5, the hard id
> goes 0,1,4..7.  This can causes issues for places we utilize PIR to index
> into array like in debug exception handlers for finding the exception
> stack.

Kumar, What should be the CONFIG_NR_CPUS for this? 8 or 6 ?

Thanks
-Bharat

>=20
> Move to setting up PIR with hard_smp_processor_id fixes the issue.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/platforms/85xx/smp.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/smp.c
> b/arch/powerpc/platforms/85xx/smp.c
> index d6e4746..190d111 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -48,10 +48,11 @@ smp_85xx_kick_cpu(int nr)
>  	const u64 *cpu_rel_addr;
>  	__iomem u32 *bptr_vaddr;
>  	struct device_node *np;
> -	int n =3D 0;
> +	int n =3D 0, hw_cpu =3D get_hard_smp_processor_id(nr);
>  	int ioremappable;
>=20
> -	WARN_ON (nr < 0 || nr >=3D NR_CPUS);
> +	WARN_ON(nr < 0 || nr >=3D NR_CPUS);
> +	WARN_ON(hw_cpu < 0 || hw_cpu >=3D NR_CPUS);
>=20
>  	pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
>=20
> @@ -79,7 +80,7 @@ smp_85xx_kick_cpu(int nr)
>=20
>  	local_irq_save(flags);
>=20
> -	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
> +	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, hw_cpu);
>  #ifdef CONFIG_PPC32
>  	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
>=20
> @@ -88,7 +89,7 @@ smp_85xx_kick_cpu(int nr)
>  				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
>=20
>  	/* Wait a bit for the CPU to ack. */
> -	while ((__secondary_hold_acknowledge !=3D nr) && (++n < 1000))
> +	while ((__secondary_hold_acknowledge !=3D hw_cpu) && (++n < 1000))
>  		mdelay(1);
>  #else
>  	smp_generic_kick_cpu(nr);
> --
> 1.7.3.4
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
