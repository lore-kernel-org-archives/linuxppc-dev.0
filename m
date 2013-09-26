Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp11.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C91A22C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 16:30:24 +1000 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 26 Sep 2013 07:30:19 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: word-at-a-time optimization for 64bit LE
Date: Thu, 26 Sep 2013 08:30:09 +0200
Message-Id: <1380177009-9640-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an optimization for the PowerPC in 64-bit
little-endian. Bit counting is used in find_zero(), instead
of the multiply and shift.

It is modelled after Alan Modra's PowerPC LE strlen patch
http://sourceware.org/ml/libc-alpha/2013-08/msg00097.html.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/word-at-a-time.h |   57 ++++++++++++++++-------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 213a5f2..9a5c928 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -42,13 +42,6 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
 
 #else
 
-/*
- * This is largely generic for little-endian machines, but the
- * optimal byte mask counting is probably going to be something
- * that is architecture-specific. If you have a reliably fast
- * bit count instruction, that might be better than the multiply
- * and shift, for example.
- */
 struct word_at_a_time {
 	const unsigned long one_bits, high_bits;
 };
@@ -57,19 +50,32 @@ struct word_at_a_time {
 
 #ifdef CONFIG_64BIT
 
-/*
- * Jan Achrenius on G+: microoptimized version of
- * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
- * that works for the bytemasks without having to
- * mask them first.
- */
-static inline long count_masked_bytes(unsigned long mask)
+/* Alan Modra's little-endian strlen tail for 64-bit */
+#define create_zero_mask(mask) (mask)
+
+static inline unsigned long find_zero(unsigned long mask)
 {
-	return mask*0x0001020304050608ul >> 56;
+	unsigned long leading_zero_bits;
+	long trailing_zero_bit_mask;
+
+	asm ("addi %1,%2,-1\n\t"
+	     "andc %1,%1,%2\n\t"
+	     "popcntd %0,%1"
+	     : "=r" (leading_zero_bits), "=&r" (trailing_zero_bit_mask)
+	     : "r" (mask));
+	return leading_zero_bits >> 3;
 }
 
 #else	/* 32-bit case */
 
+/*
+ * This is largely generic for little-endian machines, but the
+ * optimal byte mask counting is probably going to be something
+ * that is architecture-specific. If you have a reliably fast
+ * bit count instruction, that might be better than the multiply
+ * and shift, for example.
+ */
+
 /* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
 static inline long count_masked_bytes(long mask)
 {
@@ -79,6 +85,17 @@ static inline long count_masked_bytes(long mask)
 	return a & mask;
 }
 
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return count_masked_bytes(mask);
+}
+
 #endif
 
 /* Return nonzero if it has a zero */
@@ -94,19 +111,9 @@ static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits,
 	return bits;
 }
 
-static inline unsigned long create_zero_mask(unsigned long bits)
-{
-	bits = (bits - 1) & ~bits;
-	return bits >> 7;
-}
-
 /* The mask we created is directly usable as a bytemask */
 #define zero_bytemask(mask) (mask)
 
-static inline unsigned long find_zero(unsigned long mask)
-{
-	return count_masked_bytes(mask);
-}
 #endif
 
 #endif /* _ASM_WORD_AT_A_TIME_H */
-- 
1.7.10.4
