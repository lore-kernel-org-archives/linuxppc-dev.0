Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5H6k5cXFzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 01:32:27 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: Discard ffs() function and use builtin_ffs instead
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160512153222.6109E1A239A@localhost.localdomain>
Date: Thu, 12 May 2016 17:32:22 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the ffs() function as defined in arch/powerpc/include/asm/bitops.h
GCC will not optimise the code in case of constant parameter, as shown
by the small exemple below.

int ffs_test(void)
{
	return 4 << ffs(31);
}

c0012334 <ffs_test>:
c0012334:       39 20 00 01     li      r9,1
c0012338:       38 60 00 04     li      r3,4
c001233c:       7d 29 00 34     cntlzw  r9,r9
c0012340:       21 29 00 20     subfic  r9,r9,32
c0012344:       7c 63 48 30     slw     r3,r3,r9
c0012348:       4e 80 00 20     blr

With this patch, the same function will compile as follows:

c0012334 <ffs_test>:
c0012334:       38 60 00 08     li      r3,8
c0012338:       4e 80 00 20     blr

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/bitops.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 59abc62..75e3ebb 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -218,16 +218,7 @@ static __inline__ unsigned long __ffs(unsigned long x)
 	return __ilog2(x & -x);
 }
 
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-static __inline__ int ffs(int x)
-{
-	unsigned long i = (unsigned long)x;
-	return __ilog2(i & -i) + 1;
-}
+#include <asm-generic/bitops/builtin-ffs.h>
 
 /*
  * fls: find last (most-significant) bit set.
-- 
2.1.0
