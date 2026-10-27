Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA8606A333
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SW6eIvU9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVGp6p0gz2yfS;
	Tue, 27 Oct 2026 23:31:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104290;
	cv=none; b=HmZ3ZcmkJIjSxFPYMei/LcvMPXVihr4fvg36LAjpNydj1w3sqwBKjAsfMMG8nSv14/X78faYuor7V9echvn1X1Gp0SVM7xl0BXGZqz/La4gE0I2f0jYk12qUnL+HRHkoXKB4b7K/OIwY3VxVXnAjoxY8hO/m2DgHMCDWURF/GS4c5fyWn0W9Z9ie6ysrLdBDq6X3Rawe2AnLpDa6aYIBV1QGHFU+Mgm6WMN6R+XOgTPgtjQnA6V+gQla5Bmo8lBD4KIFRLpox+tsfqvxvnSQfsH2Llkn6aY3J75z4WladvxdBdkr9Rk1Qg97oZOTNY/4MQ7TEKXYjCPzFd/KJAWvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104290; c=relaxed/relaxed;
	bh=65SL1AewKqVdtWsrwvYT4s2cwkDMClnNUoT1ZS12Abw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkK9Vs5bs9nfGvHUXh/JQPZuf2K+gQ3zvItmgyfJDXr7JRZCiCZCzDHSEVSaZghvIwmewfikREGXyiKYg/x/pbpPNKauCEf+vFZ+e+Nyq8/Y8FbTwlbDG7L14emZCdK2GNiOTEZqZlH8l0qeQpDSnqA4ggOuLqavH0OOFuUnCaF1I0qoul6XJWj3XdNMOn5f+ECtnDAEkJc3e5yXAET2nY6lmWAgDvxPP1PBwcPbeOF9Yy9Cn+PPW8dy+WsVIKFnLa5tKPWo0nuhh/RJWrmsWbOeeuKb4MrMcpeJUvkVZROChL4ZvoC1t9RSixGmDKn1f89GX8RrVLHrnj/AdTnD1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SW6eIvU9; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SW6eIvU9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVGm3zqTz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:31:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=65
	SL1AewKqVdtWsrwvYT4s2cwkDMClnNUoT1ZS12Abw=; b=SW6eIvU9RZVRZrWTx3
	fWDG2za1mcEzzxVI3Fm2x9CiqdlTinhGUJLAPbHRqHHxMJ9CpFeSefPVf5VXadvU
	eJNlkXEcQ8GBGWgZjpbWDSDm9/ZcLG4nymativHlFeBzailRI3KCeZ5r8fXfVNER
	TEktLmFnflzKXz288j1Rpv5nU=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S8;
	Tue, 27 Oct 2026 20:28:48 +0800 (CST)
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
Subject: [PATCH v4 14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:25 +0800
Message-ID: <20261027122827.2725643-15-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S8
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17Zr17XFWkuFW5ZF47Jwb_yoWDCFcE93
	s8WFnrArWUGF98GFnFyryrXryYva4fWw1jga9aqFZxAFn7Xw1kWr92qFZrAF95Cr1DXF97
	Jr1qvF48A3yUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNuWltUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AE53GrgmQEa0gAA3S
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

spear13xx_pcie_host_init() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap() and store the offset in a u8.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 01794a9d3ad2..6e4c11b497d4 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -122,7 +122,7 @@ static int spear13xx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
-	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 exp_cap_off = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
-- 
2.43.0


