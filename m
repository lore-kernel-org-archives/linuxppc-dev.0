Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgGcP5h3JzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:53:41 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UArXh5068759
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:53:39 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt8pfv0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:53:39 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 16:23:34 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B81F23940061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:23:31 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UArVKH33751080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:23:31 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UArQ59028275
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:23:30 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH v3 6/7] PCI: Add support for enforcing all MMIO BARs to be
 page aligned
Date: Thu, 30 Jun 2016 18:53:12 +0800
In-Reply-To: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1467283993-3185-7-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When vfio passthrough a PCI device of which MMIO BARs are
smaller than PAGE_SIZE, guest will not handle the mmio
accesses to the BARs which leads to mmio emulations in host.

This is because vfio will not allow to passthrough one BAR's
mmio page which may be shared with other BARs. Otherwise,
there will be a backdoor that guest can use to access BARs
of other guest.

To solve this issue, this patch modifies resource_alignment
to support syntax where multiple devices get the same
alignment. So we can use something like
"pci=resource_alignment=*:*:*.*:noresize" to enforce the
alignment of all MMIO BARs to be at least PAGE_SIZE so that
one BAR's mmio page would not be shared with other BARs.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt |    2 ++
 drivers/pci/pci.c                   |   60 ++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c4802f5..cb09503 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3003,6 +3003,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				aligned memory resources.
 				If <order of align> is not specified,
 				PAGE_SIZE is used as alignment.
+				<domain>, <bus>, <slot> and <func> can be set to
+				"*" which means match all values.
 				PCI-PCI bridge can be specified, if resource
 				windows need to be expanded.
 				noresize: Don't change the resources' sizes when
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1d80a94..2e15ac8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4759,6 +4759,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	int seg, bus, slot, func, align_order, count;
 	resource_size_t align = 0;
 	char *p;
+	bool invalid = false;
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
@@ -4777,16 +4778,49 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 		} else {
 			align_order = -1;
 		}
-		if (sscanf(p, "%x:%x:%x.%x%n",
-			&seg, &bus, &slot, &func, &count) != 4) {
+		if (p[0] == '*' && p[1] == ':') {
+			seg = -1;
+			count = 1;
+		} else if (sscanf(p, "%x%n", &seg, &count) != 1 ||
+				p[count] != ':') {
+			invalid = true;
+			break;
+		}
+		p += count + 1;
+		if (*p == '*') {
+			bus = -1;
+			count = 1;
+		} else if (sscanf(p, "%x%n", &bus, &count) != 1) {
+			invalid = true;
+			break;
+		}
+		p += count;
+		if (*p == '.') {
+			slot = bus;
+			bus = seg;
 			seg = 0;
-			if (sscanf(p, "%x:%x.%x%n",
-					&bus, &slot, &func, &count) != 3) {
-				/* Invalid format */
-				printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
-					p);
+			p++;
+		} else if (*p == ':') {
+			p++;
+			if (p[0] == '*' && p[1] == '.') {
+				slot = -1;
+				count = 1;
+			} else if (sscanf(p, "%x%n", &slot, &count) != 1 ||
+					p[count] != '.') {
+				invalid = true;
 				break;
 			}
+			p += count + 1;
+		} else {
+			invalid = true;
+			break;
+		}
+		if (*p == '*') {
+			func = -1;
+			count = 1;
+		} else if (sscanf(p, "%x%n", &func, &count) != 1) {
+			invalid = true;
+			break;
 		}
 		p += count;
 		if (!strncmp(p, ":noresize", 9)) {
@@ -4794,10 +4828,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 			p += 9;
 		} else
 			*resize = true;
-		if (seg == pci_domain_nr(dev->bus) &&
-			bus == dev->bus->number &&
-			slot == PCI_SLOT(dev->devfn) &&
-			func == PCI_FUNC(dev->devfn)) {
+		if ((seg == pci_domain_nr(dev->bus) || seg == -1) &&
+			(bus == dev->bus->number || bus == -1) &&
+			(slot == PCI_SLOT(dev->devfn) || slot == -1) &&
+			(func == PCI_FUNC(dev->devfn) || func == -1)) {
 			if (align_order == -1)
 				align = PAGE_SIZE;
 			else
@@ -4807,10 +4841,14 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 		}
 		if (*p != ';' && *p != ',') {
 			/* End of param or invalid format */
+			invalid = true;
 			break;
 		}
 		p++;
 	}
+	if (invalid)
+		printk(KERN_ERR "PCI: Can't parse resource_alignment parameter:%s\n",
+				p);
 	spin_unlock(&resource_alignment_lock);
 	return align;
 }
-- 
1.7.9.5
