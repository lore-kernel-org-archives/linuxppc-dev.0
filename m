Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E553B702E
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2011 10:28:41 +1000 (EST)
Received: from mail102-db3 (localhost.localdomain [127.0.0.1])	by
	mail102-db3-R.bigfish.com (Postfix) with ESMTP id 6ABBE5401E3	for
	<linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2011 00:28:36 +0000 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.246])	by
	mail102-db3.bigfish.com (Postfix) with ESMTP id 0E4AD17C004E	for
	<linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2011 00:28:36 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/fsl_msi: clean up and document calculation of MSIIR
	address
Date: Fri, 26 Aug 2011 19:28:32 -0500
Message-ID: <1314404912-6947-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 3da34aae (powerpc/fsl: Support unique MSI addresses per PCIe Root
Complex) redefined the meanings of msi->msi_addr_hi and msi->msi_addr_lo to be
an offset rather than an address.  To help clarify the code, we make the
following changes:

1) Get rid of msi_addr_hi, which is always zero anyway.

2) Rename msi_addr_lo to ccsr_msiir_offset, to indicate that it's an offset
   relative to the beginning of CCSR.

3) Calculate 64-bit addresses using actual 64-bit math.

4) Document some of the code and assumptions we make.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   26 ++++++++++++++++++--------
 arch/powerpc/sysdev/fsl_msi.h |    3 +--
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 419a772..d824230 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -30,7 +30,7 @@ LIST_HEAD(msi_head);
 
 struct fsl_msi_feature {
 	u32 fsl_pic_ip;
-	u32 msiir_offset;
+	u32 msiir_offset; /* offset of MSIIR, relative to start of MSI regs */
 };
 
 struct fsl_msi_cascade_data {
@@ -120,16 +120,23 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	return;
 }
 
+/*
+ * Initialize the address and data fields of an MSI message object
+ */
 static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 				struct msi_msg *msg,
-				struct fsl_msi *fsl_msi_data)
+				struct fsl_msi *msi_data)
 {
-	struct fsl_msi *msi_data = fsl_msi_data;
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	u64 base = fsl_pci_immrbar_base(hose);
 
-	msg->address_lo = msi_data->msi_addr_lo + lower_32_bits(base);
-	msg->address_hi = msi_data->msi_addr_hi + upper_32_bits(base);
+	/*
+	 * The PCI address of MSIIR is equal to the PCI base address of CCSR
+	 * plus the offset of MSIIR.
+	 */
+	u64 addr = fsl_pci_immrbar_base(hose) + msi_data->ccsr_msiir_offset;
+
+	msg->address_hi = upper_32_bits(addr);
+	msg->address_lo = lower_32_bits(addr);
 
 	msg->data = hwirq;
 
@@ -359,8 +366,11 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 
 	msi->irqhost->host_data = msi;
 
-	msi->msi_addr_hi = 0x0;
-	msi->msi_addr_lo = features->msiir_offset + (res.start & 0xfffff);
+	/*
+	 * We assume that the 'reg' property of the MSI node contains an
+	 * offset that has five (or fewer) digits, hence the 0xfffff.
+	 */
+	msi->ccsr_msiir_offset = features->msiir_offset + (res.start & 0xfffff);
 
 	rc = fsl_msi_init_allocator(msi);
 	if (rc) {
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 624580c..eb68c42 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -28,8 +28,7 @@ struct fsl_msi {
 
 	unsigned long cascade_irq;
 
-	u32 msi_addr_lo;
-	u32 msi_addr_hi;
+	u32 ccsr_msiir_offset; /* offset of MSIIR, relative to start of CCSR */
 	void __iomem *msi_regs;
 	u32 feature;
 	int msi_virqs[NR_MSI_REG];
-- 
1.7.3.4
