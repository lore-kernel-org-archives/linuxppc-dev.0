Return-Path: <linuxppc-dev+bounces-24516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D35C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:12:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVf6Z51z3c2V;
	Tue, 21 Jul 2026 01:11:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560266;
	cv=none; b=naBEMKTLJuyBsP+H45/hm5ceSdM8ODHERLzAzN1tL1LthzaoW7Ux7k8tXNQpjG0H5ATmXDvWAQBFtttEiIEmIUAQSTx70HcxbXTtzjBa9ueInq67Il5VreQaU+wtGPXS5vZJHL5mi02sR7GtjcWdfz88M6olPJDpGA0E8jyLucnbOyZCEecreLabdfSdoB+rQBwCIJjNiWJIeN52Pzol9hSTtoDpH7QHa7Hh4tlkUY1Fs1qY/9PTrkceD+jgcYlp9tR+/dST/2CjMQSsLaXAEMKzDvqpzejJl5wuM9fVxbq2TOD5l9YM+do6XuPcUZ8173QmwyATNlAQPQP8xpO60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560266; c=relaxed/relaxed;
	bh=rbJVHVOturhJVseaFdgCutzkTWzNq56ytxEmv63ILZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4fhZkte9RJPnUi1jUtl2hbA0WkRYC3+2mo0Sbujds+6Ss088J21Wz9K09DZEGHPFPtssU2uOCvAdttUCpGSuEBcTOcEiEg/ifHyXaBoJjVpdzTUkisBL36E1afTqYsPfbAD4YR1PQxGegfzMg1zHjzAcxdrvRbNRJeJFxIWHSa0vs6g44rxtUvKEyMtiV1jBrmXBdtGJSRyQ7HBIV1Mchs+PZR0WrEpYBmG3k9juk8nsZUTo7Dx/rJOK2jB+5ufLRqbkk5f/sFyXth/+lUSRED2ngzv7KPphKAtKDYiDjZoy6G0lcXrEFltqlk37eY0HNCvMYBeVJaXx5LVCJuqvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GF+PwHNR; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GF+PwHNR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVS5nkyz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rb
	JVHVOturhJVseaFdgCutzkTWzNq56ytxEmv63ILZM=; b=GF+PwHNR5pTt4PDsWs
	T0s0PiiqjMWesPjJyyiowX5dFZfrnnirwrFYBQhSP0lrzpNSqY6cgjdv2QOJuIqq
	tIl5UUx1O9sm7a+L/BKoT/KuyihjJDqUqhlhhH1t+I8P1+BJiEsvrNc6nopIbVDj
	DvRKjT+EbgW3o8RLRY00CQ7rE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S7;
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
Subject: [PATCH v3 13/16] PCI: dwc: spacemit-k1: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:16 +0800
Message-Id: <20260720150619.24733-14-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1fWF1UGr15JF4rXr1kZrb_yoWkCrgE9F
	y3Jan7JrW5Cr90k3Zayw1aqr9Yy3y7X3W09a1ftF98Z3Z2qw1YgryDZFWkAa1UGrs7Xryf
	Gw1qvF1rC3yUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNVbytUUUUU==
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBC0WGpeOdAGWwAA34

Because .init runs before core caching, we call dw_pcie_get_pcie_cap()
inside k1_pcie_disable_aspm_l1() to get the capability base, then add
PCI_EXP_LNKCAP. Hardware is already enabled at this point.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-spacemit-k1, the call chain is:

  static const struct dw_pcie_host_ops k1_pcie_host_ops = {
    .init = k1_pcie_init,
  };
  k1_pcie_init()
    -> k1_pcie_disable_aspm_l1()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 04241df8fd59..3e741324f44a 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -116,7 +116,7 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	u8 offset;
 	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	offset += PCI_EXP_LNKCAP;
 
 	dw_pcie_dbi_ro_wr_en(pci);
-- 
2.34.1


