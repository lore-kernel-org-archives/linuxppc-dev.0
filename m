Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nSwc6hp7zF2BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 23:01:20 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/lib: Adjust .balign inside string functions for
 PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180518130116.A1A3B6F937@po14934vm.idsi0.si.c-s.fr>
Date: Fri, 18 May 2018 15:01:16 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 87a156fb18fe1 ("Align hot loops of some string functions")
degraded the performance of string functions by adding useless
nops

A simple benchmark on an 8xx calling 100000x a memchr() that
matches the first byte runs in 41668 TB ticks before this patch
and in 35986 TB ticks after this patch. So this gives an
improvement of approx 10%

Another benchmark doing the same with a memchr() matching the 128th
byte runs in 1011365 TB ticks before this patch and 1005682 TB ticks
after this patch, so regardless on the number of loops, removing
those useless nops improves the test by 5683 TB ticks.

Fixes: 87a156fb18fe1 ("Align hot loops of some string functions")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Define IFETCH_ALIGN_SHIFT for PPC32 and use IFETCH_ALIGN_BYTES
    for the alignment

 arch/powerpc/include/asm/cache.h | 3 +++
 arch/powerpc/lib/string.S        | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index c1d257aa4c2d..66298461b640 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -9,11 +9,14 @@
 #if defined(CONFIG_PPC_8xx) || defined(CONFIG_403GCX)
 #define L1_CACHE_SHIFT		4
 #define MAX_COPY_PREFETCH	1
+#define IFETCH_ALIGN_SHIFT	2
 #elif defined(CONFIG_PPC_E500MC)
 #define L1_CACHE_SHIFT		6
 #define MAX_COPY_PREFETCH	4
+#define IFETCH_ALIGN_SHIFT	3
 #elif defined(CONFIG_PPC32)
 #define MAX_COPY_PREFETCH	4
+#define IFETCH_ALIGN_SHIFT	3	/* 603 fetches 2 insn at a time */
 #if defined(CONFIG_PPC_47x)
 #define L1_CACHE_SHIFT		7
 #else
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index a787776822d8..0378def28d41 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -12,6 +12,7 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/cache.h>
 
 	.text
 	
@@ -23,7 +24,7 @@ _GLOBAL(strncpy)
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
-	.balign 16
+	.balign IFETCH_ALIGN_BYTES
 1:	lbzu	r0,1(r4)
 	cmpwi	0,r0,0
 	stbu	r0,1(r6)
@@ -43,7 +44,7 @@ _GLOBAL(strncmp)
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
-	.balign 16
+	.balign IFETCH_ALIGN_BYTES
 1:	lbzu	r3,1(r5)
 	cmpwi	1,r3,0
 	lbzu	r0,1(r4)
@@ -77,7 +78,7 @@ _GLOBAL(memchr)
 	beq-	2f
 	mtctr	r5
 	addi	r3,r3,-1
-	.balign 16
+	.balign IFETCH_ALIGN_BYTES
 1:	lbzu	r0,1(r3)
 	cmpw	0,r0,r4
 	bdnzf	2,1b
-- 
2.13.3
