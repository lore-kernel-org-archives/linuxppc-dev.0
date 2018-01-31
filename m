Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zX1Cc0vgtzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 11:27:23 +1100 (AEDT)
Date: Wed, 31 Jan 2018 18:25:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powerpc/perf: Add nest IMC PMU support
Message-ID: <20180131152527.GA19851@mwanda>
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

Hello Anju T Sudhakar,

The patch 885dcd709ba9: "powerpc/perf: Add nest IMC PMU support" from
Jul 19, 2017, leads to the following static checker warning:

	arch/powerpc/perf/imc-pmu.c:1393 init_imc_pmu()
	warn: 'pmu_ptr' was already freed.

arch/powerpc/perf/imc-pmu.c
  1317  int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_idx)
  1318  {
  1319          int ret;
  1320  
  1321          ret = imc_mem_init(pmu_ptr, parent, pmu_idx);
  1322          if (ret) {
  1323                  imc_common_mem_free(pmu_ptr);
  1324                  return ret;
  1325          }

Change this to:

		if (ret)
			goto err_free_mpu_ptr;

Or something instead of a direct return.  That's more normal kernel
style.

  1326  
  1327          switch (pmu_ptr->domain) {
  1328          case IMC_DOMAIN_NEST:
  1329                  /*
  1330                  * Nest imc pmu need only one cpu per chip, we initialize the
  1331                  * cpumask for the first nest imc pmu and use the same for the
  1332                  * rest. To handle the cpuhotplug callback unregister, we track
  1333                  * the number of nest pmus in "nest_pmus".
  1334                  */
  1335                  mutex_lock(&nest_init_lock);
  1336                  if (nest_pmus == 0) {
  1337                          ret = init_nest_pmu_ref();
  1338                          if (ret) {
  1339                                  mutex_unlock(&nest_init_lock);
  1340                                  goto err_free;
  1341                          }
  1342                          /* Register for cpu hotplug notification. */
  1343                          ret = nest_pmu_cpumask_init();
  1344                          if (ret) {
  1345                                  mutex_unlock(&nest_init_lock);
  1346                                  kfree(nest_imc_refc);
  1347                                  kfree(per_nest_pmu_arr);
  1348                                  goto err_free;
  1349                          }
  1350                  }
  1351                  nest_pmus++;
  1352                  mutex_unlock(&nest_init_lock);
  1353                  break;
  1354          case IMC_DOMAIN_CORE:
  1355                  ret = core_imc_pmu_cpumask_init();
  1356                  if (ret) {
  1357                          cleanup_all_core_imc_memory();
  1358                          return ret;

These direct returns don't look correct...

  1359                  }
  1360  
  1361                  break;
  1362          case IMC_DOMAIN_THREAD:
  1363                  ret = thread_imc_cpu_init();
  1364                  if (ret) {
  1365                          cleanup_all_thread_imc_memory();
  1366                          return ret;
  1367                  }
  1368  
  1369                  break;
  1370          default:
  1371                  return  -1;     /* Unknown domain */

This one certainly looks like a memory leak.  Plus -1 is -EPERM which is
probably not the correct error code.


  1372          }
  1373  
  1374          ret = update_events_in_group(parent, pmu_ptr);
  1375          if (ret)
  1376                  goto err_free;
  1377  
  1378          ret = update_pmu_ops(pmu_ptr);
  1379          if (ret)
  1380                  goto err_free;
  1381  
  1382          ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
  1383          if (ret)
  1384                  goto err_free;
  1385  
  1386          pr_info("%s performance monitor hardware support registered\n",
  1387                                                          pmu_ptr->pmu.name);
  1388  
  1389          return 0;
  1390  
  1391  err_free:
  1392          imc_common_mem_free(pmu_ptr);
  1393          imc_common_cpuhp_mem_free(pmu_ptr);
                                          ^^^^^^^
This is a use after free, it should be in the reverse order.

err_free_cpuhp:
	imc_common_cpuhp_mem_free(pmu_ptr);
err_free_pmu_ptr:
	imc_common_mem_free(pmu_ptr);

  1394          return ret;
  1395  }

regards,
dan carpenter
