Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xD0Tz60vszDrFh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 02:58:47 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6KGrcp3003592
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:58:45 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btwac9svd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:58:45 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 13:58:43 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6KGsFK019988726
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 13:54:16 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6KGwe1O020097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 13:58:40 -0300
From: Victor Aoqui <victora@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com
Cc: victora@br.ibm.com, victora@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc/mm: Implemented default_hugepagesz verification
 for powerpc
Date: Thu, 20 Jul 2017 13:58:38 -0300
Message-Id: <20170720165838.3549-1-victora@linux.vnet.ibm.com>
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

Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
---
v2:

- Renamed default_hugepage_setup_sz function to hugetlb_default_size_setup;

- Added powerpc string to error message.

 arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e1bf5ca..3a142fe 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -780,6 +780,21 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
+static int __init hugetlb_default_size_setup(char *str)
+{
+	unsigned long long size;
+
+	size = memparse(str, &str);
+
+	if (add_huge_page_size(size) != 0) {
+		hugetlb_bad_size();
+		pr_err("Invalid powerpc default huge page size specified(%llu)\n", size);
+	}
+
+	return 1;
+}
+__setup("default_hugepagesz=", hugetlb_default_size_setup);
+
 struct kmem_cache *hugepte_cache;
 static int __init hugetlbpage_init(void)
 {
-- 
1.8.3.1
