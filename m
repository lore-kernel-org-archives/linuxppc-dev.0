Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y25D73vTWzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 14:57:43 +1000 (AEST)
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Jeremy Kerr <jk@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>,
 Meng YK Li <shlimeng@cn.ibm.com>
Subject: [PATCH] powerpc: Fix action argument for cpufeatures-based TLB flush
Date: Wed, 27 Sep 2017 12:55:51 +0800
Message-Id: <1506488151-9825-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 41d0c2ecde introduced calls to __flush_tlb_power[89] from the
cpufeatures code, specifying the number of sets to flush.

However, these functions take an action argument, not a number of sets.
This means we hit the BUG() in __flush_tlb_{206,300} when using
cpufeatures-style configuration.

This change passes TLB_INVAL_SCOPE_GLOBAL instead.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
CC: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 1df770e..7275fed 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -102,10 +102,10 @@ static void cpufeatures_flush_tlb(void)
 	case PVR_POWER8:
 	case PVR_POWER8E:
 	case PVR_POWER8NVL:
-		__flush_tlb_power8(POWER8_TLB_SETS);
+		__flush_tlb_power8(TLB_INVAL_SCOPE_GLOBAL);
 		break;
 	case PVR_POWER9:
-		__flush_tlb_power9(POWER9_TLB_SETS_HASH);
+		__flush_tlb_power9(TLB_INVAL_SCOPE_GLOBAL);
 		break;
 	default:
 		pr_err("unknown CPU version for boot TLB flush\n");
-- 
2.7.4
