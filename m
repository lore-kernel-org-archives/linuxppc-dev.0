Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8YCJ4phkzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 21:18:52 +1000 (AEST)
Message-Id: <1940eb7224ec831a9a4324bfd859797f180a2e53.1492772606.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492772606.git.christophe.leroy@c-s.fr>
References: <cover.1492772606.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/4] powerpc: Use builtin functions for fls()/__fls()/fls64()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 21 Apr 2017 13:18:48 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the fls() functions as defined in arch/powerpc/include/asm/bitops.h
GCC will not optimise the code in case of constant parameter.

This patch replaces __fls() by the builtin function, and modifies
fls() and fls64() to use builtins instead of inline assembly

For non constant calls, the generated code is doing the same:

int testfls(unsigned int x)
{
	return fls(x);
}

unsigned long test__fls(unsigned long x)
{
	return __fls(x);
}

int testfls64(__u64 x)
{
	return fls64(x);
}

On PPC32, before the patch:
00000064 <testfls>:
  64:	7c 63 00 34 	cntlzw  r3,r3
  68:	20 63 00 20 	subfic  r3,r3,32
  6c:	4e 80 00 20 	blr

00000070 <test__fls>:
  70:	7c 63 00 34 	cntlzw  r3,r3
  74:	20 63 00 1f 	subfic  r3,r3,31
  78:	4e 80 00 20 	blr

0000007c <testfls64>:
  7c:	2c 03 00 00 	cmpwi   r3,0
  80:	40 82 00 10 	bne     90 <testfls64+0x14>
  84:	7c 83 00 34 	cntlzw  r3,r4
  88:	20 63 00 20 	subfic  r3,r3,32
  8c:	4e 80 00 20 	blr
  90:	7c 63 00 34 	cntlzw  r3,r3
  94:	20 63 00 40 	subfic  r3,r3,64
  98:	4e 80 00 20 	blr

On PPC32, after the patch:
00000054 <testfls>:
  54:	7c 63 00 34 	cntlzw  r3,r3
  58:	20 63 00 20 	subfic  r3,r3,32
  5c:	4e 80 00 20 	blr

00000060 <test__fls>:
  60:	7c 63 00 34 	cntlzw  r3,r3
  64:	20 63 00 1f 	subfic  r3,r3,31
  68:	4e 80 00 20 	blr

0000006c <testfls64>:
  6c:	2c 03 00 00 	cmpwi   r3,0
  70:	41 82 00 10 	beq     80 <testfls64+0x14>
  74:	7c 63 00 34 	cntlzw  r3,r3
  78:	20 63 00 40 	subfic  r3,r3,64
  7c:	4e 80 00 20 	blr
  80:	7c 83 00 34 	cntlzw  r3,r4
  84:	20 63 00 40 	subfic  r3,r3,32
  88:	4e 80 00 20 	blr

On PPC64, before the patch:
00000000000000a0 <.testfls>:
  a0:	7c 63 00 34 	cntlzw  r3,r3
  a4:	20 63 00 20 	subfic  r3,r3,32
  a8:	7c 63 07 b4 	extsw   r3,r3
  ac:	4e 80 00 20 	blr

00000000000000b0 <.test__fls>:
  b0:	7c 63 00 74 	cntlzd  r3,r3
  b4:	20 63 00 3f 	subfic  r3,r3,63
  b8:	7c 63 07 b4 	extsw   r3,r3
  bc:	4e 80 00 20 	blr

00000000000000c0 <.testfls64>:
  c0:	7c 63 00 74 	cntlzd  r3,r3
  c4:	20 63 00 40 	subfic  r3,r3,64
  c8:	7c 63 07 b4 	extsw   r3,r3
  cc:	4e 80 00 20 	blr

On PPC64, after the patch:
0000000000000090 <.testfls>:
  90:	7c 63 00 34 	cntlzw  r3,r3
  94:	20 63 00 20 	subfic  r3,r3,32
  98:	7c 63 07 b4 	extsw   r3,r3
  9c:	4e 80 00 20 	blr

00000000000000a0 <.test__fls>:
  a0:	7c 63 00 74 	cntlzd  r3,r3
  a4:	20 63 00 3f 	subfic  r3,r3,63
  a8:	4e 80 00 20 	blr
  ac:	60 00 00 00 	nop

00000000000000b0 <.testfls64>:
  b0:	7c 63 00 74 	cntlzd  r3,r3
  b4:	20 63 00 40 	subfic  r3,r3,64
  b8:	7c 63 07 b4 	extsw   r3,r3
  bc:	4e 80 00 20 	blr

Those builtins have been in GCC since at least 3.4.6 (see
https://gcc.gnu.org/onlinedocs/gcc-3.4.6/gcc/Other-Builtins.html )

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/bitops.h | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 71b05685f3a7..af36b404dbe8 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -263,33 +263,15 @@ static __inline__ unsigned long ffz(unsigned long x)
  */
 static __inline__ int fls(unsigned int x)
 {
-	int lz;
-
-	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
-	return 32 - lz;
+	return 32 - __builtin_clz(x);
 }
 
-static __inline__ unsigned long __fls(unsigned long x)
-{
-	return __ilog2(x);
-}
+#include <asm-generic/bitops/builtin-__fls.h>
 
-/*
- * 64-bit can do this using one cntlzd (count leading zeroes doubleword)
- * instruction; for 32-bit we use the generic version, which does two
- * 32-bit fls calls.
- */
-#ifdef __powerpc64__
 static __inline__ int fls64(__u64 x)
 {
-	int lz;
-
-	asm ("cntlzd %0,%1" : "=r" (lz) : "r" (x));
-	return 64 - lz;
+	return 64 - __builtin_clzll(x);
 }
-#else
-#include <asm-generic/bitops/fls64.h>
-#endif /* __powerpc64__ */
 
 #ifdef CONFIG_PPC64
 unsigned int __arch_hweight8(unsigned int w);
-- 
2.12.0
