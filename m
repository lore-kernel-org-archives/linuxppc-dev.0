Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 5018D1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 19:27:35 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc32: rearrange instructions order in ip_fast_csum()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-Id: <20150805092730.C2F171A2412@localhost.localdomain>
Date: Wed,  5 Aug 2015 11:27:30 +0200 (CEST)
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
 v3: Only use lwzu for the last load as lwzu has undocumented
 	additional latency

 arch/powerpc/lib/checksum_32.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 9c48ee0..3ef6e3f 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -26,14 +26,17 @@
  */
 _GLOBAL(ip_fast_csum)
 	lwz	r0,0(r3)
-	lwzu	r5,4(r3)
-	addic.	r4,r4,-2
+	lwz	r5,4(r3)
+	lwz	r6,8(r3)
+	lwzu	r7,12(r3)
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
