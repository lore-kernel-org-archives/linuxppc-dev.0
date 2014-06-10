Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56B1F1A0294
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:11 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 07:27:09 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 18F193940049
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:07 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1vJ6l46792840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:19 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1v6CK013243
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:06 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 08/17] PCI: Add weak pcibios_sriov_resource_size()
 interface
Date: Tue, 10 Jun 2014 09:56:30 +0800
Message-Id: <1402365399-5121-9-git-send-email-weiyang@linux.vnet.ibm.com>
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

When retrieving sriov resource size in pci_sriov_resource_size(), it will
divide the total IOV resource size with the totalVF number. This is true for
most cases, while may not be correct on some specific platform.

For example on powernv platform, in order to fix the IOV BAR into a hardware
alignment, the IOV resource size would be expended. This means the original
method couldn't work.

This patch introduces a weak pcibios_sriov_resource_size() interface, which
gives platform a chance to implement specific method to calculate the sriov
resource size.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   27 +++++++++++++++++++++++++--
 include/linux/pci.h |    3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index cc87773..9fd4648 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -45,6 +45,30 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 		pci_remove_bus(virtbus);
 }
 
+resource_size_t __weak pcibios_sriov_resource_size(struct pci_dev *dev, int resno)
+{
+	return 0;
+}
+
+resource_size_t pci_sriov_resource_size(struct pci_dev *dev, int resno)
+{
+	u64 size;
+	struct pci_sriov *iov;
+
+	if (!dev->is_physfn)
+		return 0;
+
+	size = pcibios_sriov_resource_size(dev, resno);
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
@@ -81,8 +105,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
-		size = resource_size(res);
-		do_div(size, iov->total_VFs);
+		size = pci_sriov_resource_size(dev, i + PCI_IOV_RESOURCES);
 		virtfn->resource[i].start = res->start + size * id;
 		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
 		rc = request_resource(res, &virtfn->resource[i]);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ddb1ca0..315c150 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1637,6 +1637,7 @@ int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
+resource_size_t pci_sriov_resource_size(struct pci_dev *dev, int resno);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
@@ -1658,6 +1659,8 @@ static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
 static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
+static inline resource_size_t pci_sriov_resource_size(struct pci_dev *dev, int resno)
+{ return -1; }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-- 
1.7.9.5
