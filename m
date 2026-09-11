Return-Path: <linuxppc-dev+bounces-27132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DB6C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:37:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFvg6DJSz2yqL;
	Fri, 11 Sep 2026 23:37:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789129806;
	cv=none; b=JywSi6FXjsp0sd3Nx/pOPgYildpbAZ+9E7/5z6CvUCKMyCFP8Gy4bwReuIWFXBXaLWGt3lEQs7j+esCmu1Oo9Df1TccEmrqJgIq71r27DdaxRKvCMCP69SdyHwim6gtKlDiwILqQV7h8bcRGkKf9wififuGvhHm97Kd+UZWGB4ia3+2YSMyBQC6vDUY1Z3lhutHE7ZLTGMSAL8/uwd0IuqlglAc88APJg/KbrmX8A1Z/y97XNkyug9MZHWh/to/2p5FiQv4r+4rkoJWrOe73etUauCGdJUXoO58O8LoZvjLWhsixiGK3OllAeM0WLFIuROzh2HlHmr+MzBjcJ0W40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789129806; c=relaxed/relaxed;
	bh=76//lFNoD73PWgho8H4Yagi2iOr5lIAS/w2o2f0iL7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHHRC1CdRnue5G2RwOPSCqaXiF8emDwi2fJ56znFYVySyjnU2ipF7WJAcZGfeFU8meKSM1TP2cSEbOFNGU0n+vMV2abja9mOnKaI3j1vGBttjrtD9KGDIb7f6nvhsgztvNcNlxsJzE26DmGqTSJz3HA8GfTR0qQk6rXmARX8ygBsxURZjxcmiPsXmwXs7Nrcx/J9912NzTwchQbBuPtH3UHBIULa+hDdWg4lxA0jrm1cY7GkY+7zfPhsK33KhRNGI/MkTm1Yv5AUjzgfTuxw0uWqatcibIElV7Xt2flV2DRZTY3NOgVXDGpIgm/pWAFmdh1YnSL99dPMv8kzLoL1iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=goybNU4J; dkim-atps=neutral; spf=pass (client-ip=52.12.53.23; helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=goybNU4J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.de (client-ip=52.12.53.23; helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org)
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDQP581jz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:30:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129805; x=1820665805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76//lFNoD73PWgho8H4Yagi2iOr5lIAS/w2o2f0iL7E=;
  b=goybNU4JXvSARFdDDoeSkR31fh8TqnFEZYMN9WW1upRdaX5lIhWnYBi9
   PSH0812p8jfEogtjAhNaY9XgDfjtWbghBvNL2LM8ULzGvVxaTWSsd4Ogi
   MHzsJOXeWu7rbqsqBdBbUi6tFskMbwboLhWarQu7/KEmTOyybTAH2FKOz
   7rTY6bVm7RuXEpzVS9gSLghiaIfpDfLRdPZR6YK5U7MlYRBaXnsnqBs4h
   qwaaiXFwZg8D3t+P60vTU3Qcyc/nzIUBDWY0d4fdMGd350jiA2BzqNHjx
   1MRUPNK2JUew2CceGu1P0WwLrl+n/pnDTOAgRPCd7a6lInVpaaJr6jlJW
   Q==;
X-CSE-ConnectionGUID: ZRF+sWN8SxyaluaZFeHopg==
X-CSE-MsgGUID: pjbUDy3lSES4SHUcYAZPSA==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28293784"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:30:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15106]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.198:2525] with esmtp (Farcaster)
 id 0ebb7c56-e5f4-4c1a-a205-8c4760150ebb; Fri, 11 Sep 2026 12:30:03 +0000 (UTC)
X-Farcaster-Flow-ID: 0ebb7c56-e5f4-4c1a-a205-8c4760150ebb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:30:02 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:30:00 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kees Cook <kees@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, "Ionut
 Nechita" <ionut.nechita@windriver.com>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 3/8] PCI/PM: Convert pci_bridge_d3_update() recursion to iteration
Date: Fri, 11 Sep 2026 14:29:58 +0200
Message-ID: <20260911122958.88717-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
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
Content-Type: text/plain
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_bridge_d3_update() propagates a bridge_d3 change to upstream bridges
by tail recursion: when a bridge's bridge_d3 value changes, the function
calls itself with that bridge as the new device.

Convert the tail recursion into an iterative loop. Each level recomputes
"remove" and d3cold_ok exactly as the recursive call did for its own
device, and the early returns become loop exits. No functional change
intended.

An upcoming change serializes this update with a mutex; the iterative
form lets that mutex be taken once per external call instead of once per
bridge level.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/pci.c | 67 +++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..c62a315c0b4c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3104,46 +3104,49 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
  */
 void pci_bridge_d3_update(struct pci_dev *dev)
 {
-	bool remove = !device_is_registered(&dev->dev);
 	struct pci_dev *bridge;
-	bool d3cold_ok = true;
 
-	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
-		return;
+	while ((bridge = pci_upstream_bridge(dev)) &&
+	       pci_bridge_d3_possible(bridge)) {
+		bool remove = !device_is_registered(&dev->dev);
+		bool d3cold_ok = true;
 
-	/*
-	 * If D3 is currently allowed for the bridge, removing one of its
-	 * children won't change that.
-	 */
-	if (remove && bridge->bridge_d3)
-		return;
+		/*
+		 * If D3 is currently allowed for the bridge, removing one of
+		 * its children won't change that.
+		 */
+		if (remove && bridge->bridge_d3)
+			break;
 
-	/*
-	 * If D3 is currently allowed for the bridge and a child is added or
-	 * changed, disallowance of D3 can only be caused by that child, so
-	 * we only need to check that single device, not any of its siblings.
-	 *
-	 * If D3 is currently not allowed for the bridge, checking the device
-	 * first may allow us to skip checking its siblings.
-	 */
-	if (!remove)
-		pci_dev_check_d3cold(dev, &d3cold_ok);
+		/*
+		 * If D3 is currently allowed for the bridge and a child is
+		 * added or changed, disallowance of D3 can only be caused by
+		 * that child, so we only need to check that single device,
+		 * not any of its siblings.
+		 *
+		 * If D3 is currently not allowed for the bridge, checking the
+		 * device first may allow us to skip checking its siblings.
+		 */
+		if (!remove)
+			pci_dev_check_d3cold(dev, &d3cold_ok);
 
-	/*
-	 * If D3 is currently not allowed for the bridge, this may be caused
-	 * either by the device being changed/removed or any of its siblings,
-	 * so we need to go through all children to find out if one of them
-	 * continues to block D3.
-	 */
-	if (d3cold_ok && !bridge->bridge_d3)
-		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
-			     &d3cold_ok);
+		/*
+		 * If D3 is currently not allowed for the bridge, this may be
+		 * caused either by the device being changed/removed or any of
+		 * its siblings, so we need to go through all children to find
+		 * out if one of them continues to block D3.
+		 */
+		if (d3cold_ok && !bridge->bridge_d3)
+			pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
+				     &d3cold_ok);
+
+		if (bridge->bridge_d3 == d3cold_ok)
+			break;
 
-	if (bridge->bridge_d3 != d3cold_ok) {
 		bridge->bridge_d3 = d3cold_ok;
+
 		/* Propagate change to upstream bridges */
-		pci_bridge_d3_update(bridge);
+		dev = bridge;
 	}
 }
 
-- 
2.47.3


