Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF3606B243
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QKekTN4t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVGr2SWDz2ySC;
	Tue, 27 Oct 2026 23:31:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104292;
	cv=none; b=LwSXjbkO8aN09I/9w/A2+82SLN1wK/WgCvJbzl9W7DIKQF/9XR/OMaLjcrJDhQcztD42+La5IwPFZmdKGBz09jAF3gXUj3dkkSCdhTyvaalJB9/18on1djmYBOZea/uipGopzHVYJeyStP2tUZfzlfS3H3PKCENpL8+MTECNj3JTelCdrrpBYxr/wkRa09MsNW3kofLVHcNO/+clQTzOkLbpJkcFC0i7rmCcubtUaxfmklBAbz0KgO5JBYiH3qQjZ2SId/EtuBojvszx0cUcH6vstnigyz/6ehF2YiaGjc3QYj4ShpsxfbSgNTmZOkQUFHJqJSigMqdc8F+asVXGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104292; c=relaxed/relaxed;
	bh=P+DOek8Xwg8mr7X23MpvL+sXMtJB3TD1T1b5Qii+fWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfDoMGsdJ0ZxIhrEeuPV2xO3yxOMXjxcO8pbj3vla/1JxZFWCHLcp61VEPNzhXajGoTkuVMclbnqLweqY8hgteb67qkKJjmjBqJ8EaYoekDD86O8XzgUqpKvIyCz7OVP8twWX4mJJVhLvVapDMxACsiVUxmKGobBQ8rLKJ7QsBgmMomVasoISWouHG1TwfC5Y5PBA3eRjES8HMAfWQw915goxR0g8EhumYEb3nfsbzisfR9vKn8NCpblfI2heHu6wTDzEbjjH5w5vrOkjA1MjcRWbtmsEKqjc7S2R+1WWF9KHNEolaUCeA9l1qc9dBuyOynj7uhwX1mGGtIpsPOy+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QKekTN4t; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QKekTN4t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVGp1S8Qz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:31:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=P+
	DOek8Xwg8mr7X23MpvL+sXMtJB3TD1T1b5Qii+fWc=; b=QKekTN4tJdi67oKu9j
	LRsqgdFXZd7kF1vm5qva+c7fRRqBpySbrVj7LJK3nKBnmBcwYJOW16NNe0vcfPpz
	yYpGoE07/S2RyPAd7BQs+1Hd2wXWMGKT6s5OyEDFu+GkMbKfhsKCAFfQPRkmDHLM
	o3ohd1bt9LWQsKqZBS/hrIu7g=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S7;
	Tue, 27 Oct 2026 20:28:36 +0800 (CST)
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
Subject: [PATCH v4 05/16] PCI: dwc: meson: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:16 +0800
Message-ID: <20261027122827.2725643-6-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyrtr45Xw1kZr4rZFyxXwb_yoW8WF1fpr
	WYgF4Fkr1rAr4YgwsFka1ruFy3Jas8ArW7Ja9xKw1S9Fy7KanrGa4akFWSka4xWFsF9F1q
	9Fn8tryUZws5JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piQtx-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xQ22WrgmPQX+QAA3Y
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
meson_set_max_payload() and meson_set_max_rd_req_size() with
dw_pcie_get_pcie_cap() and store the offset in a u8, which is the type
used everywhere else for a capability offset.

Both functions are called from meson_pcie_host_init(), which runs after
the controller clocks and resets have been enabled, so the first lookup
happens exactly where the open coded search used to happen.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 8559d132dcde..03dd1282f3f3 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -277,7 +277,7 @@ static void meson_set_max_payload(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
 	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	int max_payload_size = meson_size_to_payload(mp, size);
 
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
@@ -293,7 +293,7 @@ static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
 	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	int max_rd_req_size = meson_size_to_payload(mp, size);
 
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-- 
2.43.0


