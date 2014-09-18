Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 095461A09AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 09:40:27 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com, torvalds@linux-foundation.org
Subject: [PATCH 2/3] powerpc: ppc64le optimised word at a time
Date: Fri, 19 Sep 2014 09:40:20 +1000
Message-Id: <1411083621-12064-3-git-send-email-anton@samba.org>
In-Reply-To: <1411083621-12064-1-git-send-email-anton@samba.org>
References: <1411083621-12064-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use cmpb which compares each byte in two 64 bit values and
for each matching byte places 0xff in the target and 0x00
otherwise.

A simple hash_name microbenchmark:

http://ozlabs.org/~anton/junkcode/hash_name_bench.c

shows this version to be 10-20% faster than running the x86
version on POWER8, depending on the length.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/word-at-a-time.h | 61 ++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 07cc121..7cff3de 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -42,32 +42,65 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
 
 #else
 
+#ifdef CONFIG_64BIT
+
+/* unused */
 struct word_at_a_time {
-	const unsigned long one_bits, high_bits;
 };
 
-#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+#define WORD_AT_A_TIME_CONSTANTS { }
 
-#ifdef CONFIG_64BIT
+/* This will give us 0xff for a NULL char and 0x00 elsewhere */
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits, const struct word_at_a_time *c)
+{
+	unsigned long ret;
+	unsigned long zero = 0;
 
-/* Alan Modra's little-endian strlen tail for 64-bit */
-#define create_zero_mask(mask) (mask)
+	asm("cmpb %0,%1,%2" : "=r" (ret) : "r" (a), "r" (zero));
+	*bits = ret;
 
-static inline unsigned long find_zero(unsigned long mask)
+	return ret;
+}
+
+static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits, const struct word_at_a_time *c)
+{
+	return bits;
+}
+
+/* Alan Modra's little-endian strlen tail for 64-bit */
+static inline unsigned long create_zero_mask(unsigned long bits)
 {
 	unsigned long leading_zero_bits;
 	long trailing_zero_bit_mask;
 
-	asm ("addi %1,%2,-1\n\t"
-	     "andc %1,%1,%2\n\t"
-	     "popcntd %0,%1"
-	     : "=r" (leading_zero_bits), "=&r" (trailing_zero_bit_mask)
-	     : "r" (mask));
-	return leading_zero_bits >> 3;
+	asm("addi	%1,%2,-1\n\t"
+	    "andc	%1,%1,%2\n\t"
+	    "popcntd	%0,%1"
+		: "=r" (leading_zero_bits), "=&r" (trailing_zero_bit_mask)
+		: "r" (bits));
+
+	return leading_zero_bits;
+}
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return mask >> 3;
+}
+
+/* This assumes that we never ask for an all 1s bitmask */
+static inline unsigned long zero_bytemask(unsigned long mask)
+{
+	return (1UL << mask) - 1;
 }
 
 #else	/* 32-bit case */
 
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
 /*
  * This is largely generic for little-endian machines, but the
  * optimal byte mask counting is probably going to be something
@@ -96,8 +129,6 @@ static inline unsigned long find_zero(unsigned long mask)
 	return count_masked_bytes(mask);
 }
 
-#endif
-
 /* Return nonzero if it has a zero */
 static inline unsigned long has_zero(unsigned long a, unsigned long *bits, const struct word_at_a_time *c)
 {
@@ -116,6 +147,8 @@ static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits,
 
 #endif
 
+#endif
+
 static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset, tmp;
-- 
1.9.1
