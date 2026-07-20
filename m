Return-Path: <linuxppc-dev+bounces-24521-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09967C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:12:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVj2P9Pz3c72;
	Tue, 21 Jul 2026 01:11:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560268;
	cv=none; b=Yic3FpVHH+YIZy0yZjgnTDh2vRHc1tariNtYvNka8Vh1U7JzgumWtaf2QEiMHCxN1mf7CzAscoR4UwsIqEMswP2uqN8rpyJLksznYg40Vy0rqNgHrIujQRX+gCMp3y/cK/pmeOj58bSDcZdejIVv3Yh5LcWWr03mq1ccJXcz8uyksLQ5KLAYkgrRwPhJTZJabHh0DZuUe5JyW5L0JLv/0TC9GJhIk/7c7gZxuabihwcZ4voR78VJrCWa4kYuySM2gi/voHD8Drr6VNwmjqIbXpfHL33GMrsxF9x4u1JL1e+GIJoXn6qVn/yK4MkR9yVKBPtBVLG+GjtIhsEeJKvHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560268; c=relaxed/relaxed;
	bh=VXL2XKRY5F3qPW2VboJTa9SPw1RX8rEnzJV3c1g8W44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TN0fSNUGNvgnYJBVexDjdFBZzqWL8Q2we4YFX1W6IWmuF45t2aA+fkbYq/nDaYHaS83x/oH89knBcGg3fufPuFd4g6VJJwycN2UPh1n9Ix2ECNrncllvSCGwcuYjYe8kQYYEbDe6M9ZnMD8qd5x0liHio+WjPTAHqVUeb01G+ThVFrHp7fkI99yUWDHpdidRd8y+GkYXEYzGTMEqHlVueWHBXCQwvZ4/sqsW8/Yswdcou/wtigzhyk/p9ZEhkr7JklRRR6mEAcM1EYugMXlBlffZEJNB8azFXBFmsa7eVFrFDGohDrM5jW4otKL3fauAhuVmh2+d7SesPj6+ylJmZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PL56MJC6; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PL56MJC6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVW5nCxz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VX
	L2XKRY5F3qPW2VboJTa9SPw1RX8rEnzJV3c1g8W44=; b=PL56MJC6Mw2Dm3beJw
	EGXf2JsTShEbMBOlljS+EgYO6qacNN2UjIkc8WYsI3Z3k7cA6sDekfjYsxzQ//WC
	ct1DT3oLvPkTGbHh3jinH59RtwXi3SySdmeiigJq4uG8QntqeP+JmCy4vww5lACu
	u6uUmyYQXJwiJIDj086urjZ4o=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDX5ybVOV5q0OGYJQ--.29751S2;
	Mon, 20 Jul 2026 23:08:06 +0800 (CST)
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
Subject: [PATCH v3 16/16] PCI: dwc: ultrarisc: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:19 +0800
Message-Id: <20260720150619.24733-17-18255117159@163.com>
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
X-CM-TRANSID:_____wDX5ybVOV5q0OGYJQ--.29751S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy7CF43CF1xGry8JFy7KFg_yoW8Grykpa
	y3WryjyF1Dtr4YvFs2v3WDXF13tFnxAr9xJanrGrnIvF1akrWUJ390k34rtFn7GFWUKryY
	kr1YyFy5Ga4rtwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0tCwUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBa1WWpeOdYHFAAA32

Inside .init we call dw_pcie_get_pcie_cap() to obtain the offset, because
the core has not yet cached it. Hardware is already enabled by the driver
before this point.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-ultrarisc, the call chain is:

  static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
    .init = ultrarisc_pcie_host_init,
  };
  ultrarisc_pcie_host_init()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 6ee661ceff67..3f6e3ab0aa69 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -49,7 +49,7 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
 	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
 	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
 
-	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap_exp = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
 	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
 	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
-- 
2.34.1


