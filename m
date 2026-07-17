Return-Path: <linuxppc-dev+bounces-24332-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7137C44512
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 02:40:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1Yzq5kXCz2yRl;
	Fri, 17 Jul 2026 12:40:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784256023;
	cv=none; b=bG33Fnz/67iWb0+D+Q7igqY3XrVBguc4AWcCAfCDBK4rteUQFPmoAKIy5Inyn7qWfpmy2uBAuX/486jRarRgd9iOeej+xqPN8datMLx8WE09AaVXK8LIp9sNqpMBrXBok8DWh06/yUpLzYR0gmgANtcpVFwL5EEDs8rgO0p+DEh/tI3ktzR9y/SumTE2Rgx3jSlE1g6dHffl2fA32QpywRfMNLwDAGjortTZhBdg77WJGGfwJMIpNWXFxZe/ZzGgYnq1hL29ec4Z5LyyYBkfouRgJ6pwqT02me615Bfs+sdHtZy55n9PlNUN9hrfGOOmAnLPAMMBCMl/HA+A8wCrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784256023; c=relaxed/relaxed;
	bh=jUQaNeQ3aTBvO4b8YKlHCR99o0A/CpSDur5ru6PdqUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZZtMu9MuXO+w3Ge8b7vWWT4izCjRRmaXHTTP6fvVMUEboTE7x63cVcnCTC8KfwFtHyenPLth9X5Tr1R/+iCDJ2bo4G50BxJvEvAJ5l+7+67koXhIIAbZVuITbqjKcHpnYAuRnyOAUXDmQsvlPN8lRtuAtlVXPZNVqvjtOMFf1aolaUTIIv5w7VYvafHcVYeI7SrMAQyQ7UWu8KmDEI1n1X33UcFALdDhr5cO7NlqfZ5Y259Wa416wrKNichne9RYbogbNmdLSjq7allCKF7uFnLwqUFkNDLMlyDyBlVuVEPVuPXJYJSpAPtE19hOD0qwC6GpXwLFiu79eiiPV1PRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xy5Z87Ec; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xy5Z87Ec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1Yzp11zYz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 12:40:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNg4CD2751493;
	Fri, 17 Jul 2026 02:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jUQaNe
	Q3aTBvO4b8YKlHCR99o0A/CpSDur5ru6PdqUY=; b=Xy5Z87EctH43Pdz6I2S8zQ
	Rlc7UTHXPPLAEeiAjV+YIy2JvYSxY72Sf1oCslv+KpyrVyUMpA69X1FrNK/tFOGT
	IVaBFBt4VAPw5OTjOQ4t6Sub3Ej+EGeBGxUrGt8wIhZqDD002iYX+l5RHe8bjCQm
	Jmaa1OOgEGZaUdhjxc6BKHYu/AEGH55nYxNCwrJ4pAT6S9QwHnkdewvMPlD3OgNe
	z5Bp2K6Xb6RLdjTp5T8Yzr0jiRXKkWiyhffn+4C4BHKho/A9ER2JVRsWe/ZrBrqK
	OCQ9+04x0WfOLd4W+y4m5POYs3VdwSoO5AyGZt4pHEFlBOzlo/nqnNlg0IXLzTkw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33mqp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 02:40:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H2YbDs001159;
	Fri, 17 Jul 2026 02:40:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyfh3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 02:40:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H2e7bC5636712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 02:40:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F73B5804B;
	Fri, 17 Jul 2026 02:40:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E502058067;
	Fri, 17 Jul 2026 02:40:05 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 02:40:05 +0000 (GMT)
Message-ID: <4a5872b6-a341-49ad-865f-08cbef20f7ad@linux.ibm.com>
Date: Thu, 16 Jul 2026 19:40:05 -0700
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
Subject: Re: [PATCH net-next v3 13/15] ibmveth: Implement incremental MQ RX
 queue resize
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-14-mmc@linux.ibm.com>
 <20260714130344.1841551-3-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714130344.1841551-3-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAxOSBTYWx0ZWRfXznxvEsRZUeEB
 MOW6VzfGszv+DNsfdg2M1FCM+rCAIhWChpqfta1YLsYakuvGz3tSAWdxEGHgfjBEuXmVmuI9esw
 Q5Z2GqB6yZmZGZtkWj7CYXPM4mFeC6w=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a59960a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=kjHIh2Z9nTzAJ6UZDdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 3-ycBRn1fbyAl7x6GIhedcvGwHUT4EYT
X-Proofpoint-ORIG-GUID: lIx5WQb0Gylt4wOw6jFc_j1GcnVWTXYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAxOSBTYWx0ZWRfX1gshAuuXC50x
 pxHQHuRJWirFGzWaFAH2W5qzM6kUr3rdeL7K6rR3uw5M/tRfZ+rXk4GmfpxdQjo/dsBrMLEGrc5
 xoRyEs2GgGyYpFz9cCKBJlpEC1fgQO/MteqVQckPdoE+42VuXZsSUpgJKCPNzMs5m+DXodrM5Vu
 gXecZlus+RlZF1a4X5nIqetpw+nJWjnKVppMd5M6iSm/0gwt4nih5TeFvSC4ayNt3RqSFnqpYHO
 cpYYdKbg+x1iq8/GiNYA09nYYBNF3S8WU4sQOaPfoyKbyD2fO0fksf9CfEfhQpZxPt7tBVx3M5i
 rBGRl8aAEa6Q9x5lO1ksqKZUrrOc77qPntWg+82Z7uuqHjEvxVUPztHQzzvmNcmA1BFYkgTc+0o
 /D+bk4arC+ZQW0S2WuqGVXgT5GbqSXdyn8Rsa9CoqBcSYL4JfVtsXnqdwtoCeSZc2JPbHHstC5s
 6jN0Z7/bLgh64F3uGgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170019

On 7/14/26 6:03 AM, Simon Horman wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> Date:   Mon Jul 6 19:36:01 2026 +0000
>
> ibmveth: Implement incremental MQ RX queue resize
>      
> Add helpers to register/deregister individual RX queues and scale
> queue count up or down while the netdev stays up. Surviving queues
> keep PHYP handles, buffer pools, and IRQ state across resize.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index ecc472ee8f71f..ac4d89a66a8db 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1080,6 +1132,138 @@ static void ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
>> +static int
>> +ibmveth_alloc_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx,
>> +			      int rxq_entries)
>> +{
> [ ... ]
>
>> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> +		adapter->rx_buff_pool[queue_idx][i].size =
>> +			adapter->rx_buff_pool[0][i].size;
>> +		adapter->rx_buff_pool[queue_idx][i].buff_size =
>> +			adapter->rx_buff_pool[0][i].buff_size;
>> +		adapter->rx_buff_pool[queue_idx][i].threshold =
>> +			adapter->rx_buff_pool[0][i].threshold;
>> +		adapter->rx_buff_pool[queue_idx][i].active =
>> +			adapter->rx_buff_pool[0][i].active;
>> +	}
> [Severity: Critical]
> Does this loop miss initializing pool->index?
>
> If pool->index remains 0 for all buffer pools on the new queue, when
> replenishing, 0 is shifted into the correlator.
>
> Then when receiving, ibmveth_remove_buffer_from_pool() will extract pool=0,
> which fetches from the wrong pool and could corrupt the free map of pool 0,
> leading to a use-after-free or leak.
Thanks — this was a real bug. We discovered this issue while doing 
stress tests, and identified
this issue, Agreed copies
*

pool->index when cloning pools for incrementally added queues; I have 
verified the fix. Thanks again,

*
>
> [ ... ]
>
>> @@ -1192,6 +1376,49 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>> +static int
>> +ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
>> +{
> [ ... ]
>
>> +	while (drained < limit &&
>> +	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
>> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
> Simon says: I think we can consider the issue below in the context of
>              possible follow-up, because I believe the use of this pattern
> 	    predates this patch.
>
> [Severity: High]
> Is a read memory barrier needed between reading the toggle bit in
> ibmveth_rxq_pending_buffer() and reading the correlator in
> ibmveth_rxq_harvest_buffer()?
>
> Since the hypervisor could be actively writing new descriptors while this is
> called, could a weakly-ordered CPU reorder the correlator load before the
> toggle bit load, causing us to recycle the wrong buffer?
>
> [ ... ]
Ah, *

as this toggle/correlator ordering pattern

**

pre-dates the resize work. I’ll treat adding an explicit barrier

in the drain path in v4

*
>> @@ -1491,6 +1718,175 @@ ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
>> +static int
>> +ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
>> +				     int new_count, int rxq_entries)
>> +{
> [ ... ]
>
>> +			rc = ibmveth_enable_irq(adapter, i);
>> +			if (rc) {
>> +				netdev_err(netdev,
>> +					   "Failed to enable IRQ for queue %d: %d\n",
>> +					   i, rc);
>> +				ibmveth_cleanup_single_rx_interrupt(adapter, i);
>> +				ibmveth_deregister_single_rx_queue(adapter, i);
>> +				ibmveth_free_single_rx_queue(adapter, i);
>> +				goto cleanup_new_queues;
>> +			}
>> +
>> +			napi_enable(&adapter->napi[i]);
>> +		}
>> +
>> +		adapter->num_rx_queues = new_count;
> [Severity: High]
> What happens if an interrupt fires on the newly added queue before
> adapter->num_rx_queues is updated?
*agreed, v3 published the new queue count too late.*
> If an interrupt fires between ibmveth_enable_irq() and the update of
> adapter->num_rx_queues, ibmveth_interrupt() might evaluate:
>      WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues)
> to true and return IRQ_NONE without masking the interrupt.
>
> Could this lead to an unhandled interrupt storm?
*

possible

**

I will work on in v4 so that each new queue is published and replenished

**

before PHYP enable and napi_enable(), so ibmveth_interrupt() will not

**

return IRQ_NONE on a queue we have not published yet, and NAPI

does not run on an empty queue.

*
>
> [ ... ]
>
>> +	} else {
>> +		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
>> +			   new_count, old_count - 1);
>> +
>> +		for (i = new_count; i < old_count; i++)
>> +			napi_disable(&adapter->napi[i]);
>> +
>> +		for (i = new_count; i < old_count; i++)
>> +			ibmveth_drain_rx_queue(adapter, i);
>> +
>> +		synchronize_net();
> [Severity: High]
> Can disabling NAPI before disabling the hardware interrupts create an
> interrupt storm window?
*

  Agreed — with the handler only masking on successful NAPI

  schedule, napi_disable before PHYP mask can storm during drain.

*
>
> If the hypervisor asserts an interrupt during synchronize_net(), the hardware
> IRQ handler runs. Since NAPI is disabled, it returns IRQ_HANDLED without
> masking the interrupt source at the hypervisor, leading immediately to an
> IRQ storm and CPU lockup.
*

  That is a load-dependent race (tests can pass and still miss it).

  In v4 I will disable_irq + synchronize_irq before

  napi_disable/drain on scale-down (and on scale-up fail cleanup).

*

>> +
>> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
>> +		if (rc) {
>> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
>> +				   new_count, rc);
>> +			for (i = new_count; i < old_count; i++)
>> +				napi_enable(&adapter->napi[i]);
>> +			return rc;
>> +		}
> [Severity: High]
> Is it possible for this error path to permanently stall the RX queues?
>
> It calls napi_enable() but doesn't call ibmveth_replenish_task(). Since the
> queues were completely drained of their buffers by ibmveth_drain_rx_queue(),
> will the hypervisor have any buffers to place incoming packets?
>
> Without buffers, no interrupts will fire for these queues, and NAPI will
> never run again.
*

  Good catch — after drain, that set_real_num_rx failure path must

  replenish before re-enabling IRQ/NAPI, or those queues stall with

  empty pools. Real rollback bug (rare path). Will fix in v4.

*
Thanks,
Mingming


