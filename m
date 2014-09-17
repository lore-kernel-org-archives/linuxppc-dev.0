Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B6BC1A0138
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:39:41 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 1/6] powerpc: Speed up clear_page by unrolling it
Date: Wed, 17 Sep 2014 14:39:34 +1000
Message-Id: <1410928779-20938-1-git-send-email-anton@samba.org>
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

This assumes cacheline sizes won't grow beyond 512 bytes and
page sizes wont drop below 1kB, which is unlikely, but we could
add a runtime check during early init if it makes people nervous.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/page_64.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index d0d6afb..b6e78cb 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -51,11 +51,21 @@ static __inline__ void clear_page(void *addr)
 
 	__asm__ __volatile__(
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
+	: "r" (lines/8), "0" (addr), "b" (line_size), "b" (line_size*2),
+		"b" (line_size*3), "b" (line_size*4), "b" (line_size*5),
+		"b" (line_size*6), "b" (line_size*7), "r" (line_size*8)
 	: "ctr", "memory");
 }
 
-- 
1.9.1
