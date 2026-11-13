Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9F606A89F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PxOxofnA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR6020948z2xP9;
	Sat, 14 Nov 2026 05:55:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794596129;
	cv=none; b=W18JX6AxTWThx7nhSINS5iKXt/yGHkhqcKv0MwR3IAQnVD8p/Zwom7LD00gmhMw0zjEp89wKgfC8rnuRodUdAYby8st80+0uRmRDUpSXpEQ1jH2xIHbHGw1O4+ABz9eQ/wKl0EsR3RTvLoezxhbTb3BggvevpRDesijusvdHBDsVhXIR9MQpkSiHJGGBaKf8WYx4bHrVWyyryMYpK/HWAZ1yVwuFXrZtA8+wWfvPVCcutXdB7qnoA1shx0mARIMsyj6SJhH40wvghToN3M9QLVw7eKMczCjqpPAE0XIDQTr0eIStVFG3avtoMs4tMJgjlEWr6WU9TGNN6X2YOCVSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794596129; c=relaxed/relaxed;
	bh=MzQo6b40FJqZIOj7U/fNaW1qa/xGJTIi7wkOrZE5CFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XByT4XWwZ3BIeqq8v57nzgCYVu4iL6y9Xkr33wR09DCX7FJy/HsIGKkowELeOsxZN9yB/aryM6naiKBDWbgW4I7407PLQ4QXnztaqG6kV6IqQ19HR7a7z6y/ngNBuTVYF/ENamNh4/72A7SUjyAITWDnVFTyWtlQ9R5ABBCXKIPg4fxv/mDitPj5fjLus6pYM1m5f/ncm3I0lnQSkdSbkfJe+vxS6mLA9R03aNX4+5R6uTCo6umk9vVhI1lw9GLkPETGhEEXN79eyjcPru/HBDa7TsekHdipb6tWvsGfqcojCHXrV6H5Ijyx+SoJk0CtEzE/ZhmEkzLme1y/N8enkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PxOxofnA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PxOxofnA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR6006nh5z2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:55:28 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFiXv03395037;
	Fri, 13 Nov 2026 18:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MzQo6b
	40FJqZIOj7U/fNaW1qa/xGJTIi7wkOrZE5CFE=; b=PxOxofnAcz2RXbeVI+w4mz
	7sOH+7JT9u401lKOJKbaBr816SGas5BqkObpQpqIjGLv6W3ny7rcAWWo/m4TXbeY
	08t+S8wfLEXzEZ0ZmSzs+65xksXDt5wQL54yq3AhaKFjf5CQMBCtYbe/9sky3Z5b
	7X/I6dH/+cO5ATa7PCFLqEiwdG8HyVw6LCAf3LkgpkbZsL1fTB/3YEN+1WHa4UVu
	1mzBEsSSRHxk8Pa4n5RZJuueM7hL0XIgFoz9LytKg801IjPA72UwGbaZ26ha9nkQ
	B+/FBZ2QRTpu0Nxw3vapDr0NQQHgVFybd9UJEGwR3M6VkT0f3wVB4VRA0zv3zrdQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdm4pqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:55:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFYxbD2453156;
	Fri, 13 Nov 2026 18:55:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfd4kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:55:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADIsrHi30802638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 18:54:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E84E358059;
	Fri, 13 Nov 2026 18:54:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFD7F58017;
	Fri, 13 Nov 2026 18:54:49 +0000 (GMT)
Received: from [9.67.72.137] (unknown [9.67.72.137])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 18:54:49 +0000 (GMT)
Message-ID: <361a5a43-9fcb-423a-808f-d8cdf1d9ad5e@linux.ibm.com>
Date: Fri, 13 Nov 2026 10:54:49 -0800
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
Subject: Re: [PATCH net-next v8 06/15] ibmveth: Refactor TX resource
 allocation in open/close paths
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20261109235556.60604-7-mmc@linux.ibm.com>
 <179452782258.2199510.1384176100068608942@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179452782258.2199510.1384176100068608942@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af75d15 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=KieAIxUdgdruANkDTVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MyBTYWx0ZWRfX7nLydZXzMXJL
 3AgPPTSlHVnbiEbgJBkjz/ktN4eicQFBYZqpeD4S4vJyCHVkRPQg1jAmHa52zC410w6IVY0Zpmc
 kgcZMTAuqZbeCUT/i3Mxt323opgrserS73zZuVX/JaTPMqlmv9TxZgLtT4tQ13af8L6jCWkhMbD
 QmG5AA7Cf2Qci5WO4yh+xnXmiFiHfRJIupv+R2DYBYW0oLmHBEsninWzy1teoI2I/hfBs4R+G2P
 egXMkFZIYUs7GneKe/TfzXLDb2VywutryuOqgDX5mKWtKlDIRq37tZ2tnF6aDDZi4uyQ7gniu0j
 vQHCzkinxy/sHIDgIiz+QgIDaRjvhXGGmy67W2kjA9jzYrSUdkSDHZlneUvk4zO+UBd14+pvKIE
 J7bKyb7CFMZuKxpfGgxJowB/6E7/BasOmnHwOKctD8D9brZ04l6mKZCSbuR3/P2/ouYXOch9GvN
 XjvllB81jVPGPKChikQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MyBTYWx0ZWRfXx91O3UGKVtUs
 f2WHpksSz0K7cv2YBxXFTZ6qv9sa3qOjcN72+0KiWGI7a4uinsC1jtpl8tXjNtkcB0oBh+EQjfU
 62qGPCAW9UN/+5pbIsZBeamXOT1MH1Q=
X-Proofpoint-ORIG-GUID: BdisUuincl5p1a-ZwwcazCuCBT4xWSKd
X-Proofpoint-GUID: o6PiT2dxa8hDAdoa84RAaa-VrurgN88t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130073
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/12/26 3:57 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 3 · Low: 0 (2)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The patch is titled 'Refactor', but it also carries the only
>    fix for a NULL-pointer dereference that already exists in the base…
> - [Medium] ibmveth_open() now allocates the TX LTBs (line 1432) after
>    h_register_logical_lan, ibmveth_alloc_buffer_pools(),…
> - [Medium] The patch makes a non-NULL tx_ltb_ptr[idx] mean 'this LTB is
>    usable'.
>
> Pre-existing issues:
> - [Low] Not a real bug for the scenario described (baseline decision:
>    false).
> - [Low] Resolved later in the series (baseline decision: false).
>
> --
>
> ibmveth: Refactor TX resource allocation in open/close paths
>
> This patch moves TX LTB allocation and freeing in open() and close() into
> the new ibmveth_alloc_tx_resources() and ibmveth_free_tx_resources()
> helpers. It also moves the TX allocation to the end of open(), after RX
> is live. It adds netif_tx_disable() at the start of open(), and adds a
> check in ibmveth_start_xmit() that drops packets when tx_ltb_ptr[] is
> NULL.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 62e6c9a9f5e91..cab895cc970c5 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> +/* Caller must ensure tx_ltb_ptr[idx] is NULL. open() runs on
>> + * probe-zeroed slots; set_channels() skips populated indices.
>> + */
>>   static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>>   {
>>   	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,
>> @@ -1277,12 +1287,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>>   			   "unable to DMA map tx long term buffer\n");
>>   		kfree(adapter->tx_ltb_ptr[idx]);
>>   		adapter->tx_ltb_ptr[idx] = NULL;
>> +		adapter->tx_ltb_dma[idx] = 0;
>>   		return -ENOMEM;
>>   	}
> [Severity: Medium]
> ibmveth_free_tx_ltb() now takes a non-NULL tx_ltb_ptr[idx] to mean the
> LTB is usable, and the new check in ibmveth_start_xmit() depends on that.
> Does ibmveth_allocate_tx_ltb() follow the same rule?
>
> It stores the kzalloc() result in tx_ltb_ptr[idx] before tx_ltb_dma[idx]
> is mapped. On the map failure path it calls kfree() before it clears the
> slot.
>
> The stale sender that the new guard is meant to catch could hit these
> windows on a later grow. After a shrink, netif_tx_wake_all_queues()
> leaves the freed index j without DRV_XOFF. If ethtool -L then grows the
> queues, ibmveth_set_channels() does this:
>
> 	netif_tx_stop_all_queues(netdev);
>
> 	/* Allocate any queue that we need */
> 	for (i = old; i < goal; i++) {
> 		...
> 		rc = ibmveth_allocate_tx_ltb(adapter, i);
>
> The grow path has no synchronize_net(). A stale sender that already
> passed the DRV_XOFF check could see a non-NULL tx_ltb_ptr[j] and
> memcpy() into it. It could then put tx_ltb_dma[j] == 0 into the
> H_SEND_LOGICAL_LAN descriptor, or write into memory that the map failure
> path is about to kfree().
>
> The grow-failure free loop in ibmveth_set_channels() also frees the slots
> it just allocated without waiting for a grace period.
>
> Would it be safer to allocate and map into local variables, and publish
> tx_ltb_ptr[idx] last with WRITE_ONCE() or a release store? On failure,
> the slot could be cleared before kfree(), and ibmveth_start_xmit() could
> read the pointer and the DMA address once each.
>
> [ ... ]
That publish-before-map ordering was already there. This patch doesn't
touch the allocation order or the ethtool -L TX grow loop; it only
clears tx_ltb_dma[] on the map-failure path and in the free helper. So
in net-next today, a stale sender after a shrink can hit a NULL
tx_ltb_ptr[], and one during a grow can hit the window you describe.
The new check turns the first case into a drop, but it doesn't try to
fix the grow window.

Your suggestion is the right fix: allocate and map into locals, publish
the pointer only once the DMA address is valid, clear it before freeing
on failure, and read the pointer and DMA address once in xmit. I'd
rather do that as a follow-up to the TX resize code than grow this
series.
>> @@ -1373,26 +1424,36 @@ static int ibmveth_open(struct net_device *netdev)
>>   	 */
>>   	rc = ibmveth_setup_rx_interrupts(adapter);
>>   	if (rc)
>> -		goto out_free_buffer_pools;
>> +		goto out_unregister_lan;
>>   
>>   	netdev_dbg(netdev, "initial replenish cycle\n");
>>   	ibmveth_schedule_rx_queue(adapter, 0);
>>   
>> +	rc = ibmveth_alloc_tx_resources(adapter);
>> +	if (rc)
>> +		goto out_cleanup_rx_interrupts;
> [Severity: Medium]
> Can a TX LTB allocation failure here now free RX buffers that PHYP still
> owns?
>
> By this point ibmveth_schedule_rx_queue(adapter, 0) has posted RX skb DMA
> addresses to the hypervisor. If kzalloc() or dma_map_single() fails in
> ibmveth_allocate_tx_ltb(), open() jumps to out_cleanup_rx_interrupts and
> falls through into:
>
> out_unregister_lan:
> 	do {
> 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> 	ibmveth_free_buffer_pools(adapter);
> out_free_queue_mem:
> 	ibmveth_cleanup_rx_resources(adapter);
>
> Any H_FREE_LOGICAL_LAN result other than busy is ignored. The posted RX
> skbs are then unmapped and freed, and so are the RX ring and the buffer
> list pages. If the H_FREE failed, could PHYP still DMA inbound frames, or
> the buffer list drop counter, into pages already returned to the
> allocator?
>
> Before this patch, TX allocation ran before LAN registration, so only
> close() had this window.
>
> The commit message says a later patch keeps this memory mapped on a hard
> failure. At the end of the series, though, ibmveth_free_all_queues() only
> returns -EIO in multi-queue mode:
>
> 	if (lpar_rc != H_PARAMETER && adapter->multi_queue)
> 		return -EIO;
>
> so single-queue mode would still free the posted buffers on this path.
>
> Does TX LTB allocation need to move after the replenish kick? Since
> ibmveth_alloc_tx_resources() unwinds its own partial failure, it could
> probably stay before h_register_logical_lan(), or at least before
> ibmveth_schedule_rx_queue().
>
> [ ... ]
Only if two things go wrong in the same open(): the TX LTB allocation
fails after the RX buffers are posted, and then H_FREE_LOGICAL_LAN
returns a hard failure. In multi-queue mode (patch 10 onward)
ibmveth_free_all_queues() returns -EIO and open() leaves the LAN memory
mapped, so the next open() or remove() can retry the free. Single-queue
mode still does what close() has always done: log the H_FREE failure
and unmap.

Moving the TX allocation ahead of h_register_logical_lan() would close
this particular window. I didn't want to reshuffle open() again for a
case that needs both a TX allocation failure and a hard H_FREE failure.
The single-queue hard-H_FREE policy is something I plan to fix
separately.
>> @@ -1864,6 +1923,14 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>>   	int i, queue_num = skb_get_queue_mapping(skb);
>>   	unsigned long mss = 0;
>>   
>> +	/* TX LTBs are freed on shrink; a sender that picked its queue
>> +	 * before the shrink can get here after the free.
>> +	 */
>> +	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
> [Severity: Medium]
> Does this check fix a NULL pointer dereference that is already in the
> base tree?
>
> On a TX shrink, ibmveth_set_channels() frees the dropped LTBs and then
> wakes every queue, including the freed indices:
>
> 	for (i = old; i > goal; i--) {
> 		if (adapter->tx_ltb_ptr[i - 1])
> 			ibmveth_free_tx_ltb(adapter, i - 1);
> 	}
>
> 	netif_tx_wake_all_queues(netdev);
>
> Some senders can still have a queue_mapping that points at a freed
> index. One is AF_PACKET with PACKET_QDISC_BYPASS, preempted between
> packet_pick_tx_queue() and dev_direct_xmit(). Another is pktgen reusing
> a cloned skb. In the old ibmveth_start_xmit(), such a sender reaches the
> memcpy() into adapter->tx_ltb_ptr[queue_num] with a NULL pointer.
>
> If so, could this check be sent as a separate minimal patch for net,
> with a tag like the following?
>
> Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
>
> Right now it sits inside a refactor in the middle of a net-next series,
> along with the open() reorder and the RX helper dependencies, so it
> can't be backported on its own.
Yes, though the trigger is narrow. Normal stack TX is drained by the
synchronize_net() in the shrink path. What's left is senders holding a
stale queue mapping that bypass that path, e.g. PACKET_QDISC_BYPASS or
pktgen reusing an skb after ethtool -L removed the queue.

I kept the check in this patch because it's where start_xmit() learns
to cope with a missing LTB, and the later MQ patches build on that. If
the maintainers want it for stable, I can peel it out as a minimal net
fix with the fix tag.
> Also, the commit message says:
>
>    a sender already in xmit during the free is not covered, as before
>    this series.
>
> Isn't that sender already drained on the shrink path? When queues are
> being disabled, netif_set_real_num_tx_queues() calls synchronize_net(),
> and ibmveth_set_channels() calls it before the free loop. What remains is
> a stale sender that arrives after netif_tx_wake_all_queues(), and that
> is the case this check catches.
Yes. netif_set_real_num_tx_queues() runs before the LTB free loop and
synchronizes when queues are removed. What's left is a stale sender
that shows up after the later wake. The commit message sentence about
an already-in-xmit sender not being covered is too broad; I'll fix it
in the follow-up.

Thanks,
Mingming

