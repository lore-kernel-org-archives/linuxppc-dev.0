Return-Path: <linuxppc-dev+bounces-21119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA116CD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 14:59:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK1DY0vHvz2yLB;
	Tue, 19 May 2026 00:59:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779116381;
	cv=none; b=MR4AfdPFdja5Ud9ecgNaY7BfoGURkax/QoFKATp+fvyKSSlf/hMOm1K0qHYGBiDQllgt92Wf3idrdIBsMJbjYQrhVTjDhJaXhYK5leHSZmzTsdC3+qRmXhjuFfviOaHV9pU9u/TW+hGnCOz6RUw/QqLikQUl6C/t4oBg1Nip8FhPHLTvhoaMWAjPHLpaQdMuWIQ4oep6oFIBTqzDSvX08j10/Fqk/b572dgLBDIYhXen97d4ME1oVIF4yvzZfd0Wnl9e2DQ0T7zaNsYwUmX6b7WqtWBhQqPXZqa1qgAwj9uymv6Qh30uC7kZoWByBqKHSglUtdwkYkk5F4/+91ycMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779116381; c=relaxed/relaxed;
	bh=1jBeIvH+ev2/VOGZSLs2/Nm3nn0glIp/8aMcm/j7TMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1kp2R8XeU+6klVfDsax7ETIsV/4X+yTrmKJOnX5c8kGKTCJeAWY3miRjT+w4OJlASS06jSW5xMTq8rKNkl4nOUDAW6Nh6pYr/8dWJRnDPhWZQ57J1tB89FMXuZMpDUu7W6phnh3k2PkL3t3uV2Pa1FB6H0aEty9N0njaOvxdBAN7AZ27YksU56orsmdqqdcFQQN1nRLWF20cBXLHcc0K5IGOadXctivQ/qjVl4PcPdYIDN5XmY57yiiNH6Vvsm/tJFxrNP+un++nfkUJjKOpFJjjuSwoqd7cWJ/0XcM2VeWmPyCSSWybRY55VUXMlTP6vzqq4DT0GT/Fhl1Dvv4LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rSFNQyej; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rSFNQyej;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK1DW4M6Zz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 00:59:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 18A34445DC;
	Mon, 18 May 2026 14:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6071C2BCFA;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116377;
	bh=2BlXOqN2MZMWBnpX9YhHPFj1hDHvw8PDo9sAAleLcKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rSFNQyejJN1StW2jxZXu4JYK0fBi4R7e50XyaCZdoKCJrc88c/HBcQUE+XFczKXln
	 7GCFjGgUbJfUnABpYaJYIZldk/dzVUkNZXjp7pgUqmHm2NJizrZEgAs93NuyHoRs5u
	 ORUL/OQt4EG9yUeTchQzypVNqwGZpaMXK1d2UG+SZ9bZ4RqNAYTpLVANp5VHBsjgEt
	 0XC1RmRbEzLdSO7N7nGg60yPvelPhzBNyjEMQfEcxkMaR09wvdKZBE3/OSxndVe4KC
	 NOmISQynSe7AzFcBX3BHpjXWTeEVzED1TZHtas+ifUE/JUkVSJNMYv5Bs7cFVDkYFD
	 +AvF2Yeuctw0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA44ECD4F49;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 18 May 2026 20:29:17 +0530
Subject: [PATCH v8 5/5] misc: pci_endpoint_test: Add AER error handlers
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
Message-Id: <20260518-pci-port-reset-v8-5-eb5a7d331dfc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=JH7YrfnPbbQwcHA61MAIZvihPkNzj1YvLFKf+5eniiA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqCylVusbtosdeWvULWFlkHh78IbQMGqm1IAOx+
 tGRKk7zI06JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCagspVQAKCRBVnxHm/pHO
 9WBGB/9M4YSDd/u8GygRb+Q9NR+sR+xkzlGX6Arf72nQo8iLfuIZSfmmo3tNIE252mRjE4SBjep
 u9Mu4Rk2sVPFLvxd+u5GSzGgsDTa8tcVuYDAtw+xFjz5MRwDWTgKgxr38lidrHbLRqiqtzL5uz4
 KychY6gPdaMcbHKno6gaMz9PA9pV3VzJGng6rKL8yL8uODtIyLvIlMslDX2Hq190bXbkex0fwWC
 cjULNwNhFecOlIu5lUUhaomXfvTFH0/sue5mbjRY9aOppS+5rzT7TOHdXs3ETXD0xXVSgMt/306
 Ux/uIMKhNVNouKfGHOjox249GhFX61Hck5JeWw2KFHfEmY46
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
index dbd017cabbb9..3e89bd48c196 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1327,6 +1327,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_kfree_name;
 	}
 
+	pci_save_state(pdev);
+
 	return 0;
 
 err_kfree_name:
@@ -1448,12 +1450,33 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
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
2.48.1



