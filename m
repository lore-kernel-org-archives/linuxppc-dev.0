Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id D08C81A0FF7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 23:56:41 +1000 (AEST)
Message-Id: <9d30facd97665b4b08a0b1d2e086ca26a88b2ce0.1435655732.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1435655732.git.christophe.leroy@c-s.fr>
References: <cover.1435655732.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc32: optimise a few instructions in csum_partial()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 30 Jun 2015 15:56:38 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

r5 does contain the value to be updated, so lets use r5 all way long
for that. It makes the code more readable.

To avoid confusion, it is better to use adde instead of addc

The first addition is useless. Its only purpose is to clear carry.
As r4 is a signed int that is always positive, this can be done by
using srawi instead of srwi

Let's also remove the comment about dcbz having no overhead as it
is not correct on all powerpc, at least on MPC8xx

In the last part, in our situation, the remaining quantity of bytes
to be proceeded is between 0 and 3. Therefore, we can base that part
on the value of bit 31 and bit 30 of r4 instead of anding r4 with 3
then proceding on comparisons and substractions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/checksum_32.S | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 7b95a68..2e4879c 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -64,35 +64,32 @@ _GLOBAL(csum_tcpudp_magic)
  * csum_partial(buff, len, sum)
  */
 _GLOBAL(csum_partial)
-	addic	r0,r5,0
 	subi	r3,r3,4
-	srwi.	r6,r4,2
+	srawi.	r6,r4,2		/* Divide len by 4 and also clear carry */
 	beq	3f		/* if we're doing < 4 bytes */
-	andi.	r5,r3,2		/* Align buffer to longword boundary */
+	andi.	r0,r3,2		/* Align buffer to longword boundary */
 	beq+	1f
-	lhz	r5,4(r3)	/* do 2 bytes to get aligned */
-	addi	r3,r3,2
+	lhz	r0,4(r3)	/* do 2 bytes to get aligned */
 	subi	r4,r4,2
-	addc	r0,r0,r5
+	addi	r3,r3,2
 	srwi.	r6,r4,2		/* # words to do */
+	adde	r5,r5,r0
 	beq	3f
 1:	mtctr	r6
-2:	lwzu	r5,4(r3)	/* the bdnz has zero overhead, so it should */
-	adde	r0,r0,r5	/* be unnecessary to unroll this loop */
+2:	lwzu	r0,4(r3)
+	adde	r5,r5,r0
 	bdnz	2b
-	andi.	r4,r4,3
-3:	cmpwi	0,r4,2
-	blt+	4f
-	lhz	r5,4(r3)
+3:	andi.	r0,r4,2
+	beq+	4f
+	lhz	r0,4(r3)
 	addi	r3,r3,2
-	subi	r4,r4,2
-	adde	r0,r0,r5
-4:	cmpwi	0,r4,1
-	bne+	5f
-	lbz	r5,4(r3)
-	slwi	r5,r5,8		/* Upper byte of word */
-	adde	r0,r0,r5
-5:	addze	r3,r0		/* add in final carry */
+	adde	r5,r5,r0
+4:	andi.	r0,r4,1
+	beq+	5f
+	lbz	r0,4(r3)
+	slwi	r0,r0,8		/* Upper byte of word */
+	adde	r5,r5,r0
+5:	addze	r3,r5		/* add in final carry */
 	blr
 
 /*
-- 
2.1.0
