Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCFADB724B
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:03 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/11] oprofile/fsl emb: Don't set MSR[PMM] until after
	clearing the interrupt.
Date: Fri,  8 Oct 2010 14:06:44 -0500
Message-Id: <1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

On an arch 2.06 hypervisor, a pending perfmon interrupt will be delivered
to the hypervisor at any point the guest is running, regardless of
MSR[EE].  In order to reflect this interrupt, the hypervisor has to mask
the interrupt in PMGC0 -- and set MSRP[PMMP] to intercept futher guest
accesses to the PMRs to detect when to unmask (and prevent the guest from
unmasking early, or seeing inconsistent state).

This has the side effect of ignoring any changes the guest makes to
MSR[PMM], so wait until after the interrupt is clear, and thus the
hypervisor should have cleared MSRP[PMMP], before setting MSR[PMM].  The
counters wil not actually run until PMGC0[FAC] is cleared in
pmc_start_ctrs(), so this will not reduce the effectiveness of PMM.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/oprofile/op_model_fsl_emb.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/oprofile/op_model_fsl_emb.c b/arch/powerpc/oprofile/op_model_fsl_emb.c
index 62312ab..d4e6507 100644
--- a/arch/powerpc/oprofile/op_model_fsl_emb.c
+++ b/arch/powerpc/oprofile/op_model_fsl_emb.c
@@ -2,7 +2,7 @@
  * Freescale Embedded oprofile support, based on ppc64 oprofile support
  * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
  *
- * Copyright (c) 2004 Freescale Semiconductor, Inc
+ * Copyright (c) 2004, 2010 Freescale Semiconductor, Inc
  *
  * Author: Andy Fleming
  * Maintainer: Kumar Gala <galak@kernel.crashing.org>
@@ -321,9 +321,6 @@ static void fsl_emb_handle_interrupt(struct pt_regs *regs,
 	int val;
 	int i;
 
-	/* set the PMM bit (see comment below) */
-	mtmsr(mfmsr() | MSR_PMM);
-
 	pc = regs->nip;
 	is_kernel = is_kernel_addr(pc);
 
@@ -340,9 +337,13 @@ static void fsl_emb_handle_interrupt(struct pt_regs *regs,
 	}
 
 	/* The freeze bit was set by the interrupt. */
-	/* Clear the freeze bit, and reenable the interrupt.
-	 * The counters won't actually start until the rfi clears
-	 * the PMM bit */
+	/* Clear the freeze bit, and reenable the interrupt.  The
+	 * counters won't actually start until the rfi clears the PMM
+	 * bit.  The PMM bit should not be set until after the interrupt
+	 * is cleared to avoid it getting lost in some hypervisor
+	 * environments.
+	 */
+	mtmsr(mfmsr() | MSR_PMM);
 	pmc_start_ctrs(1);
 }
 
-- 
1.7.2.3
