Return-Path: <linuxppc-dev+bounces-20279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52B5FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:27:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5GlJ2lKdz2yqf;
	Wed, 29 Apr 2026 22:27:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777465628;
	cv=none; b=LAGmn9u4O3dbnr/nVbQveP0lwiWnyb8iE/Es0WVdIS33tw2vBU5i4jbFOK2nJs7uUF2ysPL3cbS0hwYxKxEMuayru7NRCwkJLMetMeAC48SoXKUwRxPuBtOqhS5C2fv/VWiKqkT1DifeuGbFkwB7VacnZ/aAuRFGyBfIt9MrX+Qw+yT6NryY5DGJc04RHtNrun9921ZwNMEfZ/wIoiRmDkX90IEWXXj3+Fc0KvaS8IOZokzE+TNmW5bXj4BEdqyaFI1wLcPL2lcu/OeUaDnYD4xHe1Xt2ejRB1ozwqkNZID1Mjwz4U+QfUNo5of7bxIRNupoUtBjz1WAduYH8FZe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777465628; c=relaxed/relaxed;
	bh=QoVRHD6ikHXXVqy8TWHuiRhxDDfq2bW3MrQdIr323Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLSVATw2rj6dk+FSwpvWVisetS+BfGgct4MDigwExBuNUYXWDLkKMexAmcLb0/KvUvyiK5oatw4XYjjkytCriu7Enmjm7iyn1OQFxfNdX1WIjSFE5zEy50+AYQ84aDu+5pLHDOM5GcToo/878gHP60ouB79yoRR/4wAki+4QMInQOZ5hDJX5xPVtRN5yBM6jhd95E0XpIS12hahHEV6pUjgO2GGWVUNdPjz1DvXtXDGhbLGaFMV+ulIaLgzQp/UeYaDuENHtYi+g7XgU5a6oaij9+lu3n0nZkJShK4pYBy3/iXQCrcHsqVA+hCng4TumJy25DP4ts5dIwzUwy30kRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kRcA+KM5; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kRcA+KM5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5GlF46txz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:27:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465626; x=1809001626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymmlvQuMfjumemqUjGxrBNk55P+HxOLWdjtwtwvgzpE=;
  b=kRcA+KM5aUfKo1gFZQOwhr5+maSGk+CSVH2npno2YGGTDlRWEaWbf5fI
   +8EgtY9RgU6oFVx72sgdoqvWu4GGsI94V7/Mtr1JECKyeboSwhQtG+Zy/
   81QjKm29rz+mhNCOtU9KwPJgdWQfqEjjOe4kNvP6PYcVj7aKOsaqLEIQY
   IMJmc+lbVpCCZrF4OwSNq99S9vMbuO5RWIaCzoylMdyCSqn7ClijEP3rF
   iuXs5FR9MxJq1xXmgiq3pvGkBcjn1mpptGwdJtaPcL0BExqko/nJkOnxf
   IAWcQH+Mq2+RARv6i1OpUJSTPfl6xfAsy1W+/fC7QQcB7V54qEyAIPaTt
   Q==;
X-CSE-ConnectionGUID: EMknbreGR5WICE5Bi+PF9A==
X-CSE-MsgGUID: ono/YxMwRwGxhGb6MfJjMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77557721"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77557721"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:01 -0700
X-CSE-ConnectionGUID: fNI/Y3zKR6KPwPYP7o+w8w==
X-CSE-MsgGUID: JPHHKUAmRmO30ZkLOgV5fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229669749"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/11] PCI: Consolidate add_list (aka realloc_head) empty sanity checks
Date: Wed, 29 Apr 2026 15:26:09 +0300
Message-Id: <20260429122617.7324-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Callers of __pci_bridge_assign_resources() and
__pci_bus_assign_resources() perform
WARN_ON_ONCE(list_empty(add_list))) checks to sanity check that all
optional sizes were processed (and removed) from the list. The empty
list sanity check is duplicated code so the more appropriate place for
it would be inside the called function.

Placing the empty list check into __pci_bus_assign_resources() also
ensures all callsites do perform the sanity check which currently is
not the case when being called from enable_slot(). This inconsistency
was noted by Sashiko though only inside its in depth log but not
flagged as a real problem, possibly because this is only a sanity check
that should never fire. Nonetheless, this sanity check has been very
useful to catch problems early in the past so it's good to do it
consistenty everywhere.

As __pci_bus_assign_resources() is recursive function, it needs to be
renamed to __pci_bus_assign_resources_one() to only perform the empty
list check at the end of processing the entire hierarchy in
__pci_bus_assign_resources().

Suggested-by: sashiko.dev # Sanity check missing from enable_slot()
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3765693e95f0..1e0e28efe8b8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1501,9 +1501,9 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 	}
 }
 
-void __pci_bus_assign_resources(const struct pci_bus *bus,
-				struct list_head *add_list,
-				struct list_head *fail_head)
+static void __pci_bus_assign_resources_one(const struct pci_bus *bus,
+					   struct list_head *add_list,
+					   struct list_head *fail_head)
 {
 	struct pci_bus *b;
 	struct pci_dev *dev;
@@ -1517,7 +1517,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 		if (!b)
 			continue;
 
-		__pci_bus_assign_resources(b, add_list, fail_head);
+		__pci_bus_assign_resources_one(b, add_list, fail_head);
 
 		switch (dev->hdr_type) {
 		case PCI_HEADER_TYPE_BRIDGE:
@@ -1537,6 +1537,16 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 	}
 }
 
+void __pci_bus_assign_resources(const struct pci_bus *bus,
+				struct list_head *add_list,
+				struct list_head *fail_head)
+{
+	__pci_bus_assign_resources_one(bus, add_list, fail_head);
+
+	if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
+		pci_dev_res_free_list(add_list);
+}
+
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
 	__pci_bus_assign_resources(bus, NULL, NULL);
@@ -1641,6 +1651,9 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 			 pci_domain_nr(b), b->number);
 		break;
 	}
+
+	if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
+		pci_dev_res_free_list(add_list);
 }
 
 static void pci_bridge_release_resources(struct pci_bus *bus,
@@ -2205,8 +2218,6 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 
 		/* Depth last, allocate resources and update the hardware. */
 		__pci_bus_assign_resources(bus, add_list, &fail_head);
-		if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
-			pci_dev_res_free_list(add_list);
 		tried_times++;
 
 		/* Any device complain? */
@@ -2268,8 +2279,6 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		pci_bridge_distribute_available_resources(bridge, &add_list);
 
 		__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
-		if (WARN_ON_ONCE(!list_empty(&add_list)))
-			pci_dev_res_free_list(&add_list);
 		tried_times++;
 
 		if (list_empty(&fail_head))
@@ -2339,8 +2348,6 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 
 	__pci_bus_size_bridges(bridge->subordinate, &add_list);
 	__pci_bridge_assign_resources(bridge, &add_list, &failed);
-	if (WARN_ON_ONCE(!list_empty(&add_list)))
-		pci_dev_res_free_list(&add_list);
 
 	if (!list_empty(&failed)) {
 		if (pci_required_resource_failed(&failed, type))
@@ -2473,7 +2480,5 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 			__pci_bus_size_bridges(dev->subordinate, &add_list);
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
-	if (WARN_ON_ONCE(!list_empty(&add_list)))
-		pci_dev_res_free_list(&add_list);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
-- 
2.39.5


