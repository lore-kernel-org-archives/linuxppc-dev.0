Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfVVl6hxgzDqPH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 23:45:51 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 23:45:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 37F603578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 23:45:39 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u35DjQ7T12190132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 23:45:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u35Dj0pa032180
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 23:45:01 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v5 2/7] PCI: Do not Use IORESOURCE_STARTALIGN to identify bridge
 resources
Date: Tue,  5 Apr 2016 21:43:30 +0800
Message-Id: <1459863813-2830-3-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we use the IORESOURCE_STARTALIGN to identify
bridge resources in __assign_resources_sorted().
That's quite fragile. We can't make sure that
the PCI devices' resources will not use
IORESOURCE_STARTALIGN any more.

In this patch, we try to use a more robust way
to identify bridge resources.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..bffcf1e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -391,6 +391,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
+	int index;
 
 	/* Check if optional add_size is there */
 	if (!realloc_head || list_empty(realloc_head))
@@ -411,11 +412,14 @@ static void __assign_resources_sorted(struct list_head *head,
 
 		/*
 		 * There are two kinds of additional resources in the list:
-		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
+		 * 1. bridge resource
+		 * 2. SR-IOV resource
 		 * Here just fix the additional alignment for bridge
 		 */
-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
+		index = dev_res->res - dev_res->dev->resource;
+		if (pci_is_bridge(dev_res->dev) &&
+			index >= PCI_BRIDGE_RESOURCES &&
+			index <= PCI_BRIDGE_RESOURCE_END)
 			continue;
 
 		add_align = get_res_add_align(realloc_head, dev_res->res);
-- 
1.7.9.5
