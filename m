Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8YCK3wxgzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 21:18:53 +1000 (AEST)
Message-Id: <a32c02cd42659861732cc3d746613775d79c7d00.1492772606.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492772606.git.christophe.leroy@c-s.fr>
References: <cover.1492772606.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/4] powerpc: Replace ffz() by equivalent generic function
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 21 Apr 2017 13:18:50 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the ffz() function as defined in arch/powerpc/include/asm/bitops.h
GCC will not optimise the code in case of constant parameter.

This patch replaces ffz() by the generic function.

The generic ffz(x) expects to never be called with ~x == 0
as written in the comment in include/asm-generic/bitops/ffz.h
The only user of ffz() within arch/powerpc/ is
platforms/512x/mpc5121_ads_cpld.c, which checks if x is not 0xff

For non constant calls, the generated code is doing the same:

unsigned long testffz(unsigned long x)
{
	return ffz(x);
}

On PPC32, before the patch:
00000018 <testffz>:
  18:	7c 63 18 f9 	not.    r3,r3
  1c:	40 82 00 0c 	bne     28 <testffz+0x10>
  20:	38 60 00 20 	li      r3,32
  24:	4e 80 00 20 	blr
  28:	7d 23 00 d0 	neg     r9,r3
  2c:	7d 23 18 38 	and     r3,r9,r3
  30:	7c 63 00 34 	cntlzw  r3,r3
  34:	20 63 00 1f 	subfic  r3,r3,31
  38:	4e 80 00 20 	blr

On PPC32, after the patch:
00000018 <testffz>:
  18:	39 23 00 01 	addi    r9,r3,1
  1c:	7d 23 18 78 	andc    r3,r9,r3
  20:	7c 63 00 34 	cntlzw  r3,r3
  24:	20 63 00 1f 	subfic  r3,r3,31
  28:	4e 80 00 20 	blr

On PPC64, before the patch:
0000000000000030 <.testffz>:
  30:	7c 60 18 f9 	not.    r0,r3
  34:	38 60 00 40 	li      r3,64
  38:	4d 82 00 20 	beqlr
  3c:	7c 60 00 d0 	neg     r3,r0
  40:	7c 63 00 38 	and     r3,r3,r0
  44:	7c 63 00 74 	cntlzd  r3,r3
  48:	20 63 00 3f 	subfic  r3,r3,63
  4c:	7c 63 07 b4 	extsw   r3,r3
  50:	4e 80 00 20 	blr

On PPC64, after the patch:
0000000000000030 <.testffz>:
  30:	38 03 00 01 	addi    r0,r3,1
  34:	7c 03 18 78 	andc    r3,r0,r3
  38:	7c 63 00 74 	cntlzd  r3,r3
  3c:	20 63 00 3f 	subfic  r3,r3,63
  40:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/bitops.h | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index af36b404dbe8..d835cd697d6b 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -233,25 +233,7 @@ int __ilog2_u64(u64 n)
 }
 #endif
 
-/*
- * Determines the bit position of the least significant 0 bit in the
- * specified double word. The returned bit position will be
- * zero-based, starting from the right side (63/31 - 0).
- */
-static __inline__ unsigned long ffz(unsigned long x)
-{
-	/* no zero exists anywhere in the 8 byte area. */
-	if ((x = ~x) == 0)
-		return BITS_PER_LONG;
-
-	/*
-	 * Calculate the bit position of the least significant '1' bit in x
-	 * (since x has been changed this will actually be the least significant
-	 * '0' bit in * the original x).  Note: (x & -x) gives us a mask that
-	 * is the least significant * (RIGHT-most) 1-bit of the value in x.
-	 */
-	return __ilog2(x & -x);
-}
+#include <asm-generic/bitops/ffz.h>
 
 #include <asm-generic/bitops/builtin-__ffs.h>
 
-- 
2.12.0
