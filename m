Return-Path: <linuxppc-dev+bounces-20651-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC616CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 13:55:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCSF42cbcz2xqv;
	Sat, 09 May 2026 23:55:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778334952;
	cv=none; b=SJn2Fyf1j7YuQNmrMFOo8rflRGRNSy0tTZRV+lS8RIQaOt3sU6Mtow9U/0wwDiDuH/zpvl7S++0gRh68g+TxMeEOyDpLGGKLBF3+KyIfrYlKI/3lsTkt0zFCzBxn1ubGRzwwoc8sRyJtsRI3VOVCmlvK155KMdW5esl8DeXflGPWsSt4yuvddosZoYTq9/S7wgA4BKcaaP+wN3Q4uQQQaVAr1pmqiqO5w52sNZNR3kHIRY40VUnhPxUcv2sQ6PcYk9tG95/lMoJKZoW6CDgD2QGjzd37TF1IIJsGfYlYU/SMHFM5EukNijy6e7bsRNx1qh500Yyx71hE/33Qrv2wJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778334952; c=relaxed/relaxed;
	bh=LTH5VZR3wbji2shWxUMqCGICYtJFJYr1trTdG4CcqwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLVpRgxw6wfvHlw2sb9UdAXm/0BnHBx02xwumtjzWmDCSI9Bl2Z+ldiQnVi6emWuQyz/sdP2TL/+3L0TQxfI6ikhIyqFy8KEx5YemeDcL/Owd2GipIk3HdHd447yqG/DldxRPEidzqA71W9Z1364dLF23T0lXrV60c1NfeorDSOfhZ2Zenl/1BCS/RlxjXGoXlMO1CeMHuGL4p0gKONWsAuW2DCF+CE/x3JrZN4xcRCBt6uFsXvVY57OgKleY7fpCTUoon5kgWvVBTb6bor9MGTHxjJ6s/DtjOL13BpwA2V2WE5CPjPQ+dxgKxOGaTDssPYpYAo5dmhFz16GeMwcXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Au0TXh4Z; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Au0TXh4Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 132 seconds by postgrey-1.37 at boromir; Sat, 09 May 2026 23:55:49 AEST
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCSF16tl5z2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 23:55:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LT
	H5VZR3wbji2shWxUMqCGICYtJFJYr1trTdG4CcqwA=; b=Au0TXh4Zc5TrHQ8/OC
	ZGsjr7P+w0iJx7MFRGdSSw6hCgJdXQpdZ0P6Y9VbjenliJC6iKlJlWGUJ1DnFc4w
	wkbsjW1cHk13iEITJDfiJF57uzeZKGWEyUZeBxp7ACJMKSLEOyL/reQY/dEqBEyy
	IEkq33Cfj1mv6Tbny8VtbKYM0=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXLzL8O_9p486jAQ--.37610S3;
	Sat, 09 May 2026 21:51:58 +0800 (CST)
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
Subject: [PATCH 1/3] PCI: dwc: Add pcie_cap field and helper in designware header
Date: Sat,  9 May 2026 21:51:50 +0800
Message-Id: <20260509135152.2241235-2-18255117159@163.com>
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
X-CM-TRANSID:_____wDXLzL8O_9p486jAQ--.37610S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWxCF4kArWUWw4fGr1fXrb_yoW8Ww45pa
	y3JFySkF48AFWava13AanxZr15tas3ArW7Ga9rKw1SqF9xCFyUGa18AryYyF17Kr4Ikrya
	kw45t34rCFn8JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE3CzZUUUUU=
X-Originating-IP: [140.206.53.66]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxB5oDGn-O-4CewAA3U

Add a pcie_cap field to struct dw_pcie to store the offset of the
PCI Express Capability structure. Provide a helper dw_pcie_get_pcie_cap()
which performs the capability search on first call and caches the result.

This is a preparatory step for replacing repetitive capability searches
in both core and platform drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 3e69ef60165b..4baf7eb072eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -568,6 +568,8 @@ struct dw_pcie {
 	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
+
+	u8			pcie_cap;	/* PCIe capability offset */
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -805,6 +807,21 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+/**
+ * dw_pcie_get_pcie_cap() - Return cached PCIe Capability offset
+ * @pci: DWC instance
+ *
+ * Finds and caches the offset of PCI_CAP_ID_EXP on first call.
+ * Returns 0 if the capability is not present.
+ */
+static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
+{
+	if (!pci->pcie_cap)
+		pci->pcie_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	return pci->pcie_cap;
+}
+
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
 {
 	if (pci->ops && pci->ops->start_link)
-- 
2.34.1


