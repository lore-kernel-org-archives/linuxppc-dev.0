Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E5C22C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 13:25:26 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: "galak@kernel.crashing.org" <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V5] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Fri, 12 Apr 2013 03:25:13 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C3C4F7@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1365562375-11920-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1365562375-11920-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

Scott reviewed this patch and MSI errata patch for weeks.
Here is the link for MSI errata patch:
http://patchwork.ozlabs.org/patch/233211/

Could you please have a review and ACK them if they
look good to you too?

Thanks.
- Hongtao


> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Wednesday, April 10, 2013 10:53 AM
> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> Cc: Wood Scott-B07421; Li Yang-R58472; Jia Hongtao-B38951
> Subject: [PATCH V5] powerpc/MPIC: Add get_version API both for internal
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
> V5:
> * add MPIC_FSL check for fsl_mpic_get_version().
>=20
> V4:
> * change the name of function from mpic_get_version() to
>   fsl_mpic_get_version().
>=20
> V3:
> * change the name of function from mpic_primary_get_version() to
>   fsl_mpic_primary_get_version().
> * return 0 if mpic_primary is null.
>=20
> V2:
> * Using mpic_get_version() to implement mpic_primary_get_version()
>=20
>  arch/powerpc/include/asm/mpic.h |  3 +++
>  arch/powerpc/sysdev/mpic.c      | 32 +++++++++++++++++++++++++-------
>  2 files changed, 28 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h
> b/arch/powerpc/include/asm/mpic.h index c0f9ef9..ea6bf72 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -393,6 +393,9 @@ struct mpic
>  #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original
> MPIC */
>  #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109
> PIC */
>=20
> +/* Get the version of primary MPIC */
> +extern u32 fsl_mpic_primary_get_version(void);
> +
>  /* Allocate the controller structure and setup the linux irq descs
>   * for the range if interrupts passed in. No HW initialization is
>   * actually performed.
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index d30e6a6..47ef4ba 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1165,10 +1165,33 @@ static struct irq_domain_ops mpic_host_ops =3D {
>  	.xlate =3D mpic_host_xlate,
>  };
>=20
> +static u32 fsl_mpic_get_version(struct mpic *mpic) {
> +	u32 brr1;
> +
> +	if (!(mpic->flags & MPIC_FSL))
> +		return 0;
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
> +u32 fsl_mpic_primary_get_version(void)
> +{
> +	struct mpic *mpic =3D mpic_primary;
> +
> +	if (mpic)
> +		return fsl_mpic_get_version(mpic);
> +
> +	return 0;
> +}
> +
>  struct mpic * __init mpic_alloc(struct device_node *node,
>  				phys_addr_t phys_addr,
>  				unsigned int flags,
> @@ -1315,7 +1338,6 @@ struct mpic * __init mpic_alloc(struct device_node
> *node,
>  	mpic_map(mpic, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE),
> 0x1000);
>=20
>  	if (mpic->flags & MPIC_FSL) {
> -		u32 brr1;
>  		int ret;
>=20
>  		/*
> @@ -1326,9 +1348,7 @@ struct mpic * __init mpic_alloc(struct device_node
> *node,
>  		mpic_map(mpic, mpic->paddr, &mpic->thiscpuregs,
>  			 MPIC_CPU_THISBASE, 0x1000);
>=20
> -		brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> -				MPIC_FSL_BRR1);
> -		fsl_version =3D brr1 & MPIC_FSL_BRR1_VER;
> +		fsl_version =3D fsl_mpic_get_version(mpic);
>=20
>  		/* Error interrupt mask register (EIMR) is required for
>  		 * handling individual device error interrupts. EIMR @@ -
> 1518,9 +1538,7 @@ void __init mpic_init(struct mpic *mpic)
>  	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
>=20
>  	if (mpic->flags & MPIC_FSL) {
> -		u32 brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> -				      MPIC_FSL_BRR1);
> -		u32 version =3D brr1 & MPIC_FSL_BRR1_VER;
> +		u32 version =3D fsl_mpic_get_version(mpic);
>=20
>  		/*
>  		 * Timer group B is present at the latest in MPIC 3.1 (e.g.
> --
> 1.8.0
