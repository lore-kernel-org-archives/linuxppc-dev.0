Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTbh80SyDzDr46
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 06:09:43 +1000 (AEST)
Date: Fri, 11 Aug 2017 23:05:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] powerpc/perf: double unlock bug in imc_common_cpuhp_mem_free()
Message-ID: <20170811200541.qlxcpp3og33sdki3@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a typo so we call unlock instead of lock.

Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I also don't understand how the &nest_imc_refc[node_id].lock works.  Why
can't we use ref->lock everywhere?  They seem equivalent, and my static
checker complains if we call the same lock different names.

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 46cd912af060..52017f6eafd9 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1124,7 +1124,7 @@ static void cleanup_all_thread_imc_memory(void)
 static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 {
 	if (pmu_ptr->domain == IMC_DOMAIN_NEST) {
-		mutex_unlock(&nest_init_lock);
+		mutex_lock(&nest_init_lock);
 		if (nest_pmus == 1) {
 			cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
 			kfree(nest_imc_refc);
