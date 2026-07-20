Return-Path: <linuxppc-dev+bounces-24506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EEAC4452B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVV0bydz2yfD;
	Tue, 21 Jul 2026 01:10:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560257;
	cv=none; b=jRZDAmChpPO0zBc+gY7NN4baA2CTApSgkcvfIy26Cgn7l2BHqMF5Wk4weYCoOSi/qqGuFuyGPe90qiTh6x5TT3sr411M2oIEcQRquYbNxuv4WT7SfJCo4kcDrgz7W2/JQg7GBN56gKjn1uaps5YU+RJVT/Lsu3/M4QOtlUCMJB6jwwP545PpCJ/G3J7ztUHUJ++IzHImV0wxU5J7NcyXvomGEpRhkPdaPEo3Ay0OnDQOwveZxfzFysXMbii4jLuE48O8V5YYhXoshpaVdwkS6Htr8fhBmsprFjjgWLQK1ewhcAQUja+w3iKo5MwL0LV01C+d0w149seKRrdM8V7RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560257; c=relaxed/relaxed;
	bh=S4lPlR1q4qSCvgYn9gZFu5HucqogfFBKik1eEg5ZKUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6HhQ1fyIriLkQyoado7kxZLCOcTq3W2gQg7br3JGi1wjsqv4smNsUkndExWV9WNIN5Kswrb2rpxAacqzX76lZR/5oWn+3hMS+/zQeavaFmxqrTxmDlog7F1Ca64vDxreGmJR0UhYhdWmQWlTy1K0/VoZoTbHjVmjlNmAPxK/jv2qtVDjelRSfILTQ+yNBX7dIDsNA/764CXWP8y+eAk1tR/elxkTspDTqyQ41m/xpJy69wnl0q7zdV29+8jGpFvCrK/59/mIPbi8oGiKxHGDqoweNmEsQN7pEfkN2Wbo/WfDtLCLuFHcCoacJtPXnpqjuKw/I/Kaov0c1o1vLelgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IFTUZrp4; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IFTUZrp4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVQ1gYJz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=S4
	lPlR1q4qSCvgYn9gZFu5HucqogfFBKik1eEg5ZKUU=; b=IFTUZrp4E9PZKqQGHU
	jILUxrpWJD9kNSDQNDCct1EO5IHqaTfV1PLv3Buw3HPhXxbG8l0vFXtWfO0phug+
	Fq9aLtAp97ZUlgohkgbK5M0BgY539ri6XL2Z1cplFxkoxGS8YhCY/7jb0A/yJPOj
	Z1OpM9bzQG2mLsXIWZWsrEUvA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S9;
	Mon, 20 Jul 2026 23:07:49 +0800 (CST)
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
Subject: [PATCH v3 07/16] PCI: dwc: eswin: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:10 +0800
Message-Id: <20260720150619.24733-8-18255117159@163.com>
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
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S9
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4UZFW8XF4kWw18tr1DZFb_yoWkuFXE9a
	4DKr9rAr47GF90k3Zavw4fAF9Fya4xXr1293WFyF9xZFyIgr1jgrnFqF98AFWxCFn5XFyr
	Jr4qvFyxAryUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNF4EPUUUUU==
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wWxVWpeOcVuzQAA3h

This function is called after dw_pcie_host_init() has already cached the
offset (dw_pcie_link_up() is called after .init and after caching).
Therefore, we can directly use pci->pcie_cap.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-eswin, the call chain is:

  static const struct dw_pcie_ops dw_pcie_ops = {
    .link_up = eswin_pcie_link_up,
  };
  eswin_pcie_link_up()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-eswin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index ce8d64f8a395..6a37fd5a8384 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -84,8 +84,7 @@ static int eswin_pcie_start_link(struct dw_pcie *pci)
 
 static bool eswin_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+	u16 val = dw_pcie_readw_dbi(pci, pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
-- 
2.34.1


