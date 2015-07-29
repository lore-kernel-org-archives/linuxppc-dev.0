Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56F731A0DB0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:31 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D0A6140DC0
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:30 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:28 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5555F394007B
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7A9rY46137404
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A6iR001240
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 6/8] powerpc/prom: Simplify the logic while fetching SLB size
Date: Wed, 29 Jul 2015 12:40:03 +0530
Message-Id: <1438153805-31828-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch just simplifies the existing code logic while fetching
the SLB size property from the device tree. This also changes the
function name from check_cpu_slb_size to init_mmu_slb_size as
it just initializes the mmu_slb_size value.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 8b888b1..4bb43c0 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -218,22 +218,18 @@ static void __init check_cpu_pa_features(unsigned long node)
 }
 
 #ifdef CONFIG_PPC_STD_MMU_64
-static void __init check_cpu_slb_size(unsigned long node)
+static void __init init_mmu_slb_size(unsigned long node)
 {
 	const __be32 *slb_size_ptr;
 
-	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL);
-	if (slb_size_ptr != NULL) {
-		mmu_slb_size = be32_to_cpup(slb_size_ptr);
-		return;
-	}
-	slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
-	if (slb_size_ptr != NULL) {
+	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL) ? :
+			of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
+
+	if (slb_size_ptr)
 		mmu_slb_size = be32_to_cpup(slb_size_ptr);
-	}
 }
 #else
-#define check_cpu_slb_size(node) do { } while(0)
+#define init_mmu_slb_size(node) do { } while(0)
 #endif
 
 static struct feature_property {
@@ -380,7 +376,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 
 	check_cpu_feature_properties(node);
 	check_cpu_pa_features(node);
-	check_cpu_slb_size(node);
+	init_mmu_slb_size(node);
 
 #ifdef CONFIG_PPC64
 	if (nthreads > 1)
-- 
2.1.0
