Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4D6A1A181E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 15:44:20 +1000 (EST)
Date: Thu, 2 Oct 2014 15:44:21 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v2] powerpc: Speed up clear_page by unrolling it
Message-ID: <20141002154421.62073027@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unroll clear_page 8 times. A simple microbenchmark which
allocates and frees a zeroed page:

for (i = 0; i < iterations; i++) {
	unsigned long p = __get_free_page(GFP_KERNEL | __GFP_ZERO);
	free_page(p);
}

improves 20% on POWER8.

This assumes cacheline sizes won't grow beyond 512 bytes or
page sizes wont drop below 1kB, which is unlikely, but we could
add a runtime check during early init if it makes people nervous.

Michael found that some versions of gcc produce quite bad code
(all multiplies), so we give gcc a hand by using shifts and adds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/page_64.h | 42 ++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index d0d6afb..d908a46 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -42,20 +42,40 @@
 
 typedef unsigned long pte_basic_t;
 
-static __inline__ void clear_page(void *addr)
+static inline void clear_page(void *addr)
 {
-	unsigned long lines, line_size;
-
-	line_size = ppc64_caches.dline_size;
-	lines = ppc64_caches.dlines_per_page;
-
-	__asm__ __volatile__(
+	unsigned long iterations;
+	unsigned long onex, twox, fourx, eightx;
+
+	iterations = ppc64_caches.dlines_per_page / 8;
+
+	/*
+	 * Some verisions of gcc use multiply instructions to
+	 * calculate the offsets so lets give it a hand to
+	 * do better.
+	 */
+	onex = ppc64_caches.dline_size;
+	twox = onex << 1;
+	fourx = onex << 2;
+	eightx = onex << 3;
+
+	asm volatile(
 	"mtctr	%1	# clear_page\n\
-1:      dcbz	0,%0\n\
-	add	%0,%0,%3\n\
+	.balign	16\n\
+1:	dcbz	0,%0\n\
+	dcbz	%3,%0\n\
+	dcbz	%4,%0\n\
+	dcbz	%5,%0\n\
+	dcbz	%6,%0\n\
+	dcbz	%7,%0\n\
+	dcbz	%8,%0\n\
+	dcbz	%9,%0\n\
+	add	%0,%0,%10\n\
 	bdnz+	1b"
-        : "=r" (addr)
-        : "r" (lines), "0" (addr), "r" (line_size)
+	: "=&r" (addr)
+	: "r" (iterations), "0" (addr), "b" (onex), "b" (twox),
+		"b" (twox+onex), "b" (fourx), "b" (fourx+onex),
+		"b" (twox+fourx), "b" (eightx-onex), "r" (eightx)
 	: "ctr", "memory");
 }
 
-- 
1.9.1
