Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 161602C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 04:09:04 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/2][v3] driver/memory:Move Freescale IFC driver to a
 common driver
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1389850929-19873-1-git-send-email-prabhakar@freescale.com>
Date: Fri, 17 Jan 2014 11:08:44 -0600
Message-Id: <E7780BC2-F914-4D0C-8AB9-9FE7437A5C48@kernel.crashing.org>
References: <1389850929-19873-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 15, 2014, at 11:42 PM, Prabhakar Kushwaha =
<prabhakar@freescale.com> wrote:

> Freescale IFC controller has been used for mpc8xxx. It will be used
> for ARM-based SoC as well. This patch moves the driver to =
driver/memory
> and fix the header file includes.
>=20
> Also remove module_platform_driver() and  instead call
> platform_driver_register() from subsys_initcall() to make sure this =
module
> has been loaded before MTD partition parsing starts.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes for v2:
> 	- Move fsl_ifc in driver/memory
>=20
> Changes for v3:
> 	- move device tree bindings to memory
>=20
> .../{powerpc =3D> memory-controllers}/fsl/ifc.txt    |    0
> arch/powerpc/sysdev/Makefile                       |    1 -
> drivers/memory/Makefile                            |    1 +
> {arch/powerpc/sysdev =3D> drivers/memory}/fsl_ifc.c  |    8 ++++++--
> drivers/mtd/nand/fsl_ifc_nand.c                    |    2 +-
> .../include/asm =3D> include/linux}/fsl_ifc.h        |    0
> 6 files changed, 8 insertions(+), 4 deletions(-)
> rename Documentation/devicetree/bindings/{powerpc =3D> =
memory-controllers}/fsl/ifc.txt (100%)
> rename {arch/powerpc/sysdev =3D> drivers/memory}/fsl_ifc.c (98%)
> rename {arch/powerpc/include/asm =3D> include/linux}/fsl_ifc.h (100%)

The Kconfig option for FSL_IFC should move into drivers/memory/Kconfig

>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt =
b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
> rename to =
Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> diff --git a/arch/powerpc/sysdev/Makefile =
b/arch/powerpc/sysdev/Makefile
> index f67ac90..afbcc37 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -21,7 +21,6 @@ obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o =
fsl_mpic_err.o
> obj-$(CONFIG_FSL_PCI)		+=3D fsl_pci.o $(fsl-msi-obj-y)
> obj-$(CONFIG_FSL_PMC)		+=3D fsl_pmc.o
> obj-$(CONFIG_FSL_LBC)		+=3D fsl_lbc.o
> -obj-$(CONFIG_FSL_IFC)		+=3D fsl_ifc.o
> obj-$(CONFIG_FSL_GTM)		+=3D fsl_gtm.o
> obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+=3D fsl_85xx_l2ctlr.o =
fsl_85xx_cache_sram.o
> obj-$(CONFIG_SIMPLE_GPIO)	+=3D simple_gpio.o
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 969d923..f2bf25c 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -6,6 +6,7 @@ ifeq ($(CONFIG_DDR),y)
> obj-$(CONFIG_OF)		+=3D of_memory.o
> endif
> obj-$(CONFIG_TI_EMIF)		+=3D emif.o
> +obj-$(CONFIG_FSL_IFC)		+=3D fsl_ifc.o
> obj-$(CONFIG_MVEBU_DEVBUS)	+=3D mvebu-devbus.o
> obj-$(CONFIG_TEGRA20_MC)	+=3D tegra20-mc.o
> obj-$(CONFIG_TEGRA30_MC)	+=3D tegra30-mc.o
> diff --git a/arch/powerpc/sysdev/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> similarity index 98%
> rename from arch/powerpc/sysdev/fsl_ifc.c
> rename to drivers/memory/fsl_ifc.c
> index d7fc722..135a950 100644
> --- a/arch/powerpc/sysdev/fsl_ifc.c
> +++ b/drivers/memory/fsl_ifc.c
> @@ -30,8 +30,8 @@
> #include <linux/of.h>
> #include <linux/of_device.h>
> #include <linux/platform_device.h>
> +#include <linux/fsl_ifc.h>
> #include <asm/prom.h>
> -#include <asm/fsl_ifc.h>
>=20
> struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
> EXPORT_SYMBOL(fsl_ifc_ctrl_dev);
> @@ -299,7 +299,11 @@ static struct platform_driver fsl_ifc_ctrl_driver =
=3D {
> 	.remove      =3D fsl_ifc_ctrl_remove,
> };
>=20
> -module_platform_driver(fsl_ifc_ctrl_driver);
> +static int __init fsl_ifc_init(void)
> +{
> +	return platform_driver_register(&fsl_ifc_ctrl_driver);
> +}
> +subsys_initcall(fsl_ifc_init);
>=20
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Freescale Semiconductor");
> diff --git a/drivers/mtd/nand/fsl_ifc_nand.c =
b/drivers/mtd/nand/fsl_ifc_nand.c
> index 4335577..865b323 100644
> --- a/drivers/mtd/nand/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/fsl_ifc_nand.c
> @@ -30,7 +30,7 @@
> #include <linux/mtd/nand.h>
> #include <linux/mtd/partitions.h>
> #include <linux/mtd/nand_ecc.h>
> -#include <asm/fsl_ifc.h>
> +#include <linux/fsl_ifc.h>
>=20
> #define FSL_IFC_V1_1_0	0x01010000
> #define ERR_BYTE		0xFF /* Value returned for read
> diff --git a/arch/powerpc/include/asm/fsl_ifc.h =
b/include/linux/fsl_ifc.h
> similarity index 100%
> rename from arch/powerpc/include/asm/fsl_ifc.h
> rename to include/linux/fsl_ifc.h
> --=20
> 1.7.9.5
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
