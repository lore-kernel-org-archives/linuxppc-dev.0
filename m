Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzPqp2LrQzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 00:15:18 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36EDrPi031600
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 10:15:06 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29n5h78rj1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 10:15:06 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 19:45:00 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v36EEqWL13631542
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 19:44:52 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v36EEuoI003442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 19:44:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 2/3] powerpc/mm: Add comments to the vmemmap layout
Date: Thu,  6 Apr 2017 19:44:49 +0530
In-Reply-To: <20170406141450.16060-1-khandual@linux.vnet.ibm.com>
References: <20170406141450.16060-1-khandual@linux.vnet.ibm.com>
Message-Id: <20170406141450.16060-2-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add some explaination to the layout of vmemmap virtual address
space and how physical page mapping is only used for valid PFNs
present at any point on the system.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Previous discussions around this http://patchwork.ozlabs.org/patch/584111/

 arch/powerpc/mm/pgtable-hash64.c | 75 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 8b85a14..16877f6 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -22,6 +22,81 @@
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
+ * vmemmap is the starting address of the virtual address space where
+ * struct pages are allocated for all possible PFNs present on the system
+ * including holes and bad memory (hence sparse). These virtual struct
+ * pages are stored in sequence in this virtual address space irrespective
+ * of the fact whether the corresponding PFN is valid or not. This achieves
+ * constant relationship between address of struct page and its PFN.
+ *
+ * During boot or memory hotplug operation when a new memory section is
+ * added, physical memory allocation (including hash table bolting) will
+ * be performed for the set of struct pages which are part of the memory
+ * section. This saves memory by not allocating struct pages for PFNs
+ * which are not valid.
+ *
+ *		----------------------------------------------
+ *		| PHYSICAL ALLOCATION OF VIRTUAL STRUCT PAGES|
+ *		----------------------------------------------
+ *
+ *	   f000000000000000                  c000000000000000
+ * vmemmap +--------------+                  +--------------+
+ *  +      |  page struct | +--------------> |  page struct |
+ *  |      +--------------+                  +--------------+
+ *  |      |  page struct | +--------------> |  page struct |
+ *  |      +--------------+ |                +--------------+
+ *  |      |  page struct | +       +------> |  page struct |
+ *  |      +--------------+         |        +--------------+
+ *  |      |  page struct |         |   +--> |  page struct |
+ *  |      +--------------+         |   |    +--------------+
+ *  |      |  page struct |         |   |
+ *  |      +--------------+         |   |
+ *  |      |  page struct |         |   |
+ *  |      +--------------+         |   |
+ *  |      |  page struct |         |   |
+ *  |      +--------------+         |   |
+ *  |      |  page struct |         |   |
+ *  |      +--------------+         |   |
+ *  |      |  page struct | +-------+   |
+ *  |      +--------------+             |
+ *  |      |  page struct | +-----------+
+ *  |      +--------------+
+ *  |      |  page struct | No mapping
+ *  |      +--------------+
+ *  |      |  page struct | No mapping
+ *  v      +--------------+
+ *
+ *		-----------------------------------------
+ *		| RELATION BETWEEN STRUCT PAGES AND PFNS|
+ *		-----------------------------------------
+ *
+ * vmemmap +--------------+                 +---------------+
+ *  +      |  page struct | +-------------> |      PFN      |
+ *  |      +--------------+                 +---------------+
+ *  |      |  page struct | +-------------> |      PFN      |
+ *  |      +--------------+                 +---------------+
+ *  |      |  page struct | +-------------> |      PFN      |
+ *  |      +--------------+                 +---------------+
+ *  |      |  page struct | +-------------> |      PFN      |
+ *  |      +--------------+                 +---------------+
+ *  |      |              |
+ *  |      +--------------+
+ *  |      |              |
+ *  |      +--------------+
+ *  |      |              |
+ *  |      +--------------+                 +---------------+
+ *  |      |  page struct | +-------------> |      PFN      |
+ *  |      +--------------+                 +---------------+
+ *  |      |              |
+ *  |      +--------------+
+ *  |      |              |
+ *  |      +--------------+                 +---------------+
+ *  |      |  page struct | +-------------> |      PFN      |
+ *  |      +--------------+                 +---------------+
+ *  |      |  page struct | +-------------> |      PFN      |
+ *  v      +--------------+                 +---------------+
+ */
+/*
  * On hash-based CPUs, the vmemmap is bolted in the hash table.
  *
  */
-- 
1.9.3
