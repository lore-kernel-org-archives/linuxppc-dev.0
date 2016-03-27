Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqr22HhPzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:10 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:26:08 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B59BEC90041
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:26:00 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8Q4vE33161386
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:26:04 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8KlP2022579
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:20:48 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 44/65] powerpc/mm/radix: Update secondary PTCR
Date: Sun, 27 Mar 2016 13:53:52 +0530
Message-Id: <1459067053-10835-44-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
