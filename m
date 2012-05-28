Return-Path: <paulus@ozlabs.org>
Date: Mon, 28 May 2012 13:03:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] powerpc: Use the new generic strncpy_from_user() and
 strnlen_user()
Message-ID: <20120528030347.GB6822@bloggs.ozlabs.ibm.com>
References: <20120528025956.GA6822@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120528025956.GA6822@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is much the same as for SPARC except that we can do the find_zero()
function more efficiently using the count-leading-zeroes instructions.
Tested on 32-bit and 64-bit PowerPC.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
I'm sending this in without Ben H's ack as he is away for a few weeks for
medical reasons.

 arch/powerpc/Kconfig                      |    2 ++
 arch/powerpc/include/asm/uaccess.h        |   41 ++++----------------------
 arch/powerpc/include/asm/word-at-a-time.h |   41 ++++++++++++++++++++++++++
 arch/powerpc/kernel/ppc_ksyms.c           |    2 --
 arch/powerpc/lib/string.S                 |   45 -----------------------------
 5 files changed, 48 insertions(+), 83 deletions(-)
 create mode 100644 arch/powerpc/include/asm/word-at-a-time.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 00b9874..050cb37 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -135,6 +135,8 @@ config PPC
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index bd0fb84..17bb40c 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -40,6 +40,8 @@
 
 #define segment_eq(a, b)	((a).seg == (b).seg)
 
+#define user_addr_max()	(get_fs().seg)
+
 #ifdef __powerpc64__
 /*
  * This check is sufficient because there is a large enough
@@ -453,42 +455,9 @@ static inline unsigned long clear_user(void __user *addr, unsigned long size)
 	return size;
 }
 
-extern int __strncpy_from_user(char *dst, const char __user *src, long count);
-
-static inline long strncpy_from_user(char *dst, const char __user *src,
-		long count)
-{
-	might_sleep();
-	if (likely(access_ok(VERIFY_READ, src, 1)))
-		return __strncpy_from_user(dst, src, count);
-	return -EFAULT;
-}
-
-/*
- * Return the size of a string (including the ending 0)
- *
- * Return 0 for error
- */
-extern int __strnlen_user(const char __user *str, long len, unsigned long top);
-
-/*
- * Returns the length of the string at str (including the null byte),
- * or 0 if we hit a page we can't access,
- * or something > len if we didn't find a null byte.
- *
- * The `top' parameter to __strnlen_user is to make sure that
- * we can never overflow from the user area into kernel space.
- */
-static inline int strnlen_user(const char __user *str, long len)
-{
-	unsigned long top = current->thread.fs.seg;
-
-	if ((unsigned long)str > top)
-		return 0;
-	return __strnlen_user(str, len, top);
-}
-
-#define strlen_user(str)	strnlen_user((str), 0x7ffffffe)
+extern long strncpy_from_user(char *dst, const char __user *src, long count);
+extern __must_check long strlen_user(const char __user *str);
+extern __must_check long strnlen_user(const char __user *str, long n);
 
 #endif  /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
new file mode 100644
index 0000000..d0b6d4a
--- /dev/null
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_WORD_AT_A_TIME_H
+#define _ASM_WORD_AT_A_TIME_H
+
+/*
+ * Word-at-a-time interfaces for PowerPC.
+ */
+
+#include <linux/kernel.h>
+#include <asm/asm-compat.h>
+
+struct word_at_a_time {
+	const unsigned long high_bits, low_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0xfe) + 1, REPEAT_BYTE(0x7f) }
+
+/* Bit set in the bytes that have a zero */
+static inline long prep_zero_mask(unsigned long val, unsigned long rhs, const struct word_at_a_time *c)
+{
+	unsigned long mask = (val & c->low_bits) + c->low_bits;
+	return ~(mask | rhs);
+}
+
+#define create_zero_mask(mask) (mask)
+
+static inline long find_zero(unsigned long mask)
+{
+	long leading_zero_bits;
+
+	asm (PPC_CNTLZL "%0,%1" : "=r" (leading_zero_bits) : "r" (mask));
+	return leading_zero_bits >> 3;
+}
+
+static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
+{
+	unsigned long rhs = val | c->low_bits;
+	*data = rhs;
+	return (val + c->high_bits) & ~rhs;
+}
+
+#endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index d1f2aaf..3e40315 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -85,8 +85,6 @@ EXPORT_SYMBOL(csum_tcpudp_magic);
 
 EXPORT_SYMBOL(__copy_tofrom_user);
 EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(copy_page);
 
 #if defined(CONFIG_PCI) && defined(CONFIG_PPC32)
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 455881a..093d631 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -160,48 +160,3 @@ _GLOBAL(__clear_user)
 	PPC_LONG	1b,91b
 	PPC_LONG	8b,92b
 	.text
-
-_GLOBAL(__strncpy_from_user)
-	addi	r6,r3,-1
-	addi	r4,r4,-1
-	cmpwi	0,r5,0
-	beq	2f
-	mtctr	r5
-1:	lbzu	r0,1(r4)
-	cmpwi	0,r0,0
-	stbu	r0,1(r6)
-	bdnzf	2,1b		/* dec ctr, branch if ctr != 0 && !cr0.eq */
-	beq	3f
-2:	addi	r6,r6,1
-3:	subf	r3,r3,r6
-	blr
-99:	li	r3,-EFAULT
-	blr
-
-	.section __ex_table,"a"
-	PPC_LONG	1b,99b
-	.text
-
-/* r3 = str, r4 = len (> 0), r5 = top (highest addr) */
-_GLOBAL(__strnlen_user)
-	addi	r7,r3,-1
-	subf	r6,r7,r5	/* top+1 - str */
-	cmplw	0,r4,r6
-	bge	0f
-	mr	r6,r4
-0:	mtctr	r6		/* ctr = min(len, top - str) */
-1:	lbzu	r0,1(r7)	/* get next byte */
-	cmpwi	0,r0,0
-	bdnzf	2,1b		/* loop if --ctr != 0 && byte != 0 */
-	addi	r7,r7,1
-	subf	r3,r3,r7	/* number of bytes we have looked at */
-	beqlr			/* return if we found a 0 byte */
-	cmpw	0,r3,r4		/* did we look at all len bytes? */
-	blt	99f		/* if not, must have hit top */
-	addi	r3,r4,1		/* return len + 1 to indicate no null found */
-	blr
-99:	li	r3,0		/* bad address, return 0 */
-	blr
-
-	.section __ex_table,"a"
-	PPC_LONG	1b,99b
-- 
1.7.10.rc3.219.g53414
