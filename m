Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C2722B7223
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 14:13:51 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <57aa741dd20afd92712007325b649bc5c2315230.1245298429.git.michael@ellerman.id.au>
In-Reply-To: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
References: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/7] powerpc: Cleanup & use pr_devel() in arch/powerpc/mm/slb.c
Date: Thu, 18 Jun 2009 14:13:51 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_debug() can now result in code being generated even when DEBUG
is not defined. That's not really desirable in some places.

With CONFIG_DYNAMIC_DEBUG=y:

size before:
   text    data     bss     dec     hex filename
   3261     416       4    3681     e61 arch/powerpc/mm/slb.o

size after:
   text    data     bss     dec     hex filename
   2861     248       4    3113     c29 arch/powerpc/mm/slb.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/slb.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 3b52c80..5b7038f 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -14,8 +14,6 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
-
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
@@ -27,11 +25,6 @@
 #include <linux/compiler.h>
 #include <asm/udbg.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG pr_debug
-#endif
 
 extern void slb_allocate_realmode(unsigned long ea);
 extern void slb_allocate_user(unsigned long ea);
@@ -285,13 +278,13 @@ void slb_initialize(void)
 		patch_slb_encoding(slb_compare_rr_to_size,
 				   mmu_slb_size);
 
-		DBG("SLB: linear  LLP = %04lx\n", linear_llp);
-		DBG("SLB: io      LLP = %04lx\n", io_llp);
+		pr_devel("SLB: linear  LLP = %04lx\n", linear_llp);
+		pr_devel("SLB: io      LLP = %04lx\n", io_llp);
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 		patch_slb_encoding(slb_miss_kernel_load_vmemmap,
 				   SLB_VSID_KERNEL | vmemmap_llp);
-		DBG("SLB: vmemmap LLP = %04lx\n", vmemmap_llp);
+		pr_devel("SLB: vmemmap LLP = %04lx\n", vmemmap_llp);
 #endif
 	}
 
-- 
1.6.2.1
