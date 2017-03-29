Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtZJS4z6BzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 04:19:51 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2THIXAA002639
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 13:19:48 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29gdadvarg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 13:19:48 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 29 Mar 2017 18:19:47 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: Add missing global TLBI if cxl is active
Date: Wed, 29 Mar 2017 19:19:42 +0200
Message-Id: <20170329171942.14267-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4c6d9acce1f4 ("powerpc/mm: Add hooks for cxl") converted local
TLBIs to global if the cxl driver is active. It is necessary because
the CAPP snoops invalidations to forward them to the PSL on the cxl
adapter.
However one path was apparently forgotten. native_flush_hash_range()
still sends local TLBIs, as found out the hard way recently.

This patch fixes it by following the same logic as previously: if the
cxl driver is active, the local TLBIs are 'upgraded' to global.

Fixes: 4c6d9acce1f4 ("powerpc/mm: Add hooks for cxl")
Cc: stable@vger.kernel.org
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index cc33260..65bb8f3 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -638,6 +638,10 @@ static void native_flush_hash_range(unsigned long number, int local)
 	unsigned long psize = batch->psize;
 	int ssize = batch->ssize;
 	int i;
+	unsigned int use_local;
+
+	use_local = local && mmu_has_feature(MMU_FTR_TLBIEL) &&
+		mmu_psize_defs[psize].tlbiel && !cxl_ctx_in_use();
 
 	local_irq_save(flags);
 
@@ -667,8 +671,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		} pte_iterate_hashed_end();
 	}
 
-	if (mmu_has_feature(MMU_FTR_TLBIEL) &&
-	    mmu_psize_defs[psize].tlbiel && local) {
+	if (use_local) {
 		asm volatile("ptesync":::"memory");
 		for (i = 0; i < number; i++) {
 			vpn = batch->vpn[i];
-- 
2.9.3
