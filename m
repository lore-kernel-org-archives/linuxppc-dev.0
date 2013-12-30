Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 95F632C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 13:37:12 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "Bharat.Bhushan@freescale.com"
 <Bharat.Bhushan@freescale.com>
Subject: RE: [PATCH v6 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0
 define
Date: Mon, 30 Dec 2013 02:37:02 +0000
Message-ID: <792cbd6b4f0d40b2a4b7c8f106076d74@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1387268222-9703-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1387268222-9703-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Could you apply these patches?

[v6,1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0 define, http://patch=
work.ozlabs.org/patch/302045/
[v6,2/4] powerpc/85xx: add hardware automatically enter altivec idle state,=
 http://patchwork.ozlabs.org/patch/302046/
[v6,3/4] powerpc/85xx: add hardware automatically enter pw20 state, http://=
patchwork.ozlabs.org/patch/302047/
[v6,4/4] powerpc/85xx: add sysfs for pw20 state and altivec idle, http://pa=
tchwork.ozlabs.org/patch/302048/

-Dongsheng

> -----Original Message-----
> From: Dongsheng Wang [mailto:dongsheng.wang@freescale.com]
> Sent: Tuesday, December 17, 2013 4:17 PM
> To: Wood Scott-B07421; Bhushan Bharat-R65777
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH v6 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0 def=
ine
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> E6500 PVR and SPRN_PWRMGTCR0 will be used in subsequent pw20/altivec
> idle patches.
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
>   * the PowerPC core. The various versions of these processors must be
> diff --git a/arch/powerpc/include/asm/reg_booke.h
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
