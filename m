Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Ndg0vbbzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:55:02 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:24:59 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9FC45394006B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7sotP48824322
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7slej031632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:49 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 4/6] powerpc/mm/hash: Compute the segment size correctly for
 ISA 3.0
Date: Thu, 19 May 2016 13:24:30 +0530
Message-Id: <1463644472-10158-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerISA 3.0 encodes the segment size in the second half of hash page
table entry. Update hpte_decode accordingly.

Fixes: 50de596de8be ("powerpc/mm/hash: Add support for Power9 Hash")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index d873f6507f72..c9715fc99d68 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -550,7 +550,10 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 		}
 	}
 	/* This works for all page sizes, and for 256M and 1T segments */
-	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		*ssize = hpte_r >> HPTE_R_3_0_SSIZE_SHIFT;
+	else
+		*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 	shift = mmu_psize_defs[size].shift;
 
 	avpn = (HPTE_V_AVPN_VAL(hpte_v) & ~mmu_psize_defs[size].avpnm);
-- 
2.7.4
