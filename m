Return-Path: <linuxppc-dev+bounces-24512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB759C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVb1LWtz3bqD;
	Tue, 21 Jul 2026 01:11:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560263;
	cv=none; b=Hsy/OLHhWWwG8ZZffnfUmmRggSa0iKyfCb9JioayYkWvm+ESco4cFSB3g7sarWhgTNjGYNwsDdjkwQbWnAg+z3k2aRLM2Tw9EhIdkTDFYt3ixd3rgIb/yLRxAu8eYh8L5jhP/fh2Yp88EpoWEc3f/iSp0ycHM4tTXueHOfLCD3euF4YzCJuBe6PMGgcpG+Ut9Dpmt9AaGoc66zBnZI/yL8CQEDEfnhl+M8I1BEt7Lr08bZhVcxGk0HkycdRAaV9qXsXBOAXn70uqwKvap8Mt1gFOMJZli9nTJRwxs7H83BBl49iNcSsmXAGFmOM8qMySixZ8GXR/TmsHsNRQH4DcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560263; c=relaxed/relaxed;
	bh=OmuI2Spp3n9kV5Al6PVnZ7ZuVvU00LmjtW0tSnMTkU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMN5bee/DUUR8voMPGv0FfaUWgpn7x9ZInESjmfPlknVk0ADN+b50rQb97t+5QdPW59XqtYMbZhG4BF3eh1yEx7TKCQFXWYa+NOHda8MBYIL/0fCWJg8XJn+oOoHm2QsHVfrJS2A9ZlTb/QkIhhSLqS5BzvvWRl64c/zkMCqvN0xlgY4SNvmQfWUQfRpSxdEU8qPOgCtuFdudVPlBXuVgOd0U2Bex8qJLUwdXjzUPGNdlKzHUoWWjtK0VPpiCFzhIzZ2n2cNCml+/S0PAMYS13yTeidkhysAoCK0TIkqBVc/hCWsmQDJxPwK6/KCi4osDn+k3Ip7bbRy5tOYIo0lwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=X+REq//w; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=X+REq//w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVQ10hmz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Om
	uI2Spp3n9kV5Al6PVnZ7ZuVvU00LmjtW0tSnMTkU8=; b=X+REq//wOe+JPBVZRf
	iKQ/Wg1l8eNIl04rCuJGnuOUVa50cGEdGMeJCu2Yh+d9tcScIZQEApLrC9W3a70f
	gFUMjuZVKj/ff/b7qjLQIxhMNH/WvppMBSfysyFsyVfa/P89hnK1ajV01wTpR5+r
	8+94fpUyPI8nU9fmA6j71Lkxw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S9;
	Mon, 20 Jul 2026 23:08:01 +0800 (CST)
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
Subject: [PATCH v3 15/16] PCI: dwc: tegra194: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:18 +0800
Message-Id: <20260720150619.24733-16-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWfJrW7KFWkXFWkKFy3urg_yoW8KF18pa
	yfXrWFkr1UJr4SqFsrAan8ZF1F93sIyrW7GanagwsIvr17C347WwsYk3y5tF17CFZFyryU
	Cr18tFy7Gr15J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9a9hUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxG0WGpeOdEBugAA3Z

In host mode: tegra_pcie_dw_host_init() runs inside .start_link, which is
called after dw_pcie_host_init() has cached the offset. However, the
driver's own initialization already enables hardware, so calling
dw_pcie_get_pcie_cap() is safe and will return the cached value.

In endpoint mode: pex_ep_event_pex_rst_deassert() runs after hardware is
enabled (PERST# deassert). Because the core no longer caches automatically,
we call dw_pcie_get_pcie_cap() here to cache the offset for subsequent
accesses. The helper performs the DBI read only when hardware is ready.

Thus, the private pcie_cap_base is always valid and can still be used for
register accesses.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-tegra194, dw_pcie_find_capability() appears in:

  static const struct dw_pcie_ops tegra_dw_pcie_ops = {
    .start_link = tegra_pcie_dw_start_link,
  };
  tegra_pcie_dw_start_link()
    -> tegra_pcie_dw_host_init()
      -> dw_pcie_find_capability()

  tegra_pcie_dw_probe()
    case DW_PCIE_EP_TYPE:
      tegra_pcie_config_ep()
        -> pex_ep_event_pex_rst_deassert()
	  -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 795cef5a915d..bf482bc66a92 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -905,8 +905,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	pp->bridge->ops = &tegra_pci_ops;
 
 	if (!pcie->pcie_cap_base)
-		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-							      PCI_CAP_ID_EXP);
+		pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
@@ -1889,8 +1888,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 	}
 
-	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-						      PCI_CAP_ID_EXP);
+	pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
-- 
2.34.1


