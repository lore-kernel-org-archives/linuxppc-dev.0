Return-Path: <linuxppc-dev+bounces-25696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7E2C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 22:21:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJq3R5pMTz2yVd;
	Tue, 11 Aug 2026 08:21:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786400483;
	cv=none; b=N6rxXTR4C+gb9H/bto9iob9T5ri/KmmUevwayt29qz5wpUYxdZrkMscAQiBDLakRnge9grjPegPQWXZkE/Hu5/f1rvdm2eajhW4nuvl1+izzJlUQtVhJwei3IedZhpuMqODb+Ac2gGOOgdmJB65lA4oUwSKgjrexBU50ONxlyKt92dNMfcG9sxbbnLlUmITHqhoWPtTeOffKjjUdSyvBp0m5U+K2SSCC7z/bu1G5WAkIZQZWcMYbnqZczJqnjyBkS0xQLFOdjvQyVKvlU9dNb0pwWJ0GyhYlmxafUsaN41zeDS59FLSPwA8XaEH3iTsPD4r/s9rE2Q48WmreOXqQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786400483; c=relaxed/relaxed;
	bh=k71kDVkPgtVSLGC6YYQTHtEB+mdU008AaGExgWn7PtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVJslwoF3cF0C+gI5yXKdKH0ehi16iYh/A8uoqRnS+BbKyTFc+n8NYc0X2rIG8eUuXC45E1z0un5O51gScomEOUWwCWcTK7HIYXgdFVWz2ltLKucAPxw3pED8C6Es1yc1YuX7Ka0zlO5nSIDVUXOSUQFW7BXrKFXEWhdM8gDTktZgeqKAa5bjTEnDgIiBY4D0r2Zw/GS1So/yaqIBlAK5SsL098d9H7qx/RZh2mgy9QOuZ5K4FlqGmjYw/wZBxfqd4E+i5lgUIp/cakRG1mYfBUCXMKZGOH78pNNjC5SgYnp7vW/ZX3Tkl1ebFMRR4wMHonSyIlRkTkB05pr8kKPPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qwGtE7VT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qwGtE7VT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJq3Q3YGlz2yS6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 08:21:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AK1fKA1504650;
	Mon, 10 Aug 2026 22:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k71kDV
	kPgtVSLGC6YYQTHtEB+mdU008AaGExgWn7PtI=; b=qwGtE7VT9Iax/k/QIIRLcw
	PNJoKHWHJBWynGmjFcm5hV2uVaQ2O78jplFBdj+nXyVVEWQiAY48n7xO21Y5E/I/
	pI5UAlxtkqtM/W3cHY5ZrzdHA83rdVmoVRjAzAHyQB8Jxxmos4s9lrFG4fX19R4O
	/8+GttHw3GSkAUOoYBMrclfwyPdFxfRHW+ytWVpKYQark2gkmf7fG+SPWazbzLYx
	EsyCfpIXy+5ntrS85eGCMH1qoopy8QfP7/b5MtmXQ5wjxo+z0T4XCbAY4qob2YRR
	RR6EI7MfP87BvON/QeNiu71So9vEncVtt41kSy/R92rMyPFfqL8y/2ux2f2+nfLw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23k708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 22:21:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AMBIFf018178;
	Mon, 10 Aug 2026 22:21:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vxry8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 22:21:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AML7wp32178930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 22:21:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF1D85804B;
	Mon, 10 Aug 2026 22:21:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55E8C58063;
	Mon, 10 Aug 2026 22:21:05 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 22:21:05 +0000 (GMT)
Message-ID: <4650ce59-eeec-49f9-bd05-c06904fe9f62@linux.ibm.com>
Date: Mon, 10 Aug 2026 15:21:04 -0700
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
Subject: Re: [PATCH net-next v4 06/14] ibmveth: Refactor TX resource
 allocation in open/close paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <f6e2721c3c664f789a72594d64c7b586ef1ce108.1785457143.git.mmc@linux.ibm.com>
 <20260806183705.3175367-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183705.3175367-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7a4ed5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=V8nVX8gm4qbMgMhMm0IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NyBTYWx0ZWRfX6b6l2HNTNywg
 ulPAYN4lcwYZ6EGhyBt9dEWvuJvoUJMl+p2pxE4WzThy3in2kUNeI+p8o+rori8KIgN0LxlX1Vx
 syw8Z4jf3D4GTp8wt5Sfu3BLLjZM5BiRQj/Cp6jspMR2URuvjIkNtp12jSp+UrzJETpQm/06Vsc
 JhzGFvcaAOG9NTH9KAl9/1VWSQR6lJvA7QncbtE2SUMiGJZP0HDZwz9fHpSJx4hvuLZfpt2dxhr
 fIjkN0QUHrhDqGFSrZK5kPB44w/9697HPbqj+UNet1eC9Rxq8MLDHtxyNIkvE3+cCxZb8A7Nd3v
 0mramX1laAEF2gAnR0tUSSIFAwoBAyzKWRqwByiFJB0krrnaRtecMW9GRak1kDBbQq+/Z5I6Wo1
 pAEWmfhG2tXtYIjFczv707N8sV48WzyJJHUaiZM4duibEXp8Wfh0lxGFICcLDJXY1wjuiOOCwUw
 C/2EWO0hY/YtEyu4PJg==
X-Proofpoint-ORIG-GUID: 9GPOzrTHlZS8uB9Zs4oo96sc6TuwHvzp
X-Proofpoint-GUID: oswL9tYeOAfCIN7nYJvCZp4ACX9RvUBN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NyBTYWx0ZWRfX84qKOkI5gWAp
 FKR+i1rwJXo9TG2gWLxlhGoF5mVVG/dd8AyKizU4W/xKOo02BYBBatf9YeVki0+2+5hMDAnGgeY
 eVMteyctWLQsSq1j7K0z8Sqh6Jrv2xY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100187


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor TX resource allocation in open/close paths
>
> This moves the per-queue TX long term buffer alloc/free loops out of
> ibmveth_open() and ibmveth_close() into ibmveth_alloc_tx_resources() and
> ibmveth_free_tx_resources(), relocates the TX allocation to the end of
> open(), and reworks the open() error unwind labels.
>
> A few questions on the changelog and on the new ordering below.
Hi Jakub,

Thanks for the review.

> [Severity: Medium]
> The changelog says:
>
>      That also retires a mid-open TX leak where the old index-based
>      while (--i) free could skip successfully allocated LTBs.
>
> Is that leak real?  In the parent commit the TX loop re-initializes the
> shared index before allocating anything:
>
> 	rc = -ENOMEM;
> 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
> 		if (ibmveth_allocate_tx_ltb(adapter, i))
> 			goto out_free_tx_ltb;
> 	}
>
> and nothing between that loop and the later gotos (mac_address/rxq_desc
> setup, ibmveth_register_logical_lan(), ibmveth_alloc_buffer_pools(),
> ibmveth_setup_rx_interrupts()) reassigns i.  On every path that reaches
> out_free_tx_ltb, i is either the failing index or real_num_tx_queues, so
> while (--i >= 0) frees exactly what was allocated.  Paths taken before the
> TX loop jump to out_free_filter_list, which is below the TX label.
>
> The new helper also uses the same index-based unwind that the changelog
> calls broken:
>
> err_free_ltbs:
> 	while (--i >= 0)
> 		ibmveth_free_tx_ltb(adapter, i);
>
> Could this paragraph be dropped or reworded to describe the actual
> motivation (removing the dependence on a shared loop index and matching
> the RX helpers)?  As written it reads like a leak fix that a stable
> maintainer might want to backport, and there is no Fixes: tag.
Agreed for this patch. I will drop that paragraph and reword the
motivation in terms of helper extraction, avoiding dependence on shared
open-path loop state, and matching the RX helper structure, rather than
presenting it as a leak fix here.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 664169c4d27a4..131c1a61d9e7e 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1077,8 +1077,14 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>>   
>>   static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>>   {
>> -	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
>> -			 adapter->tx_ltb_size, DMA_TO_DEVICE);
>> +	if (!adapter->tx_ltb_ptr[idx])
>> +		return;
>> +
>> +	if (adapter->tx_ltb_dma[idx]) {
>> +		dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
>> +				 adapter->tx_ltb_size, DMA_TO_DEVICE);
>> +		adapter->tx_ltb_dma[idx] = 0;
>> +	}
> [Severity: Low]
> Is the inner test on tx_ltb_dma[idx] wanted here?  It treats DMA address 0
> as a "not mapped" sentinel, and the only architecturally valid check for a
> bad handle is dma_mapping_error() at map time.  If a mapping ever
> legitimately returned IOVA 0, the TCE entry would leak while kfree() below
> still released the buffer.
>
> On pseries this cannot happen today, since
> arch/powerpc/kernel/iommu.c:iommu_table_reserve_pages() reserves entry 0:
>
> 	if (tbl->it_offset == 0)
> 		set_bit(0, tbl->it_map);
>
> The test also looks redundant: ibmveth_allocate_tx_ltb() already kfree()s
> the buffer and clears tx_ltb_ptr[idx] on dma_mapping_error(), so
> tx_ltb_ptr[idx] != NULL already implies a valid mapping and the new early
> return covers the stated "safe on an unallocated slot" goal.  Would
> dropping the zero test and relying on the pointer check be simpler?
Agreed. In v5 I will just key the free path off allocation state instead
of treating DMA address 0 as a sentinel.
>>   	kfree(adapter->tx_ltb_ptr[idx]);
>>   	adapter->tx_ltb_ptr[idx] = NULL;
>>   }
> [ ... ]
>
>> @@ -1184,35 +1226,38 @@ static int ibmveth_open(struct net_device *netdev)
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
> [Severity: Low]
> This changes hypervisor-visible behaviour on an RX error path, which the
> changelog does not mention while stating "there is no MQ RX behaviour
> change here".
>
> In the parent commit an ibmveth_alloc_buffer_pools() failure went to
> out_free_tx_ltb and then to ibmveth_cleanup_rx_resources(), leaving the
> logical LAN registered with PHYP while the RX ring was freed and the
> buffer list unmapped.  With the new label the h_free_logical_lan() loop
> runs first, which is the safer order.
>
> Is this an intentional fix folded into a TX-only refactor?  If so, could
> it be split out with its own changelog text (the next patch in the series
> reorders open() so this path disappears entirely, so the fix becomes hard
> to find later).
Yes, that change was intentional, and I agree it needs to be called out
more clearly. Freeing the LAN before tearing down the RX resources is
the safer order on that failure path, so in v5 I will say that
explicitly in the changelog instead of letting it read like a pure TX
refactor.
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
> [ ... ]
>
>> @@ -1224,13 +1269,13 @@ static int ibmveth_close(struct net_device *netdev)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>>   	long lpar_rc;
>> -	int i;
>>   
>>   	netdev_dbg(netdev, "close starting\n");
>>   
>>   	netif_tx_stop_all_queues(netdev);
>>   
>>   	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
>> +	ibmveth_free_tx_resources(adapter);
>>   	ibmveth_cleanup_rx_interrupts(adapter);
> [Severity: High]
> Can a transmit already in flight write into the TX LTB after it has been
> unmapped and freed here?
>
> netif_tx_stop_all_queues() only sets __QUEUE_STATE_DRV_XOFF.  It does not
> take __netif_tx_lock and does not wait for an ndo_start_xmit that is
> already running on another CPU (netif_tx_disable() would).  ibmveth_close()
> is also called directly, bypassing dev_close() -> dev_deactivate_many()
> and its synchronize_net() / some_qdisc_is_busy() wait, from:
>
> 	ibmveth_set_csum_offload()
> 	ibmveth_set_tso()
> 	ibmveth_change_mtu()
> 	veth_pool_store()
>
> all of which do:
>
> 	if (netif_running(dev)) {
> 		restart = 1;
> 		ibmveth_close(dev);
> 	}
>
> So a transmitter that already passed netif_xmit_stopped() can be inside
> ibmveth_start_xmit(), which copies into the LTB with no NULL check and no
> lock:
>
> 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
> 	...
> 		memcpy(adapter->tx_ltb_ptr[queue_num] + total_bytes,
> 		       skb_frag_address_safe(frag), skb_frag_size(frag));
> 	...
> 	desc.fields.address = adapter->tx_ltb_dma[queue_num];
>
> while ibmveth_free_tx_ltb() concurrently does:
>
> 	dma_unmap_single(...);
> 	adapter->tx_ltb_dma[idx] = 0;
> 	kfree(adapter->tx_ltb_ptr[idx]);
> 	adapter->tx_ltb_ptr[idx] = NULL;
>
> That looks like either a write of up to tx_ltb_size bytes into freed heap
> memory, or a NULL dereference on the cleared pointer.
>
> A second question on the same move: the DMA unmap now happens before the
> h_free_logical_lan() loop below, so a racing ibmveth_send() can hand PHYP
> a descriptor whose address is 0 or an already unmapped TCE while the
> logical LAN is still registered.  Previously the TX LTBs were freed at the
> very end of close(), after h_free_logical_lan(), free_irq()/napi_disable()
> and the buffer pool teardown, which incidentally left a large gap between
> the XOFF and the free.  Was the inversion intended?
>
> Would keeping ibmveth_free_tx_resources() after the h_free_logical_lan()
> loop, switching to netif_tx_disable(), and/or adding an
>
> 	if (unlikely(!adapter->tx_ltb_ptr[queue_num]))
>
> bail-out in ibmveth_start_xmit() be preferable?

Agreed. This is the main correctness issue in the patch. In v5 I will
quiesce TX before freeing the LTB state and move the TX free back after
`h_free_logical_lan()`. I will also add the `!tx_ltb_ptr[q]` guard in
`ibmveth_start_xmit()`, but I think it reads better as the answer to
your open-side mirror-window point below.


>   The last one would also
> cover the mirror window that the new open() ordering creates, where the
> LAN is registered and RX interrupts/NAPI are live while tx_ltb_ptr[] is
> still NULL during the sleeping GFP_KERNEL allocation in
> ibmveth_alloc_tx_resources():
>
> 	ibmveth_schedule_rx_queue(adapter, 0);
>
> 	rc = ibmveth_alloc_tx_resources(adapter);

Yes, and that is how I plan to cover the open-side window for this
series. `netif_tx_start_all_queues()` still runs only after
`ibmveth_alloc_tx_resources()` succeeds, and the `!tx_ltb_ptr[q]` guard
in `ibmveth_start_xmit()` closes the remaining mirror case without
needing to reorder open in this patch.

>
> [Severity: Low]
> The comment about PHYP mask, napi_disable and free_irq now sits above
> ibmveth_free_tx_resources() instead of above the
> ibmveth_cleanup_rx_interrupts() call it describes, so it reads as
> documentation of the TX free.  Could it move below the TX free?
Agreed. I will clean up that misplaced comment so the code and

commentary match.

Thanks,
Mingming

>
>>   
>>   	do {
> [ ... ]
>
>> -	for (i = 0; i < netdev->real_num_tx_queues; i++)
>> -		ibmveth_free_tx_ltb(adapter, i);
>> -
>>   	netdev_dbg(netdev, "close complete\n");
>>   
>>   	return 0;

