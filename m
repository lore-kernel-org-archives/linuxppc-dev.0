Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BBC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 09:57:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3083720675
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 09:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3083720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k14y1vJjzDqFY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 19:57:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=anju@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k0tr1wvPzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 19:48:51 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3G9iefD050520
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 05:48:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwb8v469c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 05:48:49 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 16 Apr 2019 10:48:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 10:48:47 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3G9mkne60752024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 09:48:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 281984C040;
 Tue, 16 Apr 2019 09:48:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10F094C04E;
 Tue, 16 Apr 2019 09:48:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.144.43])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 09:48:44 +0000 (GMT)
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v4 4/5] powerpc/perf: Trace imc events detection and cpuhotplug
Date: Tue, 16 Apr 2019 15:18:30 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190416094831.7264-1-anju@linux.vnet.ibm.com>
References: <20190416094831.7264-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041609-0028-0000-0000-000003615980
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041609-0029-0000-0000-000024209028
Message-Id: <20190416094831.7264-5-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160067
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, anju@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Patch detects trace-imc events, does memory initilizations for each online
cpu, and registers cpuhotplug call-backs.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c               | 104 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-imc.c |   3 +
 include/linux/cpuhotplug.h                |   1 +
 3 files changed, 108 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 7fe258e17dfe..3fe0222885bc 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -43,6 +43,11 @@ static DEFINE_PER_CPU(u64 *, thread_imc_mem);
 static struct imc_pmu *thread_imc_pmu;
 static int thread_imc_mem_size;
 
+/* Trace IMC data structures */
+static DEFINE_PER_CPU(u64 *, trace_imc_mem);
+static struct imc_pmu_ref *trace_imc_refc;
+static int trace_imc_mem_size;
+
 static struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 {
 	return container_of(event->pmu, struct imc_pmu, pmu);
@@ -1050,6 +1055,59 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
 	imc_event_update(event);
 }
 
+/*
+ * Allocate a page of memory for each cpu, and load LDBAR with 0.
+ */
+static int trace_imc_mem_alloc(int cpu_id, int size)
+{
+	u64 *local_mem = per_cpu(trace_imc_mem, cpu_id);
+	int phys_id = cpu_to_node(cpu_id), rc = 0;
+	int core_id = (cpu_id / threads_per_core);
+
+	if (!local_mem) {
+		local_mem = page_address(alloc_pages_node(phys_id,
+					GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
+					__GFP_NOWARN, get_order(size)));
+		if (!local_mem)
+			return -ENOMEM;
+		per_cpu(trace_imc_mem, cpu_id) = local_mem;
+
+		/* Initialise the counters for trace mode */
+		rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_TRACE, __pa((void *)local_mem),
+					    get_hard_smp_processor_id(cpu_id));
+		if (rc) {
+			pr_info("IMC:opal init failed for trace imc\n");
+			return rc;
+		}
+	}
+
+	/* Init the mutex, if not already */
+	trace_imc_refc[core_id].id = core_id;
+	mutex_init(&trace_imc_refc[core_id].lock);
+
+	mtspr(SPRN_LDBAR, 0);
+	return 0;
+}
+
+static int ppc_trace_imc_cpu_online(unsigned int cpu)
+{
+	return trace_imc_mem_alloc(cpu, trace_imc_mem_size);
+}
+
+static int ppc_trace_imc_cpu_offline(unsigned int cpu)
+{
+	mtspr(SPRN_LDBAR, 0);
+	return 0;
+}
+
+static int trace_imc_cpu_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
+			  "perf/powerpc/imc_trace:online",
+			  ppc_trace_imc_cpu_online,
+			  ppc_trace_imc_cpu_offline);
+}
+
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
 static int update_pmu_ops(struct imc_pmu *pmu)
 {
@@ -1172,6 +1230,18 @@ static void cleanup_all_thread_imc_memory(void)
 	}
 }
 
+static void cleanup_all_trace_imc_memory(void)
+{
+	int i, order = get_order(trace_imc_mem_size);
+
+	for_each_online_cpu(i) {
+		if (per_cpu(trace_imc_mem, i))
+			free_pages((u64)per_cpu(trace_imc_mem, i), order);
+
+	}
+	kfree(trace_imc_refc);
+}
+
 /* Function to free the attr_groups which are dynamically allocated */
 static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
 {
@@ -1213,6 +1283,11 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE);
 		cleanup_all_thread_imc_memory();
 	}
+
+	if (pmu_ptr->domain == IMC_DOMAIN_TRACE) {
+		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE);
+		cleanup_all_trace_imc_memory();
+	}
 }
 
 /*
@@ -1295,6 +1370,27 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 
 		thread_imc_pmu = pmu_ptr;
 		break;
+	case IMC_DOMAIN_TRACE:
+		/* Update the pmu name */
+		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s", s, "_imc");
+		if (!pmu_ptr->pmu.name)
+			return -ENOMEM;
+
+		nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
+		trace_imc_refc = kcalloc(nr_cores, sizeof(struct imc_pmu_ref),
+								GFP_KERNEL);
+		if (!trace_imc_refc)
+			return -ENOMEM;
+
+		trace_imc_mem_size = pmu_ptr->counter_mem_size;
+		for_each_online_cpu(cpu) {
+			res = trace_imc_mem_alloc(cpu, trace_imc_mem_size);
+			if (res) {
+				cleanup_all_trace_imc_memory();
+				goto err;
+			}
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1367,6 +1463,14 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 			goto err_free_mem;
 		}
 
+		break;
+	case IMC_DOMAIN_TRACE:
+		ret = trace_imc_cpu_init();
+		if (ret) {
+			cleanup_all_trace_imc_memory();
+			goto err_free_mem;
+		}
+
 		break;
 	default:
 		return  -EINVAL;	/* Unknown domain */
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 58a07948c76e..dedc9ae22662 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -284,6 +284,9 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 		case IMC_TYPE_THREAD:
 			domain = IMC_DOMAIN_THREAD;
 			break;
+		case IMC_TYPE_TRACE:
+			domain = IMC_DOMAIN_TRACE;
+			break;
 		default:
 			pr_warn("IMC Unknown Device type \n");
 			domain = -1;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e78281d07b70..c3413d9b8348 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -170,6 +170,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
+	CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
-- 
2.17.2

