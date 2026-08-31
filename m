Return-Path: <linuxppc-dev+bounces-26337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABACC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:12:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYdsn4ZPTz2xlv;
	Tue, 01 Sep 2026 05:12:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788203549;
	cv=none; b=fE3g7b2XeZxQ0m6sHF3UfbnOVNxVKb5iGJ3NWJI1dxe3UElUoGz3ObyZUbKgfeds0WBIkKWAAOTdlrA6ftU1JPo5vFozHj3Yzb+8d1GtmLkhWGakxyEXlTJmVHuJxdxsb5eL60WedmnWHWmvOsUWukL/6cdOML8mXH1L0abhcTFb/lpERECIFCegorxeCyA6Acxxo5+s9kuNc81LnvNaQVRjHQitLn/dpD27oG+yji6UZI5QA2pcpsnj1LIp5XKoVOm/M7//lTvYV//wgo/q3u1eUnhVxkFXyBdFKhKIAKeeqqSlFlqOfIJHaehH+YfEVIbEj2PbEjvXY/+tcp/FpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788203549; c=relaxed/relaxed;
	bh=7FkGDtOthwdlrNoRiXtWrXd5JAARtY5YgIf9V6S68js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7X176ZNwOVl8nKpY7J3V7EIfOn4Tu0jC/asAwrQL8i3boXI5SSNagxLqgjTzQAOEKusH187hLGYChJqWKIGdo3G/DRQmInNff4lKqbpGwd3/fo+tJS7tfNJg1nMiPlX3HCGPPy3016lDzqMHSzno0gzVzesWryxwgNCccRkpjOO8mspvLgnU0TfD/g7p9ok9izaEGkUOz8fstKms4s0xlPdxLZnHEdOb/BFJwtPu+fPauYAZc7bK6H1gLvz3talmz1VtsxBWEwP45VD4kM+yf8fL6wSlaQYUl8Me48TU1lhTOw9bftOve+2MSkMLs7nKuVgT/7Rc0H92S240UkAOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hX1JLjk0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hX1JLjk0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYdsm3VShz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:12:28 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVkFM2996324;
	Mon, 31 Aug 2026 19:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7FkGDt
	OthwdlrNoRiXtWrXd5JAARtY5YgIf9V6S68js=; b=hX1JLjk0BQADyLiqCJEi6L
	oQK9zAPP6mumuITQgT7kSCu+KTQ20J3IPnlnzIAoSuBhouGi5ldScwED0dGFaCIu
	v5UAS64j/1ZZoVNJAUGIEasnaXo5xrr0axAfYCp4w8inzjjTAI52IE1rc68ZTpMg
	sKOt9WYvo6RjUAUrzS9r1KUeh0PtDVSSXDzUT9GHQz3/E891yTSyx/3Kf4SF3kKg
	bomuSLXEHxyK1jxRZan27YzxOA6V7EhGgdQ1ruSEVi8lgf/JgQ4D5hAtGBrQA8HH
	KsRmOxN/zMZ82Yz/vJEN32EV61RZTQbh7GBNQsd+N3fe95Mjx4csfwkG2xZDTv9A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhkf5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:12:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJBO4e024207;
	Mon, 31 Aug 2026 19:12:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg7f2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:12:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VJCBRm57213418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 19:12:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46E9558060;
	Mon, 31 Aug 2026 19:12:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C28C5803F;
	Mon, 31 Aug 2026 19:12:08 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 19:12:07 +0000 (GMT)
Message-ID: <0a251a80-193c-42aa-bbeb-d8c2bef4403f@linux.ibm.com>
Date: Mon, 31 Aug 2026 12:12:06 -0700
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
Subject: Re: [PATCH net-next v5 11/15] ibmveth: Add per-queue RX and TX
 statistics collection
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-12-mmc@linux.ibm.com>
 <20260818014733.3854367-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014733.3854367-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: B3ja80p8nNMDrgMHAN9tmPDYhgH4Gfo_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfXyKi4u6Srb9VF
 6e5G3RcPUby0V6JzCTERZvm+0pIzlCAbLF43OdilOVHXj6Cegh3Nl3ZloiKzjfo33vaG44l0GM+
 D6azymcDqH1OHstjxQjBPSDGSUKvJDEmMUjmrYD1qeE9j9LBfF6wsMAUlo3BFxNbTBfJ6S40imr
 6N4b8m0tq80beRMtym99J+tzJ+ZmFfH1dZTEa9zeaLjZDtHEkNa9D/NOBGEBgD10ZjyF7oue0PB
 8MZVrK/chbXixSaeSMBQK9REV21x4W+YJfIlxFhUwpttnJPUfXh+40utwJalBzrx8oJjORzOp2u
 2NDKNioWJf8cineAeLl2h7o21F5cEKh7PnWs3pdkRTIXcaCAs7alHq1oB38XJ2IEXlolob8I6oY
 ohXn5kixFr/0WYbRj0d8Mn8pR57QRt9l4hy/rnk0TcRil3c2+qQimcv0w5AWW7KQ7gcpqvp0DQk
 MBycEJMu+hblnvvkCmA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a95d210 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=PBIAcup3xsgB1fYgbTMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX4x50rqQjePIl
 DSHp/Uc3lPwFZElL7LLc3/oUlA9XteObx3yafeSA4RkA0hdu8Bf7DLCAO+b1uxLpChJAwHAGEvj
 M0S5Hv+9/1sbtG+W7SRJe6xllOY3kpw=
X-Proofpoint-ORIG-GUID: QoFRByZaBBidmCFCcioLwy9-ZrvIgiTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310164


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
Hi Jakub,

Thanks for the review.

v6 rewrites this patch around the review. Every multi-writer counter
moves to a per-queue u64 (no atomics). packets/bytes/drops go through
netdev_stat_ops; the eight hcall_* keys and the fifteen pool%d_ keys
are gone. unregister then cancel, with the reset worker gated on
NETREG_REGISTERED.
> ---
> ibmveth: Add per-queue RX and TX statistics collection
>
> This adds per-queue RX and TX counter arrays that are allocated at probe
> and freed at remove, updates them from the poll/IRQ/xmit paths, and
> exposes the values through ethtool -S plus a new ndo_get_stats64
> implementation. It also adds the hcall_* counters to the ethtool string
> table and reworks the probe error paths and ibmveth_remove() teardown
> order.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 36f0926711e60..3202b657c9b8f 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -98,7 +98,17 @@ static struct ibmveth_stat ibmveth_stats[] = {
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
> Can these hcall_* values lose increments once they become user visible?
>
> The fields in adapter->hcall_stats are plain u64 bumped with an
> unserialized read-modify-write. ibmveth_replenish_task() takes only the
> queue-local lock:
>
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
>
> so two NAPI instances replenishing different RX queues both reach
>
> 	adapter->hcall_stats.add_bufs_queue++;
>
> with no shared serialization, and separate TX queues both reach
>
> 	adapter->hcall_stats.send_lan++;
>
> in ibmveth_send(). Two CPUs can read N and both store N+1.
>
> Would per-queue counters summed on read (the same approach used for the
> new rx_qstats/tx_qstats), or atomic64_t, be preferable here?
Yes, those plain u64s could lose increments under MQ. They are not
exported: the hcall_* keys are gone, not made atomic. replenish_*
are the ones that move per-queue here, summed on the existing
adapter-wide keys.
>
> [ ... ]
>
>> @@ -1011,7 +1075,23 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>>   	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>>   	drops = be64_to_cpup(p);
>>   
>> -	adapter->rx_no_buffer = drops;
>> +	/*
>> +	 * PHYP's buffer-list page counter is absolute for that page. A new
>> +	 * page (reopen / queue reuse after -L) starts near zero; fold the
>> +	 * previous absolute into retired so adapter-level sums stay
>> +	 * monotonic.
>> +	 */
>> +	if (adapter->rx_qstats) {
>> +		u64 *slot = &adapter->rx_qstats[queue_index].no_buffer_drops;
>> +
>> +		if (drops < *slot)
>> +			adapter->rx_no_buffer_retired += *slot;
>> +		*slot = drops;
>> +	} else {
>> +		if (drops < adapter->rx_no_buffer)
>> +			adapter->rx_no_buffer_retired += adapter->rx_no_buffer;
>> +		adapter->rx_no_buffer = drops;
>> +	}
>>   }
> [Severity: Low]
> Does the no_buffer_drops slot lose the final PHYP value when a queue is
> retired by a channel shrink?
>
> This makes rx_qstats[i].no_buffer_drops a mirror of the page-absolute
> counter, and folding into rx_no_buffer_retired only happens when a later
> read observes a decrease. ibmveth_update_rx_no_buffer() has only two call
> sites, the replenish path and ibmveth_close(), and it early-returns for
>
> 	queue_index >= ibmveth_get_num_rx_queues(adapter)
>
> Once the incremental resize patch later in this series lands, scale-down
> does:
>
> 	ibmveth_publish_num_rx_queues(adapter, new_count);
> 	...
> 	for (i = new_count; i < old_count; i++)
> 		ibmveth_destroy_subordinate_rx_queue(adapter, i);
>
> which reaches ibmveth_free_single_rx_queue() and dma_unmap_single() plus
> free_page() on buffer_list_addr[i]. The live count is already lowered, so
> a late harvest is rejected by the guard above, and everything PHYP
> recorded in that page since the last replenish read is dropped from both
> the per-queue slot and the adapter sum.
>
> Would harvesting the absolute before lowering the published queue count
> and freeing the page fix this?
Yes. The slot mirrors the page absolute, and we only fold into the
retired carry when a later read sees a decrease. Close still harvests
before free_all_queues; at this commit a later -L shrink would publish
a lower live count first, so the guard would refuse the retiring
queues and the last PHYP delta would be lost.

Patch 14 harvests under each retiring queue's replenish_lock, then
publishes the new count, then frees the page. Not in this stats

patch.


>> @@ -2239,22 +2319,158 @@ static int ibmveth_set_features(struct net_device *dev,
> [ ... ]
>
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
>> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
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
> Should the per-queue packet, byte and drop counters go through the
> standard per-queue statistics interface instead of private ethtool
> strings?
>
> rx%d_packets, rx%d_bytes, tx%d_packets, tx%d_bytes and
> tx%d_dropped_packets map directly onto existing fields:
>
> include/net/netdev_queues.h
> 	struct netdev_stat_ops {
> 		void (*get_queue_stats_rx)(struct net_device *dev, int idx,
> 					   struct netdev_queue_stats_rx *stats);
> 		...
>
> The driver adds only .ndo_get_stats64 (device-wide) and never sets
> netdev->stat_ops, so the newly collected per-queue values are reachable
> only through the private ethtool blob, which cannot be removed once
> shipped. The genuinely driver-specific counters (interrupts, polls,
> invalid_buffers, no_buffer_drops, send_failures, checksum_offload) look
> fine in ethtool -S.
>
> Could the packets/bytes/dropped set be exposed via netdev_stat_ops
> qstats instead?
Yes. packets/bytes/drops go through netdev_stat_ops in v6, not
private -S strings. The driver-specific keys (replenish_*,
rx_invalid_buffer, rx_no_buffer, tx_map_failed, etc.) stay in
ethtool -S. get_base_stats() is the retired-queue remainder so a
shrink does not go backwards.
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
>> +		       ibmveth_get_num_rx_queues(adapter) *
>> +		       IBMVETH_NUM_RX_QSTATS +
>> +		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS +
>> +		       IBMVETH_NUM_BUFF_POOLS * 3;
>>   	default:
>>   		return -EOPNOTSUPP;
>>   	}
>> @@ -2263,11 +2479,44 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
>>   static void ibmveth_get_ethtool_stats(struct net_device *dev,
>>   				      struct ethtool_stats *stats, u64 *data)
>>   {
> [ ... ]
>
>> +	for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
>> +		data[i++] = adapter->rx_buff_pool[0][j].size;
>> +		data[i++] = adapter->rx_buff_pool[0][j].active;
>> +		data[i++] = atomic_read(&adapter->rx_buff_pool[0][j].available);
>> +	}
>>   }
> [Severity: Medium]
> This is a pre-existing issue rather than something this patch creates for
> the lifetime part below, but the commit message describes only per-queue
> RX/TX statistics and the hcall_* strings, while the patch also carries two
> other changes.
>
> First, three new ethtool -S entries per buffer pool are added:
>
> 	ethtool_sprintf(&p, "pool%d_size", i);
> 	ethtool_sprintf(&p, "pool%d_active", i);
> 	ethtool_sprintf(&p, "pool%d_available", i);
>
> and counted as IBMVETH_NUM_BUFF_POOLS * 3 in ibmveth_get_sset_count().
> The values are read only from adapter->rx_buff_pool[0][j], but
> rx_buff_pool is declared as
>
> 	struct ibmveth_buff_pool
> 		rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
>
> so in multi-queue mode queues 1..N-1 are not represented and the string
> names carry no queue index. pool size and active are also already
> available through the per-pool sysfs attributes (veth_size_attr,
> veth_num_attr, veth_active_attr). Should these strings be dropped, or at
> least given a queue index and mentioned in the commit message?
>
> Second, ibmveth_remove() reorders unregister_netdev() ahead of
> cancel_work_sync(), and the new ibmveth_probe_cleanup() clears vio
> drvdata before free_netdev(). The in-code comments describe both as
> fixing existing problems (a worker running after free_netdev(), and CMO
> get_desired_dma() seeing a freed netdev on rebind), neither of which the
> commit message body mentions and neither of which has a Fixes: tag.
> Could these be split into their own patches?
Dropped entirely, not given a queue index: do not grow sticky -S ABI
that duplicates sysfs (size/active) or that patch 13 already reports
per queue (available).

The remove reorder and the drvdata clear are real pre-existing bugs
and the body names both. They stay here rather than as prior patches
because the reorder without the qstat teardown P11 adds would leave
an intermediate partial fix. No Fixes: tag on a fix this entangled
with the feature; I could send the reset-vs-unregister piece
standalone to net if you would really rather pick it up that way.

>
> [ ... ]
>
>> @@ -3107,6 +3410,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>>   	.ndo_validate_addr	= eth_validate_addr,
>>   	.ndo_set_mac_address    = ibmveth_set_mac_addr,
>>   	.ndo_features_check	= ibmveth_features_check,
>> +	.ndo_get_stats64	= ibmveth_get_stats64,
>>   #ifdef CONFIG_NET_POLL_CONTROLLER
>>   	.ndo_poll_controller	= ibmveth_poll_controller,
>>   #endif
>> @@ -3121,6 +3425,23 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
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
>> +	/* Probe failure never reaches ibmveth_remove(); clear before free so
>> +	 * CMO get_desired_dma() cannot see a freed netdev on rebind.
>> +	 */
>> +	dev_set_drvdata(&adapter->vdev->dev, NULL);
>> +	free_netdev(netdev);
>> +}
>> +
> [ ... ]
>
>> @@ -3332,12 +3651,20 @@ static void ibmveth_remove(struct vio_dev *dev)
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>>   	int i;
>>   
>> -	cancel_work_sync(&adapter->work);
>> -
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>>   		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>>   
>> +	/*
>> +	 * Unregister first so NAPI/xmit cannot re-arm reset work after we
>> +	 * cancel it. cancel_work_sync() before unregister left a window
>> +	 * where poll could schedule_work() and the worker ran after
>> +	 * free_netdev().
>> +	 */
>>   	unregister_netdev(netdev);
>> +	cancel_work_sync(&adapter->work);
>> +
>> +	ibmveth_free_tx_qstats(adapter);
>> +	ibmveth_free_rx_qstats(adapter);
>>   
>>   	free_netdev(netdev);
>>   	dev_set_drvdata(&dev->dev, NULL);
> [Severity: High]
> With cancel_work_sync() now running after unregister_netdev(), can the
> reset worker re-open an already unregistered netdev?
>
> adapter->work is queued from several error paths, for example
> ibmveth_replenish_task() on an invalid free_map entry or on MQ H_FUNCTION
> after LPM, and from ibmveth_poll_skip_bad_correlator():
>
> 	schedule_work(&adapter->work);
>
> The handler has no registration or running check:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_reset() {
> 	rtnl_lock();
>
> 	dev_close(adapter->netdev);
> 	dev_open(adapter->netdev, NULL);
>
> 	rtnl_unlock();
> }
>
> A worker already queued (or already blocked in rtnl_lock() while
> unregister_netdev() holds rtnl) proceeds once unregistration finishes.
> dev_close() is then a no-op, and the re-open is not rejected:
>
> net/core/dev.c:netif_open() {
> 	if (dev->flags & IFF_UP)
> 		return 0;
>
> 	ret = __dev_open(dev, extack);
> }
>
> net/core/dev.c:__dev_open() {
> 	ASSERT_RTNL();
> 	dev_addr_check(dev);
>
> 	if (!netif_device_present(dev)) {
> 	...
> 	if (!ret && ops->ndo_open)
> 		ret = ops->ndo_open(dev);
> }
>
> IFF_UP was cleared by unregister and __LINK_STATE_PRESENT is never
> cleared (the driver does not call netif_device_detach()), so
> ibmveth_open() runs again on the unregistered device: it re-requests the
> RX IRQs with dev_id = &adapter->napi[i], re-registers the logical LAN
> with PHYP, and re-arms DMA into freshly allocated buffer lists.
>
> cancel_work_sync() then returns and remove() continues into
> ibmveth_free_tx_qstats() / ibmveth_free_rx_qstats() and free_netdev(),
> so the installed IRQ handler and the hypervisor are left pointing at
> freed memory. The next RX interrupt would execute
>
> 	adapter->rx_qstats[qindex].interrupts++;
>
> in ibmveth_interrupt() against a freed adapter and a freed qstat array.
>
> Would a netif_running() or reg_state check inside ibmveth_reset(), or a
> "removing" flag set before unregister_netdev(), close this?
Yes. With cancel after unregister, a worker already queued or blocked
on RTNL can still close/open an unregistered netdev before
free_netdev(), and leave IRQ/PHYP pointed at freed qstats.

v6 returns from ibmveth_reset() after rtnl_lock() unless
reg_state is NETREG_REGISTERED. unregister then cancel_work_sync
stays. No cancel-first, and no extra “removing” flag.


Thanks,

Mingming


