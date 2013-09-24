Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B2522C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 21:22:08 +1000 (EST)
Received: from mail213-co1 (localhost [127.0.0.1])	by
 mail213-co1-R.bigfish.com (Postfix) with ESMTP id E669AD8015D	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 11:22:03 +0000 (UTC)
Received: from CO1EHSMHS015.bigfish.com (unknown [10.243.78.225])	by
 mail213-co1.bigfish.com (Postfix) with ESMTP id 3B73A4C0041	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 11:22:01 +0000 (UTC)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0
 define
Date: Tue, 24 Sep 2013 11:21:59 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0717DD00@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380014871-22937-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1380014871-22937-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Don=
gsheng
> Wang
> Sent: Tuesday, September 24, 2013 2:58 PM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0 def=
ine
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> E6500 PVR and SPRN_PWRMGTCR0 will be used in subsequent pw20/altivec idle
> patches.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v3:
> Add bit definitions for PWRMGTCR0.
>=20
>  arch/powerpc/include/asm/reg.h       | 2 ++
>  arch/powerpc/include/asm/reg_booke.h | 9 +++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index 64264bf..d4160ca 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1053,6 +1053,8 @@
>  #define PVR_8560	0x80200000
>  #define PVR_VER_E500V1	0x8020
>  #define PVR_VER_E500V2	0x8021
> +#define PVR_VER_E6500	0x8040
> +
>  /*
>   * For the 8xx processors, all of them report the same PVR family for
>   * the PowerPC core. The various versions of these processors must be di=
ff --
> git a/arch/powerpc/include/asm/reg_booke.h
> b/arch/powerpc/include/asm/reg_booke.h
> index ed8f836..4a6457e 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -170,6 +170,7 @@
>  #define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status Register 1
> */
>  #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
>  #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
> +#define SPRN_PWRMGTCR0	0x3FB	/* Power management control register 0 */

Is this generic for booke or e6500 specific? I can't see this register eith=
er in ISA and EREF.
Also I can see SPRN_ICCR also with same SPRN, how that is possible?

-Bharat

>  #define SPRN_SVR	0x3FF	/* System Version Register */
>=20
>  /*
> @@ -216,6 +217,14 @@
>  #define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity
> checking */
>  #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
>=20
> +/* Bit definitions for PWRMGTCR0. */
> +#define PWRMGTCR0_PW20_WAIT		(1 << 14) /* PW20 state enable bit */
> +#define PWRMGTCR0_PW20_ENT_SHIFT	8
> +#define PWRMGTCR0_PW20_ENT		0x3F00
> +#define PWRMGTCR0_AV_IDLE_PD_EN		(1 << 22) /* Altivec idle enable */
> +#define PWRMGTCR0_AV_IDLE_CNT_SHIFT	16
> +#define PWRMGTCR0_AV_IDLE_CNT		0x3F0000
> +
>  /* Bit definitions for the MCSR. */
>  #define MCSR_MCS	0x80000000 /* Machine Check Summary */
>  #define MCSR_IB		0x40000000 /* Instruction PLB Error */
> --
> 1.8.0
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
