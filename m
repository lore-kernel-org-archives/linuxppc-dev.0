Return-Path: <linuxppc-dev+bounces-18118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FBC105A596
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 13:03:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWnpx6lmmz3cFm;
	Fri, 13 Mar 2026 00:03:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773320585;
	cv=none; b=MyBa1DsCn4Vp/E0xUJfGhX9ZofCsBMpP7sEXd0VKeod7pN8KBLK2n/+2gi+Y17v9XL27TmjKpaFlAhLiZXgga9IQReK6+Zm/9JzlbfFgj9JUaxmebrNhDq8PpzSZP341y+9ITGaUVl8AXobRhedYKbLo9yEGTO1brfHYtZuS7jVtgHIRKghNzj3DYmg9Fv9oEMlBbw7HheQBxh66ld3XxomnRk9U4yn0Xlp/g4jEma4BVLSNORW5LQuvKRFxJGTxWnwJW7b1ZR4SDeDBnBS49rQcgvypIKfOWaMAwi/UHCeFkkQsdgpmlbdmmJBZGlwji1RbWROz1BvQnnEU9wNrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773320585; c=relaxed/relaxed;
	bh=xh1txJNyzG1M2Lr/vjuwW9qa/Cj3gHNtNUqRXDGSUwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0rOPAOs78KjF+GVrr6bPZFVwIkoyZhnfwrOIZiIj8Q/2Dq3/oye8KEiRBpmixXlSm9beSsp/cz72z5+Kudx1s1wcM7lhZXHIcte96GcBW/ZKEyklffK7070pt3HQZxYOSfOmIRr0NeWR8SUaBcO7B++Sft8iJnewMrwLBXhBmBeL/MYFTCDMLlQbXLF8PDaCNfzw4JTA123LW6KrVgRgWjg/5m/aCZ0+QbkZSfKZSL645Ov3Q6YRN+HvRLG0IgHyG9LomGvg21eohGIl2+deGjVSSiBJpncIKCA5Fa5XG9VTK2iGXFdgoAbPuPy0BteRWl2u0hh1exp261G4fsbTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qpIZAAZG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qpIZAAZG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWnpx1K1xz3cFN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 00:03:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 17EB743B50;
	Thu, 12 Mar 2026 13:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8711DC19424;
	Thu, 12 Mar 2026 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320583;
	bh=GbGl6zqVttX478ng3v1K7mG32v3LA6mgfKCuVzgbqjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpIZAAZGdWADpLd/buqNtmxhbq0F6Xbx217+SmEYFV0DDw4ppbi2zw+VQWxP1hgY8
	 ERzXBVuWkWLSb5LQ37yTXqTjLUSOlUVa2JW3+MEItwUP+f/3CUQ1mTRmQPyDluf695
	 fxd2vZ2O8qgB0EYn6tkCQ7TsqA2i8jshvCVjM2CoZLbqSM4/6YIoRPuLSgY+oT7xoM
	 1uTUdIFlsuY5oxML6KR/VU5bCXypjL8TCy2m5OCKin469LT27yan17GRNeSTOVIlqQ
	 D+lOCaYXDvv+knwk4hAZ8TZRivK2HdHAt7X/k8Tj5zqUJaKv7LxVz/6g0h0eO1IWMv
	 AoKY9TKabzRcA==
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
	Magnus Damm <magnus.damm@gmail.com>
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
Subject: [PATCH v4 01/10] PCI: endpoint: Do not mark the BAR succeeding a 64-bit BAR as BAR_RESERVED
Date: Thu, 12 Mar 2026 14:02:29 +0100
Message-ID: <20260312130229.2282001-13-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>
References: <20260312130229.2282001-12-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6284; i=cassel@kernel.org; h=from:subject; bh=GbGl6zqVttX478ng3v1K7mG32v3LA6mgfKCuVzgbqjU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI37cx2PrTthw/rFoFbZ6be+SDvd+hvUxxLWMSfBN2ai O59c7X6O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRq5MZGZq2nz3XKRZ/ofaF 1nlmi7cHBU0tJx3aFxTAo3bz8o+623UM/xOWaat43l784uL1KtZMVyPPNMWPwec58j59qFbQcF8 8jRkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A BAR that can only be configured as a 64-bit BAR by an EPC driver can be
marked as such using the "only_64bit" flag.

Currently, the documentation says that an EPC driver should explicitly
mark the BAR succeeding an "only_64bit" BAR as BAR_RESERVED.

However, a 64-bit BAR will always take up two BARs. It is thus redundant
to mark both BARs.

pci_epc_get_next_free_bar() already skips the BAR succeeding a "only_64bit"
BAR, regardless if the succeeding BAR is marked as BAR_RESERVED or not.

Thus, drop the BAR_RESERVED for a BAR succeeding a "only_64bit" BAR.

No functional changes.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 2 --
 drivers/pci/controller/dwc/pcie-keembay.c      | 3 ---
 drivers/pci/controller/dwc/pcie-qcom-ep.c      | 2 --
 drivers/pci/controller/dwc/pcie-tegra194.c     | 1 -
 drivers/pci/controller/dwc/pcie-uniphier-ep.c  | 5 -----
 drivers/pci/controller/pcie-rcar-ep.c          | 3 ---
 include/linux/pci-epc.h                        | 3 +--
 7 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index a4a800699f89..79d226e0cc80 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -251,9 +251,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	pci->ops = pcie->drvdata->dw_pcie_ops;
 
 	ls_epc->bar[BAR_2].only_64bit = true;
-	ls_epc->bar[BAR_3].type = BAR_RESERVED;
 	ls_epc->bar[BAR_4].only_64bit = true;
-	ls_epc->bar[BAR_5].type = BAR_RESERVED;
 	ls_epc->linkup_notifier = true;
 
 	pcie->pci = pci;
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 2666a9c3d67e..7cf2c312ecec 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -313,11 +313,8 @@ static const struct pci_epc_features keembay_pcie_epc_features = {
 	.msi_capable		= true,
 	.msix_capable		= true,
 	.bar[BAR_0]		= { .only_64bit = true, },
-	.bar[BAR_1]		= { .type = BAR_RESERVED, },
 	.bar[BAR_2]		= { .only_64bit = true, },
-	.bar[BAR_3]		= { .type = BAR_RESERVED, },
 	.bar[BAR_4]		= { .only_64bit = true, },
-	.bar[BAR_5]		= { .type = BAR_RESERVED, },
 	.align			= SZ_16K,
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 18460f01b2c6..ffb4409c0468 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -850,9 +850,7 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.msi_capable = true,
 	.align = SZ_4K,
 	.bar[BAR_0] = { .only_64bit = true, },
-	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_2] = { .only_64bit = true, },
-	.bar[BAR_3] = { .type = BAR_RESERVED, },
 };
 
 static const struct pci_epc_features *
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 06571d806ab3..f1f70fb824b2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1993,7 +1993,6 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
 	.msi_capable = true,
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
 			.only_64bit = true, },
-	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_2] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_RESERVED, },
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index d52753060970..b7020131f626 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -426,9 +426,7 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 		.msix_capable = false,
 		.align = 1 << 16,
 		.bar[BAR_0] = { .only_64bit = true, },
-		.bar[BAR_1] = { .type = BAR_RESERVED, },
 		.bar[BAR_2] = { .only_64bit = true, },
-		.bar[BAR_3] = { .type = BAR_RESERVED, },
 		.bar[BAR_4] = { .type = BAR_RESERVED, },
 		.bar[BAR_5] = { .type = BAR_RESERVED, },
 	},
@@ -445,11 +443,8 @@ static const struct uniphier_pcie_ep_soc_data uniphier_nx1_data = {
 		.msix_capable = false,
 		.align = 1 << 12,
 		.bar[BAR_0] = { .only_64bit = true, },
-		.bar[BAR_1] = { .type = BAR_RESERVED, },
 		.bar[BAR_2] = { .only_64bit = true, },
-		.bar[BAR_3] = { .type = BAR_RESERVED, },
 		.bar[BAR_4] = { .only_64bit = true, },
-		.bar[BAR_5] = { .type = BAR_RESERVED, },
 	},
 };
 
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 657875ef4657..c2da8ac1f2e8 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -440,13 +440,10 @@ static const struct pci_epc_features rcar_pcie_epc_features = {
 	/* use 64-bit BARs so mark BAR[1,3,5] as reserved */
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = 128,
 			.only_64bit = true, },
-	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = 256,
 			.only_64bit = true, },
-	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256,
 			.only_64bit = true, },
-	.bar[BAR_5] = { .type = BAR_RESERVED, },
 };
 
 static const struct pci_epc_features*
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..c981ea7d52c0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -206,8 +206,7 @@ enum pci_epc_bar_type {
  * @fixed_size: the fixed size, only applicable if type is BAR_FIXED_MASK.
  * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
  *		should be configured as 32-bit or 64-bit, the EPF driver must
- *		configure this BAR as 64-bit. Additionally, the BAR succeeding
- *		this BAR must be set to type BAR_RESERVED.
+ *		configure this BAR as 64-bit.
  *
  *		only_64bit should not be set on a BAR of type BAR_RESERVED.
  *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
-- 
2.53.0


