Return-Path: <akinobu.mita@gmail.com>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA7992C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Nov 2012 23:04:14 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id t11so2078222daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2012 04:04:12 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: remove BITOP_MASK and BITOP_WORD from asm/bitops.h
Date: Sun,  4 Nov 2012 21:03:44 +0900
Message-Id: <1352030625-3471-2-git-send-email-akinobu.mita@gmail.com>
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

Replace BITOP_MASK and BITOP_WORD with BIT_MASK and BIT_WORD defined
in linux/bitops.h and remove BITOP_* which are not used anymore.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/bitops.h | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index dc2cf9c..920596f 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -52,8 +52,6 @@
 #define smp_mb__before_clear_bit()	smp_mb()
 #define smp_mb__after_clear_bit()	smp_mb()
 
-#define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
 /* Macro for generating the ***_bits() functions */
@@ -83,22 +81,22 @@ DEFINE_BITOP(change_bits, xor, "", "")
 
 static __inline__ void set_bit(int nr, volatile unsigned long *addr)
 {
-	set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
 static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
 {
-	clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
 static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
-	clear_bits_unlock(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
 static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 {
-	change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
 /* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
@@ -136,26 +134,26 @@ DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
 static __inline__ int test_and_set_bit(unsigned long nr,
 				       volatile unsigned long *addr)
 {
-	return test_and_set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
 static __inline__ int test_and_set_bit_lock(unsigned long nr,
 				       volatile unsigned long *addr)
 {
-	return test_and_set_bits_lock(BITOP_MASK(nr),
-				addr + BITOP_WORD(nr)) != 0;
+	return test_and_set_bits_lock(BIT_MASK(nr),
+				addr + BIT_WORD(nr)) != 0;
 }
 
 static __inline__ int test_and_clear_bit(unsigned long nr,
 					 volatile unsigned long *addr)
 {
-	return test_and_clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
 static __inline__ int test_and_change_bit(unsigned long nr,
 					  volatile unsigned long *addr)
 {
-	return test_and_change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
 #include <asm-generic/bitops/non-atomic.h>
-- 
1.7.11.7
