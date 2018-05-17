Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mp3X55bszF1mb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 20:50:00 +1000 (AEST)
Message-Id: <f42d0e828227103cc20349d111b2562c6a77dd49.1526553552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526553552.git.christophe.leroy@c-s.fr>
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 4/5] powerpc/lib: inline string functions NUL size
 verification
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 17 May 2018 12:49:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many calls to memcmp(), strncmp(), strncpy() and memchr()
are done with constant size.

This patch gives GCC a chance to optimise out
the NUL size verification.

This is only done when CONFIG_FORTIFY_SOURCE is not set, because
when CONFIG_FORTIFY_SOURCE is set, other inline versions of the
functions are defined in linux/string.h and conflict with ours.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/string.h      | 45 +++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 arch/powerpc/lib/memcmp_64.S           |  8 ++++++
 arch/powerpc/lib/string.S              | 14 +++++++++++
 arch/powerpc/lib/string_32.S           |  8 ++++++
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 9b8cedf618f4..35f1aaad9b50 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -15,17 +15,56 @@
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
 
 extern char * strcpy(char *,const char *);
-extern char * strncpy(char *,const char *, __kernel_size_t);
 extern __kernel_size_t strlen(const char *);
 extern int strcmp(const char *,const char *);
-extern int strncmp(const char *, const char *, __kernel_size_t);
 extern char * strcat(char *, const char *);
 extern void * memset(void *,int,__kernel_size_t);
 extern void * memcpy(void *,const void *,__kernel_size_t);
 extern void * memmove(void *,const void *,__kernel_size_t);
+extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
+
+#ifdef CONFIG_FORTIFY_SOURCE
+
+extern char * strncpy(char *,const char *, __kernel_size_t);
+extern int strncmp(const char *, const char *, __kernel_size_t);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
-extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
+
+#else
+
+extern char *__strncpy(char *,const char *, __kernel_size_t);
+extern int __strncmp(const char *, const char *, __kernel_size_t);
+extern int __memcmp(const void *,const void *,__kernel_size_t);
+extern void *__memchr(const void *,int,__kernel_size_t);
+
+static inline char *strncpy(char *p, const char *q, __kernel_size_t size)
+{
+	if (unlikely(!size))
+		return p;
+	return __strncpy(p, q, size);
+}
+
+static inline int strncmp(const char *p, const char *q, __kernel_size_t size)
+{
+	if (unlikely(!size))
+		return 0;
+	return __strncmp(p, q, size);
+}
+
+static inline int memcmp(const void *p,const void *q,__kernel_size_t size)
+{
+	if (unlikely(!size))
+		return 0;
+	return __memcmp(p, q, size);
+}
+
+static inline void *memchr(const void *p, int c, __kernel_size_t size)
+{
+	if (unlikely(!size))
+		return NULL;
+	return __memchr(p, c, size);
+}
+#endif
 
 #ifdef CONFIG_PPC64
 #define __HAVE_ARCH_MEMSET32
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index acb6b9226352..2d87e5f9d87b 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -18,7 +18,7 @@
 
 WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
-__secondary_hold_acknowledge __secondary_hold_spinloop __start
+__secondary_hold_acknowledge __secondary_hold_spinloop __start  __strncmp
 strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index d75d18b7bd55..9b28286b85cf 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -29,8 +29,14 @@
 #define LD	ldx
 #endif
 
+#ifndef CONFIG_FORTIFY_SOURCE
+#define memcmp __memcmp
+#endif
+
 _GLOBAL(memcmp)
+#ifdef CONFIG_FORTIFY_SOURCE
 	cmpdi	cr1,r5,0
+#endif
 
 	/* Use the short loop if both strings are not 8B aligned */
 	or	r6,r3,r4
@@ -39,7 +45,9 @@ _GLOBAL(memcmp)
 	/* Use the short loop if length is less than 32B */
 	cmpdi	cr6,r5,31
 
+#ifdef CONFIG_FORTIFY_SOURCE
 	beq	cr1,.Lzero
+#endif
 	bne	.Lshort
 	bgt	cr6,.Llong
 
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 0ef189847337..2521c159e644 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -14,12 +14,20 @@
 #include <asm/export.h>
 
 	.text
+
+#ifndef CONFIG_FORTIFY_SOURCE
+#define strncpy __strncpy
+#define strncmp __strncmp
+#define memchr __memchr
+#endif
 	
 /* This clears out any unused part of the destination buffer,
    just as the libc version does.  -- paulus */
 _GLOBAL(strncpy)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beqlr
+#endif
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
@@ -40,8 +48,10 @@ _GLOBAL(strncpy)
 EXPORT_SYMBOL(strncpy)
 
 _GLOBAL(strncmp)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beq-	2f
+#endif
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
@@ -55,13 +65,17 @@ _GLOBAL(strncmp)
 	beqlr	1
 	bdnzt	eq,1b
 	blr
+#ifdef CONFIG_FORTIFY_SOURCE
 2:	li	r3,0
 	blr
+#endif
 EXPORT_SYMBOL(strncmp)
 
 _GLOBAL(memchr)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beq-	2f
+#endif
 	mtctr	r5
 	addi	r3,r3,-1
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index 5c0e77baa9c7..15f6fa175ec1 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -17,9 +17,15 @@
 
 	.text
 
+#ifndef CONFIG_FORTIFY_SOURCE
+#define memcmp __memcmp
+#endif
+
 _GLOBAL(memcmp)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beq-	2f
+#endif
 	srawi.	r7, r5, 2		/* Divide len by 4 */
 	mr	r6, r3
 	beq-	3f
@@ -56,8 +62,10 @@ _GLOBAL(memcmp)
 	lbzx	r0, r4, r7
 	subf.	r3, r0, r3
 	blr
+#ifdef CONFIG_FORTIFY_SOURCE
 2:	li	r3,0
 	blr
+#endif
 EXPORT_SYMBOL(memcmp)
 
 CACHELINE_BYTES = L1_CACHE_BYTES
-- 
2.13.3
