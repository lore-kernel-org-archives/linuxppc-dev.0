Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0143.outbound.protection.outlook.com [157.56.110.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC7001A0757
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 13:01:01 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/e500mc: Remove dead L2 flushing code in idle_e500.S
Date: Mon, 6 Apr 2015 22:00:38 -0500
Message-ID: <1428375638-13361-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code can never be executed as it is only built when
CONFIG_PPC_E500MC is unset, but the only CPUs that have CPU_FTR_L2CSR
require CONFIG_PPC_E500MC and do not have the MSR/HID0-based nap
mechanism that this file uses.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/idle_e500.S | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 1544866..b9b6ef5 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -58,15 +58,6 @@ BEGIN_FTR_SECTION
 	mtlr	r0
 	lis	r3,HID0_NAP@h
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
-BEGIN_FTR_SECTION
-	msync
-	li	r7,L2CSR0_L2FL@l
-	mtspr	SPRN_L2CSR0,r7
-2:
-	mfspr	r7,SPRN_L2CSR0
-	andi.	r4,r7,L2CSR0_L2FL@l
-	bne	2b
-END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
 1:
 	/* Go to NAP or DOZE now */
 	mfspr	r4,SPRN_HID0
-- 
2.1.0
