Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QHDs1BBmzF1tF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 17:38:51 +1000 (AEST)
Message-Id: <b27f1b13f1d5fca6fb0ad5e90692667c56528583.1523950415.git.christophe.leroy@c-s.fr>
In-Reply-To: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
References: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/7] powerpc/lib: Remove .balign inside string functions for
 PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Apr 2018 09:38:47 +0200 (CEST)
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
 arch/powerpc/lib/string.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 89af53b08b4a..9e96f1c102c6 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -25,7 +25,9 @@ _GLOBAL(strncpy)
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
+#ifdef CONFIG_PPC64
 	.balign 16
+#endif
 1:	lbzu	r0,1(r4)
 	cmpwi	0,r0,0
 	stbu	r0,1(r6)
@@ -47,7 +49,9 @@ _GLOBAL(strncmp)
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
+#ifdef CONFIG_PPC64
 	.balign 16
+#endif
 1:	lbzu	r3,1(r5)
 	cmpwi	1,r3,0
 	lbzu	r0,1(r4)
@@ -68,7 +72,9 @@ _GLOBAL(memchr)
 #endif
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
