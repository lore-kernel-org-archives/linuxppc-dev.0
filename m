Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C7606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m351pkzC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVDJ1GY3z30C6;
	Tue, 27 Oct 2026 23:29:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104160;
	cv=none; b=gnZqqoZ90WmaRCh31zwP2OkY6GgDAo3NOcQJ9sYzSLkmRWvGTWigREx9IdJAqMAXA1s1PSu+sZs1SGQVUHWKNxWCice9hHBGR1TIs3x1t5zzeyl87XaqSm7v50WJPH79yEkeS+aHE80g8wvpars7fcuXiB+6FduNG8ZhIDouIpMnAb+mTIDJ8ocRc2270y440+U8JNPhzN3e66kY2RgCqAhlu7UZ07HiylEm7KuVPHzHlFOk1RlP+O/lP9zfdO/8UY3NNHE4vJaR+lYeTVJh3mKvJlUi66qGZQTev6kiZdbLsIjef1vI9aEjpXrh9Udea4tLhdFR7TzLj30LpX3LZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104160; c=relaxed/relaxed;
	bh=EsBtfIr5EUXQ3qF7d6IMuBZrNqiq4pV3HY493jPff14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9mCU3c0K24A2zcPZsLKgq8XYjOFQRNDzioHU3ijS/hCpTAvuDyBIDRddA/T2mVvAJdVlvaHcDn5/fu7YJaUmWH0zbXPzNQ5yG5nwIETIR9bXhcA5duW1C7jTk5p2BTQlFVzpNZhFOWIFJurjs+oQ4t1ALFNHkhUbkxmk6tf2msdLsmaNH/r1p9hYZrY2ziJYNKIZ1m+TcieM+nNhA4TSTS1lXeUPPThLlI2iPkwpDmLr4suZmnSrb9H+lTb26R7D0BaejXryfuJ3pE606X4vJKnAQ5rP+MRNvnZ9b7RpoZigM4Njzwmm9DFdbpiMCZ07AXzqB9iToMwqyqxWZ5v7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m351pkzC; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m351pkzC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVDC3hMLz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:29:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Es
	BtfIr5EUXQ3qF7d6IMuBZrNqiq4pV3HY493jPff14=; b=m351pkzCgssz/DX0pY
	xpsMvLCUrrSPCcOs3tWTUl5KcRaXs23UG/WLDZoevmyBmCf503yCpxGvEdCdOmng
	I04rmsLBgcj9RXWsac6py8GSg670JVKuSbhZK3OD8fifMh/KwALDzYrh17+DL2fo
	QOh1tOkJJjOCSAL1lxIzVcKFk=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S5;
	Tue, 27 Oct 2026 20:28:45 +0800 (CST)
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
Subject: [PATCH v4 11/16] PCI: dwc: qcom: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:22 +0800
Message-ID: <20261027122827.2725643-12-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryxKryxKw17Xr4ktryfXrb_yoW5KFyUp3
	yYvFn0kFn8JrZ7Wrn2yFZ3Xr1avrn8ArW7AayxK34aqFy3tryUGa1jyrySyFn3CFZ2kFy7
	Gr1jqr1UW3Z5Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziyCJ9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x0422rgmP0ZsgAA3R
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
index b58a607b713f..cec36c989a88 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -359,13 +359,13 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
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
 
@@ -378,7 +378,7 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 
 static void qcom_pcie_set_slot_cap(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	dw_pcie_dbi_ro_wr_en(pci);
@@ -959,7 +959,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	/* Force PHY out of lowest power state */
@@ -1281,7 +1281,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 	int i;
 
@@ -1327,7 +1327,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 
 static bool qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
@@ -1690,14 +1690,15 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 
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


