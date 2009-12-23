Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 911B4B7BF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Dec 2009 04:23:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] Adding PCI-E MSI support for PowerPC 460SX SOC.
Date: Wed, 23 Dec 2009 09:23:14 -0800
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C08882A65@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <200912230918.34124.sr@denx.de>
References: <1261554743-30498-1-git-send-email-tmarri@amcc.com>
	<200912230918.34124.sr@denx.de>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Stefan Roese" <sr@denx.de>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, writetomarri@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for the suggestions. I will try remove the extra lines . Add
changes you suggested.
-Marri

-----Original Message-----
From: linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org] On =
Behalf
Of Stefan Roese
Sent: Wednesday, December 23, 2009 12:19 AM
To: linuxppc-dev@lists.ozlabs.org
Cc: linuxppc-dev@ozlabs.org; writetomarri@yahoo.com; Tirumala Reddy
Marri
Subject: Re: [PATCH 2/2] Adding PCI-E MSI support for PowerPC 460SX SOC.

On Wednesday 23 December 2009 08:52:23 tmarri@amcc.com wrote:
> From: Tirumala Marri <tmarri@amcc.com>

Please find some mostly nitpicking comments below.

BTW: Did you already test this on other 4xx platforms, like 440SPe or
405EX?=20
What are your plans here?
=20
> Signed-off-by: Tirumala Marri <tmarri@amcc.com>
> ---
> Kernel version: 2.6.33-rc1
> Testing:
> 	When 460SX configured as root as a end point E1000(Intell
Ethernet card)
> 	was plugged into the one of the PCI-E ports. I was able to run
the traffic
> 	with MSI interrupts.
> ---
>  arch/powerpc/boot/dts/redwood.dts          |   15 ++
>  arch/powerpc/configs/44x/redwood_defconfig |    5 +-
>  arch/powerpc/platforms/44x/Kconfig         |    1 +
>  arch/powerpc/sysdev/Kconfig                |    7 +
>  arch/powerpc/sysdev/Makefile               |    1 +
>  arch/powerpc/sysdev/ppc4xx_msi.c           |  342
>  ++++++++++++++++++++++++++++ arch/powerpc/sysdev/ppc4xx_msi.h
|=20
>   39 ++++
>  7 files changed, 408 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/ppc4xx_msi.c
>  create mode 100644 arch/powerpc/sysdev/ppc4xx_msi.h
>=20
> diff --git a/arch/powerpc/boot/dts/redwood.dts
>  b/arch/powerpc/boot/dts/redwood.dts index 81636c0..412d5f9 100644
> --- a/arch/powerpc/boot/dts/redwood.dts
> +++ b/arch/powerpc/boot/dts/redwood.dts
> @@ -357,6 +357,21 @@
>  				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /*
swizzled int C */
>  				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /*
swizzled int D */>;
>  		};
> +  		MSI: ppc4xx-msi@400300000 {
> +  			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";

Better use something like this:

  			compatible =3D "amcc,ppc4xx-msi-ppc460sx",
"amcc,ppc4xx-msi";

This way you could check for 460SX specials in the driver if needed.

> +  			reg =3D < 0x4 0x00300000 0x100
> +  				0x4 0x00300000 0x100>;
> +  			sdr-base =3D <0x3B0>;
> +  			interrupts =3D<0 1 2 3>;
> +  			interrupt-parent =3D <&MSI>;
> +  			#interrupt-cells =3D <1>;
> +  			#address-cells =3D <0>;
> +  			#size-cells =3D <0>;
> +  			interrupt-map =3D <0 &UIC0 0xC 1
> +  				1 &UIC0 0x0D 1
> +  				2 &UIC0 0x0E 1
> +  				3 &UIC0 0x0F 1>;
> +  		};
>=20
>  	};
>=20
> diff --git a/arch/powerpc/configs/44x/redwood_defconfig
>  b/arch/powerpc/configs/44x/redwood_defconfig index ed31d4f..5d16c88
100644
> --- a/arch/powerpc/configs/44x/redwood_defconfig
> +++ b/arch/powerpc/configs/44x/redwood_defconfig
> @@ -158,6 +158,7 @@ CONFIG_DEFAULT_AS=3Dy
>  CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
>  # CONFIG_FREEZER is not set
>  CONFIG_PPC4xx_PCI_EXPRESS=3Dy
> +CONFIG_PPC_MSI_BITMAP=3Dy
>=20
>  #
>  # Platform support
> @@ -264,7 +265,7 @@ CONFIG_PCIEPORTBUS=3Dy
>  CONFIG_PCIEAER=3Dy
>  # CONFIG_PCIEASPM is not set
>  CONFIG_ARCH_SUPPORTS_MSI=3Dy
> -# CONFIG_PCI_MSI is not set
> +CONFIG_PCI_MSI=3Dy
>  # CONFIG_PCI_LEGACY is not set
>  # CONFIG_PCI_DEBUG is not set
>  # CONFIG_PCI_STUB is not set
> @@ -1062,7 +1063,7 @@ CONFIG_PRINT_STACK_DEPTH=3D64
>  # CONFIG_DEBUG_PAGEALLOC is not set
>  # CONFIG_CODE_PATCHING_SELFTEST is not set
>  # CONFIG_FTR_FIXUP_SELFTEST is not set
> -# CONFIG_MSI_BITMAP_SELFTEST is not set
> +CONFIG_MSI_BITMAP_SELFTEST=3Dy
>  # CONFIG_XMON is not set
>  # CONFIG_IRQSTACKS is not set
>  # CONFIG_VIRQ_DEBUG is not set
> diff --git a/arch/powerpc/platforms/44x/Kconfig
>  b/arch/powerpc/platforms/44x/Kconfig index 7486bff..9c3b8ca 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -126,6 +126,7 @@ config REDWOOD
>  	select 460SX
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select PPC4xx_MSI
>  	help
>  	  This option enables support for the AMCC PPC460SX Redwood
board.
>=20
> diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
> index 3965828..c8f1486 100644
> --- a/arch/powerpc/sysdev/Kconfig
> +++ b/arch/powerpc/sysdev/Kconfig
> @@ -7,8 +7,15 @@ config PPC4xx_PCI_EXPRESS
>  	depends on PCI && 4xx
>  	default n
>=20
> +config PPC4xx_MSI
> +	bool
> +	depends on PCI_MSI
> +	depends on PCI && 4xx
> +	default n
> +
>  config PPC_MSI_BITMAP
>  	bool
>  	depends on PCI_MSI
>  	default y if MPIC
>  	default y if FSL_PCI
> +	default y if PPC4xx_MSI
> diff --git a/arch/powerpc/sysdev/Makefile
b/arch/powerpc/sysdev/Makefile
> index 5642924..4c67d2d 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_PPC_I8259)		+=3D i8259.o
>  obj-$(CONFIG_IPIC)		+=3D ipic.o
>  obj-$(CONFIG_4xx)		+=3D uic.o
>  obj-$(CONFIG_4xx_SOC)		+=3D ppc4xx_soc.o
> +obj-$(CONFIG_PPC4xx_MSI)		+=3D ppc4xx_msi.o
>  obj-$(CONFIG_XILINX_VIRTEX)	+=3D xilinx_intc.o
>  obj-$(CONFIG_XILINX_PCI)	+=3D xilinx_pci.o
>  obj-$(CONFIG_OF_RTC)		+=3D of_rtc.o
> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c
>  b/arch/powerpc/sysdev/ppc4xx_msi.c new file mode 100644
> index 0000000..3c2ef32
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> @@ -0,0 +1,342 @@
> +/*
> + * Copyright (C) 2009 Applied Micro Circuits corporation.
> + *
> + * Author: Feng Kan <fkan@amcc.com>
> + * 	   Tirumala Marri <tmarri@amcc.com>
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + */
> +#include <linux/irq.h>
> +#include <linux/bootmem.h>
> +#include <linux/pci.h>
> +#include <linux/msi.h>
> +#include <linux/of_platform.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <asm/prom.h>
> +#include <asm/hw_irq.h>
> +#include <asm/ppc-pci.h>
> +#include <asm/dcr.h>
> +#include <asm/dcr-regs.h>
> +#include "ppc4xx_msi.h"
> +
> +

Nitpicking: Remove one empty line here.

> +static struct ppc4xx_msi *ppc4xx_msi;
> +
> +struct ppc4xx_msi_feature {
> +	u32 ppc4xx_pic_ip;
> +	u32 msiir_offset;
> +};
> +
> +static int ppc4xx_msi_init_allocator(struct ppc4xx_msi *msi_data)
> +{
> +	int rc;
> +
> +	rc =3D msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
> +				msi_data->irqhost->of_node);
> +	if (rc)
> +		return rc;
> +	rc =3D msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
> +	if (rc < 0) {
> +		msi_bitmap_free(&msi_data->bitmap);
> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +

Nitpicking: Remove one empty line here.

> +static void ppc4xx_msi_cascade(unsigned int irq, struct irq_desc
*desc)
> +{
> +	unsigned int cascade_irq;
> +	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
> +	int msir_index =3D -1;
> +
> +	raw_spin_lock(&desc->lock);
> +	if (desc->chip->mask_ack) {
> +		desc->chip->mask_ack(irq);
> +	} else {
> +		desc->chip->mask(irq);
> +		desc->chip->ack(irq);
> +	}
> +
> +	if (unlikely(desc->status & IRQ_INPROGRESS))
> +		goto unlock;
> +
> +	msir_index =3D (int)desc->handler_data;
> +
> +	if (msir_index >=3D NR_MSI_IRQS)
> +		cascade_irq =3D NO_IRQ;
> +
> +	desc->status |=3D IRQ_INPROGRESS;
> +
> +	cascade_irq =3D irq_linear_revmap(msi_data->irqhost, msir_index);
> +	if (cascade_irq !=3D NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +	desc->status &=3D ~IRQ_INPROGRESS;
> +
> +	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
> +		desc->chip->unmask(irq);
> +unlock:
> +	raw_spin_unlock(&desc->lock);
> +}

Nitpicking: Add one empty line here.

> +static void ppc4xx_compose_msi_msg(struct pci_dev *pdev, int hwirq,
> +					struct msi_msg *msg)
> +{
> +	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
> +
> +	msg->address_lo =3D msi_data->msi_addr_lo;
> +	msg->address_hi =3D msi_data->msi_addr_hi;
> +	msg->data =3D hwirq;
> +}
> +
> +

Nitpicking: Remove one empty line here.

> +int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	struct msi_desc *entry;
> +	int rc, hwirq;
> +	unsigned int virq;
> +	struct msi_msg msg;
> +	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
> +
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		hwirq =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> +		if (hwirq < 0) {
> +			rc =3D hwirq;
> +			dev_err(&dev->dev, "%s: fail allocating msi\
> +					interrupt\n",	__func__);
> +			goto out_free;
> +		}
> +
> +		pr_debug(KERN_INFO"mis is %p\n", msi_data->irqhost);
> +		virq =3D irq_create_mapping(msi_data->irqhost, hwirq);
> +		if (virq =3D=3D NO_IRQ) {
> +			dev_err(&dev->dev, "%s: fail mapping irq\n",
__func__);
> +			rc =3D -ENOSPC;
> +			goto out_free;
> +		}
> +
> +		set_irq_msi(virq, entry);
> +		ppc4xx_compose_msi_msg(dev, hwirq, &msg);
> +		write_msi_msg(virq, &msg);
> +	}
> +
> +	return 0;
> +out_free:
> +	return rc;
> +}
> +
> +void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *entry;
> +	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
> +	 dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		if (entry->irq =3D=3D NO_IRQ)
> +			continue;
> +		set_irq_msi(entry->irq, NULL);
> +		msi_bitmap_free_hwirqs(&msi_data->bitmap,
> +				       virq_to_hw(entry->irq), 1);
> +		irq_dispose_mapping(entry->irq);
> +

Nitpicking: Remove one empty line here.

> +	}
> +
> +	return;
> +}
> +
> +static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec,
int
>  type) +{
> +	pr_debug(KERN_INFO"PCIE-MSI:%s called. vec %x type %d\n",
> +					__func__, nvec, type);
> +	return 0;
> +}
> +
> +/*
> + * We do not need this actually. The MSIR register has been read once
> + * in the cascade interrupt. So, this MSI interrupt has been acked
> +*/
> +static void ppc4xx_msi_end_irq(unsigned int virq)
> +{
> +}
> +
> +

Nitpicking: Remove one empty line here. I'll stop mentioning this here.
Please=20
check the whole file for this.

> +static struct irq_chip ppc4xx_msi_chip =3D {
> +	.mask           =3D mask_msi_irq,
> +	.unmask         =3D unmask_msi_irq,
> +	.ack            =3D ppc4xx_msi_end_irq,
> +	.name       =3D " UIC",
> +};
> +
> +static int ppc4xx_msi_host_map(struct irq_host *h, unsigned int virq,
> +				irq_hw_number_t hw)
> +{
> +	struct irq_chip *chip =3D &ppc4xx_msi_chip;
> +
> +	irq_to_desc(virq)->status |=3D IRQ_TYPE_EDGE_RISING;
> +
> +	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
> +
> +	return 0;
> +}
> +
> +static struct irq_host_ops ppc4xx_msi_host_ops =3D {
> +	.map =3D ppc4xx_msi_host_map,
> +};
> +
> +
> +static int __devinit ppc4xx_msi_probe(struct of_device *dev,
> +					const struct of_device_id
*match)
> +{
> +	struct ppc4xx_msi *msi;
> +	struct resource res, rmsi;
> +	int i, count;
> +	int rc;
> +	int virt_msir;
> +	const u32 *p;
> +	const u32 *sdr_base;
> +	u32 *msi_virt =3D NULL;
> +	dma_addr_t msi_phys;
> +
> +
> +	msi =3D kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
> +	if (!msi) {
> +		dev_err(&dev->dev, "No memory for MSI structure\n");
> +		rc =3D -ENOMEM;
> +		goto error_out;
> +	}
> +
> +	msi->irqhost =3D irq_alloc_host(dev->node, IRQ_HOST_MAP_LINEAR,
> +				      NR_MSI_IRQS, &ppc4xx_msi_host_ops,
0);
> +	if (msi->irqhost =3D=3D NULL) {
> +		dev_err(&dev->dev, "No memory for MSI irqhost\n");
> +		rc =3D -ENOMEM;
> +		goto error_out;
> +	}
> +
> +
> +	/* Get MSI ranges */
> +	rc =3D of_address_to_resource(dev->node, 0, &rmsi);
> +	if (rc) {
> +		dev_err(&dev->dev, "%s resource error!\n",
> +				dev->node->full_name);
> +		goto error_out;
> +	}
> +
> +
> +	/* Get the MSI reg base */
> +	rc =3D of_address_to_resource(dev->node, 1, &res);
> +	if (rc) {
> +		dev_err(&dev->dev, "%s resource error!\n",
> +				dev->node->full_name);
> +		goto error_out;
> +	}
> +	/* Get the sdr-base */
> +	sdr_base =3D (u32 *)of_get_property(dev->node, "sdr-base", NULL);
> +	if (sdr_base =3D=3D NULL) {
> +		dev_err(&dev->dev, "%s resource error!\n",
> +				dev->node->full_name);
> +		goto error_out;
> +	}
> +	msi->sdr_base =3D *sdr_base;
> +#if  defined(CONFIG_460SX)
> +	mtdcri(SDR0, msi->sdr_base, res.start >> 32);
> +	mtdcri(SDR0, msi->sdr_base + 1, res.start & 0xFFFFFFFF);
> +	msi->msi_regs =3D ioremap(res.start, res.end - res.start + 1);

	msi->msi_regs =3D ioremap(res.start, resource_size(&res));

> +#else
> +	dev_err(&dev->dev, " Invalid Device \n");
> +	goto error_out;
> +#endif

Please don't introduce such a compile-time selection here. You don't
even need=20
it, since the register bases are provided via the device-tree. So just
remove=20
the #if and it's #else part here.

> +	if (!msi->msi_regs) {
> +		dev_err(&dev->dev, "ioremap problem failed\n");
> +		goto error_out;
> +	}
> +	/* MSI region always mapped in 4GB region*/
> +	msi->msi_addr_hi =3D 0x0;
> +	msi_virt =3D dma_alloc_coherent(&dev->dev, 64, &msi_phys,
> +			GFP_KERNEL);
> +	if (msi_virt =3D=3D NULL) {
> +		dev_err(&dev->dev, "No memory for MSI mem space\n");
> +		rc =3D -ENOMEM;
> +		goto error_out;
> +	}
> +	msi->msi_addr_lo =3D (u32)msi_phys;
> +
> +	/* Progam the Interrupt handler Termination addr registers */
> +	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
> +	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
> +
> +	/* Program MSI Expected data and Mask bits */
> +	out_be32(msi->msi_regs + PEIH_MSIED, MSI_DATA_PATTERN);
> +	out_be32(msi->msi_regs + PEIH_MSIMK, MSI_DATA_PATTERN);
> +
> +	msi->irqhost->host_data =3D msi;
> +
> +	if (ppc4xx_msi_init_allocator(msi)) {
> +		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
> +		goto error_out;
> +	}
> +
> +	p =3D of_get_property(dev->node, "interrupts", &count);
> +	if (!p) {
> +		dev_err(&dev->dev, "no interrupts property found on
%s\n",
> +				dev->node->full_name);
> +		rc =3D -ENODEV;
> +		goto error_out;
> +	}
> +	if (count =3D=3D 0) {
> +		dev_err(&dev->dev, "Malformed interrupts property on
%s\n",
> +				dev->node->full_name);
> +		rc =3D -EINVAL;
> +		goto error_out;
> +	}
> +
> +	for (i =3D 0; i < NR_MSI_IRQS; i++) {
> +		virt_msir =3D irq_of_parse_and_map(dev->node, i);
> +		if (virt_msir !=3D NO_IRQ) {
> +			set_irq_data(virt_msir, (void *)i);
> +			set_irq_chained_handler(virt_msir,
ppc4xx_msi_cascade);
> +		}
> +	}
> +
> +	ppc4xx_msi =3D msi;
> +
> +	WARN_ON(ppc_md.setup_msi_irqs);
> +	ppc_md.setup_msi_irqs =3D ppc4xx_setup_msi_irqs;
> +	ppc_md.teardown_msi_irqs =3D ppc4xx_teardown_msi_irqs;
> +	ppc_md.msi_check_device =3D ppc4xx_msi_check_device;
> +	return 0;
> +error_out:
> +	if (msi_virt)
> +		dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
> +	kfree(msi);
> +	return rc;
> +}
> +
> +static const struct ppc4xx_msi_feature ppc4xx_msi_feature =3D {
> +	.ppc4xx_pic_ip =3D 0,
> +	.msiir_offset =3D 0x140,
> +};
> +
> +static const struct of_device_id ppc4xx_msi_ids[] =3D {
> +	{
> +		.compatible =3D "amcc,ppc4xx-msi",
> +		.data =3D (void *)&ppc4xx_msi_feature,
> +	},
> +	{}
> +};
> +
> +static struct of_platform_driver ppc4xx_msi_driver =3D {
> +	.name =3D "ppc4xx-msi",
> +	.match_table =3D ppc4xx_msi_ids,
> +	.probe =3D ppc4xx_msi_probe,
> +};
> +
> +static __init int ppc4xx_msi_init(void)
> +{
> +	return of_register_platform_driver(&ppc4xx_msi_driver);
> +}
> +
> +subsys_initcall(ppc4xx_msi_init);
> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.h
>  b/arch/powerpc/sysdev/ppc4xx_msi.h new file mode 100644
> index 0000000..e4ae058
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_msi.h
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (C) 2009 Applied Micro Circuits Corporation.
> + *
> + * Author: Tirumala Marri <tmarri@amcc.com>
> + * 		Feng Kan <fkan@amcc.com>
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + */
> +#ifndef __PPC4XX_MSI_H__
> +#define __PPC4XX_MSI_H__
> +
> +#include <asm/msi_bitmap.h>
> +
> +#define PEIH_TERMADH    0x00
> +#define PEIH_TERMADL    0x08
> +#define PEIH_MSIED      0x10
> +#define PEIH_MSIMK      0x18
> +#define PEIH_MSIASS     0x20
> +#define PEIH_FLUSH0     0x30
> +#define PEIH_FLUSH1     0x38
> +#define PEIH_CNTRST     0x48
> +
> +#define MSI_DATA_PATTERN   0x44440000
> +
> +struct ppc4xx_msi {
> +	struct irq_host *irqhost;
> +	unsigned long cascade_irq;
> +	u32 msi_addr_lo;
> +	u32 msi_addr_hi;
> +	void __iomem *msi_regs;
> +	u32 feature;
> +	struct msi_bitmap bitmap;
> +	u32 sdr_base;
> +};
> +
> +#define NR_MSI_IRQS 4
> +#endif /* __PPC4XX_MSI_H__ */
>=20

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
