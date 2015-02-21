Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E89E1A0E53
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 06:00:59 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Sat, 21 Feb 2015 14:00:56 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3722438C8026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 14:01:13 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1LJ0qsq19595364
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 19:00:53 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1LJ0pJS025278
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 14:00:52 -0500
Date: Sat, 21 Feb 2015 11:00:50 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] pseries/iommu: remove iommu device references via bus
 notifier
Message-ID: <20150221190050.GA20184@linux.vnet.ibm.com>
References: <20150219184103.GB13745@linux.vnet.ibm.com>
 <1424406689.11680.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424406689.11680.3.camel@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20.02.2015 [15:31:29 +1100], Michael Ellerman wrote:
> On Thu, 2015-02-19 at 10:41 -0800, Nishanth Aravamudan wrote:
> > After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
> > refcnt on the kobject backing the IOMMU group for a PCI device is
> > elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
> > set_iommu_table_base_and_group). When we go to dlpar a multi-function
> > PCI device out:
> > 
> > 	iommu_reconfig_notifier ->
> > 		iommu_free_table ->
> > 			iommu_group_put
> > 			BUG_ON(tbl->it_group)
> > 
> > We trip this BUG_ON, because there are still references on the table, so
> > it is not freed. Fix this by also adding a bus notifier identical to
> > PowerNV for pSeries.
> 
> Please put it somewhere common, arch/powerpc/kernel/iommu.c perhaps, and just
> add a second machine_init_call() for pseries.

How does this look? Only compile-tested with CONFIG_IOMMU_API on/off so
far, waiting for access to the test LPAR (should have it on Monday).


After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
refcnt on the kobject backing the IOMMU group for a PCI device is
elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
set_iommu_table_base_and_group). When we go to dlpar a multi-function
PCI device out:

        iommu_reconfig_notifier ->
                iommu_free_table ->
                        iommu_group_put
                        BUG_ON(tbl->it_group)

We trip this BUG_ON, because there are still references on the table, so
it is not freed. Fix this by moving the PowerNV bus notifier to common
code and calling it for both PowerNV and pSeries.

Fixes: d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier")
Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: stable@kernel.org (3.13+)

---
v1 -> v2:
  Move powernv code to common file, just add machine_init_call for pseries.
  Suggested by Michael Ellerman.

Michael, I'll send another update once I have testing results.

diff -urpN linux-3.19/arch/powerpc/include/asm/iommu.h linux-3.19-dev/arch/powerpc/include/asm/iommu.h
--- linux-3.19/arch/powerpc/include/asm/iommu.h	2015-02-08 18:54:22.000000000 -0800
+++ linux-3.19-dev/arch/powerpc/include/asm/iommu.h	2015-02-21 09:03:55.960995053 -0800
@@ -113,6 +113,7 @@ extern void iommu_register_group(struct
 				 int pci_domain_number, unsigned long pe_num);
 extern int iommu_add_device(struct device *dev);
 extern void iommu_del_device(struct device *dev);
+extern int __init tce_iommu_bus_notifier_init(void);
 #else
 static inline void iommu_register_group(struct iommu_table *tbl,
 					int pci_domain_number,
@@ -128,6 +129,11 @@ static inline int iommu_add_device(struc
 static inline void iommu_del_device(struct device *dev)
 {
 }
+
+static inline int __init tce_iommu_bus_notifier_init(void) 
+{ 
+        return 0; 
+} 
 #endif /* !CONFIG_IOMMU_API */
 
 static inline void set_iommu_table_base_and_group(struct device *dev,
diff -urpN linux-3.19/arch/powerpc/kernel/iommu.c linux-3.19-dev/arch/powerpc/kernel/iommu.c
--- linux-3.19/arch/powerpc/kernel/iommu.c	2015-02-08 18:54:22.000000000 -0800
+++ linux-3.19-dev/arch/powerpc/kernel/iommu.c	2015-02-20 17:50:19.229927080 -0800
@@ -1175,4 +1175,30 @@ void iommu_del_device(struct device *dev
 }
 EXPORT_SYMBOL_GPL(iommu_del_device);
 
+static int tce_iommu_bus_notifier(struct notifier_block *nb,
+                unsigned long action, void *data)
+{
+        struct device *dev = data;
+
+        switch (action) {
+        case BUS_NOTIFY_ADD_DEVICE:
+                return iommu_add_device(dev);
+        case BUS_NOTIFY_DEL_DEVICE:
+                if (dev->iommu_group)
+                        iommu_del_device(dev);
+                return 0;
+        default:
+                return 0;
+        }
+}
+
+static struct notifier_block tce_iommu_bus_nb = {
+        .notifier_call = tce_iommu_bus_notifier,
+};
+
+int __init tce_iommu_bus_notifier_init(void)
+{
+        bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
+        return 0;
+}
 #endif /* CONFIG_IOMMU_API */
diff -urpN linux-3.19/arch/powerpc/platforms/powernv/pci.c linux-3.19-dev/arch/powerpc/platforms/powernv/pci.c
--- linux-3.19/arch/powerpc/platforms/powernv/pci.c	2015-02-08 18:54:22.000000000 -0800
+++ linux-3.19-dev/arch/powerpc/platforms/powernv/pci.c	2015-02-20 17:50:33.917927464 -0800
@@ -866,30 +866,4 @@ void __init pnv_pci_init(void)
 #endif
 }
 
-static int tce_iommu_bus_notifier(struct notifier_block *nb,
-		unsigned long action, void *data)
-{
-	struct device *dev = data;
-
-	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
-		return iommu_add_device(dev);
-	case BUS_NOTIFY_DEL_DEVICE:
-		if (dev->iommu_group)
-			iommu_del_device(dev);
-		return 0;
-	default:
-		return 0;
-	}
-}
-
-static struct notifier_block tce_iommu_bus_nb = {
-	.notifier_call = tce_iommu_bus_notifier,
-};
-
-static int __init tce_iommu_bus_notifier_init(void)
-{
-	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
-	return 0;
-}
 machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
diff -urpN linux-3.19/arch/powerpc/platforms/pseries/iommu.c linux-3.19-dev/arch/powerpc/platforms/pseries/iommu.c
--- linux-3.19/arch/powerpc/platforms/pseries/iommu.c	2015-02-08 18:54:22.000000000 -0800
+++ linux-3.19-dev/arch/powerpc/platforms/pseries/iommu.c	2015-02-20 17:51:23.265928866 -0800
@@ -1340,3 +1340,5 @@ static int __init disable_multitce(char
 }
 
 __setup("multitce=", disable_multitce);
+
+machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
