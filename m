Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AC606A31B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ql3fsKVv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVGs3v10z30DY;
	Tue, 27 Oct 2026 23:31:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104293;
	cv=none; b=QZX6lDt6o1mcDonWPYOfYCBd4IX6UxcFzeEXuB85sRDL3BefSEHSNfnCJeiu1m5vwZDiWfvLE7ekvbi58ZCRgU0vBnbVUYxEMTM0W9y4VfZxqLvgZhrdI2rhto27o596WtdegBYoUCxRArfmiHiKM+1JfwhPtsOm5p1qGw0kkY9/OmGrdydyLYLxIIh4WJGM7Pu9SzlecGIC0c8E3CpVRWUZaYdfk4YQ8EsuBb5TSGNow6e47eX9dCLS4ikaro9t6PoikevafYnF0CvoNcs8SVs7nF8qHEIdpvWga/OU3vAXLm48zy1DZi91rG73DZusgOqn4cSgIRzU9z+6VcCy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104293; c=relaxed/relaxed;
	bh=TdYceE7RRPUM62LOVxn/fHgK36xYRy4qKZfZkYwC3NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+MkR+xkFx/9BZ6aUgSTStwWRtaZV4JZWCWRd0U30UogSlTtYDD84SvPjsRW+3gfwRVluDuu/OCtMzXo16Qd5aVKILdvW00CXXiq36ehJyTR+tKyqiAMkZW7tjcSTNaKt6Ws+WrtoNEfgYQnsMYMQXpoNXi8Z8WvNhOSs9kS+6l9IooVhq/eetSFp6b1+Xvx45kAzK2NLjarIL2LHlUVYx0o/POUMxFKMUuzEOBcmG3xkipyUXwKPOyk/mGlGpIdt17Z/O2Yf8iC3z2bv3ilmV0/41x7YnEDAQmoMZXyQ4j7jhpYK7ydXUsL2VNIx92TE7beAXLUpi5JBFjSMzmBMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ql3fsKVv; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ql3fsKVv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVGq6Tbdz2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:31:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Td
	YceE7RRPUM62LOVxn/fHgK36xYRy4qKZfZkYwC3NA=; b=Ql3fsKVvhSIX7zUl8a
	qzihG3hTfydNTdF9wLL01uUMT1FV8wHgK2mWad0l/ETDV9U0UQx/eW5/86NZHCQQ
	1Eg3YQFEO91ulexQRqIUvmkBdlDFdJfrg7lFGqmkDXidKtizIFsgQ7mtGUSYxIQ8
	nwvaR5/DeNw/y5Elc1plFAl7A=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S6;
	Tue, 27 Oct 2026 20:28:46 +0800 (CST)
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
Subject: [PATCH v4 12/16] PCI: dwc: sophgo: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:23 +0800
Message-ID: <20261027122827.2725643-13-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW8tFy8Cry5CF1DZr4DXFb_yoWDWFgE9r
	9rCFZ7ArWUury5G3ZFyw4fXryqva47ZF1j9ay8tF90vFn7Zw18tr9rZrZ8A3W8Gr1DJF97
	Jr1qyF1rAry7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNuWltUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B8422rgmP8aZQAA3C
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sophgo_pcie_disable_l0s_l1() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap() and store the offset in a u8.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-sophgo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index 044088898819..39703d2b7b5f 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -164,9 +164,10 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
 static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u32 offset, val;
+	u8 offset;
+	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-- 
2.43.0


