Return-Path: <akinobu.mita@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 423DAB7127
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 00:56:00 +1100 (EST)
Received: by iwb12 with SMTP id 12so2191017iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 05:55:55 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH -mm 2/6] powerpc: convert little-endian bitops macros to
	static inline functions
Date: Thu, 27 Jan 2011 22:56:19 +0900
Message-Id: <1296136583-13815-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(This patch is intended to be folded into the patch in -mm:
powerpc-introduce-little-endian-bitops.patch)

The little-endian bitops on powerpc are written as preprocessor
macros with the cast to "unsigned long *".
This means that even non-pointers will be accepted without an error, and
that is a Very Bad Thing.

This converts the little-endian bitops macros to static inline functions
with proper prototypes.

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/bitops.h |   43 +++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index fe67024..2e56187 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -288,20 +288,35 @@ static __inline__ int test_bit_le(unsigned long nr,
 	return (tmp[nr >> 3] >> (nr & 7)) & 1;
 }
 
-#define __set_bit_le(nr, addr) \
-	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-#define __clear_bit_le(nr, addr) \
-	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-
-#define test_and_set_bit_le(nr, addr) \
-	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-#define test_and_clear_bit_le(nr, addr) \
-	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-
-#define __test_and_set_bit_le(nr, addr) \
-	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
-#define __test_and_clear_bit_le(nr, addr) \
-	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (unsigned long *)(addr))
+static inline void __set_bit_le(int nr, void *addr)
+{
+	__set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline void __clear_bit_le(int nr, void *addr)
+{
+	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int test_and_set_bit_le(int nr, void *addr)
+{
+	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int test_and_clear_bit_le(int nr, void *addr)
+{
+	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int __test_and_set_bit_le(int nr, void *addr)
+{
+	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
+
+static inline int __test_and_clear_bit_le(int nr, void *addr)
+{
+	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+}
 
 #define find_first_zero_bit_le(addr, size) \
 	find_next_zero_bit_le((addr), (size), 0)
-- 
1.7.3.4
