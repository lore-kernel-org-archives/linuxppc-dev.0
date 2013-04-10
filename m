Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DA212C0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 12:32:40 +1000 (EST)
Date: Tue, 9 Apr 2013 21:32:28 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/MPIC: Add get_version API both for internal
 and external use
To: Jia Hongtao <hongtao.jia@freescale.com>
References: <1365386514-14647-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1365386514-14647-1-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Sun Apr  7 21:01:54 2013)
Message-ID: <1365561148.29365.0@snotra>
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

On 04/07/2013 09:01:54 PM, Jia Hongtao wrote:
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index d30e6a6..48c8fae 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1165,10 +1165,30 @@ static struct irq_domain_ops mpic_host_ops =3D {
>  	.xlate =3D mpic_host_xlate,
>  };
>=20
> +static u32 fsl_mpic_get_version(struct mpic *mpic)
> +{
> +	u32 brr1;
> +
> +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> +			MPIC_FSL_BRR1);
> +
> +	return brr1 & MPIC_FSL_BRR1_VER;
> +}

If it's not an FSL mpic, thiscpuregs->base will be NULL.  Please check =20
mpic->flags for MPIC_FSL.

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

...especially since the external version doesn't check for it either.

Otherwise, this and the MSI-X patch look OK to me.

-Scott=
