Return-Path: <linuxppc-dev+bounces-25705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C232C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 23:42:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJrrp4zLFz2yys;
	Tue, 11 Aug 2026 09:42:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786405338;
	cv=none; b=n2iVrcs0pXqBzIRaOyXD7Mcvd2G28iImuccIJWG6Ks6XAVJWUv7kUO0hkcDy6cs41X2mtRiHVH8qOdIC5uY4I8YcYolJ4SMHgUI1ewOorN90oCigQaH6Eilj7qyZOrUYL8WDD0tIBZIpEaiL2KPTbmtoGS9C96zPeyk7YfuLSMbAdGtznyHE6wDWwGUBI0BnYu1P0kxRkJGOxupi7ehKx2dxEr7t78E0Hx7W60qneJKKUucWA9lFdtqoCRQcSHUkQZwbbp/jyPdYRDyeWrUfmyySHoPoTwEGmrb9sfVgdihDxebl041Lh0PsPS3EVVhfm6FCFm+SS893owty1dFneA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786405338; c=relaxed/relaxed;
	bh=mbfTAxrUpn9G0xUwCLBK+18B2qqJzBJ0W9eIyo7WEwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkvHG7vhJ+GwYlPXY7Hb4CVvz/V+Zn4skcdmbmfJFjn/N9qgLTbjZ59ZcL2JiEEvSg66O8/KizlIg4uCdqeL8KbROlnv8aiL6Oez3nsI2Inq47T6r2hn3tHg4K3bwy0tjujVF70uqK+guVd8cXcI6q6R0DwAcC4zy+Eh1MOwSgmVbrKcqt8MF1377yqHuFJ+tte474/dcXCbW90a7zEVXPn9euFRiOxtsLWE2LMYvL1VhydN43rhvOlTGop92GICKPuFN2k04xxbrm5H0hUkK5aSbfTFEHtl+GKMMCjxTPvMmItkrLVfsv2DQrHfuKuo3a0pMLHH99WOlMDN59eylA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pG8qAJUO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pG8qAJUO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJrrn0g0Wz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 09:42:16 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1ggb2920434;
	Mon, 10 Aug 2026 23:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mbfTAx
	rUpn9G0xUwCLBK+18B2qqJzBJ0W9eIyo7WEwY=; b=pG8qAJUOIFmAIxcjY9Zx6w
	ce16i2HVLSzSQjsvdXQpiz5ytjoc0V/wJs8UNx3W3ekSM4XTLQzIMult2TH3QWaq
	xsDNo5wz1SqibHUW1gdj0V2GaqqfBayt6xGIdpQoxj6OXWQhTyR/ptOyEAMyWMJB
	EPy/8wH2llNyGYJsRnszak4US2y36mhOnU2wssi/8HqBsrHidapeLr2h93GxKH8g
	KA/wYjDnP4LeP2FR3ePc+Sg2qpB7ISRbEGxw6aPoZBmS8FJiFac/JL5t+EgXrmRz
	Smr9UYxGNi88QF+OXAA7PTZsOVkbgWudcbQUqxaYtNfPD8kd3aEMKru/FQtFNvow
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9ahfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:42:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ANfSnj000659;
	Mon, 10 Aug 2026 23:42:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespy0s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:42:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ANg3T627001508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 23:42:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFD845805A;
	Mon, 10 Aug 2026 23:42:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B0005803F;
	Mon, 10 Aug 2026 23:42:01 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 23:42:01 +0000 (GMT)
Message-ID: <5910489d-2d8b-443d-9b24-d948330cacfa@linux.ibm.com>
Date: Mon, 10 Aug 2026 16:42:00 -0700
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
Subject: Re: [PATCH net-next v4 10/14] ibmveth: Add per-queue RX and TX
 statistics collection
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <69368babf33c52163881c33d3929ab17b61d0629.1785457143.git.mmc@linux.ibm.com>
 <20260806183709.3175682-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183709.3175682-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vHcYiZVsJccVNNNBJ2yLZrNmPAWaPYEJ
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a61ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=E7DJuKED5wCTCSCwuQoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDIwMCBTYWx0ZWRfX7EpaVOA9sXga
 DDu6eq01pNzt/bMjScTl/BnfsYfBJ4FSfce7GMnw5SLBTwZqQq8vOAp11zcAUzzF443AiF8s/dY
 DWTTRILSRs1/0KsluJfaKybFvZJccIDvli5MlypWxscdrUEdQnOO4q5jfpwGO4ZgbgWe8JaRdGx
 8ffyHOQAnyREqbZ71AF8fH6Bw2XQjszI9fj9vWQTOgHjoCJjNngPru7ZXlzcdu0s0ri0RxygzUh
 FwiZpirmvvOm2OaKVpD2om+tekUEEFyp5Ygjws69c9LtvX3QAbBDBf4/QB7cL4w/eYF3tRHhGHP
 kAmPC4kF8esyNCjJKSLos6TMOZQmHo89tRdzr7w4C2DtBPy5GwFO3tBvvoKtm468FSyi6vVGmmV
 rLF436AIgW4Ibb7YXXntGcdgFILm8Rhn+TsHvQPhShn+dU8b10zcYWOA8/Ldk61RmldKXkeUbzR
 u5tAwA2R12QxpeiR7oA==
X-Proofpoint-ORIG-GUID: TXjjkoLpOVmu4Gp4MPgUc7O4o3iGrVod
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDIwMCBTYWx0ZWRfX6pAsk6FvZhkB
 zLKHBLByECPR39zDllA+RAPtBpAxKtPP3leAnG1bFxYbtp5qj+10PIikEs4wj4taeNg/ujYSw8Y
 c3Ln+L4UUX4zPB0Rk/fi5wQyGstisM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100200


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Add per-queue RX and TX statistics collection
>
> This patch adds per-queue RX and TX counter arrays that live for the
> adapter lifetime, exports them through ethtool -S, and adds an
> ndo_get_stats64 implementation that sums them. It also changes what
> ibmveth_get_channels() reports for max_rx and rx_count.
>
> A few questions below.
Hi Jakub,

Thanks for the review.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 4ad7ced3c6083..dbb47a42b4cb5 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -921,6 +975,8 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>>   		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
>>   		u64 drops = be64_to_cpup(p);
>>   
>> +		if (adapter->rx_qstats)
>> +			adapter->rx_qstats[i].no_buffer_drops = drops;
>>   		adapter->rx_no_buffer += drops;
>>   	}
>>   }
> [Severity: Medium]
>
> Can concurrent polls on different queues corrupt these counters?
>
> ibmveth_update_rx_no_buffer() writes rx_qstats[i] for every queue, but
> its caller ibmveth_replenish_task(adapter, queue_index) holds only that
> one queue's lock:
>
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
> 	...
> 	ibmveth_update_rx_no_buffer(adapter);
> 	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
>
> So two NAPI polls on different queues run the same all-queue loop under
> disjoint locks (replenish_lock[0] vs replenish_lock[1]):
>
> CPU A: reads queue 1 hypervisor value 100
> CPU B: reads queue 1 hypervisor value 105, stores 105
> CPU A: stores 100
>
> Does that make rxN_no_buffer_drops move backwards as seen by ethtool?
> The adapter->rx_no_buffer = 0 / += drops sequence around it is also an
> unsynchronized read-modify-write visible to a concurrent ethtool reader.
>
> This also seems to work against the ____cacheline_aligned_in_smp
> annotation added to struct ibmveth_rx_queue_stats, since every replenish
> cycle now dirties every queue's stats cache line from a foreign CPU.
>
> Would passing queue_index into the helper and touching only
> rx_qstats[queue_index] and buffer_list_addr[queue_index] work, deriving
> the adapter-level rx_no_buffer by summing on read the way the patch
> already does for rx_large_packets and rx_invalid_buffer?
>
> Related: at the end of the series the RX scale-down path in
> ibmveth_resize_rx_queues_incremental() lowers adapter->num_rx_queues and
> then frees a queue's buffer_list page while polls on surviving queues keep
> running. Can a poll that already loaded the old bound dereference
> buffer_list_addr[i] for a freed page here?

Yes. This needs to become queue-local and NULL-safe.

I’m planning to update only the current queue’s slot, keep the absolute
PHYP count in `rx_qstats[q].no_buffer_drops`, and derive the adapter
`rx_no_buffer` total by summing on read. That avoids concurrent-poll
RMW on one shared field, avoids foreign cacheline writes, and closes the
scale-down freed-page hazard.
>
> [Severity: Medium]
>
> Should no_buffer_drops be accumulated rather than assigned?
>
> The value PHYP writes into the last 8 bytes of the buffer-list page is an
> absolute count for the life of that page, and the page is re-obtained with
> get_zeroed_page(GFP_KERNEL) by ibmveth_alloc_rx_queues() on every
> ibmveth_open() and released by ibmveth_cleanup_rx_resources() on every
> ibmveth_close(), including the close/open pairs done by the reset work,
> ibmveth_set_csum_offload() and ibmveth_set_tso().
>
> Since rx_qstats[i].no_buffer_drops is assigned with "= drops", does
> rxN_no_buffer_drops (and the recomputed adapter->rx_no_buffer) jump
> backwards after an ifdown/ifup, a driver reset, or an ethtool -K tso
> change?
>
> That appears to contradict the comment this patch adds above the sum
> helpers:
>
> 	 * globals on the hot path (ibmvnic-style); with qstats allocated for the
> 	 * adapter lifetime, these sums remain meaningful across ifdown/up.
The PHYP field there is an absolute count for the life of that
buffer-list page, so assigning `=` into the per-queue slot is correct
for that page lifetime.

What needs tightening is the lifetime wording around the aggregate:
qstats live for the adapter lifetime, but a raw sum of these page-
absolute values can still go backwards across ifdown/up. I’m planning
to clarify that in the comments and ethtool wording rather than imply
monotonic lifetime `no_buffer` semantics without a baseline+delta
model.
>> @@ -1972,22 +2028,131 @@ static int ibmveth_set_features(struct net_device *dev,
>>    * globals on the hot path (ibmvnic-style); with qstats allocated for the
>>    * adapter lifetime, these sums remain meaningful across ifdown/up.
>>    */
>> +static u64 ibmveth_sum_rx_invalid_buffers(struct ibmveth_adapter *adapter)
>> +{
>> +	u64 total = 0;
>> +	int i;
>> +
>> +	if (!adapter->rx_qstats)
>> +		return adapter->rx_invalid_buffer;
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++)
>> +		total += adapter->rx_qstats[i].invalid_buffers;
>> +
>> +	return total;
>> +}
> [ ... ]
>
>> +static u64 ibmveth_sum_tx_send_failed(struct ibmveth_adapter *adapter)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	u64 total = 0;
>> +	int i;
>> +
>> +	if (!adapter->tx_qstats)
>> +		return adapter->tx_send_failed;
>> +
>> +	for (i = 0; i < netdev->real_num_tx_queues; i++)
>> +		total += adapter->tx_qstats[i].send_failures;
>> +
>> +	return total;
>> +}
> [Severity: Medium]
>
> Do these sums go backwards when the queue count is reduced?
>
> The qstats arrays persist for the adapter lifetime, but the sums are
> bounded by the currently configured queue count. ibmveth_set_channels()
> lowers netdev->real_num_tx_queues:
>
> 	rc = netif_set_real_num_tx_queues(netdev, goal);
>
> Nothing folds or clears the counters of the queues that disappear, so
> after "ethtool -L ethX tx N" with a smaller N, do the adapter-level
> ethtool strings tx_large_packets and tx_send_failed, plus the
> rtnl_link_stats64 tx_packets/tx_bytes/tx_dropped summed in
> ibmveth_get_stats64(), all drop by the traffic accounted to the removed
> queues, and then jump forward again when the count is raised?
>
> Since this patch removes the hot-path netdev->stats accounting,
> ibmveth_get_stats64() is now the only source for the rtnl counters, so a
> decrease is directly user visible; tools computing deltas (ip -s link,
> ifstat) will read it as a counter wrap. The same applies on the RX side
> with adapter->num_rx_queues once the incremental RX resize commit later in
> this series changes it at runtime.

Yes. The aggregate sums should not be bounded by only the currently live
queue count.

I’m planning to make the aggregate stats walk the fixed MAX queue slots
so retired queues keep contributing and the adapter-visible totals do
not move backwards when the active queue count shrinks.

>> +static u64 ibmveth_ethtool_adapter_stat(struct ibmveth_adapter *adapter,
>> +					int index)
>> +{
>> +	unsigned long offset = ibmveth_stats[index].offset;
>> +
>> +	if (offset == IBMVETH_STAT_OFF(rx_invalid_buffer))
>> +		return ibmveth_sum_rx_invalid_buffers(adapter);
>> +	if (offset == IBMVETH_STAT_OFF(rx_large_packets))
>> +		return ibmveth_sum_rx_large_packets(adapter);
>> +	if (offset == IBMVETH_STAT_OFF(tx_large_packets))
>> +		return ibmveth_sum_tx_large_packets(adapter);
>> +	if (offset == IBMVETH_STAT_OFF(tx_send_failed))
>> +		return ibmveth_sum_tx_send_failed(adapter);
>> +
>> +	return IBMVETH_GET_STAT(adapter, offset);
>> +}
>> +
>>   static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>>   {
>> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +	u8 *p = data;
>>   	int i;
>>   
>>   	if (stringset != ETH_SS_STATS)
>>   		return;
>>   
>> -	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++, data += ETH_GSTRING_LEN)
>> -		memcpy(data, ibmveth_stats[i].name, ETH_GSTRING_LEN);
>> +	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++) {
>> +		memcpy(p, ibmveth_stats[i].name, ETH_GSTRING_LEN);
>> +		p += ETH_GSTRING_LEN;
>> +	}
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		ethtool_sprintf(&p, "rx%d_packets", i);
>> +		ethtool_sprintf(&p, "rx%d_bytes", i);
>> +		ethtool_sprintf(&p, "rx%d_interrupts", i);
>> +		ethtool_sprintf(&p, "rx%d_polls", i);
>> +		ethtool_sprintf(&p, "rx%d_large_packets", i);
>> +		ethtool_sprintf(&p, "rx%d_invalid_buffers", i);
>> +		ethtool_sprintf(&p, "rx%d_no_buffer_drops", i);
>> +	}
>> +
>> +	for (i = 0; i < dev->real_num_tx_queues; i++) {
>> +		ethtool_sprintf(&p, "tx%d_packets", i);
>> +		ethtool_sprintf(&p, "tx%d_bytes", i);
>> +		ethtool_sprintf(&p, "tx%d_large_packets", i);
>> +		ethtool_sprintf(&p, "tx%d_dropped_packets", i);
>> +		ethtool_sprintf(&p, "tx%d_send_failures", i);
>> +		ethtool_sprintf(&p, "tx%d_checksum_offload", i);
>> +	}
> [Severity: Medium]
>
> Should the per-queue packet and byte counters use the standard per-queue
> statistics interface instead of driver-private ethtool strings?
>
> rx%d_packets, rx%d_bytes, tx%d_packets and tx%d_bytes map one to one onto
> struct netdev_queue_stats_rx and struct netdev_queue_stats_tx, which are
> exported through netlink via struct netdev_stat_ops. No netdev_stat_ops
> is added here, so generic tooling (ynl) cannot consume these values, and
> Documentation/networking/statistics.rst asks that counters with a standard
> uAPI not be duplicated in ethtool -S.
>
> Also, the new ibmveth_get_stats64() populates only rx/tx packets, bytes
> and tx_dropped:
>
> 	stats->tx_errors = dev->stats.tx_errors;
>
> After this patch, is there any remaining writer of dev->stats in this
> driver? The only match in the file is this read, so tx_errors appears to
> be permanently 0. The loss counters this patch does collect
> (no_buffer_drops from the hypervisor, invalid_buffers) are not mapped
> into rx_dropped / rx_missed_errors / rx_errors either, so ip -s link
> reports zero RX drops while ethtool -S shows a non-zero rx_no_buffer.

Agreed in principle. The duplicated standard queue stats in `-S`, the
stale `tx_errors` read, and the incomplete RX drop mapping are all real
interface issues, but I still see them as broader uAPI cleanup rather
than something that has to be solved in the same patch as MQ stats
enablement.

I’m planning to keep the MQ correctness fixes in this series and leave
the `netdev_stat_ops` / rtnl mapping cleanup as a follow-up, since that
is really an ABI/tools migration rather than a small MQ fix.

>> +
>> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> +		ethtool_sprintf(&p, "pool%d_size", i);
>> +		ethtool_sprintf(&p, "pool%d_active", i);
>> +		ethtool_sprintf(&p, "pool%d_available", i);
>> +	}
>>   }
>>   
>>   static int ibmveth_get_sset_count(struct net_device *dev, int sset)
>>   {
>> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +
>>   	switch (sset) {
>>   	case ETH_SS_STATS:
>> -		return ARRAY_SIZE(ibmveth_stats);
>> +		return ARRAY_SIZE(ibmveth_stats) +
>> +		       adapter->num_rx_queues * IBMVETH_NUM_RX_QSTATS +
>> +		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS +
>> +		       IBMVETH_NUM_BUFF_POOLS * 3;
>>   	default:
>>   		return -EOPNOTSUPP;
>>   	}
> [ ... ]
>
>> @@ -1996,21 +2161,59 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
>>   static void ibmveth_get_ethtool_stats(struct net_device *dev,
>>   				      struct ethtool_stats *stats, u64 *data)
>>   {
>> -	int i;
>>   	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +	int i, j;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++)
>> -		data[i] = IBMVETH_GET_STAT(adapter, ibmveth_stats[i].offset);
>> +		data[i] = ibmveth_ethtool_adapter_stat(adapter, i);
>> +
>> +	for (j = 0; j < adapter->num_rx_queues; j++) {
>> +		if (adapter->rx_qstats) {
>> +			data[i++] = adapter->rx_qstats[j].packets;
>> +			data[i++] = adapter->rx_qstats[j].bytes;
>> +			data[i++] = adapter->rx_qstats[j].interrupts;
>> +			data[i++] = adapter->rx_qstats[j].polls;
>> +			data[i++] = adapter->rx_qstats[j].large_packets;
>> +			data[i++] = adapter->rx_qstats[j].invalid_buffers;
>> +			data[i++] = adapter->rx_qstats[j].no_buffer_drops;
>> +		} else {
>> +			i += IBMVETH_NUM_RX_QSTATS;
>> +		}
>> +	}
> [Severity: Low]
>
> Can adapter->rx_qstats or adapter->tx_qstats ever be NULL here?
>
> The allocations happen in ibmveth_probe() before register_netdev(), and a
> failure aborts probe with ibmveth_probe_cleanup() + return -ENOMEM.
> ibmveth_remove() frees them only after unregister_netdev(). So on a
> registered netdev the NULL case seems unreachable, which would make these
> else arms, the else arms in ibmveth_poll(), and the
> "if (!adapter->*_qstats) return adapter-><legacy>;" early returns in the
> four sum helpers dead code.
>
> The two styles also disagree: ibmveth_is_packet_unsupported() guards with
> "if (adapter->tx_qstats)" while ibmveth_start_xmit() dereferences
> adapter->tx_qstats[queue_num] unconditionally at six new sites on the same
> call chain. Which of the two is intended?
>
> A side effect is that adapter->rx_invalid_buffer, rx_large_packets,
> tx_large_packets and tx_send_failed are never incremented again while
> still being listed in ibmveth_stats[].
>
> Separately, ibmveth_ethtool_adapter_stat() dispatches by comparing
> ibmveth_stats[index].offset against IBMVETH_STAT_OFF() values. Would
> adding or reordering a field in struct ibmveth_adapter silently redirect a
> statistic to the wrong source here?

Yes. After successful probe those NULL arms are effectively dead, and
the mixed guarded/unguarded style should be simplified.

I’m planning to collapse that to one defensive style at fold rather than
leave the current inconsistent mix in place.

Separately, I agree the offset-based adapter-stat dispatch is brittle,
even if it is not the main correctness blocker here.

>> +
>> +	for (j = 0; j < dev->real_num_tx_queues; j++) {
>> +		if (adapter->tx_qstats) {
>> +			data[i++] = adapter->tx_qstats[j].packets;
>> +			data[i++] = adapter->tx_qstats[j].bytes;
>> +			data[i++] = adapter->tx_qstats[j].large_packets;
>> +			data[i++] = adapter->tx_qstats[j].dropped_packets;
>> +			data[i++] = adapter->tx_qstats[j].send_failures;
>> +			data[i++] = adapter->tx_qstats[j].checksum_offload;
>> +		} else {
>> +			i += IBMVETH_NUM_TX_QSTATS;
>> +		}
>> +	}
>> +
>> +	for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
>> +		data[i++] = adapter->rx_buff_pool[0][j].size;
>> +		data[i++] = adapter->rx_buff_pool[0][j].active;
>> +		data[i++] = atomic_read(&adapter->rx_buff_pool[0][j].available);
>> +	}
>>   }
> [Severity: Medium]
>
> Should the pool%d_* strings be queue-indexed?
>
> The driver now keeps an independent pool set per RX queue
> (rx_buff_pool[queue][pool], populated for all q < adapter->num_rx_queues
> by ibmveth_alloc_buffer_pools() and updated per queue by
> ibmveth_replenish_task()), but these three entries read only
> rx_buff_pool[0][j] under queue-agnostic names, so the state of queues
> 1..N-1 is not visible. Is that intended for someone debugging drops on a
> non-zero queue?
>
> Also, size and active are configuration values already exposed through the
> per-pool sysfs kobjects rather than statistics, and this new permanent
> ethtool string set is not mentioned in the commit message.

Yes, that is intentional here: those `pool%d_*` entries are the shared
queue-0 template view, not live per-queue runtime state.

I’m planning to make that clearer in the wording. Live per-queue state
belongs in the later debugfs visibility, and I’m fine with dropping
`size` / `active` from ethtool -S later if sysfs-only is preferred.

>>   static void ibmveth_get_channels(struct net_device *netdev,
>>   				 struct ethtool_channels *channels)
>>   {
>> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> +
>>   	channels->max_tx = ibmveth_real_max_tx_queues();
>>   	channels->tx_count = netdev->real_num_tx_queues;
>>   
>> -	channels->max_rx = netdev->real_num_rx_queues;
>> -	channels->rx_count = netdev->real_num_rx_queues;
>> +	if (adapter->multi_queue)
>> +		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
>> +	else
>> +		channels->max_rx = 1;
>> +	channels->rx_count = adapter->num_rx_queues;
>>   }
> [Severity: Low]
>
> This isn't a bug, but would this ABI-visible get_channels() reporting
> change be easier to review as its own patch? It is independent of the
> statistics work, and if it is a fix it would want its own Fixes: tag.
>
> There is also a mismatch it introduces: the new RX loops in
> ibmveth_get_strings() / ibmveth_get_sset_count() / ibmveth_get_stats64()
> use adapter->num_rx_queues while the TX loops use
> dev->real_num_tx_queues. netdev->real_num_rx_queues is only synced to
> adapter->num_rx_queues in ibmveth_open(), so on a never-opened interface
> ethtool -l reports a count the stack does not have yet.
>
> [ ... ]

Agreed. That `get_channels()` reporting change is separate enough that
it should be split out so this patch stays stats-focused and the
reporting change can be reviewed on its own.

>> @@ -2150,6 +2355,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>>   	    skb_checksum_help(skb)) {
>>   
>>   		netdev_err(netdev, "tx: failed to checksum packet\n");
>> +		adapter->tx_qstats[queue_num].dropped_packets++;
>>   		goto out;
>>   	}
> [ ... ]
>
>> @@ -2211,7 +2423,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>>   	dma_wmb();
>>   
>>   	if (ibmveth_send(adapter, desc.desc, mss)) {
>> +		adapter->tx_qstats[queue_num].send_failures++;
>> +		adapter->tx_qstats[queue_num].dropped_packets++;
>>   	} else {
>> +		adapter->tx_qstats[queue_num].packets++;
>> +		adapter->tx_qstats[queue_num].bytes += skb->len;
>>   	}
> [Severity: Medium]
>
> These empty if/else bodies in the pre-image show that the previous commit
> in the series ("ibmveth: Enable multi-queue RX receive path") deleted the
> hot-path netdev->stats accounting, and the replacement only arrives here.
> ibmveth_poll() likewise increments no packet or byte counter at that
> commit, and no ndo_get_stats64 exists yet.
>
> Does that leave the tree at the parent commit reporting zero
> rx_packets/rx_bytes/tx_packets/tx_bytes/tx_dropped through ip -s link,
> where the pre-series baseline reported them? Would squashing the removal
> into this patch, or deferring the removal until this replacement lands,
> keep every commit in the series bisectable for counter-related issues?
>
> [ ... ]

Fair point. If the series keeps the current split, I’m planning to note
that intermediate stats hole in the cover and consider a minimal bridge
when restacking so the series stays bisectable for counter behavior.

>> @@ -2698,6 +2933,40 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
>>   	return vlan_features_check(skb, features);
>>   }
>>   
> [ ... ]
>
>>   static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>> -				   int pools_ready)
>> +				  int pools_ready)
>>   {
>>   	int i;
> [Severity: Low]
>
> This isn't a bug, but this whitespace-only reflow breaks the previously
> correct open-parenthesis alignment of the second parameter (checkpatch:
> "Alignment should match open parenthesis") in a function this patch does
> not otherwise change. Could it be dropped?

Yes. That whitespace-only reflow should just be dropped.

>> @@ -2724,6 +2994,19 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>>   		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>>   }
>>   
>> +static void ibmveth_probe_cleanup(struct ibmveth_adapter *adapter,
>> +				  int pools_ready)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +
>> +	cancel_work_sync(&adapter->work);
>> +	ibmveth_put_pool_kobjs(adapter, pools_ready);
>> +
>> +	ibmveth_free_tx_qstats(adapter);
>> +	ibmveth_free_rx_qstats(adapter);
>> +	free_netdev(netdev);
>> +}
>> +
> [Severity: High]
>
> This isn't a problem introduced by this patch, since the old open-coded
> error paths had the same omission, but the new helper is now the single
> place four probe failure paths funnel through, so it looks like the
> natural spot to fix it.
>
> ibmveth_probe() stores the netdev in the VIO drvdata right after
> alloc_etherdev_mqs():
>
> 	dev_set_drvdata(&dev->dev, netdev);
>
> ibmveth_probe_cleanup() ends with free_netdev(netdev) but never clears it,
> and ibmveth_remove() (the only caller of dev_set_drvdata(&dev->dev, NULL))
> does not run when probe fails. So after any probe failure the vio_dev
> keeps a pointer to freed memory.
>
> On FW_FEATURE_CMO systems the stale pointer is consumed on the next bind
> attempt, before the driver probe re-initializes it:
>
> vio_bus_probe()
>    vio_cmo_bus_probe()
>      viodev->cmo.desired = IOMMU_PAGE_ALIGN(viodrv->get_desired_dma(viodev), tbl);
>        ibmveth_get_desired_dma()
>
> ibmveth_get_desired_dma() only checks for NULL:
>
> 	netdev = dev_get_drvdata(&vdev->dev);
> 	if (netdev == NULL)
> 		return ...;
>
> and then dereferences netdev->mtu and adapter->num_rx_queues, using the
> latter as the loop bound over adapter->rx_buff_pool[q][i]. Since that
> bound is read from freed memory, can this read past the end of the freed
> allocation as well? Would adding dev_set_drvdata(&dev->dev, NULL) to
> ibmveth_probe_cleanup() close this?

Yes. `probe_cleanup()` needs to clear the VIO drvdata before
`free_netdev()`, so a later CMO entitlement path cannot see a freed
netdev.
>>   static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   {
>>   	int rc, i, mac_len, pools_ready = 0;
>> @@ -2779,6 +3062,11 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		netif_napi_add_weight(netdev, &adapter->napi[i],
>>   				      ibmveth_poll, 16);
>>   
>> +	if (ibmveth_alloc_rx_qstats(adapter) ||
>> +	    ibmveth_alloc_tx_qstats(adapter)) {
>> +		ibmveth_probe_cleanup(adapter, 0);
>> +		return -ENOMEM;
>> +	}
>>   
>>   	netdev->irq = dev->irq;
>>   	netdev->netdev_ops = &ibmveth_netdev_ops;
> [ ... ]
>
>> @@ -2913,6 +3198,9 @@ static void ibmveth_remove(struct vio_dev *dev)
>>   
>>   	unregister_netdev(netdev);
>>   
>> +	ibmveth_free_tx_qstats(adapter);
>> +	ibmveth_free_rx_qstats(adapter);
>> +
>>   	free_netdev(netdev);
>>   	dev_set_drvdata(&dev->dev, NULL);
>>   }
> [Severity: High]
>
> This is a pre-existing issue, since the cancel_work_sync() placement in
> ibmveth_remove() predates this patch, but the patch adds two new frees
> into exactly that window.
>
> ibmveth_remove() calls cancel_work_sync(&adapter->work) at the top,
> before unregister_netdev(), so the device is still open when the cancel
> returns and softirq context can re-arm the work:
>
> ibmveth_poll()                     /* on ibmveth_enable_irq() failure */
>    schedule_work(&adapter->work);
>
> ibmveth_replenish_buffer_pool()    /* on an invalid free_map index */
>    schedule_work(&adapter->work);
>
> Timeline:
>
> CPU A: cancel_work_sync() returns, queue empty
> CPU B: ibmveth_poll() -> schedule_work(&adapter->work)
> CPU A: unregister_netdev()
> CPU A: ibmveth_free_tx_qstats() / ibmveth_free_rx_qstats()
> CPU A: free_netdev(netdev)
> CPU B: ibmveth_reset() runs container_of(w, struct ibmveth_adapter, work)
>
> Can the worker then dereference the freed adapter and netdev in
> rtnl_lock(); dev_close(adapter->netdev); dev_open(...)?
>
> If it reaches dev_open() -> netif_tx_start_all_queues(), TX restarts with
> tx_qstats == NULL, and the unguarded adapter->tx_qstats[queue_num]
> dereferences added to ibmveth_start_xmit() by this patch would then be a
> NULL dereference. The new "if (adapter->rx_qstats)" hot-path guards do not
> help, since the adapter holding the pointer is itself inside the freed
> netdev.
>
> Would moving the cancel (or disable_work_sync()) to after
> unregister_netdev() address this?

Yes. `remove()` needs to unregister the netdev first, then cancel the
work, then free the qstats and netdev, so nothing can re-arm the reset
work after the cancel returns.

Thanks,
Mingming

