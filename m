Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF69606B24B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=brVnHV1u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVGx2g9Qz3bV6;
	Tue, 27 Oct 2026 23:31:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104297;
	cv=none; b=m4A9aZxOqeuKJUci6QLf3tXUofSheYwdzeYb1mCuTBGvEPIN5CrZluev1hYbz8ncCU/oZhRBwpIN/FEssCUl7wsaZvo/vrGT78IXUmGSHj0P00vYz8br7oDM6U3ix570B9SKa38hKDyyYZ90e6IY9+L6ef+YnmaKa2QWJ/T6SzxCTRC4dmC1TjnIGuc9L97bWM95FG4duRTMMA/A0X3SqN99lgjJmT58R/GJTd0zGQsVEmhaTKpD4mTnSsDjhWLV68e1Zh4KcNq6Tu0GA2uuTBSKzw7hyu3Pb8+tRHDj8bKg6LV2pnhkYvKgVkh2w+VCgcmYCA3Bd2WvqwdMoZM+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104297; c=relaxed/relaxed;
	bh=P3tLqqAFpnJH9SKq8XCpeGD7if/i4dQDDK4AIGHrwgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6dB/crjcn5PvXBaztDXa0HJ17Y7RqKDZyaGSVCMN0kZG1hxd5/XmQouvmwm/82pyoX42ywdJcaTbGbs/ROSltv224c1nt1uqIfZn15T+zaYvsFvqOFp/H0S2xVrHQL0uVyjWui3UbkrktU44Y4qq2YFcFgruNnbvbiK3ap2rtaM9evq3KTHaVSSGwx7kpIKPgMbtBDFiW1vj0gFFZ6c30DtmWw5rOS9AmmiCgaP/IAnLqkKdK+KjFAQq2uNFXvcHzYefO7Qx3qdqG3/lqdcCPTVMtsAwcLotkxWoIGYAaa2loxuTvTutfGVHCNpn42WMEPyIFB3qycI/b4NtWz95w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=brVnHV1u; dkim-atps=neutral; spf=pass (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=brVnHV1u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVGv5STMz308H
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:31:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=P3
	tLqqAFpnJH9SKq8XCpeGD7if/i4dQDDK4AIGHrwgE=; b=brVnHV1uBzJ2WBqtd7
	C9/jmmzH6ng05ud6IrlRIZb5TWMKleR+0g0EHWFxQ7QAHlpKJVFWDKE/ky3p8A1n
	ZDs7BxUFF0fiLiP8Y9RXAvcZK6m9cTit00NZy/LxDABL69Ib2sLirqkLhvE70JqH
	OpwG9qVLJTC0MQ2ybrkvksnMg=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S4;
	Tue, 27 Oct 2026 20:28:33 +0800 (CST)
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
Subject: [PATCH v4 02/16] PCI: dwc: Use cached PCIe capability offset in core
Date: Tue, 27 Oct 2026 20:28:13 +0800
Message-ID: <20261027122827.2725643-3-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry3AF4UurW3tw45GrW8tFb_yoWrJr4xp3
	y5JFyYyF18AF45ZFs29as3ZF15tF9xArW7Ga9agrnI9Fy2yrZFga10vry3tFn2kFsFyrya
	9r1UJr15Cwn3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziveHfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xE12GrgmPEXawAA3I
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert the DWC core users of
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to dw_pcie_get_pcie_cap():

  dw_pcie_wait_for_link()
  dw_pcie_link_set_max_speed()
  dw_pcie_link_get_max_link_width()
  dw_pcie_link_set_max_link_width()
  dw_pcie_ep_init_non_sticky_registers()

These functions are reached in exactly the same situations in which the
replaced dw_pcie_find_capability() call used to be executed, so DBI is
accessible whenever the helper performs its first lookup. Because the
lookup happens at the point of use, there is no window in which
pci->pcie_cap could be used uninitialized, neither in Root Complex nor
in Endpoint mode.

While at it, remove the now redundant capability lookup in
dw_pcie_link_get_max_link_width(): the offset variable it filled is the
one used for the register access.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de8ee3db4360..b56dbbb29733 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1265,7 +1265,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 	 * to all other functions as well.
 	 */
 	if (funcs > 1) {
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = dw_pcie_get_pcie_cap(pci);
 		func0_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		func0_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW |
 					 PCI_EXP_LNKCAP_SLS, func0_lnkcap);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 593388f29bdd..bd18415e92da 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -806,7 +806,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 
 	pci_host_common_link_train_delay(pci->max_link_speed);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
 	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
@@ -844,7 +844,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 {
 	u32 cap, ctrl2;
 	enum pci_bus_speed link_speed;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u16 ctrl2_speed;
 
 	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
@@ -879,7 +879,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 {
-	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 cap = dw_pcie_get_pcie_cap(pci);
 	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 
 	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
@@ -925,7 +925,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
 
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap = dw_pcie_get_pcie_cap(pci);
 	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_MLW, &lnkcap, num_lanes);
 	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
-- 
2.43.0


