Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXHt35bFlzDr8n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 22:28:11 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w11BP5Ni068694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Feb 2018 06:28:07 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fv1m49868-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Feb 2018 06:28:06 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 1 Feb 2018 11:28:04 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w11BS18G43909296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Feb 2018 11:28:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68D2EA4053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 11:21:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 100F3A404D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 11:21:32 +0000 (GMT)
Received: from [9.124.31.150] (unknown [9.124.31.150])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 11:21:31 +0000 (GMT)
Subject: Re: [bug report] powerpc/perf: Add nest IMC PMU support
To: linuxppc-dev@lists.ozlabs.org
References: <20180131152527.GA19851@mwanda>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 16:57:59 +0530
MIME-Version: 1.0
In-Reply-To: <20180131152527.GA19851@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bb3f5ee5-7329-1662-c30e-43287f7a71bc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 31 January 2018 08:55 PM, Dan Carpenter wrote:
> Hello Anju T Sudhakar,
>
> The patch 885dcd709ba9: "powerpc/perf: Add nest IMC PMU support" from
> Jul 19, 2017, leads to the following static checker warning:
>
> 	arch/powerpc/perf/imc-pmu.c:1393 init_imc_pmu()
> 	warn: 'pmu_ptr' was already freed.
>
> arch/powerpc/perf/imc-pmu.c
>    1317  int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_idx)
>    1318  {
>    1319          int ret;
>    1320
>    1321          ret = imc_mem_init(pmu_ptr, parent, pmu_idx);
>    1322          if (ret) {
>    1323                  imc_common_mem_free(pmu_ptr);
>    1324                  return ret;
>    1325          }
>
> Change this to:
>
> 		if (ret)
> 			goto err_free_mpu_ptr;
>
> Or something instead of a direct return.  That's more normal kernel
> style.
>
>    1326
>    1327          switch (pmu_ptr->domain) {
>    1328          case IMC_DOMAIN_NEST:
>    1329                  /*
>    1330                  * Nest imc pmu need only one cpu per chip, we initialize the
>    1331                  * cpumask for the first nest imc pmu and use the same for the
>    1332                  * rest. To handle the cpuhotplug callback unregister, we track
>    1333                  * the number of nest pmus in "nest_pmus".
>    1334                  */
>    1335                  mutex_lock(&nest_init_lock);
>    1336                  if (nest_pmus == 0) {
>    1337                          ret = init_nest_pmu_ref();
>    1338                          if (ret) {
>    1339                                  mutex_unlock(&nest_init_lock);
>    1340                                  goto err_free;
>    1341                          }
>    1342                          /* Register for cpu hotplug notification. */
>    1343                          ret = nest_pmu_cpumask_init();
>    1344                          if (ret) {
>    1345                                  mutex_unlock(&nest_init_lock);
>    1346                                  kfree(nest_imc_refc);
>    1347                                  kfree(per_nest_pmu_arr);
>    1348                                  goto err_free;
>    1349                          }
>    1350                  }
>    1351                  nest_pmus++;
>    1352                  mutex_unlock(&nest_init_lock);
>    1353                  break;
>    1354          case IMC_DOMAIN_CORE:
>    1355                  ret = core_imc_pmu_cpumask_init();
>    1356                  if (ret) {
>    1357                          cleanup_all_core_imc_memory();
>    1358                          return ret;
>
> These direct returns don't look correct...
>
>    1359                  }
>    1360
>    1361                  break;
>    1362          case IMC_DOMAIN_THREAD:
>    1363                  ret = thread_imc_cpu_init();
>    1364                  if (ret) {
>    1365                          cleanup_all_thread_imc_memory();
>    1366                          return ret;
>    1367                  }
>    1368
>    1369                  break;
>    1370          default:
>    1371                  return  -1;     /* Unknown domain */
>
> This one certainly looks like a memory leak.  Plus -1 is -EPERM which is
> probably not the correct error code.
>
>
>    1372          }
>    1373
>    1374          ret = update_events_in_group(parent, pmu_ptr);
>    1375          if (ret)
>    1376                  goto err_free;
>    1377
>    1378          ret = update_pmu_ops(pmu_ptr);
>    1379          if (ret)
>    1380                  goto err_free;
>    1381
>    1382          ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
>    1383          if (ret)
>    1384                  goto err_free;
>    1385
>    1386          pr_info("%s performance monitor hardware support registered\n",
>    1387                                                          pmu_ptr->pmu.name);
>    1388
>    1389          return 0;
>    1390
>    1391  err_free:
>    1392          imc_common_mem_free(pmu_ptr);
>    1393          imc_common_cpuhp_mem_free(pmu_ptr);
>                       

Yes, this doesn't looks right. Recent patch had re-factored this code.
     ed8e443feee2b  ('powerpc/perf: IMC code cleanup with some code 
refactoring')

My bad. Should have looked at it more closely. I will look at this and 
will rework it.

Thanks for reviewing.
Maddy

>                       ^^^^^^^
> This is a use after free, it should be in the reverse order.
>
> err_free_cpuhp:
> 	imc_common_cpuhp_mem_free(pmu_ptr);
> err_free_pmu_ptr:
> 	imc_common_mem_free(pmu_ptr);
>
>    1394          return ret;
>    1395  }
>
> regards,
> dan carpenter
>
