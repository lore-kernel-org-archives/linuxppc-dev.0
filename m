Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m4gc1N9KzF1Rp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 16:45:14 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: get rid of PMD_PAGE_SIZE()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180516064509.A35E06F6EC@po14934vm.idsi0.si.c-s.fr>
Date: Wed, 16 May 2018 08:45:09 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PMD_PAGE_SIZE() is nowhere used, this patch removes it

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h | 2 --
 arch/powerpc/include/asm/pte-common.h        | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 124f9ac23a1e..1918fba42433 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -56,8 +56,6 @@
 #define _PMD_SIZE_4M	0x0c0
 #define _PMD_SIZE_16M	0x0e0
 
-#define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))
-
 /* Until my rework is finished, 40x still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index c4a72c7a8c83..0c070107825c 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -62,7 +62,6 @@
 #endif
 #ifndef _PMD_SIZE
 #define _PMD_SIZE	0
-#define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
 #endif
 #ifndef _PMD_USER
 #define _PMD_USER	0
@@ -88,11 +87,7 @@
 #define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
 #endif
 
-/* Make sure we get a link error if PMD_PAGE_SIZE is ever called on a
- * kernel without large page PMD support
- */
 #ifndef __ASSEMBLY__
-extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 
 /*
  * Don't just check for any non zero bits in __PAGE_USER, since for book3e
-- 
2.13.3
