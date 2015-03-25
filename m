Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 928831A2DD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:28:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 18:28:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 33BDA2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:28:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P8SFJM38404196
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:28:23 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P8RncT024517
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:27:49 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V16 09/20] PCI: Add pcibios_iov_resource_alignment() interface
Date: Wed, 25 Mar 2015 16:23:50 +0800
Message-Id: <1427271841-28749-10-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Per the SR-IOV spec r1.1, sec 3.3.14, the required alignment of a PF's IOV
BAR is the size of an individual VF BAR, and the size consumed is the
individual VF BAR size times NumVFs.

The PowerNV platform has additional alignment requirements to help support
its Partitionable Endpoint device isolation feature (see
Documentation/powerpc/pci_iov_resource_on_powernv.txt).

Add a pcibios_iov_resource_alignment() interface to allow platforms to
request additional alignment.

[bhelgaas: changelog, adapt to reworked pci_sriov_resource_alignment(),
drop "align" parameter]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   |    8 +++++++-
 include/linux/pci.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 64c4692..ee0ebff 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -569,6 +569,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
+						      int resno)
+{
+	return pci_iov_resource_size(dev, resno);
+}
+
 /**
  * pci_sriov_resource_alignment - get resource alignment for VF BAR
  * @dev: the PCI device
@@ -581,7 +587,7 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
  */
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
-	return pci_iov_resource_size(dev, resno);
+	return pcibios_iov_resource_alignment(dev, resno);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 99ea948..4e1f17d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1174,6 +1174,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.9.5
