Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1dS30gLpzDr4C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 06:06:10 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v63K3d2S093884
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 16:06:09 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bf27bg7s5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 16:06:08 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 17:06:05 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v63K1iut30212168
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 17:01:44 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v63K636H024983
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 17:06:03 -0300
From: Victor Aoqui <victora@br.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Cc: victora@br.ibm.com, victora@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Implemented default_hugepagesz verification for
 powerpc
Date: Mon,  3 Jul 2017 17:05:59 -0300
Message-Id: <20170703200559.3743-1-victora@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implemented default hugepage size verification (default_hugepagesz=)
in order to allow allocation of defined number of pages (hugepages=)
only for supported hugepage sizes.

Signed-off-by: Victor Aoqui <victora@br.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a4f33de..464e72e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -797,6 +797,21 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
+static int __init default_hugepage_setup_sz(char *str)
+{
+        unsigned long long size;
+
+        size = memparse(str, &str);
+
+        if (add_huge_page_size(size) != 0) {
+                hugetlb_bad_size();
+                pr_err("Invalid default huge page size specified(%llu)\n", size);
+        }
+
+        return 1;
+}
+__setup("default_hugepagesz=", default_hugepage_setup_sz);
+
 struct kmem_cache *hugepte_cache;
 static int __init hugetlbpage_init(void)
 {
-- 
1.8.3.1
