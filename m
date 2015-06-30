Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 3F12D1A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 23:51:34 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc32: rearrange instructions order in ip_fast_csum()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-Id: <20150630135128.E75341A241C@localhost.localdomain>
Date: Tue, 30 Jun 2015 15:51:28 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC_8xx, lwz has a 2 cycles latency, and branching also takes
2 cycles. On some other powerpc, lwz has 3 cycles.

As the size of the header is minimum 5 words, we can unroll the loop
for the first words to reduce number of branching, and we can re-order
the instructions to limit loading latency.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/checksum_32.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 9c48ee0..6fbadfe 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -27,13 +27,16 @@
 _GLOBAL(ip_fast_csum)
 	lwz	r0,0(r3)
 	lwzu	r5,4(r3)
-	addic.	r4,r4,-2
+	lwzu	r6,4(r3)
+	lwzu	r7,4(r3)
+	addi	r4,r4,-4
 	addc	r0,r0,r5
 	mtctr	r4
-	blelr-
-1:	lwzu	r4,4(r3)
-	adde	r0,r0,r4
+	adde	r0,r0,r6
+1:	adde	r0,r0,r7
+	lwzu	r7,4(r3)
 	bdnz	1b
+	adde	r0,r0,r7
 	addze	r0,r0		/* add in final carry */
 	rlwinm	r3,r0,16,0,31	/* fold two halves together */
 	add	r3,r0,r3
-- 
2.1.0
