Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkQ0T2YJPzDqZ9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:37:45 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GAXoix049211
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:37:33 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297nt7abat-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:37:33 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:37:32 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 05/14] powerpc/mm/slice: Move slice_mask struct definition
 to slice.c
Date: Thu, 16 Mar 2017 16:07:04 +0530
In-Reply-To: <1489660633-24125-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489660633-24125-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489660633-24125-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This structure definition need not be in a header since this is used only by
slice.c file. So move it to slice.c. This also allow us to use SLICE_NUM_HIGH
instead of 64.

I also switch the low_slices type to u64 from u16. This doesn't have an impact
on size of struct due to padding added with u16 type. This helps in using
bitmap printing function for printing slice mask.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/page_64.h | 11 -----------
 arch/powerpc/mm/slice.c            | 10 +++++++++-
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index bd55ff751938..c4d9654bd637 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -99,17 +99,6 @@ extern u64 ppc64_pft_size;
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
 #ifndef __ASSEMBLY__
-/*
- * One bit per slice. We have lower slices which cover 256MB segments
- * upto 4G range. That gets us 16 low slices. For the rest we track slices
- * in 1TB size.
- * 64 below is actually SLICE_NUM_HIGH to fixup complie errros
- */
-struct slice_mask {
-	u16 low_slices;
-	DECLARE_BITMAP(high_slices, 64);
-};
-
 struct mm_struct;
 
 extern unsigned long slice_get_unmapped_area(unsigned long addr,
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 2546204856f5..14e9fb525172 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -37,7 +37,15 @@
 #include <asm/hugetlb.h>
 
 static DEFINE_SPINLOCK(slice_convert_lock);
-
+/*
+ * One bit per slice. We have lower slices which cover 256MB segments
+ * upto 4G range. That gets us 16 low slices. For the rest we track slices
+ * in 1TB size.
+ */
+struct slice_mask {
+	u64 low_slices;
+	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
+};
 
 #ifdef DEBUG
 int _slice_debug = 1;
-- 
2.7.4
