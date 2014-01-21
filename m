Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D30DA2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 04:11:46 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/2][v5] driver/memory:Move Freescale IFC driver to a
 common driver
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1390026091-25111-1-git-send-email-prabhakar@freescale.com>
Date: Tue, 21 Jan 2014 11:11:31 -0600
Message-Id: <0E81C3B6-B875-4DA3-BD24-92B63C57E913@kernel.crashing.org>
References: <1390026091-25111-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2014, at 12:21 AM, Prabhakar Kushwaha =
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
> Changes for v4: Rebased to=20
> 	=
git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
>=20
> Changes for v5:=20
> 	- Moved powerpc/Kconfig option to driver/memory
>=20
>=20
> .../{powerpc =3D> memory-controllers}/fsl/ifc.txt    |    0
> arch/powerpc/Kconfig                               |    4 ----
> arch/powerpc/sysdev/Makefile                       |    1 -
> drivers/memory/Kconfig                             |    4 ++++
> drivers/memory/Makefile                            |    1 +
> {arch/powerpc/sysdev =3D> drivers/memory}/fsl_ifc.c  |    8 ++++++--
> drivers/mtd/nand/fsl_ifc_nand.c                    |    2 +-
> .../include/asm =3D> include/linux}/fsl_ifc.h        |    0
> 8 files changed, 12 insertions(+), 8 deletions(-)
> rename Documentation/devicetree/bindings/{powerpc =3D> =
memory-controllers}/fsl/ifc.txt (100%)
> rename {arch/powerpc/sysdev =3D> drivers/memory}/fsl_ifc.c (98%)
> rename {arch/powerpc/include/asm =3D> include/linux}/fsl_ifc.h (100%)
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt =
b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
> rename to =
Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b44b52c..83fb8b3 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -725,10 +725,6 @@ config FSL_LBC
> 	  controller.  Also contains some common code used by
> 	  drivers for specific local bus peripherals.
>=20
> -config FSL_IFC
> -	bool
> -        depends on FSL_SOC
> -
> config FSL_GTM
> 	bool
> 	depends on PPC_83xx || QUICC_ENGINE || CPM2
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
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 29a11db..b33bb0e 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -50,4 +50,8 @@ config TEGRA30_MC
> 	  analysis, especially for IOMMU/SMMU(System Memory Management
> 	  Unit) module.
>=20
> +config FSL_IFC
> +	bool
> +        depends on FSL_SOC
> +

I think this should be user selectable like all the other Kconfig =
options in drivers/memory

Also add a help description.

> endif

[ snip ]

- k
