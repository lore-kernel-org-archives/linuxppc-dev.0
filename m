Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415SBs2HQtzDr9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 23:24:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	paulus@samba.org
Subject: [PATCH] powerpc/64s: Fix DT CPU features Power9 DD2.1 logic
Date: Wed, 13 Jun 2018 23:23:56 +1000
Message-Id: <20180613132356.29246-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the device tree CPU features quirk code we want to set
CPU_FTR_POWER9_DD2_1 on all Power9s that aren't DD2.0 or earlier. But
we got the logic wrong and instead set it on all CPUs that aren't
Power9 DD2.0 or earlier, ie. including Power8.

Fix it by making sure we're on a Power9. This isn't a bug in practice
because the only code that checks the feature is Power9 only to begin
with. But we'll backport it anyway to avoid confusion.

Fixes: 9e9626ed3a4a ("powerpc/64s: Fix POWER9 DD2.2 and above in DT CPU features")
Cc: stable@vger.kernel.org # v4.17+
Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 4be1c0de9406..96dd3d871986 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -711,7 +711,8 @@ static __init void cpufeatures_cpu_quirks(void)
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TM_HV_ASSIST;
 		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TM_XER_SO_BUG;
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
-	} else /* DD2.1 and up have DD2_1 */
+	} else if ((version & 0xffff0000) == 0x004e0000)
+		/* DD2.1 and up have DD2_1 */
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
 
 	if ((version & 0xffff0000) == 0x004e0000) {
-- 
2.14.1
