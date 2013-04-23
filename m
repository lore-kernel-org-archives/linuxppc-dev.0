Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 103052C011D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:59:06 +1000 (EST)
Date: Tue, 23 Apr 2013 18:58:55 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 07/15] powerpc/85xx: add time base sync for SoCs
 based on e500mc/e5500
To: Zhao Chenhui <chenhui.zhao@freescale.com>
References: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
 <1366368468-29143-7-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1366368468-29143-7-git-send-email-chenhui.zhao@freescale.com>
 (from chenhui.zhao@freescale.com on Fri Apr 19 05:47:40 2013)
Message-ID: <1366761535.5825.19@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2013 05:47:40 AM, Zhao Chenhui wrote:
> From: Chen-Hui Zhao <chenhui.zhao@freescale.com>
>=20
> In the case of SMP, during the time base sync period, all time bases =20
> of
> online cores must stop, then start simultaneously.
>=20
> There is a RCPM (Run Control/Power Management) module in CoreNet =20
> based SoCs.
> Define a struct ccsr_rcpm to describe the register map.
>=20
> This patch supports SoCs based on e500mc/e5500, such as P4080, P5020,
> etc.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/include/asm/fsl_guts.h |   38 =20
> +++++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/smp.c   |   32 =20
> +++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/fsl_guts.h =20
> b/arch/powerpc/include/asm/fsl_guts.h
> index 77ced0b..4eac1cf 100644
> --- a/arch/powerpc/include/asm/fsl_guts.h
> +++ b/arch/powerpc/include/asm/fsl_guts.h
> @@ -106,6 +106,44 @@ struct ccsr_guts {
>  /* Alternate function signal multiplex control */
>  #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
>=20
> +struct ccsr_rcpm {
> +	u8	res0000[4];
> +	__be32	cdozsr;		/* 0x0004 - Core Doze Status Register */
> +	u8	res0008[4];
> +	__be32	cdozcr;		/* 0x000c - Core Doze Control Register =20
> */
> +	u8	res0010[4];
> +	__be32	cnapsr;		/* 0x0014 - Core Nap Status Register */
> +	u8	res0018[4];
> +	__be32	cnapcr;		/* 0x001c - Core Nap Control Register */
> +	u8	res0020[4];
> +	__be32	cdozpsr;	/* 0x0024 - Core Doze Previous Status =20
> Register */
> +	u8	res0028[4];
> +	__be32	cnappsr;	/* 0x002c - Core Nap Previous Status =20
> Register */
> +	u8	res0030[4];
> +	__be32	cwaitsr;	/* 0x0034 - Core Wait Status Register */
> +	u8	res0038[4];
> +	__be32	cwdtdsr;	/* 0x003c - Core watchdog detect status =20
> register */
> +	__be32	powmgtcsr;	/* 0x0040 - Power Mangement Control & =20
> Status Register */
> +	u8	res0044[12];
> +	__be32	ippdexpcr;	/* 0x0050 - IP Powerdown Exception =20
> Control Register */
> +	u8	res0054[16];
> +	__be32	cpmimr;		/* 0x0064 - Core PM IRQ Mask Register */
> +	u8	res0068[4];
> +	__be32	cpmcimr;	/* 0x006c - Core PM Critical IRQ Mask =20
> Register */
> +	u8	res0070[4];
> +	__be32	cpmmcmr;	/* 0x0074 - Core PM Machine Check Mask =20
> Register */
> +	u8	res0078[4];
> +	__be32	cpmnmimr;	/* 0x007c - Core PM NMI Mask Register */
> +	u8	res0080[4];
> +	__be32	ctbenr;		/* 0x0084 - Core Time Base Enable =20
> Register */
> +	u8	res0088[4];
> +	__be32	ctbckselr;	/* 0x008c - Core Time Base Clock Select =20
> Register */
> +	u8	res0090[4];
> +	__be32	ctbhltcr;	/* 0x0094 - Core Time Base Halt Control =20
> Register */
> +	u8	res0098[4];
> +	__be32	cmcpmaskcr;	/* 0x00a4 - Core machine check mask =20
> control register */
> +};
> +
>  #ifdef CONFIG_PPC_86xx
>=20
>  #define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA =20
> controller/channel set to SSI */
> diff --git a/arch/powerpc/platforms/85xx/smp.c =20
> b/arch/powerpc/platforms/85xx/smp.c
> index 6a17599..6c2fe6b 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -44,7 +44,36 @@ static struct ccsr_guts __iomem *guts;
>  static u64 timebase;
>  static int tb_req;
>  static int tb_valid;
> +static u32 cur_booting_core;
>=20
> +#ifdef CONFIG_PPC_E500MC
> +/* get a physical mask of online cores and booting core */
> +static inline u32 get_phy_cpu_mask(void)
> +{
> +	u32 mask;
> +	int cpu;
> +
> +	mask =3D 1 << cur_booting_core;
> +	for_each_online_cpu(cpu)
> +		mask |=3D 1 << get_hard_smp_processor_id(cpu);
> +
> +	return mask;
> +}
> +
> +static void mpc85xx_timebase_freeze(int freeze)
> +{
> +	struct ccsr_rcpm __iomem *rcpm =3D (typeof(rcpm))guts;
> +	u32 mask =3D get_phy_cpu_mask();
> +
> +	if (freeze)
> +		clrbits32(&rcpm->ctbenr, mask);
> +	else
> +		setbits32(&rcpm->ctbenr, mask);
> +
> +	/* read back to push the previos write */
> +	in_be32(&rcpm->ctbenr);
> +}
> +#else

Please determine the timebase sync implementation at runtime, rather =20
than relying on our current inability to have e500v2 and e500mc in the =20
same kernel.  e6500 will be different from e5500, but both can be in =20
the same kernel image.

-Scott=
