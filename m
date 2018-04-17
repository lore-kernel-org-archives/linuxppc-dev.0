Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QHDd52nKzF1yy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 17:38:41 +1000 (AEST)
Message-Id: <b66ec6bcd1755aea63fef7ade9bae0a538617665.1523950415.git.christophe.leroy@c-s.fr>
In-Reply-To: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
References: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  2/7] powerpc/lib: inline memcmp() NUL size verification
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Apr 2018 09:38:37 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many calls to memcmp() are done with constant size.
This patch gives GCC a chance to optimise out
the NULL size verification.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/string.h | 10 ++++++++++
 arch/powerpc/lib/memcmp_64.S      |  4 ++++
 arch/powerpc/lib/string_32.S      |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 9b8cedf618f4..cf6f495134c3 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -27,6 +27,16 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
 
+#ifndef CONFIG_FORTIFY_SOURCE
+static inline int __memcmp(const void *p,const void *q,__kernel_size_t size)
+{
+	if (unlikely(!size))
+		return 0;
+	return memcmp(p, q, size);
+}
+#define memcmp __memcmp
+#endif
+
 #ifdef CONFIG_PPC64
 #define __HAVE_ARCH_MEMSET32
 #define __HAVE_ARCH_MEMSET64
diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index d75d18b7bd55..f6822fabf254 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -30,7 +30,9 @@
 #endif
 
 _GLOBAL(memcmp)
+#ifdef CONFIG_FORTIFY_SOURCE
 	cmpdi	cr1,r5,0
+#endif
 
 	/* Use the short loop if both strings are not 8B aligned */
 	or	r6,r3,r4
@@ -39,7 +41,9 @@ _GLOBAL(memcmp)
 	/* Use the short loop if length is less than 32B */
 	cmpdi	cr6,r5,31
 
+#ifdef CONFIG_FORTIFY_SOURCE
 	beq	cr1,.Lzero
+#endif
 	bne	.Lshort
 	bgt	cr6,.Llong
 
diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index 2519f8bd09e3..94e9c9bc31c3 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -15,8 +15,10 @@
 	.text
 
 _GLOBAL(memcmp)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beq-	2f
+#endif
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
@@ -25,8 +27,10 @@ _GLOBAL(memcmp)
 	subf.	r3,r0,r3
 	bdnzt	2,1b
 	blr
+#ifdef CONFIG_FORTIFY_SOURCE
 2:	li	r3,0
 	blr
+#endif
 EXPORT_SYMBOL(memcmp)
 
 _GLOBAL(__clear_user)
-- 
2.13.3
