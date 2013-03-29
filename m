Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2985F2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2013 08:52:09 +1100 (EST)
Date: Fri, 29 Mar 2013 16:51:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2] powerpc/MPIC: Add get_version API both for internal
 and external use
To: Jia Hongtao <hongtao.jia@freescale.com>
References: <1364275690-26790-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1364275690-26790-1-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Tue Mar 26 00:28:10 2013)
Message-ID: <1364593919.13310.12@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: hongtao.jia@freescale.com, B07421@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2013 12:28:10 AM, Jia Hongtao wrote:
> MPIC version is useful information for both mpic_alloc() and =20
> mpic_init().
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
> diff --git a/arch/powerpc/include/asm/mpic.h =20
> b/arch/powerpc/include/asm/mpic.h
> index c0f9ef9..7d1222d 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -393,6 +393,9 @@ struct mpic
>  #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* =20
> Original MPIC */
>  #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* =20
> Tsi108/109 PIC */
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
> +static u32 mpic_get_version(struct mpic *mpic)
> +{
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

So this just crashes if there is no mpic_primary or it's a non-FSL MPIC?

-Scott=
