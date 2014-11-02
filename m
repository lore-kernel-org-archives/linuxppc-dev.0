Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B6331A056B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:41:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 646432CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:44 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2FfWKX41484382
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2FfhTk028033
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:43 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V9 02/18] PCI: Add weak pcibios_iov_resource_alignment()
 interface
Date: Sun,  2 Nov 2014 23:41:18 +0800
Message-Id: <1414942894-17034-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The alignment of PF's IOV BAR is designed to be the individual size of a VF's
BAR size. This works fine for many platforms, but on PowerNV platform it needs
some change.

The original alignment works, since at sizing and assigning stage the
requirement is from an individual VF's BAR size instead of the PF's IOV BAR.
This is the reason for the original code to just retrieve the individual
VF BAR size as the alignment.

On PowerNV platform, it is required to align the whole PF IOV BAR to a hardware
segment. Based on this fact, the alignment of PF's IOV BAR should be
calculated seperately.

This patch introduces a weak pcibios_iov_resource_alignment() interface, which
gives platform a chance to implement specific method to calculate the PF's IOV
BAR alignment.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   11 ++++++++++-
 include/linux/pci.h |    3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5e8091b..4d1685d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -501,6 +501,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
+		int resno, resource_size_t align)
+{
+	return align;
+}
+
 /**
  * pci_sriov_resource_alignment - get resource alignment for VF BAR
  * @dev: the PCI device
@@ -515,13 +521,16 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
 	struct resource tmp;
 	enum pci_bar_type type;
+	resource_size_t align;
 	int reg = pci_iov_resource_bar(dev, resno, &type);
 
 	if (!reg)
 		return 0;
 
 	__pci_read_base(dev, type, &tmp, reg);
-	return resource_alignment(&tmp);
+	align = resource_alignment(&tmp);
+
+	return pcibios_iov_resource_alignment(dev, resno, align);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3ed7c66..bbf8058 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1159,6 +1159,9 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev,
+						 int resno,
+						 resource_size_t align);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.9.5
