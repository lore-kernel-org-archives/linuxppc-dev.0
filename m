Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C242EC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:35:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA9F2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA9F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPzR2PR8zDqLG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:35:47 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPSb3smXzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:12:31 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3FA9Cis145809
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 06:12:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rvp6h596b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 06:12:28 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 15 Apr 2019 11:12:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Apr 2019 11:12:24 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3FACNIE51904662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2019 10:12:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2014C5205A;
 Mon, 15 Apr 2019 10:12:23 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.161.180])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E163652057;
 Mon, 15 Apr 2019 10:12:21 +0000 (GMT)
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v4 5/5] powerpc/perf: Trace imc PMU functions
Date: Mon, 15 Apr 2019 15:42:04 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
References: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041510-0016-0000-0000-0000026EEC34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041510-0017-0000-0000-000032CB3033
Message-Id: <20190415101204.15125-6-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-15_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150072
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

Add PMU functions to support trace-imc.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 183 ++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 3fe0222885bc..3f433cc96b18 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1108,6 +1108,182 @@ static int trace_imc_cpu_init(void)
 			  ppc_trace_imc_cpu_offline);
 }
 
+static u64 get_trace_imc_event_base_addr(void)
+{
+	return (u64)per_cpu(trace_imc_mem, smp_processor_id());
+}
+
+/*
+ * Function to parse trace-imc data obtained
+ * and to prepare the perf sample.
+ */
+static int trace_imc_prepare_sample(struct trace_imc_data *mem,
+				    struct perf_sample_data *data,
+				    u64 *prev_tb,
+				    struct perf_event_header *header,
+				    struct perf_event *event)
+{
+	/* Sanity checks for a valid record */
+	if (be64_to_cpu(READ_ONCE(mem->tb1)) > *prev_tb)
+		*prev_tb = be64_to_cpu(READ_ONCE(mem->tb1));
+	else
+		return -EINVAL;
+
+	if ((be64_to_cpu(READ_ONCE(mem->tb1)) & IMC_TRACE_RECORD_TB1_MASK) !=
+			 be64_to_cpu(READ_ONCE(mem->tb2)))
+		return -EINVAL;
+
+	/* Prepare perf sample */
+	data->ip =  be64_to_cpu(READ_ONCE(mem->ip));
+	data->period = event->hw.last_period;
+
+	header->type = PERF_RECORD_SAMPLE;
+	header->size = sizeof(*header) + event->header_size;
+	header->misc = 0;
+
+	if (is_kernel_addr(data->ip))
+		header->misc |= PERF_RECORD_MISC_KERNEL;
+	else
+		header->misc |= PERF_RECORD_MISC_USER;
+
+	perf_event_header__init_id(header, data, event);
+
+	return 0;
+}
+
+static void dump_trace_imc_data(struct perf_event *event)
+{
+	struct trace_imc_data *mem;
+	int i, ret;
+	u64 prev_tb = 0;
+
+	mem = (struct trace_imc_data *)get_trace_imc_event_base_addr();
+	for (i = 0; i < (trace_imc_mem_size / sizeof(struct trace_imc_data));
+		i++, mem++) {
+		struct perf_sample_data data;
+		struct perf_event_header header;
+
+		ret = trace_imc_prepare_sample(mem, &data, &prev_tb, &header, event);
+		if (ret) /* Exit, if not a valid record */
+			break;
+		else {
+			/* If this is a valid record, create the sample */
+			struct perf_output_handle handle;
+
+			if (perf_output_begin(&handle, event, header.size))
+				return;
+
+			perf_output_sample(&handle, &header, &data, event);
+			perf_output_end(&handle);
+		}
+	}
+}
+
+static int trace_imc_event_add(struct perf_event *event, int flags)
+{
+	int core_id = smp_processor_id() / threads_per_core;
+	struct imc_pmu_ref *ref = NULL;
+	u64 local_mem, ldbar_value;
+
+	/* Set trace-imc bit in ldbar and load ldbar with per-thread memory address */
+	local_mem = get_trace_imc_event_base_addr();
+	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | TRACE_IMC_ENABLE;
+
+	if (core_imc_refc)
+		ref = &core_imc_refc[core_id];
+	if (!ref) {
+		/* If core-imc is not enabled, use trace-imc reference count */
+		if (trace_imc_refc)
+			ref = &trace_imc_refc[core_id];
+		if (!ref)
+			return -EINVAL;
+	}
+	mtspr(SPRN_LDBAR, ldbar_value);
+	mutex_lock(&ref->lock);
+	if (ref->refc == 0) {
+		if (opal_imc_counters_start(OPAL_IMC_COUNTERS_TRACE,
+				get_hard_smp_processor_id(smp_processor_id()))) {
+			mutex_unlock(&ref->lock);
+			pr_err("trace-imc: Unable to start the counters for core %d\n", core_id);
+			mtspr(SPRN_LDBAR, 0);
+			return -EINVAL;
+		}
+	}
+	++ref->refc;
+	mutex_unlock(&ref->lock);
+
+	return 0;
+}
+
+static void trace_imc_event_read(struct perf_event *event)
+{
+	return;
+}
+
+static void trace_imc_event_stop(struct perf_event *event, int flags)
+{
+	u64 local_mem = get_trace_imc_event_base_addr();
+	dump_trace_imc_data(event);
+	memset((void *)local_mem, 0, sizeof(u64));
+}
+
+static void trace_imc_event_start(struct perf_event *event, int flags)
+{
+	return;
+}
+
+static void trace_imc_event_del(struct perf_event *event, int flags)
+{
+	int core_id = smp_processor_id() / threads_per_core;
+	struct imc_pmu_ref *ref = NULL;
+
+	if (core_imc_refc)
+		ref = &core_imc_refc[core_id];
+	if (!ref) {
+		/* If core-imc is not enabled, use trace-imc reference count */
+		if (trace_imc_refc)
+			ref = &trace_imc_refc[core_id];
+		if (!ref)
+			return;
+	}
+	mtspr(SPRN_LDBAR, 0);
+	mutex_lock(&ref->lock);
+	ref->refc--;
+	if (ref->refc == 0) {
+		if (opal_imc_counters_stop(OPAL_IMC_COUNTERS_TRACE,
+				get_hard_smp_processor_id(smp_processor_id()))) {
+			mutex_unlock(&ref->lock);
+			pr_err("trace-imc: Unable to stop the counters for core %d\n", core_id);
+			return;
+		}
+	} else if (ref->refc < 0) {
+		ref->refc = 0;
+	}
+	mutex_unlock(&ref->lock);
+	trace_imc_event_stop(event, flags);
+}
+
+static int trace_imc_event_init(struct perf_event *event)
+{
+	struct task_struct *target;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* Return if this is a couting event */
+	if (event->attr.sample_period == 0)
+		return -ENOENT;
+
+	event->hw.idx = -1;
+	target = event->hw.target;
+
+	event->pmu->task_ctx_nr = perf_hw_context;
+	return 0;
+}
+
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
 static int update_pmu_ops(struct imc_pmu *pmu)
 {
@@ -1138,6 +1314,13 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		pmu->pmu.cancel_txn = thread_imc_pmu_cancel_txn;
 		pmu->pmu.commit_txn = thread_imc_pmu_commit_txn;
 		break;
+	case IMC_DOMAIN_TRACE:
+		pmu->pmu.event_init = trace_imc_event_init;
+		pmu->pmu.add = trace_imc_event_add;
+		pmu->pmu.del = trace_imc_event_del;
+		pmu->pmu.start = trace_imc_event_start;
+		pmu->pmu.stop = trace_imc_event_stop;
+		pmu->pmu.read = trace_imc_event_read;
 	default:
 		break;
 	}
-- 
2.17.2

