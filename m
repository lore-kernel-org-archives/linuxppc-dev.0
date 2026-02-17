Return-Path: <linuxppc-dev+bounces-16920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA1BE9A03B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 21:27:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFt5y1mrhz2yrn;
	Wed, 18 Feb 2026 08:27:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771363670;
	cv=none; b=EZ9WGDezz7ZBYC0vMHR4rfWv+3ixK0POkmWzOo0ds+4cN2YC+BhqQbK3e8cCn70m1s4ybrepLte6wovSVCeZQezMY8i3wSY+1zxeH6eKUrEBNhlfrHKUpyc0LoNzJjKaGNCoiKRRu/JJAnNhGccdIj23wALEcfyOeB14xigYscwby+OUm098Ty74rxSW9LB3PqsxSuBd+EWIPGB1wzOSeTOotlEY3yKFoHQw6v/tHDk6Qy7hggozilBHkEHpcQ/jAyezSIYl2ZZA6pWR6MP7WZSLMjfdzi7wtmscV+W9DzgeEHwar6heko/CQarACKNoXQyLZrv9NCSg147NvtsulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771363670; c=relaxed/relaxed;
	bh=HDnO+xMzgtIg7dSQlnQN9CIg4wd+14OsJgxrdor0hbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUN4v4MHkkTxFDE4iln8qwfPGn1GEtSJSK7nNqSfgdruEvC6kVIX4Uziwy+FiWdZ8WmRerfa7HlpcuDs6PuRt1rsGDrA32gVRPXJ8SdvHPJ921gHLVQ9e/wb64OcuzdMYS31XopxSPaFpO3vhYvZz1hzFSjkFakKAaIwf8p28bEmw6DihAcAiSSFjfGpq9FEaltsfCzGn+f32Q5B6s2a7J9qYrVXfyyU6TuUcTNqDDKb2ap4PJcOF/jkY+uwgfv107o1aYkZ17lTjGqskqdAJARtdnfYJRVtJ6IStNE6HbhR6A3ZXMXVjkMeGiTcFS8krTN6aRRudPokyFZ2lUbeBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C/fjQHv4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C/fjQHv4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFt5x2XWMz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 08:27:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D05A361850;
	Tue, 17 Feb 2026 21:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0C9C19421;
	Tue, 17 Feb 2026 21:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363666;
	bh=X04sYpF9RR3/zBHOQ0h3rIKYAPzRe51nTHAYQKai6UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/fjQHv4VU1gQU6yfH5Dc/ERiUNHU2+zfHPZhybcyNysepnXxB+HU0uxw+ajqd2to
	 K3rQE2UoP5GyEf5tiWZ+25juOM5F3fkymp8kmcIHEf5IiTtdh4+ThvOcszMWyVSf+8
	 Xtc0ZcLcv9CdD2jxQZ4FAgd3m+PxH1IoxpBmS5fAMyOUGSZrFSktZX0Yuf3GEp6ZLG
	 vLk6zOIWq4TCuarWcuLqT61gfipxN6BoHRCtA+XLTh9qAell6O2aj9qIWBZlgrSAYQ
	 knyN5RT7FmAPA9kif4tJsGWKcK8v7j1U55zxouA5s/JYML8hGtan/ONQimIkq+Smha
	 6QXZvnUsac9vA==
From: Niklas Cassel <cassel@kernel.org>
To: Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/9] PCI: endpoint: Introduce pci_epc_bar_type BAR_64BIT_UPPER
Date: Tue, 17 Feb 2026 22:27:07 +0100
Message-ID: <20260217212707.2450423-12-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217212707.2450423-11-cassel@kernel.org>
References: <20260217212707.2450423-11-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7812; i=cassel@kernel.org; h=from:subject; bh=X04sYpF9RR3/zBHOQ0h3rIKYAPzRe51nTHAYQKai6UU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3NXRzVUO90+MyMjbePv44dXmDN9EY3oefPviGxPyi zeP331BRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYSsJKR4b9DR/HPG0fmP+mP rKou2+w0YcqkbS4vF59+t3r74qIXL5UYGdZr+b29pCFyJ8ta9Z5dgY4d55PNjWs3F8ydwxO8SPz ELU4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate
BAR_64BIT_UPPER from BAR_RESERVED.

This BAR type will only be used for a BAR following a "only_64bit" BAR.

This makes the BAR description more clear, and the reader does no longer
need to check the BAR type for the preceding BAR to know how to interpret
the BAR type.

No functional changes.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c |  4 ++--
 drivers/pci/controller/dwc/pcie-keembay.c      |  6 +++---
 drivers/pci/controller/dwc/pcie-qcom-ep.c      |  4 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c     |  2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c  | 10 +++++-----
 drivers/pci/controller/pcie-rcar-ep.c          |  6 +++---
 drivers/pci/endpoint/pci-epc-core.c            |  3 ++-
 include/linux/pci-epc.h                        |  5 ++++-
 8 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index a4a800699f89..5a03a8f895f9 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -251,9 +251,9 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	pci->ops = pcie->drvdata->dw_pcie_ops;
 
 	ls_epc->bar[BAR_2].only_64bit = true;
-	ls_epc->bar[BAR_3].type = BAR_RESERVED;
+	ls_epc->bar[BAR_3].type = BAR_64BIT_UPPER;
 	ls_epc->bar[BAR_4].only_64bit = true;
-	ls_epc->bar[BAR_5].type = BAR_RESERVED;
+	ls_epc->bar[BAR_5].type = BAR_64BIT_UPPER;
 	ls_epc->linkup_notifier = true;
 
 	pcie->pci = pci;
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 2666a9c3d67e..5a00b8cf5b53 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -313,11 +313,11 @@ static const struct pci_epc_features keembay_pcie_epc_features = {
 	.msi_capable		= true,
 	.msix_capable		= true,
 	.bar[BAR_0]		= { .only_64bit = true, },
-	.bar[BAR_1]		= { .type = BAR_RESERVED, },
+	.bar[BAR_1]		= { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_2]		= { .only_64bit = true, },
-	.bar[BAR_3]		= { .type = BAR_RESERVED, },
+	.bar[BAR_3]		= { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_4]		= { .only_64bit = true, },
-	.bar[BAR_5]		= { .type = BAR_RESERVED, },
+	.bar[BAR_5]		= { .type = BAR_64BIT_UPPER, },
 	.align			= SZ_16K,
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 18460f01b2c6..e55675b3840a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -850,9 +850,9 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.msi_capable = true,
 	.align = SZ_4K,
 	.bar[BAR_0] = { .only_64bit = true, },
-	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_2] = { .only_64bit = true, },
-	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
 };
 
 static const struct pci_epc_features *
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 06571d806ab3..31aa9a494dbc 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1993,7 +1993,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
 	.msi_capable = true,
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
 			.only_64bit = true, },
-	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_2] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_RESERVED, },
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index d52753060970..f873a1659592 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -426,9 +426,9 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 		.msix_capable = false,
 		.align = 1 << 16,
 		.bar[BAR_0] = { .only_64bit = true, },
-		.bar[BAR_1] = { .type = BAR_RESERVED, },
+		.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
 		.bar[BAR_2] = { .only_64bit = true, },
-		.bar[BAR_3] = { .type = BAR_RESERVED, },
+		.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
 		.bar[BAR_4] = { .type = BAR_RESERVED, },
 		.bar[BAR_5] = { .type = BAR_RESERVED, },
 	},
@@ -445,11 +445,11 @@ static const struct uniphier_pcie_ep_soc_data uniphier_nx1_data = {
 		.msix_capable = false,
 		.align = 1 << 12,
 		.bar[BAR_0] = { .only_64bit = true, },
-		.bar[BAR_1] = { .type = BAR_RESERVED, },
+		.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
 		.bar[BAR_2] = { .only_64bit = true, },
-		.bar[BAR_3] = { .type = BAR_RESERVED, },
+		.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
 		.bar[BAR_4] = { .only_64bit = true, },
-		.bar[BAR_5] = { .type = BAR_RESERVED, },
+		.bar[BAR_5] = { .type = BAR_64BIT_UPPER, },
 	},
 };
 
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 657875ef4657..9b3f5391fabe 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -440,13 +440,13 @@ static const struct pci_epc_features rcar_pcie_epc_features = {
 	/* use 64-bit BARs so mark BAR[1,3,5] as reserved */
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = 128,
 			.only_64bit = true, },
-	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = 256,
 			.only_64bit = true, },
-	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256,
 			.only_64bit = true, },
-	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_64BIT_UPPER, },
 };
 
 static const struct pci_epc_features*
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..8de321e1c342 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -104,7 +104,8 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 
 	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
 		/* If the BAR is not reserved, return it. */
-		if (epc_features->bar[i].type != BAR_RESERVED)
+		if (epc_features->bar[i].type != BAR_RESERVED &&
+		    epc_features->bar[i].type != BAR_64BIT_UPPER)
 			return i;
 	}
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..c22f8a6cf9a3 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -192,12 +192,15 @@ struct pci_epc {
  *		   NOTE: An EPC driver can currently only set a single supported
  *		   size.
  * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
+ * @BAR_64BIT_UPPER: Should only be set on a BAR if the preceding BAR is marked
+ *		     as only_64bit.
  */
 enum pci_epc_bar_type {
 	BAR_PROGRAMMABLE = 0,
 	BAR_FIXED,
 	BAR_RESIZABLE,
 	BAR_RESERVED,
+	BAR_64BIT_UPPER,
 };
 
 /**
@@ -207,7 +210,7 @@ enum pci_epc_bar_type {
  * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit. Additionally, the BAR succeeding
- *		this BAR must be set to type BAR_RESERVED.
+ *		this BAR must be set to type BAR_64BIT_UPPER.
  *
  *		only_64bit should not be set on a BAR of type BAR_RESERVED.
  *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
-- 
2.53.0


