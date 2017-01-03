Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttNWh30NGzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 05:58:40 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b1so34338369pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 10:58:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc: implement clear_bit_unlock_is_negative_byte()
Date: Wed,  4 Jan 2017 04:58:28 +1000
Message-Id: <20170103185828.31311-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b91e1302ad9b8 ("mm: optimize PageWaiters bit use for
unlock_page()") added a special bitop function to speed up
unlock_page(). Implement this for powerpc.

This improves the unlock_page() core code from this:

	li	9,1
	lwsync
1:	ldarx	10,0,3,0
	andc	10,10,9
	stdcx.	10,0,3
	bne-	1b
	ori	2,2,0
	ld	9,0(3)
	andi.	10,9,0x80
	beqlr
	li	4,0
	b	wake_up_page_bit

To this:

	li	10,1
	lwsync
1:	ldarx	9,0,3,0
	andc	9,9,10
	stdcx.	9,0,3
	bne-	1b
	andi.	10,9,0x80
	beqlr
	li	4,0
	b	wake_up_page_bit

In a test of elapsed time for dd writing into 16GB of already-dirty
pagecache on a POWER8 with 4K pages, which has one unlock_page per 4kB
this patch reduced overhead by 1.1%:

    N           Min           Max        Median           Avg        Stddev
x  19         2.578         2.619         2.594         2.595         0.011
+  19         2.552         2.592         2.564         2.565         0.008
Difference at 95.0% confidence
	-0.030  +/- 0.006
	-1.142% +/- 0.243%

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/bitops.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 59abc620f8e8..9add12ee13dd 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -154,6 +154,31 @@ static __inline__ int test_and_change_bit(unsigned long nr,
 	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
+static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
+						volatile unsigned long *addr)
+{
+	unsigned long old, t;
+	unsigned long *p = (unsigned long *)addr + BIT_WORD(nr);
+	unsigned long mask = BIT_MASK(nr);
+
+	__asm__ __volatile__ (
+	PPC_RELEASE_BARRIER
+"1:"	PPC_LLARX(%0,0,%3,0) "\n"
+	"andc %1,%0,%2\n"
+	PPC405_ERR77(0,%3)
+	PPC_STLCX "%1,0,%3\n"
+	"bne- 1b\n"
+	: "=&r" (old), "=&r" (t)
+	: "r" (mask), "r" (p)
+	: "cc", "memory");
+
+	return old;
+}
+
+/* This is a special function for mm/filemap.c */
+#define clear_bit_unlock_is_negative_byte(nr, addr)			\
+	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(PG_waiters))
+
 #include <asm-generic/bitops/non-atomic.h>
 
 static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
-- 
2.11.0
