Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG2z102GNzF0QH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 17:58:03 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Remove memory clobber asm constraint on dcbX()
 functions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180109065759.4E54B6C73D@localhost.localdomain>
Date: Tue,  9 Jan 2018 07:57:59 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of just telling GCC that dcbz(), dcbi(), dcbf() and dcbst()
clobber memory, tell it what it clobbers:
* dcbz(), dcbi() and dcbf() clobbers one cacheline as output
* dcbf() and dcbst() clobbers one cacheline as input

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cache.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index c1d257aa4c2d..fc8fe18acf8c 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -82,22 +82,31 @@ extern void _set_L3CR(unsigned long);
 
 static inline void dcbz(void *addr)
 {
-	__asm__ __volatile__ ("dcbz 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbz 0, %1" :
+			      "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
+			      "r"(addr) :);
 }
 
 static inline void dcbi(void *addr)
 {
-	__asm__ __volatile__ ("dcbi 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbi 0, %1" :
+			      "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
+			      "r"(addr) :);
 }
 
 static inline void dcbf(void *addr)
 {
-	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbf 0, %1" :
+			      "=m"(*(char (*)[L1_CACHE_BYTES])addr) :
+			      "r"(addr), "m"(*(char (*)[L1_CACHE_BYTES])addr) :
+			     );
 }
 
 static inline void dcbst(void *addr)
 {
-	__asm__ __volatile__ ("dcbst 0, %0" : : "r"(addr) : "memory");
+	__asm__ __volatile__ ("dcbst 0, %0" : :
+			      "r"(addr), "m"(*(char (*)[L1_CACHE_BYTES])addr) :
+			     );
 }
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
-- 
2.13.3
