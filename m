Return-Path: <B38951@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5A1B2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 18:44:55 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V2] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Fri, 29 Mar 2013 07:44:44 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C2EBCC@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364275690-26790-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1364275690-26790-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar and Scott,

Any comments on these two patches?

Thanks.
-Hongtao.

> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Tuesday, March 26, 2013 1:28 PM
> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> Cc: Wood Scott-B07421; Li Yang-R58472; Jia Hongtao-B38951
> Subject: [PATCH V2] powerpc/MPIC: Add get_version API both for internal
> and external use
>=20
> MPIC version is useful information for both mpic_alloc() and mpic_init().
> The patch provide an API to get MPIC version for reusing the code.
> Also, some other IP block may need MPIC version for their own use.
> The API for external use is also provided.
>=20
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Changes for V2:
> * Using mpic_get_version() to implement mpic_primary_get_version()
>=20
>  arch/powerpc/include/asm/mpic.h |  3 +++
>  arch/powerpc/sysdev/mpic.c      | 26 +++++++++++++++++++-------
>  2 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h
> b/arch/powerpc/include/asm/mpic.h index c0f9ef9..7d1222d 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -393,6 +393,9 @@ struct mpic
>  #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original
> MPIC */
>  #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109
> PIC */
>=20
> +/* Get the version of primary MPIC */
> +extern u32 mpic_primary_get_version(void);
> +
>  /* Allocate the controller structure and setup the linux irq descs
>   * for the range if interrupts passed in. No HW initialization is
>   * actually performed.
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index d30e6a6..c893a4b 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1165,10 +1165,27 @@ static struct irq_domain_ops mpic_host_ops =3D {
>  	.xlate =3D mpic_host_xlate,
>  };
>=20
> +static u32 mpic_get_version(struct mpic *mpic) {
> +	u32 brr1;
> +
> +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> +			MPIC_FSL_BRR1);
> +
> +	return brr1 & MPIC_FSL_BRR1_VER;
> +}
> +
>  /*
>   * Exported functions
>   */
>=20
> +u32 mpic_primary_get_version(void)
> +{
> +	struct mpic *mpic =3D mpic_primary;
> +
> +	return mpic_get_version(mpic);
> +}
> +
>  struct mpic * __init mpic_alloc(struct device_node *node,
>  				phys_addr_t phys_addr,
>  				unsigned int flags,
> @@ -1315,7 +1332,6 @@ struct mpic * __init mpic_alloc(struct device_node
> *node,
>  	mpic_map(mpic, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE),
> 0x1000);
>=20
>  	if (mpic->flags & MPIC_FSL) {
> -		u32 brr1;
>  		int ret;
>=20
>  		/*
> @@ -1326,9 +1342,7 @@ struct mpic * __init mpic_alloc(struct device_node
> *node,
>  		mpic_map(mpic, mpic->paddr, &mpic->thiscpuregs,
>  			 MPIC_CPU_THISBASE, 0x1000);
>=20
> -		brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> -				MPIC_FSL_BRR1);
> -		fsl_version =3D brr1 & MPIC_FSL_BRR1_VER;
> +		fsl_version =3D mpic_get_version(mpic);
>=20
>  		/* Error interrupt mask register (EIMR) is required for
>  		 * handling individual device error interrupts. EIMR @@ -
> 1518,9 +1532,7 @@ void __init mpic_init(struct mpic *mpic)
>  	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
>=20
>  	if (mpic->flags & MPIC_FSL) {
> -		u32 brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> -				      MPIC_FSL_BRR1);
> -		u32 version =3D brr1 & MPIC_FSL_BRR1_VER;
> +		u32 version =3D mpic_get_version(mpic);
>=20
>  		/*
>  		 * Timer group B is present at the latest in MPIC 3.1 (e.g.
> --
> 1.8.0
