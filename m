Return-Path: <linuxppc-dev+bounces-25749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A72EC5B56A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 18:55:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKLQv3rJgz2yrW;
	Wed, 12 Aug 2026 04:55:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786474503;
	cv=none; b=XunApbzVDSHlOO+TdH2L/1eHXMrII9ngsXR/J3VEPV9vCJh+TQdVS+vo6ZvjjknNJW4cyEaydK0rNgogr3riQagrYb/ILUPrY/Xc5dF6hEYHb/kqKu2R1n8ZBPQtQIM4aMjFEVWwwyHu3hTtBOTz2Co0A9s8kD+iBAn0v3qHG44v3uyyjGoBp3evuywjJwtnpFm1RRwM7xenB7Sci+MKFQUVQRSRmn2bBZmpsvZcaYL6GjThSy2tOSUs7G+xuSbihZlvX/9h4g5tyZh13ISFTQ8FfEWHpDZ1a7QPzr/N1zOC2eqmdiLV03aLFBzfogGCSdyAdOpe8QMIR7TwN9POAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786474503; c=relaxed/relaxed;
	bh=uJBvhwFewNs2EykUznSzRXEKadsuef8BiAq5oW6rHfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKlZyqEYIv/Q6CZeI/y/bbz01NN7ksMmk6FxlcplU8UptUz55cUlX2gT2d4Arkz8Sf1EKFUP9qF2e7modOAhNXZZ2UYE4s807lZc+mcwGr6Xk5ikK2ufqTvUIdW6Gd540xNGBfddSkdwo4Tch3tKnCHCSTAkj/8pOVA0oVwOe47YChpFXA6fKQXhs+ZPloo7e8ng6yh4qEdK8aF0MZ97ezOE4QKMzgL2WTPfZbWTkpYG1/1SH+3C3c42h7FkxbrlAos+5lGgXLEC3YLIbQ9e3dVTsVfHqj88T7l1KFoh7auYPX5JSmgBUfvbSehPVbFkK0id3QcLcSGy6VndhHQZ3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iugRb+5i; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iugRb+5i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKLQs5FhTz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 04:55:01 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVer8933993;
	Tue, 11 Aug 2026 18:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uJBvhw
	FewNs2EykUznSzRXEKadsuef8BiAq5oW6rHfA=; b=iugRb+5i2um2JWEd1FECCb
	jd7XSrTlqcxNLVnL61huOkwwVDWoGmPfaoMx2Qk7POd0J2KKr+ElvBjJGUf9CMdC
	OyxNFnbBaHdqy0EltI2e1hAxKBiXbvRnUpALV4gWI4/kmjdMvBf85iJazKFrZbx/
	KxUSPldr3lA4ru6p08hnbqHHukYTjRlaHASEydA+wHt+/qsptvQegjdVi/bk+gEF
	YAw6AZdHjdTxm8PLXl9DF94kpSIkvDQRJKRZj16NaA/UucfhxIsWnz05PvwN5uYU
	+KGeWhMJrXsMbpNa+zLuGOX6f6qkptus1qK0c94cdLuB6kM9nUmUPU8QLusqC3pg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9pm0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:54:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfMun012141;
	Tue, 11 Aug 2026 18:54:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0ga6mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:54:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIskAq65405414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:54:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8E858057;
	Tue, 11 Aug 2026 18:54:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E37E358058;
	Tue, 11 Aug 2026 18:54:43 +0000 (GMT)
Received: from [9.67.110.153] (unknown [9.67.110.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:54:43 +0000 (GMT)
Message-ID: <d05f8694-6b90-4c44-855a-12b65f9709d6@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:54:43 -0700
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
Subject: Re: [PATCH net-next v4 14/14] ibmveth: Fix MQ RX poll and shutdown
 hangs after queue resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
 <20260806183714.3176012-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183714.3176012-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX081p3BtOIBOt
 lCviIs/J24UaS5z2f1+c2rES4Dm1CiAfE+QWWuKYj+zf4+LhNIC20HIfeq+2XH+Vc+HqZPPVs2o
 hWHPOsmBnV3o/nRIqZYNPqvO/pOydD/0WTOVFsonzjm21/h8RhjfyDm6Nmz5Lax5Zg+K1Kzr2YO
 M6yE+f3YtDNAgLGAaAvmtddUhv6unvpWO+EptgX+zo6aK2D2Q70ThQSjZYYm4qwzmUq+ufFYw4V
 4CqU/nkxsPsLcFOfJcJl21Jxq2OWxhHpUnCB2OLf9xlD+0ngzTO5ZkBjFU9fotBRF8sdIz5TD+g
 gXYxnEEsllONCQKAm7Y8kT3fhAG+8a0ha1Y+JEEH18v18Sf0Ql4fcxE6zrsgT9jjY3AODnkh31j
 cqQFuilxR180UywArd/VfbElvpQ1CyP3axo+XSa1q8dAT3A6L2eADk5esBlFXGbPqNR8eu0aUXE
 4oUgR3OJigfFb0YQWaw==
X-Proofpoint-ORIG-GUID: a6kz70YrMGRrQA6HIs1Q6OybPntPgzQv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXxEGnwxIaAOoh
 bi7Tk9E29rTilksSYP1DirkvGDb6jCz2kI8wNGNrrf6qJLMzW93PV+o+eZeL+LcUXALRMsZEUaX
 mhowZtHixLUVlcMPEEtFc1p+0FtJ0nw=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b6ff8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Tv6OAxz2Y7oFqIR8BB0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3hm7--MNlLqlk31whHC2prmqNYCBWAHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
>
> This changes ibmveth_poll() to skip RX slots whose correlator cannot be
> mapped to a buffer pool instead of retrying them forever, completes NAPI
> when the interface is going down, and adds a descriptor length check
> before skb_put().  The WARN_ON plus adapter reset escalation in the
> correlator validation paths is replaced by a rate-limited message.
>
> No Link: tags present in the commit header.
>
> A few questions below.
Hi Jakub,

Thanks for the review and follow-up.
>
> [Severity: Low]
> Would it make sense to split this into separate patches with individual
> Fixes: tags?  There appear to be four independent changes here:
>
>    - skipping bad RX correlators and dropping the WARN_ON/reset escalation
>    - completing NAPI when the interface is down or napi_disable is pending
>    - validating the descriptor length against skb tailroom before skb_put()
>    - changing the return value on the budget-exhausted shutdown path
>
> There is no Fixes: tag, so stable maintainers cannot pick up the hang fix
> without also picking up the policy change that removes the reset based
> recovery, and the skb_put() hardening is not visible as a fix on its own.
I’ll fold these back into the introducing patches rather than keep a
mixed trailer or invent broad `Fixes:` tags.

These are MQ-series issues in the new poll/resize/teardown paths, not

fixes for older pre-MQ behavior, so I do not think they should be
presented as separate `net` backports.

The better restack is to fold each piece into the patch that introduces
the behavior:
- P05: mask IRQ when napi_schedule_prep() fails
- P09: stopping guards, wrap-safe length validation, honest harvest
- P12: teardown-first resize fix, correlator liveness, residual
   skip+schedule_work handling

So I’ll restack this into the owning patches for v5; P14 may
disappear entirely if nothing independent remains after the fold-back,
rather than keeping one mixed patch with broad `Fixes:` tags.

>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index c99d8e8be7b37..09e06d86701a5 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1376,6 +1376,24 @@ ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
>>   	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
>>   }
>>   
>> +static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
>> +					 int queue_index, u64 correlator)
>> +{
>> +	unsigned int pool = correlator >> 32;
>> +	unsigned int index = correlator & 0xffffffffUL;
>> +
>> +	return pool < IBMVETH_NUM_BUFF_POOLS &&
>> +	       index < adapter->rx_buff_pool[queue_index][pool].size;
>> +}
> [Severity: High]
> This isn't a bug introduced by this patch, since the pre-existing WARN_ON
> checks were also bounds-only, but can a correlator naming an inactive or
> already freed pool still pass ibmveth_rxq_correlator_valid() and then
> dereference a NULL array?
>
> ibmveth_init_buffer_pool() sets pool->size for all pools regardless of
> active state, while ibmveth_alloc_queue_buffer_pools() skips inactive
> pools, and ibmveth_free_buffer_pool() clears the arrays without clearing
> size or active:
>
> 	kfree(pool->free_map);
> 	pool->free_map = NULL;
> 	...
> 	if (pool->skbuff) {
> 		kfree(pool->skbuff);
> 		pool->skbuff = NULL;
> 	}
>
> With the defaults in ibmveth.h:
>
> 	static int pool_count[] = { 256, 512, 256, 256, 256 };
> 	static int pool_active[] = { 1, 1, 0, 0, 0};
>
> a correlator of pool=2, index=0 satisfies both conditions of the new
> helper, and both users then index a NULL pointer before the !skb test can
> help:
>
> 	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>
> and
>
> 	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>
> Should the helper also require pool->active and non-NULL skbuff/dma_addr/
> free_map, or should ibmveth_free_buffer_pool() clear pool->size?  The same
> window seems to apply to pools torn down by ethtool -L scale-down, an MTU
> change, or sysfs deactivation.
Yes. Bounds-only validation is too weak here.

I’ll make the helper require an active pool plus non-NULL
skbuff/free_map state, and clear the freed pool state so it no longer
looks in-range after teardown. That belongs with the resize teardown
story, because the real bug is freeing pool state while stale
correlators can still arrive.
> [Severity: Low]
> This is a pre-existing weakness rather than something new here, but the
> helper only bounds-checks, so a stale correlator that happens to land in
> range after an ethtool -L resize is treated as a live frame.  With
> reuse=false the buffer can be handed to the stack while the hypervisor may
> still own it, and with reuse=true the index is pushed onto free_map a
> second time.  Is there any generation counter or per-queue tag available in
> the correlator that could distinguish a stale descriptor from a current
> one?
No, there is no generation field in the correlator today.

I don’t plan to add one in this series. I think the right fix here is
to close the ownership/teardown hole in P12 so PHYP is no longer
posting into pool state we already tore down. With that fixed, the
stronger liveness checks should be enough as belt-and-braces, without
adding a larger generation/tag change in this cycle.

>> +
>> +static void ibmveth_rxq_advance(struct ibmveth_rx_q *rxq)
>> +{
>> +	if (++rxq->index == rxq->num_slots) {
>> +		rxq->index = 0;
>> +		rxq->toggle = !rxq->toggle;
>> +	}
>> +}
>> +
>>   /**
>>    * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>>    * @adapter: adapter instance
>> @@ -1397,17 +1415,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>>   	unsigned int free_index;
>>   	struct sk_buff *skb;
>>   
>> -	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
>> -	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
>> -		schedule_work(&adapter->work);
>> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
>>   		return -EINVAL;
>> -	}
>>   
>>   	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>> -	if (WARN_ON(!skb)) {
>> -		schedule_work(&adapter->work);
>> +	if (!skb)
>>   		return -EFAULT;
>> -	}
> [Severity: Medium]
> The schedule_work(&adapter->work) escalation is dropped here and in
> ibmveth_rxq_get_buffer(), so nothing bounds the condition any more.  The
> commit message describes the new skip policy but does not mention that all
> recovery escalation is gone.
>
> The previous reset performed a close/open cycle, which issued
> h_free_logical_lan and re-registered the logical LAN, flushing every buffer
> registration the hypervisor still held.  If the bad correlator exists
> because PHYP still holds buffers from a pool that
> ibmveth_free_buffer_pool() already unmapped and freed during an
> ethtool -L resize:
>
> 	dma_unmap_single(&adapter->vdev->dev, pool->dma_addr[i],
> 			 pool->buff_size, DMA_FROM_DEVICE);
> 	dev_kfree_skb_any(skb);
>
> can the hypervisor keep writing into those freed pages indefinitely now
> that the driver only logs and advances?
>
> Separately, this also folds together two different classes: -EINVAL for an
> out-of-range correlator, and -EFAULT where pool and index are in range but
> skbuff[index] is NULL, which indicates driver/hypervisor state desync.  Is
> silently skipping the -EFAULT case intended?
>
> And if the descriptor's correlator belongs to a different queue's pool, the
> skip never reclaims that queue's slot, so that pool's available count stays
> inflated and ibmveth_replenish_task() stops replenishing it:
>
> 	if (pool->active && pool->free_map &&
> 	    (atomic_read(&pool->available) < pool->threshold))
Agreed — skip-only was not sufficient on its own.

The real fix belongs in P12, in the earlier resize/teardown path:
drain, deregister with h_free_logical_lan_queue(), then unmap/free, so
PHYP ownership is released before the pool memory goes away. After
that, I’ll keep residual bad-slot handling with rate-limited logging
plus schedule_work() as secondary recovery, rather than treating
skip-and-advance as the primary answer.

>>   
>>   	/* if we are going to reuse the buffer then keep the pointers around
>>   	 * but mark index as available. replenish will see the skb pointer and
>> @@ -1452,11 +1465,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
>>   	unsigned int pool = correlator >> 32;
>>   	unsigned int index = correlator & 0xffffffffUL;
>>   
>> -	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
>> -	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
>> -		schedule_work(&adapter->work);
>> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
>>   		return NULL;
>> -	}
>>   
>>   	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>>   }
>> @@ -1483,14 +1493,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>>   
>>   	cor = rxq->queue_addr[rxq->index].correlator;
>>   	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
>> -	if (unlikely(rc))
>> +	if (unlikely(rc)) {
>> +		if (rc == -EINVAL || rc == -EFAULT)
>> +			goto advance;
>>   		return rc;
>> -
>> -	if (++rxq->index == rxq->num_slots) {
>> -		rxq->index = 0;
>> -		rxq->toggle = !rxq->toggle;
>>   	}
>>   
>> +advance:
>> +	ibmveth_rxq_advance(rxq);
>> +
>>   	return 0;
>>   }
> [Severity: Low]
> Can ibmveth_rxq_harvest_buffer() still return non-zero after this change?
> ibmveth_remove_buffer_from_pool() has exactly three returns: -EINVAL,
> -EFAULT and 0, and both error codes now go to the advance label, so
> "return rc;" looks unreachable.
>
> That would make all five "if (unlikely(rc)) break;" checks in
> ibmveth_poll(), including the two added by this patch, dead code, along
> with the harvest failure path in ibmveth_drain_rx_queue():
>
> 	rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
> 	if (rc) {
> 		netdev_err(netdev,
> 			   "Failed to harvest buffer from queue %d during drain: %d\n",
> 			   queue_index, rc);
> 		break;
> 	}
> 	drained++;
>
> Should unmappable slots encountered during drain still be counted as
> drained++ with no diagnostic?  The kernel-doc above harvest still documents
> "other - non-zero return from ibmveth_remove_buffer_from_pool", which no
> longer matches the implementation.
As mailed, not for -EINVAL/-EFAULT, so that part was misleading.

I’ll make harvest advance and return rc for -EINVAL/-EFAULT, with
poll/drain continuing past those slots without treating them as
successful receives. I’ll fold that into the earlier poll logic patch
rather than leaving it here as a trailer cleanup.

>>   
>> @@ -3092,11 +3103,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
>>   		return 0;
>>   
>> +	if (!netif_running(netdev) || napi_disable_pending(napi)) {
>> +		napi_complete_done(napi, 0);
>> +		return 0;
>> +	}
>> +
>>   	if (adapter->rx_qstats)
>>   		adapter->rx_qstats[queue_index].polls++;
>>   
>>   restart_poll:
>>   	while (frames_processed < budget) {
>> +		if (!netif_running(netdev) || napi_disable_pending(napi))
>> +			break;
>> +
>>   		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
>>   			break;
>>   
> [ ... ]
>
>> @@ -3126,8 +3145,45 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   			__sum16 iph_check = 0;
>>   
>>   			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
>> -			if (unlikely(!skb))
>> -				break;
>> +			if (unlikely(!skb)) {
>> +				if (net_ratelimit())
>> +					netdev_err(netdev,
>> +						   "bad correlator on queue %d, skipping slot\n",
>> +						   queue_index);
> [ ... ]
>
>> +
>> +			if (unlikely((unsigned int)offset +
>> +				     (unsigned int)length >
>> +				     skb_tailroom(skb))) {
> [Severity: High]
> This is not a regression from this patch, since there was no length check
> at all before, but can this check be bypassed by 32-bit wraparound?
>
> Both operands are cast to unsigned int, so the sum is modulo 2^32.  Unlike
> offset, length is not masked; ibmveth_rxq_frame_length() returns the whole
> descriptor field:
>
> 	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
>
> and in ibmveth.h that field is a full __be32 written by the hypervisor,
> while only offset gets IBMVETH_RXQ_OFF_MASK (0x0000FFFF).
>
> For a corrupted length like 0xFFFFFFF0 with a small offset, the addition
> wraps to a small value and the guard does not fire.  The copybreak test
> compares against "static unsigned int rx_copybreak", so 0xFFFFFFF0 is not
> less than rx_copybreak and no copy skb is allocated, and execution reaches:
>
> 	skb_put(skb, length);
>
> which trips skb_over_panic() -> BUG().  Would an overflow-safe form work
> better here, for example:
>
> 	if (offset > tailroom || length > tailroom - offset)
>
> or validating length against pool->buff_size?
>
> [ ... ]
Yes. The sum-based check can wrap and still let skb_put() overrun.

I’ll switch that to the overflow-safe form, i.e. reject if offset is
already past tailroom or length exceeds the remaining room. That should
live with the patch that introduces the MQ poll path, not as a separate
end-of-series hardening patch.
>> @@ -3206,8 +3262,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   
>>   	ibmveth_replenish_task(adapter, queue_index);
>>   
>> -	if (frames_processed == budget)
>> +	if (frames_processed == budget) {
>> +		if (!netif_running(netdev) || napi_disable_pending(napi)) {
>> +			napi_complete_done(napi, frames_processed);
>> +			/* After complete_done, must not return full budget. */
>> +			return frames_processed ? frames_processed - 1 : 0;
>> +		}
>>   		goto out;
>> +	}
>>   
>>   	if (!napi_complete_done(napi, frames_processed))
>>   		goto out;
>> @@ -3225,6 +3287,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   	}
>>   
>>   	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
>> +	    netif_running(netdev) &&
>> +	    !napi_disable_pending(napi) &&
>>   	    napi_schedule(napi)) {
>>   		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
>>   		WARN_ON(lpar_rc != H_SUCCESS);
> [Severity: High]
> This isn't a bug introduced by this patch, as the
> napi_complete_done() -> ibmveth_enable_irq() -> ibmveth_rxq_pending_buffer()
> sequence is unchanged, but do the new guards actually close the shutdown
> window the commit message describes?
>
> The new mid-loop break also lands here with frames_processed < budget, so
> the quiesce case still reaches:
>
> 	if (!napi_complete_done(napi, frames_processed))
> 		goto out;
>
> Clearing NAPI_STATE_SCHED there is what napi_disable() waits for, so
> ibmveth_close() can proceed past ibmveth_cleanup_rx_interrupts() into
> ibmveth_cleanup_rx_resources():
>
> 	if (adapter->rx_queue[i].queue_addr) {
> 		dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
> 				  adapter->rx_queue[i].queue_addr,
> 				  adapter->rx_queue[i].queue_dma);
> 		adapter->rx_queue[i].queue_addr = NULL;
>
> while the still running poll executes:
>
> 	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
>
> re-arming the PHYP interrupt that close just masked, and then evaluates
> ibmveth_rxq_pending_buffer(), which reads
> rxq->queue_addr[rxq->index].flags_off - a NULL dereference or a read of
> freed coherent memory.  ibmveth_close() has no synchronize_net() between
> napi_disable()/free_irq() and the frees, unlike the scale-down path.
>
> Note the new netif_running()/napi_disable_pending() terms are evaluated
> after ibmveth_rxq_pending_buffer() in the same condition, so they cannot
> prevent that access; they only suppress the following
> ibmveth_disable_irq().
>
> Related question on that suppression: in the window where
> __LINK_STATE_START is already cleared by __dev_close_many() but
> NAPI_STATE_DISABLE is not yet set, the pre-patch code re-masked PHYP via
> the napi_schedule() branch.  With the new guards, poll now returns leaving
> delivery unmasked into the napi_disable()/free_irq() window, and the
> interrupt handler does not mask either when napi_schedule_prep() fails:
>
> 	if (napi_schedule_prep(napi)) {
> 		lpar_rc = ibmveth_disable_irq(adapter, qindex);
> 		WARN_ON(lpar_rc != H_SUCCESS);
> 		__napi_schedule(napi);
> 	}
>
> Can that leave the queue interrupt storming until free_irq()?
>
> [ ... ]
Yes, the mailed guards were incomplete.

The stopping path needs to complete without re-enabling IRQs once close
or napi_disable is in progress.

The schedule_rx_queue() path also still needs to mask the interrupt
when napi_schedule_prep() fails, so the queue does not stay unmasked
into the free_irq() window.

I’ll also keep synchronize_net() in close after RX IRQ/NAPI teardown
and before freeing queue resources, so any poll instance that already
passed the stopping checks is drained before the frees.

Thanks

Mingming


