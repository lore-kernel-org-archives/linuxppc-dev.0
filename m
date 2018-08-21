Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vXWL5ldczF1Rh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 11:04:14 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Remove static branch hints from memset()
Date: Tue, 21 Aug 2018 11:04:12 +1000
Message-Id: <20180821010412.23806-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Static branch hints override dynamic branch prediction on recent
POWER CPUs. We should only use them when we are overwhelmingly
sure of the direction.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/mem_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index ec531de99996..3c3be02f33b7 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -40,7 +40,7 @@ _GLOBAL(memset)
 .Lms:	PPC_MTOCRF(1,r0)
 	mr	r6,r3
 	blt	cr1,8f
-	beq+	3f			/* if already 8-byte aligned */
+	beq	3f			/* if already 8-byte aligned */
 	subf	r5,r0,r5
 	bf	31,1f
 	stb	r4,0(r6)
@@ -85,7 +85,7 @@ _GLOBAL(memset)
 	addi	r6,r6,8
 8:	cmpwi	r5,0
 	PPC_MTOCRF(1,r5)
-	beqlr+
+	beqlr
 	bf	29,9f
 	stw	r4,0(r6)
 	addi	r6,r6,4
-- 
2.17.1
