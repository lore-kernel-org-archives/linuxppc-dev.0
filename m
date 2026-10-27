Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A46606BF65
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m7ZY+dLc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVDH3yV1z2yr0;
	Tue, 27 Oct 2026 23:29:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104159;
	cv=none; b=bVnsQWrnyX3I1rrgPAAbrX9rnhh+ivNeggyIsbX7PmnW8cLjT2xCE8qaOsLYARYD1T+NtVgs5PBFe8+0SK2bq3oQo9EJvfllJ6mdF345QMmOgEgkiCDmxJ0Rv0WqG3EWG2+TEiBxZmKuPi8yYrcYdMbf52ucrWhdgSB2A2CKS/hkiQKcPZWddJloAPwWlIu/KwNB9jyD+bAo+LX9NTwEDxGVtHJfXGS7auOKXPIqNtVlpGtqNfAsf+zrI/14nuwclq99g3p1cDs4xS+MVtpoBbT2pIJ/mZCfQSR+fF294CP0hKsyb0uaZoQczEYn1mL70edEqBh+5OHWIusX3+m1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104159; c=relaxed/relaxed;
	bh=tJKsjbxpCgR/MpuZ6mXUaOQY924DVgW1gFjR2gL0Omg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCTpx7UdzYDtzk/nPCYrIORw2aFLQZfneKTULddGb2qVUbECVItzeRdDwBCiD3u/95ktmoxpM3NLuvDF0Cm9/7sbpwfV/u71up4ZlbW2atKsOv+gJEoYxai5dgdML9knboakvQCXttKlNlJ9rNwENorj3wWmBv8IuF6Ih9rp0ZRZ3dBuc7P/2TTnQ1rbx6m8AItx7POVsaYNe/0fJjxmFQykwigIE+J3zp7+bjboUmjdGGseWroTrMmGdGrAGVfFj1OZmUInhuSEWTUmXfnPONKDflk4htNb6bLMkpKKYCrxJMUCROcBjGas9RE2jNFMZEOW3wNnKeM9wGxTlUlaBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m7ZY+dLc; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m7ZY+dLc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVD93M68z2yVM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:29:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tJ
	KsjbxpCgR/MpuZ6mXUaOQY924DVgW1gFjR2gL0Omg=; b=m7ZY+dLcUEYc2TGiO1
	IlPXXho+HNCCQCnBvx4vEAizikJPinHmprvmSdpDKXPUajAxbG6N1yhz8EYI1yYc
	20mDQmvgHvoeSz3j/nmK0Ec0+xpIOnZbeyHKODlHxnrRnVzyrjvCB17RrjXSdHh2
	qKu49tZkMIbdqtxGX+of9Gi94=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S6;
	Tue, 27 Oct 2026 20:28:35 +0800 (CST)
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 04/16] PCI: dwc: layerscape-ep: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:15 +0800
Message-ID: <20261027122827.2725643-5-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyrXr45GF17AF43Cw13XFb_yoW8WF1xpF
	Z8JF1Ykr18JF4SgFn29a1Dur13GF9xArW7Ja97K3WavFyav3yUG3s0yryrtFn7KFZFkF1a
	v3y5tFW5uw4rAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimLvJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xM12GrgmPMXzgAA3t
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
ls_pcie_ep_probe() and ls_pcie_ep_event_handler() with
dw_pcie_get_pcie_cap().

The probe reads the Link Capabilities register to save the values
configured by the Reset Configuration Word anyway, so the offset is
cached there. The link down event handler runs in hardirq context and
can then simply reuse the cached value instead of walking the
capability list every time the link goes down.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 527c57114dcf..113be247b01b 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -84,7 +84,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
 
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = dw_pcie_get_pcie_cap(pci);
 
 		/*
 		 * The values of the Maximum Link Width and Supported Link
@@ -268,7 +268,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
 	ret = dw_pcie_ep_init(&pci->ep);
-- 
2.43.0


