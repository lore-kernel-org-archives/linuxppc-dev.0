Return-Path: <Bharat.Bhushan@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CDAA1A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 13:37:56 +1000 (EST)
From: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2] memory: Freescale CoreNet Coherency Fabric error
 reporting driver
Date: Thu, 3 Jul 2014 03:37:49 +0000
Message-ID: <2c99870181dd45189e54e2f49c4b6726@BLUPR03MB566.namprd03.prod.outlook.com>
References: <20140702235211.GA3898@home.buserror.net>
In-Reply-To: <20140702235211.GA3898@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, July 03, 2014 5:22 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org; Bhushan Bharat-R65777
> Subject: [PATCH v2] memory: Freescale CoreNet Coherency Fabric error repo=
rting
> driver
>=20
> The CoreNet Coherency Fabric is part of the memory subsystem on
> some Freescale QorIQ chips.  It can report coherency violations (e.g.
> due to misusing memory that is mapped noncoherent) as well as
> transactions that do not hit any local access window, or which hit a
> local access window with an invalid target ID.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Reviewed-by: Bharat Bhushan <bharat.bhushan@freescale.com>


Regards
-Bharat

> ---
> v2:
>  - s/cecadr/cecaddr/ to consistently use ccf2 names
>  - fix ERRDET_CTYPE_MASK value
>  - use the ccf2 value for CECADDRH_ADDRH (harmless on ccf1)
>  - add comment explaining why we disable detection on remove for
>    ccf1 but not ccf2
> ---
>  arch/powerpc/configs/corenet32_smp_defconfig |   1 +
>  arch/powerpc/configs/corenet64_smp_defconfig |   1 +
>  drivers/memory/Kconfig                       |  10 ++
>  drivers/memory/Makefile                      |   1 +
>  drivers/memory/fsl-corenet-cf.c              | 251 +++++++++++++++++++++=
++++++
>  5 files changed, 264 insertions(+)
>  create mode 100644 drivers/memory/fsl-corenet-cf.c
>=20
> diff --git a/arch/powerpc/configs/corenet32_smp_defconfig
> b/arch/powerpc/configs/corenet32_smp_defconfig
> index 7d0c837..6a3c58a 100644
> --- a/arch/powerpc/configs/corenet32_smp_defconfig
> +++ b/arch/powerpc/configs/corenet32_smp_defconfig
> @@ -180,3 +180,4 @@ CONFIG_CRYPTO_SHA512=3Dy
>  CONFIG_CRYPTO_AES=3Dy
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_CRYPTO_DEV_FSL_CAAM=3Dy
> +CONFIG_FSL_CORENET_CF=3Dy
> diff --git a/arch/powerpc/configs/corenet64_smp_defconfig
> b/arch/powerpc/configs/corenet64_smp_defconfig
> index 6ae07e1..4b07bad 100644
> --- a/arch/powerpc/configs/corenet64_smp_defconfig
> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> @@ -179,3 +179,4 @@ CONFIG_CRYPTO_SHA256=3Dy
>  CONFIG_CRYPTO_SHA512=3Dy
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_CRYPTO_DEV_FSL_CAAM=3Dy
> +CONFIG_FSL_CORENET_CF=3Dy
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index c59e9c9..fab81a1 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -61,6 +61,16 @@ config TEGRA30_MC
>  	  analysis, especially for IOMMU/SMMU(System Memory Management
>  	  Unit) module.
>=20
> +config FSL_CORENET_CF
> +	tristate "Freescale CoreNet Error Reporting"
> +	depends on FSL_SOC_BOOKE
> +	help
> +	  Say Y for reporting of errors from the Freescale CoreNet
> +	  Coherency Fabric.  Errors reported include accesses to
> +	  physical addresses that mapped by no local access window
> +	  (LAW) or an invalid LAW, as well as bad cache state that
> +	  represents a coherency violation.
> +
>  config FSL_IFC
>  	bool
>  	depends on FSL_SOC
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 71160a2..4055c47 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_OF)		+=3D of_memory.o
>  endif
>  obj-$(CONFIG_TI_AEMIF)		+=3D ti-aemif.o
>  obj-$(CONFIG_TI_EMIF)		+=3D emif.o
> +obj-$(CONFIG_FSL_CORENET_CF)	+=3D fsl-corenet-cf.o
>  obj-$(CONFIG_FSL_IFC)		+=3D fsl_ifc.o
>  obj-$(CONFIG_MVEBU_DEVBUS)	+=3D mvebu-devbus.o
>  obj-$(CONFIG_TEGRA20_MC)	+=3D tegra20-mc.o
> diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet=
-cf.c
> new file mode 100644
> index 0000000..c9443fc
> --- /dev/null
> +++ b/drivers/memory/fsl-corenet-cf.c
> @@ -0,0 +1,251 @@
> +/*
> + * CoreNet Coherency Fabric error reporting
> + *
> + * Copyright 2014 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify=
 it
> + * under  the terms of  the GNU General  Public License as published by =
the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +
> +enum ccf_version {
> +	CCF1,
> +	CCF2,
> +};
> +
> +struct ccf_info {
> +	enum ccf_version version;
> +	int err_reg_offs;
> +};
> +
> +static const struct ccf_info ccf1_info =3D {
> +	.version =3D CCF1,
> +	.err_reg_offs =3D 0xa00,
> +};
> +
> +static const struct ccf_info ccf2_info =3D {
> +	.version =3D CCF2,
> +	.err_reg_offs =3D 0xe40,
> +};
> +
> +static const struct of_device_id ccf_matches[] =3D {
> +	{
> +		.compatible =3D "fsl,corenet1-cf",
> +		.data =3D &ccf1_info,
> +	},
> +	{
> +		.compatible =3D "fsl,corenet2-cf",
> +		.data =3D &ccf2_info,
> +	},
> +	{}
> +};
> +
> +struct ccf_err_regs {
> +	u32 errdet;		/* 0x00 Error Detect Register */
> +	/* 0x04 Error Enable (ccf1)/Disable (ccf2) Register */
> +	u32 errdis;
> +	/* 0x08 Error Interrupt Enable Register (ccf2 only) */
> +	u32 errinten;
> +	u32 cecar;		/* 0x0c Error Capture Attribute Register */
> +	u32 cecaddrh;		/* 0x10 Error Capture Address High */
> +	u32 cecaddrl;		/* 0x14 Error Capture Address Low */
> +	u32 cecar2;		/* 0x18 Error Capture Attribute Register 2 */
> +};
> +
> +/* LAE/CV also valid for errdis and errinten */
> +#define ERRDET_LAE		(1 << 0)  /* Local Access Error */
> +#define ERRDET_CV		(1 << 1)  /* Coherency Violation */
> +#define ERRDET_CTYPE_SHIFT	26	  /* Capture Type (ccf2 only) */
> +#define ERRDET_CTYPE_MASK	(0x1f << ERRDET_CTYPE_SHIFT)
> +#define ERRDET_CAP		(1 << 31) /* Capture Valid (ccf2 only) */
> +
> +#define CECAR_VAL		(1 << 0)  /* Valid (ccf1 only) */
> +#define CECAR_UVT		(1 << 15) /* Unavailable target ID (ccf1) */
> +#define CECAR_SRCID_SHIFT_CCF1	24
> +#define CECAR_SRCID_MASK_CCF1	(0xff << CECAR_SRCID_SHIFT_CCF1)
> +#define CECAR_SRCID_SHIFT_CCF2	18
> +#define CECAR_SRCID_MASK_CCF2	(0xff << CECAR_SRCID_SHIFT_CCF2)
> +
> +#define CECADDRH_ADDRH		0xff
> +
> +struct ccf_private {
> +	const struct ccf_info *info;
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct ccf_err_regs __iomem *err_regs;
> +};
> +
> +static irqreturn_t ccf_irq(int irq, void *dev_id)
> +{
> +	struct ccf_private *ccf =3D dev_id;
> +	static DEFINE_RATELIMIT_STATE(ratelimit, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
> +	u32 errdet, cecar, cecar2;
> +	u64 addr;
> +	u32 src_id;
> +	bool uvt =3D false;
> +	bool cap_valid =3D false;
> +
> +	errdet =3D ioread32be(&ccf->err_regs->errdet);
> +	cecar =3D ioread32be(&ccf->err_regs->cecar);
> +	cecar2 =3D ioread32be(&ccf->err_regs->cecar2);
> +	addr =3D ioread32be(&ccf->err_regs->cecaddrl);
> +	addr |=3D ((u64)(ioread32be(&ccf->err_regs->cecaddrh) &
> +		       CECADDRH_ADDRH)) << 32;
> +
> +	if (!__ratelimit(&ratelimit))
> +		goto out;
> +
> +	switch (ccf->info->version) {
> +	case CCF1:
> +		if (cecar & CECAR_VAL) {
> +			if (cecar & CECAR_UVT)
> +				uvt =3D true;
> +
> +			src_id =3D (cecar & CECAR_SRCID_MASK_CCF1) >>
> +				 CECAR_SRCID_SHIFT_CCF1;
> +			cap_valid =3D true;
> +		}
> +
> +		break;
> +	case CCF2:
> +		if (errdet & ERRDET_CAP) {
> +			src_id =3D (cecar & CECAR_SRCID_MASK_CCF2) >>
> +				 CECAR_SRCID_SHIFT_CCF2;
> +			cap_valid =3D true;
> +		}
> +
> +		break;
> +	}
> +
> +	dev_crit(ccf->dev, "errdet 0x%08x cecar 0x%08x cecar2 0x%08x\n",
> +		 errdet, cecar, cecar2);
> +
> +	if (errdet & ERRDET_LAE) {
> +		if (uvt)
> +			dev_crit(ccf->dev, "LAW Unavailable Target ID\n");
> +		else
> +			dev_crit(ccf->dev, "Local Access Window Error\n");
> +	}
> +
> +	if (errdet & ERRDET_CV)
> +		dev_crit(ccf->dev, "Coherency Violation\n");
> +
> +	if (cap_valid) {
> +		dev_crit(ccf->dev, "address 0x%09llx, src id 0x%x\n",
> +			 addr, src_id);
> +	}
> +
> +out:
> +	iowrite32be(errdet, &ccf->err_regs->errdet);
> +	return errdet ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int ccf_probe(struct platform_device *pdev)
> +{
> +	struct ccf_private *ccf;
> +	struct resource *r;
> +	const struct of_device_id *match;
> +	int ret, irq;
> +
> +	match =3D of_match_device(ccf_matches, &pdev->dev);
> +	if (WARN_ON(!match))
> +		return -ENODEV;
> +
> +	ccf =3D devm_kzalloc(&pdev->dev, sizeof(*ccf), GFP_KERNEL);
> +	if (!ccf)
> +		return -ENOMEM;
> +
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	ccf->regs =3D devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(ccf->regs)) {
> +		dev_err(&pdev->dev, "%s: can't map mem resource\n", __func__);
> +		return PTR_ERR(ccf->regs);
> +	}
> +
> +	ccf->dev =3D &pdev->dev;
> +	ccf->info =3D match->data;
> +	ccf->err_regs =3D ccf->regs + ccf->info->err_reg_offs;
> +
> +	dev_set_drvdata(&pdev->dev, ccf);
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (!irq) {
> +		dev_err(&pdev->dev, "%s: no irq\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	ret =3D devm_request_irq(&pdev->dev, irq, ccf_irq, 0, pdev->name, ccf);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: can't request irq\n", __func__);
> +		return ret;
> +	}
> +
> +	switch (ccf->info->version) {
> +	case CCF1:
> +		/* On CCF1 this register enables rather than disables. */
> +		iowrite32be(ERRDET_LAE | ERRDET_CV, &ccf->err_regs->errdis);
> +		break;
> +
> +	case CCF2:
> +		iowrite32be(0, &ccf->err_regs->errdis);
> +		iowrite32be(ERRDET_LAE | ERRDET_CV, &ccf->err_regs->errinten);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ccf_remove(struct platform_device *pdev)
> +{
> +	struct ccf_private *ccf =3D dev_get_drvdata(&pdev->dev);
> +
> +	switch (ccf->info->version) {
> +	case CCF1:
> +		iowrite32be(0, &ccf->err_regs->errdis);
> +		break;
> +
> +	case CCF2:
> +		/*
> +		 * We clear errdis on ccf1 because that's the only way to
> +		 * disable interrupts, but on ccf2 there's no need to disable
> +		 * detection.
> +		 */
> +		iowrite32be(0, &ccf->err_regs->errinten);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ccf_driver =3D {
> +	.driver =3D {
> +		.name =3D KBUILD_MODNAME,
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D ccf_matches,
> +	},
> +	.probe =3D ccf_probe,
> +	.remove =3D ccf_remove,
> +};
> +
> +module_platform_driver(ccf_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("Freescale CoreNet Coherency Fabric error reporting")=
;
> --
> 1.9.1
