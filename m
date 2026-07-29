Return-Path: <linuxppc-dev+bounces-24965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFAAC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 04:53:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h90MB0QQHz2ypm;
	Wed, 29 Jul 2026 14:52:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785300773;
	cv=none; b=R4wAqAII9k3ZemnmRolY5Ex3WC9d3wxDeWQF7sKGgleccrZI05l1lWxItwFwH0NmSWJArzGZdDPR2J8XFsjJTWZ+4ELC54PWAUF3aeAgmjAxWpznHdAkmeF+bEEVBxGiOYVMx41ldIgP7GoYkHcy5E9ubSGGAlDocmOLF/S5QaInr8eHIcpqIhWgxr8hugw4l6K9zkHzCvBv7WvHEYTEC5sZXa5itmFZVfeSWGNB4LjkLRU/Rx8z5LQY+AhTtqIp9ZX1j0u5QGUbt94cPGV/pWJ6dH09lmta0/Pp7KiT4LKkarjqBtLWFUgbPbBYR3fZKDrTXNQV9eTZW7+clwE2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785300773; c=relaxed/relaxed;
	bh=Hs5nzRZgMEOGUyI2IsYJM4bUc6UtIAsg3AzDj+RfyR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aK7OSbew1Kor3QXHWbuy5Yba2I44W9CJ6Z6xFoXHfnJdL11aroUbpv0h8JZzC+eZFi0IgdDeeoS9SM4mnRMtVK/UyvszwQUqa52wrOcUVREAIuNxzVTm8sj8aFAc4H5LSU3xPgvXmItXb1U/mrqaE99PROVSKJ6u27mixB8ElIadFbaRzpWN5M1xItufvWB2R8eiM0GfEhWPhAhp/E5l3/4mssYj4fDegUAHH4MHp2VwBoapU6bOK0c6NPu1BCAK4pHVagme+M6cOqBmseFpE+5U3LIT814fgrHl1jDQB0PNL7JeiWSs88pS4hXlxI6gPOSU+oDkxvIuEeqCIDZblA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sUuiMVj0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sUuiMVj0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h90M82wqzz2ynh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:52:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 286184512B;
	Wed, 29 Jul 2026 04:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7E19C2BCFC;
	Wed, 29 Jul 2026 04:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785300767;
	bh=GXsfpuBjTP8KRmTpmgSgO41ETDhVR5I3O4GjePFOCS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sUuiMVj0WFEsLwvanb5fQyGiJ+kk72IDMDfl2b8y0FL463crsP9DRi4MU3eMFfAli
	 5W4epMPrQ5hATPueK9tFxahndIMD+Qs+E/9xu2tyjd6OLBdiQUViNtoRGvMdVGV14+
	 L2PmYi4YMAffkIsMuVjj8/iaW5Xhi/UYiM0WO+cnU2hrc4NKRvUFTtKfhJ03CX2fVa
	 /TB5wFfKLLhOMMVFqQd7a+5B22X55BcOrtX4ISOIuVbC7hyS/mQaOdBRBK0UWemyHL
	 JtQmvmqiYGC1IeiPDd0oOqIK4AMHyPskYRLkjRCGs+MR4B/9EkI1eRTgsC4Y+OLW6z
	 ftrFXZqXYy+6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FACC53219;
	Wed, 29 Jul 2026 04:52:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 29 Jul 2026 10:22:28 +0530
Subject: [PATCH v9 2/5] PCI/ERR: Add support for resetting the Root Ports
 in a platform specific way
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
Message-Id: <20260729-pci-port-reset-v9-2-53570b92064d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=1Oy19557+yV3/9OLsUixcbfzFzWsM2UYeBRw29jVti8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqaYccd5GhRxgafeOVS/QPxoXKKMCDKbr6/Y8uN
 27gAISBB3yJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCammHHAAKCRBVnxHm/pHO
 9RI1B/47y1/xQOdgi41SJopTqMvwW3CUl1cVKVXn9Dsvs2ZZIikdDnfTrq9aGJuCTVzXpqdDnLz
 eRZH2AYOjLg+OceKeoWTGOF131FgQ/Xnuj9tjF28EQhu4e3s0ZFSNV2Aq3qA1y4x0jKHCP9TRUQ
 W8Ok6P0P5dCwuRVnnvuVK1ZGK7ny7fwmEyi7+VxKh0GyI/NlOzF8dhRlfk/K8mHdagYQjA+PmdT
 82WSlklvfMpUopl3ys3GNhrZzzXY4rRBquhdvNBpL1+FG/kIj92Mig0jyyhMZjIuvkPwoijnrGk
 2BygcS8joCV6HPClOuSToRF66ZPZ5B3I3MfpLjllCIXC7tcU
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <mani@kernel.org>

Some host bridge devices require resetting the Root Ports in a platform
specific way to recover them from error conditions such as Fatal AER
errors, Link Down etc... So introduce pci_host_bridge::reset_root_port()
callback and call it from pcibios_reset_secondary_bus() if available. Also,
save the Root Port config space before reset and restore it afterwards.

The 'reset_root_port' callback is responsible for resetting the given Root
Port referenced by the 'pci_dev' pointer in a platform specific way and
bring it back to the working state if possible. If any error occurs during
the reset operation, relevant errno should be returned.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Brian Norris <briannorris@chromium.org>
Tested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.c      | 13 +++++++++++++
 drivers/pci/pcie/err.c |  5 -----
 include/linux/pci.h    |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..12e099489690 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4841,6 +4841,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int ret;
+
+	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
+		ret = host->reset_root_port(host, dev);
+		if (ret)
+			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
+		else
+			pci_restore_state(dev);
+
+		return;
+	}
+
 	pci_reset_secondary_bus(dev);
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d7..13b9d9eb714f 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -256,11 +256,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast slot_reset message\n");
 		pci_walk_bridge(bridge, report_slot_reset, &status);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ebb5b9d76360..be82cc0a3371 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -646,6 +646,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	int (*reset_root_port)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.51.0



