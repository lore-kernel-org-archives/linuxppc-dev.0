Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 856CF1A01E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:16 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:13 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2416E3578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:14 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N2hM0A41680956
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:43:22 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N36D4A014699
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:13 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/18] powerpc/powernv: Convert/move set_bypass() callback
 to take_ownership()
Date: Wed, 23 Jul 2014 13:05:56 +1000
Message-Id: <1406084764-24685-11-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the iommu_table struct has a set_bypass() which enables/
disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
which calls this callback when external IOMMU users such as VFIO are
about to get over a PHB.

Since the set_bypass() is not really an iommu_table function but PE's
function, and we have an ops struct per IOMMU owner, let's move
set_bypass() to the spapr_tce_iommu_ops struct.

As arch/powerpc/kernel/iommu.c is more about POWERPC IOMMU tables and
has very little to do with PEs, this moves take_ownership() calls to
the VFIO SPAPR TCE driver.

This renames set_bypass() to take_ownership() as it is not necessarily
just enabling bypassing, it can be something else/more so let's give it
a generic name. The bool parameter is inverted.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |  1 -
 arch/powerpc/include/asm/tce.h            |  2 ++
 arch/powerpc/kernel/iommu.c               | 12 ------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 17 ++++++++++-------
 drivers/vfio/vfio_iommu_spapr_tce.c       | 16 ++++++++++++++++
 5 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index fb2c884..00205cb 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -81,7 +81,6 @@ struct iommu_table {
 	struct iommu_group *it_group;
 #endif
 	iommu_invalidate_fn invalidate;
-	void (*set_bypass)(struct iommu_table *tbl, bool enable);
 };
 
 /* Pure 2^n version of get_order */
diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
index a697681..c3d295d 100644
--- a/arch/powerpc/include/asm/tce.h
+++ b/arch/powerpc/include/asm/tce.h
@@ -56,6 +56,8 @@ struct spapr_tce_iommu_ops {
 	struct iommu_table *(*get_table)(
 			struct spapr_tce_iommu_group *data,
 			phys_addr_t addr);
+	void (*take_ownership)(struct spapr_tce_iommu_group *data,
+			bool enable);
 };
 
 struct spapr_tce_iommu_group {
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b207332..d9494b2 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1113,14 +1113,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	memset(tbl->it_map, 0xff, sz);
 	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 
-	/*
-	 * Disable iommu bypass, otherwise the user can DMA to all of
-	 * our physical memory via the bypass window instead of just
-	 * the pages that has been explicitly mapped into the iommu
-	 */
-	if (tbl->set_bypass)
-		tbl->set_bypass(tbl, false);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_take_ownership);
@@ -1135,10 +1127,6 @@ void iommu_release_ownership(struct iommu_table *tbl)
 	/* Restore bit#0 set by iommu_init_table() */
 	if (tbl->it_offset == 0)
 		set_bit(0, tbl->it_map);
-
-	/* The kernel owns the device now, we can restore the iommu bypass */
-	if (tbl->set_bypass)
-		tbl->set_bypass(tbl, true);
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8152e30..b5e757b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -715,10 +715,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
 
-static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
 
@@ -758,16 +756,21 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	/* TVE #1 is selected by PCI address bit 59 */
 	pe->tce_bypass_base = 1ull << 59;
 
-	/* Install set_bypass callback for VFIO */
-	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
-
 	/* Enable bypass by default */
-	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
+	pnv_pci_ioda2_set_bypass(pe, true);
+}
 
+static void pnv_ioda2_take_ownership(struct spapr_tce_iommu_group *data,
+				     bool enable)
+{
+	struct pnv_ioda_pe *pe = data->iommu_owner;
+
+	pnv_pci_ioda2_set_bypass(pe, !enable);
 }
 
 static struct spapr_tce_iommu_ops pnv_pci_ioda2_ops = {
 	.get_table = pnv_ioda1_iommu_get_table,
+	.take_ownership = pnv_ioda2_take_ownership,
 };
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1107c70..d6264ac 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -78,6 +78,13 @@ static long tce_iommu_account_memlimit(struct iommu_table *tbl, bool inc)
 	return ret;
 }
 
+static void tce_iommu_take_ownership_notify(struct spapr_tce_iommu_group *data,
+		bool enable)
+{
+	if (data && data->ops && data->ops->take_ownership)
+		data->ops->take_ownership(data, enable);
+}
+
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
@@ -386,6 +393,12 @@ static int tce_iommu_attach_group(void *iommu_data,
 		ret = iommu_take_ownership(tbl);
 		if (!ret)
 			container->grp = iommu_group;
+		/*
+		 * Disable iommu bypass, otherwise the user can DMA to all of
+		 * our physical memory via the bypass window instead of just
+		 * the pages that has been explicitly mapped into the iommu
+		 */
+		tce_iommu_take_ownership_notify(data, true);
 	}
 
 	mutex_unlock(&container->lock);
@@ -423,6 +436,9 @@ static void tce_iommu_detach_group(void *iommu_data,
 		BUG_ON(!tbl);
 
 		iommu_release_ownership(tbl);
+
+		/* Kernel owns the device now, we can restore bypass */
+		tce_iommu_take_ownership_notify(data, false);
 	}
 	mutex_unlock(&container->lock);
 }
-- 
2.0.0
