Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CAC01A028E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:13 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/19] powerpc: Don't disable MSR bits in
 do_load_up_transact_*() functions
Date: Wed, 28 Oct 2015 11:50:50 +1100
Message-Id: <1445993467-667-2-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to the non TM load_up_*() functions, don't disable the MSR
bits on the way out.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/fpu.S    | 4 ----
 arch/powerpc/kernel/vector.S | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 9ad236e..38eb79b 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -73,10 +73,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	MTFSF_L(fr0)
 	REST_32FPVSRS(0, R4, R7)
 
-	/* FP/VSX off again */
-	MTMSRD(r6)
-	SYNC
-
 	blr
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index f5c80d5..1c54259 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -29,10 +29,6 @@ _GLOBAL(do_load_up_transact_altivec)
 	addi	r10,r3,THREAD_TRANSACT_VRSTATE
 	REST_32VRS(0,r4,r10)
 
-	/* Disable VEC again. */
-	MTMSRD(r6)
-	isync
-
 	blr
 #endif
 
-- 
2.5.0
