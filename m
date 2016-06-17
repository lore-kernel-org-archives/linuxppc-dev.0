Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWRCn0VXSzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 02:53:37 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5HGmqsM132925
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 12:53:35 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kqskf9da-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 12:53:34 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 17:53:32 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 63ED817D8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 17:54:45 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5HGrUbc62849106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 16:53:30 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5HGrUYU022071
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 10:53:30 -0600
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH] powerpc/mm: Prevent unlikely crash in copro_calculate_slb()
Date: Fri, 17 Jun 2016 18:53:28 +0200
Message-Id: <1466182408-17884-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a cxl adapter faults on an invalid address for a kernel context, we
may enter copro_calculate_slb() with a NULL mm pointer (kernel
context) and an effective address which looks like a user
address. Which will cause a crash when dereferencing mm. It is clearly
an AFU bug, but there's no reason to crash either. So return an error,
so that cxl can ack the interrupt with an address error.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org>
---
 arch/powerpc/mm/copro_fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 6527882..ddfd274 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -106,6 +106,8 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 	switch (REGION_ID(ea)) {
 	case USER_REGION_ID:
 		pr_devel("%s: 0x%llx -- USER_REGION_ID\n", __func__, ea);
+		if (mm == NULL)
+			return 1;
 		psize = get_slice_psize(mm, ea);
 		ssize = user_segment_size(ea);
 		vsid = get_vsid(mm->context.id, ea, ssize);
-- 
2.7.4
