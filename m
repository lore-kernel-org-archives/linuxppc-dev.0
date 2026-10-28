Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B560731CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HlaGvqTS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjf4JdZz2yql;
	Wed, 28 Oct 2026 14:07:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156854;
	cv=none; b=Lau3nymNysBBZDc6S7YOp0RjcuDxO58UnKaeKm8ad+zXVgDVynniS6+ofEd/+CUQ1LWpsPWfLcGzmeQkvJ0Za0XDaRWFlD5QjnsXbcNTHqKtfFYFOfePb57ryPKp++YvkPted1SI3yj/aa316iuMTxh0oHwvDAQ3r/DNAwzx0rKcSt+Uip1WPxnwcNuDyA+hwM5F61jXFAwyb6Tib0F/twPYtRZCS45UvxNhMbd2hJ21qRrdiXUZSXPVfNfC75S/TS5XZbTNyf0T8w+5yVwCz4TBZrK1xKmLfX0C64SxxPuKqVLtxWu8gSVfNS4V3Fnx2bixQGBFgwCCNkLGkz43bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156854; c=relaxed/relaxed;
	bh=ENXjM8l8fpp+VQ1jCKMGhGoHWTRBJndO+D7+/5QFhRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFUWMd3Etmt80RjvBRgQ8H4E1HO72bsjsI/0YiRG9GgcpDJFPNMDcl+HNbWi3H7amueuuV+dPn4DNg4+1rdoqA5UL0Bdu0bziJcGm9nBqVuonG7iNbse1qhld/2FlyWMS2zOIrMgaNYJvHEgePhGPf+ySPr6K/5cFvAx8LJ/hVDrVKMGG+aKd33gXI7FE5iWWfzmJaUG3zjJHkKyfWC0J7zskZgxddwEBNjiBX8yDKObSD27j3FhtHYlicYGBk6jLbWwO/b9l/3ApobXhxyNweHp9LmfZWjDL5l3n0U1riGxKzFtXhxYlHOPjK45hgnqhW8eIYwtQE7mah1cm1iMaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HlaGvqTS; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HlaGvqTS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjZ1tB5z2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EN
	XjM8l8fpp+VQ1jCKMGhGoHWTRBJndO+D7+/5QFhRM=; b=HlaGvqTSN7WygKOAMT
	l8if6Pw8PqV1Wki3WB3U71S2hm2beDge9p2tegu07hJ3SDoA62E0Vl9/xHX/xzsz
	a728+pjxCw09fBwKnwrDgu7evxKXJFyVPE+TYZZqLCGUGDM/bxqPQjETnex+XShT
	8m5QN8/F7Il/u0IFh+Lw1Bgks=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S5;
	Wed, 28 Oct 2026 11:07:00 +0800 (CST)
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
Subject: [PATCH v5 03/16] PCI: dwc: imx6: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:39 +0800
Message-ID: <20261028030652.2917756-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyruw4UKr1UtFWxKw1xKrg_yoW8Ww43pa
	98urWFyF4rJF4IvFs7Aa15ur13tas0kF1UJan2gw1avFy3t34UWFy0yry3tF43Krs7try2
	yF17t3W7W39ayF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zigAwxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xXhhWrhZtXDzAAA3t
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the two dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
imx_pcie_ltssm_enable() and imx_pcie_start_link() with
dw_pcie_get_pcie_cap().

Both functions run with the controller powered and clocked: they are
reached either from the host .start_link callback or, in Endpoint mode,
after the PERST# deassert path has enabled the resources. The helper
therefore performs the DBI read at the same point as the replaced call
and caches the result for later invocations, which is useful for
suspend/resume where the link is started again.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 83fbd998551d0..865438ffde879 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1020,7 +1020,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
-	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(imx_pcie->pci);
 	u32 tmp;
 
 	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
@@ -1049,7 +1049,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 tmp;
 	int ret;
 
-- 
2.43.0


