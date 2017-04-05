Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyZ0w1QGCzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 15:20:16 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v355JVbI044610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 01:20:10 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29mr5s4e5u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 01:20:09 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 15:20:06 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v355JtkC49348642
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 15:20:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v355JUWc010883
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 15:19:30 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH V2] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
Date: Wed,  5 Apr 2017 10:49:07 +0530
In-Reply-To: <f7208305-1aad-bc98-87e3-a8a46404c19e@linux.vnet.ibm.com>
References: <f7208305-1aad-bc98-87e3-a8a46404c19e@linux.vnet.ibm.com>
Message-Id: <20170405051907.18192-1-khandual@linux.vnet.ibm.com>
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

Changes in V2:
- Added definitions for 2MB and 1GB HugeTLB pages per Aneesh

 arch/powerpc/include/uapi/asm/mman.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index 03c06ba..3eb788c 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -29,4 +29,9 @@
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
 
+#define MAP_HUGE_2MB	(21 << MAP_HUGE_SHIFT)	/* 2MB HugeTLB Page */
+#define MAP_HUGE_16MB	(24 << MAP_HUGE_SHIFT)	/* 16MB HugeTLB Page */
+#define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB HugeTLB Page */
+#define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB HugeTLB Page */
+
 #endif /* _UAPI_ASM_POWERPC_MMAN_H */
-- 
1.8.5.2
