Return-Path: <linuxppc-dev+bounces-24507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F59C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVX2cQkz308Q;
	Tue, 21 Jul 2026 01:11:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560260;
	cv=none; b=M9zCYHSA4AtMEw6NWa1bbRLJLZxkmtnPCnBhd/89MZLxmqPksRVFCyVgXzqHAJj7+C1+ASwZoH6C97paxLgIwU4I4pZpnNe/0DK4LuQY+5B+Tlo+SoTg82DSE73FgEJeGBggb598ElTqHZKWVd2JyBXgb2KNmWvdPR4HT01By1GreZiscj3/HnOSSrV1vruwRegxsZRpeY6LSTPUMVmUEsj7xbDQY0xRr/Eucwby5o/EqdOPMFwQXGVJWBznw2tuKkJmaa0/uRipH8CkbDSAWRBneU1P2dQ19CIiGi2vQMD2tKPshNPWA0XT76L79CQzWCRvO/qHEja/+lSpIn214w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560260; c=relaxed/relaxed;
	bh=/iOTdtu/aTwGdJUNHIqJwX0fu5L6Cd4Ns7bFgW3B/CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAelYKBO3txOGPFuDIx0OLCIjlV8wfCu+/nSvsgg3KkS4Z73c66s/gcLvptpIDdlGQkhZCZxP2LoE7O+Lovu9bUvTIormSP+t1BRMmATW+6MQI2oAccEFuvS7rH3e1mrnDMGsPflvdWAWHB13DRwuAFFfL2X3g4GNEQ6ZuqxOTpJe4CcC1Es2MrPnmsGWKUa3DJEdDfFEaJmcJ29ffm4I5k2jcn8SIcZFsvy8aWCx5DOvEYGhdQBSfPkGgHumaCuR7Y2DhdVxgg8ZhHUyBHvigImLki5X5Nu3rnvwzy/D7NZV2LOFDNIPwJ1CqlUGUrL3kbsezVBq8l9xu/zZL+TeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=p5auUxhn; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=p5auUxhn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVQ14M1z2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/i
	OTdtu/aTwGdJUNHIqJwX0fu5L6Cd4Ns7bFgW3B/CE=; b=p5auUxhnEfBNES3fQG
	/5lF37QXLQgFIFFyWudRnnYGV60U57RN3sj6TCtJPX4ApgYAU3FmWt7m0eVmv/rn
	3q88jJs/6ELE9CYOkItHihO1HRuJRwJ5PIQR5RxfJhBgzyRQ2b04o3yH85Jyzema
	diLdDoIf3bPZ3EEr6o8wmxNr0=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S8;
	Mon, 20 Jul 2026 23:08:00 +0800 (CST)
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
Subject: [PATCH v3 14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:17 +0800
Message-Id: <20260720150619.24733-15-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1DKr1kCFyruF4ftrW8Zwb_yoW8JF1rpa
	9xXry2yF1rJr4aqr42v3Z8Xr15t3s8urWqq39akw1SvF17CryUtrW5t34YyF13WFWqyry3
	Kr1Uta4xWF98Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9a9hUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBG0WGpeOdEGcgAA3R

Inside .init we must call dw_pcie_get_pcie_cap() to obtain the offset,
because the core has not yet cached it. The hardware is already enabled
by the driver's own initialization before this point.
Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-spear13xx, the call chain is:

  static const struct dw_pcie_host_ops spear13xx_pcie_host_ops = {
    .init = spear13xx_pcie_host_init,
  };
  spear13xx_pcie_host_init()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 01794a9d3ad2..6e4c11b497d4 100644
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
2.34.1


