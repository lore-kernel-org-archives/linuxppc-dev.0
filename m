Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtkQb3ML0zDrJZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 15:26:15 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org
Subject: [PATCH 2/2] powerpc: Handle MCE on POWER9 with only DSISR bit 33 set
Date: Fri, 15 Sep 2017 15:25:49 +1000
Message-Id: <20170915052549.8105-2-mikey@neuling.org>
In-Reply-To: <20170915052549.8105-1-mikey@neuling.org>
References: <20170915052549.8105-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 DD2.1 and below, it's possible to get Machine Check
Exception (MCE) where only DSISR bit 33 is set. This will result in
the linux MCE handler seeing an unknown event, which triggers linux to
crash.

We change this by detecting unknown events in the MCE handler and
marking them as handled so that we no longer crash. We do this only on
chip revisions known to have this problem.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/mce_power.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index b76ca198e0..72ec667136 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -595,6 +595,7 @@ static long mce_handle_error(struct pt_regs *regs,
 	uint64_t addr;
 	uint64_t srr1 = regs->msr;
 	long handled;
+	unsigned long pvr;
 
 	if (SRR1_MC_LOADSTORE(srr1))
 		handled = mce_handle_derror(regs, dtable, &mce_err, &addr);
@@ -604,6 +605,20 @@ static long mce_handle_error(struct pt_regs *regs,
 	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
 		handled = mce_handle_ue_error(regs);
 
+	/*
+	 * On POWER9 DD2.1 and below, it's possible to get machine
+	 * check where only DSISR bit 33 is set. This will result in
+	 * the MCE handler seeing an unknown event and us crashing.
+	 * Change this to mark as handled on these revisions.
+	 */
+	pvr = mfspr(SPRN_PVR);
+	if (((PVR_VER(pvr) == PVR_POWER9) &&
+	     (PVR_CFG(pvr) == 2) &&
+	     (PVR_MIN(pvr) <= 1)) || cpu_has_feature(CPU_FTR_POWER9_DD1))
+		/* DD2.1 and below */
+		if (mce_err.error_type == MCE_ERROR_TYPE_UNKNOWN)
+		    handled = 1;
+
 	save_mce_event(regs, handled, &mce_err, regs->nip, addr);
 
 	return handled;
-- 
2.11.0
