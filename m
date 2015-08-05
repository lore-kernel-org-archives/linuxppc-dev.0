Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id DDCBD1A1C02
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 23:29:37 +1000 (AEST)
Message-Id: <67cf476f657e87b2ea586951a57ae3ba3c1e3c0c.1435655733.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1435655733.git.christophe.leroy@c-s.fr>
References: <cover.1435655733.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] powerpc32: optimise csum_partial() loop
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed,  5 Aug 2015 15:29:35 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the 8xx, load latency is 2 cycles and taking branches also takes
2 cycles. So let's unroll the loop.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Only use lwzu for the last load as lwzu has undocumented
 	additional latency

 arch/powerpc/lib/checksum_32.S | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 2e4879c..9c48ee0 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -75,10 +75,24 @@ _GLOBAL(csum_partial)
 	srwi.	r6,r4,2		/* # words to do */
 	adde	r5,r5,r0
 	beq	3f
-1:	mtctr	r6
+1:	andi.	r6,r6,3		/* Prepare to handle words 4 by 4 */
+	beq	21f
+	mtctr	r6
 2:	lwzu	r0,4(r3)
 	adde	r5,r5,r0
 	bdnz	2b
+21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
+	beq	3f
+	mtctr	r6
+22:	lwz	r0,4(r3)
+	lwz	r6,8(r3)
+	lwz	r7,12(r3)
+	lwzu	r8,16(r3)
+	adde	r5,r5,r0
+	adde	r5,r5,r6
+	adde	r5,r5,r7
+	adde	r5,r5,r8
+	bdnz	22b
 3:	andi.	r0,r4,2
 	beq+	4f
 	lhz	r0,4(r3)
-- 
2.1.0
