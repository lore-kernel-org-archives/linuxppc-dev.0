Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyP706QzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 49/70] powerpc/mm/radix: Update PTCR on secondary CPUs
Date: Fri, 29 Apr 2016 23:26:12 +1000
Message-Id: <1461936393-10131-49-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index e6b53cde676e..faaadeff7c1e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -896,9 +896,13 @@ void __init hash__early_init_mmu(void)
 void hash__early_init_mmu_secondary(void)
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
