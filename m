Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08BCC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 06:12:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45B821850
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 06:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45B821850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KPgD6r4yzDqTM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 17:12:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KPbR2NGBzDqcR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 17:08:51 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBJ68mwS088808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 01:08:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pfdtf62cs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 01:08:48 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 19 Dec 2018 06:08:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 19 Dec 2018 06:08:36 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBJ68aDW21954764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 06:08:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0988FA4057;
 Wed, 19 Dec 2018 06:08:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4218DA4040;
 Wed, 19 Dec 2018 06:08:35 +0000 (GMT)
Received: from [9.126.27.138] (unknown [9.126.27.138])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 19 Dec 2018 06:08:35 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] powerpc/perf: Trace imc events detection and
 cpuhotplug
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org
References: <20181214091122.20992-1-anju@linux.vnet.ibm.com>
 <20181214091122.20992-5-anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 19 Dec 2018 11:38:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214091122.20992-5-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18121906-0012-0000-0000-000002DB166B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121906-0013-0000-0000-00002110B20E
Message-Id: <fdd1aad4-022d-9972-92cf-7672f084b46f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-19_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190053
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 14/12/18 2:41 PM, Anju T Sudhakar wrote:
> Patch detects trace-imc events, does memory initilizations for each online
> cpu, and registers cpuhotplug call-backs.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>   arch/powerpc/perf/imc-pmu.c               | 91 +++++++++++++++++++++++
>   arch/powerpc/platforms/powernv/opal-imc.c |  3 +
>   include/linux/cpuhotplug.h                |  1 +
>   3 files changed, 95 insertions(+)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 5ca80545a849..1f09265c8fb0 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -43,6 +43,10 @@ static DEFINE_PER_CPU(u64 *, thread_imc_mem);
>   static struct imc_pmu *thread_imc_pmu;
>   static int thread_imc_mem_size;
>
> +/* Trace IMC data structures */
> +static DEFINE_PER_CPU(u64 *, trace_imc_mem);
> +static int trace_imc_mem_size;
> +
>   static struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
>   {
>   	return container_of(event->pmu, struct imc_pmu, pmu);
> @@ -1068,6 +1072,54 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
>   	imc_event_update(event);
>   }
>
> +/*
> + * Allocate a page of memory for each cpu, and load LDBAR with 0.
> + */
> +static int trace_imc_mem_alloc(int cpu_id, int size)
> +{
> +	u64 *local_mem = per_cpu(trace_imc_mem, cpu_id);
> +	int phys_id = cpu_to_node(cpu_id), rc = 0;
> +
> +	if (!local_mem) {
> +		local_mem = page_address(alloc_pages_node(phys_id,
> +					GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
> +					__GFP_NOWARN, get_order(size)));
> +		if (!local_mem)
> +			return -ENOMEM;
> +		per_cpu(trace_imc_mem, cpu_id) = local_mem;
> +
> +		/* Initialise the counters for trace mode */
> +		rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_TRACE, __pa((void *)local_mem),
> +					    get_hard_smp_processor_id(cpu_id));
> +		if (rc) {
> +			pr_info("IMC:opal init failed for trace imc\n");
> +			return rc;
> +		}
> +	}
> +
> +	mtspr(SPRN_LDBAR, 0);
> +	return 0;
> +}
> +
> +static int ppc_trace_imc_cpu_online(unsigned int cpu)
> +{
> +	return trace_imc_mem_alloc(cpu, trace_imc_mem_size);
> +}
> +
> +static int ppc_trace_imc_cpu_offline(unsigned int cpu)
> +{
> +	mtspr(SPRN_LDBAR, 0);
> +	return 0;
> +}
> +
> +static int trace_imc_cpu_init(void)
> +{
> +	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
> +			  "perf/powerpc/imc_trace:online",
> +			  ppc_trace_imc_cpu_online,
> +			  ppc_trace_imc_cpu_offline);
> +}
> +
>   /* update_pmu_ops : Populate the appropriate operations for "pmu" */
>   static int update_pmu_ops(struct imc_pmu *pmu)
>   {
> @@ -1189,6 +1241,17 @@ static void cleanup_all_thread_imc_memory(void)
>   	}
>   }
>
> +static void cleanup_all_trace_imc_memory(void)
> +{
> +	int i, order = get_order(trace_imc_mem_size);
> +
> +	for_each_online_cpu(i) {
> +		if (per_cpu(trace_imc_mem, i))
> +			free_pages((u64)per_cpu(trace_imc_mem, i), order);
> +
> +	}
> +}
> +
>   /* Function to free the attr_groups which are dynamically allocated */
>   static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
>   {
> @@ -1230,6 +1293,11 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>   		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE);
>   		cleanup_all_thread_imc_memory();
>   	}
> +
> +	if (pmu_ptr->domain == IMC_DOMAIN_TRACE) {
> +		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE);
> +		cleanup_all_trace_imc_memory();
> +	}
>   }
>
>   /*
> @@ -1312,6 +1380,21 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>
>   		thread_imc_pmu = pmu_ptr;
>   		break;
> +	case IMC_DOMAIN_TRACE:
> +		/* Update the pmu name */
> +		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s", s, "_imc");
> +		if (!pmu_ptr->pmu.name)
> +			return -ENOMEM;
> +
> +		trace_imc_mem_size = pmu_ptr->counter_mem_size;
> +		for_each_online_cpu(cpu) {
> +			res = trace_imc_mem_alloc(cpu, trace_imc_mem_size);
> +			if (res) {
> +				cleanup_all_trace_imc_memory();
> +				goto err;
> +			}
> +		}
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1384,6 +1467,14 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   			goto err_free_mem;
>   		}
>
> +		break;
> +	case IMC_DOMAIN_TRACE:
> +		ret = trace_imc_cpu_init();
> +		if (ret) {
> +			cleanup_all_trace_imc_memory();
> +			goto err_free_mem;
> +		}
> +
>   		break;
>   	default:
>   		return  -EINVAL;	/* Unknown domain */
> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index 58a07948c76e..dedc9ae22662 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -284,6 +284,9 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
>   		case IMC_TYPE_THREAD:
>   			domain = IMC_DOMAIN_THREAD;
>   			break;
> +		case IMC_TYPE_TRACE:
> +			domain = IMC_DOMAIN_TRACE;
> +			break;
>   		default:
>   			pr_warn("IMC Unknown Device type \n");
>   			domain = -1;
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index e0cd2baa8380..c471f2de878b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -167,6 +167,7 @@ enum cpuhp_state {
>   	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>   	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
>   	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
> +	CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
>   	CPUHP_AP_WATCHDOG_ONLINE,
>   	CPUHP_AP_WORKQUEUE_ONLINE,
>   	CPUHP_AP_RCUTREE_ONLINE,

