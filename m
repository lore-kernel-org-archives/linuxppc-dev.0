Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id DFF951A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 01:02:20 +1100 (AEDT)
Message-Id: <4a508a481397cb2c71942eaf6b07afa6eb6417a2.1446893433.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1446893426.git.christophe.leroy@c-s.fr>
References: <cover.1446893426.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 18/23] powerpc: add inline functions for cache related
 instructions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Nov 2015 14:32:36 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds inline functions to use dcbz, dcbi, dcbf, dcbst
from C functions

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: new
v3: no change

 arch/powerpc/include/asm/cache.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 5f8229e..ffbafbf 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -69,6 +69,25 @@ extern void _set_L3CR(unsigned long);
 #define _set_L3CR(val)	do { } while(0)
 #endif
 
+static inline void dcbz(void *addr)
+{
+	__asm__ __volatile__ ("dcbz 0, %0" : : "r"(addr) : "memory");
+}
+
+static inline void dcbi(void *addr)
+{
+	__asm__ __volatile__ ("dcbi 0, %0" : : "r"(addr) : "memory");
+}
+
+static inline void dcbf(void *addr)
+{
+	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
+}
+
+static inline void dcbst(void *addr)
+{
+	__asm__ __volatile__ ("dcbst 0, %0" : : "r"(addr) : "memory");
+}
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */
-- 
2.1.0
