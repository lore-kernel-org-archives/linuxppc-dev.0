Return-Path: <linuxppc-dev+bounces-29016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E26CA6002
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 00:07:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0VgH3bMcz2y8r;
	Thu, 08 Oct 2026 11:07:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791379157;
	cv=none; b=HQnQpv6szn9wW3Isblv/hXLkU025R2X70DdErIatO+HoP6qDsOsCN/3xhBDHUY4Nv85JCzTaCGgpKQs31dF5G0i3Xxloh37XdtzL5jWZyt0a8SJhhOtFWEvme3ciKA0ix3IqibCB2HWqPpNjCZSdw5itzmlaA3KatoF0Wq+SBypuxNuNqa6kcCcXOOFDuftB0EnobjZaI2PCs1L21gE5YlIzQYs+0fZ21ncR3sIP5IMwnOHyHKxokde6NMzyil4Ze+RX5r9lHn1XiwVPFpwT2PlIclbEayHJTQA/CWLfxkgBxOoq7IEUqu5cWHKsGiFGPjdK9EpsIuYtCR5JvLDC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791379157; c=relaxed/relaxed;
	bh=UinKWqIbgjSBn0S0/ReeQkmBlx3lLuVFDaLY0ELTIy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5GpVl/h+EH2kVnvrVkhiA5ig2WC0AdJc4JZT48SZPETu3VLfclWAu0BPNOVdoc0bJBNxVK8Aa7z3Xv2zX0lcV1EpTFuAjhmKZYzYwniFCfuqVSwYCCwdBSt7T64vALTqb4uIMRXUIO7UMrCCfudX32BIcdggL875WrMclyRtGUrEp6uA0hottL2W08RliLNu+VUWcl5hETe0siBloM8yJ5dAo3baLRk6a2wj33ucLOCvhOYiqQL7ZCopPo3gpbGnkQsVuwfw6OPa0QQUiKddtg7C8Jr7Wh1OR/rvHvdJFNWvE7v9x+mw3xXlnHVZdljKgG63nGwb/5ayMg20FIDuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=itx.no; dkim=pass (1024-bit key; secure) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=cYKP8h8C; dkim-atps=neutral; spf=pass (client-ip=91.189.121.228; helo=mx.itxnorge.no; envelope-from=stian@itx.no; receiver=lists.ozlabs.org) smtp.mailfrom=itx.no
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=cYKP8h8C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=itx.no (client-ip=91.189.121.228; helo=mx.itxnorge.no; envelope-from=stian@itx.no; receiver=lists.ozlabs.org)
X-Greylist: delayed 353 seconds by postgrey-1.37 at boromir; Thu, 08 Oct 2026 00:19:14 AEDT
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0DH63W9zz2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 00:19:13 +1100 (AEDT)
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791378794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UinKWqIbgjSBn0S0/ReeQkmBlx3lLuVFDaLY0ELTIy0=;
	b=cYKP8h8CMke1eXZTCl6uC9/ujdqhmiUMfBFE4Q6AbdQcpNSNtzlrUHw1SBuou+tkUyQ2eR
	HS7EBt3esxlFYTAJ2Vv5RLOX+2Oty2jKRm78tyOrijXlpSZE+8+TiyL1TAkJN3R2fpOhta
	tV/HOQCkkI12OuqmJPZXr95SjQiSy3k=
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
Date: Wed,  7 Oct 2026 15:13:04 +0200
Message-ID: <20261007131304.309511-1-stian@itx.no>
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
Content-Transfer-Encoding: 8bit

sparc64 and powerpc create PCI devices from the device tree in
of_create_pci_dev(), which calls set_pcie_port_type() but not
pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
pci_setup_device(), so it stays 0 for these devices.
pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
reads "Unknown", and the failed link retraining quirk passes
PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
T7-1:

  WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0x2e0

Set supported_speeds in set_pcie_port_type(), which all three paths
call.

Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
Closes: https://github.com/sparclinux/issues/issues/109
Signed-off-by: Stian Halseth <stian@itx.no>
---
Tested on a SPARC T7-1: before, max_link_speed reads "Unknown" and the
warning above appears with CONFIG_PCIEPORTBUS; after, all 23 PCIe
devices report their real speed and the quirk lifts the 2.5GT/s
restriction without a warning. Not tested on powerpc.

 drivers/pci/probe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..52a79b033b069 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1651,6 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		pdev->aspm_l1_support = 1;
 #endif
 
+	pdev->supported_speeds = pcie_get_supported_speeds(pdev);
+
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
 		return;
@@ -2074,9 +2076,6 @@ int pci_setup_device(struct pci_dev *dev)
 
 	set_pcie_untrusted(dev);
 
-	if (pci_is_pcie(dev))
-		dev->supported_speeds = pcie_get_supported_speeds(dev);
-
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
-- 
2.43.0


