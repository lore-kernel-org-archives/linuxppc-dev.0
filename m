Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzm2n3FDNzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 13:56:01 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v373rjoQ045214
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 23:55:51 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p20tb4wt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 23:55:51 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 09:25:48 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v373sQ4I16384244
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 09:24:26 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v373tjFW022918
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 09:25:46 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au,
 christophe.leroy@c-s.fr
Subject: [PATCH V4] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
Date: Fri,  7 Apr 2017 09:25:39 +0530
In-Reply-To: <5fb76b92-2988-1207-2bed-814a96e6a51a@linux.vnet.ibm.com>
References: <5fb76b92-2988-1207-2bed-814a96e6a51a@linux.vnet.ibm.com>
Message-Id: <20170407035539.21688-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This just adds user space exported ABI definitions for 2MB, 16MB, 1GB,
16GB non default huge page sizes to be used with mmap() system call.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
These defined values will be used along with MAP_HUGETLB while calling
mmap() system call if the desired HugeTLB page size is not the default
one. Follows similar definitions present in x86.

arch/x86/include/uapi/asm/mman.h:#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
arch/x86/include/uapi/asm/mman.h:#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)

Changes in V4:
- Added defines for 512KB and 8MB HugeTLB page sizes per Christophe

Changes in V3:
- Added comment about how these defines will help create 'flags'
  argument for mmap() system call per Balbir

Changes in V2:
- Added definitions for 2MB and 1GB HugeTLB pages per Aneesh

 arch/powerpc/include/uapi/asm/mman.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index 03c06ba..ebe99c7 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -29,4 +29,18 @@
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
 
+/*
+ * These constant defines should be used for creating the
+ * 'flags' argument (26:31 bit positions) for mmap() system
+ * call should the caller decide to use non default HugeTLB
+ * page size.
+ */
+#define MAP_HUGE_512KB	(19 << MAP_HUGE_SHIFT)	/* 512KB HugeTLB Page */
+#define MAP_HUGE_1MB	(20 << MAP_HUGE_SHIFT)	/* 1MB   HugeTLB Page */
+#define MAP_HUGE_2MB	(21 << MAP_HUGE_SHIFT)	/* 2MB   HugeTLB Page */
+#define MAP_HUGE_8MB	(23 << MAP_HUGE_SHIFT)	/* 8MB   HugeTLB Page */
+#define MAP_HUGE_16MB	(24 << MAP_HUGE_SHIFT)	/* 16MB  HugeTLB Page */
+#define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB   HugeTLB Page */
+#define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB  HugeTLB Page */
+
 #endif /* _UAPI_ASM_POWERPC_MMAN_H */
-- 
1.8.5.2
