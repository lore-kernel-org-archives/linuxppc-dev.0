Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254F606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gtbwcafv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjp3Bjnz3bYG;
	Wed, 28 Oct 2026 14:07:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156862;
	cv=none; b=PAJfmd4jHm601n32nut2YbPYT5VMsIGpwuc9T83y4vTWa7VcAgPwpnFhNf2gj6nqMFGR7EDXCCu+XHUy6YIKJn+S70azowpnS0jNbjVUAb3nqIqhVww0s2aaIRQcLDZNyJtPgPu0gYtrnQ+71lUiT2QUw6onIfHVcLyDYH0mefUSC//8hKAB4lxlSWmfy6293d5EhIiXBhpJWHH42cLWWZt74NwyRF7RgWWcam+Pvxwq0HQVNha6pGwGUWv54qCLK+aIO8F3u01UlYCPdKXbr7Uv3fLO0JErmpymwWUpLBT/afksKbtNM3PoM9wW2s+duUBBo89mGKhSXNPOGwrRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156862; c=relaxed/relaxed;
	bh=n4jGWf/FWtMvLmpyVMZtbApsVdmVgjXDZdhxzRoPMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBH7OmSGv9ybT8huQIR19T/APzxvrcJ+EwiF2X78vy2sgfoAQHf8Ckh0O1SDYTOKGkAEOE4nYoVnTQByPspL1IhuBHV5/9krR0ujHZX3fkNIfCX/TcErfX5peUFNfeqItSdOaa9/35J/03GpVPFMBLu1SjsmW9hqsVG6SOiejvZEKnKsnNsHvXfd7LvOp2Q+sAOYDe593lTRvCphA9RmYhUzeddWlhHwJV1VhTQyg9m8ZGh8URtXgdo5MpZX9VYKrxAPW44jlKIw/1OEF7sDN6aLWO7wMC1d1QTiHLSEDpNRhcwM6ugXgfGwKT5pZKsTu8dH6hJbrGaw2HwemYmgvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gtbwcafv; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gtbwcafv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjl23C7z30W9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n4
	jGWf/FWtMvLmpyVMZtbApsVdmVgjXDZdhxzRoPMwA=; b=gtbwcafvem1NRSUNV0
	mgm8RE6uKOEJUTa2VO2GqaFjXsEQnWaUj6v5IT1Q7mXLnpZ1m5KQVRqFrILUwe3X
	ZvJwkC3e9F2oCNAWnvHJcatHWEB9lb5V1TFrPusvFdw3NtsWhgAfpfhSVj0g//ku
	pQW8iwlRKvrqlW8IcZrLVMkpQ=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S9;
	Wed, 28 Oct 2026 11:07:16 +0800 (CST)
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
Subject: [PATCH v5 15/16] PCI: dwc: tegra194: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:51 +0800
Message-ID: <20261028030652.2917756-16-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWruryUuF43Kw4rGrW3ZFb_yoW8CF4rp3
	yrXr4Fkr1kJr4aqFsrAa1UZrnFyr9IyrW7WanYgwsIvF42ka42grZYkrW5tF17CFs7tryj
	kr18tFy3Gr15JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGYLLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7ATliWrhZuTTXAAA3C
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the two dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP)
calls in tegra_pcie_dw_host_init() and pex_ep_event_pex_rst_deassert()
with dw_pcie_get_pcie_cap() so that the driver-private pcie_cap_base is
filled from the same cached value.

tegra_pcie_dw_host_init() is called from .start_link, i.e. after the
controller has been initialized, and the PERST# deassert handler runs
after the endpoint has been brought out of reset with its clocks and
power enabled. The helper therefore performs its single DBI read at the
same point as the open coded search, and the private copy keeps working
unchanged.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 26e2ac5c58695..9d7ac539aceae 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -906,8 +906,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	pp->bridge->ops = &tegra_pci_ops;
 
 	if (!pcie->pcie_cap_base)
-		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-							      PCI_CAP_ID_EXP);
+		pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
@@ -1890,8 +1889,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		dw_pcie_writel_dbi(pci, GEN3_CTRL, val);
 	}
 
-	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-						      PCI_CAP_ID_EXP);
+	pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
-- 
2.43.0


