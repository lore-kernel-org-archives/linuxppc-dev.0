Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCgqN3976zDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 23:27:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
	anton@samba.org
Subject: [PATCH v2 2/2] powerpc/mm/radix: Optimise tlbiel flush all case
Date: Wed, 26 Apr 2017 23:27:20 +1000
Message-Id: <1493213240-5260-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1493213240-5260-1-git-send-email-mpe@ellerman.id.au>
References: <1493213240-5260-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_tlbiel_pid() is called with a ric (Radix Invalidation Control) argument of
either RIC_FLUSH_TLB or RIC_FLUSH_ALL.

RIC_FLUSH_ALL says to invalidate the entire TLB and the Page Walk Cache (PWC).

To flush the whole TLB, we have to iterate over each set (congruence class) of
the TLB. Currently we do that and pass RIC_FLUSH_ALL each time. That is not
incorrect but it means we flush the PWC 128 times, when once would suffice.

Fix it by doing the first flush with the ric value we're passed, and then if it
was RIC_FLUSH_ALL, we downgrade it to RIC_FLUSH_TLB, because we know we have
just flushed the PWC and don't need to do it again.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Split out of combined patch, tweak logic, rewrite change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/tlb-radix.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index ae2e799822bd..5e17c4e873a5 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -46,9 +46,20 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 	int set;
 
 	asm volatile("ptesync": : :"memory");
-	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
+
+	/*
+	 * Flush the first set of the TLB, and if we're doing a RIC_FLUSH_ALL,
+	 * also flush the entire Page Walk Cache.
+	 */
+	__tlbiel_pid(pid, 0, ric);
+
+	if (ric == RIC_FLUSH_ALL)
+		/* For the remaining sets, just flush the TLB */
+		ric = RIC_FLUSH_TLB;
+
+	for (set = 1; set < POWER9_TLB_SETS_RADIX ; set++)
 		__tlbiel_pid(pid, set, ric);
-	}
+
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
-- 
2.7.4
