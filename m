Return-Path: <linuxppc-dev+bounces-21123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C3CCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 15:00:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK1Dc5dQQz3brt;
	Tue, 19 May 2026 00:59:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779116384;
	cv=none; b=gpnPtFQMm9SCtpcavkVQeSui5It+bBt/iCX8OQAl+1fz37OoAKjhjrNnxtqvhpwAVwJGwT/OkhCHHmtyuj9GoAjMvOpfJyQHTG+2JoD7EsxLMktkgdleGD4ouxRMLSpFZW70jEpVKuGcc2Axu43qZQtbtc9vDi6WRdyTmJxIS/BB5vQXYkiVxfxz/HfkyDC7iG4S6zI4QKG4pumJHNiDlOzbCgn+TdcLVwOdadL3n09XI4URrH9N5oKIUdYUkAlq2jzjPDYKcwpM7+NDmPhtfRBx12ENcGECED0yaUwdTwCsYHIb7qkzovBAVp7sBWIjOEQXF/V8tZJ8uHhZ9HwHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779116384; c=relaxed/relaxed;
	bh=Hb8Z/QwUqmNbevH/a/ryjpL5qgeBffRR9Ug827RyGas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQB1KnNyKHdg9CkB6dYuTbTxz3CC5pQo8CjrbLJJK3lg8j8+o7NXurOETFUDS+TxER/ixr05IacB4fhtlCxFCKVMLiQ3/Zbc3ORaKxX2kcK6Ix7Q6jwt6FHqAT9C/xPuapdSfUdEtwws4xW75zrcdqazq4nh3pMWQR9clB1M4qCEX5tKjRJArfR2wK9TO4Pl66n90IZA/TjiF8PvbfMKXSJoU2Y2F5RL0UjC8sb2qz3pUNeTUhIr+aDTQdxOzj6ID5rFGNyjCbVTD/cQoDxVN0J7h9iQLfEsoW2dzcBSXQzVjofgKsDVHy54LNDiqS5yHGQwpEo1n26APfScpwIaOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tb/1LJ14; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tb/1LJ14;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK1DW6KGsz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 00:59:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EB0C04459A;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C119EC2BCC7;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116376;
	bh=FPkH7nuI/rmbozo4tpmubhI/WsHwtwOZ2WRLuaejGvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tb/1LJ14o0icck2ihCsOmTA/7FW3dsMH8eXTC6NXAr4aE7l1S6VfHpMcexJAiqEBn
	 XZgUfuD20/0PCeWx5/Av7aG9sV7T8J93+vbRwKEwSmouKjW9bDynihjgoHmrGSLvzS
	 KZgA3CEs6XX20NZKTrCFB8smRU7IDltjzfRYYJH2CVi2EQH+2e90nWlZO0eQJxR+Oe
	 mlPqwwTlVyuibHP45k+etkIUQIyRSJ4qyezZ8xMYRqnUonjxZVLU7rx7uzedyQ1ta7
	 dKyYoqfbcxT0Dx1dqAneRt4kE/Vimzhd4zlQQ3qifIWRcjCHg4cFW08cWQusFU9Rj2
	 rbfZ3PEzNhkqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B531FCD4F52;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 18 May 2026 20:29:15 +0530
Subject: [PATCH v8 3/5] PCI: host-common: Add link down handling for Root
 Ports
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
Message-Id: <20260518-pci-port-reset-v8-3-eb5a7d331dfc@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4994;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=sUUM3qfYFHtLCvQ6F4TpKK8xkq87A6dqKTUi0wYFy8I=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqCylVsyXmrLzrL4HM6RZ5tQgjTnDWSo1IJbmqH
 9kH3iIqszOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCagspVQAKCRBVnxHm/pHO
 9e0bB/9vke3MyQywmKGA3GJHkJV+dxOGWWN8YoNw/Rzn7XiOr8oQzUBq/Gh+PpQnY3OXbjrSHHM
 CLayK3+F3LYkQK0C62kPt1fTq8AF9xkddaAWCxZcjQITehj/TowyK4qSoR+Fz2zywNIHSU7sYfl
 9yN5CLJTC4qVfpAjD6sqhSj0Wd0EmV+/YmH6G1LtwouYbzl/VB5nyTADdgtcoEAHjYFiJvXUvNd
 E/sNZNw307LUx+VQsasfhyN5X67ZAOoQZUx/I0KYkwpGGyFmMCPn4EmvYtnVXx/flktEjT8H4H/
 j8bdKy9/1wCveS3bTpctzjVo7fcy3RsQRFLIdAl9GI48QJO2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <mani@kernel.org>

The PCI link, when down, needs to be recovered to bring it back. But on
some platforms, that cannot be done in a generic way as link recovery
procedure is platform specific. So add a new API
pci_host_handle_link_down() that could be called by the host bridge drivers
for a specific Root Port when the link goes down.

The API accepts the 'pci_dev' corresponding to the Root Port which observed
the link down event. If CONFIG_PCIEAER is enabled, the API calls
pcie_do_recovery() function with 'pci_channel_io_frozen' as the state. This
will result in the execution of the AER Fatal error handling code. Since
the link down recovery is pretty much the same as AER Fatal error handling,
pcie_do_recovery() helper is reused here. First, the AER error_detected()
callback will be triggered for the bridge and then for the downstream
devices. Finally, pci_host_reset_root_port() will be called for the Root
Port, which will reset the Root Port using 'reset_root_port' callback to
recover the link. Once that's done, resume message will be broadcasted to
the bridge and the downstream devices, indicating successful link recovery.

But if CONFIG_PCIEAER is not enabled in the kernel, only
pci_host_reset_root_port() API will be called, which will in turn call
pci_bus_error_reset() to just reset the Root Port as there is no way we
could inform the drivers about link recovery.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Brian Norris <briannorris@chromium.org>
Tested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/pci-host-common.c | 35 ++++++++++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  1 +
 drivers/pci/pci.c                        |  1 +
 drivers/pci/pcie/err.c                   |  1 +
 4 files changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..15ebff8a542a 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -12,9 +12,11 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
 #include "pci-host-common.h"
 
 static void gen_pci_unmap_cfg(void *ptr)
@@ -106,5 +108,38 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
+static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
+{
+	int ret;
+
+	pci_lock_rescan_remove();
+	ret = pci_bus_error_reset(dev);
+	pci_unlock_rescan_remove();
+	if (ret) {
+		pci_err(dev, "Failed to reset Root Port: %d\n", ret);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_info(dev, "Root Port has been reset\n");
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void pci_host_recover_root_port(struct pci_dev *port)
+{
+#if IS_ENABLED(CONFIG_PCIEAER)
+	pcie_do_recovery(port, pci_channel_io_frozen, pci_host_reset_root_port);
+#else
+	pci_host_reset_root_port(port);
+#endif
+}
+
+void pci_host_handle_link_down(struct pci_dev *port)
+{
+	pci_info(port, "Recovering Root Port due to Link Down\n");
+	pci_host_recover_root_port(port);
+}
+EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
+
 MODULE_DESCRIPTION("Common library for PCI host controller drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb..dd12dd1a1b23 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -17,6 +17,7 @@ int pci_host_common_init(struct platform_device *pdev,
 			 struct pci_host_bridge *bridge,
 			 const struct pci_ecam_ops *ops);
 void pci_host_common_remove(struct platform_device *pdev);
+void pci_host_handle_link_down(struct pci_dev *port);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 651505b3bd60..35dc9f54a8ef 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5669,6 +5669,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
 {
 	return pci_reset_bridge(bridge, PCI_RESET_NO_RESTORE);
 }
+EXPORT_SYMBOL_GPL(pci_bus_error_reset);
 
 int pci_try_reset_bridge(struct pci_dev *bridge)
 {
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 13b9d9eb714f..d77403d8855b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -292,3 +292,4 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+EXPORT_SYMBOL_GPL(pcie_do_recovery);

-- 
2.48.1



