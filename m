Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynRrq2ycczDrq3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 17:12:26 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAU6B0fg110059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 01:12:23 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ej712k6ts-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 01:12:22 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 30 Nov 2017 06:12:20 -0000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Invalidate subpage_prot() system call on radix
 platforms
Date: Thu, 30 Nov 2017 11:42:15 +0530
Message-Id: <20171130061215.22861-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix enabled platforms don't support subpage_prot() system calls. But
at present the system calls goes through without an error and fails
later on while validating expected subpage accesses. Lets not allow
the system call on powerpc radix platforms to begin with to prevent
this confusion in user space.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/subpage-prot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 781532d..4005468 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -195,6 +195,9 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 	unsigned long next, limit;
 	int err;
 
+	if (radix_enabled())
+		return -ENOSYS;
+
 	/* Check parameters */
 	if ((addr & ~PAGE_MASK) || (len & ~PAGE_MASK) ||
 	    addr >= mm->task_size || len >= mm->task_size ||
-- 
1.8.5.2
