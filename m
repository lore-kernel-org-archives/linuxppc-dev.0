Return-Path: <linuxppc-dev+bounces-28336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328D6C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 18:08:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htCB05WKTz2yPR;
	Mon, 28 Sep 2026 04:08:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790532536;
	cv=none; b=lEajcXRH6uGfs14xHFmwHUB4n4W2P4Wshu9GaRznnb2Qvcskl8ZErWfA4dVAB+97fYeIXdwXComuqfJNjRTQamVAvbvDlvuSzebCxBdmZ9NMBOaXvn01RTxVSoWEoicgbDLzhkU6vkWhmPTcEzv3yHk3j6mirG5HqTah3gQ+MlTXQcdN8kAHRaiywq1NdlXzzeGxLqhwv96o0A3JiE6tYsiuXZWeFp04htJxuZ6mwX8LpfKbG+8gxmdMRQTeSPZV8IhDrJ2So7yH9koNG0FZ634ms33Hw+F91V1sxeDZ6YL3Ff4Q45hw62MlXfrwm19BgK6cGrghuLli1GSVfm3D2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790532536; c=relaxed/relaxed;
	bh=vdvrQKe8jATCWFpG7oF0NnZu44KFNkY4m3klKZya/s0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=DOTbAx2uKdp2HYuN4vH8FNFWfAuFz4/0lb+KkvMMa4b56o7Bt5q1MwC6pf7fPEvI4NoqgXqabw2vJUwSi0ZlPU+DiMgI3Wp4K0xkBLCJDY0+H1CIWUmWZ6qiVd5ykCk8omkARmS6umRmzryCFd1zEXm9EZdKjsw6wRi0uqjn43WzcPoRePKTuMxxPBAUWMpm+9eeW8WCuv5UIJVNxhPz7WeNFcsA1UnMrgd7FVyQ9ynPi3/hlnBB0Vh2XflMUeJJH2TYWMsh0gfHkCBM9P/eiN8Rw9j1MI/rLxz9RAvnWQiajYecvmNQDZLAJxoFcRkbHUX59bf3zEoW8ZxIgQpyBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCB00CkQz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:08:56 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 1B9045D3;
	Sun, 27 Sep 2026 20:08:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 55F68625294D; Sun, 27 Sep 2026 20:08:52 +0200 (CEST)
Message-ID: <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:02 +0200
Subject: [PATCH 2/7] PCI/DPC: Reinstate support for AER-incapable ports
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
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

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
ownership") seemingly inadvertently constrained DPC to AER-supporting
Downstream Ports by inserting a call to pcie_aer_is_native() in
dpc_probe(), which implicitly checks for presence of an AER capability.

Drop the call.  It is superfluous because it duplicates the conditions
applied by the PCIe port service driver when it decides whether to
instantiate a DPC port service (see get_port_device_capability()).
If the conditions are not met, no port service is instantiated and
dpc_probe() isn't executed.

The only difference between the conditions in dpc_probe() and the ones in
get_port_device_capability() is the check for the AER capability, so by
removing the checks from dpc_probe(), DPC is supported on AER-incapable
Downstream Ports again.

Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.8+
---
 drivers/pci/pcie/dpc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 793a799053f1..104ff2b91f1f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -474,9 +474,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 cap;
 
-	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
-		return -ENOTSUPP;
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
-- 
2.53.0


