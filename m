Return-Path: <linuxppc-dev+bounces-28169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A1EC98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:28:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgkm1G33z2y2J;
	Fri, 25 Sep 2026 16:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790317712;
	cv=none; b=lbZnM64RjBMFuvTQT+zRPldPn8mkrRivqenI4Jm/qnT6WaQTdlC0uLWo7XjoA9B+rArvc633ewL+NSt3APZSWaoVhjDTY0gPrIwfcyzg4GGx8nqvcm5XKzZeE/LWUd2qmIbwVU7iyzwyVtYMcTxT2xeA5/nPFXskWMPFlQpwmB/xsb7wozBjFQXj6eOeI3IXJqYgbohofbUHe5+eWgBZ4R3q2Hp4MdyqeNH2tviQJrJwbPwMRWtiDt4sOm43fm1OdnIPh3xbfzJFAPzTZI/qGW1DshyuEsAmN5ZxZwHIRrDCRmPiFoE8SULBB6R0luGXkyQuPocWZ/uHNdizeKG6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790317712; c=relaxed/relaxed;
	bh=f02YJ6Sbqpc6CDKMe0vb0KTcHI2xR969CQ44ojK/Xos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8RmtVYCRkd4CxIhgs2EVXbXyRr0n0vkWdKo9iXccQk1jBfu07uunxkd62+MJXn30hR2qrWQz5nSKrKv9rpSIFDvSQfm5ZW3NPYW6DceZwYBYuxN8itXwPoDac5rDqEIUt5226Jg7IsdVy+0IGXRNC7NmcYnhfSUM1pcGvdGbySBFFQ1v6oKSbL+JwdiCVBYDeyNFiricbKVJ8YOQbsCsIpV6lyDZWlAvIL+V04oa/DOlq9cAkDnNKmDWk5hzadfPXVoMW0mh7gfKi0JWvEMsSsTrM0iA5yHj22QDhBkFD7YqBJ2ZDgD98y8FrtnSIxTjREugmrS+s6ex69/xe00iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MaZFl/eY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MaZFl/eY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgkk4tWMz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:28:29 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aXFE102845;
	Fri, 25 Sep 2026 06:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f02YJ6
	Sbqpc6CDKMe0vb0KTcHI2xR969CQ44ojK/Xos=; b=MaZFl/eY8+bLrDhgzrcqJ1
	D2dwga+TbuPKVIX9mazPXs1z2DD8yV8mLt7jDzdnM3/7EM1lbJzSjz4AR3H9Lp94
	uyuCbdMYnGRxPOyNu6AM1VdnkpVLGvoNkj0viXsMCqVcIVWBmkcM48MvIofXykc6
	EhirYuUedZvKKnv+QEo5m0bc92p71O4pJmjb+VmlNE0+2GsjuQc6zFFDy5c4BryZ
	rRaUdR4z7QdccclFoOmKqaZDigVOz39gI2Z85FPaRAuA5YdDJJmcoB39E5b/SxGN
	TPKewFO1kEEQYOWgTqiIUHONumE/JuEsic5MTC0edI4GQs/2vigdeTdoK/ZOxl+A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvmnab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:28:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lV1h3288190;
	Fri, 25 Sep 2026 06:28:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21b9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:28:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6SEKi10289736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:28:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AB1A58055;
	Fri, 25 Sep 2026 06:28:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FF055804B;
	Fri, 25 Sep 2026 06:28:11 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:28:11 +0000 (GMT)
Message-ID: <16b4b934-d14f-4d0f-ba87-3e37530f231e@linux.ibm.com>
Date: Thu, 24 Sep 2026 23:28:10 -0700
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
Subject: Re: [net-next,v6,06/15] ibmveth: Refactor TX resource allocation in
 open/close paths
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <e07afab0a0129a7b01d24113d9d74bc10c7dc7de.1788102125.git.mmc@linux.ibm.com>
 <178845903572.3394541.18066559713836022844@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845903572.3394541.18066559713836022844@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZCCot-DAqB9L39H3BZrfgYG6sq4SI3ZW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX2b46CAu2EqvL
 23jjbabS/ZIlH97pXhX+PgoWQHWt+JuShig4Zis4LLZuGOCsWp4F00qIgqiqbw6QcmwI0OdkBC6
 YByH/yD/rIvdPZ6vxsP7RnMme/qy6S4=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab61481 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=jAftywWrWGzVg5WlXPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QBLWJ1wuI5UIa7P3-YOfW9rPc4QDzrFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX3fV/z2f0vMGQ
 zarooIIToNlNixEudh8uZqTp1KoZvY2mLbdbsB60Fwf1teGn0sVI+hfpLHrjdS1N4qehcKiHszx
 MS/EEn9qd0WsfuihVh2stpZDoXMK1TvvNSCBQgR2DELmkm0gpmCFJiWlOPB4k36+RxbQVJeWNyC
 6D1rgucvUvo380zA11pc9UP5rQdrMtbZpEUinIa3ZC3xc68HRAHUNskoOUnj8NDIWpbToys0yCh
 KK011JU9/SbmW2DRwplXJwthhYWfgBObLpLSNYcwN/XXGYrnHmQgseKKokIYb/OYRhyhA2l8Kiq
 nG7MPEZHI3g2LPJXYwyA4SwvHy0P4zosu/3TdmragdmYmwo0wDfqcVyJ5tLMHVOCE+4YC5zi9MP
 lJnHboJLKgss4geV+OqwCjJDvPelmSlez9ikX/t57UbfOBDIxn+uRrVh9uFK8RFc4SOSHD0QaJH
 LpnuPTxiFAm5mkxY65A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250024

Hi, Thanks for your review..

On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0 (2)
>
> - [Medium] The patch silently repairs a live mainline bug while
>    presenting itself as a TX refactor.
>
> Pre-existing issues:
> - [Low] Concern (assessed as a FALSE POSITIVE): the new `if
>    (unlikely(!adapter->tx_ltb_ptr[queue_num]))` guard in…
> - [Low] Concern (assessed as a FALSE POSITIVE for the final series
>    state): ibmveth_alloc_tx_resources() calls ibmveth_allocate_tx_ltb()…
>
> --
>
> ibmveth: Refactor TX resource allocation in open/close paths
>
> This moves the per-queue TX LTB allocation and free out of ibmveth_open()
> and ibmveth_close() into ibmveth_alloc_tx_resources() and
> ibmveth_free_tx_resources(), moves the TX allocation to the end of open()
> after RX interrupt setup, and adds a tx_ltb_ptr[] check to
> ibmveth_start_xmit(). It also reworks the open() failure unwind labels.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 335712faaa42a..7a420e1a41d52 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1201,12 +1201,27 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>>   
>>   static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>>   {
>> -	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
>> -			 adapter->tx_ltb_size, DMA_TO_DEVICE);
>> -	kfree(adapter->tx_ltb_ptr[idx]);
>> +	void *ltb = adapter->tx_ltb_ptr[idx];
>> +	dma_addr_t dma = adapter->tx_ltb_dma[idx];
>> +
>> +	if (!ltb)
>> +		return;
>> +
>> +	/*
>> +	 * Clear the slot before releasing it. start_xmit() tests
>> +	 * tx_ltb_ptr[idx] to decide whether the LTB is usable.
>> +	 */
>>   	adapter->tx_ltb_ptr[idx] = NULL;
>> +	adapter->tx_ltb_dma[idx] = 0;
>> +
>> +	dma_unmap_single(&adapter->vdev->dev, dma, adapter->tx_ltb_size,
>> +			 DMA_TO_DEVICE);
>> +	kfree(ltb);
>>   }
>>   
>> +/* Caller must ensure tx_ltb_ptr[idx] is NULL. open() runs on
>> + * probe-zeroed slots; set_channels() skips populated indices.
>> + */
>>   static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>>   {
>>   	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,
> [Severity: Low]
> This is a pre-existing style point rather than something this patch breaks,
> but the new kdoc on ibmveth_allocate_tx_ltb() states an invariant that the
> helper itself never checks:
>
>    /* Caller must ensure tx_ltb_ptr[idx] is NULL. ...
>
> and ibmveth_alloc_tx_resources() below calls it unconditionally for every
> index in [0, real_num_tx_queues). If a slot were ever populated on entry,
> the kzalloc() would overwrite the old pointer and leak both the 64 KiB
> buffer and its streaming DMA mapping.
>
> Tracing the callers, the only way to reach open() with a populated slot was
> ibmveth_set_channels() gating on IFF_UP instead of adapter->opened, and a
> later patch in this series makes set_channels() return early on !opened
> before it touches the LTBs, so no reachable caller can present a populated
> index. Would a WARN_ON_ONCE(adapter->tx_ltb_ptr[idx]) (or just an early
> return) be worth adding so the documented precondition is enforced rather
> than only described?
A comment, not a WARN_ON or an early return, and
v6 added that comment. I am keeping it that way: a
skip would hide a caller that left a live mapping,
and still strand the old TCE.
>
> [ ... ]
>
>> @@ -1308,24 +1359,24 @@ static int ibmveth_open(struct net_device *netdev)
>>   				     rxq_desc.desc,
>>   				     mac_address);
>>   		rc = -ENONET;
>> -		goto out_free_tx_ltb;
>> +		goto out_free_queue_mem;
>>   	}
>>   
>>   	rc = ibmveth_alloc_buffer_pools(adapter);
>>   	if (rc)
>> -		goto out_free_tx_ltb;
>> +		goto out_unregister_lan;
>>   
>>   	rc = ibmveth_setup_rx_interrupts(adapter);
>> -	if (rc) {
>> -		do {
>> -			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> -		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> -		goto out_free_buffer_pools;
>> -	}
>> +	if (rc)
>> +		goto out_unregister_lan;
>>   
>>   	netdev_dbg(netdev, "initial replenish cycle\n");
>>   	ibmveth_schedule_rx_queue(adapter, 0);
>>   
>> +	rc = ibmveth_alloc_tx_resources(adapter);
>> +	if (rc)
>> +		goto out_cleanup_rx_interrupts;
>> +
>>   	netif_tx_start_all_queues(netdev);
>>   
>>   	adapter->opened = true;
>> @@ -1333,11 +1384,14 @@ static int ibmveth_open(struct net_device *netdev)
>>   
>>   	return 0;
>>   
>> -out_free_buffer_pools:
>> +out_cleanup_rx_interrupts:
>> +	ibmveth_cleanup_rx_interrupts(adapter);
>> +out_unregister_lan:
>> +	do {
>> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>>   	ibmveth_free_buffer_pools(adapter);
>> -out_free_tx_ltb:
>> -	while (--i >= 0)
>> -		ibmveth_free_tx_ltb(adapter, i);
>> +out_free_queue_mem:
>>   	ibmveth_cleanup_rx_resources(adapter);
> [Severity: Medium]
> Should the h_free_logical_lan() part of this hunk be split out as its own
> patch with a Fixes: tag and Cc: stable?
>
> Rerouting the ibmveth_alloc_buffer_pools() failure to out_unregister_lan
> looks like a real bug fix, not just a label rename. At the series merge base
> (1b78070aaef6) that failure path in ibmveth_open() runs:
>
>    rc = ibmveth_alloc_buffer_pools(adapter);
>    if (rc)
>            goto out_free_buffer_pools;
>    ...
>    out_free_buffer_pools:
>            while (--i >= 0) { ... }
>    out_unmap_filter_list:
>            dma_unmap_single(dev, adapter->filter_list_dma, 4096,
>                             DMA_BIDIRECTIONAL);
>
> so the filter list, the buffer list and the RX completion ring are unmapped
> and freed while the logical LAN registered by ibmveth_register_logical_lan()
> is still live. Only the request_irq() failure path issued the hcall. This
> patch is the first place that path deregisters, which matches the commit
> message note:
>
>    "After LAN registration, open-fail teardown issues h_free_logical_lan()
>    before RX pool DMA teardown on the pool-fail path that previously never
>    issued that hcall (missing deregistration, not a preference reorder)."
>
> The concern is packaging rather than correctness of the code here. As
> written, the fix for an ifup-under-memory-pressure path that leaves PHYP
> registered against freed DMA memory is folded into a TX helper refactor with
> no Fixes: tag, no Cc: stable and no statement of the failure mode.
>
> The next patch in the series ("ibmveth: Add RX queue register helpers for
> MQ") then moves pool allocation ahead of registration, so this arrangement
> is transient inside the series and no single commit is backportable for the
> mainline/stable bug. Could the deregistration fix be lifted to a standalone
> patch at the front of the series?
That path never issued the hcall, and the tag
would be Fixes: d43732ce021f — the same defect as
Patch 3. I am leaving h_free on this unwind rather
than peeling a Fixes: patch out here, so this
posting stays at 15, and sending one standalone
[PATCH net] after the series. Happy to send that
unwind ahead of this 15 instead if you would
prefer it that way.

The commit message already names the missing
deregistration.
> [ ... ]
>
>> @@ -1807,6 +1864,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>>   	int i, queue_num = skb_get_queue_mapping(skb);
>>   	unsigned long mss = 0;
>>   
>> +	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
>> +	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
>> +		netdev->stats.tx_dropped++;
>> +		goto out;
>> +	}
>> +
>>   	if (ibmveth_is_packet_unsupported(skb, netdev))
>>   		goto out;
>>   	/* veth can't checksum offload UDP */
> [Severity: Low]
> This isn't a bug introduced by the patch, and after checking it appears to
> be safe, but the shape of the new guard invites the question. The check
> reads adapter->tx_ltb_ptr[queue_num] once, then the body re-reads the same
> slots later:
>
>    memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
>    ...
>    desc.fields.address = adapter->tx_ltb_dma[queue_num];
>
> Since ibmveth_free_tx_ltb() now NULLs the slot before the unmap, is the
> guard intended as a race barrier, or purely as a check for a slot that is
> already known to be quiesced?
>
> Every free site does look quiesced independently of this check:
> ibmveth_close() calls netif_tx_disable() plus synchronize_net() before
> ibmveth_free_tx_resources(); the ibmveth_set_channels() shrink frees only
> after netif_set_real_num_tx_queues(), which does synchronize_net() on the
> disabling path; and the open() unwind runs with all TX queues still XOFF.
>
> The commit message already says as much:
>
>    "NULL-first in free_tx_ltb() only closes the check-then-use window, it is
>    not itself a UAF barrier."
>
> Would it be clearer to state next to the guard that TX is quiesced at all
> free sites, so the single read is not load-bearing?


Not a race barrier. close() is safe:
netif_tx_disable()
waits out xmit. Shrink frees only after
netif_set_real_num_tx_queues(), which
synchronize_net()s on the disabling path. The
guard is for a slot that is already gone (close
/ failed reopen with IFF_UP still set).
NULL-first only closes the check-then-use
window; the v6 commit message already says it
is not a UAF barrier.

I am leaving out "all free sites are quiesced"
next to the guard; that is not load-bearing.

Thanks,
Mingming


