Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDdRp6dQfzDr4t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:43:02 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sDdRn6SbCz9sRB
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2016 15:43:01 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 03/10] powerpc: A new cache shape aux vectors
Date: Wed, 17 Aug 2016 15:39:10 +1000
Message-Id: <1471412357-3477-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
References: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The definition is loosely based on sh and alpha, modified to
accomodate larger associativity and cache size for future-proofing.

We currently set all the values to -1 which indicates that the
information isn't available.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/elf.h         |  8 ++++++++
 arch/powerpc/include/uapi/asm/auxvec.h | 27 ++++++++++++++++++++++++++-
 arch/powerpc/kernel/setup-common.c     |  5 ++++-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 730c27e..402605e 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -115,6 +115,10 @@ do {								\
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
+extern long il1cache_shape;
+extern long dl1cache_shape;
+extern long l2cache_shape;
+extern long l3cache_shape;
 
 /* vDSO has arch_setup_additional_pages */
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
@@ -155,6 +159,10 @@ do {									\
 	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
 	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
 	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
+	NEW_AUX_ENT(AT_L1I_CACHESHAPE, il1cache_shape);			\
+	NEW_AUX_ENT(AT_L1D_CACHESHAPE, dl1cache_shape);			\
+	NEW_AUX_ENT(AT_L2_CACHESHAPE, l2cache_shape);			\
+	NEW_AUX_ENT(AT_L3_CACHESHAPE, l3cache_shape);			\
 	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
 } while (0)
 
diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
index ce17d2c..b3861d8 100644
--- a/arch/powerpc/include/uapi/asm/auxvec.h
+++ b/arch/powerpc/include/uapi/asm/auxvec.h
@@ -16,6 +16,31 @@
  */
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
+/* More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the
+   value is -1, then the cache doesn't exist or information isn't
+   availble.  Otherwise:
+
+      bit 0-9:	  Cache set-associativity 0 means fully associative.
+      bit 10-13:  Log2 of cacheline size.
+      bit 14-31:  Size of the entire cache >> 10.
+      bit 32-39:  [64-bit only] more bits for total cache size.
+      bit 40-63:  Reserved
+
+   If any of the fields is all 1's, then that field isn't available.
+
+    WARNING: The cache *line* size can be different from the cache *block*
+             size. The latter, represented by vectors 19,20,21, is the size
+	     used by the cache management instructions such as dcbz. The
+	     cache line size on the other hand is the real HW line size
+	     for a given cache level which might be different and should
+	     only be used for performance related tuning
+*/
+
+#define AT_L1I_CACHESHAPE	34
+#define AT_L1D_CACHESHAPE	35
+#define AT_L2_CACHESHAPE	36
+#define AT_L3_CACHESHAPE	37
+
+#define AT_VECTOR_SIZE_ARCH	10 /* entries in ARCH_DLINFO */
 
 #endif
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index e0eeed4..cfa2a06 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -94,7 +94,10 @@ EXPORT_SYMBOL_GPL(boot_cpuid);
 int dcache_bsize;
 int icache_bsize;
 int ucache_bsize;
-
+long il1cache_shape = -1;
+long dl1cache_shape = -1;
+long l2cache_shape = -1;
+long l3cache_shape = -1;
 
 unsigned long klimit = (unsigned long) _end;
 
-- 
2.7.4
