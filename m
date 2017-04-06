Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzPqk6RSCzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 00:15:14 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36EDnSx036106
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 10:15:04 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29nph22bt9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 10:15:04 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 19:45:00 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v36EEv2C20316324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 19:44:57 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v36EEunG003436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 19:44:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 1/3] powerpc/mm: Rename variable to reflect start address of a
 section
Date: Thu,  6 Apr 2017 19:44:48 +0530
Message-Id: <20170406141450.16060-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit (16a05bff1: powerpc: start loop at section start of
start in vmemmap_populated()) reused 'start' variable to compute
the starting address of the memory section where the given address
belongs. Then the same variable is used for iterating over starting
address of all memory sections before reaching the 'end' address.
Renaming it as 'section_start' makes the logic more clear.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Previous discussions on this http://patchwork.ozlabs.org/patch/584103/

 arch/powerpc/mm/init_64.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index c22f207..2a15986 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -104,11 +104,15 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
  */
 static int __meminit vmemmap_populated(unsigned long start, int page_size)
 {
-	unsigned long end = start + page_size;
-	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
+	unsigned long end, section_start;
 
-	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
-		if (pfn_valid(page_to_pfn((struct page *)start)))
+	end = start + page_size;
+	section_start = (unsigned long)(pfn_to_page
+					(vmemmap_section_start(start)));
+
+	for (; section_start < end; section_start
+				+= (PAGES_PER_SECTION * sizeof(struct page)))
+		if (pfn_valid(page_to_pfn((struct page *)section_start)))
 			return 1;
 
 	return 0;
-- 
1.9.3
