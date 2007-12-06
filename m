Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5536CDE255
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:59 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 3114C368006
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:59 +1100 (EST)
Date: Fri, 7 Dec 2007 01:55:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 11/19] [POWERPC] iSeries: iseries_ds_addr is only used in pci.c
Message-Id: <20071207015550.e6dc6fde.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |   11 +++++++++++
 arch/powerpc/platforms/iseries/pci.h |   13 +------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 3cf51c6..b46d8c5 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -69,6 +69,17 @@ static const char pci_io_text[] = "iSeries PCI I/O";
 static DEFINE_SPINLOCK(iomm_table_lock);
 
 /*
+ * Generate a Direct Select Address for the Hypervisor
+ */
+static inline u64 iseries_ds_addr(struct device_node *node)
+{
+	struct pci_dn *pdn = PCI_DN(node);
+
+	return ((u64)pdn->busno << 48) + ((u64)pdn->bussubno << 40)
+			+ ((u64)0x10 << 32);
+}
+
+/*
  * iomm_table_allocate_entry
  *
  * Adds pci_dev entry in address translation table
diff --git a/arch/powerpc/platforms/iseries/pci.h b/arch/powerpc/platforms/iseries/pci.h
index 3cb18fa..3af9cf1 100644
--- a/arch/powerpc/platforms/iseries/pci.h
+++ b/arch/powerpc/platforms/iseries/pci.h
@@ -30,7 +30,7 @@
  * End Change Activity
  */
 
-#include <asm/pci-bridge.h>
+#include <asm/iseries/hv_types.h>
 
 struct pci_dev;				/* For Forward Reference */
 
@@ -47,17 +47,6 @@ struct pci_dev;				/* For Forward Reference */
 #define ISERIES_GET_DEVICE_FROM_SUBBUS(subbus)		((subbus >> 5) & 0x7)
 #define ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus)	((subbus >> 2) & 0x7)
 
-/*
- * Generate a Direct Select Address for the Hypervisor
- */
-static inline u64 iseries_ds_addr(struct device_node *node)
-{
-	struct pci_dn *pdn = PCI_DN(node);
-
-	return ((u64)pdn->busno << 48) + ((u64)pdn->bussubno << 40)
-			+ ((u64)0x10 << 32);
-}
-
 extern void	iSeries_Device_Information(struct pci_dev *PciDev, int count,
 			u16 bus, HvSubBusNumber subbus);
 #ifdef CONFIG_PCI
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
