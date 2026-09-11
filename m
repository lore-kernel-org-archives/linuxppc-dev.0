Return-Path: <linuxppc-dev+bounces-27133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FADC88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:37:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFvp3556z2yqf;
	Fri, 11 Sep 2026 23:37:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789129863;
	cv=none; b=WZLfvgFMZJ3SwLe705WWK33U9vpA1tZYqPgRPKOnDNS9QzTEFz21L1oM/e5MBxkyHGDK5ZMW2hnaFePSkDGdh4xLvUuYnCPzMKojTytsW04LWO8n4GrWNlUwoCrKgrAaBVUaPyKirE5t2bgSdqetT6HG1jHJ4b5rlwmadhRegARcmd/H2QdvbDtVALXREkllWU/ymgsJvg+K86aa2a6KQNwVd5shUdQAry9sNTs2zp1xlcSvxl4vIh2sZwvfoZgJ1K8EanlgiGQ7b9PtI5SsheXZqpFnrfSrYhrqFUwY9EFHyuB4V0Y09Sv7uZmcBOYffVWQpAw8121+jSz2DYpJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789129863; c=relaxed/relaxed;
	bh=opd+WPzQfIayk9e7GEeBv5N8aZ9REoyrAqKoAc96BV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jViJvfIYpVsXqL1wbUWTsYPry1QT7f5P/iX057CQ0c5a56C8JdHBeRJp5vm/xReT4L66W3NLQhmlQw25hQ5uv2p0D1xjq/+VAwsTOg/8EwSGjy6KioKRz5xGFAJQ26FrCY3UlzX1S7DLRCjXERCmasuCzMN3dDDdUSOy3AgVkktTVaw5k6WXMqx7yAbEssYYu6iOklkxyLPR8d4rb9BDLs1G5T2aKlC/+bxTStMlP96F1OoDDCAopax5qXUIPKAFJEXEfNbg60Ub9I3vjPKxak4M7jIu5zUmXFbYyX54gJWYQYtg1pgpTk5XlJzaTa/sshbEhbb/3t34HbRQm73wRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=bDWkz4jc; dkim-atps=neutral; spf=pass (client-ip=44.246.77.92; helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=bDWkz4jc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.de (client-ip=44.246.77.92; helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org)
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDRV4GZ8z2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:31:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129862; x=1820665862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=opd+WPzQfIayk9e7GEeBv5N8aZ9REoyrAqKoAc96BV4=;
  b=bDWkz4jcwcILRDMsOKNEsv+/PYH2lRLJhkQOMJINpjisi4oYs7cs3Ehb
   tmm0sye9hur5Leikl+JTWjsPePqFhe0SwedytG+fpz/EUGnBgr1XRsgwc
   8IR7MhQgS//ZDxegqe1lyyb1fVx7PiqSM+cWnCY0CvO+GDiRZIyJGCBvV
   lTP+JQpZixhYpkvq1qZ1CSAAVEWnNgvi0wQILm5UtGu9pqGJME8anwxez
   YSZ/hcEfkXEGYLnAlAQhK1QBOSybmMOZdx5mZ+GSO2OZ0ThDQMSnTNxlW
   tuVopcWpcH0WAhsVfbpAk/VvvGugA7qVwsn6FSdY1+nAWmFAd/tRldWcS
   g==;
X-CSE-ConnectionGUID: MWmo8yIbQ/yVZfLriKnhlg==
X-CSE-MsgGUID: OkrTFEs5SgCvU9PUbqh1zA==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28418067"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:30:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:21145]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.198:2525] with esmtp (Farcaster)
 id 53f93df2-f4cc-426b-a8bf-346efb1e2633; Fri, 11 Sep 2026 12:30:57 +0000 (UTC)
X-Farcaster-Flow-ID: 53f93df2-f4cc-426b-a8bf-346efb1e2633
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:30:57 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:30:54 +0000
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
Subject: [RFC PATCH 4/8] PCI/PM: Serialize pci_bridge_d3_update()
Date: Fri, 11 Sep 2026 14:30:52 +0200
Message-ID: <20260911123052.94884-1-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_bridge_d3_update() does an unlocked read-modify-write of
bridge->bridge_d3, and its callers are not mutually serialized: the
d3cold_allowed sysfs write and the driver-context D3cold helpers hold
neither pci_rescan_remove_lock nor device_lock. A concurrent write can
lose an update and leave bridge_d3 stale, costing a wrong D3cold decision
rather than memory safety. An upcoming change runs pci_bus_add_device()
for sibling VFs concurrently, making sibling additions concurrent callers
too, so this must land first.

Add a mutex around the whole update, taken once for the propagation
loop. A device with no D3cold-capable port above it returns before the
mutex, so the common add is not funneled through a global lock, and the
loop re-evaluates both conditions under it. The mutex serializes the
updaters against each other only; the d3cold_allowed store itself still
writes an adjacent bit of the same word unlocked, a pre-existing
exposure this change neither widens nor closes. The resulting order is
pci_rescan_remove_lock, device_lock(any) -> pci_bridge_d3_lock ->
pci_bus_sem (read), so pci_bridge_d3_lock must never be acquired while
holding pci_bus_sem and no pci_walk_bus() callback may call into this
path.

The race dates back to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into
D3 during suspend"), is theoretical with no known report, and so
carries no Fixes: tag and no stable designation; it claims no measured
performance contribution.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/pci.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c62a315c0b4c..b2a159ef125b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3095,17 +3095,36 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 }
 
 /*
+ * Serializes pci_bridge_d3_update()'s bridge_d3 read-modify-writes and
+ * their upstream propagation.  Ordering: pci_rescan_remove_lock,
+ * device_lock(any) -> pci_bridge_d3_lock -> pci_bus_sem (read); no
+ * pci_walk_bus() callback may call into this path.
+ */
+static DEFINE_MUTEX(pci_bridge_d3_lock);
+
+/**
  * pci_bridge_d3_update - Update bridge D3 capabilities
  * @dev: PCI device which is changed
  *
  * Update upstream bridge PM capabilities accordingly depending on if the
  * device PM configuration was changed or the device is being removed.  The
  * change is also propagated upstream.
+ *
+ * Context: Process context. Takes and releases pci_bridge_d3_lock.
  */
 void pci_bridge_d3_update(struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
 
+	/*
+	 * Unlocked fast path; the loop condition re-evaluates both checks
+	 * under the lock.
+	 */
+	bridge = pci_upstream_bridge(dev);
+	if (!bridge || !pci_bridge_d3_possible(bridge))
+		return;
+
+	mutex_lock(&pci_bridge_d3_lock);
 	while ((bridge = pci_upstream_bridge(dev)) &&
 	       pci_bridge_d3_possible(bridge)) {
 		bool remove = !device_is_registered(&dev->dev);
@@ -3148,6 +3167,7 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 		/* Propagate change to upstream bridges */
 		dev = bridge;
 	}
+	mutex_unlock(&pci_bridge_d3_lock);
 }
 
 /**
@@ -3157,6 +3177,9 @@ void pci_bridge_d3_update(struct pci_dev *dev)
  * This function can be used in drivers to enable D3cold from the device
  * they handle.  It also updates upstream PCI bridge PM capabilities
  * accordingly.
+ *
+ * Context: Process context. Takes and releases pci_bridge_d3_lock;
+ * must not be called from a pci_walk_bus() callback.
  */
 void pci_d3cold_enable(struct pci_dev *dev)
 {
@@ -3174,6 +3197,9 @@ EXPORT_SYMBOL_GPL(pci_d3cold_enable);
  * This function can be used in drivers to disable D3cold from the device
  * they handle.  It also updates upstream PCI bridge PM capabilities
  * accordingly.
+ *
+ * Context: Process context. Takes and releases pci_bridge_d3_lock;
+ * must not be called from a pci_walk_bus() callback.
  */
 void pci_d3cold_disable(struct pci_dev *dev)
 {
-- 
2.47.3


