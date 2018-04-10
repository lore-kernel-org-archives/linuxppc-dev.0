Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ky8015bbzDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 16:34:39 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/64: optimises from64to32()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180410063435.272F8653BC@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 10 Apr 2018 08:34:35 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current implementation of from64to32() gives a poor result:

0000000000000270 <.from64to32>:
 270:	38 00 ff ff 	li      r0,-1
 274:	78 69 00 22 	rldicl  r9,r3,32,32
 278:	78 00 00 20 	clrldi  r0,r0,32
 27c:	7c 60 00 38 	and     r0,r3,r0
 280:	7c 09 02 14 	add     r0,r9,r0
 284:	78 09 00 22 	rldicl  r9,r0,32,32
 288:	7c 00 4a 14 	add     r0,r0,r9
 28c:	78 03 00 20 	clrldi  r3,r0,32
 290:	4e 80 00 20 	blr

This patch modifies from64to32() to operate in the same
spirit as csum_fold()

It swaps the two 32-bit halves of sum then it adds it with the
unswapped sum. If there is a carry from adding the two 32-bit halves,
it will carry from the lower half into the upper half, giving us the
correct sum in the upper half.

The resulting code is:

0000000000000260 <.from64to32>:
 260:	78 60 00 02 	rotldi  r0,r3,32
 264:	7c 60 1a 14 	add     r3,r0,r3
 268:	78 63 00 22 	rldicl  r3,r3,32,32
 26c:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/checksum.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 4e63787dc3be..54065caa40b3 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -12,6 +12,7 @@
 #ifdef CONFIG_GENERIC_CSUM
 #include <asm-generic/checksum.h>
 #else
+#include <linux/bitops.h>
 /*
  * Computes the checksum of a memory block at src, length len,
  * and adds in "sum" (32-bit), while copying the block to dst.
@@ -55,11 +56,7 @@ static inline __sum16 csum_fold(__wsum sum)
 
 static inline u32 from64to32(u64 x)
 {
-	/* add up 32-bit and 32-bit for 32+c bit */
-	x = (x & 0xffffffff) + (x >> 32);
-	/* add up carry.. */
-	x = (x & 0xffffffff) + (x >> 32);
-	return (u32)x;
+	return (x + ror64(x, 32)) >> 32;
 }
 
 static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
-- 
2.13.3
