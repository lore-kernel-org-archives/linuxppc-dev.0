Return-Path: <linuxppc-dev+bounces-25704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651EEC5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 23:28:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJrXm56r1z2yys;
	Tue, 11 Aug 2026 09:28:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786404504;
	cv=none; b=gE6rNu3Lt3FB/9zwLjZqcLxTZz2GOuaR2j85tnOMiRl/rCREgoat65edAFyEO1HeystSp6pCOmqSy16EXzTCShy/Oqj/LtPrrGoOykvU84bDgs+VDOXShpWq1+cIRhTKwUOOwSYQxMsf8NG5Ts7gm1MYcGvrfDeLu5NerroMwqazB50yNe5JV5RTfMNrUy8laGVhTwZ4epoBgbEpTuztVUxYS/cjiNBpit0XbqeaJwzhsB4eFlxXivVi6eXzePouAdZtfIsPeYeevl5HvrzEMqbtonH5zfM6kL85wtj4YeA0eueRL88UfS/C0Ma21VIRrRUhXEe/I/TPWZjiWQMZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786404504; c=relaxed/relaxed;
	bh=+1AUm74WXk8O2QZ7zbWEo7XkrdgcMJrHZzUOUDxErVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAD8vq1yKqoyPEgeRQ1xEtNSJPDLu3UTWSoayWpyaXC7VYk1KgI880wPX83na2mfr1lLvztQh8KEMDDKxV8Ecps6Vx0be+t6HJ+WaVLdNyimlp1Mchgz+AKCQb33hPVRojTm5DN7hLI91utUtLdbomeSkRxa0d3p/t8yvs9AGs77BQHFnFBqcsO5kIZR419XLOtkJbgOGM5d4mj8J0XlGDfPzo3d5kjQMSkmoFvmWlyBO40YSjWNS1BHA1miqy6SChYnUC9x9HXJXfLb0P/EgKLShQvL56eziZGXqLf05rLeR484O5ZDkUN2dISMbQU1GczhhzsVWHgHHdJlKl0rqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ONY5e8QU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ONY5e8QU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJrXk3q10z2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 09:28:22 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1saS1869486;
	Mon, 10 Aug 2026 23:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+1AUm7
	4WXk8O2QZ7zbWEo7XkrdgcMJrHZzUOUDxErVU=; b=ONY5e8QUgPvTVJIOvheVA/
	A/WQVlrQC28dgwHxhVc8lafBKj+XzE+YMuzd+qgNIWacmxsY66mrNcQ+a/8ABh/x
	rjaPj9n1MHnpOKsUvk15Y3BpFMDO1E+Bu8XFrD0IZ2MEjrpmXGq4Hmzu3rsGeHW/
	tHY19BD4Nswvq6RHOWq5hQuxo8BHjlOu87a1suKtWqS2qK++C5InmRbZjqW3nO2W
	zkV+hwizDlRqHIwdEz082/3fdJGaFLzUqBMZuEB2Lul4gHu++0up8jZ8R9OwdkGN
	sYPfsLMA8hXPirIZsLiG7iP5Jbhkp+1mwP2u8S8F08bELRP6wWPIFDxH/Ppb3hmg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23kbrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:28:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ANBWgh021151;
	Mon, 10 Aug 2026 23:28:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gxr6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:28:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ANRR7R64684428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 23:27:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C3AB58058;
	Mon, 10 Aug 2026 23:28:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDAE858059;
	Mon, 10 Aug 2026 23:28:01 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 23:28:01 +0000 (GMT)
Message-ID: <c6514989-f397-4fdc-a769-80cf5ff698f0@linux.ibm.com>
Date: Mon, 10 Aug 2026 16:28:00 -0700
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/14] ibmveth: Enable multi-queue RX receive
 path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <f49057799577b7c3c1444910b56a6662a610a20a.1785457143.git.mmc@linux.ibm.com>
 <20260806183708.3175604-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183708.3175604-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7a5e87 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=rs9HJqA_zBob2guIO60A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE5NSBTYWx0ZWRfXwbHOoaOJT314
 Ma+pKQ3oAHBwuOR7ApeaN6OiTqdn4JZQ/eA6qI1GUU8/mEAQjLXhiaFvymaK8Etm2NhBgsrkcSo
 TcYQSoYllpP91yrTV+5NB3nhOSuEpHxZxUISj4ZhEhqFF+Kn/8myRTrqZSz7YOVRpELucMIGOUB
 q6uDLgTomFvteOOhh46hnUUHGuFb8Ga/rSvaL/CqzTdES2d1DLCaxTP/EMKDG/3lQh+WLqr/s8j
 EWFI2aTKtWT5uyntpMBtV/u7IYWeIk/7zzSaqsuzOZOp5cWpVyJUqzAz4LcJg9VWHRGRDjcLiWP
 +U1LlR9yZwyII9Sr3idJEiPoVTdUHV9O5q5VgEIs1efgcXxJYvBeLFAevgaFLFR5W12Q8ZgYxAp
 ds2Z4E9FvBVaQ6+6QXwANjzqVfLF+MUrPU8y/rfDyfWt5zj8iRLzIKNbK5/DLU520HHU32EFEJZ
 oc88vPw3R2yyks7/4gg==
X-Proofpoint-ORIG-GUID: JwAAFfDyQkEk69D04xyrivqqIFiwbZc0
X-Proofpoint-GUID: N3JwxPCgriuLvEIPpWYARt7En6zttYJC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE5NSBTYWx0ZWRfXxiAH9GAdUGP3
 BouFbxECcGPttB47wVJ9qjPaAEsIpZek5VuE2Dx1futu1WAPXcu9AWHr22viG+YryUecPcI3Vh2
 c/Y7mcfpwvtKhHqF6DzN8Q0NY4CZ+so=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100195


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
Hi Jakub,

Thanks for the review.
> ---
> ibmveth: Enable multi-queue RX receive path
>
> This patch turns on the multi-queue RX path: probe latches multi_queue and
> num_rx_queues from the H_ILLAN_ATTRIBUTES MQ bit, subordinate queues are
> registered with H_REG_LOGICAL_LAN_QUEUE, and open replenishes every queue
> before setup_rx_interrupts() unmasks PHYP. A few questions below on the
> new ordering, the CMO entitlement accounting and the probe unwind.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index cb93659fc0576..4ad7ced3c6083 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -97,7 +97,17 @@ static struct ibmveth_stat ibmveth_stats[] = {
>>   	{ "fw_enabled_ipv6_csum", IBMVETH_STAT_OFF(fw_ipv6_csum_support) },
>>   	{ "tx_large_packets", IBMVETH_STAT_OFF(tx_large_packets) },
>>   	{ "rx_large_packets", IBMVETH_STAT_OFF(rx_large_packets) },
>> -	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) }
>> +	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) },
>> +	{ "hcall_reg_lan_queue", IBMVETH_STAT_OFF(hcall_stats.reg_lan_queue) },
>> +	{ "hcall_reg_lan", IBMVETH_STAT_OFF(hcall_stats.reg_lan) },
>> +	{ "hcall_add_bufs_queue",
>> +	  IBMVETH_STAT_OFF(hcall_stats.add_bufs_queue) },
>> +	{ "hcall_add_bufs", IBMVETH_STAT_OFF(hcall_stats.add_bufs) },
>> +	{ "hcall_add_buf", IBMVETH_STAT_OFF(hcall_stats.add_buf) },
>> +	{ "hcall_free_lan_queue",
>> +	  IBMVETH_STAT_OFF(hcall_stats.free_lan_queue) },
>> +	{ "hcall_free_lan", IBMVETH_STAT_OFF(hcall_stats.free_lan) },
>> +	{ "hcall_send_lan", IBMVETH_STAT_OFF(hcall_stats.send_lan) },
>>   };
> [Severity: Low]
> Should hcall_send_lan be exported through ethtool -S?  It is incremented
> once per successfully transmitted packet on the ibmveth_send() success
> path:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_send() {
> 	...
> 	adapter->hcall_stats.send_lan++;
> 	return 0;
> }
>
> That makes it the same value as the standard rtnl_link_stats64 tx_packets
> counter reported by ndo_get_stats64 / ip -s link, and
> Documentation/networking/statistics.rst asks that counters with a standard
> uAPI not be duplicated as driver-private ethtool -S strings.  These
> strings become uAPI once merged.
>
> The commit message subject is "Enable multi-queue RX receive path" and
> does not mention that eight new statistics strings are being added.  Could
> the stats additions be split out or at least described?
They do bump on the same success path. The useful distinction here is
role, not packet meaning: `hcall_send_lan` is a PHYP hcall/debug
counter, while `tx_packets` is the standard stack TX success counter.

I’m planning to move the `hcall_*` string-table growth out of P09 so
this patch does not expand ethtool -S at the same time as the MQ RX
enablement change.
>> @@ -429,12 +439,64 @@ ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
>>   	return ibmveth_toggle_irq(adapter, queue_index, true);
>>   }
>>   
>> +/**
>> + * ibmveth_dispose_subordinate_irq_mapping - Drop one subordinate virq mapping
>> + * @adapter: ibmveth adapter structure
>> + * @queue_idx: RX queue index (1..N)
>> + *
>> + * Subordinate queues get mappings from irq_create_mapping() during PHYP
>> + * registration. Queue 0 uses netdev->irq from device tree and is left alone.
>> + *
>> + * Bound against IBMVETH_MAX_RX_QUEUES, not num_rx_queues: scale-down and
>> + * scale-up fail paths dispose queues that are no longer in the published
>> + * live set but still own a virq in queue_irq[]. The bulk helper still
>> + * iterates only 1..num_rx_queues-1 for close/open-fail cleanup.
> [Severity: Low]
> This isn't a bug, but do the "scale-down and scale-up fail paths" exist at
> this commit?  ibmveth_resize_rx_queues_incremental() and
> ibmveth_setup_single_rx_interrupt() arrive in a later patch, and the only
> caller here is the bulk helper bounded by num_rx_queues.
>
> The same applies to the comment added above ibmveth_get_strings() in this
> patch:
>
> 	/*
> 	 * Sum per-queue counters for rare ethtool reads. Do not write adapter
> 	 * globals on the hot path (ibmvnic-style); with qstats allocated for the
> 	 * adapter lifetime, these sums remain meaningful across ifdown/up.
> 	 */
>
> ibmveth_get_strings() only memcpy()s string tables here, and no
> rx_qstats/tx_qstats members exist in struct ibmveth_adapter until the
> following patch.  Could both comments move to the patches that add the
> code they describe, so the intermediate commits read correctly?
Yes. Those comments should move with first use at restack, so the
intermediate commits read correctly.
>> +	for (i = 0; i < num; i++)
>> +		napi_enable(&adapter->napi[i]);
>> +
>> +	if (adapter->multi_queue && num > 1) {
>> +		for (i = 0; i < num; i++) {
>> +			rc = ibmveth_enable_irq(adapter, i);
>> +			if (rc) {
>> +				netdev_err(netdev,
>> +					   "Failed to enable IRQ for queue %d, rc=%d\n",
>> +					   i, rc);
>> +				while (--i >= 0)
>> +					ibmveth_disable_irq(adapter, i);
>> +				rc = -EIO;
>> +				goto err_disable_napi;
>> +			}
>> +		}
>> +	}
>> +
>>   	return 0;
>>   
>> +err_disable_napi:
>> +	/* PHYP unmask was rolled back above; disable NAPI before free_irq */
>> +	for (i = 0; i < num; i++)
>> +		napi_disable(&adapter->napi[i]);
>> +	for (i = 0; i < num; i++) {
>> +		if (adapter->queue_irq[i])
>> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
>> +	}
>> +	goto err_dispose_mappings;
> [Severity: Low]
> Can the rollback loop above be undone by an in-flight poll?  Queues 0..i-1
> were already unmasked, so a poll may be running when
> ibmveth_enable_irq() fails for queue i:
>
> ibmveth_poll() {
> 	...
> 	if (!napi_complete_done(napi, frames_processed))
> 		goto out;
> 	...
> 	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
> }
>
> There is no synchronize_irq() between the while (--i >= 0)
> ibmveth_disable_irq() loop and napi_disable(), so a poll that completes
> after the mask re-enables PHYP delivery.  napi_disable() waits for the
> poll but does not undo that re-enable, and the following free_irq() plus
> ibmveth_dispose_subordinate_irq_mappings() then leave the hypervisor
> source enabled for a hwirq whose Linux mapping is gone.
>
> The scale-down path added later does disable_irq() followed by
> synchronize_irq() for exactly this reason.  Should this path do the same?
>
> [ ... ]
Yes. The enable-IRQ rollback path should synchronize before tearing down
NAPI and freeing the IRQs.

I’m planning to make that failure path follow the same
disable/synchronize/disable-NAPI pattern as the teardown paths, so a
poll cannot re-enable delivery after rollback has started.

>> @@ -834,9 +914,15 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>    */
>>   static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>>   {
>> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
>> +	int i;
>>   
>> -	adapter->rx_no_buffer = be64_to_cpup(p);
>> +	adapter->rx_no_buffer = 0;
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
>> +		u64 drops = be64_to_cpup(p);
>> +
>> +		adapter->rx_no_buffer += drops;
>> +	}
>>   }
> [Severity: High]
> Is this cross-queue aggregation safe against the RX queue resize path?
> The only lock held here is the caller's own per-queue lock:
>
> ibmveth_replenish_task(adapter, queue_index) {
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
> 	...
> 	ibmveth_update_rx_no_buffer(adapter);
> 	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
> }
>
> That lock does not cover other queues' buffer_list_addr[] entries, nor
> num_rx_queues.  The ethtool -L scale-down path added later in the series
> publishes the new count and then frees the pages:
>
> 	adapter->num_rx_queues = new_count;
>
> 	for (i = new_count; i < old_count; i++) {
> 		...
> 		ibmveth_free_single_rx_queue(adapter, i);   /* free_page() + NULL */
> 	}
>
> If a surviving queue's poll already loaded the older, larger
> num_rx_queues, can this loop dereference NULL + 4096 - 8, or read a page
> that was just freed, from softirq context?  A READ_ONCE() of the count
> plus a NULL check, or serializing the aggregation against the resize
> path, would make this explicit.
>
> Separately, two concurrent polls on different queues both execute
> adapter->rx_no_buffer = 0 followed by += drops on the same field.  Can
> that lose increments and expose a transient 0 through
> rx_no_buffer / ethtool -S?
Yes. That cross-queue `rx_no_buffer` aggregation is not safe once queue
resize enters the picture, and even without resize it is the wrong shape
for concurrent polls.

I’m planning to make that helper queue-local and NULL-safe, so it only
touches the current queue’s buffer-list slot and keeps the absolute PHYP
drop count in that queue’s stats.

Then the adapter-visible `rx_no_buffer` total can be derived by summing
on read, rather than having different queues race on one shared field.

>> @@ -847,8 +933,12 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>>   	unsigned long flags;
>>   	int i;
>>   
>> -	if (queue_index >= adapter->num_rx_queues)
>> +	if (queue_index >= adapter->num_rx_queues) {
>> +		netdev_dbg(adapter->netdev,
>> +			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
>> +			   queue_index, adapter->num_rx_queues);
>>   		return;
>> +	}
>>   
>>   	adapter->replenish_task_cycles++;
> [Severity: Low]
> With several RX queues now polling concurrently, do the adapter-wide plain
> u64 counters need serialization?  replenish_task_cycles is incremented
> before the per-queue lock is taken, and replenish_no_mem,
> replenish_add_buff_success/failure and the new hcall_stats fields are
> touched under different per-queue locks, so the lockset intersection for
> these adapter-global fields is empty.  hcall_stats.send_lan is also
> incremented from ibmveth_start_xmit() on up to 16 TX queues in parallel.
> The visible effect is lost increments in the ethtool -S values.
>
> [ ... ]

Yes, once MQ is active those adapter-global counters can lose updates
across queues.

I still see that as the same broader informational-counter issue as in
the earlier patches. `rx_no_buffer` is addressed separately by the
queue-local fix above.

>> @@ -1284,6 +1374,137 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
>> +	lpar_rc = h_reg_logical_lan_queue(adapter->vdev->unit_address,
>> +					  adapter->buffer_list_dma[queue_index],
>> +					  rxq_desc.desc, &handle, &hwirq);
>> +	adapter->hcall_stats.reg_lan_queue++;
> [Severity: Low]
> Should this hcall retry on a busy return?  Every other long-running hcall
> in the driver loops:
>
> 	do {
> 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>
> including h_free_logical_lan_queue() in the IRQ-mapping failure path a few
> lines below this call, and h_send_logical_lan() in ibmveth_send().  As
> written, a transient H_BUSY / H_LONG_BUSY_ORDER_* here becomes -EIO from
> ibmveth_register_single_rx_queue() and a failed ifup.
Yes. `h_reg_logical_lan_queue()` should handle `H_BUSY` and long-busy
returns with a busy/long-busy spin on the subordinate register path.

I’m planning to add that there, but not bring back the older blind retry
shape that repeated the same subordinate register attempt without
changing any state.

>> +	/*
>> +	 * H_FUNCTION means firmware rejected this subordinate register
>> +	 * (MQ unsupported). That is a hard open failure: do not clear
>> +	 * multi_queue or claim single-queue fallback. Keep a specific
>> +	 * log, then the generic failure lines below (no early return).
>> +	 */
>> +	if (lpar_rc == H_FUNCTION)
>> +		netdev_err(adapter->netdev,
>> +			   "h_reg_logical_lan_queue H_FUNCTION for queue %d (firmware MQ unsupported)\n",
>> +			   queue_index);
> [Severity: High]
> Can the adapter recover if firmware stops honouring the MQ register after
> probe?  multi_queue and num_rx_queues are latched once in ibmveth_probe()
> from the H_ILLAN_ATTRIBUTES bit and are never re-read or reduced, so a
> H_FUNCTION here fails ibmveth_open() and every subsequent open the same
> way.
>
> The reset work item only closes and reopens, it never re-reads the
> attributes:
>
> ibmveth_reset() {
> 	rtnl_lock();
> 	dev_close(adapter->netdev);
> 	dev_open(adapter->netdev, NULL);
> 	rtnl_unlock();
> }
>
> ethtool -L ethX rx 1 while down does not restore RX either: multi_queue
> stays 1, so rx_buffers_per_hcall remains IBMVETH_MAX_RX_QUEUE and
> ibmveth_add_logical_lan_buffers() keeps calling
> h_add_logical_lan_buffers_queue(), whose H_FUNCTION path has no fallback
> when multi_queue is set.
>
> The driver already assumes PHYP capabilities can disappear across LPM:
>
> 	/*
> 	 * Live Partition Migration may drop multi-
> 	 * buffer support. Fall back to single-buffer
> 	 * on the next replenish; ...
> 	 */
>
> Would clearing multi_queue and falling back to one queue on H_FUNCTION be
> preferable to leaving the interface permanently unable to open?

Yes. If subordinate queue registration starts returning `H_FUNCTION`
after probe, the adapter can get stuck in a permanent open-fail state.

I’m planning to set a fallback latch on subordinate-register
`H_FUNCTION`, fail the current open cleanly, and let the next open apply
single-queue fallback after close has torn down the partial MQ state.

That should be framed as defensive recovery for an unexpected
`H_FUNCTION` event, not as a supported live MQ-to-SQ mode switch on the
running datapath.

>> +static int
>> +ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
>> +				 int queue_idx, u64 mac_address)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	union ibmveth_buf_desc rxq_desc;
>> +	long lpar_rc;
>> +
>> +	(void)mac_address;
> [Severity: Low]
> This isn't a bug, but is the mac_address parameter worth keeping?
> H_REG_LOGICAL_LAN_QUEUE has no MAC operand and
> ibmveth_register_logical_lan_queue() has no MAC parameter, so callers
> compute ether_addr_to_u64(netdev->dev_addr) only to feed a parameter that
> is voided here.  The (void)x; suppression cast is also not needed under
> the kernel's warning set.
>
> [ ... ]

Yes. The unused `mac_address` parameter should just be dropped.

>> @@ -1356,9 +1579,31 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
>> +	for (i = 1; i < adapter->num_rx_queues; i++) {
>> +		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
>> +		if (rc)
>> +			goto err_unregister;
>> +	}
>> +
>>   	netdev_dbg(netdev,
>> -		   "registered 1 RX queue with hypervisor (single-queue mode)\n");
>> +		   "registered %d RX queues with hypervisor (multi-queue mode)\n",
>> +		   adapter->num_rx_queues);
>> +
>>   	return 0;
>> +
>> +err_unregister:
>> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
>> +	ibmveth_free_all_queues(adapter);
>> +	return rc;
>>   }
>> @@ -1396,12 +1641,29 @@ static int ibmveth_open(struct net_device *netdev)
>> +	/*
>> +	 * MQ: post buffers before setup_rx_interrupts() unmasks PHYP
>> +	 * (avoids drops if traffic arrives during open; PHYP allows
>> +	 * either order). Single-queue keeps the classic kick: setup
>> +	 * (no unmask) then schedule_rx_queue() so the first poll
>> +	 * replenishes and enables.
>> +	 */
>> +	if (adapter->multi_queue && adapter->num_rx_queues > 1) {
>> +		for (i = 0; i < adapter->num_rx_queues; i++) {
>> +			netdev_dbg(netdev,
>> +				   "initial replenish cycle for queue %d\n", i);
>> +			ibmveth_replenish_task(adapter, i);
>> +		}
>> +	}
>> +
>>   	rc = ibmveth_setup_rx_interrupts(adapter);
> [Severity: Medium]
> Is PHYP delivery for subordinate queues guaranteed to be masked in this
> window?  Queue 0 is explicitly masked before registration:
>
> ibmveth_register_rx_queues() {
> 	adapter->queue_irq[0] = netdev->irq;
> 	rc = ibmveth_disable_irq(adapter, 0);
> 	...
> }
>
> but queues 1..N get no equivalent H_VIOCTL/H_DISABLE_VIO_INTERRUPT after
> H_REG_LOGICAL_LAN_QUEUE plus irq_create_mapping().  Buffers are now
> posted for every queue here, before any handler exists, and
> ibmveth_setup_rx_interrupts() was also reordered so request_irq() for all
> queues completes before any napi_enable():
>
> 	for (i = 0; i < num; i++) {
> 		...
> 		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt, ...);
> 	}
>
> 	for (i = 0; i < num; i++)
> 		napi_enable(&adapter->napi[i]);
>
> If an interrupt arrives in that window, ibmveth_schedule_rx_queue() finds
> NAPI still disabled:
>
> 	if (napi_schedule_prep(napi)) {
> 		lpar_rc = ibmveth_disable_irq(adapter, qindex);
> 		WARN_ON(lpar_rc != H_SUCCESS);
> 		__napi_schedule(napi);
> 	}
>
> so the handler returns IRQ_HANDLED without masking the hypervisor source
> and without scheduling a poll.  That is the same storm window described in
> ibmveth_cleanup_rx_interrupts() ("Mask PHYP before napi_disable so
> ibmveth_interrupt cannot return IRQ_HANDLED without masking").  The
> err_free_irqs path has the same gap: it frees handlers and disposes
> subordinate mappings without masking already-registered subordinate
> queues.
>
> The later scale-up path uses register -> request_irq -> publish ->
> replenish -> napi_enable -> enable_irq and documents why.  Would enabling
> NAPI before request_irq (as the baseline did), or explicitly masking each
> subordinate queue right after registration, close this window?
>
> [ ... ]

Yes. The subordinate queues need the same coherent IRQ/NAPI sequencing as
queue 0.

I’m planning to keep the open/setup path on the same
request_irq -> napi_enable -> PHYP enable rule here, so the first unmask
does not race a disabled poll. I do not think this needs a different
open-order policy from the single-queue path.

>> @@ -2373,18 +2632,25 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>>   	/* add size of mapped tx buffers */
>>   	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
>>   
>> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> -		/* add the size of the active receive buffers */
>> -		if (adapter->rx_buff_pool[0][i].active)
>> -			ret +=
>> -			    adapter->rx_buff_pool[0][i].size *
>> -			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].
>> -					     buff_size, tbl);
>> -		rxqentries += adapter->rx_buff_pool[0][i].size;
>> -	}
>> -	/* add the size of the receive queue entries */
>> -	ret += IOMMU_PAGE_ALIGN(
>> -		rxqentries * sizeof(struct ibmveth_rx_q_entry), tbl);
>> +	for (q = 0; q < adapter->num_rx_queues; q++) {
>> +		int rxqentries = 1;
> [Severity: Medium]
> Does the buffer-list term still need scaling here?  The unchanged line
> above this loop counts it once:
>
> 	ret = IBMVETH_BUFF_LIST_SIZE + IBMVETH_FILT_LIST_SIZE;
>
> while multi-queue allocates and dma_map_single()s a distinct 4096-byte
> buffer-list page per queue, which ibmveth_cleanup_rx_resources() unmaps
> per index.  That leaves the desired value short by (num_rx_queues - 1)
> buffer-list pages.
>
> Also, is anything updating the CMO entitlement for the new default queue
> count?  The VIO core samples it before the driver's probe runs:
>
> arch/powerpc/platforms/pseries/vio.c:vio_cmo_bus_probe() {
> 	viodev->cmo.desired =
> 		IOMMU_PAGE_ALIGN(viodrv->get_desired_dma(viodev), tbl);
> }
>
> with dev_get_drvdata() still NULL, so the single-queue sized
> IBMVETH_IO_ENTITLEMENT_DEFAULT is used for an adapter that will open with
> up to 8 RX queues, and neither ibmveth_probe() nor ibmveth_open() calls
> vio_cmo_set_dev_desired().  On a CMO partition, can this make
> dma_map_single()/dma_alloc_coherent() fail during open on adapters that
> worked in single-queue mode?

Yes. The desired-DMA calculation needs to scale the buffer-list pages by
the live RX queue count, and probe needs to refresh the CMO entitlement
after MQ capability detection.

I’m planning to keep the size derived from the pool0 geometry and call
vio_cmo_set_dev_desired() after probe has finalized the queue count.

>> +
>> +		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> +			/* add the size of the active receive buffers */
>> +			struct ibmveth_buff_pool *bpool =
>> +				&adapter->rx_buff_pool[q][i];
> [Severity: Medium]
> Is rx_buff_pool[q][i] populated for q >= 1 when this runs?  Pool metadata
> for queues 1..N is only filled in by ibmveth_alloc_buffer_pools(), which
> runs from ndo_open; ibmveth_probe() initializes only rx_buff_pool[0][i],
> and the private area is zeroed, so before the first open these entries
> have size = active = buff_size = 0.
>
> ibmveth_change_mtu() pushes the result straight into firmware accounting:
>
> 	vio_cmo_set_dev_desired(viodev, ibmveth_get_desired_dma(viodev));
>
> Can an MTU change while the interface is down therefore lower the
> entitlement to roughly the single-queue value, right before an open that
> allocates buffers for up to 8 queues?

Yes. `change_mtu()` also needs to refresh the desired entitlement using
the MQ-scaled geometry even while the interface is down.

>> @@ -2449,9 +2715,18 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>>   #endif
>>   };
>>   
>> +static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>> +				   int pools_ready)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < pools_ready; i++)
>> +		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>> +}
>> +
> [ ... ]
>
>> @@ -2531,16 +2810,27 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		netdev->features |= NETIF_F_FRAGLIST;
>>   	}
>>   
>> -	/* Initialize queue count - always 1 for now */
>> -	adapter->multi_queue = 0;
>> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
>> +	if (ret == H_SUCCESS &&
>> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
>> +		adapter->multi_queue = 1;
>> +		adapter->num_rx_queues = min(num_online_cpus(),
>> +					     IBMVETH_DEFAULT_QUEUES);
>> +		netdev_dbg(netdev, "RX multi queue mode enabled: %d queues\n",
>> +			   adapter->num_rx_queues);
>> +	} else {
>> +		adapter->multi_queue = 0;
>> +		adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
>> +	}
> [Severity: Medium]
> Now that num_rx_queues can be greater than one here, does
> ibmveth_resume() need updating too?  It still kicks queue 0 only:
>
> ibmveth_resume() {
> 	...
> 	ibmveth_schedule_rx_queue(adapter, 0);
> 	return 0;
> }
>
> The kick exists because the poll routine is what replenishes buffers and
> re-arms the PHYP interrupt via napi_complete_done() ->
> ibmveth_enable_irq().  After a suspend/resume or partition migration,
> queues 1..N-1 would then have no buffers posted and no interrupt
> re-armed until an ifdown/ifup.

Yes. `resume()` should kick every live RX queue, not just queue 0, so
subordinate queues get replenished and re-armed too.

>> @@ -2558,15 +2848,24 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>>   		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
>> -		int error;
>>   
>>   		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>>   					 pool_count[i], pool_size[i],
>>   					 pool_active[i]);
>> -		error = kobject_init_and_add(kobj, &ktype_veth_pool,
>> -					     &dev->dev.kobj, "pool%d", i);
>> -		if (!error)
>> -			kobject_uevent(kobj, KOBJ_ADD);
>> +		rc = kobject_init_and_add(kobj, &ktype_veth_pool,
>> +					  &dev->dev.kobj, "pool%d", i);
>> +		if (rc) {
>> +			dev_err(&dev->dev,
>> +				"failed to create pool%d kobject: %d\n", i, rc);
>> +			/* init_and_add takes a ref even on failure */
>> +			kobject_put(kobj);
>> +			ibmveth_put_pool_kobjs(adapter, pools_ready);
>> +			free_netdev(netdev);
>> +			return rc;
>> +		}
>> +
>> +		pools_ready++;
>> +		kobject_uevent(kobj, KOBJ_ADD);
>>   	}
> [Severity: Medium]
> Is it safe to free_netdev() immediately after ibmveth_put_pool_kobjs()?
> The kobjects are embedded in netdev_priv(netdev), and ktype_veth_pool has
> no release callback:
>
> static struct kobj_type ktype_veth_pool = {
> 	.release        = NULL,
> 	...
> };
>
> With CONFIG_DEBUG_KOBJECT_RELEASE=y the final put defers cleanup using a
> work item stored inside the kobject itself:
>
> lib/kobject.c:kobject_release() {
> #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> 	unsigned long delay = HZ + HZ * get_random_u32_below(4);
> 	...
> 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
> 	schedule_delayed_work(&kobj->release, delay);
> #else
> 	kobject_cleanup(kobj);
> #endif
> }
>
> free_netdev() then releases that memory with no window, so
> kobject_delayed_cleanup() would read kobj->state_in_sysfs, kobj->parent
> and kobj->name from freed storage.  The same shape applies to the two
> other new put_pool_kobjs() call sites below.
>> @@ -2574,6 +2873,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   	if (rc) {
>>   		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
>>   			   rc);
>> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
>>   		free_netdev(netdev);
>>   		return rc;
>>   	}
>> @@ -2590,6 +2890,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   
>>   	if (rc) {
>>   		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
>> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
>>   		free_netdev(netdev);
>>   		return rc;
>>   	}
> [ ... ]
Fair point. That DEBUG_KOBJECT_RELEASE hazard is real, but I’m treating
it as a follow-up rather than blocking this MQ series.

An empty release callback is not enough by itself; this needs a safer
lifetime arrangement, for example waiting out delayed release before
free_netdev(), or moving the pool kobjects out of the netdev-private
storage.

Thanks,
Mingming


