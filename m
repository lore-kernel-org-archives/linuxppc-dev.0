Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8YCH5kMhzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 21:18:51 +1000 (AEST)
Message-Id: <a0105d18c39c419ed3b30270d0c2f30d10aa1947.1492772606.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492772606.git.christophe.leroy@c-s.fr>
References: <cover.1492772606.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/4] powerpc: Discard ffs()/__ffs() function and use builtin
 functions instead
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 21 Apr 2017 13:18:46 +0200 (CEST)
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

The same happens with __ffs()

For non constant calls, the generated code is doing the same,
allthought it is slightly different on 64 bits for ffs():

unsigned long test__ffs(unsigned long x)
{
	return __ffs(x);
}

int testffs(int x)
{
	return ffs(x);
}

On PPC32, before the patch:
0000003c <test__ffs>:
  3c:	7d 23 00 d0 	neg     r9,r3
  40:	7d 23 18 38 	and     r3,r9,r3
  44:	7c 63 00 34 	cntlzw  r3,r3
  48:	20 63 00 1f 	subfic  r3,r3,31
  4c:	4e 80 00 20 	blr

00000050 <testffs>:
  50:	7d 23 00 d0 	neg     r9,r3
  54:	7d 23 18 38 	and     r3,r9,r3
  58:	7c 63 00 34 	cntlzw  r3,r3
  5c:	20 63 00 20 	subfic  r3,r3,32
  60:	4e 80 00 20 	blr

On PPC32, after the patch:
0000002c <test__ffs>:
  2c:	7d 23 00 d0 	neg     r9,r3
  30:	7d 23 18 38 	and     r3,r9,r3
  34:	7c 63 00 34 	cntlzw  r3,r3
  38:	20 63 00 1f 	subfic  r3,r3,31
  3c:	4e 80 00 20 	blr

00000040 <testffs>:
  40:	7d 23 00 d0 	neg     r9,r3
  44:	7d 23 18 38 	and     r3,r9,r3
  48:	7c 63 00 34 	cntlzw  r3,r3
  4c:	20 63 00 20 	subfic  r3,r3,32
  50:	4e 80 00 20 	blr

On PPC64, before the patch:
0000000000000060 <.test__ffs>:
  60:	7c 03 00 d0 	neg     r0,r3
  64:	7c 03 18 38 	and     r3,r0,r3
  68:	7c 63 00 74 	cntlzd  r3,r3
  6c:	20 63 00 3f 	subfic  r3,r3,63
  70:	7c 63 07 b4 	extsw   r3,r3
  74:	4e 80 00 20 	blr

0000000000000080 <.testffs>:
  80:	7c 03 00 d0 	neg     r0,r3
  84:	7c 03 18 38 	and     r3,r0,r3
  88:	7c 63 00 74 	cntlzd  r3,r3
  8c:	20 63 00 40 	subfic  r3,r3,64
  90:	7c 63 07 b4 	extsw   r3,r3
  94:	4e 80 00 20 	blr

On PPC64, after the patch:
0000000000000050 <.test__ffs>:
  50:	7c 03 00 d0 	neg     r0,r3
  54:	7c 03 18 38 	and     r3,r0,r3
  58:	7c 63 00 74 	cntlzd  r3,r3
  5c:	20 63 00 3f 	subfic  r3,r3,63
  60:	4e 80 00 20 	blr

0000000000000070 <.testffs>:
  70:	7c 03 00 d0 	neg     r0,r3
  74:	7c 03 18 38 	and     r3,r0,r3
  78:	7c 63 00 34 	cntlzw  r3,r3
  7c:	20 63 00 20 	subfic  r3,r3,32
  80:	7c 63 07 b4 	extsw   r3,r3
  84:	4e 80 00 20 	blr
(ffs() operates on an int so cntlzw is equivalent to cntlzd)

In addition, when reading the generated vmlinux, we can observe
that with the builtin functions, GCC sometimes efficiently spreads
the instructions within the generated functions while the inline
assembly force them to remain grouped together.

__builtin_ffs() is already used in arch/powerpc/include/asm/page_32.h

Those builtins have been in GCC since at least 3.4.6 (see
https://gcc.gnu.org/onlinedocs/gcc-3.4.6/gcc/Other-Builtins.html )

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/bitops.h | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 33a24fdd7958..71b05685f3a7 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -253,21 +253,9 @@ static __inline__ unsigned long ffz(unsigned long x)
 	return __ilog2(x & -x);
 }
 
-static __inline__ unsigned long __ffs(unsigned long x)
-{
-	return __ilog2(x & -x);
-}
+#include <asm-generic/bitops/builtin-__ffs.h>
 
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
2.12.0
