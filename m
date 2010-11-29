Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0ADAC1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Nov 2010 05:36:27 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oATIOJ58011729
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Nov 2010 11:24:19 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oATIaM2S178428
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Nov 2010 11:36:22 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oATIeWo4024843
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Nov 2010 11:40:32 -0700
Date: Mon, 29 Nov 2010 13:35:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: tmarri@apm.com
Subject: Re: [PATCH v2] PPC4xx: Adding PCI(E) MSI support
Message-ID: <20101129183535.GA5603@zod.rchland.ibm.com>
References: <1289852106-17577-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289852106-17577-1-git-send-email-tmarri@apm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 12:15:06PM -0800, tmarri@apm.com wrote:
>From: Tirumala Marri <tmarri@apm.com>
>
>This patch adds MSI support for 440SPe, 460Ex, 460Sx and 405Ex.
>

My apologies in the delay here.  I was on holiday for a while and never
got back to review this.  A few notes below.

Also, I've added a few patches from Victor for suspend/idle support in
my next branch that cause a minor conflict with this one.  It's not a
big deal to fix, but if you rework the patch for the comments, rebasing
it to my next branch would be appreciated.

>diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
>new file mode 100644
>index 0000000..9ed559f
>--- /dev/null
>+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
>@@ -0,0 +1,311 @@
>+/*
>+ * Adding PCI-E MSI support for PPC4XX SoCs.
>+ *
>+ * Copyright (c) 2010, Applied Micro Circuits Corporation
>+ * Authors: 	Tirumala R Marri <tmarri@apm.com>
>+ * 		Feng Kan <fkan@apm.com>
>+ *
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License as
>+ * published by the Free Software Foundation; either version 2 of
>+ * the License, or (at your option) any later version.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>+ * MA 02111-1307 USA
>+ */
>+
>+#include <linux/irq.h>
>+#include <linux/bootmem.h>
>+#include <linux/pci.h>
>+#include <linux/msi.h>
>+#include <linux/of_platform.h>
>+#include <linux/interrupt.h>
>+#include <asm/prom.h>
>+#include <asm/hw_irq.h>
>+#include <asm/ppc-pci.h>
>+#include <boot/dcr.h>

This still seems weird to include.  Perhaps you should duplicate the
macros you need into asm/dcr-regs.h or something.

>+#include <asm/dcr-regs.h>
>+#include <asm/msi_bitmap.h>
>+
>+#define PEIH_TERMADH	0x00
>+#define PEIH_TERMADL	0x08
>+#define PEIH_MSIED	0x10
>+#define PEIH_MSIMK	0x18
>+#define PEIH_MSIASS	0x20
>+#define PEIH_FLUSH0	0x30
>+#define PEIH_FLUSH1	0x38
>+#define PEIH_CNTRST	0x48
>+#define NR_MSI_IRQS	4
>+
>+LIST_HEAD(msi_head);
>+struct ppc4xx_msi {
>+	u32 msi_addr_lo;
>+	u32 msi_addr_hi;
>+	void __iomem *msi_regs;
>+	int msi_virqs[NR_MSI_IRQS];
>+	struct msi_bitmap bitmap;
>+	struct list_head list;
>+};
>+
>+struct ppc4xx_msi_feature {
>+	u32 ppc4xx_pic_ip;
>+	u32 msiir_offset;
>+};
>+
>+static int ppc4xx_msi_init_allocator(struct platform_device *dev,
>+		struct ppc4xx_msi *msi_data)
>+{
>+	int err;
>+
>+	err = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
>+			      dev->dev.of_node);
>+	if (err)
>+		return err;
>+
>+	err = msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
>+	if (err < 0) {
>+		msi_bitmap_free(&msi_data->bitmap);
>+		return err;
>+	}
>+
>+	return 0;
>+}
>+
>+static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>+{
>+	int err = 0;
>+	int int_no = -ENOMEM;
>+	unsigned int virq;
>+	struct msi_msg msg;
>+	struct msi_desc *entry;
>+	struct device_node *msi_dev = NULL;
>+	struct ppc4xx_msi *msi_data = dev->dev.platform_data;
>+
>+	msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
>+	if (msi_dev) {
>+		err = -ENODEV;
>+		goto out_free;
>+	}
>+
>+	list_for_each_entry(entry, &dev->msi_list, list) {
>+		list_for_each_entry(msi_data, &msi_head, list) {
>+			int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
>+			if(int_no >= 0)
>+				break;
>+		}
>+		if(int_no < 0) {
>+
>+			err = int_no;
>+			pr_debug("%s: fail allocating msi interrupt\n",
>+					__func__);
>+		}
>+		virq = irq_of_parse_and_map(msi_dev, int_no);
>+		if (virq == NO_IRQ) {
>+			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
>+			msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
>+			err = -ENOSPC;
>+			goto out_free;
>+		}
>+		msi_data->msi_virqs[int_no] = virq;
>+		set_irq_data(virq, (void *)int_no);
>+		dev_dbg(&dev->dev, "%s: virq = %d \n", __func__, virq);
>+
>+		/* Setup msi address space */
>+		msg.address_hi = msi_data->msi_addr_hi;
>+		msg.address_lo = msi_data->msi_addr_lo;
>+
>+		set_irq_msi(virq, entry);
>+		msg.data = int_no;
>+		write_msi_msg(virq, &msg);
>+	}
>+	of_node_put(msi_dev);
>+	return err;
>+
>+out_free:
>+	of_node_put(msi_dev);
>+	return err;

You can move the label up and get rid of the duplicate of_node_put and
return calls.

>+}
>+
>+void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
>+{
>+	struct msi_desc *entry;
>+	struct ppc4xx_msi *msi_data = dev->dev.platform_data;
>+
>+	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
>+
>+	list_for_each_entry(entry, &dev->msi_list, list) {
>+		if (entry->irq == NO_IRQ)
>+			continue;
>+		set_irq_msi(entry->irq, NULL);
>+		msi_bitmap_free_hwirqs(&msi_data->bitmap,
>+				virq_to_hw(entry->irq), 1);
>+		irq_dispose_mapping(entry->irq);
>+	}
>+
>+	return;
>+}
>+
>+static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec, int type)
>+{
>+	dev_dbg(&pdev->dev, "PCIE-MSI:%s called. vec %x type %d\n",
>+		__func__, nvec, type);
>+	if (type == PCI_CAP_ID_MSIX)
>+		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");

fslmsi?

>+
>+	return 0;
>+}
>+
>+static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
>+				 struct resource res, struct ppc4xx_msi *msi)
>+{
>+	const u32 *msi_data;
>+	const u32 *msi_mask;
>+	const u32 *sdr_addr;
>+	int err = 0;
>+	dma_addr_t msi_phys;
>+	void *msi_virt;
>+	struct device_node *msi_dev = NULL;
>+
>+	sdr_addr = of_get_property(dev->dev.of_node, "sdr-base", NULL);
>+	if (!sdr_addr)
>+		return -1;
>+
>+	SDR0_WRITE(sdr_addr, (u64)res.start >> 32);	 /*HIGH addr */
>+	SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
>+
>+
>+	msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
>+	if (msi_dev) {
>+		err = -ENODEV;
>+		goto error_out;
>+	}
>+	msi->msi_regs = of_iomap(msi_dev, 0);
>+	if (!msi->msi_regs) {
>+		dev_err(&dev->dev, "ioremap problem failed\n");

Should probably read "of_iomap failed".

>+		return -ENOMEM;
>+	}
>+	of_node_put(msi_dev);
>+	dev_dbg(&dev->dev, "PCIE-MSI: msi register mapped 0x%x 0x%x\n",
>+		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
>+
>+	msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);

This can fail, can't it?  Also, where is this actually used?

>+	msi->msi_addr_hi = 0x0;
>+	msi->msi_addr_lo = (u32) msi_phys;
>+	dev_dbg(&dev->dev, "PCIE-MSI: msi address 0x%x \n", msi->msi_addr_lo);
>+
>+	/* Progam the Interrupt handler Termination addr registers */
>+	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
>+	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
>+
>+	msi_data = of_get_property(dev->dev.of_node, "msi-data", NULL);
>+	if (!msi_data) {
>+		err = -1;
>+		goto error_out;
>+	}
>+
>+	msi_mask = of_get_property(dev->dev.of_node, "msi-mask", NULL);
>+	if (!msi_mask) {
>+		err = -1;
>+		goto error_out;
>+	}

I don't see where dma_free_coherent is called to cleanup if either of
those fail.

>+
>+	/* Program MSI Expected data and Mask bits */
>+	out_be32(msi->msi_regs + PEIH_MSIED, *msi_data);
>+	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
>+
>+	return err;
>+error_out:
>+	return err;

You can just move the label up 2 lines and get rid of one of these
return statements.

>+}
>+
>+static int ppc4xx_of_msi_remove(struct platform_device *dev)
>+{
>+	struct ppc4xx_msi *msi = dev->dev.platform_data;
>+	int i;
>+	int virq;
>+
>+	for(i = 0; i < NR_MSI_IRQS; i++) {
>+		virq = msi->msi_virqs[i];
>+		if (virq != NO_IRQ)
>+			irq_dispose_mapping(virq);
>+	}
>+
>+	if (msi->list.prev != NULL)
>+		list_del(&msi->list);
>+
>+	if (msi->bitmap.bitmap)
>+		msi_bitmap_free(&msi->bitmap);
>+	iounmap(msi->msi_regs);
>+	kfree(msi);
>+
>+	return 0;
>+}
>+
>+static int __devinit ppc4xx_msi_probe(struct platform_device *dev,
>+				      const struct of_device_id *match)
>+{
>+	struct ppc4xx_msi *msi;
>+	struct resource res;
>+	int err = 0;
>+
>+	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
>+
>+	msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
>+	if (!msi) {
>+		dev_err(&dev->dev, "No memory for MSI structure\n");
>+		err = -ENOMEM;
>+		goto error_out;
>+	}
>+	dev->dev.platform_data = msi;
>+
>+	/* Get MSI ranges */
>+	err = of_address_to_resource(dev->dev.of_node, 0, &res);
>+	if (err) {
>+		dev_err(&dev->dev, "%s resource error!\n",
>+			dev->dev.of_node->full_name);
>+		goto error_out;
>+	}
>+
>+	if (ppc4xx_setup_pcieh_hw(dev, res, msi))
>+		goto error_out;
>+
>+	err = ppc4xx_msi_init_allocator(dev, msi);
>+	if (err) {
>+		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
>+		goto error_out;
>+	}
>+
>+	list_add_tail(&msi->list, &msi_head);
>+
>+	ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
>+	ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
>+	ppc_md.msi_check_device = ppc4xx_msi_check_device;
>+	return err;
>+
>+error_out:
>+	ppc4xx_of_msi_remove(dev);
>+	return err;
>+}
>+
>+static struct of_platform_driver ppc4xx_msi_driver = {
>+	.driver = {
>+		   .name = "ppc4xx-msi",
>+		   .owner = THIS_MODULE,
>+		   },
>+	.probe = ppc4xx_msi_probe,
>+	.remove = ppc4xx_of_msi_remove,
>+};
>+
>+static __init int ppc4xx_msi_init(void)
>+{
>+	return of_register_platform_driver(&ppc4xx_msi_driver);
>+}
>+
>+subsys_initcall(ppc4xx_msi_init);
>-- 
>1.6.1.rc3
>
