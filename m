Return-Path: <linuxppc-dev+bounces-24508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AD8C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVY3rwtz30B0;
	Tue, 21 Jul 2026 01:11:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560261;
	cv=none; b=apPVgoafvyHKlcEy/McNQaZZizcIlc/B2kpOKuIhQ0qJxRM2t7YY7H8JqVXP/j//ZXG6AoypjubOSKFBgV3LrTwo+bYbkKMi5rfSLljdey18TLN8uO5u5sf2ITxIOkQwBUV0kiqV9yKZ8dXVuGxJ+lgj+IQNC2K29d5Hln0N6mCTUP49SRQoIb3a3xyPVK8jVRvti3QWy2kP0v40cV6zIuJ2YmGSzNT7bUl6zmrFNWw10VveN6Wb+Z0iOnfGmiGJOaG1Lb1CLhuJSqeuf6DPFnSvTAp9crtA25uIx7Wl3tV9W5A33e6Ly3qClFQKfhPYYGWuINPV7HCfvrgIrutFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560261; c=relaxed/relaxed;
	bh=FfB7GrmVp8WAki9+UnmVSGGvKtwSZ9GLa+Vb7MYQ6is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4ecTj5rcVumOVOXLUU+UFUjzI7L611/WehZrNdVUTCZrcmyABDGCNQVkihUWefU0P15JZrM8l8WhsNqv/tlffVvY0Bt+y4WDVw5QZCP73tDrVH6+p8TOtEhwWcPLcPxfDZkdZLwVvG1PpiQEpMcMEBD7G8NC5PclH7TSUdDgOVK1j9mf/B62SKsWjL70ajuSfs3pxW05BSFuwSOxMtiedDji1P0EBe1cvolx3SH5X34ZIwlSrG+/kJ0bu89wEcSRQjy1dFZqZzu4E6lf4N60zSpRJtyb9fvcaMzYrEwEF9eTDcJxmjf8iNKxXrDPEDgc66Lzp+YkOAqwnzyw143Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T05Ujlka; dkim-atps=neutral; spf=pass (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T05Ujlka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVP6tPlz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ff
	B7GrmVp8WAki9+UnmVSGGvKtwSZ9GLa+Vb7MYQ6is=; b=T05UjlkaldoQa5YO1i
	pYWOXA+5sHjoD1Znr8vTiWAk3LqecPXJQt2ysiuoKU09Ur5AmUhmWEXNBJxkoq2y
	oKSNHkoYPQvONVjblDNCVPpvZJO0k52szKh6MijJ7Ps8HK9TcOOGPx0R8mcmAhCU
	XRJCZO3IGNeWr/eQtCx1y2HFM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S2;
	Mon, 20 Jul 2026 23:07:54 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 08/16] PCI: dwc: fu740: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:11 +0800
Message-Id: <20260720150619.24733-9-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1UXr4rWw1rCr47Xr13urg_yoWDArbE9a
	4UGFs7ArWUKryFy3W2k3yfJF97Za47WF1UKa1rtFW3ZF97Xw18Wr9FqFyDJF48W34DXF1x
	JF4qvF40ka9rAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt7KIPUUUUU==
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wuyVmpeOctvPAAA3R

This callback is invoked after dw_pcie_host_init() has cached the offset,
so we can use pci->pcie_cap directly.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-fu740, the call chain is:

  static const struct dw_pcie_ops dw_pcie_ops = {
    .start_link = fu740_pcie_start_link,
  };
  fu740_pcie_start_link()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index d0a34f680397..72c0a6316fff 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -178,7 +178,7 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
-	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 cap_exp = pci->pcie_cap;
 	int ret;
 	u32 orig, tmp;
 
-- 
2.34.1


