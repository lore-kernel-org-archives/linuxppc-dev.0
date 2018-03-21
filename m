Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405s8B4VhvzF1TQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:07:54 +1100 (AEDT)
Message-Id: <00a43265a2759dc284a17b042df633f0717c9dcb.1521641042.git.christophe.leroy@c-s.fr>
In-Reply-To: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
References: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  2/4] powerpc/mm: Avoid unnecessary test and reduce code size
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Mar 2018 15:07:49 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

no_selective_tlbil hence the use of either steal_all_contexts()
or steal_context_up() depends on the subarch, it won't change
during run. Only the 8xx uses steal_all_contexts and CONFIG_PPC_8xx
is exclusive of other processors.

This patch replaces the test of no_selective_tlbil global var by
a test of CONFIG_PPC_8xx selection. It avoids the test and
removes unnecessary code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmu_context_nohash.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 5051c9363f8c..3fbe36266838 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -62,7 +62,6 @@ static unsigned long *context_map;
 static unsigned long *stale_map[NR_CPUS];
 static struct mm_struct **context_mm;
 static DEFINE_RAW_SPINLOCK(context_lock);
-static bool no_selective_tlbil;
 
 #define CTX_MAP_SIZE	\
 	(sizeof(unsigned long) * (last_context / BITS_PER_LONG + 1))
@@ -279,7 +278,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 			goto stolen;
 		}
 #endif /* CONFIG_SMP */
-		if (no_selective_tlbil)
+		if (IS_ENABLED(CONFIG_PPC_8xx))
 			id = steal_all_contexts();
 		else
 			id = steal_context_up(id);
@@ -440,16 +439,12 @@ void __init mmu_context_init(void)
 	 * present if needed.
 	 *      -- BenH
 	 */
-	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
+	if (mmu_has_feature(MMU_FTR_TYPE_8xx))
 		last_context = 16;
-		no_selective_tlbil = true;
-	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
+	else if (mmu_has_feature(MMU_FTR_TYPE_47x))
 		last_context = 65535;
-		no_selective_tlbil = false;
-	} else {
+	else
 		last_context = 255;
-		no_selective_tlbil = false;
-	}
 
 #ifdef DEBUG_CLAMP_LAST_CONTEXT
 	last_context = DEBUG_CLAMP_LAST_CONTEXT;
-- 
2.13.3
