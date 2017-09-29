Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HM14DlJzDsQ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:37:49 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <nicholas.piggin@gmail.com>
Subject: [PATCH] powerpc: Fix workaround for spurious MCE on POWER9
Date: Thu, 28 Sep 2017 22:37:35 -0500
Message-Id: <20170929033735.28710-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the recent commit:
  d8bd9f3f09 powerpc: Handle MCE on POWER9 with only DSISR bit 30 set
I screwed up the bit.  It should be bit 25 (IBM bit 38).

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/mce_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index f523125b9d..72f153c6f3 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -626,7 +626,7 @@ long __machine_check_early_realmode_p9(struct pt_regs *regs)
 {
 	/*
 	 * On POWER9 DD2.1 and below, it's possible to get a machine check
-	 * caused by a paste instruction where only DSISR bit 30 is set. This
+	 * caused by a paste instruction where only DSISR bit 25 is set. This
 	 * will result in the MCE handler seeing an unknown event and the kernel
 	 * crashing. An MCE that occurs like this is spurious, so we don't need
 	 * to do anything in terms of servicing it. If there is something that
@@ -634,7 +634,7 @@ long __machine_check_early_realmode_p9(struct pt_regs *regs)
 	 * correct DSISR so that it can be serviced properly. So detect this
 	 * case and mark it as handled.
 	 */
-	if (SRR1_MC_LOADSTORE(regs->msr) && regs->dsisr == 0x40000000)
+	if (SRR1_MC_LOADSTORE(regs->msr) && regs->dsisr == 0x02000000)
 		return 1;
 
 	return mce_handle_error(regs, mce_p9_derror_table, mce_p9_ierror_table);
-- 
2.11.0
