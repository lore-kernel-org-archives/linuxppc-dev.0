Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E110DB712E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:25 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9171i4K015865
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:01:44 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176PCL745608
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176Ore027780
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:25 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 07/18] powerpc: Use generic bitops for little endian bitmap
	operations
Date: Fri,  1 Oct 2010 17:06:00 +1000
Message-Id: <1285916771-18033-8-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: paulus@samba.org, Ian Munsie <imunsie@au1.ibm.com>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

With the little endian PowerPC Linux port, the CPU could be in either
mode. Rather than byte swapping and mapping the little endian bitmap
operations ourselves on the assumption that we are big endian, map them
to the generic macros that will automatically byte swap the bit number
only if we actually are big endian.

The generic bitops le.h already defines the macros/prototypes for the
generic_find_next_[zero_]le_bit appropriately for the current endian so
we can drop those prototypes altogether.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/bitops.h |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 30964ae..066b2df 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -54,7 +54,6 @@
 
 #define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
 /* Macro for generating the ***_bits() functions */
 #define DEFINE_BITOP(fn, op, prefix, postfix)	\
@@ -272,34 +271,29 @@ static __inline__ int fls64(__u64 x)
 
 /* Little-endian versions */
 
-static __inline__ int test_le_bit(unsigned long nr,
-				  __const__ unsigned long *addr)
-{
-	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
-	return (tmp[nr >> 3] >> (nr & 7)) & 1;
-}
+#include <asm-generic/bitops/le.h>
+
+#define test_le_bit(nr, addr) \
+	generic_test_le_bit(nr, addr)
 
 #define __set_le_bit(nr, addr) \
-	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+	generic__set_le_bit(nr, addr)
 #define __clear_le_bit(nr, addr) \
-	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+	generic__clear_le_bit(nr, addr)
 
 #define test_and_set_le_bit(nr, addr) \
-	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+	generic_test_and_set_le_bit(nr, addr)
 #define test_and_clear_le_bit(nr, addr) \
-	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+	generic_test_and_clear_le_bit(nr, addr)
 
 #define __test_and_set_le_bit(nr, addr) \
-	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+	generic__test_and_set_le_bit(nr, addr)
 #define __test_and_clear_le_bit(nr, addr) \
-	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+	generic__test_and_clear_le_bit(nr, addr)
 
-#define find_first_zero_le_bit(addr, size) generic_find_next_zero_le_bit((addr), (size), 0)
-unsigned long generic_find_next_zero_le_bit(const unsigned long *addr,
-				    unsigned long size, unsigned long offset);
+#define find_first_zero_le_bit(addr, size) \
+	generic_find_first_zero_le_bit(addr, size)
 
-unsigned long generic_find_next_le_bit(const unsigned long *addr,
-				    unsigned long size, unsigned long offset);
 /* Bitmap functions for the ext2 filesystem */
 
 #define ext2_set_bit(nr,addr) \
-- 
1.7.1
