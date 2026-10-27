Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C0606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BS8ockxB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVGs0vtxz30BJ;
	Tue, 27 Oct 2026 23:31:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104293;
	cv=none; b=eGJdIT8NPrZoY05lyUZFofoMlMpoSeff99Fa4DFylhEPE7JKPRgJcFd1Y3ErroL297GKpssvxVVXh0JrK73sDbm0mYbfc5jAHXmZ2etSG4xG3EtlFIFHlZDaQjkcHNpwFj74zCE3qqNlf9SViuTe3ZjAKpzCozhr0DVD8O/DRUMSp8VnKEvcqjOokYb4eI8LYzFQU3XNC4bRQuJ/stlmqckk8ARJxwXlnvemia+UG5z26FmDQYLTsjrVtcXPQAgvHWB8gVXZfX0Eq4nLeeHZ0AfdPcnfQP9Oygz9xlDHI35CcuQv4w6DZKIRbUcPCGLpdgSFJZqs7p5070bnDcGMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104293; c=relaxed/relaxed;
	bh=C8BtL4WHZEYvTyOrvB3s5kHvzLx9kujDt8bs3NHTAwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3hJMTgg1zNuedzJX4Fo81Crl5BF6PJAkwDyWF6CPXLKSSI0/P/9ScTYAtlsePP37CzkqemV2NiuswNt7aJNgwJ58eboT0QfkYPq/2f2WP91ml7q6d82wc5EmQJ4aCHYWgAi6EGR/V8hB8ZKcepuKHB+tHqrv5zmORrzpaauYVH471jLMxrg8IsYnPqScgxwLyMLTUWjx5F0fjFxcKAA5NAlWtnad1QHVzTkKrI/dTA5haydQVeJy7lAxJcHnXZR2NV5OVaryr89dnrrdNrYOA+bcAWMh0yCIwn22Sivh5VncobPH8ypqhoRHpo+z8CLU16P1ESFnZOITfhx69Ingg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BS8ockxB; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BS8ockxB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVGp1qJSz2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:31:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C8
	BtL4WHZEYvTyOrvB3s5kHvzLx9kujDt8bs3NHTAwA=; b=BS8ockxBgj9gcy+xdB
	S33DdiFaHGWtXwxynQe6OoE+d6YHUEHHmC14Syz6JvvInhcBO5+vBhSUlsrn0akI
	JlrtBtBz3C+7zI3yxpE7GW5zXxM4R5XhbNefv/I2g3CrYF4b1il88bkSvXGWPD9o
	WJaus/XNJtjpC1AVoLw8WuvGQ=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S3;
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
Subject: [PATCH v4 01/16] PCI: dwc: Add pcie_cap field and caching helper
Date: Tue, 27 Oct 2026 20:28:12 +0800
Message-ID: <20261027122827.2725643-2-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xCr4UZFW3KFW7Zw17GFg_yoWrJF4xpa
	y3JF1SyFs8JFWSva13Aa1SgFy3Aas5ArW7Ja93Gw1fZw13ur1UKF10yry5tF17Gr4Iqr12
	gr45ta48CFn8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEs2-8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BE12GrgmPEX2AAA38
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DWC PCIe core and its platform drivers repeatedly call
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
PCI Express Capability structure. Besides being verbose, that performs a
DBI read every time, including in paths that run repeatedly such as link
up polling, suspend/resume and interrupt handlers.

Add a pcie_cap field to struct dw_pcie and a helper
dw_pcie_get_pcie_cap() that performs the lookup on first use and caches
the result for the subsequent calls.

The lookup is deliberately done lazily, at the first place that needs the
offset, instead of at a fixed point during controller initialization.
This guarantees that the DBI read happens exactly when the open coded
dw_pcie_find_capability() call it replaces used to happen, so no DBI
access can be made before the controller clocks, resets and power are
enabled. This matters for endpoint controllers such as qcom-ep and
tegra194, where DBI is only accessible after PERST# is deasserted, and it
also means platform drivers do not have to call the helper from a
specific callback at the right time.

The cached value is accessed with READ_ONCE()/WRITE_ONCE(), because the
first lookup may be triggered from different contexts, for example the
qcom-ep global IRQ and PERST# IRQ handlers. A concurrent lookup stores
the same value, so this race is benign.

A return value of 0 means that the capability is not present. This
cannot happen on real DWC hardware, where the PCI Express Capability is
mandatory, so a negative result is not cached separately: it only causes
the search to be repeated, which does not affect correctness.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae940924..fa31e8b763bc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -592,6 +592,8 @@ struct dw_pcie {
 	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
+
+	u8			pcie_cap;	/* Offset of PCI_CAP_ID_EXP */
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -830,6 +832,38 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+/**
+ * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
+ * @pci: DWC instance
+ *
+ * The offset of the PCI Express Capability structure is read once from
+ * the DBI configuration space on the first call and cached in
+ * @pci->pcie_cap for the subsequent ones.
+ *
+ * The lookup is done lazily at the first place that actually needs the
+ * offset, so the DBI read happens exactly when it used to happen before
+ * caching was introduced, i.e. never before the controller's clocks,
+ * resets and power are enabled.
+ *
+ * DWC PCIe controllers always implement the PCI Express Capability, so a
+ * return value of 0 means that the hardware is not usable. Callers that
+ * check the returned offset keep working, and the (never expected)
+ * lookup is simply repeated on the next call.
+ *
+ * Return: the cached offset, or 0 if the capability is not present.
+ */
+static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
+{
+	u8 cap = READ_ONCE(pci->pcie_cap);
+
+	if (!cap) {
+		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		WRITE_ONCE(pci->pcie_cap, cap);
+	}
+
+	return cap;
+}
+
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
 {
 	if (pci->ops && pci->ops->start_link)
-- 
2.43.0


