Return-Path: <linuxppc-dev+bounces-27632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E903BC982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:01:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm68n2WClz2ynZ;
	Fri, 18 Sep 2026 06:01:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789675305;
	cv=none; b=oq7dip5OEtJ2CZnoG62u5cpgAxYmhSjrZkG4xuOUF4jXb7o0G7uaFucEBrv93qawRNAyb0DCZKvqdhaeNPni93gGRKpKXOFhJHP9Xjzs0DQS7gtac5BlUSpKAwbgrJV1peiPVM0znjgq1E8uoMMbsJGDq+wzvPpO4V0cKoOyl8ggtcxMCWqVWV23UxYKTkcYaBzQUSBQah+RLo34FLzzcPo+AQxY1Cc373peEUPQ2ALvcg3DDkwqtjI+2FG8CxzdiWgCxclbKsdbyDXYGe33TezFppH9Q24vC1D9NOhzGODN/+J1K7lS/L0gPTsjU5pgjBFpW57OZHlfkPPY904bBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789675305; c=relaxed/relaxed;
	bh=SMbyouNW/EVz0LVN7bS1sUKezudmEDE0W2YcHDpgEIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCubVdHFCMDzvsNvfMxpIp5SMhE5+lO//osilSrvr4hkP95u3J44IcQGKuLED5nmAE+Z/UF3z48AMJqTdKSS48OTdWl28LXfjY9xoH2SgaP6WCy5BwtXz1zQcgXH28huwkOl1eiaWmVjbDQXBvCM5kgsQAKdtyZXApuz1iDx8ldqrAOI/u+H15u+lG4+53KhPkyjWeCeykkknfXmWa0d5mIR6WrCQ7TeTRni0DWht2Jtrv9qBBkRBiphHPoFM47VSCN/5TXyxtz7pCEpz0xoZmsH6kc55lihK+QOUBRy8dZo6ss5SbF+ehXtV18mxSDst8TYv6sukwgeFcSFFfesNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sTB6dOSA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sTB6dOSA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com [IPv6:2607:f8b0:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm68m2w4hz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 06:01:44 +1000 (AEST)
Received: by mail-qv2-x10.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so647816d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675301; x=1790280101; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMbyouNW/EVz0LVN7bS1sUKezudmEDE0W2YcHDpgEIY=;
        b=sTB6dOSAourbcxcayva3V0iHEyTXYND/tbJaQEAhUHr7BJSG3t885V6uLeu7llikZz
         p14FnzxHoq4fh8ylbfK99be0vMLSZTxGQ+2EbG8wiiJqNFXALRTcfQ/RM9oXie+dqj89
         xgMcejQTEJy31teWG/fqCts+OasBjhk1ChQyzGV/dbEq5WbBdi/P9jjQSZ7V9EZebusD
         D/ZlKRjKQK8p8Kdz/QEDpTbEsWFWLCI4i4c2quSqqFht1jPX8eIZGc6b24AY/J00ujlk
         U2Z7s5QW9d8Cj7yMgZl7E8V5z7qtXiaVjKKuieDZU3Gdf65ERAGiHzr3kfvjXmvPW6TR
         WFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675301; x=1790280101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMbyouNW/EVz0LVN7bS1sUKezudmEDE0W2YcHDpgEIY=;
        b=EVbwGNvmbMldrn9dnGhkjAOCrq+hTnfLjSdmVJM0wuLdxZkzpFIqbvTKZNRTe4JPdf
         58zb0yuRegeh/qNVxiK8tge6rp3X+wUEp9HOFQJyJxqxTFfi8coB3+LvJrn1+CKlkOpE
         CT1wCfj/kXKAOQrAm0LbTMQ6wASCtoSFbvmm27CHRLYrW+0JMjScnuzMFTs85Z/l0hji
         p4cW9RgAY3J1YWd1oOVSjSGR0e/Tip1cG7HAby6j6nfjt9MbwV8bLa4odUV/Fx2ATYDF
         C/CBGCUvR2/8DABMK/K4ZbppZY3mE+RzSLNMRwvf03Y5usoSQ+svlOTdnPLwSL7XARnb
         PIAg==
X-Forwarded-Encrypted: i=1; AKwUvBxTVqODey8zJgFi3c0LMLslIfpQRDl+hJUZRNPnIK5fQWc2QraYi6mzsCdBjfW9739Eox/EebuqF1FPAN4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k43r9dAuQ5pAZWPXaPX5eR42yPp0ck5cfZBjhoH+haUF3TfT9F
	0J73VR8MC/2Y7h7bugrFKzTekn8pmEOCSAgWqmktQkA19ycIG/gjA30=
X-Gm-Gg: AYBFou0xq6SssneupMv85H+Eu0wAdhicBQ6h3G3Hqx0SGazrpD51XLyC/NjTl5vxiCL
	m0x2mEusj4Z8LPa0aTPW+KIHjiGz0DzkxFqhAisp2JunwpXPXwtt6QQ2/kS8mgZq4r32Izo5d6A
	iZD/kCiEtw8pvGAY/orfQ0dkkPDZ16sPYrgYcwdkpo+bZiOwma6ChXi4lYR7i6hUXlEfDQfuGvy
	0y2ttvgeDaDdY6N/wJdu54vwZ+bs9QxNe/9HKno61Tum/WE+P4ADi6GknyQwbns4U4IIaS+W9rO
	S2WrtwjJhiR733Ycf3BGqq5YF9UzLaD3+cPL9tWsTTHjSqyZUMndqgE4/lyFplANvhYcPoUEHIJ
	RWPAorIwzll2tFg7MEsGGxNK4DcVfr+kcpPWl+Guhth5B9q8mTrbsIClb8IlIwhxCd53IEVJef1
	BfKQV8IyoQi+LlawAlLqkNpiPUKVnBvnvAVxJ16YKB43++0u9l4g/QFlJBE2Gb1agsqpgkOq7DT
	pSt+sXFiYSphdJ2mTeyTUGAXtN/J8AxBc/Z/qf0Ao2fALeZmDl+yikG47clrg+R7z6caONVQVuI
	bkGsSYhFiFFZnZzQzI1yq17+HqKlrUuUQBD2
X-Received: by 2002:ad4:5eca:0:b0:910:39e7:dbb9 with SMTP id 6a1803df08f44-91254bd01aamr5451946d6.33.1789675300564;
        Thu, 17 Sep 2026 13:01:40 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252c7a362sm5504776d6.18.2026.09.17.13.01.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 13:01:39 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] soc: fsl: dpio: Release the I/O object on IRQ registration failure
Date: Thu, 17 Sep 2026 16:01:38 -0400
Message-ID: <20260917200138.75755-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ registration happens after dpaa2_io_create(), but its failure path
only releases the IRQ resources and the MC portal. The I/O object stays
allocated and published in the service list and per-CPU lookup table,
while devres unmaps its portal registers after probe fails.

Call dpaa2_io_down() on IRQ registration failure to remove the object
from those lookup structures and free it. Reorder the error labels so
that a failed dpaa2_io_create() still skips this cleanup.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: fe8fe7723a3a ("soc: fsl: dpio: register dpio irq handlers after dpio create")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -244,9 +244,10 @@
 
 	return 0;
 
+err_register_dpio_irq:
+	dpaa2_io_down(priv->io);
 err_dpaa2_io_create:
 	unregister_dpio_irq_handlers(dpio_dev);
-err_register_dpio_irq:
 	fsl_mc_free_irqs(dpio_dev);
 err_allocate_irqs:
 	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-- 
2.47.1

