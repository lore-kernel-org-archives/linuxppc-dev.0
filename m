Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXjzX5pMczDqbs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 17:03:36 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, mikey@neuling.org,
 Greg Johnson <gwj@google.com>
Subject: [PATCH] powerpc: Fix booting P9 hash with CONFIG_PPC_RADIX_MMU=N
Date: Wed, 24 May 2017 17:03:26 +1000
Message-Id: <20170524070326.13531-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if you disable CONFIG_PPC_RADIX_MMU you'll crash on boot on
a P9. This is because we still set MMU_FTR_TYPE_RADIX via
ibm,pa-features and MMU_FTR_TYPE_RADIX is what's used for code patching
in much of the asm code (ie. slb_miss_realmode)

This patch fixes the problem by stopping MMU_FTR_TYPE_RADIX from being
set from ibm.pa-features.

We may eventually end up removing the CONFIG_PPC_RADIX_MMU option
completely but until then this fixes the issue.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/prom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 40c4887c27..f830562974 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -161,7 +161,9 @@ static struct ibm_pa_feature {
 	{ .pabyte = 0,  .pabit = 3, .cpu_features  = CPU_FTR_CTRL },
 	{ .pabyte = 0,  .pabit = 6, .cpu_features  = CPU_FTR_NOEXECUTE },
 	{ .pabyte = 1,  .pabit = 2, .mmu_features  = MMU_FTR_CI_LARGE_PAGE },
+#ifdef CONFIG_PPC_RADIX_MMU
 	{ .pabyte = 40, .pabit = 0, .mmu_features  = MMU_FTR_TYPE_RADIX },
+#endif
 	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features = CPU_FTR_NODSISRALIGN },
 	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
 				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
-- 
2.11.0
