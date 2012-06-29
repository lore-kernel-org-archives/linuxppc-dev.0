Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 249F5100825
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 16:48:17 +1000 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 02:48:14 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5T6m1qS385064
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:48:01 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5TCIoaS011710
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 08:18:53 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] pci: minimal alignment for bars of P2P bridges
Date: Fri, 29 Jun 2012 14:47:48 +0800
Message-Id: <878dcc914319fd110ceda936c2ce5b6bb7a449ab.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxram@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some powerpc platforms, device BARs need to be assigned to separate
"segments" of the address space in order for the error isolation and HW
virtualization mechanisms (EEH) to work properly. Those "segments" have
a minimum size that can be fairly large (16M). In order to be able to
use the generic resource assignment code rather than re-inventing our
own, we chose to group devices by bus. That way, a simple change of the
minimum alignment requirements of resources assigned to PCI to PCI (P2P)
bridges is enough to ensure that all BARs for devices below those bridges
will fit into contiguous sets of segments and there will be no overlap.

This patch provides a way for the host bridge to override the default
alignment values used by the resource allocation code for that purpose.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/probe.c |    5 +++++
 include/linux/pci.h |    8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 658ac97..a196529 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -431,6 +431,11 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 	if (bridge) {
 		INIT_LIST_HEAD(&bridge->windows);
 		bridge->bus = b;
+
+		/* Set minimal alignment shift of P2P bridges */
+		bridge->io_align_shift = PCI_DEFAULT_IO_ALIGN_SHIFT;
+		bridge->mem_align_shift = PCI_DEFAULT_MEM_ALIGN_SHIFT;
+		bridge->pmem_align_shift = PCI_DEFAULT_PMEM_ALIGN_SHIFT;
 	}
 
 	return bridge;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e66f4b2..2b2b38d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,9 +376,17 @@ struct pci_host_bridge_window {
 	resource_size_t offset;		/* bus address + offset = CPU address */
 };
 
+/* Default shits for P2P I/O and MMIO bar minimal alignment shifts */
+#define PCI_DEFAULT_IO_ALIGN_SHIFT	12	/* 4KB  */
+#define PCI_DEFAULT_MEM_ALIGN_SHIFT	20	/* 1MB  */
+#define PCI_DEFAULT_PMEM_ALIGN_SHIFT	20	/* 1MB */
+
 struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
+	int io_align_shift;		/* P2P I/O bar minimal alignment shift  */
+	int mem_align_shift;		/* P2P MMIO bar minimal alignment shift */
+	int pmem_align_shift;		/* P2P prefetchable MMIO bar minimal alignment shift */
 	struct list_head windows;	/* pci_host_bridge_windows */
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
-- 
1.7.9.5
