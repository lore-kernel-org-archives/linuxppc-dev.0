Return-Path: <bsingharora@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2CmM0vmTzDsRD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:52:34 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8R9nLCi026004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 05:52:32 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d848hgckt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 05:52:32 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bsingharora@gmail.com>;
 Wed, 27 Sep 2017 19:52:30 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8R9pCA235258384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:51:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8R9pCcR015064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:51:12 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 1/2] powerpc/strict_rwx: quirks for STRICT_RWX patches
Date: Wed, 27 Sep 2017 19:51:10 +1000
Message-Id: <20170927095111.10626-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch disables STRICT_RWX for power9 DD1 machines
where due to some limitations with the way we do tlb
updates, we clear the TLB entry of the text that's doing
the update to kernel text and that does lead to a
crash.

Fixes: 7614ff3 ("powerpc/mm/radix: Implement STRICT_RWX/mark_rodata_ro() for Radix")

Cc: stable@vger.kernel.org

Reported-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 39c252b..c2a2b46 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -169,6 +169,18 @@ void radix__mark_rodata_ro(void)
 {
 	unsigned long start, end;
 
+	/*
+	 * mark_rodata_ro() will mark itself as !writable at some point
+	 * due to workaround in radix__pte_update(), we'll end up with
+	 * an invalid pte and the system will crash quite severly.
+	 * The alternatives are quite cumbersome and leaving out
+	 * the page containing the flush code is not very nice.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		pr_warn("Warning: Unable to mark rodata read only on P9 DD1\n");
+		return;
+	}
+
 	start = (unsigned long)_stext;
 	end = (unsigned long)__init_begin;
 
-- 
2.9.5
