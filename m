Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D585C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:36:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7DE2192C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7DE2192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MCPr2sPVzDqZ2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 15:36:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MCMc5XCWzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 15:34:52 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 (helo=home.buserror.net)
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gaYzv-0000V0-Hd; Fri, 21 Dec 2018 22:34:48 -0600
Date: Fri, 21 Dec 2018 22:34:45 -0600
From: Scott Wood <oss@buserror.net>
To: Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>
Message-ID: <20181222043445.GA29462@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: leoyang.li@nxp.com, zw@zh-kernel.org,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org, peng.ma@nxp.com,
 wen.he_1@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: dmaengine@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 Wen He <wen.he_1@nxp.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Otherwise 64-bit PPC builds fail with undefined references
to these accessors.

Cc: Peng Ma <peng.ma@nxp.com>
Cc: Wen He <wen.he_1@nxp.com>
Fixes: 68997fff94afa (" dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement for ARM platform")
Signed-off-by: Scott Wood <oss@buserror.net>
---
Is there any reason why ioreadXXbe() etc can't be used on PPC as well?

 drivers/dma/fsldma.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 88db939c04a1..a9b12f82b5c3 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -202,7 +202,12 @@ struct fsldma_chan {
 #define fsl_iowrite32(v, p)	out_le32(p, v)
 #define fsl_iowrite32be(v, p)	out_be32(p, v)
 
-#ifndef __powerpc64__
+#ifdef __powerpc64__
+#define fsl_ioread64(p)		in_le64(p)
+#define fsl_ioread64be(p)	in_be64(p)
+#define fsl_iowrite64(v, p)	out_le64(p, v)
+#define fsl_iowrite64be(v, p)	out_be64(p, v)
+#else
 static u64 fsl_ioread64(const u64 __iomem *addr)
 {
 	u32 fsl_addr = lower_32_bits(addr);
-- 
2.17.1
