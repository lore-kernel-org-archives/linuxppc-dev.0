Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M39v0JWmzF1wr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 02:25:22 +1000 (AEST)
Message-Id: <2940336694008357af53e183791f1d7abff4d757.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 15/16] powerpc: remove unnecessary inclusion of
 asm/tlbflush.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 16:25:19 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

asm/tlbflush.h is only needed for:
- using functions xxx_flush_tlb_xxx()
- using MMU_NO_CONTEXT
- including asm-generic/pgtable.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/highmem.h    | 2 +-
 arch/powerpc/include/asm/tlb.h        | 1 -
 arch/powerpc/kvm/book3s.c             | 1 -
 arch/powerpc/kvm/book3s_32_mmu.c      | 1 -
 arch/powerpc/kvm/book3s_64_mmu.c      | 1 -
 arch/powerpc/kvm/book3s_64_mmu_hv.c   | 1 -
 arch/powerpc/kvm/book3s_64_vio.c      | 1 -
 arch/powerpc/kvm/book3s_64_vio_hv.c   | 1 -
 arch/powerpc/kvm/book3s_hv.c          | 1 -
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   | 1 -
 arch/powerpc/kvm/book3s_pr.c          | 1 -
 arch/powerpc/kvm/e500.c               | 1 -
 arch/powerpc/kvm/e500mc.c             | 1 -
 arch/powerpc/kvm/powerpc.c            | 1 -
 arch/powerpc/mm/fault.c               | 1 -
 arch/powerpc/mm/hash_native_64.c      | 1 -
 arch/powerpc/mm/hash_utils_64.c       | 1 -
 arch/powerpc/mm/mmu_context_hash32.c  | 1 -
 arch/powerpc/mm/mmu_decl.h            | 1 -
 arch/powerpc/mm/subpage-prot.c        | 1 -
 arch/powerpc/platforms/pseries/lpar.c | 1 -
 arch/powerpc/sysdev/cpm1.c            | 1 -
 22 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index cec820f961da..a4b65b186ec6 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -25,7 +25,7 @@
 
 #include <linux/interrupt.h>
 #include <asm/kmap_types.h>
-#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/fixmap.h>
 
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 9138baccebb0..6d2ba7c779dc 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -17,7 +17,6 @@
 #include <asm/pgtable.h>
 #endif
 #include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
 #ifndef __powerpc64__
 #include <asm/page.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index edaf4720d156..87348e498c89 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -28,7 +28,6 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 45c8ea4a0487..612169988a3d 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -23,7 +23,6 @@
 #include <linux/kvm_host.h>
 #include <linux/highmem.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index cf9d686e8162..c92dd25bed23 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -23,7 +23,6 @@
 #include <linux/kvm_host.h>
 #include <linux/highmem.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 7f3a8cf5d66f..3c0e8fb2b773 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -29,7 +29,6 @@
 #include <linux/file.h>
 #include <linux/debugfs.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index d066e37551ec..b3c1935229b0 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -31,7 +31,6 @@
 #include <linux/iommu.h>
 #include <linux/file.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 80d50d67b8c5..3315a56b6737 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -28,7 +28,6 @@
 #include <linux/list.h>
 #include <linux/stringify.h>
 
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/book3s/64/mmu-hash.h>
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de686b340f4a..b4a5cc8525a0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -53,7 +53,6 @@
 #include <asm/disassemble.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 1f22d9e977d4..a67cf1cdeda4 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/log2.h>
 
-#include <asm/tlbflush.h>
 #include <asm/trace.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index c3b8006f0eac..47ee43bbd696 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -27,7 +27,6 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index f9f6468f4171..afd3c255a427 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -21,7 +21,6 @@
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 
 #include "../mm/mmu_decl.h"
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index d0b6b5788afc..d31645491a93 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -21,7 +21,6 @@
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
-#include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/dbell.h>
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 0e8c20c5eaac..3ccc386b380d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -33,7 +33,6 @@
 #include <asm/cputable.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_ppc.h>
-#include <asm/tlbflush.h>
 #include <asm/cputhreads.h>
 #include <asm/irqflags.h>
 #include <asm/iommu.h>
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b1ca7a0974e3..7d262c6437c4 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -42,7 +42,6 @@
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
-#include <asm/tlbflush.h>
 #include <asm/siginfo.h>
 #include <asm/debug.h>
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 1baabc74c4ae..4958f2a4f1d5 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -23,7 +23,6 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
-#include <asm/tlbflush.h>
 #include <asm/trace.h>
 #include <asm/tlb.h>
 #include <asm/cputable.h>
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8318716e5075..af6c70dfe140 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -48,7 +48,6 @@
 #include <linux/uaccess.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
-#include <asm/tlbflush.h>
 #include <asm/io.h>
 #include <asm/eeh.h>
 #include <asm/tlb.h>
diff --git a/arch/powerpc/mm/mmu_context_hash32.c b/arch/powerpc/mm/mmu_context_hash32.c
index aa5a7fd89461..921c1e33e941 100644
--- a/arch/powerpc/mm/mmu_context_hash32.c
+++ b/arch/powerpc/mm/mmu_context_hash32.c
@@ -27,7 +27,6 @@
 #include <linux/export.h>
 
 #include <asm/mmu_context.h>
-#include <asm/tlbflush.h>
 
 /*
  * On 32-bit PowerPC 6xx/7xx/7xxx CPUs, we use a set of 16 VSIDs
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index c4c0a09a7775..e5d779eed181 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -19,7 +19,6 @@
  *
  */
 #include <linux/mm.h>
-#include <asm/tlbflush.h>
 #include <asm/mmu.h>
 
 #ifdef CONFIG_PPC_MMU_NOHASH
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 9d16ee251fc0..3327551c8b47 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -17,7 +17,6 @@
 
 #include <asm/pgtable.h>
 #include <linux/uaccess.h>
-#include <asm/tlbflush.h>
 
 /*
  * Free all pages allocated for subpage protection maps and pointers.
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5a392e40f3d2..bc50f1dcc430 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -36,7 +36,6 @@
 #include <asm/machdep.h>
 #include <asm/mmu_context.h>
 #include <asm/iommu.h>
-#include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
 #include <asm/cputable.h>
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 5240d3a74a10..4f8dcf124828 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -38,7 +38,6 @@
 #include <asm/8xx_immap.h>
 #include <asm/cpm1.h>
 #include <asm/io.h>
-#include <asm/tlbflush.h>
 #include <asm/rheap.h>
 #include <asm/prom.h>
 #include <asm/cpm.h>
-- 
2.13.3
