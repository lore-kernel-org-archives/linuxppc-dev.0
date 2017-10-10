Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBNSW0tFdzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 03:52:10 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9AGpxcd035306
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 12:52:08 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgyyng36y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 12:52:07 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 10 Oct 2017 17:52:05 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9AGq0Tq27525222
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 16:52:02 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9AGq1TV017143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 03:52:01 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, ppaidipe@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Fix IMC initialization crash
Date: Tue, 10 Oct 2017 22:21:55 +0530
Message-Id: <1507654315-1620-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call trace observed with latest firmware, and upstream kernel.

[   14.499938] NIP [c0000000000f318c] init_imc_pmu+0x8c/0xcf0
[   14.499973] LR [c0000000000f33f8] init_imc_pmu+0x2f8/0xcf0
[   14.500007] Call Trace:
[   14.500027] [c000003fed18f710] [c0000000000f33c8] init_imc_pmu+0x2c8/0xcf0 (unreliable)
[   14.500080] [c000003fed18f800] [c0000000000b5ec0] opal_imc_counters_probe+0x300/0x400
[   14.500132] [c000003fed18f900] [c000000000807ef4] platform_drv_probe+0x64/0x110
[   14.500185] [c000003fed18f980] [c000000000804b58] driver_probe_device+0x3d8/0x580
[   14.500236] [c000003fed18fa10] [c000000000804e4c] __driver_attach+0x14c/0x1a0
[   14.500302] [c000003fed18fa90] [c00000000080156c] bus_for_each_dev+0x8c/0xf0
[   14.500353] [c000003fed18fae0] [c000000000803fa4] driver_attach+0x34/0x50
[   14.500397] [c000003fed18fb00] [c000000000803688] bus_add_driver+0x298/0x350
[   14.500449] [c000003fed18fb90] [c00000000080605c] driver_register+0x9c/0x180
[   14.500500] [c000003fed18fc00] [c000000000807dec] __platform_driver_register+0x5c/0x70
[   14.500552] [c000003fed18fc20] [c00000000101cee0] opal_imc_driver_init+0x2c/0x40
[   14.500603] [c000003fed18fc40] [c00000000000d084] do_one_initcall+0x64/0x1d0
[   14.500654] [c000003fed18fd00] [c00000000100434c] kernel_init_freeable+0x280/0x374
[   14.500705] [c000003fed18fdc0] [c00000000000d314] kernel_init+0x24/0x160
[   14.500750] [c000003fed18fe30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
[   14.500799] Instruction dump:
[   14.500827] 4082024c 2f890002 419e054c 2e890003 41960094 2e890001 3ba0ffea 419602d8 
[   14.500884] 419e0290 2f890003 419e02a8 e93e0118 <e8690018> 2fa30000 419e0010 4827ba41 
[   14.500945] ---[ end trace 27b734ad26f1add4 ]---
[   15.908719] 
[   16.908869] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
[   16.908869] 
[   18.125813] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007]

While registering nest imc at init, cpu-hotplug callback `nest_pmu_cpumask_init()`
makes an opal call to stop the engine. And if the OPAL call fails, 
imc_common_cpuhp_mem_free() is invoked to cleanup memory and cpuhotplug setup.

But when cleaning up the attribute group, we were dereferencing the attribute
element array without checking whether the backing element is not NULL. This
causes the kernel panic.

Factor out the memory freeing part from imc_common_cpuhp_mem_free() to handle
the failing case gracefully.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9ccac86..213d976 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -224,8 +224,10 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 
 	/* Allocate memory for attribute group */
 	attr_group = kzalloc(sizeof(*attr_group), GFP_KERNEL);
-	if (!attr_group)
+	if (!attr_group) {
+		kfree(pmu->events);
 		return -ENOMEM;
+	}
 
 	/*
 	 * Allocate memory for attributes.
@@ -1115,6 +1117,15 @@ static void cleanup_all_thread_imc_memory(void)
 	}
 }
 
+/* Function to free the attr_groups which are dynamically allocated */
+static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
+{
+	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
+	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
+	kfree(pmu_ptr);
+	return;
+}
+
 /*
  * Common function to unregister cpu hotplug callback and
  * free the memory.
@@ -1147,10 +1158,6 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 		cleanup_all_thread_imc_memory();
 	}
 
-	/* Only free the attr_groups which are dynamically allocated  */
-	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
-	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
-	kfree(pmu_ptr);
 	return;
 }
 
@@ -1289,17 +1296,19 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 
 	ret = update_pmu_ops(pmu_ptr);
 	if (ret)
-		goto err_free;
+		goto err_free_mem;
 
 	ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
 	if (ret)
-		goto err_free;
+		goto err_free_mem;
 
 	pr_info("%s performance monitor hardware support registered\n",
 							pmu_ptr->pmu.name);
 
 	return 0;
 
+err_free_mem:
+	imc_common_mem_free(pmu_ptr);
 err_free:
 	imc_common_cpuhp_mem_free(pmu_ptr);
 	return ret;
-- 
1.8.3.1
