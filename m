Return-Path: <linuxppc-dev+bounces-25709-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B240C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 02:47:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJwz00ZCCz2yrt;
	Tue, 11 Aug 2026 12:47:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786416476;
	cv=none; b=ZIbprIqpcXACr9Dnh9s9IAYEfziWsA2qnuT7yrm9XhnDAlw7y18YwM/1SnjGZoupU1aYN5WYkd6gd5x1kyvZjMx26xqmnd83GWVQnC+7vxYhexAxZ4XQZxW3LCsPRtGWwit5JglEfqG98IvSFJ5PpORWZvjXrXF5I6IQSt9VYCIXCNuukq1GeXmFFvU0F9VkRjG/LQteeGyBsnr5sRktqhO0s7YSwctUZ7kDInA/uSuZi1QbE8WMV/fuRvNKR43AsQATN/OMflQmdQLtHjLD3XU9uqfd38GOTNR7ac+1kNBncNxo7H3boy/d/SeQuyT0FZEtOTYxjpvRhAp+6gHXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786416476; c=relaxed/relaxed;
	bh=2biBhxZ/VOxWdDfJI692niSxKHVrkfqBuh9Urff0Sz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACJlf7QmirUfCT7o2YOfC6UHdsdMlIfarGXcqvdssoW+j8kTY/C/cnmzJR3coaGqGZmqUD5KVBbLq+MHmlzBtf3y3wsl5phXnCd5vyqpps9bJUW/em5fNXSyHjCIEm4pzMJ9bRc+PvE7/OlQMCWgcC0WULQBN1ZUvcNobJURRgaskXNIRTQf9RH0s3fEnmDn0y81aKRpF0XZS/fMi9v0D5qpZ2vuDnueJHX5MEhyAiHDxO+TPpMcxy1oUDBEPxJtpfov1FH7G/8x/xATMz+EcwXPpVpDngTQ4qJocQnFlHpxBaE0fP241DmjeOgltN0k1/WsLzirdm9Yg5tr0/Ymew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I3Jn6gAG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I3Jn6gAG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJwyy3Tk9z2yjv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 12:47:54 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN2B9h2921269;
	Tue, 11 Aug 2026 02:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2biBhx
	Z/VOxWdDfJI692niSxKHVrkfqBuh9Urff0Sz8=; b=I3Jn6gAGGaRIfg4JHLUg2F
	gny3nf+M6wJ96jyxH+pZpC1r8J9c5eKkxFI9KsEaSEtdhVCNxikJeutl2cDDpTLo
	EOV5r/AHiPPwL2RVxo4seDJtz4xRoO/dszUyiR+r0iBhmKimI8u9BmqHf7OsGTrV
	IRLPDA2zRgAcD7o/btdX3/oS4AqVNsdnH+sZQWr+HI57fR3b9A200hLwi37c/l1c
	nND7iyDO5fbLlCqO8Saj1k1THF3NYQjFbDJc/aMxV2c3WVkRkaq5PSjEbeGJOM+u
	n1mEYNJ4APIYXsW2DZPghsNH65/XI3qYphlVh57TYuvuCMJ05p2QxxDc3GGMaOXw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9b0bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 02:47:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B2fHI9002825;
	Tue, 11 Aug 2026 02:47:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gy7f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 02:47:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B2ldua32178908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 02:47:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61FEE58056;
	Tue, 11 Aug 2026 02:47:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 765EE5803F;
	Tue, 11 Aug 2026 02:47:37 +0000 (GMT)
Received: from [9.67.11.26] (unknown [9.67.11.26])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 02:47:37 +0000 (GMT)
Message-ID: <1c06bcb0-d614-47d3-8849-b8d52256e548@linux.ibm.com>
Date: Mon, 10 Aug 2026 19:47:36 -0700
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
Subject: Re: [PATCH net-next v4 13/14] ibmveth: Wire ethtool set_channels to
 MQ RX queue resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <135011a5c18abead73784a587ed20d1518168a2d.1785457143.git.mmc@linux.ibm.com>
 <20260806183713.3175936-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183713.3175936-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wiKKb1SuamxDDax2X1OzOjfNpOeXhGKg
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a8d4e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SN66Gf6-QcupK432ZYEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAxOCBTYWx0ZWRfX9G5Fjwed22Ht
 939gNecEKOGeS9BoVjSGoBM8651ag1o+9q2a/b3kJmy3Y3BMkZd/NYbC2BhMru1qXnbAKNCHKaq
 THG8/H6CcT3un6kbR6iYfRA2dvEPRn7nLQ67bnp9VDfKTZTB67ojHYL+3XDtbXExGW5IvE7yJ21
 9fzAZ5s17/dDgN+k6iAp3MBCyZVywbx/Lf0ltTqNb7QIe01SlP2/IpHcVSDOh5kAbzpvlCuFjKm
 aSTuqH3fBKS/0ldJfykIfMwDfjFf/bZnPYSdy63fCZePSKlkYiY1hNVpZ7IRHLLjjswf5SSTvUz
 RszNIUoEUO7E/XU3jr3KOphLR3e7uHQ5vXA0h/XLHWrvMZt02N4w+jQnBY42/bOFnKstjDmzGs7
 nMl1RvIXRL31aqO6q+WQSVrW7Y3Wgx07rRC0qZqgZ9DecIwPffIqsrCmDNCvEvoAJ6Flnix/pOk
 rXxP0Nfeaa7oynPm1Kw==
X-Proofpoint-ORIG-GUID: 5TUDfrW0FvgpO1zKnc_p9QXcZ8vSkwRY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAxOCBTYWx0ZWRfX5oSS5r6tiF30
 5JTo/sRFLhcZJMXhQm3WQXU29ybAc8bWwqCogFNOHzGi8zdluqrv1s4BCnRLFpfMTONgh+ZSvay
 Pj1e9DX/YzEEglmXTyXc14Tj/i3D494=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110018


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Wire ethtool set_channels to MQ RX queue resize
>
> This completes the RX side of ibmveth_set_channels(): when the interface is
> down the TX queue count is published and the desired RX count is stashed for
> the next open(), and when it is up the RX resize runs through
> ibmveth_resize_rx_channels() before the existing TX LTB alloc/free path. It
> also renames the TX bookkeeping variables to old_tx/goal_tx and adds an early
> return when the TX count is unchanged.
>
> A few questions below.
Hi Jakub,

Thanks for the review.

>>        - Non-MQ firmware returns -EOPNOTSUPP for rx > 1.
>>        - Validate rx_count within 1..IBMVETH_MAX_RX_QUEUES.
> [Severity: Low]
> Do these two bullets describe changes that are actually in this patch?
>
> Both checks live in ibmveth_resize_rx_channels() in
> drivers/net/ethernet/ibm/ibmveth.c:
>
> 	if (goal_rx > 1 && !adapter->multi_queue) {
> 		...
> 		return -EOPNOTSUPP;
> 	}
>
> 	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
> 		...
> 		return -EINVAL;
> 	}
>
> and they were added by the preceding patch "ibmveth: Implement incremental MQ
> RX queue resize". This patch neither adds nor changes them.
>
> Related to the split: the parent commit carried a comment in
> ibmveth_set_channels() that referred to the patch series itself, which this
> patch now deletes:
>
> 	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
> 	 * in this patch. !IFF_UP RX stash ordering lands next.
> 	 */
>
> Could that comment be dropped from the parent instead, so no committed state
> of the tree describes an unfinished series?
Yes, those bullets belong with the earlier resize helper rather than
this wiring patch.

I’ll move that description to the earlier patch and drop the
series-self-referential comment so no intermediate commit describes an
unfinished series.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index b57c7df92853f..c99d8e8be7b37 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -2723,20 +2723,28 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   				struct ethtool_channels *channels)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> -	unsigned int old = netdev->real_num_tx_queues,
>> -		     goal = channels->tx_count;
>>   	unsigned int goal_rx = channels->rx_count;
>> +	unsigned int old_tx = netdev->real_num_tx_queues;
>> +	unsigned int goal_tx = channels->tx_count;
>>   	int rc, i;
>>   
>>   	/* If ndo_open has not been called yet then don't allocate, just set
>>   	 * desired netdev_queue's and return
>>   	 */
>> -	if (!(netdev->flags & IFF_UP))
>> -		return netif_set_real_num_tx_queues(netdev, goal);
>> +	if (!(netdev->flags & IFF_UP)) {
> [Severity: High]
> Is netdev->flags & IFF_UP a reliable proxy here for "the driver holds RX
> resources"?
>
> ibmveth tears down and re-creates its resources internally while IFF_UP stays
> set. veth_pool_store() does:
>
> 	ibmveth_close(netdev);
> 	...
> 	if (netif_running(netdev)) {
> 		rc = ibmveth_open(netdev);
> 		if (rc) {
> 			pool->active = oldactive;
> 			...
> 			goto unlock_err;
>
> and ibmveth_change_mtu() does the same close/open dance. If the reopen fails,
> for example a GFP_KERNEL failure in ibmveth_alloc_rx_queues() or
> ibmveth_alloc_buffer_pools(), the error is returned without clearing
> dev->flags, so IFF_UP remains set while ibmveth_close() ->
> ibmveth_cleanup_rx_interrupts() has already run:
>
> 	for (i = 0; i < adapter->num_rx_queues; i++)
> 		napi_disable(&adapter->napi[i]);
>
> and ibmveth_cleanup_rx_resources() has set buffer_list_addr[i] and
> rx_queue[i].queue_addr to NULL, with adapter->num_rx_queues left unchanged.
>
> A later "ethtool -L ethX rx <smaller>" then takes the UP branch and the
> scale-down loop in ibmveth_resize_rx_queues_incremental() calls
> napi_disable(&adapter->napi[i]) a second time on an already-disabled NAPI.
> Does napi_disable_locked() ever return in that case?
>
> net/core/dev.c:napi_disable_locked() {
> 	...
> 	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 		usleep_range(20, 200);
> 		val = READ_ONCE(n->state);
> 	}
> 	...
> }
>
> That would be an unkillable spin with rtnl_lock held.
>
> The scale-up direction on the same stale state reaches
> ibmveth_replenish_task() -> ibmveth_update_rx_no_buffer(), which does:
>
> 	for (i = 0; i < adapter->num_rx_queues; i++) {
> 		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
> 		u64 drops = be64_to_cpup(p);
>
> with buffer_list_addr[i] already NULL.
>
> This dispatch on IFF_UP came from the preceding patch, but this patch
> finalizes it as the user-visible interface. Would keying the decision on an
> explicit "RX resources allocated" state in the adapter avoid this?
Yes, keying this off `adapter->opened` should avoid that stale-UP
dispatch, because it tracks whether RX/TX resources are actually
instantiated rather than whether the netdev still carries `IFF_UP`
after a failed reopen.
>> +		if (goal_tx != old_tx) {
>> +			rc = netif_set_real_num_tx_queues(netdev, goal_tx);
>> +			if (rc)
>> +				return rc;
>> +		}
>> +
>> +		/* Stash desired RX count only after TX succeeds (or was
>> +		 * already correct); open() publishes it via
>> +		 * netif_set_real_num_rx_queues().
>> +		 */
>> +		return ibmveth_resize_rx_channels(adapter, goal_rx);
>> +	}
> [Severity: Medium]
> Does this path need to refresh the VIO CMO DMA entitlement?
>
> The stash branch of ibmveth_resize_rx_channels() just does:
>
> 	if (!(netdev->flags & IFF_UP)) {
> 		adapter->num_rx_queues = goal_rx;
> 		return 0;
> 	}
>
> and ibmveth_get_desired_dma() sizes the request per RX queue:
>
> 	for (q = 0; q < adapter->num_rx_queues; q++) {
>
> The only two vio_cmo_set_dev_desired() call sites in the driver are the live
> resize path in ibmveth_resize_rx_queues_incremental():
>
> 	if (firmware_has_feature(FW_FEATURE_CMO))
> 		vio_cmo_set_dev_desired(adapter->vdev,
> 					ibmveth_get_desired_dma(adapter->vdev));
>
> and ibmveth_change_mtu(), which refreshes it even while the interface is
> closed. ibmveth_open() does not call it.
>
> So on a CMO LPAR, after
>
> 	ip link set dev ethX down
> 	ethtool -L ethX rx 16
> 	ip link set dev ethX up
>
> the entitlement is still sized for the old, smaller RX count while open()
> DMA-maps the larger footprint (per-queue buffer-list page, RX ring, buffer
> pools). Can vio_dma_iommu_map_page() -> vio_cmo_alloc() then fail and make
> the link fail to come up with -ENOMEM? Shrinking while down has the mirror
> effect of leaving entitlement reserved until the next MTU change or live
> resize.
Yes, the down-path stash also needs to refresh CMO desired state.

I’ll update the desired entitlement after stashing the new RX count, so
the next open does not try to map a larger RX footprint against the old
budget, and shrinking while down also drops stale over-entitlement.

>
> [Severity: Low]
> Should this branch also publish the RX count to the netdev?
>
> TX is published immediately with netif_set_real_num_tx_queues(), but RX only
> reaches the stash in ibmveth_resize_rx_channels(), so
> netdev->real_num_rx_queues keeps its old value until the next
> ibmveth_open(). Meanwhile ibmveth_get_channels() reports the private counter:
>
> 	channels->rx_count = adapter->num_rx_queues;
>
> After "ip link set dev ethX down; ethtool -L ethX rx N", ethtool -l reports
> N while /sys/class/net/ethX/queues/rx-*, the RPS/RFS maps and netdev-genl
> queue enumeration still show the old count.
>
> netif_set_real_num_rx_queues() only touches kobjects and RPS maps and
> allocates no driver resources, and probe already sized the netdev with
> alloc_etherdev_mqs(..., IBMVETH_MAX_QUEUES, IBMVETH_MAX_RX_QUEUES), so is
> there a reason RX cannot be published here the way TX is?
Yes, the while-down stash path should publish RX consistently as well.

I’ll publish `real_num_rx_queues` on the while-down stash path too, so
userspace does not see the private RX count diverge from netdev core
state before the next open.
>>   
>> -	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
>> -	 * in this patch. !IFF_UP RX stash ordering lands next.
>> -	 */
>>   	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
>>   	if (rc)
>>   		return rc;
> [Severity: High]
> Can this live resize race with a surviving queue's NAPI poll?
>
> The scale-down branch of ibmveth_resize_rx_queues_incremental() takes its
> grace period before lowering the count, and the frees come after the store:
>
> 	synchronize_net();
>
> 	rc = netif_set_real_num_rx_queues(netdev, new_count);
> 	...
> 	adapter->num_rx_queues = new_count;
>
> 	for (i = new_count; i < old_count; i++) {
> 		ibmveth_cleanup_single_rx_interrupt(adapter, i);
> 		ibmveth_deregister_single_rx_queue(adapter, i);
> 		ibmveth_free_single_rx_queue(adapter, i);
> 	}
>
> ibmveth_free_single_rx_queue() then does:
>
> 	if (adapter->buffer_list_addr[queue_idx]) {
> 		free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
> 		adapter->buffer_list_addr[queue_idx] = NULL;
> 	}
>
> A surviving queue's poll -> ibmveth_replenish_task() ->
> ibmveth_update_rx_no_buffer() uses the count as a lockless bound and
> dereferences the pointer without a NULL check:
>
> 	for (i = 0; i < adapter->num_rx_queues; i++) {
> 		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
> 		u64 drops = be64_to_cpup(p);
>
> The reader holds only rx_queue[k].replenish_lock, the writer holds rtnl, so
> the locksets do not intersect and disabling the removed queues' NAPIs does
> not quiesce the surviving pollers. Can this read a freed page, or
> dereference NULL + 4088 if the pointer load lands after the NULL store?
>
> The scale-up side publishes the count with a plain store before the reader
> can see the pointer stores:
>
> 	adapter->num_rx_queues = i + 1;
> 	ibmveth_replenish_task(adapter, i);
>
> On PowerPC, can a reader observe the larger count with a stale NULL
> buffer_list_addr[i]?
>
> The resize helper and its UP-path caller came from the preceding patch
> "ibmveth: Implement incremental MQ RX queue resize", so this is not
> introduced here, but this patch completes the user-facing entry point that
> drives it. The later patch "ibmveth: Fix MQ RX poll and shutdown hangs after
> queue resize" only touches correlator validation and poll shutdown and leaves
> ibmveth_update_rx_no_buffer() and this ordering unchanged.
Yes, a reader can observe the larger count before the new queue state is
safely published, or keep walking queue state after teardown has
started. This path inherits the same publication and teardown hazards
from the live resize helper, and patch 13 is where they become user
reachable.

I’ll fix this the same way in the earlier resize path: make
`update_rx_no_buffer()` queue-local, publish `num_rx_queues` with
ordering, and unpublish before freeing queue state.
> [Severity: Medium]
> Can the adapter-wide rx_no_buffer counter lose updates once more than one RX
> queue is configured through this path?
>
> ibmveth_update_rx_no_buffer() resets and re-accumulates a shared counter and
> writes every queue's qstats entry:
>
> 	adapter->rx_no_buffer = 0;
> 	for (i = 0; i < adapter->num_rx_queues; i++) {
> 		...
> 		adapter->rx_no_buffer += drops;
> 	}
>
> but it is called from ibmveth_replenish_task() while only that caller's
> per-queue lock is held:
>
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
> 	...
> 	ibmveth_update_rx_no_buffer(adapter);
>
> 	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
>
> With polls for queue 0 and queue 1 running on different CPUs, the locksets
> are disjoint, so the "= 0" and the "+=" from both CPUs interleave and
> ethtool -S / ndo_get_stats64() can report a value near zero or well below
> the real one. This came in with the earlier per-queue aggregation and MQ RX
> patches rather than this one, and the later "ibmveth: Fix MQ RX poll and
> shutdown hangs after queue resize" patch does not touch this function.
Yes, that is the same queue-accounting bug class.

I’ll keep `no_buffer` refresh queue-local and derive the adapter-level
total by summing on read, so concurrent replenish paths do not race on a
shared clear-and-rebuild counter.
> [Severity: Low]
> Is a partially applied configuration possible here?
>
> In the UP path the RX resize is committed first, including hypervisor
> registration, IRQ setup/teardown, buffer alloc/free and the update of
> adapter->num_rx_queues. If the later netif_set_real_num_tx_queues() fails,
> for example -ENOMEM out of netdev_queue_update_kobjects(), set_channels()
> returns that error with the RX count already changed, so the resulting
> configuration matches neither the old nor the requested one and nothing
> rolls RX back.
>
> The !IFF_UP branch above has the mirror ordering: TX is committed with
> netif_set_real_num_tx_queues() before any RX validation runs, since the
> -EOPNOTSUPP and -EINVAL checks live inside ibmveth_resize_rx_channels(),
> which is called last. A rejected RX value would leave the TX count changed
> with no rollback. Today the ethtool core clamps rx_count against max_rx
> before the driver op runs, so this half is latent, but should the RX
> validation happen before TX is touched?
Yes, the combined RX/TX transaction needs a clearer rollback story.

I’ll validate both directions up front, and if the live TX phase cannot
reach the requested goal I’ll roll RX back to the old count so
`set_channels()` does not fail after committing only half the change.

>> @@ -2744,10 +2752,17 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>>   	 * but we may need to alloc/free the ltb's.
>>   	 */
>> +	if (goal_tx == old_tx)
>> +		return 0;
>> +
>>   	netif_tx_stop_all_queues(netdev);
>>   
>> -	/* Allocate any queue that we need */
>> -	for (i = old; i < goal; i++) {
>> +	/* Allocate any queue that we need. Initialize i to old_tx so a
>> +	 * scale-down path that never enters the loop still has defined
>> +	 * bounds if set_real_num_tx_queues() fails.
>> +	 */
>> +	i = old_tx;
>> +	for (; i < goal_tx; i++) {
> [Severity: Low]
> Is there a case where i was undefined before this change?
>
> The previous form was:
>
> 	for (i = old; i < goal; i++) {
>
> The init clause runs unconditionally before the first condition test, so i
> was already assigned even when the body never executes. Splitting it into
> "i = old_tx; for (; i < goal_tx; i++)" looks semantically identical, and the
> new comment suggests the idiomatic form was unsafe. Could the comment be
> dropped or reworded?
>
> The changelog bullet "Always return rc from set_channels()" also looks like a
> non-change, since the UP path already ended with "return rc;" and the down
> path already returned the netif_set_real_num_tx_queues() value.
>
> In the one case where an error is actually lost, the claim does not hold. On
> ibmveth_allocate_tx_ltb() failure the rewind runs:
>
> 		goal_tx = old_tx;
> 		old_tx = i;
> 		break;
> 	}
> 	rc = netif_set_real_num_tx_queues(netdev, goal_tx);
>
> so the -ENOMEM is overwritten by a call that cannot fail because goal_tx now
> equals dev->real_num_tx_queues, and "ethtool -L ethX tx N" reports success
> after an allocation failure. That clobber is identical at the baseline and is
> not introduced here, it just means the hardening bullet does not describe it.
>
> Separately, the genuinely new TX behaviour in this hunk, "if (goal_tx ==
> old_tx) return 0;", which now skips netif_tx_stop_all_queues() and
> netif_tx_wake_all_queues() when only RX is resized, is not mentioned in the
> commit message. Could it be added there?
>
> [ ... ]
Yes, the comment/changelog text is wrong, and the claimed
error-return cleanup is overstated.

I’ll drop or reword the `i = old_tx` comment so it does not imply the
earlier loop form was unsafe, and I’ll make the folded commit message
describe the real TX-only behavior more precisely instead of claiming
the error path is fully fixed in this patch.

Thanks,
Mingming

