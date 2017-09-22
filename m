Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyzZM0kTRzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 13:32:43 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <nicholas.piggin@gmail.com>
Subject: [PATCH v3] powerpc: Handle MCE on POWER9 with only DSISR bit 33 set
Date: Fri, 22 Sep 2017 13:32:21 +1000
Message-Id: <20170922033221.31609-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 DD2.1 and below, it's possible for a paste instruction to
cause a Machine Check Exception (MCE) where only DSISR bit 33 is
set. This will result in the MCE handler seeing an unknown event,
which triggers linux to crash.

We change this by detecting unknown events caused by load/stores in
the MCE handler and marking them as handled so that we no longer
crash.

An MCE that occurs like this is spurious, so we don't need to do
anything in terms of servicing it. If there is something that needs to
be serviced, the CPU will raise the MCE again with the correct DSISR
so that it can be serviced properly.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com
--
v3: Simplification and SRR1 check suggestions from Nick
v2: update commit message based on Balbir's comments
---
 arch/powerpc/kernel/mce_power.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index b76ca198e0..e423cf0e43 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -624,5 +624,15 @@ long __machine_check_early_realmode_p8(struct pt_regs *regs)
 
 long __machine_check_early_realmode_p9(struct pt_regs *regs)
 {
+	/*
+	 * On POWER9 DD2.1 and below, it's possible to get machine
+	 * check caused by a paste instruction where only DSISR bit 33
+	 * is set. This will result in the MCE handler seeing an
+	 * unknown event and us crashing.  Change this to mark as
+	 * handled.
+	 */
+	if (SRR1_MC_LOADSTORE(regs->msr) && regs->dsisr == 0x40000000)
+		return 1;
+
 	return mce_handle_error(regs, mce_p9_derror_table, mce_p9_ierror_table);
 }
-- 
2.11.0
