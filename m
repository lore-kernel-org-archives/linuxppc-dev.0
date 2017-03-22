Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpKXg3sYrzDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 06:30:43 +1100 (AEDT)
Date: Wed, 22 Mar 2017 12:30:30 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: Optimised memset64/memset32 for powerpc
Message-ID: <20170322193030.GA8008@bombadil.infradead.org>
References: <20170320211447.GB5073@bombadil.infradead.org>
 <18c572e8-a269-c76e-b3a1-e745ac20e5a7@c-s.fr>
 <20170321132910.GA4482@bombadil.infradead.org>
 <1490131572.2504.56.camel@kernel.crashing.org>
 <20170322131805.GA14657@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170322131805.GA14657@bombadil.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 22, 2017 at 06:18:05AM -0700, Matthew Wilcox wrote:
> There's one other potential user I've been wondering about, which are the
> various console drivers.  They use 'memsetw' to blank the entire console
> or lines of the console when scrolling, but the only architecture which
> ever bothered implementing an optimised version of it was Alpha.
> 
> Might be worth it on powerpc actually ... better than a loop calling
> cpu_to_le16() on each iteration.  That'd complete the set with a
> memset16().

All hail plane rides ... This would need to be resplit and merged properly,
but I think it makes life a little saner.

I make no claims that the ARM assembly in here is correct.  The single
x86 instruction that I wrote^W coped and pasted appears to be correct by
my understanding of the instruction set.


diff --git a/arch/alpha/include/asm/string.h b/arch/alpha/include/asm/string.h
index c2911f591704..74c0a693b76b 100644
--- a/arch/alpha/include/asm/string.h
+++ b/arch/alpha/include/asm/string.h
@@ -65,13 +65,14 @@ extern void * memchr(const void *, int, size_t);
    aligned values.  The DEST and COUNT parameters must be even for 
    correct operation.  */
 
-#define __HAVE_ARCH_MEMSETW
-extern void * __memsetw(void *dest, unsigned short, size_t count);
-
-#define memsetw(s, c, n)						 \
-(__builtin_constant_p(c)						 \
- ? __constant_c_memset((s),0x0001000100010001UL*(unsigned short)(c),(n)) \
- : __memsetw((s),(c),(n)))
+#define __HAVE_ARCH_MEMSET16
+extern void * __memset16(void *dest, unsigned short, size_t count);
+static inline void *memset16(uint16_t *p, uint16_t v, size_t n)
+{
+	if (__builtin_constant_p(v))
+		return __constant_c_memset(p, 0x0001000100010001UL * v, n * 2)
+	return __memset16(p, v, n * 2);
+}
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/alpha/include/asm/vga.h b/arch/alpha/include/asm/vga.h
index c00106bac521..3c1c2b6128e7 100644
--- a/arch/alpha/include/asm/vga.h
+++ b/arch/alpha/include/asm/vga.h
@@ -34,7 +34,7 @@ static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 	if (__is_ioaddr(s))
 		memsetw_io((u16 __iomem *) s, c, count);
 	else
-		memsetw(s, c, count);
+		memset16(s, c, count / 2);
 }
 
 /* Do not trust that the usage will be correct; analyze the arguments.  */
diff --git a/arch/alpha/lib/memset.S b/arch/alpha/lib/memset.S
index 89a26f5e89de..f824969e9e77 100644
--- a/arch/alpha/lib/memset.S
+++ b/arch/alpha/lib/memset.S
@@ -20,7 +20,7 @@
 	.globl memset
 	.globl __memset
 	.globl ___memset
-	.globl __memsetw
+	.globl __memset16
 	.globl __constant_c_memset
 
 	.ent ___memset
@@ -110,8 +110,8 @@ EXPORT_SYMBOL(___memset)
 EXPORT_SYMBOL(__constant_c_memset)
 
 	.align 5
-	.ent __memsetw
-__memsetw:
+	.ent __memset16
+__memset16:
 	.prologue 0
 
 	inswl $17,0,$1		/* E0 */
@@ -123,8 +123,8 @@ __memsetw:
 	or $1,$4,$17		/* E0 */
 	br __constant_c_memset	/* .. E1 */
 
-	.end __memsetw
-EXPORT_SYMBOL(__memsetw)
+	.end __memset16
+EXPORT_SYMBOL(__memset16)
 
 memset = ___memset
 __memset = ___memset
diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index da88299f758b..bc7a1be7a76a 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -24,15 +24,22 @@ extern void * memchr(const void *, int, __kernel_size_t);
 #define __HAVE_ARCH_MEMSET
 extern void * memset(void *, int, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMSET_PLUS
-extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
-extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
+#define __HAVE_ARCH_MEMSET16
+extern void *__memset16(uint16_t *, uint16_t v, __kernel_size_t);
+static inline void *memset16(uint16_t *p, uint16_t v, __kernel_size_t n)
+{
+	return __memset16(p, v, n * 2);
+}
 
+#define __HAVE_ARCH_MEMSET32
+extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
 static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
 {
 	return __memset32(p, v, n * 4);
 }
 
+#define __HAVE_ARCH_MEMSET64
+extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
 static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 {
 	return __memset64(p, v, n * 8, v >> 32);
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index a835ff9ed30c..0b6cbaa25b33 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -21,12 +21,12 @@ ENTRY(memset)
 UNWIND( .fnstart         )
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
+	orr	r1, r1, r1, lsl #8
 	bne	6f			@ 1
 /*
  * we know that the pointer in ip is aligned to a word boundary.
  */
-1:	orr	r1, r1, r1, lsl #8
-	orr	r1, r1, r1, lsl #16
+1:	orr	r1, r1, r1, lsl #16
 	mov	r3, r1
 7:	cmp	r2, #16
 	blt	4f
@@ -114,12 +114,13 @@ UNWIND( .fnstart            )
 	tst	r2, #4
 	strne	r1, [ip], #4
 /*
- * When we get here, we've got less than 4 bytes to zero.  We
+ * When we get here, we've got less than 4 bytes to set.  We
  * may have an unaligned pointer as well.
  */
 5:	tst	r2, #2
+	movne	r3, r1, lsr #8		@ the top half of a 16-bit pattern
 	strneb	r1, [ip], #1
-	strneb	r1, [ip], #1
+	strneb	r3, [ip], #1
 	tst	r2, #1
 	strneb	r1, [ip], #1
 	ret	lr
@@ -136,6 +137,17 @@ UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
 
+ENTRY(__memset16)
+UNWIND( .fnstart         )
+	tst	r0, #2			@ pointer unaligned?
+	mov	ip, r0			@ preserve r0 as return value
+	movne	r3, r1, lsr #8		@ r3 = r1 >> 8
+	strneb	r1, [ip], #1
+	strneb	r3, [ip], #1
+	subne	r2, r2, #2
+	b	1b			@ jump into the middle of memset
+UNWIND( .fnend   )
+ENDPROC(__memset16)
 ENTRY(__memset32)
 UNWIND( .fnstart         )
 	mov	r3, r1			@ copy r1 to r3 and fall into memset64
diff --git a/arch/powerpc/include/asm/vga.h b/arch/powerpc/include/asm/vga.h
index ab3acd2f2786..1fcda81d0fac 100644
--- a/arch/powerpc/include/asm/vga.h
+++ b/arch/powerpc/include/asm/vga.h
@@ -33,6 +33,12 @@ static inline u16 scr_readw(volatile const u16 *addr)
 	return le16_to_cpu(*addr);
 }
 
+#define VT_BUF_HAVE_MEMSET
+static inline void scr_memsetw(u16 *s, u16 v, unsigned int n)
+{
+	memset16(s, cpu_to_le16(v), n / 2);
+}
+
 #define VT_BUF_HAVE_MEMCPYW
 #define scr_memcpyw	memcpy
 
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 55614ccabb5c..84da91fe13ac 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -331,7 +331,19 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 	 : __memset((s), (c), (count)))
 #endif
 
-#define __HAVE_ARCH_MEMSET_PLUS
+#define __HAVE_ARCH_MEMSET16
+static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
+{
+	int d0, d1;
+	asm volatile("rep\n\t"
+		     "stosw"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET_32
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
 	int d0, d1;
@@ -343,8 +355,6 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 	return s;
 }
 
-extern void *memset64(uint64_t *s, uint64_t v, size_t n);
-
 /*
  * find the first occurrence of byte 'c', or 1 past the area if none
  */
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 43210320ea05..71c5e860c7da 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -56,10 +56,22 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
 
-#define __HAVE_ARCH_MEMSET_PLUS
+#define __HAVE_ARCH_MEMSET16
+static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
+{
+	long d0, d1;
+	asm volatile("rep\n\t"
+		     "stosw"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET32
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
-	int d0, d1;
+	long d0, d1;
 	asm volatile("rep\n\t"
 		     "stosl"
 		     : "=&c" (d0), "=&D" (d1)
@@ -68,9 +80,10 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 	return s;
 }
 
+#define __HAVE_ARCH_MEMSET64
 static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 {
-	int d0, d1;
+	long d0, d1;
 	asm volatile("rep\n\t"
 		     "stosq"
 		     : "=&c" (d0), "=&D" (d1)
diff --git a/include/linux/string.h b/include/linux/string.h
index 087d4d7bafd4..148b88b6ea00 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -99,8 +99,16 @@ extern __kernel_size_t strcspn(const char *,const char *);
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
 #endif
-#ifndef __HAVE_ARCH_MEMSET_PLUS
+
+#ifndef __HAVE_ARCH_MEMSET16
+extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET32
 extern void *memset32(uint32_t *, uint32_t, __kernel_size_t);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET64
 extern void *memset64(uint64_t *, uint64_t, __kernel_size_t);
 #endif
 
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index f38c10ba3ff5..fddb010be886 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -26,9 +26,13 @@
 #ifndef VT_BUF_HAVE_MEMSETW
 static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 {
+#ifdef VT_BUF_HAVE_RW
 	count /= 2;
 	while (count--)
 		scr_writew(c, s++);
+#else
+	memset16(s, c, count / 2);
+#endif
 }
 #endif
 
diff --git a/lib/string.c b/lib/string.c
index d22711e6490a..1e74a89e0af5 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -697,7 +697,29 @@ void memzero_explicit(void *s, size_t count)
 }
 EXPORT_SYMBOL(memzero_explicit);
 
-#ifndef __HAVE_ARCH_MEMSET_PLUS
+#ifndef __HAVE_ARCH_MEMSET16
+/**
+ * memset16() - Fill a memory area with a uint16_t
+ * @s: Pointer to the start of the area.
+ * @v: The value to fill the area with
+ * @count: The number of values to store
+ *
+ * Differs from memset() in that it fills with a uint16_t instead
+ * of a byte.  Remember that @count is the number of uint16_ts to
+ * store, not the number of bytes.
+ */
+void *memset16(uint16_t *s, uint16_t v, size_t count)
+{
+	uint16_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+EXPORT_SYMBOL(memset16);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET32
 /**
  * memset32() - Fill a memory area with a uint32_t
  * @s: Pointer to the start of the area.
@@ -717,7 +739,9 @@ void *memset32(uint32_t *s, uint32_t v, size_t count)
 	return s;
 }
 EXPORT_SYMBOL(memset32);
+#endif
 
+#ifndef __HAVE_ARCH_MEMSET64
 #if BITS_PER_LONG > 32
 /**
  * memset64() - Fill a memory area with a uint64_t
