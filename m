Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03D8D1A099E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:41:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 826653578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2FfjsQ42860664
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2FfjWF028053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:46 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size() interface
Date: Sun,  2 Nov 2014 23:41:19 +0800
Message-Id: <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
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

When retrieving VF IOV BAR in virtfn_add(), it will divide the total PF's IOV
BAR size with the totalVF number. This is true for most cases, while may not
be correct on some specific platform.

For example on PowerNV platform, in order to fix PF's IOV BAR into a hardware
alignment, the PF's IOV BAR size would be expended. This means the original
method couldn't work.

This patch introduces a weak pcibios_iov_resource_size() interface, which
gives platform a chance to implement specific method to calculate the VF BAR
resource size.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   27 +++++++++++++++++++++++++--
 include/linux/pci.h |    5 +++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4d1685d..6866830 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -61,6 +61,30 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 		pci_remove_bus(virtbus);
 }
 
+resource_size_t __weak pcibios_iov_resource_size(struct pci_dev *dev, int resno)
+{
+	return 0;
+}
+
+resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+{
+	resource_size_t size;
+	struct pci_sriov *iov;
+
+	if (!dev->is_physfn)
+		return 0;
+
+	size = pcibios_iov_resource_size(dev, resno);
+	if (size != 0)
+		return size;
+
+	iov = dev->sriov;
+	size = resource_size(dev->resource + resno);
+	do_div(size, iov->total_VFs);
+
+	return size;
+}
+
 static int virtfn_add(struct pci_dev *dev, int id, int reset)
 {
 	int i;
@@ -96,8 +120,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
-		size = resource_size(res);
-		do_div(size, iov->total_VFs);
+		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
 		virtfn->resource[i].start = res->start + size * id;
 		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
 		rc = request_resource(res, &virtfn->resource[i]);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bbf8058..2f5b454 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1162,6 +1162,8 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev,
 						 int resno,
 						 resource_size_t align);
+resource_size_t pcibios_iov_resource_size(struct pci_dev *dev,
+		                            int resno);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
@@ -1666,6 +1668,7 @@ int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
+resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
@@ -1685,6 +1688,8 @@ static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
 static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
+static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+{ return 0; }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-- 
1.7.9.5
