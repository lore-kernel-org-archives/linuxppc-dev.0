Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBdV0hBwzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:04:46 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBdR2GmJz9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:04:42 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/41] powerpc: Move 64-bit feature fixup earlier
Date: Tue,  5 Jul 2016 15:03:42 +1000
Message-Id: <1467695057-12431-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make it part of early_setup() as we really want the feature fixups
to be applied before we turn on the MMU since they can have an impact
on the various assembly path related to MMU management and interrupts.

This makes 64-bit match what 32-bit does.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 996bed2..e79cf1b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -286,6 +286,9 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
 
+	/* Apply all the dynamic patching */
+	apply_feature_fixups();
+
 	/*
 	 * At this point, we can let interrupts switch to virtual mode
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
@@ -468,8 +471,6 @@ void __init setup_system(void)
 {
 	DBG(" -> setup_system()\n");
 
-	apply_feature_fixups();
-
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
 	 */
-- 
2.7.4
