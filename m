Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6AF47DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:50:14 +1100 (EST)
Date: Fri, 21 Dec 2007 15:50:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/3] [POWERPC] iSeries: eliminate pci_dn bussubno
Message-Id: <20071221155009.f6f22b0c.sfr@canb.auug.org.au>
In-Reply-To: <20071221154911.c437013e.sfr@canb.auug.org.au>
References: <20071221154818.95b51c8a.sfr@canb.auug.org.au>
	<20071221154911.c437013e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

xlate_iomm_address() really wants the ds_addr to pass to the HV, so store
that value (instead of the BAR number) when we allocate the device bars.
This is not a fast path, so we can look up the device_node property
there instead of using the bussubno field of the pci_dn.

The other user of iseries_ds_addr() was already scanning the device tree,
so looking up a property will not slow it down any more.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_dn.c         |    5 -----
 arch/powerpc/platforms/iseries/pci.c |   12 +++++++-----
 include/asm-powerpc/pci-bridge.h     |    1 -
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 85d4d89..1c67de5 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -56,11 +56,6 @@ static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 		pdn->busno = (regs[0] >> 16) & 0xff;
 		pdn->devfn = (regs[0] >> 8) & 0xff;
 	}
-	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		const u32 *busp = of_get_property(dn, "linux,subbus", NULL);
-		if (busp)
-			pdn->bussubno = *busp;
-	}
 
 	pdn->pci_ext_config_space = (type && *type == 1);
 	return NULL;
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 9319410..cc562e4 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/of.h>
 
 #include <asm/types.h>
 #include <asm/io.h>
@@ -70,7 +71,7 @@ static long current_iomm_table_entry;
  * Lookup Tables.
  */
 static struct device_node *iomm_table[IOMM_TABLE_MAX_ENTRIES];
-static u8 iobar_table[IOMM_TABLE_MAX_ENTRIES];
+static u64 ds_addr_table[IOMM_TABLE_MAX_ENTRIES];
 
 static DEFINE_SPINLOCK(iomm_table_lock);
 
@@ -80,8 +81,9 @@ static DEFINE_SPINLOCK(iomm_table_lock);
 static inline u64 iseries_ds_addr(struct device_node *node)
 {
 	struct pci_dn *pdn = PCI_DN(node);
+	const u32 *sbp = of_get_property(node, "linux,subbus", NULL);
 
-	return ((u64)pdn->busno << 48) + ((u64)pdn->bussubno << 40)
+	return ((u64)pdn->busno << 48) + ((u64)(sbp ? *sbp : 0) << 40)
 			+ ((u64)0x10 << 32);
 }
 
@@ -333,7 +335,8 @@ static void __init iomm_table_allocate_entry(struct pci_dev *dev, int bar_num)
 	 */
 	while (bar_size > 0 ) {
 		iomm_table[current_iomm_table_entry] = dev->sysdata;
-		iobar_table[current_iomm_table_entry] = bar_num;
+		ds_addr_table[current_iomm_table_entry] =
+			iseries_ds_addr(dev->sysdata) | (bar_num << 24);
 		bar_size -= IOMM_TABLE_ENTRY_SIZE;
 		++current_iomm_table_entry;
 	}
@@ -598,8 +601,7 @@ static inline struct device_node *xlate_iomm_address(
 	dn = iomm_table[ind];
 
 	if (dn != NULL) {
-		int barnum = iobar_table[ind];
-		*dsaptr = iseries_ds_addr(dn) | (barnum << 24);
+		*dsaptr = ds_addr_table[ind];
 		*bar_offset = base_addr % IOMM_TABLE_ENTRY_SIZE;
 	} else
 		panic("PCI: Invalid PCI IO address detected!\n");
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 2932404..a6ea49e 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -165,7 +165,6 @@ struct iommu_table;
 
 struct pci_dn {
 	int	busno;			/* pci bus number */
-	int	bussubno;		/* pci subordinate bus number */
 	int	devfn;			/* pci device and function number */
 
 	struct  pci_controller *phb;	/* for pci devices */
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
