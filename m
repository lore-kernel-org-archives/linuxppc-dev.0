Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcr700SMnzDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:54:35 +1000 (AEST)
Message-Id: <118f28ccb9be59c72f4c7a2a0ce3c8591dea6582.1503277387.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1503277387.git.christophe.leroy@c-s.fr>
References: <cover.1503277387.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/4] powerpc/32: add memset16()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 16:54:32 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 694fc88ce271f ("powerpc/string: Implement optimized
memset variants") added memset16(), memset32() and memset64()
for the 64 bits PPC.

On 32 bits, memset64() is not relevant, and as shown below,
the generic version of memset32() gives a good code, so only
memset16() is candidate for an optimised version.

000009c0 <memset32>:
 9c0:   2c 05 00 00     cmpwi   r5,0
 9c4:   39 23 ff fc     addi    r9,r3,-4
 9c8:   4d 82 00 20     beqlr
 9cc:   7c a9 03 a6     mtctr   r5
 9d0:   94 89 00 04     stwu    r4,4(r9)
 9d4:   42 00 ff fc     bdnz    9d0 <memset32+0x10>
 9d8:   4e 80 00 20     blr

The last part of memset() handling the not 4-bytes multiples
operates on bytes, making it unsuitable for handling word without
modification. As it would increase memset() complexity, it is
better to implement memset16() from scratch. In addition it
has the advantage of allowing a more optimised memset16() than what
we would have by using the memset() function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/string.h |  4 +++-
 arch/powerpc/lib/copy_32.S        | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index b0e82466d4e8..b9f54bb34db6 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -10,6 +10,7 @@
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
 #define __HAVE_ARCH_MEMCHR
+#define __HAVE_ARCH_MEMSET16
 
 extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
@@ -24,7 +25,6 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 
 #ifdef CONFIG_PPC64
-#define __HAVE_ARCH_MEMSET16
 #define __HAVE_ARCH_MEMSET32
 #define __HAVE_ARCH_MEMSET64
 
@@ -46,6 +46,8 @@ static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 {
 	return __memset64(p, v, n * 8);
 }
+#else
+extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
 #endif
 #endif /* __KERNEL__ */
 
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 8aedbb5f4b86..a14d4df2ebc9 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -67,6 +67,20 @@ CACHELINE_BYTES = L1_CACHE_BYTES
 LG_CACHELINE_BYTES = L1_CACHE_SHIFT
 CACHELINE_MASK = (L1_CACHE_BYTES-1)
 
+_GLOBAL(memset16)
+	rlwinm.	r0 ,r5, 31, 1, 31
+	addi	r6, r3, -4
+	beq-	2f
+	rlwimi	r4 ,r4 ,16 ,0 ,15
+	mtctr	r0
+1:	stwu	r4, 4(r6)
+	bdnz	1b
+2:	andi.	r0, r5, 1
+	beqlr
+	sth	r4, 4(r6)
+	blr
+EXPORT_SYMBOL(memset16)
+
 /*
  * Use dcbz on the complete cache lines in the destination
  * to set them to zero.  This requires that the destination
-- 
2.13.3
