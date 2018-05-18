Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nWzW0BZjzF2Bj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 01:19:02 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Implement csum_ipv6_magic in assembly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Message-Id: <20180518151858.341486F940@po14934vm.idsi0.si.c-s.fr>
Date: Fri, 18 May 2018 17:18:58 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic csum_ipv6_magic() generates a pretty bad result

00000000 <csum_ipv6_magic>:
   0:	81 23 00 00 	lwz     r9,0(r3)
   4:	81 03 00 04 	lwz     r8,4(r3)
   8:	7c e7 4a 14 	add     r7,r7,r9
   c:	7d 29 38 10 	subfc   r9,r9,r7
  10:	7d 4a 51 10 	subfe   r10,r10,r10
  14:	7d 27 42 14 	add     r9,r7,r8
  18:	7d 2a 48 50 	subf    r9,r10,r9
  1c:	80 e3 00 08 	lwz     r7,8(r3)
  20:	7d 08 48 10 	subfc   r8,r8,r9
  24:	7d 4a 51 10 	subfe   r10,r10,r10
  28:	7d 29 3a 14 	add     r9,r9,r7
  2c:	81 03 00 0c 	lwz     r8,12(r3)
  30:	7d 2a 48 50 	subf    r9,r10,r9
  34:	7c e7 48 10 	subfc   r7,r7,r9
  38:	7d 4a 51 10 	subfe   r10,r10,r10
  3c:	7d 29 42 14 	add     r9,r9,r8
  40:	7d 2a 48 50 	subf    r9,r10,r9
  44:	80 e4 00 00 	lwz     r7,0(r4)
  48:	7d 08 48 10 	subfc   r8,r8,r9
  4c:	7d 4a 51 10 	subfe   r10,r10,r10
  50:	7d 29 3a 14 	add     r9,r9,r7
  54:	7d 2a 48 50 	subf    r9,r10,r9
  58:	81 04 00 04 	lwz     r8,4(r4)
  5c:	7c e7 48 10 	subfc   r7,r7,r9
  60:	7d 4a 51 10 	subfe   r10,r10,r10
  64:	7d 29 42 14 	add     r9,r9,r8
  68:	7d 2a 48 50 	subf    r9,r10,r9
  6c:	80 e4 00 08 	lwz     r7,8(r4)
  70:	7d 08 48 10 	subfc   r8,r8,r9
  74:	7d 4a 51 10 	subfe   r10,r10,r10
  78:	7d 29 3a 14 	add     r9,r9,r7
  7c:	7d 2a 48 50 	subf    r9,r10,r9
  80:	81 04 00 0c 	lwz     r8,12(r4)
  84:	7c e7 48 10 	subfc   r7,r7,r9
  88:	7d 4a 51 10 	subfe   r10,r10,r10
  8c:	7d 29 42 14 	add     r9,r9,r8
  90:	7d 2a 48 50 	subf    r9,r10,r9
  94:	7d 08 48 10 	subfc   r8,r8,r9
  98:	7d 4a 51 10 	subfe   r10,r10,r10
  9c:	7d 29 2a 14 	add     r9,r9,r5
  a0:	7d 2a 48 50 	subf    r9,r10,r9
  a4:	7c a5 48 10 	subfc   r5,r5,r9
  a8:	7c 63 19 10 	subfe   r3,r3,r3
  ac:	7d 29 32 14 	add     r9,r9,r6
  b0:	7d 23 48 50 	subf    r9,r3,r9
  b4:	7c c6 48 10 	subfc   r6,r6,r9
  b8:	7c 63 19 10 	subfe   r3,r3,r3
  bc:	7c 63 48 50 	subf    r3,r3,r9
  c0:	54 6a 80 3e 	rotlwi  r10,r3,16
  c4:	7c 63 52 14 	add     r3,r3,r10
  c8:	7c 63 18 f8 	not     r3,r3
  cc:	54 63 84 3e 	rlwinm  r3,r3,16,16,31
  d0:	4e 80 00 20 	blr

This patch implements it in assembly for PPC32

Link: https://github.com/linuxppc/linux/issues/9
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/checksum.h |  8 ++++++++
 arch/powerpc/lib/checksum_32.S      | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 54065caa40b3..c41c280c252f 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -13,6 +13,7 @@
 #include <asm-generic/checksum.h>
 #else
 #include <linux/bitops.h>
+#include <linux/in6.h>
 /*
  * Computes the checksum of a memory block at src, length len,
  * and adds in "sum" (32-bit), while copying the block to dst.
@@ -211,6 +212,13 @@ static inline __sum16 ip_compute_csum(const void *buff, int len)
 	return csum_fold(csum_partial(buff, len, 0));
 }
 
+#ifdef CONFIG_PPC32
+#define _HAVE_ARCH_IPV6_CSUM
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum);
+#endif
+
 #endif
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 9a671c774b22..f9c047145696 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -293,3 +293,36 @@ dst_error:
 	EX_TABLE(51b, dst_error);
 
 EXPORT_SYMBOL(csum_partial_copy_generic)
+
+/*
+ * static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+ *				      const struct in6_addr *daddr,
+ *				      __u32 len, __u8 proto, __wsum sum)
+ */
+
+_GLOBAL(csum_ipv6_magic)
+	lwz	r8, 0(r3)
+	lwz	r9, 4(r3)
+	lwz	r10, 8(r3)
+	lwz	r11, 12(r3)
+	addc	r0, r5, r6
+	adde	r0, r0, r7
+	adde	r0, r0, r8
+	adde	r0, r0, r9
+	adde	r0, r0, r10
+	adde	r0, r0, r11
+	lwz	r8, 0(r4)
+	lwz	r9, 4(r4)
+	lwz	r10, 8(r4)
+	lwz	r11, 12(r4)
+	adde	r0, r0, r8
+	adde	r0, r0, r9
+	adde	r0, r0, r10
+	adde	r0, r0, r11
+	addze	r0
+	rotlwi	r3, r0, 16
+	add	r3, r0, r3
+	not	r3, r3
+	rlwinm	r3, r3, 16, 16, 31
+	blr
+EXPORT_SYMBOL(csum_ipv6_magic)
-- 
2.13.3
