Return-Path: <akinobu.mita@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64A75B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 00:08:33 +1100 (EST)
Received: by iwb12 with SMTP id 12so4387200iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 16 Jan 2011 05:08:29 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v4 03/24] powerpc: introduce little-endian bitops
Date: Sun, 16 Jan 2011 22:08:32 +0900
Message-Id: <1295183333-13802-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com>
References: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com>
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

Introduce little-endian bit operations by renaming existing powerpc
native little-endian bit operations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---

The whole series is available in the git repository at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v4

 arch/powerpc/include/asm/bitops.h |   38 ++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index e903264..7b1c5a9 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -281,29 +281,29 @@ unsigned long __arch_hweight64(__u64 w);
 
 /* Little-endian versions */
 
-static __inline__ int test_le_bit(unsigned long nr,
+static __inline__ int test_bit_le(unsigned long nr,
 				  __const__ unsigned long *addr)
 {
 	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
 	return (tmp[nr >> 3] >> (nr & 7)) & 1;
 }
 
-#define __set_le_bit(nr, addr) \
+#define __set_bit_le(nr, addr) \
 	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
-#define __clear_le_bit(nr, addr) \
+#define __clear_bit_le(nr, addr) \
 	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
 
-#define test_and_set_le_bit(nr, addr) \
+#define test_and_set_bit_le(nr, addr) \
 	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
-#define test_and_clear_le_bit(nr, addr) \
+#define test_and_clear_bit_le(nr, addr) \
 	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
 
-#define __test_and_set_le_bit(nr, addr) \
+#define __test_and_set_bit_le(nr, addr) \
 	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
-#define __test_and_clear_le_bit(nr, addr) \
+#define __test_and_clear_bit_le(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
 
-#define find_first_zero_le_bit(addr, size) \
+#define find_first_zero_bit_le(addr, size) \
 	find_next_zero_bit_le((addr), (size), 0)
 unsigned long find_next_zero_bit_le(const unsigned long *addr,
 				    unsigned long size, unsigned long offset);
@@ -313,19 +313,19 @@ unsigned long find_next_bit_le(const unsigned long *addr,
 /* Bitmap functions for the ext2 filesystem */
 
 #define ext2_set_bit(nr,addr) \
-	__test_and_set_le_bit((nr), (unsigned long*)addr)
+	__test_and_set_bit_le((nr), (unsigned long*)addr)
 #define ext2_clear_bit(nr, addr) \
-	__test_and_clear_le_bit((nr), (unsigned long*)addr)
+	__test_and_clear_bit_le((nr), (unsigned long*)addr)
 
 #define ext2_set_bit_atomic(lock, nr, addr) \
-	test_and_set_le_bit((nr), (unsigned long*)addr)
+	test_and_set_bit_le((nr), (unsigned long*)addr)
 #define ext2_clear_bit_atomic(lock, nr, addr) \
-	test_and_clear_le_bit((nr), (unsigned long*)addr)
+	test_and_clear_bit_le((nr), (unsigned long*)addr)
 
-#define ext2_test_bit(nr, addr)      test_le_bit((nr),(unsigned long*)addr)
+#define ext2_test_bit(nr, addr)      test_bit_le((nr),(unsigned long*)addr)
 
 #define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_le_bit((unsigned long*)addr, size)
+	find_first_zero_bit_le((unsigned long*)addr, size)
 #define ext2_find_next_zero_bit(addr, size, off) \
 	find_next_zero_bit_le((unsigned long *)addr, size, off)
 
@@ -334,16 +334,16 @@ unsigned long find_next_bit_le(const unsigned long *addr,
 /* Bitmap functions for the minix filesystem.  */
 
 #define minix_test_and_set_bit(nr,addr) \
-	__test_and_set_le_bit(nr, (unsigned long *)addr)
+	__test_and_set_bit_le(nr, (unsigned long *)addr)
 #define minix_set_bit(nr,addr) \
-	__set_le_bit(nr, (unsigned long *)addr)
+	__set_bit_le(nr, (unsigned long *)addr)
 #define minix_test_and_clear_bit(nr,addr) \
-	__test_and_clear_le_bit(nr, (unsigned long *)addr)
+	__test_and_clear_bit_le(nr, (unsigned long *)addr)
 #define minix_test_bit(nr,addr) \
-	test_le_bit(nr, (unsigned long *)addr)
+	test_bit_le(nr, (unsigned long *)addr)
 
 #define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_le_bit((unsigned long *)addr, size)
+	find_first_zero_bit_le((unsigned long *)addr, size)
 
 #include <asm-generic/bitops/sched.h>
 
-- 
1.7.3.4
