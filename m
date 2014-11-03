Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A32D31A015B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 01:52:17 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Nov 2014 00:52:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BD0A52CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 01:52:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA3EsAuM32702628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Nov 2014 01:54:10 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA3EqCJ3006094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Nov 2014 01:52:13 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 1/2] powerpc/mm: Check for matching hpte without taking hpte
 lock
Date: Mon,  3 Nov 2014 20:21:34 +0530
Message-Id: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With smaller hash page table config, we would end up in situation
where we would be replacing hash page table slot frequently. In
such config, we will find the hpte to be not matching, and we
can do that check without holding the hpte lock. We need to
recheck the hpte again after holding lock.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index ae4962a06476..83c6bb12be14 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -294,8 +294,6 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	DBG_LOW("    update(vpn=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
 		vpn, want_v & HPTE_V_AVPN, slot, newpp);
 
-	native_lock_hpte(hptep);
-
 	hpte_v = be64_to_cpu(hptep->v);
 	/*
 	 * We need to invalidate the TLB always because hpte_remove doesn't do
@@ -308,16 +306,24 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 		DBG_LOW(" -> miss\n");
 		ret = -1;
 	} else {
-		DBG_LOW(" -> hit\n");
-		/* Update the HPTE */
-		hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) & ~(HPTE_R_PP | HPTE_R_N)) |
-			(newpp & (HPTE_R_PP | HPTE_R_N | HPTE_R_C)));
+		native_lock_hpte(hptep);
+		/* recheck with locks held */
+		hpte_v = be64_to_cpu(hptep->v);
+		if (unlikely(!HPTE_V_COMPARE(hpte_v, want_v) ||
+			     !(hpte_v & HPTE_V_VALID))) {
+			ret = -1;
+		} else {
+			DBG_LOW(" -> hit\n");
+			/* Update the HPTE */
+			hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) &
+						~(HPTE_R_PP | HPTE_R_N)) |
+					       (newpp & (HPTE_R_PP | HPTE_R_N |
+							 HPTE_R_C)));
+		}
+		native_unlock_hpte(hptep);
 	}
-	native_unlock_hpte(hptep);
-
 	/* Ensure it is out of the tlb too. */
 	tlbie(vpn, bpsize, apsize, ssize, local);
-
 	return ret;
 }
 
-- 
2.1.0
