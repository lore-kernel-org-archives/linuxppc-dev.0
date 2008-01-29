Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <76b4bd4757ab67f814f6a298a3935fa0042cd656.1201616038.git.michael@ellerman.id.au>
In-Reply-To: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/8] Split cell_iommu_setup_hardware() into two parts
Date: Wed, 30 Jan 2008 01:14:00 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Split cell_iommu_setup_hardware() into two parts. Split the page table
setup into cell_iommu_setup_page_tables() and the bits that kick the
hardware into cell_iommu_enable_hardware().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   38 +++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 4f1ca43..a86e5bb 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -306,20 +306,13 @@ static int cell_iommu_find_ioc(int nid, unsigned long *base)
 	return -ENODEV;
 }
 
-static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long size)
+static void cell_iommu_setup_page_tables(struct cbe_iommu *iommu,
+					 unsigned long base, unsigned long size)
 {
 	struct page *page;
-	int ret, i;
+	int i;
 	unsigned long reg, segments, pages_per_segment, ptab_size, stab_size,
-		      n_pte_pages, xlate_base;
-	unsigned int virq;
-
-	if (cell_iommu_find_ioc(iommu->nid, &xlate_base))
-		panic("%s: missing IOC register mappings for node %d\n",
-		      __FUNCTION__, iommu->nid);
-
-	iommu->xlate_regs = ioremap(xlate_base, IOC_Reg_Size);
-	iommu->cmd_regs = iommu->xlate_regs + IOC_IOCmd_Offset;
+		      n_pte_pages;
 
 	segments = size >> IO_SEGMENT_SHIFT;
 	pages_per_segment = 1ull << IO_PAGENO_BITS;
@@ -378,6 +371,20 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long siz
 			(__pa(iommu->ptab) + n_pte_pages * IOMMU_PAGE_SIZE * i);
 		pr_debug("\t[%d] 0x%016lx\n", i, iommu->stab[i]);
 	}
+}
+
+static void cell_iommu_enable_hardware(struct cbe_iommu *iommu)
+{
+	int ret;
+	unsigned long reg, xlate_base;
+	unsigned int virq;
+
+	if (cell_iommu_find_ioc(iommu->nid, &xlate_base))
+		panic("%s: missing IOC register mappings for node %d\n",
+		      __FUNCTION__, iommu->nid);
+
+	iommu->xlate_regs = ioremap(xlate_base, IOC_Reg_Size);
+	iommu->cmd_regs = iommu->xlate_regs + IOC_IOCmd_Offset;
 
 	/* ensure that the STEs have updated */
 	mb();
@@ -407,6 +414,13 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long siz
 	out_be64(iommu->cmd_regs + IOC_IOCmd_Cfg, reg);
 }
 
+static void cell_iommu_setup_hardware(struct cbe_iommu *iommu,
+	unsigned long base, unsigned long size)
+{
+	cell_iommu_setup_page_tables(iommu, base, size);
+	cell_iommu_enable_hardware(iommu);
+}
+
 #if 0/* Unused for now */
 static struct iommu_window *find_window(struct cbe_iommu *iommu,
 		unsigned long offset, unsigned long size)
@@ -622,7 +636,7 @@ static void __init cell_iommu_init_one(struct device_node *np,
 		 base, base + size - 1);
 
 	/* Initialize the hardware */
-	cell_iommu_setup_hardware(iommu, size);
+	cell_iommu_setup_hardware(iommu, base, size);
 
 	/* Setup the iommu_table */
 	cell_iommu_setup_window(iommu, np, base, size,
-- 
1.5.3.7.1.g4e596e
