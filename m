Return-Path: <linuxppc-dev+bounces-28176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF4DC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:41:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrh1F2zj7z30V6;
	Fri, 25 Sep 2026 16:41:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790318465;
	cv=none; b=AIrhMwOrlwR70jaM4H3Y83a/4VUTAILLy09egtIruWsccBnj99QkhPjZKhOAo3BdDD8yT2cnULn+0zH5Q6nPQypFn06uhdxm2qKX7YJ51xM7dCeyDU+oGU8Fze+2f/x2UpqaqvQ+t4iwj2KKJm5+DwbqYAfr/ywfa2b/Ojr8mzkEklFBtGKbvPCHJ+VvD8YkMpE7cYlQ++twrGsSbTieAb84yF37ylEljgOEOOr8SDwpN5PGf63gaFKBBpoirEnQqBLHY9hZY118im06MFfCf9ILc3ZX1qyokV1zblFhpI97joL5c5etGKufk7g0OGCeRaAPnq/fD6N+UmpYHs452w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790318465; c=relaxed/relaxed;
	bh=wF9HpPH3vjeXy06Suqf3VTiOYSomL18Ve9JawjErtS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4Xi78ZYwrYDPMiL1DqLWJna7puAxBweAPCorCzlbA3/5r/OIZX0oNMTMBP3BzqW4Ty0/OHz9gQcmZjGMPa11DLtT1TuJhMGXl2hmxlWU+aZhqzQhdWZVeQdOATuLUc+APYBoeviy9wpmrALnPBmQiIPMh47skkW3hfDVmmjMzfEFVnupKbaMAzZy+LHm1q0dw22ZbXk7V2La5HYZbMNfAh71AoOLBJXpHoDUxizxwh/z5Xcf3OqGbV0J5WUUdI9lDa8HozGCOEoWtYPfOs0n30w8vY2S7vYLTFywJ8x9abzcafAKffxuPzTtXVZlV3gSwcOuX0LVw7CR/B1lZQ20A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JVnV9VZy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JVnV9VZy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrh1D3B7Vz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:41:04 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aU08061729;
	Fri, 25 Sep 2026 06:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wF9HpP
	H3vjeXy06Suqf3VTiOYSomL18Ve9JawjErtS4=; b=JVnV9VZyf6ZoUQbeWvVacE
	1xbmrSA2fQT6VHEH65VQ/Zi114cTT+BV/J59HqUjO+RY1crgdhxXB1TiJygD8pZY
	Y49nMve6we9HO3mRrFtnWSXpbQGWOf6wa7FtcwvGBocgt293R3upKN84d02ZB6xo
	pdaovm7DyjNmzqBDEoEJvMr8nAah5zSV6LxsHLDbv//VKU3NqU5vNobEzmqrQztA
	CapKULO+s5RuJQh4wAj34AElSiCb5eokfi34K4gYpsD1tKWER7IrSUonwR7isvrJ
	VAcNfLqM9ar9ZlUtMdx+znciVW75fRW8QgWmvky0YM0FS4neWVRXig6A9qVe8KWA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsnhd4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:40:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4m4C33249867;
	Fri, 25 Sep 2026 06:40:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt319cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:40:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6epOR31064816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:40:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 952D658066;
	Fri, 25 Sep 2026 06:40:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D744B58055;
	Fri, 25 Sep 2026 06:40:48 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:40:48 +0000 (GMT)
Message-ID: <f35e4030-24b7-452e-85d3-6e1e4205260a@linux.ibm.com>
Date: Thu, 24 Sep 2026 23:40:48 -0700
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
Subject: Re: [net-next,v6,09/15] ibmveth: Harden RX poll path with helpers
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <2c0302ff17e945a742d0f0b79265ee556e3bf66a.1788102125.git.mmc@linux.ibm.com>
 <178845903884.3394541.9429373266253586035@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845903884.3394541.9429373266253586035@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab61777 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=GR1NILx-XGr8eRPm090A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vF9w4A1OOFoCvYNj2Jklbxm8MTuKij33
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfXz0gWWqEnC8H0
 64v//3aNWX6IdHzvhvIH45d9M3XOokcdwyAMEaXMykGKQOCBkfcB3TAdObdRzyRKKUR/xq3rCpD
 LZV4iuwDzsNz77CpHNrPEnmwV5oJSljccsJ9a3+wpXSjF97OPzV0gH5cs8MvZmzl4KaJU+wNW69
 y2VO/Og0d+2Ng0ivrWQl/ufEKRxhAcFUoxGsW1DRdF+J8w7Ye6V1ttkapTrbm+TDy+Vd5bPVZ7V
 G2bJqKxdo84tq54KTo9iXDdXEfTwPrvZ9kAXW0XFbJUWQ+noyBc9Ey4uU0MO6I5BpGGwdZdO7De
 uBTrniAPI7cFkP2nT5+7g+qu8pHCSRcow4AhmIOHx9tB4C7EP6HKUjnpGI5GxFVbHEmFprSOO2x
 DaLEkD44EZvX3KwrI+38RimXG9pHE9TWMcn9y6N2YPjEZggauzXKaAU00Fb6weTUY1qQrwUgK9G
 zZals6tyZO3BsSfe2MQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfXzJYTmKyte/sH
 ioxUbAjr2mABrMJyQorpPvgYgS4PvX459pO7d8rntUZjGx4+rfTiw9AWSjORutjIIVtK60oKmjD
 fCESVWlbGs/C0Wrq6INZKB/0BhPFbJs=
X-Proofpoint-GUID: -xsvysAJl4a9Yd0xwdKMCFDaZDW5AO5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250026


On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
>
> Critical: 0 · High: 2 (1) · Medium: 2 · Low: 0
>
> - [High] The new ibmveth_poll_stopping() check placed between
>    napi_complete_done() and ibmveth_enable_irq() cannot prevent a…
> - [High] The new oversize guard in ibmveth_poll_deliver_frame() bounds
>    the PHYP-reported offset+length against skb_tailroom(skb) instead of…
> - [Medium] A real, user-visible sk_buff leak fix is buried inside a
>    199-line helper-extraction patch with no Fixes: tag and no Cc: stable.
> - [Medium] All 'skip the slot' outcomes (invalid descriptor, bad
>    correlator, oversize offset+length) neither increment frames_processed…
>
> Pre-existing issues:
> - [High] ibmveth_remove() calls cancel_work_sync(&adapter->work) while
>    the netdev is still registered and RX NAPI/IRQ paths are live, then…
>
> --
>
> ibmveth: Harden RX poll path with helpers
>
> This splits the RX slot handling in ibmveth_poll() into a set of small
> helpers (poll_stopping, harvest_slot, recycle_invalid, skip_bad_correlator,
> drop_oversize, deliver_frame, bump_invalid) so the NAPI callback becomes a
> thin budget loop.  Along with the motion it adds an offset+length bounds
> check before skb_put(), frees the copybreak skb on a harvest error, and
> adds stopping checks so close/napi_disable does not re-arm PHYP delivery.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 46f68f5b52e70..f726d1e3f0b11 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -2382,125 +2380,236 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>>   	}
>>   }
>>   
> [ ... ]
>
>> +static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
>> +				      int queue_index, bool reuse)
>> +{
>> +	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
>> +
>> +	return !rc || rc == -EINVAL || rc == -EFAULT;
>> +}
> [Severity: Medium]
> Can this helper ever return false?  ibmveth_rxq_harvest_buffer() documents
> and returns only 0, -EINVAL or -EFAULT:
>
> 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
> 	if (unlikely(rc)) {
> 		/* Skip a corrupt slot without claiming pool ownership. */
> 		if (rc == -EINVAL || rc == -EFAULT)
> 			ibmveth_rxq_advance(rxq);
> 		return rc;
> 	}
>
> so every "break" in ibmveth_poll_recycle_invalid(),
> ibmveth_poll_skip_bad_correlator() and ibmveth_poll_drop_oversize() looks
> unreachable.
>
> Combined with the budget accounting in the loop below, is there anything
> left that bounds one ibmveth_poll() invocation?  A skipped slot returns 0
> from ibmveth_poll_deliver_frame(), so neither the break nor
> frames_processed++ runs:
>
> 		rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
> 						queue_index);
> 		if (rc < 0)
> 			break;
> 		if (rc > 0)
> 			frames_processed++;
>
> and each skip recycles the slot with reuse=true, after which
> ibmveth_replenish_task() re-posts it.  The tail of ibmveth_poll() then does:
>
> 	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
> 	    napi_schedule(napi)) {
> 		ibmveth_disable_irq(adapter, queue_index);
> 		goto restart_poll;
> 	}
>
> which re-enters the loop in the same invocation with frames_processed
> unchanged.  If PHYP keeps publishing skippable slots (stale ring contents,
> malformed completions), does the frames_processed == budget exit ever
> become reachable, and does this poll ever return?
>
> The reset escalation in ibmveth_poll_skip_bad_correlator() uses
> schedule_work(), which queues on the current CPU via system_percpu_wq, so
> would the worker be able to run while that CPU is stuck in the poll?  The
> ibmveth_poll_drop_oversize() path escalates nothing at all.
>
> The commit message states:
>
>      Skipped and dropped slots do not count against the NAPI budget; only
>      a delivered frame does.
>
> Is that intentional given it removes the only bound on the loop?
Yes. harvest only returns 0/-EINVAL/-EFAULT, so
harvest_slot is always true. That break is not a
bound.

The loop caps delivered frames, not slots, so
there is no strict per-invocation slot bound.
Each skip advances the ring, so any finite
backlog drains, but a stream of invalid
completions would keep this poll running.
restart_poll can re-enter if PHYP posts more.
skip_bad queues a reset; that worker cannot run
if this poll never returns. drop_oversize
harvests only. I am not counting skips toward
budget: that would starve real packets on a
corrupt ring.
>> +
>> +static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
>> +					 struct ibmveth_adapter *adapter,
>> +					 int queue_index)
>> +{
>> +	netdev_dbg(netdev, "recycling invalid buffer\n");
>> +	ibmveth_poll_bump_invalid(adapter, queue_index);
>> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
>> +}
>> +
>> +static bool ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
>> +					     struct ibmveth_adapter *adapter,
>> +					     int queue_index)
>> +{
>> +	if (net_ratelimit())
>> +		netdev_err(netdev,
>> +			   "bad correlator on queue %d, skipping slot\n",
>> +			   queue_index);
>> +	/* Residual stale slot after resize: recover via reset rather
>> +	 * than spinning forever. Always escalate; only the log is
>> +	 * rate-limited.
>> +	 */
>> +	schedule_work(&adapter->work);
> [Severity: High]
> This isn't a bug introduced by this patch, but this adds another NAPI-side
> producer of adapter->work while ibmveth_remove() still cancels that work
> before the device is quiesced:
>
> 	cancel_work_sync(&adapter->work);
>
> 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>
> 	unregister_netdev(netdev);
>
> 	free_netdev(netdev);
>
> Can a poll running on another CPU call schedule_work(&adapter->work) from
> here (or from the ibmveth_enable_irq() failure path in ibmveth_poll())
> after cancel_work_sync() has returned?  Nothing cancels or flushes it
> again, and adapter is netdev_priv(netdev), so the queued work_struct and
> everything ibmveth_reset() touches would be freed by free_netdev().
>
> For the record, the ordering appears to be repaired later in this series:
> at the series tip ibmveth_remove() moves the cancellation after
> unregister_netdev(), with a comment that cancel_work_sync() before
> unregister left a window where poll could schedule_work() and the worker
> ran after free_netdev().
Yes, at this commit. Patch 10 unregisters
first, then cancel_work_sync, and the reset worker
is gated on NETREG_REGISTERED. The order and the
gate belong together with the reset producer;
that pair is in Patch 10.
>> +	ibmveth_poll_bump_invalid(adapter, queue_index);
>> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
>> +}
>> +
> [ ... ]
>
>> +static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
>> +				      struct ibmveth_adapter *adapter,
>> +				      struct net_device *netdev,
>> +				      int queue_index)
>> +{
> [ ... ]
>
>> +	room = skb_tailroom(skb);
>> +	off = offset;
>> +	len = length;
>> +	if (unlikely(off >= room || len > room - off)) {
>> +		if (!ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
>> +						off, len, room))
>> +			return -1;
>> +		return 0;
>> +	}
> [Severity: High]
> Should the bound here be pool->buff_size rather than skb_tailroom(skb)?
>
> ibmveth_replenish_buffer_pool() allocates, maps and advertises exactly
> pool->buff_size to the hypervisor:
>
> 	skb = netdev_alloc_skb(adapter->netdev, pool->buff_size);
> 	...
> 	dma_addr = dma_map_single_attrs(dev, skb->data, pool->buff_size,
> 					DMA_FROM_DEVICE, DMA_ATTR_NO_WARN);
> 	...
> 	descs[filled].fields.flags_len = IBMVETH_BUF_VALID | pool->buff_size;
>
> netdev_alloc_skb() rounds up to an allocator bucket, so skb_tailroom() on
> an untouched pool buffer is larger than buff_size (a 16 KiB pool buffer
> lands in a 32 KiB allocation).  Does a PHYP-reported off+len in the
> (buff_size, tailroom] gap pass this check and then get committed and
> delivered?
>
> 	skb_put(skb, length);
> 	skb->protocol = eth_type_trans(skb, netdev);
> 	...
> 	napi_gro_receive(napi, skb);
> That would hand uninitialised slab bytes outside the DMA mapping to the
> stack, and on the copybreak path skb_copy_to_linear_data() plus
> ibmveth_flush_buffer(skb->data, length + offset) would touch addresses
> past the mapped window.  The commit message says deliver "rejects a PHYP
> offset+length that would skb_put() past the buffer" - is the buffer here
> meant to be the hardware-visible one?  The correlator has already been
> validated by ibmveth_rxq_correlator_valid(), so
> adapter->rx_buff_pool[queue_index][correlator >> 32].buff_size is
> available as the bound.
Yes — a length in (buff_size, tailroom] would pass
on v6. skb_tailroom is the skb_put bound. The DMA
map is pool->buff_size, and alloc can leave slack.
v7 uses min(tailroom, buff_size). The pool index
is the current slot's correlator; get_buffer
already validated it.
>> +
>> +	if (lrg_pkt) {
>> +		__be64 *rxmss = (__be64 *)(skb->data + 8);
>> +
>> +		mss = (u16)be64_to_cpu(*rxmss);
>> +	}
>> +
>> +	new_skb = NULL;
>> +	if (length < rx_copybreak)
>> +		new_skb = netdev_alloc_skb(netdev, length);
>> +
>> +	if (new_skb) {
>> +		skb_copy_to_linear_data(new_skb, skb->data + offset, length);
>> +		if (rx_flush)
>> +			ibmveth_flush_buffer(skb->data, length + offset);
>> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
>> +		if (unlikely(rc)) {
>> +			kfree_skb(new_skb);
>> +			return -1;
>> +		}
> [Severity: Medium]
> This kfree_skb(new_skb) is a real fix for an sk_buff leak that exists at
> the baseline in ibmveth_poll():
>
> 	new_skb = netdev_alloc_skb(netdev, length);
> 	...
> 	skb_copy_to_linear_data(new_skb, skb->data + offset, length);
> 	...
> 	if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
> 		break;   /* new_skb is neither freed nor handed to the stack */
>
> Could this be split into its own patch with a Fixes: tag (and Cc: stable)
> so it can be routed to net and picked up by older trees?  Buried in a
> 199-insertion helper extraction it is not separable for backporting.  The
> same applies to the new offset+length validation, which the commit message
> describes as preventing an skb_put() past the buffer.
The kfree_skb on the copybreak harvest-fail path
stays here. Same for the offset+length check; I am
not peeling a Fixes: patch out of this extract.
The off/len test has no parent SHA.
Neither is the unwind standalone
(Fixes: d43732ce021f).
>> +		skb = new_skb;
>> +	} else {
>> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
>> +		if (unlikely(rc))
>> +			return -1;
>> +		skb_reserve(skb, offset);
>> +	}
> [ ... ]
>
>> +	return 1;
>> +}
>> +
>>   static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   {
> [ ... ]
>
>>   	if (frames_processed == budget)
>>   		goto out;
>>   
>>   	if (!napi_complete_done(napi, frames_processed))
>>   		goto out;
>>   
>> -	/* We think we are done - reenable interrupts,
>> -	 * then check once more to make sure we are done.
>> +	/*
>> +	 * napi_disable() sets DISABLE then waits for this poll. Without a
>> +	 * second stopping check here, enable_irq() can re-arm PHYP after
>> +	 * resize already masked the queue; late IRQs then hit the handler
>> +	 * after num_rx_queues was published lower (lab WARN at interrupt).
>>   	 */
>> +	if (ibmveth_poll_stopping(netdev, napi))
>> +		goto out;
>> +
>>   	rc = ibmveth_enable_irq(adapter, queue_index);
> [Severity: High]
> Does this check actually close the window it describes?  It is a
> check-then-act pair, and both predicates in ibmveth_poll_stopping() go
> false exactly when teardown is finishing:
>
> 	return !netif_running(netdev) || napi_disable_pending(napi);
>
> napi_disable_locked() clears the DISABLE bit before returning:
>
> 	clear_bit(NAPI_STATE_DISABLE, &n->state);
>
> so napi_disable_pending() is false once close is past its wait.  And
> netif_running() stays true for the driver's internal close callers -
> ibmveth_change_mtu(), ibmveth_set_mac_addr(), the features paths and
> veth_pool_store() all do "if (netif_running(dev)) ibmveth_close(dev);".
>
> Sequence:
>
> CPU0 ibmveth_poll()
> 	napi_complete_done()		/* clears SCHED */
> 					/* delayed: hard IRQ, or vCPU
> 					   dispatch preemption on a
> 					   shared-processor LPAR */
>
> CPU1 ibmveth_change_mtu() -> ibmveth_close() -> ibmveth_cleanup_rx_interrupts()
> 	napi_disable()			/* clears DISABLE on return */
> 	ibmveth_disable_irq(adapter, i);
> 	synchronize_irq(adapter->queue_irq[i]);
> 	free_irq(...)
>
> CPU0 resumes:
> 	if (ibmveth_poll_stopping(netdev, napi))	/* false */
> 		goto out;
> 	rc = ibmveth_enable_irq(adapter, queue_index);	/* re-arms PHYP */
>
> Can the queue end up unmasked after the final remask and after free_irq()
> removed the handler?  That is the case the commit message claims to close:
>
>      ibmveth_poll_stopping() ensures close/napi_disable does not re-arm PHYP.
>
> Would moving the unmask before napi_complete_done(), or moving close's
> final remask after synchronize_net(), be a more reliable ordering than
> adding another check here?  This looks unchanged at the series tip.
The check is not a close barrier. After
napi_disable() returns, DISABLE is clear, and an
internal close+open can leave IFF_UP set. Teardown
already masks PHYP before napi_disable. Inverting
that left IFF_UP with PHYP unmasked. I am not
moving unmask before napi_complete_done or
moving the remask after synchronize_net().

Thanks,
Mingming
>>   	if (rc) {
>>   		netdev_err(netdev,
> Thanks for looking at these.
>

