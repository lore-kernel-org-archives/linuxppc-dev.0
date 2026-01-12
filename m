Return-Path: <linuxppc-dev+bounces-15591-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CE5CF45CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jan 2026 21:40:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqm5T65G1z2xP8;
	Tue, 13 Jan 2026 08:40:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.203.201.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768246747;
	cv=none; b=Ti7ciu5pHSwt7W7gBg4tqHMGzSmH8DHxvJcd+E8PDJC3D8wIy7QIGrU/4GUwgyuoWDv+qlbAaYGHdBU0Ll1+E/5j/7AQ84vdTrUcKwN+TFNRPD/hUFJ9h3FJoW+lmBxzaGHwkPrGJ44yfTQ9WwfVvQx7H4xEpeu6pBfsCdSu9MXh7nadJzBGzcpGQMVIF583+HxD1GDJvOvq8qfPTq5gSeudJuH1Kos4H+OXB57iMz9f2JBuAlsZR8u4VJINS6AEkNMV+bPR9qM+5esA+FNxXyJcLLUFDd+WaD+wvvAfrDwLJwuHbvbVKJz3kIr8lGmGnZC3ywzWEVziCFhItOEuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768246747; c=relaxed/relaxed;
	bh=xpxn4R0gOPfxcyAbXyc3KA0CINt5vkULnqTOZ4ZLzic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HLNrzQOz8TDR08w4nUqJHEWg2gLGqbyjzC1/IK7Gn2cjnybi+sLaBbjcSV877rNVRxQU25MYsCIGeDBCjOlJX8bo6edQ2Lhzhyh770A+gW4Q0B1OPdlh/iCt6BD0hd98hmFvZ4RZtERXVTCh5BoUtkbl45kCPU0QrXupYGP2YqEr7dPgt/KvHGGtnhlQK0uIgqlwaTh0Z9/AT3RLlDQ7QVeCIZiTKcDix2NENTyiU8p11DKufGCKr6Qcg+XSj8aA6Rw6kzHSqaXMaqt1x3NQwjOItjLDPAPWBE2HrhLVJxztqfJPKdqQTzxhs3QtUvt7IT2DiiGC5e/0ToQVoe4rRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=185.203.201.7; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.trumtrar@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=185.203.201.7; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.trumtrar@pengutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1172 seconds by postgrey-1.37 at boromir; Tue, 13 Jan 2026 06:39:06 AEDT
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqjP63tYGz2xHP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2026 06:39:06 +1100 (AEDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vfNPd-0003nP-0Y; Mon, 12 Jan 2026 20:17:13 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 12 Jan 2026 20:17:11 +0100
Subject: [PATCH] PCI: layerscape: Allow to compile as module
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
Message-Id: <20260112-v6-19-topic-layerscape-pcie-v1-1-1cd863fce50e@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALZIZWkC/x3MQQqAIBAAwK/EnltwrQT7SnQw22ohSjSiiP6ed
 JzLPJA4Cidoiwcin5Jk3zKoLMAvbpsZZcwGrbRRRBpPg2Tx2IN4XN3NMXkXGIMXRjuSGkxTa6o
 s5CFEnuT6965/3w/uII1AbQAAAA==
X-Change-ID: 20260112-v6-19-topic-layerscape-pcie-9d10b6542139
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Minghuan Lian <minghuan.Lian@nxp.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The layerscape pcie host controller could also be compiled as module.
Add the necessary infrastructure to allow building as module instead of
only as builtin driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/pci/controller/dwc/Kconfig          |  2 +-
 drivers/pci/controller/dwc/pci-layerscape.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 519b59422b479..abfa4a6e62c25 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -121,7 +121,7 @@ config PCI_IMX6_EP
 	  DesignWare core functions to implement the driver.
 
 config PCI_LAYERSCAPE
-	bool "Freescale Layerscape PCIe controller (host mode)"
+	tristate "Freescale Layerscape PCIe controller (host mode)"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index a44b5c256d6e2..14d6ac4fc53fd 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
+#include <linux/module.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
@@ -403,8 +404,16 @@ static const struct dev_pm_ops ls_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
 };
 
+static void ls_pcie_remove(struct platform_device *pdev)
+{
+	struct ls_pcie *pcie = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&pcie->pci->pp);
+}
+
 static struct platform_driver ls_pcie_driver = {
 	.probe = ls_pcie_probe,
+	.remove = ls_pcie_remove,
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
@@ -412,4 +421,9 @@ static struct platform_driver ls_pcie_driver = {
 		.pm = &ls_pcie_pm_ops,
 	},
 };
-builtin_platform_driver(ls_pcie_driver);
+module_platform_driver(ls_pcie_driver);
+
+MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
+MODULE_DESCRIPTION("Layerscape PCIe host controller driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, ls_pcie_of_match);

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260112-v6-19-topic-layerscape-pcie-9d10b6542139

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


