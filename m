Return-Path: <linuxppc-dev+bounces-28188-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A3C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:44:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrjQ559Wdz2ygX;
	Fri, 25 Sep 2026 17:44:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790322253;
	cv=none; b=bV4vaCY7wpWhzvMzADkoy4Nokp3k9PWgeut/+pgInEv/5c756p141RXYTwVoSO2OrdxiCsgMUZv1PUzHQV7R2HPfdhhpdslWpR76xlL2UP5SG+tNuWLBzqLnGLD2GL3LT6/Coxf7uPJMPbxwAFUUj1aNB9jxKOcTdCSY7ysjIw2TIqzdde+1E503mP3MYgE7VlDpTmaZVtHkGgEbKEr3r3xG5qF7wcq2XQBNnOo7kgM1HrNO3ZEFwSb0Atf1rhzmd4HgXiOjUlhpbXhWdkXiFab4ZISkIH91wNmHTOGDzNbF0lR2JJ/Eg2Sur4ls9ggxfYMz3fnGZ7FSxlOZxrecmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790322253; c=relaxed/relaxed;
	bh=/Y7EoS9AFgWsUBFoQWmiiXG6auOXG91TnU/NVwNnJGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfRguuJyvNZBcviROAxqcVHd9KNfPjCna7HfvVBgPbs1T69AzOUklax2k+tAdLAa/ezb64/RKWHM5vmDo2unWaEU0MaSUqF8/VtUtmSAk6V/II7/vqZhrYpAGdQD7rgRTzDQotVeIydMRFKEu0XaF1XbR2UPFOQjxLVpjPjdMbyOHksyXInYoX0pbFFGzzt4itd5MG7OCRKO/PQR3EwsR6dCKhq9PhedU1Yvoz9Qqias3f0ZSGn0t4U8H7UTKZKb9CYzy80hATOWhApn/UefWsa61NA5NcxPDyP7F7ec4bZveMH+oWb4ZZLmB+GAPeaXxec2D25+RGfc1TWQkSrHAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lt/UurFX; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lt/UurFX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrjQ46j5yz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:44:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a9sK2393217;
	Fri, 25 Sep 2026 07:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Y7EoS
	9AFgWsUBFoQWmiiXG6auOXG91TnU/NVwNnJGI=; b=Lt/UurFXVpUUaUV6nqUV9K
	VuK6l31nVFXxD0SA67V0f42ECTjzy58m5Ocm4q5tPRZDgZ1dY4hEW4UkQh0fQncH
	d08VzjZwROmNuYhUAHC+v/l985B8NxpI41fBNJbNbET8yUKEwspusOihDMuIDrQ4
	KSBFGszU/qugCIN3d7ZROi70dQGbLYQLsjYA3ypEXfbvLIXjibtLNyJm/pAdr/wZ
	868nCOqU+h+hQJvPnGCm7hTGfEYTu3lLTVcV/jqdiB6tLdPUrjCJHwJgGTVmXVhP
	8Tps9M3muzbGFhtCf59k8YabkzVZEM7DgF5tIoWyluS4zend+3V8nLkRGqg5+Vwg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske25uad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:44:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lbww3298395;
	Fri, 25 Sep 2026 07:44:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k1jq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:44:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P7hxAS59244860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 07:43:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BD3458059;
	Fri, 25 Sep 2026 07:43:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF67C58065;
	Fri, 25 Sep 2026 07:43:56 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 07:43:56 +0000 (GMT)
Message-ID: <7fee78c3-b79e-48d7-932a-81a1f3083f64@linux.ibm.com>
Date: Fri, 25 Sep 2026 00:43:56 -0700
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
Subject: Re: [net-next,v6,15/15] ibmveth: Complete set_channels down-path and
 mq_fallback max_rx cap
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <7096819367d53e08c1f4d317616c2624a2867b7a.1788102125.git.mmc@linux.ibm.com>
 <178845904669.3394541.24513769216494846@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845904669.3394541.24513769216494846@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Beh9CQ_P7cFPrPo7VbFY_vBWGG69tFd4
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab62643 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=SjPlILDxLK7o8fCdeYwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfX0/t2uKi+FrKQ
 pXG0yYiPu/lJUj6VY2trzSVDGkg2KFU3yTZSTSA8iYFEmx3UtMjvYCnD6wE9SAw2TdjthpjJo3c
 atnyWmQKzC3qEnzuQCaN5wXMRSv56JY=
X-Proofpoint-GUID: RR7Q8duhBS04jNngrZRo7lxeHeJEaqBp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfX/7vteRYmqbt9
 4RKyoy5NPfXT2F0P4Zo4Kj7YVf8HIMsuQCv6OBVk8CI3f3i2N3Gnppkty+QB7wzYb0deR9G6QZo
 XYxTuE5M2hFDnzN3HFnpPtRe7Po2pTAQFMnC9S5w+ex0Bi+VOodWV2H81/Qw3ClRKECJ9iPobew
 Rq+JANUOE9Z7UG2uubQdKptGlE4bNoFiXf8z1AEjLTEYBGUzk5iZyQ7o1BdiL9p+gKyqwr/P+NO
 PuU7Hp+y12lyGyPsNkvuIaMIG2hIHEOa7D5JLWqnT9Ze0e1mtRjabXP0l4/ZFUPNmRGpV3u7KIH
 /QBBdm8h2/9pLKAj2hK6Vzc+h0Cdpea3cbJjKmDIkXEn7LTA+h3/jb0Wl6auKKJycYgNiV3Fo+Q
 BRqP6ofX98xjCnbYhkwTECTDRbiZJF774UfMcsuWiDLt9R9xngHtt3NKSRGu4qzqnct9hwf/IH4
 xscZ/gPhWYKBmYzDecw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250030

Thanks for the review!

On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 3
>
> - [Medium] Advertised RX channel range does not match the enforced range
>    once `mq_fallback` latches.
> - [Low] In `ibmveth_set_channels()` the comment above the RX rollback
>    describes code that no longer exists: it claims…
> - [Low] The new up-path TX-failure rollback in `ibmveth_set_channels()`
>    calls `ibmveth_resize_rx_queues_incremental(adapter, old_rx,…
> - [Low] `adapter->mq_fallback` is written with a plain store from
>    softirq/NAPI context — `ibmveth_replenish_task()` does…
>
> --
>
> ibmveth: Complete set_channels down-path and mq_fallback max_rx cap
>
> This completes the ethtool -L path in ibmveth: the down-path publishes the
> desired RX count without allocating, the up-path resizes RX then TX and
> rolls RX back if TX cannot reach the requested count, and get_channels()
> now caps max_rx at the live rx_count once mq_fallback is set.
> ibmveth_poll_controller() also returns early when the adapter is closed.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 5aef8a1f2c23d..4cd00ff3d43e4 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -3156,15 +3156,24 @@ static void ibmveth_get_channels(struct net_device *netdev,
>>   				 struct ethtool_channels *channels)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> +	unsigned int rx_count = ibmveth_get_num_rx_queues(adapter);
>>   
>>   	channels->max_tx = ibmveth_real_max_tx_queues();
>>   	channels->tx_count = netdev->real_num_tx_queues;
>>   
>> -	if (adapter->multi_queue)
>> +	/*
>> +	 * Always report the live RX count. ethtool -L is read-modify-
>> +	 * write, so a TX-only request echoes rx_count back at us; an
>> +	 * understated value would be applied as a silent RX shrink.
>> +	 * mq_fallback instead caps max_rx at the live count, which
>> +	 * blocks growth in the core without misreporting what is
>> +	 * currently configured.
>> +	 */
>> +	channels->rx_count = rx_count;
>> +	if (adapter->multi_queue && !adapter->mq_fallback)
>>   		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
>>   	else
>> -		channels->max_rx = 1;
>> -	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>> +		channels->max_rx = rx_count;
>>   }
> [Severity: Medium]
> Once mq_fallback is set, does the advertised max_rx still match what the
> driver will accept?
>
> Here max_rx becomes the live rx_count, which can be 8 or 16.  The core only
> bounds the request by that value, in ethtool_set_channels():
>
>      if (channels.rx_count > curr.max_rx ||
>          channels.tx_count > curr.max_tx ||
>
> So every value in 1..rx_count reaches the driver.  But
> ibmveth_resize_rx_channels() refuses any changed count above 1 in that
> state, after the no-op shortcut:
>
>      if (goal_rx == old_rx)
>              return 0;
>      ...
>      if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
>              netdev_err(netdev,
>                         "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
>                         goal_rx);
>              return -EOPNOTSUPP;
>      }
>
> With mq_fallback set and a live count of 8, ethtool -l reports max_rx 8 while
> ethtool -L ethX rx 2 through rx 7 all fail with -EOPNOTSUPP; only 1 and the
> current count are accepted.
>
> This state looks persistent rather than transient, since
> ibmveth_register_rx_queues() latches the flag and then fails the open:
>
>      if (rc) {
>              /* Firmware MQ gone: fall back to SQ on next open. */
>              if (rc == -EOPNOTSUPP)
>                      adapter->mq_fallback = true;
>              goto err_unregister;
>      }
>
> adapter->opened stays false and num_rx_queues keeps its old value above 1
> until the next successful open.
>
> Would it be clearer to advertise max_rx = 1 in the fallback state and keep
> the no-op shortcut for the read-modify-write case?  The kernel-doc for
> ibmveth_resize_rx_channels() ("Rejects rx > 1 without MQ firmware
> (-EOPNOTSUPP)") also does not mention that the no-op shortcut precedes the
> gate.
get_channels reports the live count and
caps max_rx at that count once mq_fallback.
Advertising max_rx = 1 while rx_count is
still live fails the core (rx_count >
max_rx) and blocks a TX-only ethtool -L.
Clamping rx_count would shrink RX. rx > 1
is -EOPNOTSUPP except the current-count
no-op.
> [Severity: Low]
> Is the read of adapter->mq_fallback here synchronized against its writer?
>
> The flag is stored from softirq/NAPI context in ibmveth_replenish_task(),
> after the replenish_lock has already been dropped:
>
>      spin_unlock_irqrestore(&rxq->replenish_lock, flags);
>      ...
>              adapter->mq_fallback = true;
>              schedule_work(&adapter->work);
>
> The new reader added here, and the capability gate in
> ibmveth_resize_rx_channels():
>
>      if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
>
> run under RTNL / the netdev ops lock, which does not exclude the softirq
> writer.  There is no lock, no READ_ONCE()/WRITE_ONCE() and no acquire/release
> pairing on this field, while the sibling field num_rx_queues in the same
> struct is deliberately published with:
>
>      smp_store_release(&adapter->num_rx_queues, num);
>
> A stale false read here would advertise max_rx = IBMVETH_MAX_RX_QUEUES right
> after firmware refused MQ buffer adds, and a stale read in the gate would let
> the driver allocate and replenish RX queues on that firmware, re-latching
> mq_fallback and queueing another reset.  Would WRITE_ONCE()/READ_ONCE() on
> mq_fallback, or folding it into the existing publish/consume helpers, be
> appropriate?
No — RTNL does not exclude the NAPI store, so
this is an unannotated race. v7 keeps it as a
benign sticky latch: a stale false is one extra
MQ attempt, then the flag latches again.
WRITE_ONCE on the store without READ_ONCE on
apply / get_channels / set_channels is only half
a pass, so I left it plain. Happy to annotate
the store and all three readers together if you
would prefer that spelled out.
>> @@ -3233,28 +3242,83 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   				struct ethtool_channels *channels)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> -	unsigned int old = netdev->real_num_tx_queues,
>> -		     goal = channels->tx_count;
>> +	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
>> +	unsigned int goal_rx = channels->rx_count;
>> +	unsigned int old_tx = netdev->real_num_tx_queues;
>> +	unsigned int goal_tx = channels->tx_count;
>> +	unsigned int want_tx = goal_tx;
>> +	bool rx_changed = false;
>>   	int rc, i;
>>   
>> -	/* Validate RX (and resize when opened) before the down-path
>> -	 * early return so MQ/range errors are reported here. Publishing
>> -	 * the desired RX count and CMO while down is the next patch.
>> -	 */
>> -	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
>> +	if (goal_tx < 1 || goal_tx > ibmveth_real_max_tx_queues()) {
>> +		netdev_err(netdev,
>> +			   "Invalid TX queue count %u (must be 1-%u)\n",
>> +			   goal_tx, ibmveth_real_max_tx_queues());
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* RX range / MQ checks live in ibmveth_resize_rx_channels(). */
>> +	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
>>   	if (rc)
>>   		return rc;
> [ ... down-path publish/rollback block snipped ... ]
>
>> -	return rc;
>> +	if (netdev->real_num_tx_queues != want_tx) {
>> +		if (rx_changed) {
>> +			/*
>> +			 * Only meaningful once RX is live. num_slots is
>> +			 * embedded in the adapter and outlives the DMA ring,
>> +			 * so reading it at function entry is safe but can
>> +			 * return a stale geometry from before the resize.
>> +			 */
>> +			int rxq_entries = adapter->rx_queue[0].num_slots;
> [Severity: Low]
> This isn't a bug, but does this comment still describe the code below it?
>
> It says num_slots is read "at function entry" and "can return a stale
> geometry from before the resize", yet the read it annotates happens right
> here, inside the if (rx_changed) block, after ibmveth_resize_rx_channels()
> has already changed the RX geometry.  Function entry only reads
> num_rx_queues, real_num_tx_queues, channels->rx_count and channels->tx_count.
>
> The comment looks like a leftover from the v5 layout mentioned in the
> changelog, and now warns about a hazard that would only exist if the read
> were moved back to function entry.
The comment was leftover from the earlier
layout. The read is after the RX resize.
v7 replaces it to match that restore.
>> +			int rb;
>> +
>> +			rb = ibmveth_resize_rx_queues_incremental(adapter,
>> +								  old_rx,
>> +								  rxq_entries);
>> +			if (rb)
>> +				netdev_err(netdev,
>> +					   "Failed to roll back RX queues to %u after TX failure: %d\n",
>> +					   old_rx, rb);
>> +		}
>> +		return rc ? rc : -ENOMEM;
>> +	}
> [Severity: Low]
> Can this rollback re-attempt a queue geometry that the forward path would
> have refused?
>
> The rollback calls ibmveth_resize_rx_queues_incremental() directly, so the
> multi_queue / mq_fallback gate in ibmveth_resize_rx_channels() is not
> consulted.  That gate only rejects goal_rx > 1:
>
>      if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
>              ...
>              return -EOPNOTSUPP;
>      }
>
> Consider adapter->opened true, mq_fallback already latched from softirq in
> ibmveth_replenish_task():
>
>      adapter->mq_fallback = true;
>      schedule_work(&adapter->work);
>
> and a live RX count of 8.  A request of rx 1 with a larger tx passes the gate
> (goal_rx is 1), RX shrinks 8 -> 1 and rx_changed becomes true.  If the TX
> step then fails in ibmveth_allocate_tx_ltb() or
> netif_set_real_num_tx_queues(), the rollback runs the scale-up path back to
> old_rx = 8 on firmware that has already refused MQ buffer adds, so
> H_REG_LOGICAL_LAN_QUEUE / replenish hit the same H_FUNCTION, mq_fallback is
> re-latched and another schedule_work(&adapter->work) reset is queued from an
> ethtool error path.
>
> Would it be better to route the rollback through
> ibmveth_resize_rx_channels(), or to skip it when mq_fallback is set and leave
> RX at 1?
>
> [ ... ]
The rollback restores the count we just
left. If firmware already refused MQ, that
scale-up can fail and latch again. !opened
is the documented down path and does not
allocate.

Thanks,
Mingming

