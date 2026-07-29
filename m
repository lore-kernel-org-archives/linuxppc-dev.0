Return-Path: <linuxppc-dev+bounces-24963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B3FC53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 04:52:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h90M64NsTz2yfD;
	Wed, 29 Jul 2026 14:52:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785300770;
	cv=none; b=TrNS/c2oQSYhJWzU8RhC/Y9al4AEGTY5xUAgXhQSaZBfsVk008YHm44GMR6nIZzblEagu6GNGxcWopKdcNIekA3Jd2u9HJlRpCqdfQ2aa0rxTj/1XbYfr8gx/YzndW8izqoji9z21L1WbVvGfyxumoplGmfJ4RkskycBN3eJKWQyrrNSFfFobTo3a/ZMXpy8gXFG5FCxraNR4fK2AEHjsOyPMR2pkDRQZPePxPC+bFUEZdDt/mQGD7cKuxbHmazPMkC5ie6fvtEWx5ssE5gsAUEcTVR1mUi+VQg3wdcNbPFOZIPYwgy2sZD2rRu4MJZEMstpYnCrEG6FCj1sojbP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785300770; c=relaxed/relaxed;
	bh=VoeIURJE57Surf6bb4y3czM+qCCNVa4flFM5/ODdgSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gklpMDv3f9nCo9KdmopjjhLgp7H+9ycV9e+L/fSqtPMP0hUz4iCU8aZoxLG8WkzJOb6Ty3nywvPzY7Z9v5U+FHfV3g/QRZZnDSQY7T0FCOXVu80HmWBCI0+EI/ApOIDlaK8CHy0i5svBkmZHtH1zHd9CPim0lcYdzU3BCxm+sZKUh/AE+kEeCMWmKakKcuArFj8nLuo5hPjyjoCn6A+2zEDObGqJ1RmCD7rhDNMmRFi1rWQUFA0fCBsthjK8Q/yPemhhTuJglyLiM7ugEocjwefwtGR4IOTDQtu/uYSjbCMM5+kLS2Kc9KndxNsVmgqOn/oUZNIPDjzyLged9R6Epw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DxxkuFll; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DxxkuFll;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h90M538X6z2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:52:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1818E44FC2;
	Wed, 29 Jul 2026 04:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D626CC2BCF7;
	Wed, 29 Jul 2026 04:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785300766;
	bh=c2VrE8rb1zoFDS/P2/5rT/iLBv1+HHpu9wwoYvKp7nQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DxxkuFllRRY6RdMV40XQh2kosmUX2aLdS+z1/ZtEGmjpkZC0DFbVEeVw8UicGxAnb
	 V1QY9y+CfjP2pNIQjHZ1ArzKzNDK7K+VEDmvuY3HFIluKpQHiZ+GFFOQOI+I64CYGH
	 caXy1f+gCt1vZh2g9Q3tQV+GDLx7jkXH+jwwsr6HJt6afHnq68e/QxFobNUiPV9STb
	 VQPX6WnShYGklIfGaVJAJt1xUWMdyvSS2CMMk0658fi+CyshrFLtanSRnRaP5XYouD
	 4qC2RQ9tbJqfSl+qzK5lgy5wRT8o/CX0XlGh6ZLT8Mxoe6Y7/CjBDKupgNLo3n3cIU
	 iY3BKcSM/gdZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8549C53200;
	Wed, 29 Jul 2026 04:52:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 29 Jul 2026 10:22:27 +0530
Subject: [PATCH v9 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-pci-port-reset-v9-1-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
In-Reply-To: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 mani@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Brian Norris <briannorris@chromium.org>, 
 Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=IujD1rr4tXecCkUgBteCHlwjfNA1jOOLnFWO5BjVWVI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqaYcckthZyzkNWhp+mo4GfBWetSuqCMaJXIHPW
 g8AFj4xaDeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCammHHAAKCRBVnxHm/pHO
 9coXB/4/3XGgA/mHMhh18ubewWKhqoN8jpYSXpGZ5QthV5FyzLGbiDkMNrQlptcLpy3gkp/v5uh
 4p7JcQ9evq/4I7ElMbR/7W/pEzBKzOGSfBx/P0VlJWZ3JB3m5l2cIxVawsYej3bQhUGpeSzInyW
 kyXfw6jxizzT6hHCh2ueogeFn9MYr23mKXEuDLANJjnWWPb/XaZ4tghU4cJuW2KqjRCq7U3hiiN
 tPzcsxu2UVJre3R11ulQv7rbad1CBfxIMLRlGj5/aULFnccG7q1LfNygVg6y2PI0g1pvP9x4twI
 0fHIwtlW1iW4/eSNTiz/R8WdUOpqgSOz5M4M4EeIfjO98F2r
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The MSI iATU mapping is currently only cleared when the endpoint is
stopped via configfs or when the host updates the MSI address/size.
This avoids redundant iATU reconfiguration every time the endpoint
raises an MSI interrupt.

However, a fundamental reset triggered by PERST# assert/deassert
resets all iATU inbound/outbound registers without going through the
configfs stop path. If the host also retains the same MSI address/size
after PERST# deassert, the driver never clears the stale MSI iATU
mapping. It then continues using this stale mapping to raise the MSI
interrupts, which can cause IOMMU faults and MSI failures on the host.

Fix this by clearing the MSI iATU mapping inside dw_pcie_ep_cleanup(),
which is already called as part of the PERST# assert/deassert sequence.
This unmaps the MSI iATU region and sets the msi_iatu_mapped flag to
false, ensuring that dw_pcie_ep_raise_msi_irq() performs a fresh iATU
mapping on its next invocation, regardless of whether the host changed
the MSI address/size.

Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..31402ae218c7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1153,6 +1153,11 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	if (ep->msi_iatu_mapped) {
+		dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = false;
+	}
+
 	dwc_pcie_debugfs_deinit(pci);
 	dw_pcie_edma_remove(pci);
 }

-- 
2.51.0



