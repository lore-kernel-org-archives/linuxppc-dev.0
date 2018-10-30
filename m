Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55E8C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:42:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB1B2075D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB1B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kbNL15W2zF1Hr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 13:42:26 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kbKx1tlzzDrMm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 13:40:19 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D91371A0059;
 Tue, 30 Oct 2018 03:40:15 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7052B1A0043;
 Tue, 30 Oct 2018 03:40:09 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2BC70402A4;
 Tue, 30 Oct 2018 10:40:01 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: vkoul@kernel.org
Subject: [v11 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
Date: Tue, 30 Oct 2018 10:35:58 +0800
Message-Id: <20181030023604.34027-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
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

From: Wen He <wen.he_1@nxp.com>

This patch implement a standard macro call functions is
used to NXP dma drivers.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
change in v11:
	- no

 drivers/dma/fsldma.c |   16 ++++++++--------
 drivers/dma/fsldma.h |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1117b51..39871e0 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -53,42 +53,42 @@
 
 static void set_sr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->sr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->sr, val, 32);
 }
 
 static u32 get_sr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->sr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->sr, 32);
 }
 
 static void set_mr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->mr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->mr, val, 32);
 }
 
 static u32 get_mr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->mr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->mr, 32);
 }
 
 static void set_cdar(struct fsldma_chan *chan, dma_addr_t addr)
 {
-	DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
+	FSL_DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
 }
 
 static dma_addr_t get_cdar(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
+	return FSL_DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
 }
 
 static void set_bcr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->bcr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->bcr, val, 32);
 }
 
 static u32 get_bcr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->bcr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->bcr, 32);
 }
 
 /*
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 4787d48..982845b 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -223,10 +223,10 @@ static void out_le64(u64 __iomem *addr, u64 val)
 }
 #endif
 
-#define DMA_IN(fsl_chan, addr, width)					\
+#define FSL_DMA_IN(fsl_chan, addr, width)				\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
 			in_be##width(addr) : in_le##width(addr))
-#define DMA_OUT(fsl_chan, addr, val, width)				\
+#define FSL_DMA_OUT(fsl_chan, addr, val, width)			\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
 			out_be##width(addr, val) : out_le##width(addr, val))
 
-- 
1.7.1

