Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGrQs45RZzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:05:25 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vGrQr5t14z9ryk
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 13:05:24 +1100 (AEDT)
Message-ID: <1486346716.4850.82.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/mm/radix: Update ERAT flushes when invalidating TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 06 Feb 2017 13:05:16 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Three tiny changes to the ERAT flushing logic: First don't make
it depend on DD1. It hasn't been decided yet but we might run
DD2 in a mode that also requires explicit flushes for performance
reasons so make it unconditional. We also add a missing isync, and
finally remove the flush from _tlbiel_va as it is only necessary
for congruence-class invalidations (PID, LPID and full TLB), not
targetted invalidations.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/tlb-radix.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 61b7911..e0c8162 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -50,9 +50,7 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
 		__tlbiel_pid(pid, set, ric);
 	}
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
-	return;
+	asm volatile(PPC_INVALIDATE_ERAT ";isync" : : :"memory");
 }
 
 static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
@@ -85,8 +83,6 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
 }
 
 static inline void _tlbie_va(unsigned long va, unsigned long pid,
