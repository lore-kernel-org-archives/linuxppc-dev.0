Return-Path: <linuxppc-dev+bounces-24513-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013CDC4452B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVc54Pjz3bx5;
	Tue, 21 Jul 2026 01:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560264;
	cv=none; b=fWz6G5bcw+TTNa/KlUyRm547p9rZ6sPU4/4mhvx5xXQlx9eO+ytCUFIuCZYzu6aa9ig5j3tYAxrPYWKekPcM+HFr8gMd6Rk+iq1ctfHWIYvrCbHObc1+LDW5iTN0PV8Xp34lgWBzn6peTBX1TspotNa4GiOqTYJ2VP8rIcxIUBwJbonyEARafn0/xJT5D9SOrNdrLOUIzz7Z1dYH5MYRbC8vKGS0YoDj4SJbuncHj2qXXeGkKtLcZBdXBetmTZ09RbvlET6GBMVz34gPaqkM22x2Gneelzzt68hJ9n0JMs2KypK9f5P2HL495XIFVIEzBpImB0Z5evNn4VemY2EuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560264; c=relaxed/relaxed;
	bh=mA809+5dKgIh5hEU/u2sEYn54hA7ngIexLFJ1RFII/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3kPHxY03N2A7Hgd26xXYZYXnR362/iEy1DBuQnjEgKZzrwst7pgoeEKFmFmZ+mNWPpKEHfLX1mPNoeUAD4u2eCqmg3r3KQEFFq8zr/uMl9uFiBeWz6YssHM8NVG9wuPym6KfRBpU0zDB8Dmq0DXwCQbTB+Jlwp7SMQmjUPi+B0sLjgDFjS/6JWy8CKuUqiw4kwtKcAlsYJKGVnEn5SFtAv5RAQN8HCXIkgwLJAIFb3c6ZniwtAO9pzzXfcd8o919t7wsAyeNpR0fdG2ACZqtLf00BTWVjiJgsdKr1Tom/1Xp/Un3AxP4+1chk4YQHmf9di65BB5H+Qrn4DTijFpvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Rsa4jCy4; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Rsa4jCy4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVQ5qRsz2yYf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mA
	809+5dKgIh5hEU/u2sEYn54hA7ngIexLFJ1RFII/4=; b=Rsa4jCy4DZD7SMWYo7
	jBSCqh9Uym3kU3QnHscX2w+T5j8CfHl4x70kbASd0ua39cOpmpSZfFOEqU+hASMB
	M+lRnw9Rx7nT0npcoOUrBMQgY64hXsZ64tQML0k0CFYlpkNBIyZMKl7H1U0izOe6
	EZuBeYsiFHxPVCQ09c8uU66gY=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S6;
	Mon, 20 Jul 2026 23:07:59 +0800 (CST)
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
Subject: [PATCH v3 12/16] PCI: dwc: sophgo: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:15 +0800
Message-Id: <20260720150619.24733-13-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF48WFW5tr1rXryrCry3Arb_yoW8Jw1kpa
	y5Zr4FkF4rJF4Yqa1Iy3WkZr1Yq3sxAryxJa93Gw4av34akFyDJw45tFyYgFnrGFWjyry3
	KFn8t3W3WF98AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9a9hUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6w+zV2peOc9vigAA3n

dw_pcie_host_init() calls .init before caching, so we must call
dw_pcie_get_pcie_cap() inside .init. The hardware is already enabled by
the driver's own initialization before this point. The helper will cache
the offset and avoid redundant searches.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-sophgo, the call chain is:

  static const struct dw_pcie_host_ops sophgo_pcie_host_ops = {
    .init = sophgo_pcie_host_init,
  };
  sophgo_pcie_host_init()
    -> sophgo_pcie_disable_l0s_l1()
      -> dw_pcie_find_capability()
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
2.34.1


