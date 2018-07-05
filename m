Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M39f5zbzzF242
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 02:25:10 +1000 (AEST)
Message-Id: <b4b056df7ebb29c1757785baabaec7c1dd71cae8.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 09/16] powerpc/book3s: Remove PPC_PIN_SIZE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 16:25:07 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC_PIN_SIZE is specific to the 44x and is defined in mmu.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 5 -----
 arch/powerpc/include/asm/nohash/32/pgtable.h | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 3c3e34240628..751cf931bb3f 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -84,17 +84,12 @@
  * of RAM.  -- Cort
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
-#ifdef PPC_PIN_SIZE
-#define VMALLOC_START (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
-#else
 #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
-#endif
 #define VMALLOC_END	ioremap_bot
 
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
 #include <linux/threads.h>
-#include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
 
 extern unsigned long ioremap_bot;
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 7df2f3a66cc5..79805e0dad27 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -8,7 +8,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
 #include <linux/threads.h>
-#include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
+#include <asm/mmu.h>			/* For sub-arch specific PPC_PIN_SIZE */
 #include <asm/asm-405.h>
 
 extern unsigned long ioremap_bot;
-- 
2.13.3
