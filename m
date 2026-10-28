Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4638606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JIC+3XoR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjc3X7yz2ySl;
	Wed, 28 Oct 2026 14:07:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156852;
	cv=none; b=EY+l5hp8DnK1T740yZW0Kq4XipjX9acf3fioIDio6E6p724XNi5ZPu+SUNbS6RbrlNfgBg5bXuP4cUJGhoyGypZU/o3Is7opoSpP+ajvijToLzO8m3NeIfL9K7dI0u4Zf2gw55f7VLKOF7o6O1sWZtuoL58JJkiMonerdiDIqTKWZquRX4PXw3pxUNhhiRztxsof5SyfMeqlWcSxG/WMtGVhK4VN/At9JK7yHVt8yNgGiUQaToYtLa9YxBo6yTv8+oNoJKhMMU7oHzVSzHJFaH0gldDddu0HgkWx0LgCpoYOpP9x2Bkq45j1s/ZCCTriHMPRv1KV3aX1lOAP7APqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156852; c=relaxed/relaxed;
	bh=H7/WiFVVM2Ct9E/WSDPj/g8wukhy3907IvTWxmVmjP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfIl6JavLI5NGWSyTL/0JIFMZRYDFfHgnWgnfz8eMEmRebvJLn/ZfQKfd2VOKjBxOiMl/548x2AM4mfvnG8jLpXmplpXWFZmISv8JIDAG3FPq+TsSeXvcklo0u+DHvb1oViFTsRAw5+kXLbNKZkQUia33YRD6HYHyx00jrJM9diRbu9poEBcgTrp92/mXzJlMsXqwH6Dq55WNIDcvb9z38Mw22G3B8c53riAKj1qu1CQIs1AJkg2swlF9dy4aEhJXoyU5ke64DjgNf28a8MxZyPCbfKd/fPh7JfswFrbi+Xu10V3LcfmQP2aJbfFQtLC9WuM3D/m6qM0SuA98pGZ1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JIC+3XoR; dkim-atps=neutral; spf=pass (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JIC+3XoR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjZ1H8rz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=H7
	/WiFVVM2Ct9E/WSDPj/g8wukhy3907IvTWxmVmjP8=; b=JIC+3XoR2kMfR2J5D9
	4N+FL69uSijetsI0O8w8D2AZoMtL1Jt/dnuesm2kuf2eUnlJp5EAKz1Nu2X5IVQU
	KlthXBDV+VqqhunuHfHwETE/YVqsEaiWt+aw/J++XDvj4nOzOTGsauxX7V7bddpL
	9gn5lHSqmjA4pkU4IKALE7+2c=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S6;
	Wed, 28 Oct 2026 11:07:01 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 04/16] PCI: dwc: layerscape-ep: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:40 +0800
Message-ID: <20261028030652.2917756-5-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyrXr45GF17AF43Cw13XFb_yoW8WF1fpF
	Z8JF1Ykr18JF4SgFnF9a1DWr13GF9xAFW7Ja97Kw1avFyav3yUG3s0yryftFn7KFZFkF1a
	v3y5tFW5uw4rAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piLZ2-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xbhhWrhZtbEBwAA3h
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
ls_pcie_ep_probe() and ls_pcie_ep_event_handler() with
dw_pcie_get_pcie_cap().

The probe reads the Link Capabilities register to save the values
configured by the Reset Configuration Word anyway, so the offset is
cached there. The link down event handler runs in hardirq context and
can then simply reuse the cached value instead of walking the
capability list every time the link goes down.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 527c57114dcfe..113be247b01b0 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -84,7 +84,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
 
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = dw_pcie_get_pcie_cap(pci);
 
 		/*
 		 * The values of the Maximum Link Width and Supported Link
@@ -268,7 +268,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
 	ret = dw_pcie_ep_init(&pci->ep);
-- 
2.43.0


