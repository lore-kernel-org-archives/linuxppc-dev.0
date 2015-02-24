Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 014571A10A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:34:03 +1100 (AEDT)
Received: by padhz1 with SMTP id hz1so34371281pad.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:34:01 -0800 (PST)
Subject: [PATCH v12 09/21] PCI: Add pcibios_iov_resource_alignment() interface
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:33:59 -0600
Message-ID: <20150224083359.32124.91908.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

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
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   |    8 +++++++-
 include/linux/pci.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index cc6fedf4a1b9..bde0f02cae32 100644
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
index 99ea94835fb6..4e1f17db1a81 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1174,6 +1174,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
