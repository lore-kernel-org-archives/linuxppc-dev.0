Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63395C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:08:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D495920657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="ZCJpYZ4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D495920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44J0Lv6FVnzDqKj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:08:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="ZCJpYZ4y"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HzXj05LKzDqDh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:31:49 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 33F86419E4;
 Mon, 11 Mar 2019 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552311100; x=1554125501; bh=R7IbRdTRKbIoc00RoB3Bk7kPe21b7o79Tav
 On/8ZP3w=; b=ZCJpYZ4yq7nZg/pplJqpxKb++yYp2HFPD1QEfNM40a5U9WRfntA
 htn0K5+zwZtKFyk3Kn1LHfap9GQQ8U+bJ6tMHGQ/umK83+m0k75vo9ogClTNgIO/
 3ZYFUTNodGWC4esrOQAowron+oOWXA7nZLtVJPLR0KMvBKTmwdHFZbAk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bj_zk5tmWxGs; Mon, 11 Mar 2019 16:31:40 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A95E341980;
 Mon, 11 Mar 2019 16:31:33 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:33 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 16/21] PCI: Calculate fixed areas of bridge windows
 based on fixed BARs
Date: Mon, 11 Mar 2019 16:31:17 +0300
Message-ID: <20190311133122.11417-17-s.miroshnichenko@yadro.com>
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

For every (IO, MEM, MEM64) bridge window, count the fixed resources of
its children endpoints and children bridge windows:

| <- BAR -> |    | <- child bus fixed_range_hard -> |   | <- fixed BAR -> |
                 | <-            bus's fixed_range_hard                -> |
| <-                       bus's bridge window                         -> |

These ranges will be later used to arrange bridge windows in a way which
covers every immovable BAR as well as the movable ones during hotplug.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       | 14 +++++++
 drivers/pci/probe.c     | 82 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c | 17 +++++++++
 include/linux/pci.h     |  6 +++
 4 files changed, 119 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 56b905068ac5..14e3ebe68010 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -364,6 +364,20 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return dev->error_state == pci_channel_io_perm_failure;
 }
 
+static inline int pci_get_bridge_resource_idx(struct resource *r)
+{
+	int idx = 1;
+
+	if (r->flags & IORESOURCE_IO)
+		idx = 0;
+	else if (!(r->flags & IORESOURCE_PREFETCH))
+		idx = 1;
+	else if (r->flags & IORESOURCE_MEM_64)
+		idx = 2;
+
+	return idx;
+}
+
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DEV_IGNORE 1
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 62f4058a001f..70b15654f253 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -551,6 +551,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 {
 	struct pci_bus *b;
+	int idx;
 
 	b = kzalloc(sizeof(*b), GFP_KERNEL);
 	if (!b)
@@ -567,6 +568,11 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	if (parent)
 		b->domain_nr = parent->domain_nr;
 #endif
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		b->fixed_range_hard[idx].start = (resource_size_t)-1;
+		b->fixed_range_hard[idx].end = 0;
+	}
+
 	return b;
 }
 
@@ -3337,6 +3343,81 @@ static void pci_setup_bridges(struct pci_bus *bus)
 		pci_setup_bridge(bus);
 }
 
+static void pci_bus_update_fixed_range_hard(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	int idx;
+	resource_size_t start, end;
+
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		bus->fixed_range_hard[idx].start = (resource_size_t)-1;
+		bus->fixed_range_hard[idx].end = 0;
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_fixed_range_hard(dev->subordinate);
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_BRIDGE_RESOURCES; ++i) {
+			struct resource *r = &dev->resource[i];
+
+			if (!r->flags || (r->flags & IORESOURCE_UNSET) || !r->parent)
+				continue;
+
+			if (r->flags & IORESOURCE_PCI_FIXED) {
+				idx = pci_get_bridge_resource_idx(r);
+				start = bus->fixed_range_hard[idx].start;
+				end = bus->fixed_range_hard[idx].end;
+
+				if (start > r->start)
+					start = r->start;
+				if (end < r->end)
+					end = r->end;
+
+				if (bus->fixed_range_hard[idx].start != start ||
+				    bus->fixed_range_hard[idx].end != end) {
+					dev_dbg(&bus->dev, "%s: Found fixed 0x%llx-0x%llx in %s, expand the fixed bridge window %d to 0x%llx-0x%llx\n",
+						__func__,
+						(unsigned long long)r->start,
+						(unsigned long long)r->end,
+						dev_name(&dev->dev), idx,
+						(unsigned long long)start,
+						(unsigned long long)end);
+					bus->fixed_range_hard[idx].start = start;
+					bus->fixed_range_hard[idx].end = end;
+				}
+			}
+		}
+
+		if (dev->subordinate) {
+			struct pci_bus *child = dev->subordinate;
+
+			for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+				start = bus->fixed_range_hard[idx].start;
+				end = bus->fixed_range_hard[idx].end;
+
+				if (start > child->fixed_range_hard[idx].start)
+					start = child->fixed_range_hard[idx].start;
+				if (end < child->fixed_range_hard[idx].end)
+					end = child->fixed_range_hard[idx].end;
+
+				if (start < bus->fixed_range_hard[idx].start ||
+				    end > bus->fixed_range_hard[idx].end) {
+					dev_dbg(&bus->dev, "%s: Expand the fixed bridge window %d from %s to 0x%llx-0x%llx\n",
+						__func__, idx, dev_name(&child->dev),
+						(unsigned long long)start,
+						(unsigned long long)end);
+					bus->fixed_range_hard[idx].start = start;
+					bus->fixed_range_hard[idx].end = end;
+				}
+			}
+		}
+	}
+}
+
 static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -3437,6 +3518,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_bus_rescan_prepare(root);
 
 		max = pci_scan_child_bus(root);
+		pci_bus_update_fixed_range_hard(root);
 
 		pci_reassign_root_bus_resources(root);
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c1559a4a8564..a1fd7f3c5ea8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -879,9 +879,17 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
+	resource_size_t fixed_start = bus->fixed_range_hard[0].start;
+	resource_size_t fixed_end = bus->fixed_range_hard[0].end;
+	resource_size_t fixed_size = (fixed_start < fixed_end) ?
+		(fixed_end - fixed_start + 1) : 0;
+
 	if (!b_res)
 		return;
 
+	if (min_size < fixed_size)
+		min_size = fixed_size;
+
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
@@ -990,6 +998,15 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	bool is_mem64 = (mask & IORESOURCE_MEM_64);
+
+	resource_size_t fixed_start = bus->fixed_range_hard[is_mem64 ? 2 : 1].start;
+	resource_size_t fixed_end = bus->fixed_range_hard[is_mem64 ? 2 : 1].end;
+	resource_size_t fixed_size = (fixed_start < fixed_end) ?
+		(fixed_end - fixed_start + 1) : 0;
+
+	if (min_size < fixed_size)
+		min_size = fixed_size;
 
 	if (!b_res)
 		return -ENOSPC;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 26aa59cb6220..7a4d62d84bc1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -572,6 +572,12 @@ struct pci_bus {
 	struct list_head resources;	/* Address space routed to this bus */
 	struct resource busn_res;	/* Bus numbers routed to this bus */
 
+	/*
+	 * If there are fixed resources in the bridge window, the hard range
+	 * contains the lowest and the highest addresses of them.
+	 */
+	struct resource fixed_range_hard[PCI_BRIDGE_RESOURCE_NUM];
+
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
-- 
2.20.1

