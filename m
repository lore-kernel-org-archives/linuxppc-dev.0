Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn7xx6Mr3zDqZR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 08:15:01 +1100 (AEDT)
Date: Mon, 20 Mar 2017 14:14:47 -0700
From: Matthew Wilcox <willy@infradead.org>
To: paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Optimised memset64/memset32 for powerpc
Message-ID: <20170320211447.GB5073@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I recently introduced memset32() / memset64().  I've done implementations
for x86 & ARM; akpm has agreed to take the patchset through his tree.
Do you fancy doing a powerpc version?  Minchan Kim got a 7% performance
increase with zram from switching to the optimised version on x86.

Here's the development git tree:
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/memfill
(most recent 7 commits)

ARM probably offers the best model for you to work from; it's basically
just a case of jumping into the middle of your existing memset loop.
It was only three instructions to add support to ARM, but I don't know
PowerPC well enough to understand how your existing memset works.
I'd start with something like this ... note that you don't have to
implement memset64 on 32-bit; I only did it on ARM because it was free.
It doesn't look free for you as you only store one register each time
around the loop in the 32-bit memset implementation:

1:      stwu    r4,4(r6)
        bdnz    1b

(wouldn't you get better performance on 32-bit powerpc by unrolling that
loop like you do on 64-bit?)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index da3cdffca440..c02392fced98 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -6,6 +6,7 @@
 #define __HAVE_ARCH_STRNCPY
 #define __HAVE_ARCH_STRNCMP
 #define __HAVE_ARCH_MEMSET
+#define __HAVE_ARCH_MEMSET_PLUS
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
@@ -23,6 +24,18 @@ extern void * memmove(void *,const void *,__kernel_size_t);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 
+extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
+static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
+{
+	return __memset32(p, v, n * 4);
+}
+
+extern void *__memset64(uint64_t *, uint64_t v, __kernel_size_t);
+static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
+{
+	return __memset64(p, v, n * 8);
+}
+
 #endif /* __KERNEL__ */
 
 #endif	/* _ASM_POWERPC_STRING_H */
