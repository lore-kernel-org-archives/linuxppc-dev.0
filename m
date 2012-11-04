Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7560A2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Nov 2012 23:04:15 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id rp16so3049199pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2012 04:04:15 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: use asm-generic/bitops/le.h
Date: Sun,  4 Nov 2012 21:03:45 +0900
Message-Id: <1352030625-3471-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1352030625-3471-1-git-send-email-akinobu.mita@gmail.com>
References: <1352030625-3471-1-git-send-email-akinobu.mita@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only difference between powerpc and asm-generic le-bitops is
test_bit_le().  Usually all bitops require a long aligned bitmap.
But powerpc test_bit_le() can take an unaligned address.

There is no special callsite of test_bit_le() that needs unaligned
access in powerpc as far as I can see.  So convert to use
asm-generic/bitops/le.h for powerpc.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/bitops.h | 55 +--------------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 920596f..ef918a2 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -278,61 +278,8 @@ unsigned long __arch_hweight64(__u64 w);
 #include <asm-generic/bitops/find.h>
 
 /* Little-endian versions */
+#include <asm-generic/bitops/le.h>
 
-static __inline__ int test_bit_le(unsigned long nr,
-				  __const__ void *addr)
-{
-	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
-	return (tmp[nr >> 3] >> (nr & 7)) & 1;
-}
-
-static inline void set_bit_le(int nr, void *addr)
-{
-	set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-static inline void clear_bit_le(int nr, void *addr)
-{
-	clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-static inline void __set_bit_le(int nr, void *addr)
-{
-	__set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-static inline void __clear_bit_le(int nr, void *addr)
-{
-	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-static inline int test_and_set_bit_le(int nr, void *addr)
-{
-	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-static inline int test_and_clear_bit_le(int nr, void *addr)
-{
-	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-static inline int __test_and_set_bit_le(int nr, void *addr)
-{
-	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-static inline int __test_and_clear_bit_le(int nr, void *addr)
-{
-	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
-}
-
-#define find_first_zero_bit_le(addr, size) \
-	find_next_zero_bit_le((addr), (size), 0)
-unsigned long find_next_zero_bit_le(const void *addr,
-				    unsigned long size, unsigned long offset);
-
-unsigned long find_next_bit_le(const void *addr,
-				    unsigned long size, unsigned long offset);
 /* Bitmap functions for the ext2 filesystem */
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
-- 
1.7.11.7
