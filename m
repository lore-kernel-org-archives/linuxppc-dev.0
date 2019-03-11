Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5510C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:06:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CD320657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Scguby7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CD320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44J0K53BxqzDqHW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:06:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="Scguby7+"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HzXj6wrXzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:31:49 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 483DC419DD;
 Mon, 11 Mar 2019 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552311102; x=1554125503; bh=v4RqgUFHH6GplQ7nmnx9ZtEMNEIUG8asLgr
 rg3uwImo=; b=Scguby7+Eur4COPC1ALrnHWBX0JboLuSkw5xeQ51qAEhT7QC8hZ
 N0KyURfjcWznw1O65QSJF07DOnAnY9A/2NIjjOVjMu6KC4feU7Lu0lcoXCpbe6iY
 mXErXuM7br3MUbPk34pj4UpE4hVaF6QXJnOg7TvG1duT5t2Q0gclXY60=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v3ap44qg5gAG; Mon, 11 Mar 2019 16:31:42 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id D4E7741987;
 Mon, 11 Mar 2019 16:31:33 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:33 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 17/21] PCI: Calculate boundaries for bridge windows
Date: Mon, 11 Mar 2019 16:31:18 +0300
Message-ID: <20190311133122.11417-18-s.miroshnichenko@yadro.com>
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

If a bridge window contains fixed areas (there are PCIe devices with
immovable BARs located on this bus), this window must be allocated
within the bound memory area, limited by windows size and by address
range of fixed resources, calculated as follows:

           | <--     bus's fixed_range_hard   --> |
  | <--  fixed_range_hard.end - window size   --> |
           | <--  fixed_range_hard.start + window size   --> |
  | <--                bus's fixed_range_soft            --> |

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 56 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  4 ++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a1fd7f3c5ea8..f4737339d5ec 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1809,6 +1809,61 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 }
 #endif
 
+static void pci_bus_update_fixed_range_soft(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *parent = bus->parent;
+	int idx;
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_fixed_range_soft(dev->subordinate);
+
+	if (!parent || !bus->self)
+		return;
+
+	for (idx = 0; idx < ARRAY_SIZE(bus->fixed_range_hard); ++idx) {
+		struct resource *r;
+		resource_size_t soft_start, soft_end;
+		resource_size_t hard_start = bus->fixed_range_hard[idx].start;
+		resource_size_t hard_end = bus->fixed_range_hard[idx].end;
+
+		if (hard_start > hard_end)
+			continue;
+
+		r = bus->resource[idx];
+
+		soft_start = hard_end - resource_size(r) + 1;
+		soft_end = hard_start + resource_size(r) - 1;
+
+		if (soft_start > hard_start)
+			soft_start = hard_start;
+
+		if (soft_end < hard_end)
+			soft_end = hard_end;
+
+		list_for_each_entry(dev, &parent->devices, bus_list) {
+			struct pci_bus *sibling = dev->subordinate;
+			resource_size_t s_start, s_end;
+
+			if (!sibling || sibling == bus)
+				continue;
+
+			s_start = sibling->fixed_range_hard[idx].start;
+			s_end = sibling->fixed_range_hard[idx].end;
+
+			if (s_start > s_end)
+				continue;
+
+			if (s_end < hard_start && s_end > soft_start)
+				soft_start = s_end;
+		}
+
+		bus->fixed_range_soft[idx].start = soft_start;
+		bus->fixed_range_soft[idx].end = soft_end;
+	}
+}
+
 /*
  * first try will not touch pci bridge res
  * second and later try will clear small leaf bridge res
@@ -1847,6 +1902,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
 	__pci_bus_size_bridges(bus, add_list);
+	pci_bus_update_fixed_range_soft(bus);
 
 	/* Depth last, allocate resources and update the hardware. */
 	__pci_bus_assign_resources(bus, add_list, &fail_head);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7a4d62d84bc1..75a56db73ad4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -574,9 +574,11 @@ struct pci_bus {
 
 	/*
 	 * If there are fixed resources in the bridge window, the hard range
-	 * contains the lowest and the highest addresses of them.
+	 * contains the lowest and the highest addresses of them, and this
+	 * bridge window must reside within the soft range.
 	 */
 	struct resource fixed_range_hard[PCI_BRIDGE_RESOURCE_NUM];
+	struct resource fixed_range_soft[PCI_BRIDGE_RESOURCE_NUM];
 
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
-- 
2.20.1

