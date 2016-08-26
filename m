Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLP3L6BTRzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 00:45:18 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: fix again csum_partial_copy_generic()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Antoine Blangy <antoine.blangy@c-s.fr>, stable@vger.kernel.org
Message-Id: <20160826144513.A71561A245B@localhost.localdomain>
Date: Fri, 26 Aug 2016 16:45:13 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
based on copy_tofrom_user()") introduced a bug when destination
address is odd and len is lower than cacheline size.

In that case the resulting csum value doesn't have to be rotated one
byte because the cache-aligned copy part is skipped so no alignment
is performed.

Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
based on copy_tofrom_user()")
Cc: stable@vger.kernel.org

Reported-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/lib/checksum_32.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 0a57fe6..aa8214f 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -127,18 +127,19 @@ _GLOBAL(csum_partial_copy_generic)
 	stw	r7,12(r1)
 	stw	r8,8(r1)
 
-	rlwinm	r0,r4,3,0x8
-	rlwnm	r6,r6,r0,0,31	/* odd destination address: rotate one byte */
-	cmplwi	cr7,r0,0	/* is destination address even ? */
 	addic	r12,r6,0
 	addi	r6,r4,-4
 	neg	r0,r4
 	addi	r4,r3,-4
 	andi.	r0,r0,CACHELINE_MASK	/* # bytes to start of cache line */
+	crset	4*cr7+eq
 	beq	58f
 
 	cmplw	0,r5,r0			/* is this more than total to do? */
 	blt	63f			/* if not much to do */
+	rlwinm	r7,r6,3,0x8
+	rlwnm	r12,r12,r7,0,31	/* odd destination address: rotate one byte */
+	cmplwi	cr7,r7,0	/* is destination address even ? */
 	andi.	r8,r0,3			/* get it word-aligned first */
 	mtctr	r8
 	beq+	61f
-- 
2.1.0
