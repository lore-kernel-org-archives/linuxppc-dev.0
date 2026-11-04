Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9F606D807
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qXPP6i3r
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKSC16L5Cz2xSF;
	Thu, 05 Nov 2026 01:15:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793801725;
	cv=none; b=P3sOh+FoFm2txKvMP0H5tGgmGE7oMScFhdp4gtsJzUSr/exmsQUjwE54+riugV9ZiwayeoI79kdh+q9fFwi+w5zCU4M43oFR7Ro4RZJlq241gig3crElD5WjMKex0Tw63yGeWH8+Vd+4jhUVnPun5KNYl2My71Ri3+JS+jvvAFT5n0PWrKQINTjr/NICAUl8zCVBT5HS8JkOki540QCoUJPe8MllgHmM9Bq0cPW+RsTQrI469+Uh8YtZG4BXf9Z4PkZzl5kgei9bz6QovgakrOmUaFPtJ27vgLFOb03W9S9mqHMcWx5PnGlF7mJ/7PW6SMQP8wjHxNAYibZeKS32tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793801725; c=relaxed/relaxed;
	bh=P9mDSptb20RgCYQgJTchrS9a945O7hKBF0Rro4rOWTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IDtuO6hr35KaTnE1rM9asaKDGrdPbcjJnpLuMK3oNf62qx3bkJS7R221GGVCBuLcf1bzvpRA58j9qCSt2Jm4C4rbRSpynOTOVOR+Pa07dWn8aznoowEvPXYntYdVnYaFab9h4utYYNLLmej5AMyoK7dTV1u44y16dalBTvL+se+8cl3eKpicXM8ZmAjFhf+vKIo5oJJcRPkP8ns1f+mS0D1Y+JMLTc60uFqAGz6xEFNXdroTCSqPr2qWt3OGj9w7G811Jb5ltJCRCLrAokHBmkHQzO0b5KNSguSPBTCfP4FN6NRDqL2fCBi58fuTaJ1u6Hp5PlvYYzqGivyBND/r9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qXPP6i3r; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qXPP6i3r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKSC067t2z2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 01:15:24 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BiRNs678715;
	Wed, 4 Nov 2026 14:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P9mDSp
	tb20RgCYQgJTchrS9a945O7hKBF0Rro4rOWTo=; b=qXPP6i3ruv2affUoFtrfzq
	HuEW1b5mLRug73tqD2HLfBcI2e4tL8C2A6K83bmxObDpthiIfT6l9fihmm5N/Lhu
	RRVh2qsKECHYHyaSdqC/GdRN70u0G0A4jBQqJ4WdjSRwJOzx/vCYRFz0uoQHGba8
	QM3sFMGThzeX+Lhqu2RCpSABuLRGN+anfs8ZpJwky+YLhbYqi2GKXBdVwjsK5zs/
	HHZCNr4oFbNNu85i5/KehGpRsN/p9kqGbyoieSBWuiuwpzod0floXhmmvle1Xivc
	eRCv2pqNxPQ/zly9QzYOujeA+dylA9j6yLJtHp6ToPzjGm+v1oH+6yuDeJw4cw0g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3ma5k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 14:15:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BaoKh2895009;
	Wed, 4 Nov 2026 14:15:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5avda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 14:15:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4EEwNR50594096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 14:14:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AB312004E;
	Wed,  4 Nov 2026 14:14:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82A382004B;
	Wed,  4 Nov 2026 14:14:50 +0000 (GMT)
Received: from [9.43.115.84] (unknown [9.43.115.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 14:14:50 +0000 (GMT)
Message-ID: <ac2eaf0b-10bf-4f58-8c9a-fd195ff569ea@linux.ibm.com>
Date: Wed, 4 Nov 2026 19:44:48 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/crash: Add only the onlined CPU's node to the
 crash FDT
To: sashiko-reviews@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
References: <20261104053848.1381005-1-vishalc@linux.ibm.com>
 <sashiko-outbox-196696@kernel.org>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <sashiko-outbox-196696@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aeb3de7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4K4iQTxZuiMNCueA7y0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5EBu8d4rtl24D0GkzjZMtIW2Fy7tAs4D
X-Proofpoint-GUID: BvJ_0unD2b_-CIzkNMMFO6a7aeDscCgA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfXzNAodv1jplm9
 oV2nYfQbx7iLWEWCBTnaPJHdKL81AKGTMHGDYS0MA1MD76w5S2izcJgmSVXYNKFRJBULmm9MAlM
 U3dvXWwi+8m9rmqsQIZeeRHXiud9K4btTrXylyAQionqTNjFl3MJ/6uGAxxLT7Xvyp+TQHqf5tw
 WYTEGM5q4j6hiaVmzIRODVUnX3VPIUKdsFj6MqqVwp6yOyEMR27VnH2rO/QM7Y1NFp2m+uLWD+M
 alLRUEEhoIuNBdaz5IjJeCdeTj4Sc3LvAIifhq8W98MTK7L+X0wJgMFIc5A9RCKRd9aq2gqLpHS
 zDPGmcHXwwUMHYmF2iKvhrHaxennXkKDHrUxRB3UH1z+RLD2iemTL3Ut43dvlzpPWaQNxw4Ud40
 dfffU498p3KyYBGniStnm7UZp38RJrdknINF+QnvkvnRm9Z+zWDSmW0MVjkxlxtdNl6utwyyes1
 8myPBhw/R0w8gHzEzKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX0nocnygZC7Mu
 ljblV3Hwesjt9ErB4TPQCN1om438fN+Cv7jLLPJsVp7s45b98eYCOTVtLOgq8USwvfE78ABsL6r
 0N5u643nfODZDAf9vf/XV5+G1jA/kF0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040056
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 04/11/26 11:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] powerpc/crash: detached DLPAR CPU nodes accumulate in crash FDT in update_crash_fdt()
> - [High] powerpc/crash: incomplete CPU subnode left in FDT on fdt_setprop() failure in update_crash_fdt()
> --
>
> commit f91f7035e04400925af984e21ed910579118bae0
> Author: Vishal Chourasia <vishalc@linux.ibm.com>
>
> powerpc/crash: Add only the onlined CPU's node to the crash FDT
>
> This patch updates crash FDT handling on CPU online events to pass the onlined
> CPU number to arch_crash_handle_hotplug_event() and insert only that CPU's
> device node into the crash FDT if it is not already present, rather than
> rebuilding all CPU nodes via update_cpus_node().
>
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index 775895f310379..ca37006bddeae 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
> [ ... ]
>> @@ -584,32 +585,71 @@ static int get_fdt_index(struct kimage *image)
>>   }
>>   
>>   /**
>> - * update_crash_fdt - updates the cpus node of the crash FDT.
>> + * update_crash_fdt - add the node of the onlined CPU to the crash FDT.
>>    *
>>    * @image: a pointer to kexec_crash_image
>> + * @cpu: the CPU that was onlined
>> + *
>> + * The node is added as the first child of /cpus, the same position a node
>> + * attached to the live device tree takes. Nothing is done if the FDT already
>> + * has the node, for example when an offlined CPU comes back.
>>    */
>> -static void update_crash_fdt(struct kimage *image)
>> +static void update_crash_fdt(struct kimage *image, unsigned int cpu)
>>   {
>> +	struct device_node *dn;
>> +	struct property *pp;
>>   	void *fdt;
>> -	int fdt_index;
>> +	int fdt_index, cpus_offset, node_offset;
>> +
>> +	dn = of_get_cpu_node(cpu, NULL);
>> +	if (!dn) {
>> +		pr_err("No device node found for CPU %u\n", cpu);
>> +		return;
>> +	}
>>   
>>   	fdt_index = get_fdt_index(image);
>>   	if (fdt_index < 0) {
>>   		pr_err("Unable to locate FDT segment.\n");
>> -		return;
>> +		goto put;
>>   	}
>>   
>>   	fdt = __va((void *)image->segment[fdt_index].mem);
>>   
>> -	/* Temporarily invalidate the crash image while it is replaced */
>> +	cpus_offset = fdt_path_offset(fdt, "/cpus");
>> +	if (cpus_offset < 0) {
>> +		pr_err("Malformed device tree: error reading /cpus node: %s\n",
>> +		       fdt_strerror(cpus_offset));
>> +		goto put;
>> +	}
>> +
>> +	/* Node already present, e.g. an offlined CPU came back online */
>> +	if (fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >= 0)
>> +		goto put;
>> +
>> +	/* Temporarily invalidate the crash image while it is updated */
>>   	xchg(&kexec_crash_image, NULL);
>>   
>> -	/* update FDT to reflect changes in CPU resources */
>> -	if (update_cpus_node(fdt))
>> -		pr_err("Failed to update crash FDT");
>> +	node_offset = fdt_add_subnode(fdt, cpus_offset, dn->full_name);
> [Severity: High]
> What happens across DLPAR CPU removal and addition when update_crash_fdt()
> only appends missing CPU nodes and never removes detached ones?
>
> On pSeries, dlpar_cpu_remove() offlines the CPU threads (where
> KEXEC_CRASH_HP_REMOVE_CPU is a no-op in arch_crash_handle_hotplug_event()),
> pseries_cpuhp_detach_nodes() detaches the CPU device_node from /cpus in the
> live device tree, and pseries_remove_processor() clears its bits in
> cpu_present_mask so those logical CPU IDs can be reused.
>
> Previously, update_cpus_node() deleted all existing cpu subnodes under /cpus
> in the crash FDT and rebuilt them from the live /cpus tree, purging any
> detached DLPAR CPU nodes. With this change, detached CPU subnodes remain in
> the crash FDT indefinitely:

As mentioned in the previous paragraph, during the CPU offline path,
crash handler doesn't update the crash image and returns early.
update_cpus_node() is not invoked.

>
> 1. kdump_extra_fdt_size_ppc64() in arch/powerpc/kexec/file_load_64.c only
>     budgets extra FDT space for possible_cpu_nodes concurrent CPU nodes:
>
> 	if (image->type == KEXEC_TYPE_CRASH) {
> 		possible_cpu_nodes = num_possible_cpus() / threads_per_core;
> 		if (possible_cpu_nodes > cpu_nodes)
> 			extra_size += (possible_cpu_nodes - cpu_nodes) * cpu_node_size();
> 	}
>
>     When a CPU is DLPAR-removed and a CPU with a different DRC index is
>     DLPAR-added, retaining the detached node alongside the newly added node
>     exceeds possible_cpu_nodes and causes fdt_add_subnode() or fdt_setprop() to
>     fail with -FDT_ERR_NOSPACE.
Behaviour is same as before.
>
> 2. Because detached nodes remain under /cpus in the crash FDT,
>     smp_setup_cpu_maps() in the kdump kernel still iterates over them and
>     assigns logical CPU IDs up to nr_cpu_ids, which can push valid present
>     CPUs past nr_cpu_ids.
>
> 3. If the same DRC index is later DLPAR-added again via
>     dlpar_configure_connector() with updated properties (such as
>     ibm,associativity), fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >= 0
>     matches the stale node and skips updating its properties.
>
>> +	if (node_offset < 0) {
>> +		pr_err("Unable to add %s subnode: %s\n", dn->full_name,
>> +		       fdt_strerror(node_offset));
>> +		goto out;
>> +	}
>>   
>> +	for_each_property_of_node(dn, pp) {
>> +		int ret = fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->length);
>> +
>> +		if (ret < 0) {
>> +			pr_err("Unable to add %s property: %s\n", pp->name,
>> +			       fdt_strerror(ret));
>> +			break;
>> +		}
>> +	}
> [Severity: High]
> If fdt_setprop() fails partway through copying the properties in
> update_crash_fdt(), should node_offset be removed with fdt_del_node(fdt,
> node_offset) before breaking out?
>
> Leaving the partially populated subnode under /cpus has two consequences:
>
> 1. Any subsequent update_crash_fdt() call for sibling SMT threads of the same
>     core (or a later re-online of the CPU) sees
>     fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >= 0 and returns early
>     without populating the missing properties.
>
> 2. If the device_type = "cpu" property was written before fdt_setprop() failed
>     on ibm,ppc-interrupt-server#s and reg, early_init_dt_scan_cpus() in
>     arch/powerpc/kernel/prom.c will match the partial CPU node during kdump
>     boot, get NULL for intserv with len left uninitialized, and dereference
>     intserv[i]:
>
> 	intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
> 	if (!intserv)
> 		intserv = of_get_flat_dt_prop(node, "reg", &len);
>
> 	nthreads = len / sizeof(int);
>
> 	for (i = 0; i < nthreads; i++) {
> 		if (be32_to_cpu(intserv[i]) ==
> 			fdt_boot_cpuid_phys(initial_boot_params)) {

Similar errors on update_cpus_node() can live the crash fdt
inconsistent and result in crash kernel boot hangs.

>

