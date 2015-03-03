Return-Path: <Bharat.Bhushan@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17F791A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 16:43:31 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 11943140146
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2015 16:43:29 +1100 (AEDT)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 1/4 RFC] fsl/msi: have msiir register address absolute rather
 than offset
Date: Tue, 3 Mar 2015 10:47:43 +0530
Message-ID: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Having absolute address simplifies the code and also removes the
confusion around feature->msiir_offset and msi_data->msiir_offset.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 9 +++------
 arch/powerpc/sysdev/fsl_msi.h | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 4bbb4b8..ec3161b 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -157,7 +157,7 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 	if (reg && (len == sizeof(u64)))
 		address = be64_to_cpup(reg);
 	else
-		address = fsl_pci_immrbar_base(hose) + msi_data->msiir_offset;
+		address = msi_data->msiir;
 
 	msg->address_lo = lower_32_bits(address);
 	msg->address_hi = upper_32_bits(address);
@@ -430,18 +430,15 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 				dev->dev.of_node->full_name);
 			goto error_out;
 		}
-		msi->msiir_offset =
-			features->msiir_offset + (res.start & 0xfffff);
 
 		/*
 		 * First read the MSIIR/MSIIR1 offset from dts
 		 * On failure use the hardcode MSIIR offset
 		 */
 		if (of_address_to_resource(dev->dev.of_node, 1, &msiir))
-			msi->msiir_offset = features->msiir_offset +
-					    (res.start & MSIIR_OFFSET_MASK);
+			msi->msiir = res.start + features->msiir_offset;
 		else
-			msi->msiir_offset = msiir.start & MSIIR_OFFSET_MASK;
+			msi->msiir = msiir.start;
 	}
 
 	msi->feature = features->fsl_pic_ip;
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 420cfcb..9b0ab84 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -34,7 +34,7 @@ struct fsl_msi {
 
 	unsigned long cascade_irq;
 
-	u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
+	phys_addr_t msiir; /* MSIIR Address in CCSR */
 	u32 ibs_shift; /* Shift of interrupt bit select */
 	u32 srs_shift; /* Shift of the shared interrupt register select */
 	void __iomem *msi_regs;
-- 
1.9.3
