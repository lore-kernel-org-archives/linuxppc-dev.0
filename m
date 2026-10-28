Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EBB60A3839
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cxmqqI8v
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjh2Yxxz30HB;
	Wed, 28 Oct 2026 14:07:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156856;
	cv=none; b=SyBH4CW6SQy6OxxJhAzhcSnR+N6a7FR7K8n/AQ0+ubcp8z3fGS3H0vkxsjngJxF8xUEHmuPY566jbE/hLcwEwAjpcReIBq00mYeV54qGWIpt3O4THbvndLjX8W2uQxYv6iaE4EJMZxTimeVrn5YFqsNWxSnYe4DVfnDjz7CuEPEGKYE3ErNXNohW/nLRjIAHeCABhtQ6K/EOs3sQ4AWJxBmIhpM3GmbjmSBZI0KJ3aJxC7kQSiz60kwDxO4cZbs/B59LdVeWLZ0MJV0UlKbH7GZ89yIirJDwIWt7JgpdvdwE3BX1VTKRsbz5pZYyd4MnK/Qly6gLYLMR87L+fDO8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156856; c=relaxed/relaxed;
	bh=U80Wmdsj12fusZWg64ofRVwUMzzXEmzCkUfqbRVT4lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax7WbgCBBCQvKBppbv2JwpoOWEdGOcKeCqhpDiHaEKO0w28Z0H5xw9vlOs6xxuVY/zun4dV4iqMAQVcSCNGJbR3IkDv+anQsAQywnQN0Ay3iZREfayiNmtG68pO1UV2vo4iyD7ZG78SII/XvTcmgG0ZHM1LO9wOYuPojxxF7RbAszJFrrOqHr16Y9dzckdEsJ5WStvrWXpmcJC41vDSgvpTF+XzXZmBXZ0Qnia1w3jIxvA2+c2JSH+ueDIwlL3RuPvGzIyXGqhUrUdOrYlhhB6ZsIGAO7bRo7hIij0piks0+y1zttHeuudetOLTL9s5FbUmNuPOTOI87nXd9OcHPkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cxmqqI8v; dkim-atps=neutral; spf=pass (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cxmqqI8v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjc42fCz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=U8
	0Wmdsj12fusZWg64ofRVwUMzzXEmzCkUfqbRVT4lc=; b=cxmqqI8vb7VAeGamUa
	L+ah58/1rzK2nAEkKUGB+Mcsu+KQajbzlvlpHTX34yrE1p0j0+U/pJf32Z7uOjjM
	bhWAO149qlw6WVR6EolQhQ8UFN6HSAd5+REfz1VLjykS9Z/pqmgwhKtYq1+hX95h
	ZH63h1HSKzSzjIPWEuvb4Q62Q=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S4;
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
Subject: [PATCH v5 02/16] PCI: dwc: Use cached PCIe capability offset in core
Date: Wed, 28 Oct 2026 11:06:38 +0800
Message-ID: <20261028030652.2917756-3-18255117159@163.com>
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
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry3AF4UurW3tw45Ary8Grg_yoWrJr1rpa
	y5JFyYyFy8AF45ZFs2vas3ZF15tF9xArW7Ga9agrnI9Fy2yFZFga10yry3tFn2yFsFkrya
	9r1Utr15Cwn3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziDDG8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BThhWrhZtTO4QAA3K
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
index 630ba172280c2..b410f6ebed4ba 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1268,7 +1268,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 	 * to all other functions as well.
 	 */
 	if (funcs > 1) {
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = dw_pcie_get_pcie_cap(pci);
 		func0_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		func0_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW |
 					 PCI_EXP_LNKCAP_SLS, func0_lnkcap);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 074b007dc2963..c5a6c6cba4da0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -808,7 +808,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 
 	pci_host_common_link_train_delay(pci->max_link_speed);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
 	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
@@ -846,7 +846,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 {
 	u32 cap, ctrl2;
 	enum pci_bus_speed link_speed;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u16 ctrl2_speed;
 
 	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
@@ -881,7 +881,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 {
-	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 cap = dw_pcie_get_pcie_cap(pci);
 	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 
 	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
@@ -927,7 +927,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	dw_pcie_writel_dbi(pci, PORT_LINK_CTRL, plc);
 	dw_pcie_writel_dbi(pci, LINK_WIDTH_SPEED_CTRL, lwsc);
 
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap = dw_pcie_get_pcie_cap(pci);
 	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_MLW, &lnkcap, num_lanes);
 	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
-- 
2.43.0


