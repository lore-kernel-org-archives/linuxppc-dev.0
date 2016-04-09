Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmLQ4WQNzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:16:30 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:16:28 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5E45219D8045
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:04:18 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396GPq745154434
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 23:16:25 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396GP2v003691
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 00:16:25 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 46/68] powerpc/mm/radix: Update secondary PTCR
Date: Sat,  9 Apr 2016 11:43:42 +0530
Message-Id: <1460182444-2468-47-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8dfc6ae85d4a..be5d123b3f61 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -892,9 +892,13 @@ void __init hlearly_init_mmu(void)
 void hlearly_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
-	if (!firmware_has_feature(FW_FEATURE_LPAR))
-		mtspr(SPRN_SDR1, _SDR1);
-
+	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+			mtspr(SPRN_SDR1, _SDR1);
+		else
+			mtspr(SPRN_PTCR,
+			      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+	}
 	/* Initialize SLB */
 	slb_initialize();
 }
-- 
2.5.0
