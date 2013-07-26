Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F05312C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 09:14:09 +1000 (EST)
Date: Fri, 26 Jul 2013 18:14:00 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/8] powerpc/fsl_booke: protect the access to MAS7
 with MMU_FTR_BIG_PHYS
To: Kevin Hao <haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-2-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Thu Jul  4 07:54:07 2013)
Message-ID: <1374880440.30721.36@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2013 07:54:07 AM, Kevin Hao wrote:
> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S =20
> b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> index a92c79b..2201f84 100644
> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> @@ -88,9 +88,11 @@ skpinv:	addi	r6,r6,1				=20
> /* Increment */
>  1:	mflr	r7
>=20
>  	mfspr	r8,SPRN_MAS3
> -#ifdef CONFIG_PHYS_64BIT
> +BEGIN_MMU_FTR_SECTION
>  	mfspr	r23,SPRN_MAS7
> -#endif
> +MMU_FTR_SECTION_ELSE
> +	li	r23,0
> +ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
>  	and	r8,r6,r8
>  	subfic	r9,r6,-4096
>  	and	r9,r9,r7
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S =20
> b/arch/powerpc/kernel/head_fsl_booke.S
> index d10a7ca..a04a48d 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -82,7 +82,11 @@ _ENTRY(_start);
>  	and	r19,r3,r18		/* r19 =3D page offset */
>  	andc	r31,r20,r18		/* r31 =3D page base */
>  	or	r31,r31,r19		/* r31 =3D devtree phys addr */
> +BEGIN_MMU_FTR_SECTION
>  	mfspr	r30,SPRN_MAS7
> +MMU_FTR_SECTION_ELSE
> +	li	r30,0
> +ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)

Code patching hasn't been done yet at this point.

-Scott=
