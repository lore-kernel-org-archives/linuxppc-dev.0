Return-Path: <linuxppc-dev+bounces-28181-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7343DC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:09:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrhdl6G1jz2y2M;
	Fri, 25 Sep 2026 17:09:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790320155;
	cv=none; b=Pz2RqjcFbIau3/9YDZmcg5XxDoZXlJtoVPt853d2QP038kVXNObgeuavaRwctraFXsawYwqKJPVEwJTZRaWpkvRtlPmDg2wJdjE99oa6cis42G6c35ny2Z+Z+z8vdtC6XggcL0gejc1cWqTN5QdLSX2C8HqSWI6G+ifzP417DwyYRvFXifRbTxGaTKTTGzHOBuCsE/kyEZCnQg3zD/VbIZYqB0Y8LzRl2T2HIYAHtToLVwfaK14A7tdVss7KAdRheQR3+Uw2War1W4zyGe8Vo8xW4oCPJVTIBhswemd9t6HyecJB0oWQN1a+erjcFucMeXUVmriAYw8ZVx62c79mQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790320155; c=relaxed/relaxed;
	bh=zUDlAbIh01QfscdjSexAWVhisN93zIw51evvy4h5uSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RytmTEccFGQh4GIUjkCvjzMkBT463OBlEi65M8uCqsmS3go75/uycyjUKWx7F+qBdgFF1OlFcCBgaIUVDSsCCmtIu6PqUW+KkH6m1VrAxL80Cy20w10ZlVc94GV0QpuWtKlJ+D/De3YLiQHjNlpQMo5X7dxlybpVHxCofyyVaBrCM12cKO2X9dQ70sbSo3J1MCbW8FAYubOgG7cpGvJY4AiP3Q4uC+zW8ECpBQNLDOXCHzu9CgOOrF/I9jpcEeTQlIu5AGOv1hI/A5QX/ma1YMFhxJwI0atrR4F2O2ndjX9txZfLa1HeaoWKj1e2lmPKMYzPa4vJAhqNpYwv5hOUOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f+UHeQt7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f+UHeQt7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrhdk3YG7z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:09:14 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4adWC2393916;
	Fri, 25 Sep 2026 07:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zUDlAb
	Ih01QfscdjSexAWVhisN93zIw51evvy4h5uSM=; b=f+UHeQt7Y5EcCzkMlxuGAb
	LbObGDbHoBMF2vzBEmJRJwZJnQgL2vXSPcnuQJ/tOHmriBqkT8wOfVuFJGFgCeAz
	Ve/+2qu7FY2ycbC8eR9WKwtN5H5J8hp9kRG2wpH2rkfpl6a2zZNr7P4QFoqp6i/+
	fFdOq517kKjdQ79rPT07pJ1QuUhUO+PaC/LzCNweoTksA2O6PMQF6a958dvDj3UZ
	YqVswAYZxinuSJfv4T1j5Js4ZxWbylYYNZEbIW3LvPCQ1DRnF4WrEXyC216luoq/
	ecE0TzQj5hE8F5bxnRVsn7d1gZURSbkGpGyRhhq1ZFIF8MFdjkIPCX139exd3dLg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske25q9e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:09:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lVAO3288190;
	Fri, 25 Sep 2026 07:09:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21f7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:09:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P7919231260982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 07:09:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BCFA58063;
	Fri, 25 Sep 2026 07:09:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4143A58055;
	Fri, 25 Sep 2026 07:08:58 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 07:08:58 +0000 (GMT)
Message-ID: <2b2a4e18-448f-4ca6-aec8-65f7786383f0@linux.ibm.com>
Date: Fri, 25 Sep 2026 00:08:57 -0700
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
Subject: Re: [net-next,v6,11/15] ibmveth: Add per-queue RX and TX statistics
 collection
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <f78c04298729fa6cb6cd26e19da792b48ff1cef6.1788102125.git.mmc@linux.ibm.com>
 <178845904193.3394541.17982476800730465689@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845904193.3394541.17982476800730465689@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: G9xAfWQxu3mGQoGrrn-Ym45XgyxY-snt
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab61e10 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=aycBkK9lBmJ5_C-_FgIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyOCBTYWx0ZWRfX96Qb4bTnjzXw
 48qi88g5EAtshsv6qEu6GOJ/iRbz6hRI35o9R0isieKqNaEK5aa3b2AAx44eA9c1AUMU/R5swoa
 7X0sga0K1tCmBVYBk0M9KMzpRVSDQug=
X-Proofpoint-GUID: ZFfPQrVoPEZjYP_6fe7dR4JqwEISGcYQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyOCBTYWx0ZWRfX4HRvnffoTDbO
 ol8Cvzc3KK1g5QPjMifUpkKQwdnS1mbspqsUhcQxe6pM4VeFlO04HWDzGQ05FKa9/Ek+SBvcXYv
 XHI1U5OfZGMW32h2/GcC6RR0Vs2AIe5t4Kq7PzN8W5uTEdEK0g7+dd+sOdmHebo3xMHQddh26dY
 3jrfnPptXVl+oZHUK0eF4eFLSHUKLXQuBvBkVW6jJsBVDVlp81T+lVI/L8y+OZBsaI6ni/hYEtH
 q+9pJFVDmPRfvSMR5O1id+12IWS+aOSzB1J3hZxo3Er+CvUeZtwj87QCQ5wwAyIsKO7QMH/72cY
 xEwfUI3jLyjRDeoFCGfZOve1vB2PUlB03U19AtKSjEyl6y1KRsqqi994LHgCTMBrztEBO1F6hdU
 hU7I9e9Foin9Gwf+lZfsWkQ0MN2Cf7FSwG94+9St1eiIjjLAnRkoIpS2Ta1mVaFrVlZfkQxOm+F
 Si5ySR6Vy4jfIqidY3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250028


On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 6 · Low: 0
>
> - [Medium] The patch bundles an independently applicable use-after-free
>    fix for the reset worker into a statistics feature patch and…
> - [Medium] The new ibmveth_get_stats64() populates rx_packets/rx_bytes
>    and tx_packets/tx_bytes/tx_dropped but never sets rx_missed_errors or…
> - [Medium] ibmveth_get_queue_stats_tx() (and the retired-queue part of
>    ibmveth_get_base_stats()) exports the driver's software TX drop…
> - [Medium] The new per-queue ethtool -S key tables add driver-private
>    strings for counters that already have standard uAPI fields, while the…
> - [Medium] ibmveth_update_rx_no_buffer() detects a buffer-list page
>    replacement only by the heuristic `if (drops <…
> - [Medium] ibmveth_close() calls ibmveth_update_rx_no_buffer() for every
>    live queue without holding that queue's replenish_lock, while netpoll…
>
> --
>
> Below is an automated review report for this commit.
>
> ibmveth: Add per-queue RX and TX statistics collection
>
> This moves the ibmveth RX and TX counters out of struct ibmveth_adapter
> into per-queue arrays allocated at probe and freed at remove, adds
> netdev_stat_ops and ndo_get_stats64, and makes the ethtool -S block
> variable length with new per-queue keys.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 2e8896ea5af2e..f4fddfa56571d 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -75,32 +76,101 @@ module_param(old_large_send, bool, 0444);
> [ ... ]
>
>> +/*
>> + * Only counters with no home in the standard interfaces belong here.
>> + * packets, bytes and drops are reported through netdev_stat_ops.
>> + */
>> +static const struct ibmveth_qstat ibmveth_rx_qstat_keys[] = {
>> +	{ "rx%d_interrupts", IBMVETH_RXQ_OFF(interrupts) },
>> +	{ "rx%d_polls", IBMVETH_RXQ_OFF(polls) },
>> +	{ "rx%d_large_packets", IBMVETH_RXQ_OFF(large_packets) },
>> +	{ "rx%d_invalid_buffers", IBMVETH_RXQ_OFF(invalid_buffers) },
>> +	{ "rx%d_no_buffer_drops", IBMVETH_RXQ_OFF(no_buffer_drops) },
>> +};
>> +
>> +static const struct ibmveth_qstat ibmveth_tx_qstat_keys[] = {
>> +	{ "tx%d_large_packets", IBMVETH_TXQ_OFF(large_packets) },
>> +	{ "tx%d_send_failures", IBMVETH_TXQ_OFF(send_failures) },
>> +	{ "tx%d_checksum_offload", IBMVETH_TXQ_OFF(checksum_offload) },
>> +};
> [Severity: Medium]
> Do some of these new ethtool -S keys duplicate counters that already have
> a standard netlink representation?
>
> The comment above the tables says only counters with no home in the
> standard interfaces belong here, and the changelog says ethtool -S keeps
> "only the driver-specific keys that have no standard equivalent". Looking
> at Documentation/netlink/specs/netdev.yaml:
>
>    tx-hw-gso-packets: Number of packets that necessitated segmentation
>                       into smaller packets by the device
>    tx-needs-csum:     Number of packets that required the device to
>                       calculate the checksum
>    rx-hw-drop-overruns: Number of packets dropped due to transient lack of
>                       resources, such as buffer space, host descriptors etc.
>
> tx%d_large_packets is the large-send/GSO packet count, tx%d_checksum_offload
> is incremented exactly where the driver asks the device to compute the
> checksum, and rx%d_no_buffer_drops is a buffer-exhaustion drop count.
>
> Meanwhile the new callbacks added in this same patch fill only packets,
> bytes, hw_drops and alloc_fail, leaving hw_gso_packets, needs_csum and
> hw_drop_overruns unset. Could those standard fields be filled in
> ibmveth_get_queue_stats_rx()/ibmveth_get_queue_stats_tx() instead of
> adding private strings, so the values are not exported through two
> different interfaces?
packets, bytes and drops already go through
netdev_stat_ops. large_packets, checksum_offload
and no_buffer_drops stay as driver-specific -S
keys. The thirteen existing -S names stay; no
hcall_* or pool%d_ keys.
> rx%d_invalid_buffers is also summed into hw_drops by
> ibmveth_get_queue_stats_rx(), so it appears in both places as well.
>
> [ ... ]
>
>> @@ -1017,6 +1143,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>   static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>>   					int queue_index)
>>   {
>> +	struct ibmveth_rx_queue_stats *qstats;
>>   	__be64 *p;
>>   	u64 drops;
>>   
>> @@ -1028,7 +1155,18 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>>   	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>>   	drops = be64_to_cpup(p);
>>   
>> -	adapter->rx_no_buffer = drops;
>> +	/*
>> +	 * PHYP's buffer-list page counter is absolute for that page. A new
>> +	 * page (reopen / queue reuse after -L) starts near zero; fold the
>> +	 * previous absolute into this queue's retired carry so sums stay
>> +	 * monotonic. Both fields belong to the queue being updated, so this
>> +	 * stays single-writer under the queue's replenish_lock.
>> +	 */
>> +	qstats = &adapter->rx_qstats[queue_index];
>> +
>> +	if (drops < qstats->no_buffer_drops)
>> +		qstats->no_buffer_retired += qstats->no_buffer_drops;
>> +	qstats->no_buffer_drops = drops;
>>   }
> [Severity: Medium]
> Can the retired page's count be lost when the new page is already ahead
> of the old value at the first sample?
>
> The only signal that the buffer-list page was replaced is the numeric
> decrease. ibmveth_close() samples the counter and leaves it in
> no_buffer_drops:
>
> 	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
> 		ibmveth_update_rx_no_buffer(adapter, i);
> 	ibmveth_free_all_queues(adapter);
>
> and the next ibmveth_open() gets a fresh zeroed page from
> ibmveth_alloc_rx_queues():
>
> 		adapter->buffer_list_addr[i] =
> 			(void *)get_zeroed_page(GFP_KERNEL);
>
> Between ibmveth_register_rx_queues() and the first per-queue
> ibmveth_replenish_task() in ibmveth_open() the LAN is live with no buffers
> posted, so PHYP can push the new page's counter up before the driver reads
> it. If the previous session ended at 50 and the new page reads 500 on the
> first sample, the "drops < qstats->no_buffer_drops" test is false and those
> 50 drops disappear from the adapter-wide rx_no_buffer key, from per-queue
> rx-hw-drops and from ibmveth_get_base_stats().
>
> Would recording the retirement at the point the page is actually released
> (close and queue reuse) be more reliable than inferring it from a decrease?
The decrease is the only signal the page was
replaced. Close already samples before free.
Patch 14 harvests under the lock before
publish on scale-down. A generation field is
not in this series.
> [Severity: Medium]
> This turns a single idempotent store into a two-field accumulating
> read-modify-write. Is every caller holding that queue's replenish_lock?
>
> ibmveth_close() calls it without the lock:
>
> 	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
> 		ibmveth_update_rx_no_buffer(adapter, i);
>
> while netpoll can run the same update concurrently under the lock:
>
>    netpoll_poll_dev() -> ndo_poll_controller
>      ibmveth_poll_controller()
>        ibmveth_replenish_task(adapter, i)
>          spin_lock_irqsave(&rxq->replenish_lock, flags)
>          ...
>          ibmveth_update_rx_no_buffer(adapter, queue_index)
>
> ibmveth_close() is also called directly from ibmveth_set_csum_offload(),
> ibmveth_set_tso(), ibmveth_change_mtu() and veth_pool_store() while
> netif_running() is still true, so netpoll_poll_disable() has not run.
> netpoll_poll_dev() only bails on a missing netpoll info, a held dev_lock,
> !netif_running() or local xmit activity, and ndo_poll_controller is not
> gated by NAPI state.
>
> With the old single store the worst case was a stale snapshot; with the
> new "no_buffer_retired += no_buffer_drops; no_buffer_drops = drops"
> sequence an interleaving can double the carry or lose it permanently.
>
> The RX shrink path later in the series wraps the identical call:
>
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
> 	ibmveth_update_rx_no_buffer(adapter, i);
> 	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
>
> with the comment that netpoll still reaches these queues. Should the close
> path take the same lock?
Scale-down already takes the lock. v7 takes it
on close() too, so the carry stays single-writer.
free_buffer_pool vs replenish, irqsave around
the fill, and skipping netpoll_poll_disable on
close stay leftover.
> [ ... ]
>
>> @@ -2038,6 +2176,10 @@ static void ibmveth_reset(struct work_struct *w)
>>   	netdev_dbg(netdev, "reset starting\n");
>>   
>>   	rtnl_lock();
>> +	if (netdev->reg_state != NETREG_REGISTERED) {
>> +		rtnl_unlock();
>> +		return;
>> +	}
>>   
>>   	dev_close(adapter->netdev);
>>   	dev_open(adapter->netdev, NULL);
> [Severity: Medium]
> Could this reg_state gate, together with the ibmveth_remove() reorder
> further down, be split out as its own patch with a Fixes: tag?
>
> The changelog acknowledges it: "That reorder is a use-after-free fix in
> its own right; it is carried here because this patch depends on it. No
> Fixes: tag".
>
> At the baseline the ordering defect is real. ibmveth_remove() has:
>
> 	cancel_work_sync(&adapter->work);
>
> 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> 		kobject_put(&adapter->rx_buff_pool[i].kobj);
>
> 	unregister_netdev(netdev);
>
> and the RX path can re-arm the work after that cancel:
>
>    ibmveth_poll_skip_bad_correlator() -> schedule_work(&adapter->work)
>    ibmveth_replenish_task()           -> schedule_work(&adapter->work)
>
> so the worker can run after free_netdev(). Both halves of that fix are
> here inside a roughly 500 line feature commit with no Fixes: tag, which
> makes the fix hard to identify or backport on its own.
>
> [ ... ]
v7 moves both halves to Patch 10 with the
reset producer: unregister then cancel, and
the NETREG_REGISTERED gate. They stay
together. No Fixes: peel. That is not the
unwind standalone (Fixes: d43732ce021f).
This patch frees the per-queue statistics
arrays between cancel_work_sync() and
free_netdev().
>> @@ -3132,6 +3372,124 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
>>   	return vlan_features_check(skb, features);
>>   }
>>   
>> +/**
>> + * ibmveth_get_stats64 - Return aggregated per-queue statistics
>> + * @dev: network device
>> + * @stats: rtnl link statistics storage
>> + *
>> + * Sums per-queue rx_qstats and tx_qstats into the rtnl counters.
>> + * Walk the full allocated arrays (not the live queue count) so shrinking
>> + * channels cannot make the totals go backwards.
>> + * Callers use ndo_get_stats64(); avoid updating netdev->stats on the
>> + * xmit/poll paths to keep per-queue counters off the hot cache line.
>> + */
>> +static void ibmveth_get_stats64(struct net_device *dev,
>> +				struct rtnl_link_stats64 *stats)
>> +{
>> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +	int i;
>> +
>> +	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
>> +		stats->rx_packets += adapter->rx_qstats[i].packets;
>> +		stats->rx_bytes += adapter->rx_qstats[i].bytes;
>> +	}
>> +
>> +	for (i = 0; i < IBMVETH_MAX_QUEUES; i++) {
>> +		stats->tx_packets += adapter->tx_qstats[i].packets;
>> +		stats->tx_bytes += adapter->tx_qstats[i].bytes;
>> +		stats->tx_dropped += adapter->tx_qstats[i].dropped_packets;
>> +	}
>> +}
> [Severity: Medium]
> Should this also fill rx_missed_errors or rx_dropped?
>
> The RX loop reports only packets and bytes, while the TX loop does report
> tx_dropped, so the RX drops the driver already tracks are not visible in
> rtnl_link_stats64 at all.
>
> include/uapi/linux/if_link.h describes the matching field:
>
>   * @rx_missed_errors: Count of packets missed by the host.
>   *   Counts number of packets dropped by the device due to lack
>   *   of buffer space.
>
> which is exactly what PHYP's buffer-list page counter records and what
> ibmveth_get_queue_stats_rx() below exports as rx-hw-drops.
>
> Documentation/networking/statistics.rst says:
>
>    Drivers should report all statistics which have a matching member in
>    struct rtnl_link_stats64 exclusively via `.ndo_get_stats64`.
>
> dev_get_stats() does not derive rtnl stats from netdev_stat_ops, so
> "ip -s -s link" shows zero RX drops on a device whose qstats and
> ethtool -S rx_no_buffer key are both climbing. Is that divergence
> intended?
Yes. ndo_get_stats64 is the device aggregate:
packets, bytes, and tx_dropped. RX drops live
in qstats hw_drops and the adapter-wide
rx_no_buffer key.
>> +
>> +static void ibmveth_get_queue_stats_rx(struct net_device *dev, int idx,
>> +				       struct netdev_queue_stats_rx *stats)
>> +{
> [ ... ]
>
>> +static void ibmveth_get_queue_stats_tx(struct net_device *dev, int idx,
>> +				       struct netdev_queue_stats_tx *stats)
>> +{
>> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +
>> +	stats->packets = adapter->tx_qstats[idx].packets;
>> +	stats->bytes = adapter->tx_qstats[idx].bytes;
>> +	stats->hw_drops = adapter->tx_qstats[idx].dropped_packets;
>> +}
> [Severity: Medium]
> Does dropped_packets match what tx-hw-drops is specified to count?
>
> Documentation/netlink/specs/netdev.yaml:
>
>          name: tx-hw-drops
>          doc: |
>            Number of packets that arrived at the device but never left it,
>
> In ibmveth_start_xmit() the counter is bumped for several conditions that
> happen entirely in the driver, before ibmveth_send() issues any hypercall:
>
> 	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
> 		adapter->tx_qstats[queue_num].dropped_packets++;
> 		goto out;
> 	}
>
> plus the ibmveth_is_packet_unsupported() loopback rejection, the
> skb_checksum_help() failure, skb->len > adapter->tx_ltb_size, and
> total_bytes != skb->len. None of those packets reached the device.
>
> The loopback case is reachable by any local sender addressing the
> device's own MAC. Would rtnl_link_stats64::tx_dropped alone (which this
> patch already populates) be the right home for these, keeping hw_drops
> for the ibmveth_send() failure only?
hw_drops is the queue-stats slot for drops.
get_stats64 already reports the same count as
tx_dropped. Splitting software vs send-fail
would hide the per-queue total.

Thanks,
Mingming
> The same mapping is used for the retired queues in
> ibmveth_get_base_stats():
>
> 	tx->hw_drops += adapter->tx_qstats[i].dropped_packets;
>
> [ ... ]
>
>> @@ -3380,12 +3755,20 @@ static void ibmveth_remove(struct vio_dev *dev)
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
> This is the second half of the reordering discussed above at
> ibmveth_reset(); the same question about lifting it into its own
> Fixes:-tagged patch applies here.
>

