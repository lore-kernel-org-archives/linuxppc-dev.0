Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJH1P0xpSzDqjc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:06:00 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UD4G1W019024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:05:59 -0400
Message-Id: <201605301305.u4UD4G1W019024@mx0a-001b2d01.pphosted.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238k6umgap-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:05:59 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 30 May 2016 23:05:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2BC883578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:05:54 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UD5kaj12779848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:05:54 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UD5L80013122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:05:21 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH v2 4/4] PCI: Add support for enforcing all MMIO BARs to be
 page aligned
Date: Mon, 30 May 2016 21:00:18 +0800
In-Reply-To: <1464613218-23973-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464613218-23973-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

And we also define a macro PCIBIOS_MIN_ALIGNMENT to enable this
automatically on PPC64 platform which can easily hit this issue
because its PAGE_SIZE is 64KB.

Note that this would not be applied to VFs whose BARs are always
page aligned and should be never reassigned according to SRIOV
spec.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt |    2 ++
 arch/powerpc/include/asm/pci.h      |    2 ++
 drivers/pci/pci.c                   |   68 +++++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 11 deletions(-)

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
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index a6f3ac0..742fd34 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -28,6 +28,8 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+#define PCIBIOS_MIN_ALIGNMENT  PAGE_SIZE
+
 struct pci_dev;
 
 /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3ee13e5..664f295 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4759,7 +4759,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	int seg, bus, slot, func, align_order, count;
 	resource_size_t align = 0;
 	char *p;
+	bool invalid = false;
 
+#ifdef PCIBIOS_MIN_ALIGNMENT
+	align = PCIBIOS_MIN_ALIGNMENT;
+	*resize = false;
+#endif
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
 	while (*p) {
@@ -4776,16 +4781,49 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
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
@@ -4793,10 +4831,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
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
@@ -4806,10 +4844,14 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
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
@@ -4829,6 +4871,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	resource_size_t align, size;
 	u16 command;
 
+	/* We should never try to reassign VF's alignment */
+	if (dev->is_virtfn)
+		return;
+
 	/* check if specified PCI is target device to reassign */
 	align = pci_specified_resource_alignment(dev, &resize);
 	if (!align)
-- 
1.7.9.5
