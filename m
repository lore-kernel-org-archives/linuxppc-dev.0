Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A3606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IQAGmgt4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjp5HkBz3bb2;
	Wed, 28 Oct 2026 14:07:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156862;
	cv=none; b=WdSU1aIeex9KaUW2UF6uyVrgscR7J3on0vr4ZE1eIQWCXsZnmjzhv4dG1w/QjtF3cy888N4wIfm4LueqPDz0smytNWBXKZPztQrkRppudbwV6JtWWvPUJw5ecVWlqrjAVIDjXrXwQLYctU0bu5CZi/VxIN1DdXf6aHT4tM2SAaBtKij/8kXW3LJAKRmdGBNL+rYZGeKnUW1oO2H29LJa5wmmeLF0E8iuxha2cp2FK6dECr3MnlLCj/WPNhcMkGjMK6iQR1gU5hSsRXSwNRInLln+IDpmILmCe6n8EQdoEIGTidHCHeza19QJ0TcxTqOcwTQHVOpADU/PbYYjZdJE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156862; c=relaxed/relaxed;
	bh=lAmxH5StbC92YG4VwJJRjtxwLxu+DmfhuOFV/GCQrHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQeUjyeuBAl9+uAJHi4e8sdSUh4TC5bxlMJifSl2wL9S2nkLcTqb//iJHlUL7/XCGu7GIjOeNzK1kOBOveTzaY47TOyc0wxGRY6lCRNg5rKa7Pdu5SjEOvwS4RPHKSH86pO9FAt7WtfyIy3JAqWZ8nBV52hp8MYUNV4QeadbYJ8QyVFfwX7YMaL/zJp7w9oDV8RWraD1DNXUyBCKPe7iGaGhQaAzx0XIMJXB2FzxNrPqA5450oVeTjyzhTGMcteo9dDImCY9y3xkmeJ42cTa1fy6pGh0yuKXNYtK5gBMUvnSH0LaMNforAfMobuvlEwaVCKFgtNKebBwKIWF5rJyAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IQAGmgt4; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IQAGmgt4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjk5c88z30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lA
	mxH5StbC92YG4VwJJRjtxwLxu+DmfhuOFV/GCQrHU=; b=IQAGmgt4PNZWbso6+V
	pffK2rsO3R0sJtHr69fYShXhUdAZQYnX+4I+/tJXe36UNjjKRCZS8pASyZkOJqZw
	5wAgwiIxCroZtGVTERPriDLYCOVguaN84E1UpII75b3Y/1GlQdZMPZiBlolV1mrd
	meokRbdBJrzjJFIhQr1h7lQwk=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S8;
	Wed, 28 Oct 2026 11:07:15 +0800 (CST)
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
Subject: [PATCH v5 14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:50 +0800
Message-ID: <20261028030652.2917756-15-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S8
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17Zr17XFWkuFW5ZF47Jwb_yoWDCFXE93
	s8WFnrAr4UGFy5GFnFyryrXryYva4fWw1jga9aqFZxAFn7Xw1kWr92qrZrAF95Cr1DXF97
	Jr1qvF4rJ3y8KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM89NtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7APkiGrhZuPTEwAA3N
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

spear13xx_pcie_host_init() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap() and store the offset in a u8.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 01794a9d3ad29..6e4c11b497d45 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -122,7 +122,7 @@ static int spear13xx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
-	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 exp_cap_off = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
-- 
2.43.0


