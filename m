Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xD15j0S7PzDrFj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 03:26:16 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6KHNtI1061130
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 13:26:14 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bu01a2b86-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 13:26:13 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 14:26:11 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6KHQ8nk9896234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:26:08 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6KHQ8S1021038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 14:26:08 -0300
From: Victor Aoqui <victora@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com
Cc: victora@br.ibm.com, victora@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com
Subject: [PATCH] powerpc/kernel: Avoid preemption check during
 iommu_range_alloc
Date: Thu, 20 Jul 2017 14:26:06 -0300
Message-Id: <20170720172606.3811-1-victora@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replaced __this_cpu_read function call by raw_cpu_read in
iommu_range_alloc function.
Preemption doesn't need to be disabled since any CPU can safely
use IOMMU pool.

Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 233ca3f..0e49a45 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -208,7 +208,7 @@ static unsigned long iommu_range_alloc(struct device *dev,
 	 * We don't need to disable preemption here because any CPU can
 	 * safely use any IOMMU pool.
 	 */
-	pool_nr = __this_cpu_read(iommu_pool_hash) & (tbl->nr_pools - 1);
+	pool_nr = raw_cpu_read(iommu_pool_hash) & (tbl->nr_pools - 1);
 
 	if (largealloc)
 		pool = &(tbl->large_pool);
-- 
1.8.3.1
