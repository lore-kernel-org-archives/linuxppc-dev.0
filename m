Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNNtT0XcnzDvrr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:44:49 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/32: Discard ffs() function and use builtin_ffs
 instead
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20161122114444.D0CE8678CE@localhost.localdomain>
Date: Tue, 22 Nov 2016 12:44:44 +0100 (CET)
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

c000b8f4 <ffs_test>:
c000b8f4:	38 00 00 01 	li      r0,1
c000b8f8:	38 60 00 04 	li      r3,4
c000b8fc:	7c 00 00 34 	cntlzw  r0,r0
c000b900:	20 00 00 20 	subfic  r0,r0,32
c000b904:	7c 63 00 30 	slw     r3,r3,r0
c000b908:	4e 80 00 20 	blr

With this patch, the same function will compile as follows:

c000b8f4 <ffs_test>:
c000b8f4:	38 60 00 08 	li      r3,8
c000b8f8:	4e 80 00 20 	blr

With non constant parameters, the generated code is identical on PPC32
without and with the patch:

int ffs_test2(long x)
{
	return ffs(x);
}

Before:
c000b90c <ffs_test2>:
c000b90c:	7c 03 00 d0 	neg     r0,r3
c000b910:	7c 03 18 38 	and     r3,r0,r3
c000b914:	7c 63 00 34 	cntlzw  r3,r3
c000b918:	20 63 00 20 	subfic  r3,r3,32
c000b91c:	4e 80 00 20 	blr

After:
c000b8fc <ffs_test2>:
c000b8fc:	7c 03 00 d0 	neg     r0,r3
c000b900:	7c 03 18 38 	and     r3,r0,r3
c000b904:	7c 63 00 34 	cntlzw  r3,r3
c000b908:	20 63 00 20 	subfic  r3,r3,32
c000b90c:	4e 80 00 20 	blr

__builtin_ffs() is already used in arch/powerpc/include/asm/page_32.h
__builtin_ffs() has been in GCC since at least gcc-2.95

On PPC64, the generated code is different, so we do this change
only on PPC32:

Before the change:
c000000000027c00 <.ffs_test2>:
c000000000027c00:	7c 03 00 d0 	neg     r0,r3
c000000000027c04:	7c 03 18 38 	and     r3,r0,r3
c000000000027c08:	7c 63 00 74 	cntlzd  r3,r3
c000000000027c0c:	20 63 00 40 	subfic  r3,r3,64
c000000000027c10:	7c 63 07 b4 	extsw   r3,r3
c000000000027c14:	4e 80 00 20 	blr

After the change:
c000000000027bf0 <.ffs_test2>:
c000000000027bf0:	7c 03 00 d0 	neg     r0,r3
c000000000027bf4:	7c 03 18 38 	and     r3,r0,r3
c000000000027bf8:	7c 63 00 34 	cntlzw  r3,r3
c000000000027bfc:	20 63 00 20 	subfic  r3,r3,32
c000000000027c00:	7c 63 07 b4 	extsw   r3,r3
c000000000027c04:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: limit the change to PPC32

 arch/powerpc/include/asm/bitops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 59abc62..0e84f0c 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -223,11 +223,15 @@ static __inline__ unsigned long __ffs(unsigned long x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
+#ifdef CONFIG_PPC64
 static __inline__ int ffs(int x)
 {
 	unsigned long i = (unsigned long)x;
 	return __ilog2(i & -i) + 1;
 }
+#else
+#include <asm-generic/bitops/builtin-ffs.h>
+#endif
 
 /*
  * fls: find last (most-significant) bit set.
-- 
2.10.1
