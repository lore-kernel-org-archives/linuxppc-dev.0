Return-Path: <linuxppc-dev+bounces-20650-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3A4CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 13:55:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCSDZ4BcFz2xqv;
	Sat, 09 May 2026 23:55:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778334926;
	cv=none; b=giEl5MQmd9zwNLBWJSLor+c/FF98A86Uq1POsXCSNttyqB47eUGRghCokNmQ0DRlVUVkAUmP6GW61APi8DYR2eezrQugJ3rf1dLqCwaZU4Grit1zEuwbZmCYmXiFUdaaLQROe1vpW8APrzK0XEBxQC5EShnZqKSSaB1pOJiD5Q3Sky4PFuIoh6mYGUH7E2aBJIlWCupalDPC/R7Vj0b33lGnMXvDOhO6TGSUdqQ8gxFzhnz4OhME9Ek/13gPN/SRogVIMytoSkwrTQIYBvz5gURPMtX/geNnCroqjtCr1k4Q2o5RWUCIEomzoUH3ii0tt5DpcQ44g562UllNCebu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778334926; c=relaxed/relaxed;
	bh=U4TGWKaj7SkIQ8cbzabsaYNhoU9LhZdeAI4/egJLJc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0bfGoL64zjzsHxA5X4hw77W2awE07ezVgB3tAbmuNaFkkP1SExzKatt1zfb+xXFxcXSGQjSHGz8Ki2kZ29QrzNEScedljTiZLOWHVIdI6kro+jTfXkYrJpRPcVoy2m33O/D19FWSqDW9Nfe0kt0dnFR65ITkoADjo6/bi/oy216FP3bJNmcsBnP7Sgh2dFLT0klsDZzvgNmVQ6MaCRczh5/eYVbM+7/iUYm4pNlhCyf78PW/aBPFG8mRgV6lvocY7aGvmLVLMWSRTdDQY41VXlFpbD7AH+xxIDN0iIA5OlaO3BGH36ZOHkxvpHk62nCCoC9VL7zTVYBm4DG/H8Wbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=o9S+Nn+b; dkim-atps=neutral; spf=pass (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=o9S+Nn+b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 154 seconds by postgrey-1.37 at boromir; Sat, 09 May 2026 23:55:22 AEST
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCSDV6xHZz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 23:55:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U4
	TGWKaj7SkIQ8cbzabsaYNhoU9LhZdeAI4/egJLJc8=; b=o9S+Nn+bI2btgVgr2A
	i7Kj1LP7ypYonk+V1R4Yt9bYs7Qjp1t9rBo76rvkF5CUKNiSn+kNsNRHGra2qAiX
	W+Cona+v7xZwnniYiKzLDaeg6Q7NCoAsYJm98AQiaN1IXc987QbS0BGOKkV/tlB2
	d3A/Q4dC0HTCddI3u7Kldu5dQ=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXLzL8O_9p486jAQ--.37610S4;
	Sat, 09 May 2026 21:51:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: mx@lists.linux.dev,
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
Subject: [PATCH 2/3] PCI: dwc: Use cached PCIe capability offset in core
Date: Sat,  9 May 2026 21:51:51 +0800
Message-Id: <20260509135152.2241235-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509135152.2241235-1-18255117159@163.com>
References: <20260509135152.2241235-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDXLzL8O_9p486jAQ--.37610S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWrur15XryUAF18uF1DAwb_yoWrKw1fpa
	y5JFyYyF18AF45ZFn09as5Zr13tF9xArW7Ca9agr1SvFy2yFWjga18Ary3trn7KFsFyryY
	9w18trW5C3Z5tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi9a9xUUUUU=
X-Originating-IP: [140.206.53.66]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x9oDGn-O-+1ZwAA3Q

Modify the DWC core functions to use the cached pcie_cap offset instead
of calling dw_pcie_find_capability() each time.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c  |  4 +++-
 .../pci/controller/dwc/pcie-designware-host.c    |  4 +++-
 drivers/pci/controller/dwc/pcie-designware.c     | 16 ++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d4dc3b24da60..fdcb9012058d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1128,7 +1128,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 	 * to all other functions as well.
 	 */
 	if (funcs > 1) {
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = dw_pcie_get_pcie_cap(pci);
 		func0_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		func0_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW |
 					 PCI_EXP_LNKCAP_SLS, func0_lnkcap);
@@ -1390,6 +1390,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->msi_msg_addr = 0;
 	ep->msi_map_size = 0;
 
+	dw_pcie_get_pcie_cap(pci);
+
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c9517a348836..7b3ba83ed616 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -575,6 +575,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	raw_spin_lock_init(&pp->lock);
 
+	dw_pcie_get_pcie_cap(pci);
+
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
@@ -1218,7 +1220,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	int ret = 0;
 	u32 val;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c11cf61b8319..db62b93c6255 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -761,7 +761,7 @@ const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm)
  */
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
-	u32 offset, val, ltssm;
+	u32 val, ltssm;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -807,8 +807,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	if (pci->max_link_speed > 2)
 		msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+	val = dw_pcie_readw_dbi(pci, pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
 		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
@@ -844,7 +843,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
 static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 {
 	u32 cap, ctrl2, link_speed;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 
 	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
@@ -890,8 +889,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 {
-	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	u32 lnkcap = dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
 
 	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
 }
@@ -899,7 +897,6 @@ int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
 	u32 lnkcap, lwsc, plc;
-	u8 cap;
 
 	if (!num_lanes)
 		return;
@@ -936,11 +933,10 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
 
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	lnkcap = dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
 	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
 	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
-	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+	dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP, lnkcap);
 }
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
-- 
2.34.1


