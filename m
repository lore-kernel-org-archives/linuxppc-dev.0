Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzPqm1jTbzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 00:15:16 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36EDoJi145642
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 10:15:03 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29nq6d884y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 10:15:03 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 19:44:59 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v36EEwDR4980810
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 19:44:58 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v36EEure003445
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 19:44:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 3/3] powerpc/mm: Add comments on vmemmap physical mapping
Date: Thu,  6 Apr 2017 19:44:50 +0530
In-Reply-To: <20170406141450.16060-1-khandual@linux.vnet.ibm.com>
References: <20170406141450.16060-1-khandual@linux.vnet.ibm.com>
Message-Id: <20170406141450.16060-3-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds some explaination on how the vmemmap based struct page layout's
physical mapping is allocated and tracked through linked list. It
also keeps note of a possible race condition.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Previous discussions on this http://patchwork.ozlabs.org/patch/584110/
Michael Ellerman had agreed to take the comments alone.

 arch/powerpc/mm/init_64.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 2a15986..6e5c54d 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -118,8 +118,28 @@ static int __meminit vmemmap_populated(unsigned long start, int page_size)
 	return 0;
 }
 
+/*
+ * vmemmap virtual address space management does not have a traditonal page
+ * table to track which virtual struct pages are backed by physical mapping.
+ * The virtual to physical mappings are tracked in a simple linked list
+ * format. 'vmemmap_list' maintains the entire vmemmap physical mapping at
+ * all times where as the 'next' list maintains the available
+ * vmemmap_backing structures which have been deleted from the
+ * 'vmemmap_global' list during system runtime (memory hotplug remove
+ * operation). The freed 'vmemmap_backing' structures are reused later when
+ * new requests come in without allocating fresh memory. This pointer also
+ * tracks the allocated 'vmemmap_backing' structures as we allocate one
+ * full page memory at a time when we dont have any.
+ */
 struct vmemmap_backing *vmemmap_list;
 static struct vmemmap_backing *next;
+
+/* The same pointer 'next' tracks individual chunks inside the allocated
+ * full page during the boot time and again tracks the freeed nodes during
+ * runtime. It is racy but it does not happen as they are separated by the
+ * boot process. Will create problem if some how we have memory hotplug
+ * operation during boot !!
+ */
 static int num_left;
 static int num_freed;
 
-- 
1.9.3
