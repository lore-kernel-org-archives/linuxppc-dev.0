Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 41/63] powerpc: Add little endian support for word-at-a-time
 functions
Date: Wed,  7 Aug 2013 02:01:58 +1000
Message-Id: <1375804940-22050-42-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc word-at-a-time functions are big endian specific.
Bring in the x86 version in order to support little endian builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/word-at-a-time.h | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index d0b6d4a..213a5f2 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -8,6 +8,8 @@
 #include <linux/kernel.h>
 #include <asm/asm-compat.h>
 
+#ifdef __BIG_ENDIAN__
+
 struct word_at_a_time {
 	const unsigned long high_bits, low_bits;
 };
@@ -38,4 +40,73 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
 	return (val + c->high_bits) & ~rhs;
 }
 
+#else
+
+/*
+ * This is largely generic for little-endian machines, but the
+ * optimal byte mask counting is probably going to be something
+ * that is architecture-specific. If you have a reliably fast
+ * bit count instruction, that might be better than the multiply
+ * and shift, for example.
+ */
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+#ifdef CONFIG_64BIT
+
+/*
+ * Jan Achrenius on G+: microoptimized version of
+ * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
+ * that works for the bytemasks without having to
+ * mask them first.
+ */
+static inline long count_masked_bytes(unsigned long mask)
+{
+	return mask*0x0001020304050608ul >> 56;
+}
+
+#else	/* 32-bit case */
+
+/* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
+static inline long count_masked_bytes(long mask)
+{
+	/* (000000 0000ff 00ffff ffffff) -> ( 1 1 2 3 ) */
+	long a = (0x0ff0001+mask) >> 23;
+	/* Fix the 1 for 00 case */
+	return a & mask;
+}
+
+#endif
+
+/* Return nonzero if it has a zero */
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits, const struct word_at_a_time *c)
+{
+	unsigned long mask = ((a - c->one_bits) & ~a) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits, const struct word_at_a_time *c)
+{
+	return bits;
+}
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+/* The mask we created is directly usable as a bytemask */
+#define zero_bytemask(mask) (mask)
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return count_masked_bytes(mask);
+}
+#endif
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
-- 
1.8.1.2
