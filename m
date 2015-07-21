Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B43E01A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:59:08 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D293F140E1A
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:29:04 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 22401E0044
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:33:01 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6wwj457999468
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L6wwED007412
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [RFC 6/8] powerpc/prom: Simplify the logic while fetching SLB size
Date: Tue, 21 Jul 2015 12:28:44 +0530
Message-Id: <1437461926-8908-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>

This patch just simplifies the existing code logic while fetching
the SLB size property from the device tree.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 8b888b1..f6168e2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -223,14 +223,12 @@ static void __init check_cpu_slb_size(unsigned long node)
 	const __be32 *slb_size_ptr;
 
 	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL);
-	if (slb_size_ptr != NULL) {
-		mmu_slb_size = be32_to_cpup(slb_size_ptr);
-		return;
-	}
-	slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
-	if (slb_size_ptr != NULL) {
-		mmu_slb_size = be32_to_cpup(slb_size_ptr);
+	if (!slb_size_ptr) {
+		slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
+		if (!slb_size_ptr)
+			return;
 	}
+	mmu_slb_size = be32_to_cpup(slb_size_ptr);
 }
 #else
 #define check_cpu_slb_size(node) do { } while(0)
-- 
2.1.0
