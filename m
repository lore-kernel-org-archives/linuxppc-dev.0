Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 06/18] powerpc/dart: Remove uses of virt_to_abs() and
 abs_to_virt()
Date: Thu, 26 Jul 2012 17:19:52 +1000
Message-Id: <1343287204-7700-6-git-send-email-michael@ellerman.id.au>
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

These days they are just wrappers around __pa() and __va() respectively.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/dart_iommu.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 4f2680f..8ef63a0 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -43,7 +43,6 @@
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
-#include <asm/abs_addr.h>
 #include <asm/cacheflush.h>
 #include <asm/ppc-pci.h>
 
@@ -167,7 +166,7 @@ static int dart_build(struct iommu_table *tbl, long index,
 	 */
 	l = npages;
 	while (l--) {
-		rpn = virt_to_abs(uaddr) >> DART_PAGE_SHIFT;
+		rpn = __pa(uaddr) >> DART_PAGE_SHIFT;
 
 		*(dp++) = DARTMAP_VALID | (rpn & DARTMAP_RPNMASK);
 
@@ -244,7 +243,7 @@ static int __init dart_init(struct device_node *dart_node)
 		panic("DART: Cannot map registers!");
 
 	/* Map in DART table */
-	dart_vbase = ioremap(virt_to_abs(dart_tablebase), dart_tablesize);
+	dart_vbase = ioremap(__pa(dart_tablebase), dart_tablesize);
 
 	/* Fill initial table */
 	for (i = 0; i < dart_tablesize/4; i++)
@@ -463,7 +462,7 @@ void __init alloc_dart_table(void)
 	 * will blow up an entire large page anyway in the kernel mapping
 	 */
 	dart_tablebase = (unsigned long)
-		abs_to_virt(memblock_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
+		__va(memblock_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
 
 	printk(KERN_INFO "DART table allocated at: %lx\n", dart_tablebase);
 }
-- 
1.7.9.5
