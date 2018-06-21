Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BFLV6BK3zF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 18:32:18 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L8Sefo031510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 04:32:14 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jr89ygt4a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 04:32:14 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 21 Jun 2018 04:32:13 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/mm: Increase MAX_PHYSMEM_BITS to 128TB with
 SPARSEMEM_VMEMMAP config
Date: Thu, 21 Jun 2018 14:01:58 +0530
In-Reply-To: <20180621083158.30849-1-aneesh.kumar@linux.ibm.com>
References: <20180621083158.30849-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180621083158.30849-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We do this only with VMEMMAP config so that our page_to_[nid/section] etc are not
impacted.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/sparsemem.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index bc66712bdc3c..28f5dae25db6 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -6,13 +6,20 @@
 #ifdef CONFIG_SPARSEMEM
 /*
  * SECTION_SIZE_BITS		2^N: how big each section will be
- * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
 #define SECTION_SIZE_BITS       24
-
-#define MAX_PHYSADDR_BITS       46
+/*
+ * If we store section details in page->flags we can't increase the MAX_PHYSMEM_BITS
+ * if we increase SECTIONS_WIDTH we will not store node details in page->flags and
+ * page_to_nid does a page->section->node lookup
+ * Hence only increase for VMEMMAP.
+ */
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define MAX_PHYSMEM_BITS        47
+#else
 #define MAX_PHYSMEM_BITS        46
+#endif
 
 #endif /* CONFIG_SPARSEMEM */
 
-- 
2.17.1
