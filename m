Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s6Rr2Z8mzF0pl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 21:22:32 +1000 (AEST)
Message-Id: <484bcfaccc1ec3d91b74aeaaa26a0ae66fe0955a.1527160868.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Optimise __csum_partial()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 24 May 2018 11:22:27 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Improve __csum_partial by interleaving loads and adds.

On a 8xx, it brings neither improvement nor degradation.
On a 83xx, it brings a 25% improvement.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/checksum_32.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index d2238ea82209..aa224069f93a 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -47,16 +47,25 @@ _GLOBAL(__csum_partial)
 	bdnz	2b
 21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
 	beq	3f
+	lwz	r0,4(r3)
 	mtctr	r6
-22:	lwz	r0,4(r3)
 	lwz	r6,8(r3)
+	adde	r5,r5,r0
 	lwz	r7,12(r3)
+	adde	r5,r5,r6
 	lwzu	r8,16(r3)
+	adde	r5,r5,r7
+	bdz	23f
+22:	lwz	r0,4(r3)
+	adde	r5,r5,r8
+	lwz	r6,8(r3)
 	adde	r5,r5,r0
+	lwz	r7,12(r3)
 	adde	r5,r5,r6
+	lwzu	r8,16(r3)
 	adde	r5,r5,r7
-	adde	r5,r5,r8
 	bdnz	22b
+23:	adde	r5,r5,r8
 3:	andi.	r0,r4,2
 	beq+	4f
 	lhz	r0,4(r3)
-- 
2.13.3
