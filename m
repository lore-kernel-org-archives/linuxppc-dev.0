Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908260731C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pXPt6h9D
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjk5RnTz30Vf;
	Wed, 28 Oct 2026 14:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156858;
	cv=none; b=SONCNeK6wy7JxWxa8zx+siY9LgNik5OqMQN11d06z3jDjrvKGlHAq+4I8rLUSr3m9/AmPQfMXMAhjX8amHtpZ/O7AtjpzADrzgis33d19uKKMm3nmte89a9z0ci9OT5rWsLni7FFEWAPQMwx4dkygdDC75mN9LoDLPPhRUI25kTOqTelkjHA5LDDe4MUQ5jRsQd4VVqgpKoF/agSYxuDL70pMwWFap59voou9YO2QmjNyBEtCxNMnntsPTR60g0sQFvuzhEHNtz/fzER1HZcDcnemk1/Ml5UOSeLJ2hV23T9TiNp5P4GFtRSB0aYoUYYVMSAHp1iKf3N8zvV/DeYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156858; c=relaxed/relaxed;
	bh=nEXGdJC+nnnfnf7AnSlpph3oGrheAJvtJd7pKFwHRr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAHUe2sU4M4X6GzCRqcEkyOSVCpk/gRSZSS/VHk+RCPFMRh0Snd37mEJYbTR3AIbuXtUKfD4Kt0ZOh+Iw8kGQkRuadYRu+n0orawul0fIl3NnbHdK/V2VhhcyeiVjA6vqii7qX+vf9lbDz6ACSWpZc6O/Id5u33IPNYVqTOwq+QRHW9XPQjbDz551ME2wooUbOh0kpDRjycr9aXNYJv67ZfxRUzSM1Uh0mVBISTLvqAjjJzyTImKd9bFH3D4wq0ykSpz30NbmWBK0HKo45iI43rd8DeS9kL3UbMzlpXC/T8GQadH1GJVT2KFERzGoZvwdShLHJu/L29fvRGvaP5dYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pXPt6h9D; dkim-atps=neutral; spf=pass (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pXPt6h9D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjh1TL9z30FB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nE
	XGdJC+nnnfnf7AnSlpph3oGrheAJvtJd7pKFwHRr0=; b=pXPt6h9DTD65L8XFFv
	FHenj4yvv6zfOMSt0UAcropNQ2Vuy6ey5TGKfLnddVDEfQx1a2o8l+45u14kGY0f
	x6O2f+rzOETBMN16euOQU38LiEPYwMZXq2TffgpJOjBEE5LsIxdq6zk0DvgmRtBb
	4JqYUoxNF+BKnyy7mTu4KjLOc=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S4;
	Wed, 28 Oct 2026 11:07:11 +0800 (CST)
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
Subject: [PATCH v5 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:46 +0800
Message-ID: <20261028030652.2917756-11-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryxZrWxGrWfGFWrKw1ftFb_yoW5XFy3pa
	90qFWYyF18Jr48Xrs2ya1DXF13W3ZxAry7Ja97K34avF9F9w17Ka1jkryftrn7GFZ7KryU
	Grs5t34xu3WayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEveH-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B-jh2rhZt-R5QAA3R
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the three dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
the qcom-ep driver with dw_pcie_get_pcie_cap().

qcom_pcie_perst_deassert() is the point where the controller resources
have just been enabled and DBI becomes accessible, so the offset is
looked up and cached there. Both the L0s and the L1 exit latency are
then programmed using that same cached offset instead of walking the
capability list again.

qcom_pcie_ep_icc_update() may run from the global IRQ handler, which is
requested before the PERST# IRQ. The helper performs its lookup at that
point of use, i.e. exactly where the open coded search happened before,
so this change neither adds nor moves a DBI access and does not
introduce a new race with the PERST# handler.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e6afdc6198acc..3e2068f3fa117 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -308,14 +308,15 @@ static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
-	u32 offset, status;
+	u8 offset;
+	u32 status;
 	int speed, width;
 	int ret;
 
 	if (!pcie_ep->icc_mem)
 		return;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
@@ -398,7 +399,8 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
 	struct device *dev = pci->dev;
-	u32 val, offset;
+	u32 val;
+	u8 offset;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -493,13 +495,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_en(pci);
 
 	/* Set the L0s Exit Latency to 2us-4us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L0SEL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
 
 	/* Set the L1 Exit Latency to be 32us-64 us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L1EL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
-- 
2.43.0


