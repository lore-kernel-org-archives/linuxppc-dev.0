Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id DEEFF1A04BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:51:22 +1000 (AEST)
Message-Id: <044c1051260d4110b81af6881242eda7c8d406ac.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 25/25] powerpc32: Remove one insn in mulhdu
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:51:19 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove one instruction in mulhdu

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
New in v2

 arch/powerpc/kernel/misc_32.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 1597424..870dc63 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -91,17 +91,16 @@ _GLOBAL(mulhdu)
 	addc	r7,r0,r7
 	addze	r4,r4
 1:	beqlr	cr1		/* all done if high part of A is 0 */
-	mr	r10,r3
 	mullw	r9,r3,r5
-	mulhwu	r3,r3,r5
+	mulhwu	r10,r3,r5
 	beq	2f
-	mullw	r0,r10,r6
-	mulhwu	r8,r10,r6
+	mullw	r0,r3,r6
+	mulhwu	r8,r3,r6
 	addc	r7,r0,r7
 	adde	r4,r4,r8
-	addze	r3,r3
+	addze	r10,r10
 2:	addc	r4,r4,r9
-	addze	r3,r3
+	addze	r3,r10
 	blr
 
 /*
-- 
2.1.0
