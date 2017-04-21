Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8YCM56JXzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 21:18:55 +1000 (AEST)
Message-Id: <e58e91530039da0d89eb52a2a1ec0bb30518741d.1492772606.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492772606.git.christophe.leroy@c-s.fr>
References: <cover.1492772606.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/4] powerpc: remove __ilog2()s and use generic ones
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 21 Apr 2017 13:18:52 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the __ilog2() function as defined in
arch/powerpc/include/asm/bitops.h, GCC will not optimise the code
in case of constant parameter.

The generic ilog2() function in include/linux/log2.h is written
to handle the case of the constant parameter.

This patch discards the three __ilog2() functions and
defines __ilog2() as ilog2()

For non constant calls, the generated code is doing the same:
int test__ilog2(unsigned long x)
{
	return __ilog2(x);
}

int test__ilog2_u32(u32 n)
{
	return __ilog2_u32(n);
}

int test__ilog2_u64(u64 n)
{
	return __ilog2_u64(n);
}

On PPC32 before the patch:
00000000 <test__ilog2>:
   0:	7c 63 00 34 	cntlzw  r3,r3
   4:	20 63 00 1f 	subfic  r3,r3,31
   8:	4e 80 00 20 	blr

0000000c <test__ilog2_u32>:
   c:	7c 63 00 34 	cntlzw  r3,r3
  10:	20 63 00 1f 	subfic  r3,r3,31
  14:	4e 80 00 20 	blr

On PPC32 after the patch:
00000000 <test__ilog2>:
   0:	7c 63 00 34 	cntlzw  r3,r3
   4:	20 63 00 1f 	subfic  r3,r3,31
   8:	4e 80 00 20 	blr

0000000c <test__ilog2_u32>:
   c:	7c 63 00 34 	cntlzw  r3,r3
  10:	20 63 00 1f 	subfic  r3,r3,31
  14:	4e 80 00 20 	blr

On PPC64 before the patch:
0000000000000000 <.test__ilog2>:
   0:	7c 63 00 74 	cntlzd  r3,r3
   4:	20 63 00 3f 	subfic  r3,r3,63
   8:	7c 63 07 b4 	extsw   r3,r3
   c:	4e 80 00 20 	blr

0000000000000010 <.test__ilog2_u32>:
  10:	7c 63 00 34 	cntlzw  r3,r3
  14:	20 63 00 1f 	subfic  r3,r3,31
  18:	7c 63 07 b4 	extsw   r3,r3
  1c:	4e 80 00 20 	blr

0000000000000020 <.test__ilog2_u64>:
  20:	7c 63 00 74 	cntlzd  r3,r3
  24:	20 63 00 3f 	subfic  r3,r3,63
  28:	7c 63 07 b4 	extsw   r3,r3
  2c:	4e 80 00 20 	blr

On PPC64 after the patch:
0000000000000000 <.test__ilog2>:
   0:	7c 63 00 74 	cntlzd  r3,r3
   4:	20 63 00 3f 	subfic  r3,r3,63
   8:	7c 63 07 b4 	extsw   r3,r3
   c:	4e 80 00 20 	blr

0000000000000010 <.test__ilog2_u32>:
  10:	7c 63 00 34 	cntlzw  r3,r3
  14:	20 63 00 1f 	subfic  r3,r3,31
  18:	7c 63 07 b4 	extsw   r3,r3
  1c:	4e 80 00 20 	blr

0000000000000020 <.test__ilog2_u64>:
  20:	7c 63 00 74 	cntlzd  r3,r3
  24:	20 63 00 3f 	subfic  r3,r3,63
  28:	7c 63 07 b4 	extsw   r3,r3
  2c:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig              |  8 --------
 arch/powerpc/include/asm/bitops.h | 27 +--------------------------
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2bfd49098c5e..f231b0f190b5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -62,14 +62,6 @@ config GENERIC_LOCKBREAK
 	default y
 	depends on SMP && PREEMPT
 
-config ARCH_HAS_ILOG2_U32
-	bool
-	default y
-
-config ARCH_HAS_ILOG2_U64
-	bool
-	default y if 64BIT
-
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index d835cd697d6b..b750ffef83c7 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -206,32 +206,7 @@ static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
  * Return the zero-based bit position (LE, not IBM bit numbering) of
  * the most significant 1-bit in a double word.
  */
-static __inline__ __attribute__((const))
-int __ilog2(unsigned long x)
-{
-	int lz;
-
-	asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (x));
-	return BITS_PER_LONG - 1 - lz;
-}
-
-static inline __attribute__((const))
-int __ilog2_u32(u32 n)
-{
-	int bit;
-	asm ("cntlzw %0,%1" : "=r" (bit) : "r" (n));
-	return 31 - bit;
-}
-
-#ifdef __powerpc64__
-static inline __attribute__((const))
-int __ilog2_u64(u64 n)
-{
-	int bit;
-	asm ("cntlzd %0,%1" : "=r" (bit) : "r" (n));
-	return 63 - bit;
-}
-#endif
+#define __ilog2(x)	ilog2(x)
 
 #include <asm-generic/bitops/ffz.h>
 
-- 
2.12.0
