Return-Path: <B40534@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E88A2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 16:08:34 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH v2 2/3] powerpc/85xx: add hardware automatically enter
 altivec idle state
Date: Wed, 28 Aug 2013 06:08:11 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F154392590103460B@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1377592900-5020-1-git-send-email-dongsheng.wang@freescale.com>
 <1377592900-5020-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1377592900-5020-2-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wang Dongsheng-B40534
> Sent: Tuesday, August 27, 2013 4:42 PM
> To: Wood Scott-B07421; galak@kernel.crashing.org
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH v2 2/3] powerpc/85xx: add hardware automatically enter
> altivec idle state
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> Each core's AltiVec unit may be placed into a power savings mode
> by turning off power to the unit. Core hardware will automatically
> power down the AltiVec unit after no AltiVec instructions have
> executed in N cycles. The AltiVec power-control is triggered by hardware.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v2:
> Remove:
> delete setup_idle_hw_governor function.
> delete "Fix erratum" for rev1.
>=20
> Move:
> move setup_* into __setup/restore_cpu_e6500.
>=20
> diff --git a/arch/powerpc/include/asm/reg_booke.h
> b/arch/powerpc/include/asm/reg_booke.h
> index 86ede76..8364bbe 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -217,6 +217,9 @@
>  #define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity
> checking */
>  #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
>=20
> +/* Bit definitions for PWRMGTCR0. */
> +#define PWRMGTCR0_ALTIVEC_IDLE	(1 << 22) /* Altivec idle enable */
> +
>  /* Bit definitions for the MCSR. */
>  #define MCSR_MCS	0x80000000 /* Machine Check Summary */
>  #define MCSR_IB		0x40000000 /* Instruction PLB Error */
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index bfb18c7..90bbb46 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -58,6 +58,7 @@ _GLOBAL(__setup_cpu_e6500)
>  #ifdef CONFIG_PPC64
>  	bl	.setup_altivec_ivors
>  #endif
> +	bl	setup_altivec_idle
>  	bl	__setup_cpu_e5500
>  	mtlr	r6
>  	blr
> @@ -119,6 +120,7 @@ _GLOBAL(__setup_cpu_e5500)
>  _GLOBAL(__restore_cpu_e6500)
>  	mflr	r5
>  	bl	.setup_altivec_ivors
> +	bl	setup_altivec_idle
>  	bl	__restore_cpu_e5500
>  	mtlr	r5
>  	blr
> diff --git a/arch/powerpc/platforms/85xx/common.c
> b/arch/powerpc/platforms/85xx/common.c
> index d0861a0..93b563b 100644
> --- a/arch/powerpc/platforms/85xx/common.c
> +++ b/arch/powerpc/platforms/85xx/common.c
> @@ -11,6 +11,16 @@
>=20
>  #include "mpc85xx.h"
>=20
> +#define MAX_BIT				64
> +
This should be change to 63, i will fix this in next patch.

- dongsheng
