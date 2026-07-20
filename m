Return-Path: <linuxppc-dev+bounces-24515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C10AC4452B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVd47bNz3byT;
	Tue, 21 Jul 2026 01:11:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560264;
	cv=none; b=ZsbboYt5MPE/PnxbrvkFBlJ2uNHUphLl/0VIceRS4BlukhIunH83Uh84zgti1jkvv8uDFBQSKuCcV3eZnf2Uuj3VMqJ8bBqM5b2LI5GgG0PDkSAdZF2Dt9s+Dj5kISEHCteDRRdWEfVMo4aiyOc8++CSX8igFP375CgwgVZV/Fe1zBdRcwsKqh6ZHp7dKkRgljtv009+cX70AJuv3p/21Di2/1nhVwCZ59oc/YNo6z0KDM63W2THXlx0d1E4qoNYCoVW21ghitCMrey0L6uFtwuElB0Zyw8C32spJ5MVaI/BTuH/nyNpiTYuMNXRfpZgatvgsH3/w1vs/Df6BdswPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560264; c=relaxed/relaxed;
	bh=sq5n5May5plZP321RlYIM0qj1KqVpHN9549zyN1aNPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=amHEeEMoltj/G+luF4JfC2JYbwVQcjov+qYwlx8h3yl5HvWq1iLyUKvHQZTjU0qHKW0JxIIpQ8DV9YcK2SPxL3E9KeUgeWmUOTfUAvzf/e8iPmK68GzuLAkLYu5YocRyCqthVGObxwflpKCYx/YweAakb3oipiwcM+TLoD5kQlo21+Svzx2mt1hgnbFFd5VMFkTi1YKk0Rm8Wr3ikqQo4ZxhiGHDaEEUTH5CYxGgBns80PJYvJVEKFg0fe0/R5A+ViUrMrG3eRJMPZPzIpD6lmK4q0mI+jyLbDRhwzlQ8bMEYrV66tPk56k07bHvV20gEw9IGygQUgpd1JVFn4Qyzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aO3MFWV9; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aO3MFWV9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 145 seconds by postgrey-1.37 at boromir; Tue, 21 Jul 2026 01:10:54 AEST
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVQ0XsYz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sq
	5n5May5plZP321RlYIM0qj1KqVpHN9549zyN1aNPQ=; b=aO3MFWV9XIa4ABdZgE
	Hlnwa0G0y0jJsfMsU+rQWsAwNfdEQSRYyiF/0lG020ZdM1GUb2xHquff0SkSItpS
	n87eoGNP4gxWufaDI0dGAfmPZRd3iUPaWS2n7tJhD9P+/pRDRXpNGj7rHOOOhjXO
	Cpk0uPrOoe+twSKXp/RvlYGtk=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S7;
	Mon, 20 Jul 2026 23:07:47 +0800 (CST)
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
Subject: [PATCH v3 05/16] PCI: dwc: meson: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:08 +0800
Message-Id: <20260720150619.24733-6-18255117159@163.com>
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
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy3CFyDGrWDZw47Jw1xGrg_yoW8AFWkpF
	WYgr4jyr18Ar4YgwnrCan8ZFy3Jas8Ar47Ja93Kw1SvFy2kFsrJ34ayFWYka4xWFW293Z8
	CFn8tryUZwn5trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyxR-UUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxASxVWpeOcQFUAAA34

dw_pcie_host_init() calls pp->ops->init (meson_pcie_host_init) before
caching the offset. Therefore, inside .init we must call
dw_pcie_get_pcie_cap() to obtain the offset (the helper will perform the
DBI read and cache the result). This is safe because the hardware is
already enabled by the driver's own initialization.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pci-meson, the call chain is:

  static const struct dw_pcie_host_ops meson_pcie_host_ops = {
    .init = meson_pcie_host_init,
  };
  meson_pcie_host_init()
    -> meson_set_max_payload()
      -> dw_pcie_find_capability()
    -> meson_set_max_rd_req_size()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pci-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 7a4da9fae1ea..c9d0388d262b 100644
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
2.34.1


