Return-Path: <linuxppc-dev+bounces-21120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA3FCD4F57
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 14:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK1DY5tsvz2yS0;
	Tue, 19 May 2026 00:59:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779116381;
	cv=none; b=ZLwRP1XPPhgJgu7UL9VjLfTA+gzEuTo3dylcAxgNFO5OvpW7FAJGMU4UkRovkM1gXi/OMMVwcFWQmhwQUCbfVtPPUtoZ7C1uComa5GVQxu2Sy0cPVmakxUKSx6Vz8s+/Cj9AOCoZPulJ2jTQm6l0uZ4Str1jBtpeSIOVVgClWRz5Zl9ppxJXfRZKzyPpO1BQqTWYfKRooncS+ezev8cPJ4swNKOJ7xlg3BFVNR/bh8TvVTSZRA9tptO984zMy1IP6SAqW5UfZP6CI3ZGQQxxPr8y5urmYpvQKIIy/75abEW91sbHJKGBynaKYEpDMeRyOazxl8aSUZrdEhfJmocFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779116381; c=relaxed/relaxed;
	bh=v5Kj2t/nnvRCJCklm4qnm+pzJg6dhKl7rRb/ZWy5vqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zp0Je+btuD0jdvugMZG/337/T37OxAz1o8cOR89BtvAhzM0/H5ajI1jFdFhZ0QGWpwuooSMDkviHe8zwlQy/msIvZczPLp2da4oTULTtNbZgBczjBWOJTCeCESTXWyNFN5W3y5aa+ll7JOgW6JN+CA9y1cSbF3sN2K+8l4JBsSOmHy086C8i+VZ5bQuWVWjs8oagg12hXSFv4qBaEIsIg4k8miyGObzt3fy4x1fkREqXv/IiPs9ylUEOLxVQRMyo/gww8Tigv/+zuhr9O3dhr+Qg+i+5hzXyiGj+dPSKbN+fl1sqVxQpZEkch0qXs5MZga2kox5KjwVyL8OSfTFP2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=naUlmNLd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=naUlmNLd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK1DW3zdfz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 00:59:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DCCB44456B;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF662C2BCC6;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116376;
	bh=5tZEGCo7wCfylxqFJDnXkP1AKDZPWVP0KlTUW5f53Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=naUlmNLdzZNdmF7I8FSq4MwSTlr544XWn9m+fXzeUJkpc9N/dije1ZXLtebKtGzq7
	 TDA0XIb8bj9GWvSTkRvHot5/WNhv1k0oO8UD/6uJG8dNDaPgWdPNph+E8VINcC2lgQ
	 W928pSMWtGdDEiGTQ377zxGrn4V4CBt+593BBFP6efF7if9GE2QkkBIOyDNizF29Na
	 mPOawKdW3CJXxLikh4Hws1jLR4peo0MUBRY9cKNR57GembAPZvkkDWJVIUx5ROZRta
	 JYb5OECoxx9HXbSCeX0Yuu1Jt+rxtyGUqr28rDHa1cJTw5nKxbkGdanxZS3IA4OQBi
	 I5Qy64WH5aZXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E8FCD4F4A;
	Mon, 18 May 2026 14:59:36 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 18 May 2026 20:29:14 +0530
Subject: [PATCH v8 2/5] PCI/ERR: Add support for resetting the Root Ports
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
Message-Id: <20260518-pci-port-reset-v8-2-eb5a7d331dfc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=fadAkZ1kLRIswT7sEoWlHZDHy4GXaK/5Uzi4qJOgymI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqCylUQC0CnLltOm2LNknUaTUAACpnCJ3VV59Bw
 195OG/pDUuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCagspVAAKCRBVnxHm/pHO
 9Ub5B/wJfDUeumCQbnp9zPxpqe1kXfqsDRckD1Y5ckykPBLsLrTsZvBCYNgP40Uiypr1/Coi7ii
 uYM6xto+vGX13yv/p3MQMaWV2oi56o1f93EGeMLvTPJF7Qiy84R27MhA3mcx0P++l7TtopIXRmn
 SE4LeuFrPvyR5Xn5g6pIplxseyrK+JZml11C9C7jb/9PDcYHQIScAKsqoxmp6mI7uf6o7yFdewa
 a3fdUuBCrXostKMruQIAgv7ZPND7Dbg1+bdPC088nKamGAJ7rLST2LgiyAQI/7i65wdM6qcziYE
 /HK1vK7WcJA9s/F9r+k5K+TLAu5/YkNJAR7UnQ6AA+cN8nHS
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
index 8f7cfcc00090..651505b3bd60 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4809,6 +4809,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 
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
index 2c4454583c11..439dbd0d9184 100644
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
2.48.1



