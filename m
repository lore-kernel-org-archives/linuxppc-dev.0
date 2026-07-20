Return-Path: <linuxppc-dev+bounces-24518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089E2C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:12:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVg51Knz3c2t;
	Tue, 21 Jul 2026 01:11:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560267;
	cv=none; b=SBe+2/zMyOO0lD8VUfZEadY4iRbKyX7NpAOFaocjkIWz2ph4mP1qW+DMEXOKmLIs27vrbAwSIGK6tGiw9LaQy2btomfGhRvLwBYqwB3DKHAACMEp7+Ve1Gzc0zel5WQ9XtaGnc6ONz3YdGwS0YkY0QYfHARN0a2C/GVJwcICi1s1jsbKe8E7JHdVLV4cNFaQl4Ms3Lm4uB5scylA+22M0nI7lzyguxSNyKoC5hI9mJRBBSwpf9gJdFz+RctBi/cha2iPAIiHBXrohzqyhtMxEW9zYOMC8x9NQggHeqzf9+uMtrEI3QbRfcM2IOPSQvpDB3bw6R2OYEsRLUpJjFHYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560267; c=relaxed/relaxed;
	bh=e2nYu9u3Jutd+nElU90XXHobR87pV+uv8qFn8mq8pVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0s0N/oPYZRwz+FbEQAwvRVADfieSWeco6UoA+L8SLs3V5Ln1eLlPRhCyuhRgVIa+Vjax7lXP4ppN/f4qaOay1FetE8xHDne/eKFTDyKpy5+Jfh8MXGBpEWUBUvnsVyML0lH1NKzL9uiEQMCXF2u2ZONMQmKAP8WrceFsc9Itb6WDOPSpfyytPFdBr6kbmnAK/BsY3rLX1PHr5lqAM19XBG/z0u7t/6+ccmvrTiOoaysz7oiplHZCMYPcapdiJtEmTOdKvjIQFvEBI7jKeY8QtZ+ZYoCiTwZ1esEuKox/aFOUwYMoXaU6ZHQi0oCJzaQqIPrxuS0KpDV8jKlAyMtWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=P7co5Xrj; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=P7co5Xrj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVW3bxMz303B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=e2
	nYu9u3Jutd+nElU90XXHobR87pV+uv8qFn8mq8pVQ=; b=P7co5XrjYMyTZkVAHt
	/cKwUjkvIhjJZ13ufrkXHk5vM5fgZrivLl6avaptV5bMUovq4jhXCIXZtygS/sZR
	+JL7x8K/M6DAAQjnRDkZdy7NaHhN1mmKSkHIMUfKsECCiFfOhpsrgmMKlhUTM4b5
	w7hQcCHbDNxtAcEn3lZ7fPc2E=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S3;
	Mon, 20 Jul 2026 23:07:56 +0800 (CST)
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
Subject: [PATCH v3 09/16] PCI: dwc: intel-gw: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:12 +0800
Message-Id: <20260720150619.24733-10-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1xWrW8JrykKFy3Cr1fCrg_yoW8JF17pa
	y5Xr1jyFn5XF429F17A3Z8XF1Yy3ZxA3s3Ga97Gr1SvF9rCryDK3yqkryFkF9rGFW0vw1a
	kw1Utw17Grn8JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pig_-QUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AyzV2peOcx2MwAA3A

dw_pcie_host_init() calls .init before caching the offset, so inside
.init we must call dw_pcie_get_pcie_cap() to obtain the offset (hardware
is already enabled). The helper will cache the result for later use.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-intel-gw, the call chain is:

  static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
    .init = intel_pcie_rc_init,
  };
  intel_pcie_rc_init()
    -> intel_pcie_host_setup()
      -> intel_pcie_link_setup()
        -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 348e579e683f..a891c3f8eb01 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -119,7 +119,7 @@ static void intel_pcie_ltssm_disable(struct intel_pcie *pcie)
 static void intel_pcie_link_setup(struct intel_pcie *pcie)
 {
 	u32 val;
-	u8 offset = dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(&pcie->pci);
 
 	val = pcie_rc_cfg_rd(pcie, offset + PCI_EXP_LNKCTL);
 
-- 
2.34.1


