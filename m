Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C44606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ntWlrT6R
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjq3ryqz3bcr;
	Wed, 28 Oct 2026 14:07:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156863;
	cv=none; b=R7ffQKS3HH+xe+VJNkRz5/FgWfXnjiPIgtNNgSYP6wsOZ3Q3NQT1uBOUsQwxhh7G86b7WFmh+A2pygvZO8s61+aR3OevtFk93GoykcjoiGY9XyfTs7n1nXnimzjVmSQQasB496eyo+tAgWfmRaLpzC6FDypTkp1hDlz3F+AJVxk6Q1wx0Z/cQk/mGhAaK8xytqAnNzLLxPU2kgOgm65FWAIU4CPQsF3t0Lv11gTrpigwxcRrzNhrTfhLZ4ITmyXjVojzOsXPKsQnsNwUfvOPnzc2CkUi5a8QY+sdwQOsGX131sqsF0Jcxe4vx06aoP74G8OYr1PRzRF7P4O2H/J5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156863; c=relaxed/relaxed;
	bh=tIbcK9QjGE9c4lpPc7mfj5ekNF6tijyVodhkpLjG8sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnTBNKpIbIaDDDQDe3swh23N6zqtOc+3fFV9rbgu5yffgNc9RfBslgOBWbSjDLB45a23KLBZqjhEEXiCqozLkXpU4YtfQmBeVHIqnhRtrIClYUnSim9qpZIV8ux0IV9VF2HjG+sZv0nvjVtEgB2FNkoNEDTEq+A0QZ4DCaLdxAEI/QzE8+Djs/kU5hRbVMq7ZK2KT/55QvDVhvpMmjDZastfufLteZHupBDlHmHEOviMICRPwEYxG+OSdxxK7vKd6zYXsmjqgFA/sCXlAF/wVtrxDbWSspARFJvjxIqs0LhsXYaYv8gU1wHYQ9Tr6p+KMnXhZ0cQ+ZdAH5llqfZLaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ntWlrT6R; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ntWlrT6R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjk2kjxz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tI
	bcK9QjGE9c4lpPc7mfj5ekNF6tijyVodhkpLjG8sQ=; b=ntWlrT6RoX39yXz/iz
	soOJfC3ZjqPIOY9BC7rCiihN+Sx0E8bdQeKbCipvfVhYucPlj5BKbE8uRXngQdxH
	VrPPc4aAqWYvJBuslL+Q9zmHFU1XaHFhpMbSljPOwF8e5hWPyNLK3RWGkwU0XW/k
	de8OUC/uSB085wBRFkveHKwKM=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S5;
	Wed, 28 Oct 2026 11:07:12 +0800 (CST)
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
Subject: [PATCH v5 11/16] PCI: dwc: qcom: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:47 +0800
Message-ID: <20261028030652.2917756-12-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry3GrWfWr18CFW3ZFyxZrb_yoW5KFy5p3
	yYvrn0kF4UJrZ7WFn2yFZ3Xr1avrn8ArW7CayxK34aqFy3tryUGa1jyrySyFn3CFZ2kFy7
	Gr1Utr17Wan5Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziDPEhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wDkiGrhZuDG+wAA33
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) users in the
Qualcomm host driver to dw_pcie_get_pcie_cap():

  qcom_pcie_clear_aspm_l0s()
  qcom_pcie_set_slot_cap()
  qcom_pcie_post_init_2_3_3()
  qcom_pcie_post_init_2_9_0()
  qcom_pcie_link_up()
  qcom_pcie_icc_opp_update()

Note that the .post_init callbacks of struct qcom_pcie_ops run from
qcom_pcie_host_init() before qcom_pcie_clear_aspm_l0s(), so relying on
that function to populate the cache would have left the offset
uninitialized for them. Doing the lazy lookup inside each function
makes the ordering irrelevant: the capability is searched exactly where
the register is accessed, i.e. where the open coded
dw_pcie_find_capability() call used to be, and every one of these paths
runs after qcom_pcie_init_*() has enabled clocks, resets and power.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d903f10211c23..dfd2d10414ec9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -379,13 +379,13 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-	u16 offset;
+	u8 offset;
 	u32 val;
 
 	if (!pcie->cfg->no_l0s)
 		return;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -398,7 +398,7 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 
 static void qcom_pcie_set_slot_cap(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	dw_pcie_dbi_ro_wr_en(pci);
@@ -998,7 +998,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	/* Force PHY out of lowest power state */
@@ -1362,7 +1362,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 	int i;
 
@@ -1410,7 +1410,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 
 static bool qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
@@ -1785,14 +1785,15 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 
 static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
-	u32 offset, status, width, speed;
+	u8 offset;
+	u32 status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
 	struct dev_pm_opp_key key = {};
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	/* Only update constraints if link is up. */
-- 
2.43.0


