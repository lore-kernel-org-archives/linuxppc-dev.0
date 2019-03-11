Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6837C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:13:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5054E2075C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="C/jBGkrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5054E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44J0Sb1VhTzDqN0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:13:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="C/jBGkrT"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HzXj74hjzDqF1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:31:49 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 4013C41860;
 Mon, 11 Mar 2019 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552311102; x=1554125503; bh=ES4IHYHawY+rGNAmCsSDSgYU25ke2e/UjSw
 9HcjfDXE=; b=C/jBGkrTep+X72mxk3fx8zgYxE9ykTcnb9p1pCoQRm5n117jRAB
 PvE9q5+g09D3y3qIg8MQUHUjKJPIA0LlyaAsHcH44w5J5pPUxL6908ORCOvel86T
 yur4iLHhFKDFwzHr2Qx9/SafCGFpH70CfkWqdgq/SgzqtG5P0QUz1l04=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yF24H1U3X0Y8; Mon, 11 Mar 2019 16:31:42 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 0873E419E9;
 Mon, 11 Mar 2019 16:31:34 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:33 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 18/21] PCI: Make sure bridge windows include their
 fixed BARs
Date: Mon, 11 Mar 2019 16:31:19 +0300
Message-ID: <20190311133122.11417-19-s.miroshnichenko@yadro.com>
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

Consider previously calculated boundaries when allocating a bridge
window, setting the lowest allowed address and checking the result.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/bus.c       |  2 +-
 drivers/pci/setup-res.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index a9784144d6f2..ce2d2aeedbd3 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -192,7 +192,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		 * this is an already-configured bridge window, its start
 		 * overrides "min".
 		 */
-		if (avail.start)
+		if (min_used < avail.start)
 			min_used = avail.start;
 
 		max = avail.end;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 732d18f60f1b..04442339548d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -248,9 +248,22 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	struct resource *res = dev->resource + resno;
 	resource_size_t min;
 	int ret;
+	resource_size_t start = (resource_size_t)-1;
+	resource_size_t end = 0;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
+	if (dev->subordinate && resno >= PCI_BRIDGE_RESOURCES) {
+		struct pci_bus *child_bus = dev->subordinate;
+		int b_resno = resno - PCI_BRIDGE_RESOURCES;
+		resource_size_t soft_start = child_bus->fixed_range_soft[b_resno].start;
+
+		start = child_bus->fixed_range_hard[b_resno].start;
+		end = child_bus->fixed_range_hard[b_resno].end;
+		if (start < end)
+			min = soft_start;
+	}
+
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
 	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
@@ -262,7 +275,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
 	if (ret == 0)
-		return 0;
+		goto check_fixed;
 
 	/*
 	 * If the prefetchable window is only 32 bits wide, we can put
@@ -274,7 +287,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 					     IORESOURCE_PREFETCH,
 					     pcibios_align_resource, dev);
 		if (ret == 0)
-			return 0;
+			goto check_fixed;
 	}
 
 	/*
@@ -287,6 +300,20 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
 
+check_fixed:
+	if (ret == 0 && start < end) {
+		if (res->start > start || res->end < end) {
+			dev_err(&bus->dev, "%s: fixed area 0x%llx-0x%llx for %s doesn't fit in the allocated %pR (0x%llx-0x%llx)",
+				__func__,
+				(unsigned long long)start, (unsigned long long)end,
+				dev_name(&dev->dev),
+				res, (unsigned long long)res->start,
+				(unsigned long long)res->end);
+			release_resource(res);
+			return -1;
+		}
+	}
+
 	return ret;
 }
 
-- 
2.20.1

