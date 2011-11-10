Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B8CB9B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 00:33:51 +1100 (EST)
Subject: Re: [RFC PATCH 01/17] powerpc/mpic: Fix bogus CONFIG_BOOKE conditional
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1320883635-17194-2-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 10 Nov 2011 07:33:11 -0600
Message-Id: <2D7772C1-2EFA-4F40-A3BF-BBCC377C32F3@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-2-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Timur Tabi <timur@freescale.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 9, 2011, at 6:06 PM, Kyle Moffett wrote:

> The code inside the conditional is only used by 85xx CoreNet fabric
> platforms, so add a new config define and use it where necessary.

1. why make the change
2. if you're using FSL_CORENET as a SoC feature CONFIG option than other =
bits of this patch are wrong

It should NOT be used in platforms/85xx/Makefile those should be left =
alone and FSL_CORENET should be selected by having E500MC or similar =
set.

>=20
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig    |    5 +++++
> arch/powerpc/platforms/85xx/Makefile   |   11 ++++++-----
> arch/powerpc/platforms/Kconfig.cputype |    3 +++
> arch/powerpc/sysdev/mpic.c             |    6 ++----
> 4 files changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/Kconfig =
b/arch/powerpc/platforms/85xx/Kconfig
> index 45023e2..9088381 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -181,6 +181,7 @@ config P2041_RDB
> 	select GPIO_MPC8XXX
> 	select HAS_RAPIDIO
> 	select PPC_EPAPR_HV_PIC
> +	select FSL_CORENET
> 	help
> 	  This option enables support for the P2041 RDB board
>=20
> @@ -194,6 +195,7 @@ config P3041_DS
> 	select GPIO_MPC8XXX
> 	select HAS_RAPIDIO
> 	select PPC_EPAPR_HV_PIC
> +	select FSL_CORENET
> 	help
> 	  This option enables support for the P3041 DS board
>=20
> @@ -206,6 +208,7 @@ config P3060_QDS
> 	select MPC8xxx_GPIO
> 	select HAS_RAPIDIO
> 	select PPC_EPAPR_HV_PIC
> +	select FSL_CORENET
> 	help
> 	  This option enables support for the P3060 QDS board
>=20
> @@ -219,6 +222,7 @@ config P4080_DS
> 	select GPIO_MPC8XXX
> 	select HAS_RAPIDIO
> 	select PPC_EPAPR_HV_PIC
> +	select FSL_CORENET
> 	help
> 	  This option enables support for the P4080 DS board
>=20
> @@ -235,6 +239,7 @@ config P5020_DS
> 	select GPIO_MPC8XXX
> 	select HAS_RAPIDIO
> 	select PPC_EPAPR_HV_PIC
> +	select FSL_CORENET
> 	help
> 	  This option enables support for the P5020 DS board
>=20
> diff --git a/arch/powerpc/platforms/85xx/Makefile =
b/arch/powerpc/platforms/85xx/Makefile
> index bc5acb9..c6d1334 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -13,11 +13,12 @@ obj-$(CONFIG_MPC85xx_RDB) +=3D mpc85xx_rdb.o
> obj-$(CONFIG_P1010_RDB)   +=3D p1010rdb.o
> obj-$(CONFIG_P1022_DS)    +=3D p1022_ds.o
> obj-$(CONFIG_P1023_RDS)   +=3D p1023_rds.o
> -obj-$(CONFIG_P2041_RDB)   +=3D p2041_rdb.o corenet_ds.o
> -obj-$(CONFIG_P3041_DS)    +=3D p3041_ds.o corenet_ds.o
> -obj-$(CONFIG_P3060_QDS)   +=3D p3060_qds.o corenet_ds.o
> -obj-$(CONFIG_P4080_DS)    +=3D p4080_ds.o corenet_ds.o
> -obj-$(CONFIG_P5020_DS)    +=3D p5020_ds.o corenet_ds.o
> +obj-$(CONFIG_P2041_RDB)   +=3D p2041_rdb.o
> +obj-$(CONFIG_P3041_DS)    +=3D p3041_ds.o
> +obj-$(CONFIG_P3060_QDS)   +=3D p3060_qds.o
> +obj-$(CONFIG_P4080_DS)    +=3D p4080_ds.o
> +obj-$(CONFIG_P5020_DS)    +=3D p5020_ds.o
> +obj-$(CONFIG_FSL_CORENET) +=3D corenet_ds.o
> obj-$(CONFIG_STX_GP3)	  +=3D stx_gp3.o
> obj-$(CONFIG_TQM85xx)	  +=3D tqm85xx.o
> obj-$(CONFIG_SBC8560)     +=3D sbc8560.o
> diff --git a/arch/powerpc/platforms/Kconfig.cputype =
b/arch/powerpc/platforms/Kconfig.cputype
> index fbecae0..9210e94 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -177,6 +177,9 @@ config FSL_BOOKE
> 	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT
> 	default y
>=20
> +config FSL_CORENET
> +	bool
> +
> # this is for common code between PPC32 & PPC64 FSL BOOKE
> config PPC_FSL_BOOK3E
> 	bool
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 0842c6f..1a3d84a 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1642,9 +1642,9 @@ unsigned int mpic_get_irq(void)
> 	return mpic_get_one_irq(mpic);
> }
>=20
> +#ifdef CONFIG_FSL_CORENET
> unsigned int mpic_get_coreint_irq(void)
> {
> -#ifdef CONFIG_BOOKE
> 	struct mpic *mpic =3D mpic_primary;
> 	u32 src;
>=20
> @@ -1664,10 +1664,8 @@ unsigned int mpic_get_coreint_irq(void)
> 	}
>=20
> 	return irq_linear_revmap(mpic->irqhost, src);
> -#else
> -	return NO_IRQ;
> -#endif
> }
> +#endif
>=20
> unsigned int mpic_get_mcirq(void)
> {
> --=20
> 1.7.2.5
