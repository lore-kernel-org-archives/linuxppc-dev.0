Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYJYT6VZZzDsVP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 19:00:45 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8D8wev4040207
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 05:00:44 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25dx2pexew-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 05:00:43 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 13 Sep 2016 03:00:43 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v5 3/4] PCI: Add a new option for resource_alignment to
 reassign alignment
Date: Tue, 13 Sep 2016 17:00:33 +0800
In-Reply-To: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1473757234-5284-4-git-send-email-xyjxie@linux.vnet.ibm.com>
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
 Documentation/kernel-parameters.txt |    9 ++++++---
 drivers/pci/pci.c                   |   37 +++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a4f4d69..d6a340d 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3023,9 +3023,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				window. The default value is 64 megabytes.
 		resource_alignment=
 				Format:
-				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
-				[<order of align>@]pci:<vendor>:<device>\
-						[:<subvendor>:<subdevice>][; ...]
+				[<order of align>@][noresize@][<domain>:]
+				<bus>:<slot>.<func>[; ...]
+				[<order of align>@][noresize@]pci:<vendor>:<device>
+				[:<subvendor>:<subdevice>][; ...]
 				Specifies alignment and device to reassign
 				aligned memory resources.
 				If <order of align> is not specified,
@@ -3036,6 +3037,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				instances of a device, the PCI vendor,
 				device, subvendor, and subdevice may be
 				specified, e.g., 4096@pci:8086:9c22:103c:198f
+				noresize: Don't change the resources' sizes when
+				reassigning alignment.
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b8357d7..37f8062 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4946,11 +4946,13 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
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
 	unsigned short vendor, device, subsystem_vendor, subsystem_device;
@@ -4974,6 +4976,13 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 		} else {
 			align_order = -1;
 		}
+
+		if (!strncmp(p, "noresize@", 9)) {
+			*resize = false;
+			p += 9;
+		} else
+			*resize = true;
+
 		if (strncmp(p, "pci:", 4) == 0) {
 			/* PCI vendor/device (subvendor/subdevice) ids are specified */
 			p += 4;
@@ -5045,6 +5054,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 {
 	int i;
 	struct resource *r;
+	bool resize = true;
 	resource_size_t align, size;
 	u16 command;
 
@@ -5058,7 +5068,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 
 	/* check if specified PCI is target device to reassign */
-	align = pci_specified_resource_alignment(dev);
+	align = pci_specified_resource_alignment(dev, &resize);
 	if (!align)
 		return;
 
@@ -5086,15 +5096,22 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		}
 
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
