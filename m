Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405ntN2wHDzF1gm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 22:40:44 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LBdCvt058652
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 07:40:41 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gup8ms9rh-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 07:40:41 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 11:40:35 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/perf: Fix kernel address leak to userspace via
 BHRB buffer
Date: Wed, 21 Mar 2018 17:10:25 +0530
In-Reply-To: <1521632426-30770-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1521632426-30770-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1521632426-30770-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current Branch History Rolling Buffer (BHRB) code does
not check for any privilege levels before updating the data
from BHRB. This leaks kernel addresses to userspace even when
profiling only with userspace privileges. Add proper checks
to prevent it.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog -v1:
 - Added comment.

 arch/powerpc/perf/core-book3s.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index f89bbd54ecec..37d24c22557d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -457,6 +457,16 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 				/* invalid entry */
 				continue;
 
+			/*
+			 * BHRB rolling buffer could very much contain the kernel
+			 * addresses at this point. Check the privileges before
+			 * exporting it to userspace (avoid exposure of regions
+			 * where we could have speculative execution)
+			 */
+			if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
+				is_kernel_addr(addr))
+				continue;
+
 			/* Branches are read most recent first (ie. mfbhrb 0 is
 			 * the most recent branch).
 			 * There are two types of valid entries:
-- 
2.7.4
