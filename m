Return-Path: <linuxppc-dev+bounces-24966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585EEC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 04:53:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h90MC2fD1z2yr0;
	Wed, 29 Jul 2026 14:52:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785300775;
	cv=none; b=hdlD5mMqPKevSQ9nX11c5q6IksF5vJHeW3DS0dBs+6tsLbYFbQ9d1m8g3eiHnExUYdvMTxAeNb/TXUTwX4ORByK26xuV/wxXSWriqPdjeC5b7xvpzd7mQetAmt1ZYlc2Rq97TOBPzZjqiYSWzbsfQbSe8S7Lx8nK+2LdhzueN8XpcC6hKfuVeX/1XoNyzdX8tLlExMIdLZNJ2Y8h21dgSij3Fbq3L10PrP+EAftfZXYu5ZZ/xnpqJhtaI1Tgz+Mh9I9urATTghFsIPFWDa1WdmkianvEgPl/MgJ63zNr1/TIN4zWHwqRrCzdcR0w6bPAVfSrq0YXtXcx/WGAllZ40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785300775; c=relaxed/relaxed;
	bh=YIZNkNW5LZT+ytQyaXjrXgbwgSkBvxBGZ6CJNC3l3Uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zdnji8xu/137IpGGBpJ+UT7AVFeow8NPWulqfQPNVCfDurNkCcAZV9zPhD9WBfor6V0lcieinPM8S1Tx+Z4YH+2uCUztfWcMCQEp/Wm+Pdd77cKrxo+iJKqusgTJE7WE62SXdgEx6ODZNU9vE4P9nKOQIAWBVvs854JBJW2rLi8/REq+sN08lKD3Crzxeej/w9/AN8pABw6PsLL8A3/Gi+UCOuFBdYUu9UFLdQbj7WLAJSi1nboNdOeXwCs+9pD5RBjozUZQpyQWA2ONjuR2g5i1Ckj8oKd7vF1AQCjKKHCzd2hFS5IVudrH4jLam8DOZ24wklqf+k9tW3nTENAlsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dazNOuQV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dazNOuQV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h90M928L3z2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:52:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5841645152;
	Wed, 29 Jul 2026 04:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F5A2C4AF16;
	Wed, 29 Jul 2026 04:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785300767;
	bh=fySVXE/aTfrJSjJ2cAKr0vSWe2afZA9cj+VbFYbVc4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dazNOuQVKfjs/bgcEMNpPuj9hfKIn4r/PcFvZGzOYtzBrfv58Fpm9+33CFfhxbJ4A
	 hYvh9OGNu1sALRgh8eEiEWNO09ZRQRZHlpOzCAlOEHgH3eMgpQXMCIAyFj4CUKnrOj
	 Nz3F/taMaPkJ43my8dViJueFFc/qbUGmqwqiSeiwJ3tVOMmqwBKXSErTY39pF7j1+H
	 AVB+U8n7aPdZBl/Z/6464KqD/sDi2HxtVowQXKzl/r1zSpqnp5X34Uy6h8CDI3L75R
	 pX2ghZdTCSYeWuBbl9qAFdnnMa0+oDvWGAmJ35OHbpn18uOSw/M+bmZ+vpzBP7NVi6
	 2Usc9DXyt1P+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09056C53200;
	Wed, 29 Jul 2026 04:52:47 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 29 Jul 2026 10:22:31 +0530
Subject: [PATCH v9 5/5] misc: pci_endpoint_test: Add AER error handlers
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
Message-Id: <20260729-pci-port-reset-v9-5-53570b92064d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=+fQoBW7D9QXgCIKA2Pmk7k1028c3wFqBv4GFgS/bGLo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqaYccF5MVV5xC3xxQhY4FDr9QKyU34YNIqpE/h
 JB/JpsxBj+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCammHHAAKCRBVnxHm/pHO
 9SQWB/96YSCRrticMR9WgFmJ/tckKOVulQvEA/lBzlXln5UHHEDzdc135Ou4L1DoqJIGYkvRE5n
 KUjiUzyzjZkZgKq88HbAqNFsyfbABSgM1z6r8w+D5PdsjhqJrdHReJXOxrH4gCbOt5LXa7Ro7LM
 HvA0V3vXtClL6kmXO7st9KbbT0A6J3RCtcApW581RFLMlLSaWrPB6zjmSv95ZQ2GVxSBc+sk/OS
 Vp6FNVbauF+/GvZWH7RBDDiY9R6Y5UlzH1s2WHJQ5Ulz8GJKGiesPN+ZRBYWWmY5RPzSn4nvxWm
 IC+kZ8MI74eB+tan1kEHUWWDkIBW3yhplgSjO6n8r9tIBWUJ
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

This Endpoint test driver doesn't need to do anything fancy in its error
handlers, but just restore the config space that was saved during probe and
report the correct result. This helps in making sure that the AER recovery
succeeds.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/misc/pci_endpoint_test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3635741c3e7a..b7a149715700 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1325,6 +1325,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	misc_device->parent = &pdev->dev;
 	misc_device->fops = &pci_endpoint_test_fops;
 
+	pci_save_state(pdev);
+
 	ret = misc_register(misc_device);
 	if (ret) {
 		dev_err(dev, "Failed to register device\n");
@@ -1452,12 +1454,33 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
 
+static pci_ers_result_t pci_endpoint_test_error_detected(struct pci_dev *pdev,
+					      pci_channel_state_t state)
+{
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t pci_endpoint_test_slot_reset(struct pci_dev *pdev)
+{
+	pci_restore_state(pdev);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static const struct pci_error_handlers pci_endpoint_test_err_handler = {
+	.error_detected = pci_endpoint_test_error_detected,
+	.slot_reset = pci_endpoint_test_slot_reset,
+};
+
 static struct pci_driver pci_endpoint_test_driver = {
 	.name		= DRV_MODULE_NAME,
 	.id_table	= pci_endpoint_test_tbl,
 	.probe		= pci_endpoint_test_probe,
 	.remove		= pci_endpoint_test_remove,
 	.sriov_configure = pci_sriov_configure_simple,
+	.err_handler    = &pci_endpoint_test_err_handler,
 };
 module_pci_driver(pci_endpoint_test_driver);
 

-- 
2.51.0



