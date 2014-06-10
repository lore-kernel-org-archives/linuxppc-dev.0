Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 280EE1A02A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:13 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 07:27:11 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2ECF2E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:28:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1w0sY57213162
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:28:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1v8VQ009361
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:09 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 10/17] PCI: take additional IOV BAR alignment in sizing
 and assigning
Date: Tue, 10 Jun 2014 09:56:32 +0800
Message-Id: <1402365399-5121-11-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At resource sizing/assigning stage, resources are divided into two lists,
requested list and additional list, while the alignement of the additional
IOV BAR is not taken into the sizeing and assigning procedure.

This is reasonable in the original implementation, since IOV BAR's alignment is
mostly the size of a PF BAR alignemt. This means the alignment is already taken
into consideration. While this rule may be violated on some platform.

This patch take the additional IOV BAR alignment in sizing and assigning stage
explicitly.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   66 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9509ffa..0c3b3a5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -120,6 +120,28 @@ static resource_size_t get_res_add_size(struct list_head *head,
 	return 0;
 }
 
+static resource_size_t get_res_add_align(struct list_head *head,
+		struct resource *res)
+{
+	struct pci_dev_resource *dev_res;
+
+	list_for_each_entry(dev_res, head, list) {
+		if (dev_res->res == res) {
+			int idx = res - &dev_res->dev->resource[0];
+
+			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
+				   "res[%d]=%pR get_res_add_align min_align %llx\n",
+				   idx, dev_res->res,
+				   (unsigned long long)dev_res->min_align);
+
+			return dev_res->min_align;
+		}
+	}
+
+	return 0;
+}
+
+
 /* Sort resources by alignment */
 static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
@@ -369,8 +391,9 @@ static void __assign_resources_sorted(struct list_head *head,
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
 	struct pci_dev_resource *save_res;
-	struct pci_dev_resource *dev_res, *tmp_res;
+	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	unsigned long fail_type;
+	resource_size_t add_align, align;
 
 	/* Check if optional add_size is there */
 	if (!realloc_head || list_empty(realloc_head))
@@ -385,10 +408,31 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 
 	/* Update res in head list with add_size in realloc_head list */
-	list_for_each_entry(dev_res, head, list)
+	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
 		dev_res->res->end += get_res_add_size(realloc_head,
 							dev_res->res);
 
+		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
+			continue;
+
+		add_align = get_res_add_align(realloc_head, dev_res->res);
+
+		if (add_align > dev_res->res->start) {
+			dev_res->res->start = add_align;
+			dev_res->res->end = add_align +
+				            resource_size(dev_res->res);
+
+			list_for_each_entry(dev_res2, head, list) {
+				align = pci_resource_alignment(dev_res2->dev,
+							       dev_res2->res);
+				if (add_align > align)
+					list_move_tail(&dev_res->list,
+						       &dev_res2->list);
+			}
+               }
+
+	}
+
 	/* Try updated head list with add_size added */
 	assign_requested_resources_sorted(head, &local_fail_head);
 
@@ -928,6 +972,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					 mask | IORESOURCE_PREFETCH, type);
 	unsigned int mem64_mask = 0;
 	resource_size_t children_add_size = 0;
+	resource_size_t children_add_align = 0;
+	resource_size_t add_align = 0;
 
 	if (!b_res)
 		return 0;
@@ -955,6 +1001,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			/* put SRIOV requested res to the optional list */
 			if (realloc_head && i >= PCI_IOV_RESOURCES &&
 					i <= PCI_IOV_RESOURCE_END) {
+				add_align = max(pci_resource_alignment(dev, r), add_align);
 				r->end = r->start - 1;
 				add_to_list(realloc_head, dev, r, r_size, 0/* don't care */);
 				children_add_size += r_size;
@@ -982,8 +1029,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				max_order = order;
 			mem64_mask &= r->flags & IORESOURCE_MEM_64;
 
-			if (realloc_head)
+			if (realloc_head) {
 				children_add_size += get_res_add_size(realloc_head, r);
+				children_add_align = get_res_add_align(realloc_head, r);
+				add_align = max(add_align, children_add_align);
+			}
 		}
 	}
 
@@ -994,7 +1044,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		add_size = children_add_size;
 	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
 		calculate_memsize(size, min_size, add_size,
-				resource_size(b_res), min_align);
+				resource_size(b_res), max(min_align, add_align));
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window "
@@ -1007,10 +1057,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN | mem64_mask;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, min_align);
+		add_to_list(realloc_head, bus->self, b_res, size1-size0,
+				max(min_align, add_align));
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
-				 "%pR to %pR add_size %llx\n", b_res,
-				 &bus->busn_res, (unsigned long long)size1-size0);
+				 "%pR to %pR add_size %llx add_align %llx\n", b_res,
+				 &bus->busn_res, (unsigned long long)size1-size0,
+				 max(min_align, add_align));
 	}
 	return 1;
 }
-- 
1.7.9.5
