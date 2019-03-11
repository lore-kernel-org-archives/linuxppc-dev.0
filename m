Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D3C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 13:44:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1173206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 13:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="n2mFSY5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1173206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hzpp0HRXzDqDl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 00:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="n2mFSY5G"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HzXc49FXzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:31:44 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D040C419E8;
 Mon, 11 Mar 2019 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552311092; x=1554125493; bh=D+5t+XYJy2whiChmoUpciLcCd/RVrE0+9uo
 ha9o9Ma8=; b=n2mFSY5GApvd3DVC4xRrJJKCx8udjGs2eELsWla2kVeSoyNjMk1
 MN7MuXfiGJOBuIuXE4w6Aoaq0OQJpukJ4LsQnqhoRiI76y23CmIXey62WeLkTqeW
 aeF6F+t/4QrKbuSZJ3qK/c0rKZW++ZFANk53L8/FhaIFe29CBbZEO3NE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vN0iJy3olqB8; Mon, 11 Mar 2019 16:31:32 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 35CCB41987;
 Mon, 11 Mar 2019 16:31:31 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:30 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 04/21] PCI: Define PCI-specific version of the
 release_child_resources()
Date: Mon, 11 Mar 2019 16:31:05 +0300
Message-ID: <20190311133122.11417-5-s.miroshnichenko@yadro.com>
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

Make the released resources of a bridge valid for later re-assignment:
clear the STARTALIGN flag.

Resources marked with PCI_FIXED must preserve their offset and size.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 47 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ec44a0f3a7ac..3644feb13179 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1483,6 +1483,51 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
 	 IORESOURCE_MEM_64)
 
+/*
+ * Similar to release_child_resources(), but aware of PCI_FIXED and STARTALIGN flags
+ */
+static void pci_release_child_resources(struct resource *r)
+{
+	struct resource *tmp, *p;
+
+	if (!r)
+		return;
+
+	if (r->flags & IORESOURCE_PCI_FIXED)
+		return;
+
+	p = r->child;
+	r->child = NULL;
+	while (p) {
+		resource_size_t size = resource_size(p);
+
+		tmp = p;
+		p = p->sibling;
+
+		tmp->parent = NULL;
+		tmp->sibling = NULL;
+		pci_release_child_resources(tmp);
+
+		if (!tmp->flags)
+			continue;
+
+		if (tmp->flags & IORESOURCE_PCI_FIXED) {
+			pr_debug("PCI: release fixed %pR (%s), keep its flags, base and size\n",
+				 tmp, tmp->name);
+			continue;
+		}
+
+		pr_debug("PCI: release %pR (%s)\n", tmp, tmp->name);
+
+		/* need to restore size, and keep all the flags but STARTALIGN */
+		tmp->start = 0;
+		tmp->end = size - 1;
+
+		tmp->flags &= ~IORESOURCE_STARTALIGN;
+		tmp->flags |= IORESOURCE_SIZEALIGN;
+	}
+}
+
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					  unsigned long type)
 {
@@ -1528,7 +1573,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	 * if there are children under that, we should release them
 	 *  all
 	 */
-	release_child_resources(r);
+	pci_release_child_resources(r);
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
-- 
2.20.1

