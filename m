Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 17/18] powerpc: Remove all includes of <asm/abs_addr.h>
Date: Thu, 26 Jul 2012 17:20:03 +1000
Message-Id: <1343287204-7700-17-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's empty now, apart from other includes.

Fixup a few files that were getting things via this header.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/dma-swiotlb.c           |    2 +-
 arch/powerpc/kernel/ibmebus.c               |    1 -
 arch/powerpc/kernel/vio.c                   |    1 -
 arch/powerpc/mm/hash_native_64.c            |    2 +-
 arch/powerpc/mm/init_64.c                   |    1 -
 arch/powerpc/mm/pgtable_64.c                |    1 -
 arch/powerpc/platforms/pasemi/iommu.c       |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c   |    1 -
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    1 -
 arch/powerpc/platforms/powernv/pci.c        |    1 -
 arch/powerpc/platforms/pseries/iommu.c      |    1 +
 arch/powerpc/platforms/pseries/lpar.c       |    1 -
 12 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 4ab88da..e47d386 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/memblock.h>
 #include <linux/pfn.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -20,7 +21,6 @@
 #include <asm/machdep.h>
 #include <asm/swiotlb.h>
 #include <asm/dma.h>
-#include <asm/abs_addr.h>
 
 unsigned int ppc_swiotlb_enable;
 
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index b01d14e..8220baa 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -47,7 +47,6 @@
 #include <linux/stat.h>
 #include <linux/of_platform.h>
 #include <asm/ibmebus.h>
-#include <asm/abs_addr.h>
 
 static struct device ibmebus_bus_device = { /* fake "parent" device */
 	.init_name = "ibmebus",
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index cb87301..9185ca7 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -33,7 +33,6 @@
 #include <asm/prom.h>
 #include <asm/firmware.h>
 #include <asm/tce.h>
-#include <asm/abs_addr.h>
 #include <asm/page.h>
 #include <asm/hvcall.h>
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 90039bc..f21e8ce 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -14,10 +14,10 @@
 
 #include <linux/spinlock.h>
 #include <linux/bitops.h>
+#include <linux/of.h>
 #include <linux/threads.h>
 #include <linux/smp.h>
 
-#include <asm/abs_addr.h>
 #include <asm/machdep.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 620b7ac..95a4529 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -62,7 +62,6 @@
 #include <asm/cputable.h>
 #include <asm/sections.h>
 #include <asm/iommu.h>
-#include <asm/abs_addr.h>
 #include <asm/vdso.h>
 
 #include "mmu_decl.h"
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 249a063..297d495 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -51,7 +51,6 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
-#include <asm/abs_addr.h>
 #include <asm/firmware.h>
 
 #include "mmu_decl.h"
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index f03fbc2..7d2d036 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -19,6 +19,7 @@
 
 #undef DEBUG
 
+#include <linux/memblock.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fbdd74d..c7b7f37 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -30,7 +30,6 @@
 #include <asm/opal.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
-#include <asm/abs_addr.h>
 
 #include "powernv.h"
 #include "pci.h"
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 2649677..6b4bef4 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -30,7 +30,6 @@
 #include <asm/opal.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
-#include <asm/abs_addr.h>
 
 #include "powernv.h"
 #include "pci.h"
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index be3cfc5..1e908ae 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -30,7 +30,6 @@
 #include <asm/opal.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
-#include <asm/abs_addr.h>
 #include <asm/firmware.h>
 
 #include "powernv.h"
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 7393118..0f18a32 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/memblock.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>	/* for show_stack */
 #include <linux/string.h>
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5f3ef87..177055d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -31,7 +31,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/machdep.h>
-#include <asm/abs_addr.h>
 #include <asm/mmu_context.h>
 #include <asm/iommu.h>
 #include <asm/tlbflush.h>
-- 
1.7.9.5
