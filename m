Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 751BC1A0892
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:42 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 16:22:36 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C545F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O65fdZ17039374
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:05:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6MblT030100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:38 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 03/17] PCI: Add weak pcibios_sriov_resource_alignment()
 interface
Date: Thu, 24 Jul 2014 14:22:13 +0800
Message-Id: <1406182947-11302-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sriov resource alignment is designed to be the individual size of a sriov
resource. This works fine for many platforms, but on powernv platform it needs
some change.

The original alignment works, since at sizing and assigning stage the
requirement is from an individual VF's resource size instead of the big IOV
BAR. This is the reason for the original code to just retrieve the individual
sriov size as the alignment.

On powernv platform, it is required to align the whole IOV BAR to a hardware
aperture. Based on this fact, the alignment of sriov resource should be the
total size of the IOV BAR.

This patch introduces a weak pcibios_sriov_resource_alignment() interface, which
gives platform a chance to implement specific method to calculate the sriov
resource alignment.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   11 ++++++++++-
 include/linux/pci.h |    3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ef1c546..d395769 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -505,6 +505,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+resource_size_t __weak pcibios_sriov_resource_alignment(struct pci_dev *dev,
+		int resno, resource_size_t align)
+{
+	return align;
+}
+
 /**
  * pci_sriov_resource_alignment - get resource alignment for VF BAR
  * @dev: the PCI device
@@ -519,13 +525,16 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
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
+	return pcibios_sriov_resource_alignment(dev, resno, align);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 194db52..541ef4eb43 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1166,6 +1166,9 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+resource_size_t pcibios_sriov_resource_alignment(struct pci_dev *dev,
+						 int resno,
+						 resource_size_t align);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.9.5
