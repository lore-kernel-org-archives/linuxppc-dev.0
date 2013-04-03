Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D608F2C0112
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 03:17:28 +1100 (EST)
Date: Wed, 3 Apr 2013 11:17:08 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3 1/2] powerpc/MPIC: Add get_version API both for
 internal and external use
To: Jia Hongtao <hongtao.jia@freescale.com>
References: <1364954598-31914-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1364954598-31914-1-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Tue Apr  2 21:03:17 2013)
Message-ID: <1365005828.25627.0@snotra>
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

On 04/02/2013 09:03:17 PM, Jia Hongtao wrote:
> MPIC version is useful information for both mpic_alloc() and =20
> mpic_init().
> The patch provide an API to get MPIC version for reusing the code.
> Also, some other IP block may need MPIC version for their own use.
> The API for external use is also provided.
>=20
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Changes for V3:
> * change the name of function from mpic_primary_get_version() to
>   fsl_mpic_primary_get_version().
> * return 0 if mpic_primary is null.
>=20
>  arch/powerpc/include/asm/mpic.h |  3 +++
>  arch/powerpc/sysdev/mpic.c      | 29 ++++++++++++++++++++++-------
>  2 files changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h =20
> b/arch/powerpc/include/asm/mpic.h
> index c0f9ef9..ea6bf72 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -393,6 +393,9 @@ struct mpic
>  #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* =20
> Original MPIC */
>  #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* =20
> Tsi108/109 PIC */
>=20
> +/* Get the version of primary MPIC */
> +extern u32 fsl_mpic_primary_get_version(void);
> +
>  /* Allocate the controller structure and setup the linux irq descs
>   * for the range if interrupts passed in. No HW initialization is
>   * actually performed.
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index d30e6a6..e793337 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1165,10 +1165,30 @@ static struct irq_domain_ops mpic_host_ops =3D {
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

This one should have "fsl" in the name as well.

-Scott=
