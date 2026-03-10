Return-Path: <linuxppc-dev+bounces-17966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C88CFD2D9F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:02:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVbDJ1VC0z3cBW;
	Wed, 11 Mar 2026 01:02:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773151344;
	cv=none; b=QqUoQQ4kHAm1hIH474yjX6wJBglDMX2Wz78E5cfK/RcML9IzULJtQY4xfortm3vSMUl2mu2mi0Ea97Fg8ACZejGiNRpjxJ0z/l+Nol8MnvGpiBG+dbM/sID9i13XHI+K71d8fRLPHkcscipcLf02v4YKwD1V3GmWGm7ptijtl4hSVOmaFV5r5YpgAzVZYZqH6AXhfq9VZ5JLlnzedhc7ZhnuV9NBD2CfgkBKxFctyHIN58q9r5kBMthr8xyH0tcsTEiaVKj0aZKw+luNU8ultlyrVkZ46Ha/ckQXYrG6F9sLNQPf5XZanV4Jkpso57fufCy6bx4FNbRMdfnsF1d+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773151344; c=relaxed/relaxed;
	bh=N7Io69iN4XQqiZmwh90189e9g+EbBG7K7t0X4ttLhHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ob83zLhW/ApFpP2gD9Jn73GthcXSh4Fd0LuVZqasjlnYErqr5TmEpECNNT7KDrw1Lw+ELJ0VD1hIcUvxg3drARQVfLgC3vJIno2VF6r2YYNhHHhej59evWcw9+HS6/ixBntmEHE5Nbauk72iRAkHl1Wk4srbJ8NfnsCckQ7RnT/C5iahLa5yG5uh+YzL1Xl1A+GWyhkIXGeNHE4z3T2fnbsAatbSuF8D1qmNUvDz20lQrvtkx6vMPal2H+M44ieNjsLl7K3OtypkSJXMMJkJiLYtUDWrdbqvfy1cF4oXUQc4I6gfSQaNcItSVD63qaMY5KZnIJrWgzfZHJhii142yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GSe55bPC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GSe55bPC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVbDH1jzrz3cB5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 01:02:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BCBF44569;
	Tue, 10 Mar 2026 14:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00D6FC2BC9E;
	Tue, 10 Mar 2026 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773151341;
	bh=edmDDU4cN1Ws9FOsj1VWeSrDdLhWCsAnDzCZhRGhVas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GSe55bPCDYa+ovAH+ER7/d3wXQSaf0faFiaHXuQm7GykBR0Swm0h6NF31czljzQMR
	 IRhwZTN5sSA7QMxUGpM8ekNFXozCA8GvufM0vRyzuin6rWGeiqpFywDgwibVhWYAkF
	 j/9Gydx+aADEvWUJQwbP4tmah1WJ0uFdHg5e3kvQ9vY3pLDkcHzZ7EYLE7Rhf24Cwb
	 t8OQ67qSMC9wmio4JUDqyLbzWapw68Zexg7Kgy4leMm6cPE9/EOkZ8daMhBK4E41uN
	 HILeblvuJLUOUG0OaDeGtb6di4pbBmqgc2fnWojTMfy3HRXusrc8n2LkMBWhp8CMVy
	 k8JGnvEUEHUhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E876DEA8550;
	Tue, 10 Mar 2026 14:02:20 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 10 Mar 2026 19:32:02 +0530
Subject: [PATCH v7 4/4] misc: pci_endpoint_test: Add AER error handlers
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
Message-Id: <20260310-pci-port-reset-v7-4-9dd00ccc25ab@oss.qualcomm.com>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
In-Reply-To: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=+inIWavtaRJNM7OF0f6BOjivOkjaJ84sX0AUbJFUxOQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpsCRqF3ko4N0ymgpexjeuogA2o6z3MOYvAQA08
 ytkZacXUEuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCabAkagAKCRBVnxHm/pHO
 9X3qB/4tpolEHvIN/p5PLjjCjCIC25XWplRB+gVV5NjJ6DN5UiiI+xjy/VzC4vwEtEfMiM+L9s3
 79nhdwb3gg4aOICVpxQ+AkP6RUfFDD19XGoYEwpqSiS/++1pN2DGrEWy/wJ4CuRPT3NZ3NGXrKe
 CTiyldjCVayhqrvNDwLOv6hlHX5HBxLif4gpZJgLSGIiBl+KSluToo/y0YGW+jarmLa1KlrqC1+
 aVwUitoWo4N5tRh49OWSASn1QOjTOHekgBOoK6r4OonXTs/hB1X8U9ZIp4+debStkJO+d0ySyVE
 6631LGw4yl7h6lX8ib6dVIJ8IpSqQ2AN24qFMgFACqX9Dyel
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

This Endpoint test driver doesn't need to do anything fancy in its error
handlers, but just report the correct result. This helps in making sure
that the AER recovery succeeds. Otherwise, AER recovery results in below
log:

 AER: device recovery failed

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/misc/pci_endpoint_test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 74ab5b5b9011..4024fd72fc66 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1422,12 +1422,32 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
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



