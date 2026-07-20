Return-Path: <linuxppc-dev+bounces-24505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133E4C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVT6fMkz2ybK;
	Tue, 21 Jul 2026 01:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560257;
	cv=none; b=ecX4oqDv042dHvm2+ESCHLRQ0jxgGdKIk700/De3dp5mc3whq46pRKIvQwNMMq+P/3s0UfLiGemQwWLKdIlUfpWetgw7FnsMWeQoVUrLUWrs9wLw4Yj3tQzoWNbFOQGjaQx3V+EqTgiL3lvKgGff98GM+SbjvyODza/DYg6zsk/VT4krl/XHd8L7RiUigMGf60j78KKGK/LExeOnO7qxJb8pqeI1HslOvINjRTTUBaNfwXPPg2XZpMH9+qBJpPjlp1pSs4HyaaDg2J6jlvOogEAZnr6ezwfC0I3xkfpC/ovBoO0zhDa7ES0PLYz3vd9cWmdsV522FCCRzLNRkB7mkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560257; c=relaxed/relaxed;
	bh=sC5IK7rcAYFVlcW/qRjCYlhzV8RYd8qBA49KkuguIVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWZ+09PgyDgdc5Ok7uUlNnxoATy1k923wTy129hDJ9EOSuugjKdBITmBalOwUYMgH7vnmhimvdX/gS7Nq5cnA7U82Hqw+ie86/NhjjqvlVjUyQSvGTxh+EwIcr64o4WF2sox+uXJZ25KI9ADIdHU5mo9HOL/DTG1+J1ontOvgnmAH9AdnNfRQwVxPv/Y3WOZ2cMCOVEMVBOnnSMPVJ8P+2XhxGV29mkoFjNrJSsVznJ4iVliOPA2xjJ15ZqwehiNtZeCw/Jv4kzzpO2NiwNXIADrB0hwZraJGQZQB84Bh6JksQPHFy46AnC2iGXdSdTBNGjL03Mp9B1WbuL4jJBmAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=U1xIB7cY; dkim-atps=neutral; spf=pass (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=U1xIB7cY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVP6xqpz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sC
	5IK7rcAYFVlcW/qRjCYlhzV8RYd8qBA49KkuguIVM=; b=U1xIB7cYYmtHDba2Gg
	Aiy0ph56gAshFRwCfzdpxVDWPwdWnSX4lYYp2WwdOnuINDqBSSa5mMHpJgc97vM2
	Gr5ydSMhFv7KNMtNYF3saeMz/EFrze2OhzMB6X8PDhdsaYJXwqaH63YV74W9Yd/t
	aXWMFCUldUyUPgObP/gCPc78s=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S6;
	Mon, 20 Jul 2026 23:07:47 +0800 (CST)
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
Subject: [PATCH v3 04/16] PCI: dwc: layerscape-ep: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:07 +0800
Message-Id: <20260720150619.24733-5-18255117159@163.com>
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
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF15KF4kXF1ktr18Gry8Xwb_yoW5GF1kpF
	WUXF4YkF18Jr4SgFsrZan8Wr13GF9akFy7J397Kr1aqry2vryUGa90yry5tFn7GFWqkFyj
	934rtFy7u345JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pigAw7UUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAOwVGpeOcMFQQAA3p

Replace these with dw_pcie_get_pcie_cap(). The hardware is already enabled
by the driver before ls_pcie_ep_probe() and before the interrupt handler
runs. dw_pcie_get_pcie_cap() will cache the offset on first call, and
subsequent calls (including inside dw_pcie_ep_init) will use the cached
value without re-searching.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pci-layerscape-ep, dw_pcie_find_capability() is called in:

  ls_pcie_ep_probe()
    -> offset = dw_pcie_find_capability()
    -> pcie->lnkcap = dw_pcie_readl_dbi(offset + PCI_EXP_LNKCAP)
    -> dw_pcie_ep_init()
    -> ls_pcie_ep_interrupt_init()
        -> devm_request_irq(..., ls_pcie_ep_event_handler)
          -> ls_pcie_ep_event_handler()
            -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 8936975ff104..b2d0b51df3c5 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -74,7 +74,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 	struct ls_pcie_ep *pcie = dev_id;
 	struct dw_pcie *pci = pcie->pci;
 	u32 val, cfg;
-	u8 offset;
 
 	val = ls_pcie_pf_lut_readl(pcie, PEX_PF0_PME_MES_DR);
 	ls_pcie_pf_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
@@ -83,9 +82,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
-
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-
 		/*
 		 * The values of the Maximum Link Width and Supported Link
 		 * Speed from the Link Capabilities Register will be lost
@@ -93,7 +89,8 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 		 * that configured by the Reset Configuration Word (RCW).
 		 */
 		dw_pcie_dbi_ro_wr_en(pci);
-		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
+		dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP,
+				   pcie->lnkcap);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
 		cfg = ls_pcie_pf_lut_readl(pcie, PEX_PF0_CONFIG);
@@ -266,7 +263,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
 	ret = dw_pcie_ep_init(&pci->ep);
-- 
2.34.1


