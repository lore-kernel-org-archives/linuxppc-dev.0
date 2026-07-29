Return-Path: <linuxppc-dev+bounces-24968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F17C53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 04:53:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h90MD15Hlz2yrW;
	Wed, 29 Jul 2026 14:52:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785300776;
	cv=none; b=Gcr/4xfHXyfdxX99rEAfqzTdOhER84MLBjwL+Z3/FDrSgjuXEwzeuzupheUHm0Rk6Oaw9q30Vl2afg/dQAvNsCPXhanrQGvc50gI1RD6W7WYeaN7v3M+08pT8uOjsA0QLU3RsDsGS/usNA3ixeLeGkmf77vMFU2eIbwltMSIrcsaw1ATOrD6av5rCZeenWd8ZR7CHhlxWqh2JmTchnftAkIRzIli2pscsEHCCVincrB4moNHSKicMBt4DdDbhwqq6ze/pZDbKLx+9uOj810gPgDLofGLIYaqEbjrIJTvlk3buMbYTd+fPSpF06Q01v10xrZ4dZ5hYG8Eifw0j5ogVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785300776; c=relaxed/relaxed;
	bh=oZhAxwtFfw6e6w8/vaOT4mzELJXtwkBgBsblB4UwOfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwVBRmYa8P0gfr00GfH35QNNpqbu0x3lNGZfsUj3c5ZY5OfxUoigTmqPeoa8RSn4H26cCQPSpQ5o4zXSPj6fBrNixvJRoJG3AxvgTk8v8XOx23e4k5NcPK7OGfUAnxJoQqND9zX5YuuIuIMdhZ2qi8aoV6YNViUnGtTZIdlvAXRv+iBsmC+66638i4i7G/mwey8xuaToTf9vt03SPEQ1ptAfaAk72jSlR5ZrcqcZdKFTvOrAkphyDPkuLhL8sILAzn8wjBmTlZZek8b5iBNpFob2wAn4iFJyP7jI4g9K2uQRZILLk0jsJA1jKCWz/PTqfJaXKsxCo2uZoB+yVAz48g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nDiG6o0n; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nDiG6o0n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h90M86Kb6z2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:52:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3AB054513E;
	Wed, 29 Jul 2026 04:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00747C4AF0B;
	Wed, 29 Jul 2026 04:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785300767;
	bh=vYnyrVV6m13Ed/pDKHyIAJ+t3bsrUYebXUpxHHek//I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nDiG6o0nclLJpEPKFmsgjEKodCBG/sr4t8d3zMljpvF2lFiTJxokztviA71KlavRE
	 uTVFCsCWwOO4BA13hoUjrSKv6vSphoMG2khTDpe5vp/sRif68No6OBD5QvcU4O8Qht
	 lcHCdgGvH4wOWBv6cQFRKrxJitQ54HMM5zGB4aBro7nMXpAqpmlfjLwfdL65Y70dgJ
	 Wp3MF4HVS1PKkyyQOeve+OxsUaHANf/UN67KtCU5WExDwxrfz63rSv0J7SH9UinZBp
	 MsNWMzeE8r3wriKmQEo/3ggJLcAcjXpSSuf0qARzaywcfLVI4fxMO4/Y78qHzzAX+J
	 7+c+83PKt9kzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D15C54F5C;
	Wed, 29 Jul 2026 04:52:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 29 Jul 2026 10:22:29 +0530
Subject: [PATCH v9 3/5] PCI: host-common: Add link down handling for Root
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
Message-Id: <20260729-pci-port-reset-v9-3-53570b92064d@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5045;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=FFkpE2OojMeJ55G69r9Mkff2gjUgGan5va971rIppUs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqaYcciuamGWxObwvcK9F266CX+RGpkJdMwhoWH
 cH7l6PiLvqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCammHHAAKCRBVnxHm/pHO
 9ebhB/9PI5JeFWbWf1nD8zrabnPr0l0E6ijEeICZMcuO5pfSaH3uQNXBcAJHS8+5XxpA4nKsQgx
 CW8yMUjwqSHWqblmJf3xojLH5gR6YSW5CA5yTkV3xJ5hLcEZTzy5uAELOSxX4lODSw0X/yDfrsX
 xp/IuERsvHL+dWQZL+VEJdYxLeKaubbdwwWFptIAK3NyOAOzbRwnQ1sWD9Qe+MJ/B5yagFb8E4g
 3hgN4PH6HAcRUwusgKkc/FqccKz0XkQ0k50m3KcfjaIv0e3CPMSou+hgJfbM/yp5r2FzgblbCF+
 LKaVAEJCk0zDcvZGmCjwxktmcqTJalPtZXKRNt9Y+oxE8J3L
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
pcie_do_recovery() helper is reused here.

AER error_detected() callback will be triggered for all of the downstream
devices, but not for Root Port itself as there is nothing to do for the
Root Ports in the callbacks. Finally, pci_host_reset_root_port() will be
called for the Root Port, which will reset the Root Port using
'reset_root_port' callback to recover the link. Once that's done, resume
message will be broadcasted to the bridge and the downstream devices,
indicating successful link recovery.

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
index 2ce6f4b66133..363d3f970b10 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -13,9 +13,11 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
 #include "pci-host-common.h"
 
 /**
@@ -342,5 +344,38 @@ bool pci_host_common_d3cold_possible(struct pci_host_bridge *bridge,
 }
 EXPORT_SYMBOL_GPL(pci_host_common_d3cold_possible);
 
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
index 9f0f36a32221..51afd65d3c4a 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -48,6 +48,7 @@ int pci_host_common_init(struct platform_device *pdev,
 			 struct pci_host_bridge *bridge,
 			 const struct pci_ecam_ops *ops);
 void pci_host_common_remove(struct platform_device *pdev);
+void pci_host_handle_link_down(struct pci_dev *port);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 12e099489690..ff6d5d059b21 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5700,6 +5700,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
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
2.51.0



