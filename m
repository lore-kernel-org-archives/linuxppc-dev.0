Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7whG2F4hzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 11:53:34 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/mm/radix: Don't iterate all sets when flushing
 the PWC
Date: Fri, 14 Jul 2017 11:52:55 +1000
Message-Id: <20170714015258.7933-1-benh@kernel.crashing.org>
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

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/tlb-radix.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 02e7140..5403419 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -52,12 +52,15 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
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
2.9.4
