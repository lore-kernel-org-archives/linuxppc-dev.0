Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXJd81jr5zDr3s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:01:31 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc: Remove redundant fp/altivec giveup code
Date: Wed, 16 Aug 2017 16:01:16 +1000
Message-Id: <20170816060118.24803-3-benh@kernel.crashing.org>
In-Reply-To: <20170816060118.24803-1-benh@kernel.crashing.org>
References: <20170816060118.24803-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__giveup_vsx already calls those two functions

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 14b9a3c46c5d..bfbd6083f841 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -375,10 +375,6 @@ void enable_kernel_vsx(void)
 		 */
 		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
 			return;
-		if (current->thread.regs->msr & MSR_FP)
-			__giveup_fpu(current);
-		if (current->thread.regs->msr & MSR_VEC)
-			__giveup_altivec(current);
 		__giveup_vsx(current);
 	}
 }
-- 
2.13.4
