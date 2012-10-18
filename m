Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 130332C0093
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 04:45:13 +1100 (EST)
Received: by mail-bk0-f42.google.com with SMTP id j5so3686867bkw.15
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 10:45:10 -0700 (PDT)
Message-ID: <50804020.30505@gmail.com>
Date: Thu, 18 Oct 2012 20:45:04 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
In-Reply-To: <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
Content-Type: multipart/mixed; boundary="------------090908010907050900020301"
Cc: mla@apm.com, Robert Berger <robert.karl.berger@gmail.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090908010907050900020301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

FYI:

When I replace arch/powerpc/sysdev/ppc4xx_msi.c from a 3.6 kernel with a
ppc4xx_msi.c from 47da421981571c69ef29740cc55fa7248682e167 it boots from
nfs with a defconfig, so this seems to be the guilty one.

Please find attached the difference between the good and bad
ppc4xx_msi.c files.

I'll be happy to test your patches;)

Regards,

Robert

--------------090908010907050900020301
Content-Type: text/plain; charset=UTF-8;
 name="diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="diff.txt"

diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 82c6702..1c2d7af 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -28,11 +28,10 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
-#include <asm/dcr.h>
+#include <boot/dcr.h>
 #include <asm/dcr-regs.h>
 #include <asm/msi_bitmap.h>
 
@@ -44,14 +43,13 @@
 #define PEIH_FLUSH0	0x30
 #define PEIH_FLUSH1	0x38
 #define PEIH_CNTRST	0x48
-
-static int msi_irqs;
+#define NR_MSI_IRQS	4
 
 struct ppc4xx_msi {
 	u32 msi_addr_lo;
 	u32 msi_addr_hi;
 	void __iomem *msi_regs;
-	int *msi_virqs;
+	int msi_virqs[NR_MSI_IRQS];
 	struct msi_bitmap bitmap;
 	struct device_node *msi_dev;
 };
@@ -63,7 +61,7 @@ static int ppc4xx_msi_init_allocator(struct platform_device *dev,
 {
 	int err;
 
-	err = msi_bitmap_alloc(&msi_data->bitmap, msi_irqs,
+	err = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
 			      dev->dev.of_node);
 	if (err)
 		return err;
@@ -85,11 +83,6 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	struct msi_desc *entry;
 	struct ppc4xx_msi *msi_data = &ppc4xx_msi;
 
-	msi_data->msi_virqs = kmalloc((msi_irqs) * sizeof(int),
-					    GFP_KERNEL);
-	if (!msi_data->msi_virqs)
-		return -ENOMEM;
-
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		if (int_no >= 0)
@@ -157,11 +150,12 @@ static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
 	if (!sdr_addr)
 		return -1;
 
-	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
-	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */
+	SDR0_WRITE(sdr_addr, (u64)res.start >> 32);	 /*HIGH addr */
+	SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
+
 
 	msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
-	if (!msi->msi_dev)
+	if (msi->msi_dev)
 		return -ENODEV;
 
 	msi->msi_regs = of_iomap(msi->msi_dev, 0);
@@ -173,12 +167,9 @@ static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
 		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
 
 	msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
-	if (!msi_virt)
-		return -ENOMEM;
-	msi->msi_addr_hi = upper_32_bits(msi_phys);
-	msi->msi_addr_lo = lower_32_bits(msi_phys & 0xffffffff);
-	dev_dbg(&dev->dev, "PCIE-MSI: msi address high 0x%x, low 0x%x\n",
-		msi->msi_addr_hi, msi->msi_addr_lo);
+	msi->msi_addr_hi = 0x0;
+	msi->msi_addr_lo = (u32) msi_phys;
+	dev_dbg(&dev->dev, "PCIE-MSI: msi address 0x%x\n", msi->msi_addr_lo);
 
 	/* Progam the Interrupt handler Termination addr registers */
 	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
@@ -194,8 +185,6 @@ static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
 	out_be32(msi->msi_regs + PEIH_MSIED, *msi_data);
 	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
 
-	dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
-
 	return 0;
 }
 
@@ -205,7 +194,7 @@ static int ppc4xx_of_msi_remove(struct platform_device *dev)
 	int i;
 	int virq;
 
-	for (i = 0; i < msi_irqs; i++) {
+	for (i = 0; i < NR_MSI_IRQS; i++) {
 		virq = msi->msi_virqs[i];
 		if (virq != NO_IRQ)
 			irq_dispose_mapping(virq);
@@ -226,6 +215,8 @@ static int __devinit ppc4xx_msi_probe(struct platform_device *dev)
 	struct resource res;
 	int err = 0;
 
+	msi = &ppc4xx_msi;/*keep the msi data for further use*/
+
 	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
 
 	msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
@@ -243,10 +234,6 @@ static int __devinit ppc4xx_msi_probe(struct platform_device *dev)
 		goto error_out;
 	}
 
-	msi_irqs = of_irq_count(dev->dev.of_node);
-	if (!msi_irqs)
-		return -ENODEV;
-
 	if (ppc4xx_setup_pcieh_hw(dev, res, msi))
 		goto error_out;
 
@@ -255,7 +242,6 @@ static int __devinit ppc4xx_msi_probe(struct platform_device *dev)
 		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
 		goto error_out;
 	}
-	ppc4xx_msi = *msi;
 
 	ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
 	ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;

--------------090908010907050900020301--
