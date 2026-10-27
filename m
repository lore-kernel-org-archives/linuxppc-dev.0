Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92719606A322
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ie8Q0fCu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVGy60v8z30NF;
	Tue, 27 Oct 2026 23:31:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104298;
	cv=none; b=HqU1dJ1RFQ4qj7E68llcTtIRZojzdHnMHDRYnrqBvTxks4T8bT+zcHw9+ANCoJsA6H25lZPxqm+g6GD1NGt3uvrD+4TLCKZrmZEkzXKcxsAPnXcJzIHh+Bm3D2ofTDQrWi7rPtntfXrf05Be9H4EObhciALT7J65Lv8LLED1RLUpk75DNZFwF653YI1LU1NHrDN9ddgLBSZsjyS/rPahTfNrVseyP/1Z5OgGneEMuq4X2WSp3klZUg60b5FUMNSValq+yFWtBFOVI1aQP+OyJ3jmZt7M1mVl0DvihvYCmmidomblsWU0VgLtdxh0+Yj65odWsMHH6oIHtKTl76SGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104298; c=relaxed/relaxed;
	bh=5rTEfJyH8+8TFmlvfs8UtpwLKWhfbVwPgm8PGgqTxGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5rtFEUW4aEK2Y5j3m6l/EnlnP4UkhZBXSVQwmMQPnGRAKBfU/MAOquSU6a9faZ2RsLGXytOqp+NE+WFMsc0b9Nva83mNu0m+vlbpLMiou8XvHxs+U/PkXwWH0h70Tw+Geg6L1p+vwI5PR8iQtG7PR1Q5ovwodGivOyv87drNCSEdCO692eQmpKj1Y1YnjzbwPtBRRarptbbHvbTa3bf56jbvmRFxFmW7r5k/krkj+2GAqfDcTNTk/BoxFr8PzCn0qXva4ODbgdMX/4dEjcGMStlnYBNVLBVb4Sc/9bBa8o8nHWErhDmrK5gAed1ie08BnNPjX957ycgKOEdZkV9wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ie8Q0fCu; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ie8Q0fCu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVGx36X3z3bVh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:31:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5r
	TEfJyH8+8TFmlvfs8UtpwLKWhfbVwPgm8PGgqTxGU=; b=ie8Q0fCuq74BxlHMKN
	rqVQbExiWDMoqUzfp8O3Y/hWetwXPiAFKAyLO7FSIdPsoisDrRl7PnIb2yafKVk3
	DbNld+Q7sGWlFp+SoTnJwMlWHEZm6yZ/CQkjgXae2uC+mH2aUYyoRXtP7kZskJqB
	qEm607T+lG8JRwT/TzissUwC4=
Received: from Precision-7960.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAH_5wFmeBq67qCCQ--.31668S2;
	Tue, 27 Oct 2026 20:28:53 +0800 (CST)
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
Subject: [PATCH v4 16/16] PCI: dwc: ultrarisc: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:27 +0800
Message-ID: <20261027122827.2725643-17-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgAH_5wFmeBq67qCCQ--.31668S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr18Aw1UZr1xJrykur4rKrg_yoW8JFykpa
	yaqr1YyF1ktr4Yyan2ka4DWFy2qFnxAryDJan7Kr13ZFy2krWUW34vka4FyFnrCF4UKryY
	k3yYyFW7Gas5Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFfOwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wY63WrgmQYa+AAA39
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ultrarisc_pcie_host_init() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap(). Since the lookup is performed lazily at the
point of use, the driver no longer depends on any earlier caching step
and the offset is always valid here.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 51e89180490d..85373b479b64 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -56,7 +56,7 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
 	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
 	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
 
-	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap_exp = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
 	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
 	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
-- 
2.43.0


