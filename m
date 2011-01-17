Return-Path: <B33228@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1BCDB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 18:09:03 +1100 (EST)
From: Xulei <B33228@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] ATA: Add FSL sata v2 controller support
Date: Mon, 17 Jan 2011 15:10:59 +0800
Message-ID: <1295248259-14752-1-git-send-email-B33228@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-ide@vger.kernel.org, kumar.gala@freescale.com, jgarzik@pobox.com,
	Xulei <B33228@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In FSL sata v2 block, the snoop bit of PRDT Word3 description
information is at bit28 instead of bit22.

This patch adds FSL sata v2 probe and resolve this difference.

Signed-off-by: Xulei <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
 drivers/ata/sata_fsl.c            |   24 ++++++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 2bbecbb..9ad41dd 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -475,14 +475,14 @@
 		};
 
 		sata@18000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x18000 0x1000>;
 			cell-index = <1>;
 			interrupts = <74 0x2>;
 		};
 
 		sata@19000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x19000 0x1000>;
 			cell-index = <2>;
 			interrupts = <41 0x2>;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b0214d0..a56399a 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -6,7 +6,7 @@
  * Author: Ashish Kalra <ashish.kalra@freescale.com>
  * Li Yang <leoli@freescale.com>
  *
- * Copyright (c) 2006-2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2006-2007, 2011 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -158,7 +158,8 @@ enum {
 	    IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
 
 	EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
-	DATA_SNOOP_ENABLE = (1 << 22),
+	DATA_SNOOP_ENABLE_V1 = (1 << 22),
+	DATA_SNOOP_ENABLE_V2 = (1 << 28),
 };
 
 /*
@@ -256,6 +257,7 @@ struct sata_fsl_host_priv {
 	void __iomem *ssr_base;
 	void __iomem *csr_base;
 	int irq;
+	int data_snoop;
 };
 
 static inline unsigned int sata_fsl_tag(unsigned int tag,
@@ -308,7 +310,8 @@ static void sata_fsl_setup_cmd_hdr_entry(struct sata_fsl_port_priv *pp,
 }
 
 static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
-				     u32 *ttl, dma_addr_t cmd_desc_paddr)
+				     u32 *ttl, dma_addr_t cmd_desc_paddr,
+				     int data_snoop)
 {
 	struct scatterlist *sg;
 	unsigned int num_prde = 0;
@@ -359,7 +362,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 		ttl_dwords += sg_len;
 		prd->dba = cpu_to_le32(sg_addr);
 		prd->ddc_and_ext =
-		    cpu_to_le32(DATA_SNOOP_ENABLE | (sg_len & ~0x03));
+			cpu_to_le32(data_snoop | (sg_len & ~0x03));
 
 		VPRINTK("sg_fill, ttl=%d, dba=0x%x, ddc=0x%x\n",
 			ttl_dwords, prd->dba, prd->ddc_and_ext);
@@ -374,7 +377,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 		/* set indirect extension flag along with indirect ext. size */
 		prd_ptr_to_indirect_ext->ddc_and_ext =
 		    cpu_to_le32((EXT_INDIRECT_SEG_PRD_FLAG |
-				 DATA_SNOOP_ENABLE |
+				 data_snoop |
 				 (indirect_ext_segment_sz & ~0x03)));
 	}
 
@@ -417,7 +420,8 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		num_prde = sata_fsl_fill_sg(qc, (void *)cd,
-					    &ttl_dwords, cd_paddr);
+					    &ttl_dwords, cd_paddr,
+					    host_priv->data_snoop);
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		desc_info |= FPDMA_QUEUED_CMD;
@@ -1336,6 +1340,11 @@ static int sata_fsl_probe(struct platform_device *ofdev,
 	}
 	host_priv->irq = irq;
 
+	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,pq-sata-v2"))
+		host_priv->data_snoop = DATA_SNOOP_ENABLE_V2;
+	else
+		host_priv->data_snoop = DATA_SNOOP_ENABLE_V1;
+
 	/* allocate host structure */
 	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_FSL_MAX_PORTS);
 
@@ -1418,6 +1427,9 @@ static struct of_device_id fsl_sata_match[] = {
 	{
 		.compatible = "fsl,pq-sata",
 	},
+	{
+		.compatible = "fsl,pq-sata-v2",
+	},
 	{},
 };
 
-- 
1.7.0.4
