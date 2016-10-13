Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svc6L5D1SzDsy2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:44:10 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id s8so4063641pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 20:44:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc/64s: reduce exception alignment
Date: Thu, 13 Oct 2016 14:43:52 +1100
Message-Id: <20161013034352.9410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Exception handlers are aligned to 128 bytes (L1 cache) on 64s, which is
overkill. It can reduce the icache footprint of any individual exception
path. However taken as a whole, the expansion in icache footprint seems
likely to be counter-productive and cause more total misses.

Create IFETCH_ALIGN_SHIFT/BYTES, which should give optimal ifetch
alignment with much more reasonable alignment. This saves 1792 bytes
from head_64.o text with an allmodconfig build.

Other subarchitectures should define appropriate IFETCH_ALIGN_SHIFT
values if this becomes more widely used.

Cc: Anton Blanchard <anton@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cache.h     | 3 +++
 arch/powerpc/include/asm/head-64.h   | 8 ++++----
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index ffbafbf..7657aa8 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -20,12 +20,15 @@
 #endif
 #else /* CONFIG_PPC64 */
 #define L1_CACHE_SHIFT		7
+#define IFETCH_ALIGN_SHIFT	4 /* POWER8,9 */
 #endif
 
 #define	L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 #define	SMP_CACHE_BYTES		L1_CACHE_BYTES
 
+#define IFETCH_ALIGN_BYTES	(1 << IFETCH_ALIGN_SHIFT)
+
 #if defined(__powerpc64__) && !defined(__ASSEMBLY__)
 struct ppc64_caches {
 	u32	dsize;			/* L1 d-cache size */
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index ab90c2f..fca7033 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -95,12 +95,12 @@ end_##sname:
 
 #define __FIXED_SECTION_ENTRY_BEGIN(sname, name, __align)	\
 	USE_FIXED_SECTION(sname);				\
-	.align __align;						\
+	.balign __align;					\
 	.global name;						\
 name:
 
 #define FIXED_SECTION_ENTRY_BEGIN(sname, name)			\
-	__FIXED_SECTION_ENTRY_BEGIN(sname, name, 0)
+	__FIXED_SECTION_ENTRY_BEGIN(sname, name, IFETCH_ALIGN_BYTES)
 
 #define FIXED_SECTION_ENTRY_BEGIN_LOCATION(sname, name, start)		\
 	USE_FIXED_SECTION(sname);				\
@@ -203,9 +203,9 @@ end_##sname:
 #define EXC_VIRT_END(name, start, end)			\
 	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##name, end)
 
-#define EXC_COMMON_BEGIN(name)					\
+#define EXC_COMMON_BEGIN(name)						\
 	USE_TEXT_SECTION();						\
-	.align	7;							\
+	.balign IFETCH_ALIGN_BYTES;					\
 	.global name;							\
 	DEFINE_FIXED_SYMBOL(name);					\
 name:
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e680e84..4af87e4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1403,7 +1403,7 @@ USE_TEXT_SECTION()
 /*
  * Hash table stuff
  */
-	.align	7
+	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
 #ifdef CONFIG_PPC_STD_MMU_64
 	andis.	r0,r4,0xa410		/* weird error? */
-- 
2.9.3
