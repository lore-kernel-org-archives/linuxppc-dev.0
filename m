Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 86ED9B7BBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Dec 2009 04:55:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] Adding PCI-E MSI support for PowerPC 460SX SOC.
Date: Tue, 22 Dec 2009 09:55:45 -0800
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C08882824@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20091222120748.GS16448@hansolo.jdub.homelinux.org>
References: <1261471791-476-1-git-send-email-tmarri@amcc.com>
	<20091222120748.GS16448@hansolo.jdub.homelinux.org>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, writetomarri@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh,
 Thanks for the comments. I will fix them re-submit it.
Regards,
Marri

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@gmail.com] On Behalf Of Josh Boyer
Sent: Tuesday, December 22, 2009 4:08 AM
To: Tirumala Reddy Marri
Cc: linuxppc-dev@lists.ozlabs.org; writetomarri@yahoo.com
Subject: Re: [PATCH 2/2] Adding PCI-E MSI support for PowerPC 460SX SOC.

On Tue, Dec 22, 2009 at 12:49:51AM -0800, tmarri@amcc.com wrote:
>From: Tirumala Marri <tmarri@amcc.com>
>
>
>Signed-off-by: Tirumala Marri <tmarri@amcc.com>
>---
>Kernel version: 2.6.33-rc1
>Testing:
>	When 460SX configured as root as a end point E1000(Intell
Ethernet card)=20
>	was plugged into the one of the PCI-E ports. I was able to run
the traffic
>	with MSI interrupts.=20
>---
> arch/powerpc/boot/dts/redwood.dts          |   15 ++
> arch/powerpc/configs/44x/redwood_defconfig |    5 +-
> arch/powerpc/platforms/44x/Kconfig         |    1 +
> arch/powerpc/sysdev/Kconfig                |    7 +
> arch/powerpc/sysdev/Makefile               |    1 +
> arch/powerpc/sysdev/ppc4xx_msi.c           |  335
++++++++++++++++++++++++++++
> arch/powerpc/sysdev/ppc4xx_msi.h           |   49 ++++
> 7 files changed, 411 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/sysdev/ppc4xx_msi.c
> create mode 100644 arch/powerpc/sysdev/ppc4xx_msi.h
>
>diff --git a/arch/powerpc/boot/dts/redwood.dts
b/arch/powerpc/boot/dts/redwood.dts
>index 81636c0..412d5f9 100644
>--- a/arch/powerpc/boot/dts/redwood.dts
>+++ b/arch/powerpc/boot/dts/redwood.dts
>@@ -357,6 +357,21 @@
> 				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /*
swizzled int C */
> 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /*
swizzled int D */>;
> 		};
>+  		MSI: ppc4xx-msi@400300000 {
>+  			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
>+  			reg =3D < 0x4 0x00300000 0x100
>+  				0x4 0x00300000 0x100>;
>+  			sdr-base =3D <0x3B0>;
>+  			interrupts =3D<0 1 2 3>;
>+  			interrupt-parent =3D <&MSI>;
>+  			#interrupt-cells =3D <1>;
>+  			#address-cells =3D <0>;
>+  			#size-cells =3D <0>;
>+  			interrupt-map =3D <0 &UIC0 0xC 1
>+  				1 &UIC0 0x0D 1
>+  				2 &UIC0 0x0E 1
>+  				3 &UIC0 0x0F 1>;
>+  		};
>=20
> 	};
>=20
>diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
>index 3965828..32f5a40 100644
>--- a/arch/powerpc/sysdev/Kconfig
>+++ b/arch/powerpc/sysdev/Kconfig
>@@ -7,8 +7,15 @@ config PPC4xx_PCI_EXPRESS
> 	depends on PCI && 4xx
> 	default n
>=20
>+config 4xx_MSI

This should probably be named PPC4xx_MSI, similar to how
PPC4xx_PCI_EXPRESS is named.

>+	bool
>+	depends on PCI_MSI
>+	depends on PCI && 4xx
>+	default n
>+
> config PPC_MSI_BITMAP
> 	bool
> 	depends on PCI_MSI
> 	default y if MPIC
> 	default y if FSL_PCI
>+	default y if 4xx_MSI

>diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c
b/arch/powerpc/sysdev/ppc4xx_msi.c
>new file mode 100644
>index 0000000..752da4b
>--- /dev/null
>+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
>@@ -0,0 +1,335 @@
>+/*
>+ * Copyright (C) 2009 Applied Micro Circuits corporation,
>+ * All rights reserved.

Please don't add the 'All rights reserved.' to new files.  It is
inaccurate and confusing given that it's a GPLv2 file.

>+ *
>+ * Author: Feng Kan <fkan@amcc.com>
>+ * 	   Tirumala Marri <tmarri@amcc.com>
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * as published by the Free Software Foundation; version 2 of the
>+ * License.
>+ */
>+#include <linux/irq.h>
>+#include <linux/bootmem.h>
>+#include <linux/pci.h>
>+#include <linux/msi.h>
>+#include <linux/of_platform.h>
>+#include <linux/interrupt.h>
>+#include <linux/device.h>
>+#include <asm/prom.h>
>+#include <asm/hw_irq.h>
>+#include <asm/ppc-pci.h>
>+#include <asm/dcr.h>
>+#include <asm/dcr-regs.h>
>+#include "ppc4xx_msi.h"
>+
>+
>+static struct ppc4xx_msi *ppc4xx_msi;
>+
>+struct ppc4xx_msi_feature {
>+	u32 ppc4xx_pic_ip;
>+	u32 msiir_offset;
>+};
>+
>+static int ppc4xx_msi_init_allocator(struct ppc4xx_msi *msi_data)
>+{
>+	int rc;
>+
>+	rc =3D msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
>+				msi_data->irqhost->of_node);
>+	if (rc)
>+		return rc;
>+	rc =3D msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
>+	if (rc < 0) {
>+		msi_bitmap_free(&msi_data->bitmap);
>+		return rc;
>+	}
>+	return 0;
>+}
>+
>+
>+static void ppc4xx_msi_cascade(unsigned int irq, struct irq_desc
*desc)
>+{
>+	unsigned int cascade_irq;
>+	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
>+	int msir_index =3D -1;
>+
>+	raw_spin_lock(&desc->lock);
>+	if (desc->chip->mask_ack) {
>+		desc->chip->mask_ack(irq);
>+	} else {
>+		desc->chip->mask(irq);
>+		desc->chip->ack(irq);
>+	}
>+
>+	if (unlikely(desc->status & IRQ_INPROGRESS))
>+		goto unlock;
>+
>+	msir_index =3D (int)desc->handler_data;
>+
>+	if (msir_index >=3D NR_MSI_IRQS)
>+		cascade_irq =3D NO_IRQ;
>+
>+	desc->status |=3D IRQ_INPROGRESS;
>+
>+	cascade_irq =3D irq_linear_revmap(msi_data->irqhost, msir_index);
>+	if (cascade_irq !=3D NO_IRQ)
>+		generic_handle_irq(cascade_irq);
>+	desc->status &=3D ~IRQ_INPROGRESS;
>+
>+	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
>+		desc->chip->unmask(irq);
>+unlock:
>+	raw_spin_unlock(&desc->lock);
>+}
>+static void ppc4xx_compose_msi_msg(struct pci_dev *pdev, int hwirq,
>+					struct msi_msg *msg)
>+{
>+	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
>+
>+	msg->address_lo =3D msi_data->msi_addr_lo;
>+	msg->address_hi =3D msi_data->msi_addr_hi;
>+	msg->data =3D hwirq;
>+}
>+
>+
>+int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>+{
>+	struct msi_desc *entry;
>+	int rc, hwirq;
>+	unsigned int virq;
>+	struct msi_msg msg;
>+	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
>+
>+
>+	list_for_each_entry(entry, &dev->msi_list, list) {
>+		hwirq =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
>+		if (hwirq < 0) {
>+			rc =3D hwirq;
>+			dev_err(&dev->dev, "%s: fail allocating msi\
>+					interrupt\n",	__func__);
>+			goto out_free;
>+		}
>+
>+		pr_debug(KERN_INFO"mis is %p\n", msi_data->irqhost);
>+		virq =3D irq_create_mapping(msi_data->irqhost, hwirq);
>+		if (virq =3D=3D NO_IRQ) {
>+			dev_err(&dev->dev, "%s: fail mapping irq\n",
__func__);
>+			rc =3D -ENOSPC;
>+			goto out_free;
>+		}
>+
>+		set_irq_msi(virq, entry);
>+		ppc4xx_compose_msi_msg(dev, hwirq, &msg);
>+		write_msi_msg(virq, &msg);
>+	}
>+
>+	return 0;
>+out_free:
>+	return rc;
>+}
>+
>+void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
>+{
>+	struct msi_desc *entry;
>+	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;
>+	 dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
>+
>+	list_for_each_entry(entry, &dev->msi_list, list) {
>+		if (entry->irq =3D=3D NO_IRQ)
>+			continue;
>+		set_irq_msi(entry->irq, NULL);
>+		msi_bitmap_free_hwirqs(&msi_data->bitmap,
>+				       virq_to_hw(entry->irq), 1);
>+		irq_dispose_mapping(entry->irq);
>+
>+	}
>+
>+	return;
>+}
>+
>+static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec, int
type)
>+{
>+	pr_debug(KERN_INFO"PCIE-MSI:%s called. vec %x type %d\n",
>+					__func__, nvec, type);
>+	return 0;
>+}
>+
>+/*
>+ * We do not need this actually. The MSIR register has been read once
>+ * in the cascade interrupt. So, this MSI interrupt has been acked
>+*/
>+static void ppc4xx_msi_end_irq(unsigned int virq)
>+{
>+}
>+
>+
>+static struct irq_chip ppc4xx_msi_chip =3D {
>+	.mask           =3D mask_msi_irq,
>+	.unmask         =3D unmask_msi_irq,
>+	.ack            =3D ppc4xx_msi_end_irq,
>+	.name       =3D " UIC",
>+};
>+
>+static int ppc4xx_msi_host_map(struct irq_host *h, unsigned int virq,
>+				irq_hw_number_t hw)
>+{
>+	struct irq_chip *chip =3D &ppc4xx_msi_chip;
>+
>+	irq_to_desc(virq)->status |=3D IRQ_TYPE_EDGE_RISING;
>+
>+	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
>+
>+	return 0;
>+}
>+
>+static struct irq_host_ops ppc4xx_msi_host_ops =3D {
>+	.map =3D ppc4xx_msi_host_map,
>+};
>+
>+
>+static int __devinit ppc4xx_msi_probe(struct of_device *dev,
>+					const struct of_device_id
*match)
>+{
>+	struct ppc4xx_msi *msi;
>+	struct resource res, rmsi;
>+	int i, count;
>+	int rc;
>+	int virt_msir;
>+	const u32 *p;
>+	u32 *msi_virt =3D NULL;
>+	dma_addr_t msi_phys;
>+
>+
>+	msi =3D kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
>+	if (!msi) {
>+		dev_err(&dev->dev, "No memory for MSI structure\n");
>+		rc =3D -ENOMEM;
>+		goto error_out;
>+	}
>+
>+	msi->irqhost =3D irq_alloc_host(dev->node, IRQ_HOST_MAP_LINEAR,
>+				      NR_MSI_IRQS, &ppc4xx_msi_host_ops,
0);
>+	if (msi->irqhost =3D=3D NULL) {
>+		dev_err(&dev->dev, "No memory for MSI irqhost\n");
>+		rc =3D -ENOMEM;
>+		goto error_out;
>+	}
>+
>+
>+	/* Get MSI ranges */
>+	rc =3D of_address_to_resource(dev->node, 0, &rmsi);
>+	if (rc) {
>+		dev_err(&dev->dev, "%s resource error!\n",
>+				dev->node->full_name);
>+		goto error_out;
>+	}
>+
>+
>+	/* Get the MSI reg base */
>+	rc =3D of_address_to_resource(dev->node, 1, &res);
>+	if (rc) {
>+		dev_err(&dev->dev, "%s resource error!\n",
>+				dev->node->full_name);
>+		goto error_out;
>+	}
>+#if  defined(CONFIG_460SX)
>+	mtdcri(SDR0, SDR0_PCIEH_H, PCIE_MSI_REG_BASE_H);
>+	mtdcri(SDR0, SDR0_PCIEH_L, PCIE_MSI_REG_BASE_L);
>+	msi->msi_regs =3D ioremap(((u64)PCIE_MSI_REG_BASE_H << 32) |
res.start,
>+			res.end - res.start + 1);

You defined sdr-base in the device tree.  Please use it instead of the
hard
coding.

>+#else
>+	dev_err(&dev->dev, " Invalid Device \n");
>+	goto error_out;
>+#endif
>+	if (!msi->msi_regs) {
>+		dev_err(&dev->dev, "ioremap problem failed\n");
>+		goto error_out;
>+	}
>+	/* MSI region always mapped in 4GB region*/
>+	msi->msi_addr_hi =3D 0x0;
>+	msi_virt =3D dma_alloc_coherent(&dev->dev, 64, &msi_phys,
>+			GFP_KERNEL);
>+	if (msi_virt =3D=3D NULL) {
>+		dev_err(&dev->dev, "No memory for MSI mem space\n");
>+		rc =3D -ENOMEM;
>+		goto error_out;
>+	}
>+	msi->msi_addr_lo =3D (u32)msi_phys;
>+
>+	/* Progam the Interrupt handler Termination addr registers */
>+	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
>+	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
>+
>+	/* Program MSI Expected data and Mask bits */
>+	out_be32(msi->msi_regs + PEIH_MSIED, MSI_DATA_PATTERN);
>+	out_be32(msi->msi_regs + PEIH_MSIMK, MSI_DATA_PATTERN);
>+
>+	msi->irqhost->host_data =3D msi;
>+
>+	if (ppc4xx_msi_init_allocator(msi)) {
>+		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
>+		goto error_out;
>+	}
>+
>+	p =3D of_get_property(dev->node, "interrupts", &count);
>+	if (!p) {
>+		dev_err(&dev->dev, "no interrupts property found on
%s\n",
>+				dev->node->full_name);
>+		rc =3D -ENODEV;
>+		goto error_out;
>+	}
>+	if (count =3D=3D 0) {
>+		dev_err(&dev->dev, "Malformed interrupts property on
%s\n",
>+				dev->node->full_name);
>+		rc =3D -EINVAL;
>+		goto error_out;
>+	}
>+
>+	for (i =3D 0; i < NR_MSI_IRQS; i++) {
>+		virt_msir =3D irq_of_parse_and_map(dev->node, i);
>+		if (virt_msir !=3D NO_IRQ) {
>+			set_irq_data(virt_msir, (void *)i);
>+			set_irq_chained_handler(virt_msir,
ppc4xx_msi_cascade);
>+		}
>+	}
>+
>+	ppc4xx_msi =3D msi;
>+
>+	WARN_ON(ppc_md.setup_msi_irqs);
>+	ppc_md.setup_msi_irqs =3D ppc4xx_setup_msi_irqs;
>+	ppc_md.teardown_msi_irqs =3D ppc4xx_teardown_msi_irqs;
>+	ppc_md.msi_check_device =3D ppc4xx_msi_check_device;
>+	return 0;
>+error_out:
>+	if (msi_virt)
>+		dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
>+	kfree(msi);
>+	return rc;
>+}
>+
>+static const struct ppc4xx_msi_feature ppc4xx_msi_feature =3D {
>+	.ppc4xx_pic_ip =3D 0,
>+	.msiir_offset =3D 0x140,
>+};
>+
>+static const struct of_device_id ppc4xx_msi_ids[] =3D {
>+	{
>+		.compatible =3D "amcc,ppc4xx-msi",
>+		.data =3D (void *)&ppc4xx_msi_feature,
>+	},
>+	{}
>+};
>+
>+static struct of_platform_driver ppc4xx_msi_driver =3D {
>+	.name =3D "ppc4xx-msi",
>+	.match_table =3D ppc4xx_msi_ids,
>+	.probe =3D ppc4xx_msi_probe,
>+};
>+
>+static __init int ppc4xx_msi_init(void)
>+{
>+	return of_register_platform_driver(&ppc4xx_msi_driver);
>+}
>+
>+subsys_initcall(ppc4xx_msi_init);
>diff --git a/arch/powerpc/sysdev/ppc4xx_msi.h
b/arch/powerpc/sysdev/ppc4xx_msi.h
>new file mode 100644
>index 0000000..7b8ac5c
>--- /dev/null
>+++ b/arch/powerpc/sysdev/ppc4xx_msi.h
>@@ -0,0 +1,49 @@
>+/*
>+ * Copyright (C) 2009 Applied Micro Circuits Corporation,
>+ * All rights reserved.

Same comment as above.

>+ *
>+ * Author: T	irumala Marri <tmarri@amcc.com>
>+ * 		Feng Kan <fkan@amcc.com>
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * as published by the Free Software Foundation; version 2 of the
>+ * License.
>+ */
>+#ifndef __PPC4XX_MSI_H__
>+#define __PPC4XX_MSI_H__
>+
>+#include <asm/msi_bitmap.h>
>+
>+#define PEIH_TERMADH    0x00
>+#define PEIH_TERMADL    0x08
>+#define PEIH_MSIED      0x10
>+#define PEIH_MSIMK      0x18
>+#define PEIH_MSIASS     0x20
>+#define PEIH_FLUSH0     0x30
>+#define PEIH_FLUSH1     0x38
>+#define PEIH_CNTRST     0x48
>+
>+#define MSI_DATA_PATTERN   0x44440000
>+
>+#if defined(CONFIG_405Ex)
>+#define SDR0_PCIEH	0x4B1
>+#define PCIE_MSI_REG_BASE	0xef620000
>+#elif defined(CONFIG_440SPe) || defined(CONFIG_460SX)
>+#define SDR0_PCIEH_H	0x3B0
>+#define SDR0_PCIEH_L	0x3B1
>+#define PCIE_MSI_REG_BASE_L 0x00300000
>+#define PCIE_MSI_REG_BASE_H 0x00000004
>+#endif

sdr-base covers quite a bit of this.

>+
>+struct ppc4xx_msi {
>+	struct irq_host *irqhost;
>+	unsigned long cascade_irq;
>+	u32 msi_addr_lo;
>+	u32 msi_addr_hi;
>+	void __iomem *msi_regs;
>+	u32 feature;
>+	struct msi_bitmap bitmap;
>+};

Perhaps add an sdr_base member to this struct, similar to
how the pci port structure looks.

josh
