Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mn2p4k5yzF1Ss
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 20:04:18 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/lib: Remove .balign inside string functions for PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180517100413.856096F938@po14934vm.idsi0.si.c-s.fr>
Date: Thu, 17 May 2018 12:04:13 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 87a156fb18fe1 ("Align hot loops of some string functions")
degraded the performance of string functions by adding useless
nops

A simple benchmark on an 8xx calling 100000x a memchr() that
matches the first byte runs in 41668 TB ticks before this patch
and in 35986 TB ticks after this patch. So this gives an
improvement of approx 10%

Another benchmark doing the same with a memchr() matching the 128th
byte runs in 1011365 TB ticks before this patch and 1005682 TB ticks
after this patch, so regardless on the number of loops, removing
those useless nops improves the test by 5683 TB ticks.

Fixes: 87a156fb18fe1 ("Align hot loops of some string functions")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Was sent already as part of a serie optimising string functions.
 Resending on itself as it is independent of the other changes in the serie

 arch/powerpc/lib/string.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index a787776822d8..a026d8fa8a99 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -23,7 +23,9 @@ _GLOBAL(strncpy)
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
+#ifdef CONFIG_PPC64
 	.balign 16
+#endif
 1:	lbzu	r0,1(r4)
 	cmpwi	0,r0,0
 	stbu	r0,1(r6)
@@ -43,7 +45,9 @@ _GLOBAL(strncmp)
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
+#ifdef CONFIG_PPC64
 	.balign 16
+#endif
 1:	lbzu	r3,1(r5)
 	cmpwi	1,r3,0
 	lbzu	r0,1(r4)
@@ -77,7 +81,9 @@ _GLOBAL(memchr)
 	beq-	2f
 	mtctr	r5
 	addi	r3,r3,-1
+#ifdef CONFIG_PPC64
 	.balign 16
+#endif
 1:	lbzu	r0,1(r3)
 	cmpw	0,r0,r4
 	bdnzf	2,1b
-- 
2.13.3
