Return-Path: <linuxppc-dev+bounces-24509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451B9C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVY4SJCz30BJ;
	Tue, 21 Jul 2026 01:11:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560261;
	cv=none; b=T/vHLOXb9yau4UYq/lWCx0UwZ8iVDWIJSM0DF8BR2CJA/rQwJDn0lbpiIiNsVXbiandI+NJKkvQaZE6PM6tc34zliPhz0r9lY1tthgdsWRnOBwYFTBxamHsBV6UIq+VMZjV3yK6Yi6hNikmCK7pbLzMJUk4bn3XL7UcvjNLRbkcBX3yj0TcmQ4zNXJZrVEPf1pk79SVb1V145hFr6fbkYkRPvUmNHoaeNIavCDRlZJGCqNToSIv98dAK0WfJX2BqQ7A2obPdacok2HH6l5h346THYAjw/q/IY/LdkJGFv90FjdUWgeDz41fxfLqybd3/trSoC+++rE/fffqBJd6FJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560261; c=relaxed/relaxed;
	bh=3Tnk0wVtGn53M6dJL6AEJiPqhbC3YBLarkGOhYIYIBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDrp/JakxaVDIFEGNjls83hlhn3Ui4fy3j9O8MlHRXzGm7jp5pXZa2g12M2IQP8ni/qPxyVh9a6n5E7RqkXuPVvlWPU/0Sq5roVtOLwIo52Cjss+WUdno4l6PXNsWrxr7Lyj9qMQiB3dgRUBtK2p/bDKNnVRWJP0UEe5FmrRzMFgY+5jeABAUq0/DZ9Y7jINaSBGTDApS9PoDTMtk51moU3c6XeuyHSgzOQqjb/CSq0VOe63QMlpJUbkh+iLg5HfCv8d2yaw7R0094W3zu0OVTtA+hsDJ08gLt4N5kuY6tKDqVovM6Qw/REwDRnFfU4aHsRvhrBo54nTi8LMPgcjEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CYQ2209a; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CYQ2209a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVR0JWHz2yYq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3T
	nk0wVtGn53M6dJL6AEJiPqhbC3YBLarkGOhYIYIBw=; b=CYQ2209abseG3G4v3z
	nirGxluq0GIYB/vwRbKW4Yo4Z7lkVSJA8AKPvPxv30EEtuDHkVfL/s12ywjRRntf
	5CNqSiOasNI8LfMTXjp9xtGNN4Z/uT+7n8+63leY7twtvGSwH2XSH4Z8bjBo7oKO
	jRqjYbVuhrcdg0wgzX56UNwkk=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S8;
	Mon, 20 Jul 2026 23:07:48 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 06/16] PCI: dwc: rockchip: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:09 +0800
Message-Id: <20260720150619.24733-7-18255117159@163.com>
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
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy3CF1kCFy3GFyxtr1DZFb_yoW8Gr4kpa
	yYyry0yryrGr4S93Z2vas8urySqFnxArW7Ja97G3WSvFy2k34Ut3yYkr98tFnrGF4jyFya
	kw1Ut348GrsxAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyxR-UUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wWxVWpeOcVuuAAA3U

dw_pcie_host_init() calls .init before caching the offset. So inside
.init we call dw_pcie_get_pcie_cap() to trigger caching. The helper will
perform the DBI read (hardware is already enabled) and cache the result.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
In pcie-dw-rockchip, the call chain is:

  static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
    .init = rockchip_pcie_host_init,
  };
  rockchip_pcie_host_init()
    -> rockchip_pcie_enable_l0s()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 731d93663cca..be8b6187913d 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -369,7 +369,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 	u32 cap, lnkcap;
 
 	/* Enable L0S capability for all SoCs */
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap = dw_pcie_get_pcie_cap(pci);
 	if (cap) {
 		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
-- 
2.34.1


