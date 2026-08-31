Return-Path: <linuxppc-dev+bounces-26321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F90C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 18:21:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYckX60kxz2y2f;
	Tue, 01 Sep 2026 04:21:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788200468;
	cv=none; b=PtUiU/ESjwki8PCeQfP+eGO2hIE2SBt8UPbBs1a7p1LHySgTidDXqn64UmvwhosLgMzXE9QK9FaKAsbhkIclzW+fHRu3xBLkoQ5PxbC9WquK0vQJRu6MXttaAobzoASwG+lYT/t2hmrRa/qIS5LiO6yyLsLnjB3QcIs1k2on7SRjWub2pMKzoHERmf8zIqitc1D+UxwpuwFPHfkCXX6MsoQSGGpyBct6Dj4JbG4fUju9tTRcBNLjCxbV0qVZVm9lBzV72PAJLy06SFoSbCpcBmTIzJHyRhfTt1ZNgCYWF/xBUpfeASMw0yGA92rr+Uk04roLbpxv+dFSzLSRWzwA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788200468; c=relaxed/relaxed;
	bh=E+e18lt/Wf64vnkjrURZ5da2QsMxfg1mcvxo0SdX0Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPJcu7EHbKtu7QrOfKO/Lc4RxG80BzQvwy9NVPtMxb/4pAhYwFdjrv6W2wwJ+7ug1J8bYm4Kyn94EDaMdA6FiHVLHDgvoVmFF7nwpq5qvwQPTBQcMNF3oLnvWlKTJdHtNZuZ4um2jk5QvYcwbHea1O2G6UeHKNzXm4jGA2Ig0DUe3DzieZB2jj6eVUqj3PU8YxgXYH3GH1EwN6EwFig6xWCmp5pLhVk20wkIi+bxlxEvdvZ1ahr0h4Ew/nSyYRsWvpDb0MzDqsp0HiQH4+ez0jM/kt4H1vsf5zohFGkVJ7x6LF/7F7XXKssONxjLFppSKAr4dxBAPga+Q7bi8DLJXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XFu0aTKB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XFu0aTKB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYckW6C5Mz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 04:21:07 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1VGZ2743470;
	Mon, 31 Aug 2026 18:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E+e18l
	t/Wf64vnkjrURZ5da2QsMxfg1mcvxo0SdX0Fk=; b=XFu0aTKBK5pG37CsimFebU
	xC/+SaYmcUFQ1jepA62UQE4cmuhsIrRX7hPPW/Dk+kbUvvPQhSkFigS1EjEZaMhS
	P3t9HbzmGbJYtrWLa4GQV6TlG0dClHVN0qu/EunK3TFL9QdjOrUt7u3G1B5/XLHo
	xX9IfOWL09DvUOPBuKgYml6l9oEdUHiE5hhWdhvHiukquCdP1uUaphVRLvwi+WM2
	meT5g1tctwOOMduYzqXmdt1hxSDMQKApar5kkb1+3puWc2XOkkEu4TDP9dlMuwgZ
	0bXz44R6hOoZ6gP89qRf3C+xBtYNzfNtVFSZBKP7Mhlsbl2zdUgGn6051UtJdWNA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54k3qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:20:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHuGew023330;
	Mon, 31 Aug 2026 18:20:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexy6rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:20:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VIKrrU63897930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 18:20:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C57BB5805C;
	Mon, 31 Aug 2026 18:20:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C4DF5805A;
	Mon, 31 Aug 2026 18:20:50 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 18:20:49 +0000 (GMT)
Message-ID: <ca132b73-5fd9-428f-af41-cfabedf0e0b4@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:20:49 -0700
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
Subject: Re: [PATCH net-next v5 04/15] ibmveth: Refactor buffer pool
 management for per-queue MQ RX
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-5-mmc@linux.ibm.com>
 <20260818014721.3854017-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014721.3854017-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX9VxGHlY/J3wd
 6diRaPavGGw3a3lEneuW+3FTHRILtK1jE9COPeNjpN+J4wOtZzVoKBmV7n+ejpCiTpvu6A0Im0m
 laIEy6uoDFAMzr4/zUFgi1WMzU/SrxIdQMC1NiXKKPCQUkyfgOHMAbb4rqTQmUT2RN8uKC7rUGf
 7sKFH7AWmByQZ++Dt+UrokVXiM1c0JoqMUBdXXRVez9Fidvgr+x5AnkNrTsQgzVW5acC7BCimPH
 YXv6uzqj3GsaLVnBfQ35V7iEtrESb+J4dLNUwRXcDATVUV3KJ/9jcpf17v5n81jD5jmfgHWdMFR
 m2wvfpQUZB1EK6O4y4hqSHBz612uU/GgotvgNyMV4DJBPlpN49vyEbBbcuNj7Vbuemp6qFlKEn6
 awt+hJbzwSYGozgZQuE0qNW1Oxp8E6gxp87iFeTVg0kYn+PrWp6iMetRdnB1+Hq9UOmrjI/KCik
 Z5Se9qn2KYC71ywDqcA==
X-Proofpoint-ORIG-GUID: BGFlM4vjHa5cfMr_wXz5NyzWkyiNQzSw
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95c60a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=WWzy1uu8kLQVPc8He4wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pikxgrftQtpfgMHSmnrkAnpYUkpPpmqD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX9jOBqS+UIDVZ
 +YzvTvcLDFkEh0aAVDcfjGJVBVkhubcJMDBEt/8jxV/N7yonkJlNfmNeL79ocf8kFilmZMLR+Pi
 LtFz0l2JOSPuqPINghcOM7VqmO967O8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310156


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor buffer pool management for per-queue MQ RX
>
> This moves the five RX buffer pools to a per-queue array and introduces
> ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools() plus the
> per-queue helpers, wiring them into open() and close(). Queue 0 stays the
> template for pool geometry and activation, and runtime is still
> single-queue.
>
> A few questions below about the new unwind paths and about two of the
> new comments.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 168940bfa1094..1a428ee60d58c 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -627,6 +627,142 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>>   	}
>>   }
>>   
>> +/**
>> + * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
> [ ... ]
>
>> +/**
>> + * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue: queue index
>> + *
>> + * Allocates backing storage for each active pool on @queue.
>> + * Inactive pools (!active) are skipped. Pool metadata must be
>> + * initialized before calling this function.
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
>> +					    int queue)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	int i;
>> +
>> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> +		struct ibmveth_buff_pool *bpool =
>> +			&adapter->rx_buff_pool[queue][i];
>> +
>> +		if (!bpool->active)
>> +			continue;
>> +
>> +		if (ibmveth_alloc_buffer_pool(bpool)) {
>> +			netdev_err(netdev,
>> +				   "queue %d pool %d alloc failed (size=%u count=%u)\n",
>> +				   queue, i,
>> +				   bpool->buff_size,
>> +				   bpool->size);
>> +			bpool->active = 0;
>> +			/* Free by allocation presence, not active — the
>> +			 * failing pool cleared active first and would be
>> +			 * skipped by an active-only unwind.
>> +			 */
> [Severity: Low]
> Is the stated rationale in this comment accurate?  Freeing by allocation
> presence is a fine policy for the later resize paths, but the specific
> claim that an active-only unwind would skip the failing pool and leak it
> does not seem to hold here, because ibmveth_alloc_buffer_pool() already
> undoes its own partial allocations before returning -1:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_alloc_buffer_pool() {
> 	pool->dma_addr = kzalloc_objs(dma_addr_t, pool->size);
> 	if (!pool->dma_addr) {
> 		kfree(pool->free_map);
> 		pool->free_map = NULL;
> 		return -1;
> 	}
>
> 	pool->skbuff = kcalloc(pool->size, sizeof(void *), GFP_KERNEL);
>
> 	if (!pool->skbuff) {
> 		kfree(pool->dma_addr);
> 		pool->dma_addr = NULL;
>
> 		kfree(pool->free_map);
> 		pool->free_map = NULL;
> 		return -1;
> 	}
> 	...
> }
>
> By the time bpool->active = 0 runs, free_map/dma_addr/skbuff are all NULL
> for the failing pool, so there is nothing for an active-only unwind to
> miss.  The same claim appears in the changelog ("v4 fail path freed by
> active and skipped the failing pool", "open-fail cannot leak partially
> allocated pools").  Could the comment and changelog instead justify
> free-by-presence purely in terms of the later resize paths?
Agreed. v6 retargets the comment and changelog to the later resize
paths. Policy is unchanged.
>> +			ibmveth_free_queue_buffer_pools(adapter, queue);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> [ ... ]
>
>> +	/* Allocate actual buffers for all queues */
>> +	for (q = 0; q < adapter->num_rx_queues; q++) {
>> +		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
>> +		if (rc) {
>> +			/* Free pools for all previous queues */
>> +			while (--q >= 0)
>> +				ibmveth_free_queue_buffer_pools(adapter, q);
>> +			return rc;
>> +		}
>> +	}
>> +
>> +	netdev_dbg(netdev, "allocated buffer pools for %d queue(s)\n",
>> +		   adapter->num_rx_queues);
> [Severity: Low]
> This isn't a bug, but adapter->num_rx_queues is declared as
> "unsigned int num_rx_queues;" in drivers/net/ethernet/ibm/ibmveth.h, so
> should these two new messages use %u rather than %d?  The same applies to
> the netdev_dbg() in ibmveth_free_buffer_pools() below.
Yes,  Both count prints use %u in v6.
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ibmveth_free_buffer_pools - Free buffer pools for all queues
>> + * @adapter: ibmveth adapter structure
>> + *
>> + * Frees buffer pools for all queues using the helper function.
>> + */
>> +static void
>> +ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
>> +{
>> +	int q;
>> +
>> +	/* Free buffer pools for all queues */
>> +	for (q = 0; q < adapter->num_rx_queues; q++)
>> +		ibmveth_free_queue_buffer_pools(adapter, q);
>> +
>> +	netdev_dbg(adapter->netdev, "freed buffer pools for %d queue(s)\n",
>> +		   adapter->num_rx_queues);
>> +}
>> +
>>   /**
>>    * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>>    * @adapter: adapter instance
>> @@ -851,16 +987,9 @@ static int ibmveth_open(struct net_device *netdev)
>>   		goto out_free_tx_ltb;
>>   	}
>>   
>> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> -		if (!adapter->rx_buff_pool[0][i].active)
>> -			continue;
>> -		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
>> -			netdev_err(netdev, "unable to alloc pool\n");
>> -			adapter->rx_buff_pool[0][i].active = 0;
>> -			rc = -ENOMEM;
>> -			goto out_free_buffer_pools;
>> -		}
>> -	}
>> +	rc = ibmveth_alloc_buffer_pools(adapter);
>> +	if (rc)
>> +		goto out_free_tx_ltb;
> [Severity: Medium]
> This isn't a gap introduced by this patch (the old inline pool loop fell
> through to the same labels), but since the edge is being rewritten here:
> this goto is taken after ibmveth_register_logical_lan() has already
> succeeded, and the unwind it lands on never issues h_free_logical_lan():
>
> out_free_tx_ltb:
> 	while (--i >= 0)
> 		ibmveth_free_tx_ltb(adapter, i);
> 	ibmveth_cleanup_rx_resources(adapter);
> out_free_filter_list:
> 	ibmveth_free_filter_list(adapter);
>
> ibmveth_cleanup_rx_resources() does the dma_unmap_single() of
> buffer_list_dma[], the dma_free_coherent() of the RX completion queue and
> the free_page() of the buffer-list page, and ibmveth_free_filter_list()
> releases the filter list, all while PHYP still holds those addresses.  The
> adjacent request_irq() failure path does perform the handshake the driver
> otherwise considers mandatory:
>
> 		do {
> 			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> 		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>
> Can PHYP write the rx_no_buffer counter into the freed buffer-list page, or
> post a completion into the freed RX queue, after this path returns?  The
> h_vio_signal(VIO_IRQ_DISABLE) issued just before registration also is not
> rebalanced here.
>
> Later patches in this series do repair this: "ibmveth: Refactor TX resource
> allocation in open/close paths" retargets this edge to out_unregister_lan,
> and by the end of the series ibmveth_open() allocates the pools before
> ibmveth_register_rx_queues() and routes post-registration failures through
> ibmveth_free_all_queues() -> h_free_logical_lan().  Would it be reasonable
> to point this goto at a label that unregisters the logical LAN already in
> this patch, so the intermediate commit is not bisect-visible?

Yes it can, at this point. Not retargeted here: the missing hcall
belongs with the TX open/close unwind (patch 6), and pools-before-
register is the register-helpers patch (7). Pointing this goto at a
new unregister label here would just be removed again in patch 6 when
out_unregister_lan replaces it — churn for no net gain. The
intermediate state is real but not a bisect hazard: num_rx_queues is
still 1 and this path is only reachable after a successful
h_register_logical_lan(), which is the same exposure the baseline had.

>>   
>>   	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>>   	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>> @@ -885,11 +1014,7 @@ static int ibmveth_open(struct net_device *netdev)
>>   	return 0;
>>   
>>   out_free_buffer_pools:
>> -	while (--i >= 0) {
>> -		if (adapter->rx_buff_pool[0][i].active)
>> -			ibmveth_free_buffer_pool(adapter,
>> -						 &adapter->rx_buff_pool[0][i]);
>> -	}
>> +	ibmveth_free_buffer_pools(adapter);
>>   out_free_tx_ltb:
>>   	while (--i >= 0)
>>   		ibmveth_free_tx_ltb(adapter, i);
> [Severity: Medium]
> This is a pre-existing issue rather than one introduced here, but does this
> hunk silently fix a TX long-term-buffer leak?
>
> In the parent commit the pool unwind consumed i:
>
> out_free_buffer_pools:
> 	while (--i >= 0) {
> 		if (adapter->rx_buff_pool[0][i].active)
> 			ibmveth_free_buffer_pool(adapter,
> 						 &adapter->rx_buff_pool[0][i]);
> 	}
> out_free_tx_ltb:
> 	while (--i >= 0)
> 		ibmveth_free_tx_ltb(adapter, i);
>
> so on reaching out_free_tx_ltb by fall-through, i was already -1 and the
> first test of --i evaluated to -2, meaning no tx_ltb_ptr[]/tx_ltb_dma[]
> buffer was released.  With the pool unwind now a helper call that does not
> touch i, i still holds the TX queue count from the completed TX allocation
> loop, so the TX LTBs are freed.
>
> Every PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE) TX buffer plus its DMA mapping was
> leaked on each failing open, and it repeats per attempt ("ip link set <dev>
> up" under memory pressure, or the close+open pair inside veth_pool_store(),
> ibmveth_change_mtu() and ibmveth_reset()).
>
> Would it make sense to split this out as its own patch with a Fixes: tag so
> stable trees pick it up, or at least describe it in the changelog?

Yes, as a side effect of pulling the pool loop out. v6 names it in the
commit message. Not split out: adding it at the head would make the
series 16 patches, exceeding the netdev limit.

Thanks,

Mingming


