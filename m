Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E410606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GoamCqJY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjp1PYgz3bWX;
	Wed, 28 Oct 2026 14:07:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156862;
	cv=none; b=nexDW+l/IwIuX25aTUbD30snBzRBsDFKJ5sarEeYkzj/mEGTRaV/cDdsPDdQuo67n8xpJca98laiOlSF+wYZSx2MRrI8BZHvorkTH1U7nv9qkcvS7skELhFMMYENFPRGxNsRr4BJCxyOqn1r7sDGZVZvDgOcWJjEpQ5540hsDpPraBVYKszaNejJ+ClX3dYD1B+ARBjr29xMuSVGbbOcubZROh8gnAY/GF9JwTdNmyQN8qemtv0Fm5G0XY5/kTBRLS3lV2r72Biu7t4uq4iX3zy4k2HsC+BFTX7SuCVB5ZfbxVawxii96M36J+MzDmuOBL52HSC/tee8ILTalqglTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156862; c=relaxed/relaxed;
	bh=o/IRs6JzA5LFZdnsRQ+spSM1tkDMabFMzmbDWv96JLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNDz/OTEO+dz0kjuxjGZXkqhpoZmEfrZ6FXI7KhO8vndt4clAsO+SJy09UBw71aXsg+78LiinQZs3yCsh45tYB0YP2OpMKT74WYKCoKG7IdnRUiy2437wHfFK8GtKPQljhquYxdVhbPivczW10CA5Rf69YBrbbO+PC3Gfl+KkzzyNGHNnDxWCMMD2TxlL42sLTHvxSVjqCxGZPKW/SXb6fIFsgo3mW/ngdWkILr+vyiCmcw+X3pQ3vPdIylV7vCe2YimL4oh6qJeUHoirTBMxWvz33m5EdnJy+4yjdwyOCABm+QK+xjhTvb3UiAV/0RC5WoouegtC73htw1Wu9qv1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GoamCqJY; dkim-atps=neutral; spf=pass (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GoamCqJY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjl3FCgz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=o/
	IRs6JzA5LFZdnsRQ+spSM1tkDMabFMzmbDWv96JLM=; b=GoamCqJYHM933HGiPB
	ypqZ4tGSvn84jILo/LfRPAfsqKV6PV5Hx3NHfKM/w6HK7jxgOIIvp7LSh84gwXrq
	Rq4DKgtb7JLCSIVjAyF+LeMLqoC2SzYmXA7UyCc9mxN2wpviFAIe70HvX5D0g//8
	oVFzf2KK8i5Zm3x0LwBuvvfhc=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S6;
	Wed, 28 Oct 2026 11:07:13 +0800 (CST)
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
Subject: [PATCH v5 12/16] PCI: dwc: sophgo: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:48 +0800
Message-ID: <20261028030652.2917756-13-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW8tFy8Cry5CF1DZr4DXFb_yoWDWwbE9r
	9rCFZ7ArWUCry5K3ZFyw4rXr90va47ZF1j9ay8tF90vFn7Zw18tr9rZrZ8A3W8Gr1DJF97
	Jr1qyF1rArW7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM89NtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wHkiGrhZuHHSwAA3G
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
index 044088898819e..39703d2b7b5f2 100644
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


