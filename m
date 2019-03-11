Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4929CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7062087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Vji5435/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7062087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hzhr3htHzDqFp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 00:38:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="Vji5435/"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HzXZ1qCZzDqC7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:31:42 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D0640419F0;
 Mon, 11 Mar 2019 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552311093; x=1554125494; bh=JVyoC34eGmx5ip94yGCGHtFiL2Yb7i7wQdT
 eL3g7f0E=; b=Vji5435/EYsHto3qxulaR3Fsu5a2VZenvqnsNfPgWrYntsRj4yP
 7bwlGxaXAdWPuNCa5Zl9ZmC8jZCiv2tcmgpKgVIBMecz4ZGZWdUoZ75c6QMJT5nf
 rVeRwQMg+FdmWBmtOuQ0KNoKYWs3Rhz/wTzaMSIs6EfBVs1xX0oOd9oM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ng4E5I6HCMU9; Mon, 11 Mar 2019 16:31:33 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 8F9674198C;
 Mon, 11 Mar 2019 16:31:31 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:31 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 06/21] PCI: Pause the devices with movable BARs during
 rescan
Date: Mon, 11 Mar 2019 16:31:07 +0300
Message-ID: <20190311133122.11417-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Drivers indicate their support of movable BARs by implementing the
new rescan_prepare() and rescan_done() hooks in the struct pci_driver.

All device's activity must be stopped during a rescan, and iounmap()
+ioremap() must be applied to every used BAR.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 51 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h |  2 ++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 977a127ce791..88350dd56344 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3248,6 +3248,38 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+static void pci_bus_rescan_prepare(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child) {
+			pci_bus_rescan_prepare(child);
+		} else if (dev->driver &&
+			   dev->driver->rescan_prepare) {
+			dev->driver->rescan_prepare(dev);
+		}
+	}
+}
+
+static void pci_bus_rescan_done(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child) {
+			pci_bus_rescan_done(child);
+		} else if (dev->driver &&
+			   dev->driver->rescan_done) {
+			dev->driver->rescan_done(dev);
+		}
+	}
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3261,8 +3293,23 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
 
-	max = pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
+	if (pci_movable_bars_enabled()) {
+		struct pci_bus *root = bus;
+
+		while (!pci_is_root_bus(root))
+			root = root->parent;
+
+		pci_bus_rescan_prepare(root);
+
+		max = pci_scan_child_bus(root);
+		pci_assign_unassigned_root_bus_resources(root);
+
+		pci_bus_rescan_done(root);
+	} else {
+		max = pci_scan_child_bus(bus);
+		pci_assign_unassigned_bus_resources(bus);
+	}
+
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cbe661aff9f5..3d52f5538282 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -780,6 +780,8 @@ struct pci_driver {
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
+	void (*rescan_prepare)(struct pci_dev *dev);
+	void (*rescan_done)(struct pci_dev *dev);
 	const struct pci_error_handlers *err_handler;
 	const struct attribute_group **groups;
 	struct device_driver	driver;
-- 
2.20.1

