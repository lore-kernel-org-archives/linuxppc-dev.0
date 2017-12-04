Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqv8W5yCbzDvJ4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 16:49:31 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB45mvSs100376
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Dec 2017 00:49:29 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2en0htr0g5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 00:49:28 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 4 Dec 2017 05:49:27 -0000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH V2] powerpc/mm: Invalidate subpage_prot() system call on radix
 platforms
Date: Mon,  4 Dec 2017 11:19:22 +0530
Message-Id: <20171204054922.16075-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix enabled platforms don't support subpage_prot() system calls. But
at present the system call goes through without an error and fails
later on while validating expected subpage accesses. Lets not allow
the system call on powerpc radix platforms to begin with to prevent
this confusion in user space.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V2:

Now it returns -ENOENT error instead as per Michael Ellerman.

 arch/powerpc/mm/subpage-prot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 781532d..f14a07c 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -195,6 +195,9 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 	unsigned long next, limit;
 	int err;
 
+	if (radix_enabled())
+		return -ENOENT;
+
 	/* Check parameters */
 	if ((addr & ~PAGE_MASK) || (len & ~PAGE_MASK) ||
 	    addr >= mm->task_size || len >= mm->task_size ||
-- 
1.8.3.1
