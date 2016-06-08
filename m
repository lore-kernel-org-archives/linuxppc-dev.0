Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNW1NBDzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:50 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:26:49 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 07/10] powerpc/hash: Use the correct ppp mask when updating
 hpte
Date: Wed,  8 Jun 2016 19:55:55 +0530
Message-Id: <1465395958-21349-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit: e58e87adc8bf9 ("powerpc/mm: Update _PAGE_KERNEL_RO") we
now use all the three PPP bits. The top bit is now used to have a
PPP value of 0b110 which will be mapped to kernel read only. When
updating the hpte entry use right mask such that we update the
63rd bit (top 'P' bit) too.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 1 +
 arch/powerpc/mm/hash_native_64.c              | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 290157e8d5b2..74839f24f412 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -88,6 +88,7 @@
 #define HPTE_R_RPN_SHIFT	12
 #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
 #define HPTE_R_PP		ASM_CONST(0x0000000000000003)
+#define HPTE_R_PPP		ASM_CONST(0x8000000000000003)
 #define HPTE_R_N		ASM_CONST(0x0000000000000004)
 #define HPTE_R_G		ASM_CONST(0x0000000000000008)
 #define HPTE_R_M		ASM_CONST(0x0000000000000010)
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index d873f6507f72..e37916cbc18d 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -316,8 +316,8 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 			DBG_LOW(" -> hit\n");
 			/* Update the HPTE */
 			hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) &
-						~(HPTE_R_PP | HPTE_R_N)) |
-					       (newpp & (HPTE_R_PP | HPTE_R_N |
+						~(HPTE_R_PPP | HPTE_R_N)) |
+					       (newpp & (HPTE_R_PPP | HPTE_R_N |
 							 HPTE_R_C)));
 		}
 		native_unlock_hpte(hptep);
@@ -385,8 +385,8 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 
 	/* Update the HPTE */
 	hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) &
-			~(HPTE_R_PP | HPTE_R_N)) |
-		(newpp & (HPTE_R_PP | HPTE_R_N)));
+				~(HPTE_R_PPP | HPTE_R_N)) |
+			       (newpp & (HPTE_R_PPP | HPTE_R_N)));
 	/*
 	 * Ensure it is out of the tlb too. Bolted entries base and
 	 * actual page size will be same.
-- 
2.7.4
