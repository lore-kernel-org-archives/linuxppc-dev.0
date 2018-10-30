Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB9C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:44:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D7B2075D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D7B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kbQD2NWSzF1C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 13:44:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com; envelope-from=peng.ma@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kbKx1tmzzDrS3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 13:40:20 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AAF521A0134;
 Tue, 30 Oct 2018 03:40:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 059F51A0016;
 Tue, 30 Oct 2018 03:40:11 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B569B40302;
 Tue, 30 Oct 2018 10:40:02 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: vkoul@kernel.org
Subject: [v11 2/7] dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement
 for ARM platform
Date: Tue, 30 Oct 2018 10:35:59 +0800
Message-Id: <20181030023604.34027-2-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181030023604.34027-1-peng.ma@nxp.com>
References: <20181030023604.34027-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, zw@zh-kernel.org,
 robh+dt@kernel.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch add the macro FSL_DMA_IN/OUT implement for ARM platform.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
change in v11:
	- no

 drivers/dma/fsldma.h |   61 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 982845b..88db939 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -196,39 +196,62 @@ struct fsldma_chan {
 #define to_fsl_desc(lh) container_of(lh, struct fsl_desc_sw, node)
 #define tx_to_fsl_desc(tx) container_of(tx, struct fsl_desc_sw, async_tx)
 
+#ifdef	CONFIG_PPC
+#define fsl_ioread32(p)		in_le32(p)
+#define fsl_ioread32be(p)	in_be32(p)
+#define fsl_iowrite32(v, p)	out_le32(p, v)
+#define fsl_iowrite32be(v, p)	out_be32(p, v)
+
 #ifndef __powerpc64__
-static u64 in_be64(const u64 __iomem *addr)
+static u64 fsl_ioread64(const u64 __iomem *addr)
 {
-	return ((u64)in_be32((u32 __iomem *)addr) << 32) |
-		(in_be32((u32 __iomem *)addr + 1));
+	u32 fsl_addr = lower_32_bits(addr);
+	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
+
+	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
 }
 
-static void out_be64(u64 __iomem *addr, u64 val)
+static void fsl_iowrite64(u64 val, u64 __iomem *addr)
 {
-	out_be32((u32 __iomem *)addr, val >> 32);
-	out_be32((u32 __iomem *)addr + 1, (u32)val);
+	out_le32((u32 __iomem *)addr + 1, val >> 32);
+	out_le32((u32 __iomem *)addr, (u32)val);
 }
 
-/* There is no asm instructions for 64 bits reverse loads and stores */
-static u64 in_le64(const u64 __iomem *addr)
+static u64 fsl_ioread64be(const u64 __iomem *addr)
 {
-	return ((u64)in_le32((u32 __iomem *)addr + 1) << 32) |
-		(in_le32((u32 __iomem *)addr));
+	u32 fsl_addr = lower_32_bits(addr);
+	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
+
+	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
 }
 
-static void out_le64(u64 __iomem *addr, u64 val)
+static void fsl_iowrite64be(u64 val, u64 __iomem *addr)
 {
-	out_le32((u32 __iomem *)addr + 1, val >> 32);
-	out_le32((u32 __iomem *)addr, (u32)val);
+	out_be32((u32 __iomem *)addr, val >> 32);
+	out_be32((u32 __iomem *)addr + 1, (u32)val);
 }
 #endif
+#endif
 
-#define FSL_DMA_IN(fsl_chan, addr, width)				\
-		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-			in_be##width(addr) : in_le##width(addr))
-#define FSL_DMA_OUT(fsl_chan, addr, val, width)			\
-		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-			out_be##width(addr, val) : out_le##width(addr, val))
+#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
+#define fsl_ioread32(p)		ioread32(p)
+#define fsl_ioread32be(p)	ioread32be(p)
+#define fsl_iowrite32(v, p)	iowrite32(v, p)
+#define fsl_iowrite32be(v, p)	iowrite32be(v, p)
+#define fsl_ioread64(p)		ioread64(p)
+#define fsl_ioread64be(p)	ioread64be(p)
+#define fsl_iowrite64(v, p)	iowrite64(v, p)
+#define fsl_iowrite64be(v, p)	iowrite64be(v, p)
+#endif
+
+#define FSL_DMA_IN(fsl_dma, addr, width)			\
+		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
+			fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
+
+#define FSL_DMA_OUT(fsl_dma, addr, val, width)			\
+		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
+			fsl_iowrite##width##be(val, addr) : fsl_iowrite	\
+		##width(val, addr))
 
 #define DMA_TO_CPU(fsl_chan, d, width)					\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-- 
1.7.1

