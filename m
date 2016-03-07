Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40C511A0B72
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 18:49:16 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 13:19:13 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u277mrhr11599908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 13:18:53 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u277n0fJ025848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 13:19:03 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 2/7] PCI: Use IORESOURCE_WINDOW to identify bridge
 resources
Date: Mon,  7 Mar 2016 15:48:33 +0800
Message-Id: <1457336918-3893-3-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we use the IORESOURCE_STARTALIGN to identify bridge
resources in __assign_resources_sorted(). But there would
be some problems because some PCI devices' resources may
also use IORESOURCE_STARTALIGN, e.g. using "noresize"
option of resource_alignment kernel parameter.

So this patch replaces IORESOURCE_STARTALIGN with
IORESOURCE_WINDOW.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..4ff10ca 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -411,11 +411,11 @@ static void __assign_resources_sorted(struct list_head *head,
 
 		/*
 		 * There are two kinds of additional resources in the list:
-		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
+		 * 1. bridge resource -- IORESOURCE_WINDOW
+		 * 2. SR-IOV resource
 		 * Here just fix the additional alignment for bridge
 		 */
-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
+		if (!(dev_res->res->flags & IORESOURCE_WINDOW))
 			continue;
 
 		add_align = get_res_add_align(realloc_head, dev_res->res);
@@ -956,7 +956,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	b_res->start = min_align;
 	b_res->end = b_res->start + size0 - 1;
-	b_res->flags |= IORESOURCE_STARTALIGN;
+	b_res->flags |= IORESOURCE_STARTALIGN | IORESOURCE_WINDOW;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
@@ -1104,7 +1104,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	}
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
-	b_res->flags |= IORESOURCE_STARTALIGN;
+	b_res->flags |= IORESOURCE_STARTALIGN | IORESOURCE_WINDOW;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx add_align %llx\n",
@@ -1140,7 +1140,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	 */
 	b_res[0].start = pci_cardbus_io_size;
 	b_res[0].end = b_res[0].start + pci_cardbus_io_size - 1;
-	b_res[0].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
+	b_res[0].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN |
+			  IORESOURCE_WINDOW;
 	if (realloc_head) {
 		b_res[0].end -= pci_cardbus_io_size;
 		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
@@ -1152,7 +1153,8 @@ handle_b_res_1:
 		goto handle_b_res_2;
 	b_res[1].start = pci_cardbus_io_size;
 	b_res[1].end = b_res[1].start + pci_cardbus_io_size - 1;
-	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
+	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN |
+			  IORESOURCE_WINDOW;
 	if (realloc_head) {
 		b_res[1].end -= pci_cardbus_io_size;
 		add_to_list(realloc_head, bridge, b_res+1, pci_cardbus_io_size,
@@ -1190,7 +1192,7 @@ handle_b_res_2:
 		b_res[2].start = pci_cardbus_mem_size;
 		b_res[2].end = b_res[2].start + pci_cardbus_mem_size - 1;
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH |
-				  IORESOURCE_STARTALIGN;
+				  IORESOURCE_STARTALIGN | IORESOURCE_WINDOW;
 		if (realloc_head) {
 			b_res[2].end -= pci_cardbus_mem_size;
 			add_to_list(realloc_head, bridge, b_res+2,
@@ -1206,7 +1208,8 @@ handle_b_res_3:
 		goto handle_done;
 	b_res[3].start = pci_cardbus_mem_size;
 	b_res[3].end = b_res[3].start + b_res_3_size - 1;
-	b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
+	b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN |
+			  IORESOURCE_WINDOW;
 	if (realloc_head) {
 		b_res[3].end -= b_res_3_size;
 		add_to_list(realloc_head, bridge, b_res+3, b_res_3_size,
-- 
1.7.9.5
