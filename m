Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RtTn4clBzF35Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 23:10:52 +1000 (AEST)
Message-Id: <4302f36bd615c179c92f2007a0f3a1215ba96c55.1531439662.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix handling of early NULL pointer dereference
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 13 Jul 2018 13:10:47 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NULL pointers are pointers to user memory space. So user pagetable
has to be set in order to avoid random behaviour in case of NULL
pointer dereference, otherwise we may encounter random memory
access hence Machine Check Exception from TLB Miss handlers.

Set user pagetable as early as possible in order to properly
catch early kernel NULL pointer dereference.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6cab07e76732..04501b65040e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -873,6 +873,10 @@ start_here:
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
+	lis	r6, swapper_pg_dir@ha
+	tophys(r6,r6)
+	mtspr	SPRN_M_TW, r6
+
 	bl	early_init	/* We have to do this with MMU on */
 
 /*
@@ -893,9 +897,6 @@ start_here:
 	 * init's THREAD like the context switch code does, but this is
 	 * easier......until someone changes init's static structures.
 	 */
-	lis	r6, swapper_pg_dir@ha
-	tophys(r6,r6)
-	mtspr	SPRN_M_TW, r6
 	lis	r4,2f@h
 	ori	r4,r4,2f@l
 	tophys(r4,r4)
-- 
2.13.3
