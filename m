Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4MH4ND0zDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:49:47 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 1/4] powerpc/mm/radix: Improve _tlbiel_pid to be usable for
 PWC flushes
Date: Wed, 19 Jul 2017 14:49:04 +1000
Message-Id: <20170719044907.21703-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PWC flush only needs a single set call, just like the
full (RIC=2) flush.

This will allow us to get rid of the dedicated _tlbiel_pwc()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/tlb-radix.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 744e0164ecf5..2f2967a2db93 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -54,12 +54,15 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 	 */
 	__tlbiel_pid(pid, 0, ric);
 
-	if (ric == RIC_FLUSH_ALL)
-		/* For the remaining sets, just flush the TLB */
-		ric = RIC_FLUSH_TLB;
+	/* For PWC, only one flush is needed */
+	if (ric == RIC_FLUSH_PWC) {
+		asm volatile("ptesync": : :"memory");
+		return;
+	}
 
+	/* For the remaining sets, just flush the TLB */
 	for (set = 1; set < POWER9_TLB_SETS_RADIX ; set++)
-		__tlbiel_pid(pid, set, ric);
+		__tlbiel_pid(pid, set, RIC_FLUSH_TLB);
 
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
-- 
2.13.3
