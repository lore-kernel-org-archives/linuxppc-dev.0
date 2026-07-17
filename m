Return-Path: <linuxppc-dev+bounces-24328-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAA2C44512
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 01:27:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1XMv3Fwwz2ySg;
	Fri, 17 Jul 2026 11:27:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784251659;
	cv=none; b=FXujvG5XB/TulFHdUYdOoJ6zwU74lZ0C3onC7XPaCaluJIEkewU46L0N2gAqOiidH/bUHcwZoc9iog6hawy9nS+IIK8mE8GR47GiRwzmO8fCydK7C/pTqNFKv5fApRzw12HO7JAgPn0IFTySv6TZhUILPC7PHAgnR5lpFcA+o1mTq/vZtJCDu9wQCZ1c0iC/rqNfmOHLxoLkJAGRgibpxPVXJgf+Z9ZsjjLCNADUiDZcVwiZNdl6wh+qB38Y5oFK5yrTeO0+TmZK4G69Gnpx4LAdZ3UNPBomAeBCQrQegMxVShAPyh5IvuK45p43Pa5m6fy4EhNTRlTTVYKJHx24Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784251659; c=relaxed/relaxed;
	bh=JJdKL25ja4uizkp4ckqqD9HisVne6nVgzk7R3Mdsyng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewfkcgRd644pA2DSGE/oCeIk4I7/QDIkqzMXTFmjQO5xM/iAq6d1WuXyab4SELcqEOCV8675yAJt4m1u8RVqBhD9XsKCZbBhuj/nRwwbtRr5p21XNqjhgwKF+ncZQ2DmY4SZpxBU6uK0NXz9Z4G65zBtyet4DVNXfxQP+B6wgZ2zc3ezuMcRlBvMN90C1WO+/wGxwAUyblzmDvhDKNYpXYxS4Xb3a/pPm51Uet2UWJMaspnTydEDarNJuprSnClv6KXQ/IkmPeRiu7DdO2s0/b80y2fRMMiiG+TFr3sH1G93bGQMvn5pn567LJvXFlSdASfqxF7P5FwtXaEZpYZ8Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=chVGKajv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=chVGKajv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1XMs67jcz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 11:27:36 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNfwtS441084;
	Fri, 17 Jul 2026 01:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JJdKL2
	5ja4uizkp4ckqqD9HisVne6nVgzk7R3Mdsyng=; b=chVGKajvEnImKXGNFtuW6n
	11QpYPo0XwDeOkRvtEpiYyKTYquQy8Hvoe/K/DCoa8VgfZ1GcEYvcFyWUHppJ1Tu
	4ykYok8qxK4HJy73V5dqZurFYllOwKRXqjR3ZxTE3ZVxrZ7shKSNNcwqCSZ6AfyY
	CKju9qazcVgVat6taLyYPZy3nD1ZFiDtU5SnIspZqQ7tI7PVos+NL/BfJ/28TZSf
	60GjPxAVgAbyyhEzQMnOq18dsuSBOC3vP/3MAFFfjlga1scSpuR5sDtXITR0DyEk
	yKj/HMXfDIELdx8FcF4jdvI6+fqd/X5Qwv+jKuv7TP5sgtCjpfUkU0jZeyUTDUqg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxuxrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:27:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H1Jc1s002059;
	Fri, 17 Jul 2026 01:27:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgqedv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:27:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H1RNif29819632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 01:27:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3640D5804B;
	Fri, 17 Jul 2026 01:27:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F39FB58055;
	Fri, 17 Jul 2026 01:27:21 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 01:27:21 +0000 (GMT)
Message-ID: <cc53403e-e617-4cf5-9c60-3f4d41398d03@linux.ibm.com>
Date: Thu, 16 Jul 2026 18:27:21 -0700
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
Subject: Re: [PATCH net-next v3 10/15] ibmveth: Enable multi-queue RX receive
 path
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-11-mmc@linux.ibm.com>
 <20260714125557.1837451-2-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714125557.1837451-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lQFPD5I2u9OgNIcE1WDTVZGOmWpuzNHP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwOCBTYWx0ZWRfX8vGpFJoKhtgi
 AKr1B0zQnbN+1a8TCDXQM4gvkEGixr2pKalIuaoaly2H08EGrRu7TOFrUFuUiWtDNjf0RltpYmk
 4dmeTLQngtK3s1GaZB6ZQEOlKDcauNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwOCBTYWx0ZWRfX8itULf997SN+
 C7HBu9C9aigovSMqknXatg4HyxH19PcqWN97EaoLz0MzeBZ1a2T5If2ElGPCjHv1P3B6v/uLLUZ
 6p0Lmp5GpfBzclG0f2ucDEWIzr6evrUVXKUSGrnSDBakXyasaEymADkxVNnoZDmhZP7QdVCyk0r
 e1bczTupSKS42ho+VrJaYRfHGjzbdpRJEebq7svTIudTT5GS2GudygaBon09KzAfU05s5CxDQVv
 2L8XNLSCYVrOWIrCVqXaOBXI5UY84nD+OgGOMY50fiLzWyhCdA1rga/XGfAt1k4KJ1mq9nS721D
 OBbCxAwTW5Hb+A5THi+hFHkJM3IMt6aT9CVEH+W65g72/YO/xTKgzL7hUJCZZuEBF7PpIfsC3bK
 j6XhrBs+4NEu2QMDSsCBPRxCt7tuGnfzE45Wo/WCo/K+EfYNqRyvut+zafxHYz+AWSak3OZgWjk
 7O0tU83obJXnWrnTo7w==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5984fd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=oCOWiWrWeyqk-uhPVHYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 5CO1Ww0zEfSzI-J7BLG5faJzXLk-tnig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170008

On 7/14/26 5:55 AM, Simon Horman wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ibmveth: Enable multi-queue RX receive path
>
> This is the first patch that sets multi_queue from H_ILLAN_ATTRIBUTES
> and switches registration, buffer posting, and receive to the MQ
> hcall path. It also raises num_rx_queues and enables per-queue NAPI.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index b3b3886c3eedb..863e5c68b42c7 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -826,15 +841,23 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>    */
>>   static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>>   {
>> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
>> +	int i;
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
>> +		u64 drops = be64_to_cpup(p);
>>   
>> -	adapter->rx_no_buffer = be64_to_cpup(p);
>> +		if (i == 0)
>> +			adapter->rx_no_buffer = drops;
>> +	}
>>   }
> [Severity: Medium]
> Will this logic silently discard the hardware drop counts for all queues
> other than queue 0?
>
> Since ethtool -S reports the global adapter->rx_no_buffer statistic, shouldn't
> this loop accumulate the drops across all queues instead of only recording
> them when evaluating the first queue?
>
> [ ... ]
*

Good catch. Per-queue drops are already in rx_qstats

once that patch lands; the global rx_no_buffer still mirrors queue 0

only. I'll sum across queues into rx_no_buffer in v4.

*
>> @@ -842,6 +865,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>>   				   int queue_index)
>>   {
>> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
>> +	unsigned long flags;
>>   	int i;
>>   
>>   	if (queue_index >= adapter->num_rx_queues)
>> @@ -842,6 +865,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>>   
>>   	adapter->replenish_task_cycles++;
>>   
>> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
>> +
> [Severity: Medium]
> With multi-queue RX enabled, can multiple NAPI threads execute this task
> concurrently for different queues?
>
> If so, does this non-atomic increment of the global replenish_task_cycles
> stat risk data corruption, torn reads on 32-bit platforms, or lost updates?
>
> Similarly, in ibmveth_replenish_buffer_pool():
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_replenish_buffer_pool() {
>      ...
>      buffers_added += filled;
>      adapter->replenish_add_buff_success += filled;
>      remaining -= filled;
>      ...
> }
>
> Even though the caller acquires the per-queue rxq->replenish_lock,
> replenish_add_buff_success is a global adapter statistic. Does this update
> also race with other CPUs holding the locks for their respective queues?
>
> [ ... ]
*Same as on the buffer-submit patch: these are informational counters only.*
*replenish_lock serializes replenishment for a single RX queue, but it 
does not *
*protect the adapter-wide counters across multiple queues.
*
*However, these counters are used only for diagnostics and observability, *
*not for correctness, synchronization, or resource management.While 
stricter *
*accounting could be achieved with atomic operations, these counters are *
*updated in a hot path and the additional synchronization overhead is 
difficult *
*to justify for diagnostic-only statistics, particularly on larger 
systems with *
*many RX queues. If more accurate accounting is desired, a per-queue *
*statistics model would likely be a better follow-up approach, *
>> @@ -2268,34 +2299,40 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>>   
>>   static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   {
> [ ... ]
>>   		} else {
>>   			struct sk_buff *skb, *new_skb;
>> -			int length = ibmveth_rxq_frame_length(adapter);
>> -			int offset = ibmveth_rxq_frame_offset(adapter);
>> -			int csum_good = ibmveth_rxq_csum_good(adapter);
>> -			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
>> +			int length = ibmveth_rxq_frame_length(adapter, queue_index);
>> +			int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
>> +			int csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
>> +			int lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
> [Severity: High]
> This isn't a bug introduced by this patch, but does this code validate the
> length and offset provided by the hardware descriptor before modifying the
> SKB bounds?
>
> Later in ibmveth_poll(), these values are used directly:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_poll() {
>      ...
>      skb_reserve(skb, offset);
>      skb_put(skb, length);
>      ...
> }
>
> If the hypervisor provides an untrusted or artificially large length, could
> the call to skb_put() trigger an skb_over_panic() and crash the guest
> kernel?
>
> [ ... ]

*Agreed, this needs guarding.I was already working on a follow-up 
poll-hardening
**patch that adds correlator validation and verifies sufficient 
skb_tailroom() before
calling skb_reserve() and skb_put(). I will keep those validations in v4.
If preferred for bisect safety, I can also move the checks earlier in 
the series rather
than introducing them only in the final hardening patch.*


>
> Also, I noticed a potential memory leak in the error unwinding path of
> ibmveth_open():
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_open() {
>      ...
>      if (rc) {
>          netdev_err(netdev, "failed to set number of rx queues\n");
>          goto out_unregister_queues;
>      }
>      ...
> out_free_buffer_pools:
>      ibmveth_free_buffer_pools(adapter);
> out_unregister_queues:
>      ibmveth_dispose_subordinate_irq_mappings(adapter);
>      ibmveth_free_all_queues(adapter);
> }
>
> [Severity: Medium]
> This is a pre-existing issue, but if netif_set_real_num_rx_queues() fails,
> the code jumps to the out_unregister_queues label.
>
> Does this bypass out_free_buffer_pools, leaving the RX buffer pools unfreed
> and causing a memory leak when cleaning up after a failure?
*

Yes — same open() unwind issue called out on the open/close

refactor patch. Will fix the label order in v4 so buffer pools

are always freed after unregister.

**

Thanks,

Mingming

*

