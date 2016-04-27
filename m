Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvzYj3hkzzDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:20:09 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 22:20:08 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F3D2F2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:20:05 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3RCJvPs65142812
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:20:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3RCJWYK028160
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:19:33 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 3/4] PCI: Add a new option for resource_alignment to reassign
 alignment
Date: Wed, 27 Apr 2016 20:17:10 +0800
Message-Id: <1461759432-5030-4-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1461759432-5030-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1461759432-5030-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using resource_alignment kernel parameter, the current
implement reassigns the alignment by changing resources' size
which can potentially break some drivers. For example, the driver
uses the size to locate some register whose length is related
to the size.

This patch adds a new option "noresize" for the parameter to
solve this problem.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt |    5 ++++-
 drivers/pci/pci.c                   |   35 +++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0b3de80..13c25bf 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2958,13 +2958,16 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				window. The default value is 64 megabytes.
 		resource_alignment=
 				Format:
-				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
+				[<order of align>@][<domain>:]<bus>:<slot>.<func>
+				[:noresize][; ...]
 				Specifies alignment and device to reassign
 				aligned memory resources.
 				If <order of align> is not specified,
 				PAGE_SIZE is used as alignment.
 				PCI-PCI bridge can be specified, if resource
 				windows need to be expanded.
+				noresize: Don't change the resources' sizes when
+				reassigning alignment.
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 19b9560..a6d2b66 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4604,11 +4604,13 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
 /**
  * pci_specified_resource_alignment - get resource alignment specified by user.
  * @dev: the PCI device to get
+ * @resize: whether or not to change resources' size when reassigning alignment
  *
  * RETURNS: Resource alignment if it is specified.
  *          Zero if it is not specified.
  */
-static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
+static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
+		bool *resize)
 {
 	int seg, bus, slot, func, align_order, count;
 	resource_size_t align = 0;
@@ -4642,6 +4644,11 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 			}
 		}
 		p += count;
+		if (!strncmp(p, ":noresize", 9)) {
+			*resize = false;
+			p += 9;
+		} else
+			*resize = true;
 		if (seg == pci_domain_nr(dev->bus) &&
 			bus == dev->bus->number &&
 			slot == PCI_SLOT(dev->devfn) &&
@@ -4674,11 +4681,12 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 {
 	int i;
 	struct resource *r;
+	bool resize = true;
 	resource_size_t align, size;
 	u16 command;
 
 	/* check if specified PCI is target device to reassign */
-	align = pci_specified_resource_alignment(dev);
+	align = pci_specified_resource_alignment(dev, &resize);
 	if (!align)
 		return;
 
@@ -4700,15 +4708,22 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
 		size = resource_size(r);
-		if (size < align) {
-			size = align;
-			dev_info(&dev->dev,
-				"Rounding up size of resource #%d to %#llx.\n",
-				i, (unsigned long long)size);
+		if (resize) {
+			if (size < align) {
+				size = align;
+				dev_info(&dev->dev,
+					"Rounding up size of resource #%d to %#llx.\n",
+					i, (unsigned long long)size);
+			}
+			r->flags |= IORESOURCE_UNSET;
+			r->end = size - 1;
+			r->start = 0;
+		} else {
+			r->flags &= ~IORESOURCE_SIZEALIGN;
+			r->flags |= IORESOURCE_STARTALIGN | IORESOURCE_UNSET;
+			r->start = max(align, size);
+			r->end = r->start + size - 1;
 		}
-		r->flags |= IORESOURCE_UNSET;
-		r->end = size - 1;
-		r->start = 0;
 	}
 	/* Need to disable bridge's resource window,
 	 * to enable the kernel to reassign new resource
-- 
1.7.9.5
