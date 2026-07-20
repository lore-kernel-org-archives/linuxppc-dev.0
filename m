Return-Path: <linuxppc-dev+bounces-24514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C99C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVd1mH9z3byP;
	Tue, 21 Jul 2026 01:11:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560264;
	cv=none; b=L8n7yHiYwTbrTQHrtf1lDPHtN7fJD9zI34ko0qJUJLDdXpASS7WitR3ezQ7vX0t4K8G7LApN902b/+f0R0usW0riLpo2fWhqhkdvzszB0rmX+BFa2ZvYzajFRXhTboWk70cZj0LL+C8dwIhJvQ7K26j/O57XGJMOfLxykjTRYwC2KLQM3/nCkUj87B9ZamxWdKa/F56Za8mdRBTxToWaOdU+44yHJ9ZsLrzE6rsW1tzTKvaCrupXVTw38O45ZcURWy4xBuECY8TPOO5PnytYuiIzhQfljP3/CRU2gxsWYKBh8cRGZ62Qvbc+eVNarMoNk+cP01V27jsIxQQoZ6lSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560264; c=relaxed/relaxed;
	bh=P5dtUmSCJE7DzqsEwcI8FKsNsEzR7pCOmSoVvece9QE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbyGKuqC3G673j34ktCv64XIO6wL0FucqloK6QPo26d/HvnFS9SPRgS7JhQjPNl/mgQXcUfmGsYnREsdhcFvb5cmErAp5fMOEb8dEGgWa8jH5BUBjBZJ8e+BsTOxy7Bt4Hr8FSthRLP6N7H8Ee/VijMLdA1Whib05dB5qiUQ14g2/1VrxdxJ1WRVIZgvrjdteBjpshNE/yIO0w/2kfxNn0n+hwMURzhsKSS+ZXpdjAfpcWjWLAtieXr7DjoDU4tLgVJMASgu2jBEaLGE3QJLQBz7byaf4h6WKvlA8caTWqpk6u+/lI64h12VKQAK49+gXaTPStILt/8vVNnhWTZpGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WHD25rbD; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WHD25rbD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVQ13dbz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=P5
	dtUmSCJE7DzqsEwcI8FKsNsEzR7pCOmSoVvece9QE=; b=WHD25rbD+O3j/PT/bT
	hZqCaT6y3aNagSE1KNUgmZzKqZzOjklu7qJiEGkfnex+zdNyzT4/sZb7/ExrlHfy
	I4u2eHHcW3SLMybgrWivdvpxISrVGWvUVfkR7jTgf03CFB4Dr4OPWN8z/k2quiWE
	mw5891+p7BDY6f5GDoCuVDVew=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S4;
	Mon, 20 Jul 2026 23:07:57 +0800 (CST)
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
Subject: [PATCH v3 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:13 +0800
Message-Id: <20260720150619.24733-11-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4kWFW3Cw4fAFy7JFy3CFg_yoW5GFy8pa
	s0qrsIyr18Jr48XrsFka98XFnxWrn8Ary7Aa97Kw1fZa42v347Ja1jyryftFn7GFW7KryU
	Cr4rt3yxu3WYyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEzB-NUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCww2zV2peOc0BRQAA3u

dw_pcie_ep_init() no longer caches the offset automatically. For qcom-ep,
hardware (clocks, PHY) is enabled only after PERST# deassert. Therefore,
we must call dw_pcie_get_pcie_cap() in qcom_pcie_perst_deassert() after
the resources are enabled, before any DBI access. This ensures the cached
offset is valid for subsequent uses in interrupt handlers and ICC updates.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-qcom-ep, dw_pcie_find_capability() appears in:

  qcom_pcie_ep_probe()
    -> dw_pcie_ep_init()
    -> qcom_pcie_ep_enable_irq_resources()
      -> qcom_pcie_ep_global_irq_thread()
	-> qcom_pcie_ep_icc_update()
	  -> dw_pcie_find_capability()
	-> qcom_pcie_ep_perst_irq_thread()
	  -> qcom_pcie_perst_deassert()
	    -> offset = dw_pcie_find_capability()  (called twice)
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 56184e6ca6e6..16b0891f9571 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -307,15 +307,13 @@ static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
-	u32 offset, status;
-	int speed, width;
-	int ret;
+	int speed, width, ret;
+	u32 status;
 
 	if (!pcie_ep->icc_mem)
 		return;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	status = readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
@@ -491,14 +489,15 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
+	dw_pcie_get_pcie_cap(pci);
+
 	/* Set the L0s Exit Latency to 2us-4us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = pci->pcie_cap;
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L0SEL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
 
 	/* Set the L1 Exit Latency to be 32us-64 us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L1EL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
-- 
2.34.1


