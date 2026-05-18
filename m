Return-Path: <linuxppc-dev+bounces-21122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930D0CD4F52
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 14:59:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK1Dc0w4Tz3brP;
	Tue, 19 May 2026 00:59:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779116384;
	cv=none; b=U7ODjK6YaRZpc5juRXEXWEwNI3/0Quhc8+ltpcLb01+VGDOrEpYRErPIxNow860YR6wAp325kdX4yQcQBY1xHLAGYCutxbqOYKIhKLbQN5QY4uAbRP601EuH6hfAdXBkuziPt4QG1jQ4yMDPyXmOngs6pQCkC8jMjAtmEvYdgizTfVQl+NqzdrhwJiOxlzN92g+tC4DJ57VrnaB4bExYF+47lSiw6/m7p9uHdMz9DuXceXqzPQiW7RehEOZ+rw34J8A4fGL2KjWc03y6KBasB/qkcXSdHNgGGOGsZZgnZ0546JNDQzv/eg8gwRPrmtXY/7QgcET3ZQWJofl0ynIRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779116384; c=relaxed/relaxed;
	bh=3rWue2hixAfkhDeS1NcjZTC89ybY3RUFDUF1w10HaZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qp34UBv+HJZlTr4xxe7BUKlcxGwp/07hNyH6dMDEGmabKCBe3OUIdvPQxBct4MPt1lX0YvMtFwcJKlNpje4yKQaELJT3qgc6iMYvSb06Ey0yMFsl4ryITkoXPloPuSwB8B0hxRLyU2OnSu5wlFJBnN3smqy8JHPc+bqh8BY8VzlqRBJKvmCuC+KPO+4CAR8G0GxhbdVQCeWBNoilnBPn3Jnvhp8BfOiPj/zvksUEw8ibfcIRfbfKPOC59VazRSBNyvucy/zq9qWgz02ZI2LGWQjgsEmxqBHOX4Ro/7nw3Egp7r+VrUz9sJnIrpqlIrKsNAaVaGvyaY4Gs3K52z9cyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gQs5MJLi; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gQs5MJLi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK1DW60vRz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 00:59:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0387B601E5;
	Mon, 18 May 2026 14:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2E86C2BCB8;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116376;
	bh=ECoXg3gC3Bh+h2o1n42paArpk4jp4P7Tam92UW2RViE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gQs5MJLis6UVecTNK7IBd2IlJgQiFxhwt7w27uj0aIP/JtxjfkgCTv2GtAAAzx0WM
	 eyNZgbR1TJQihLZDJOCJx02FsIemL0KN9lIdH/qJb7IqD4szt76BfHkxKH8UHIZyLs
	 TPvw/MDJL78kc0UFdm/EpqLBeQo0YAp7k4NBaH3fTCTObp9TdqUvY3A7yiYS4gtGiA
	 7u0AMreAiOVzIKQthxjRTOz5urdWXgSD5lYG7IfdOJPRcq8gTs0K87gdH9YoSIgSa7
	 R3PcUahA10xl6+62j5BFrOyLTRQ4Ukb47viYxXO2Yxmf+cp/CqUrJqHoNA3EM6rYfk
	 0q9CXfisL9oPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90555CD4F49;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 18 May 2026 20:29:13 +0530
Subject: [PATCH v8 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
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
Message-Id: <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
References: <20260518-pci-port-reset-v8-0-eb5a7d331dfc@oss.qualcomm.com>
In-Reply-To: <20260518-pci-port-reset-v8-0-eb5a7d331dfc@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 mani@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Brian Norris <briannorris@chromium.org>, 
 Wilson Ding <dingwei@marvell.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=DOBc0qbyq7keowKanldmTADeubkY3d2RuxJiiS/OOM4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqCylUbgmSbz1kVr7omfIK0go80pJFvGDFzpmhY
 9nEuMnSMXmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCagspVAAKCRBVnxHm/pHO
 9Vp1B/wOqPF1w4/rxr1pZQAJ04G+p0MJoPG4wsGqn4QByaQH0A6xK3NTFRxmhprieh8pAZUVLiv
 Bfk9nqjL34e6h89veBGMpdtMjzM5K1Yd9rjfahszPgaQnTozmKX71C3zG2Gf62yCYbGIxDU0fN7
 wF9y8NDGQ6mY1osHaoCK76W0XZIqiR1qUOwlVUh1xNCspSycCzJc5KhSmcBZdrc+PrEP9ukFuQv
 W/NyAxeQV/Sz0vX+7XKAac8Blfb/ubk0kqlWq+KbLJaIh1DUw/sp7UVCIx3SVbGMVcDmGjrBopn
 /XHtcZL3biY8r5MXhNm5m2XnDXLSZk3RcxLpbHTE5Q5nhg/6
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d4dc3b24da60..4ae0e1b55f39 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1035,6 +1035,11 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
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
2.48.1



