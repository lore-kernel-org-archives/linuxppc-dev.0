Return-Path: <linuxppc-dev+bounces-25694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37872C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 21:12:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJnWZ3Q8Qz2ykf;
	Tue, 11 Aug 2026 07:12:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786396330;
	cv=none; b=TRm+N4yzjD6d47V89digwJ02wg9ylMrLK0PWBx88pVq6Od98j4ciGoA7uYzDhiDNfyl8znEZrh16TDsnJRqZkGmbUnFAtSCferlfltjVB82a7hlKNYRgLfmbOGWT/lUkCQxBYtKPgTJzW4HIkqxPw7e+rPUK6lWeba5On9Gdp4H2e1KggxnrUxLEA0D6iUtPDi3GxRMqf1VqdQg4nPZfZ3tadDexgLd6WCb5w34raqrVgLchjTdvyMHlksPk4GeOkH8fc1DvrvX+wLiG2omin3gH5bLANWcvInLLRCxmla1i+WIqmNLz4kMfFXHA8kf/tuEy52YR0lqc+89/1fSxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786396330; c=relaxed/relaxed;
	bh=l8hcVbk5Gm9Jj015QPefcGbEzAg75gxxHIpny+Tgm+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGaes4uW0gVPKNawpbVR3zTLwPruo2rXWkd0xOdVRgQMWQ0DCYqJ4PseQNaRIlN6Osa/xmXXkoyqs/tzfB8yA76EbhlY/MAGE0TM8wI/lSliMt9L9+Gdbqq4Kr+OJZnlwXwi6d7dGjZXBk1dyzPnhVYExZPzX4uBSWtdOZ5b0wYHrlknDn5O2ngUxEYGcDFgg/UVrSMN/YktZYGLlSMqmJuFNjSFisZN4/VBBBocooEgnzPl8cLNDVWrx57cXgEsDc4NBwuogBqPGpsCLcdCB2DWiSfd7Rr0XdJNQ6BvPFGBVyHHvp8LVE6D1T+/SuhqsuvK0ABShPz+EcfD4G3tNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Td5NEsLD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Td5NEsLD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJnWY44fdz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 07:12:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AK1mAX2555573;
	Mon, 10 Aug 2026 21:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l8hcVb
	k5Gm9Jj015QPefcGbEzAg75gxxHIpny+Tgm+A=; b=Td5NEsLD3+IfnJWewTfauQ
	8MzlCwS99YtbRB1BoqyUHLOiHugmGrq+fdBBBEwWDyCvDyP0YwCHnW+Fvxg0buAY
	frrSUrBZMH7XxxaIpPs8CNfRj4k8EWRxULs6PMbrZhur/sDF9OALHoUXjfbu+jhq
	YQZjNT76dfHX6/fXxiwF014j4IYPOa+labIog3xTd5n3fZWu9tj2U4hRJmP+xn+Y
	POUMo+QP/aH+39lzdgxu2oRlDTL9GphofRsfoyH1B5iZZ+koWycPPAOpsceZ7sn8
	rx2FRZLn9gm1pGRbQeAoooU52lSW1qn32sc6Ex/8GcSitRjtLa1wPlk6yVAZ5gkA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9a3kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 21:11:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ALBLsQ021843;
	Mon, 10 Aug 2026 21:11:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespxksq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 21:11:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ALBsuC53936484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 21:11:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8FC558064;
	Mon, 10 Aug 2026 21:11:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D385A5803F;
	Mon, 10 Aug 2026 21:11:52 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 21:11:52 +0000 (GMT)
Message-ID: <9ed6bafa-04b1-4462-91b7-035c17c158ff@linux.ibm.com>
Date: Mon, 10 Aug 2026 14:11:52 -0700
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
Subject: Re: [PATCH net-next v4 04/14] ibmveth: Refactor buffer pool
 management for per-queue MQ RX
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <e22471625e6a04bee87f099f467d575bcfd0c2c6.1785457143.git.mmc@linux.ibm.com>
 <20260806183702.3175208-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183702.3175208-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: uvuyZSKGZEdob86CehjXwviSKwx-LS-G
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a3e9d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=A_GA2y18t1HRMksttx4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfX78oVn4Z0zRwf
 39g6wtcGnHdqqAhTP1iHrfiWz0+e4LSdnNBLuWRCIDkZlYoV+Okr118xfOA18e7hL5ZdjwS8liY
 K7PNZpZ5PHYZeyttqQxiE0ibegRbdy2lso8yUXrpelGqhs1lRNAHaAM2yRDMmyulwAgLyeeN+3G
 68QaTCFshXmW2shr4dvQRhMuQd/Z46UshVcRKaFpaW8Mg14+ua9KNPnHtIFXtCeFU0bQjh5EpRU
 cPmTZbVquyx6uB0S9ZlWnyC20qh+jN8yMH4ItQK8JFzwPI/PPkqWJQJU3FVZ5mwYWmSEKirUw4k
 hW/g2Cy37PpstrCeJmoKOmKsvQLyjH3hBsoC/YLtF7N4/jBpw6sc/VxJeq1mChRzMguT21r9z+r
 gNyPRQkwPNQI02fPprGa1PPoTnxVwzXo83ILdOUL36GMR0bzSqVwphVofLs7lopiR0BQD+zFXiD
 NtC3IBT+djP/lLZP9Fw==
X-Proofpoint-ORIG-GUID: 6Q3xwxTgMG-YTWeTJ7bdABI9SfpBBW5Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfX64yDcnMBCVUW
 SGeA3LkskVRyJb1MWilQm/hJrt8+EgBGbs4oBt2AzAmFs5+iR8a4iNWaV2sCzgBQKYws9ERdW4N
 1f3Wid6Q3v3WoGO/gEBbi/IQv0NObL8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100178


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> his is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor buffer pool management for per-queue MQ RX
>
> This reworks the five RX buffer pools into per-queue arrays
> (rx_buff_pool[queue][pool]) with new alloc/free helpers, wires those
> helpers into ibmveth_open()/ibmveth_close(), and clones pool geometry from
> queue 0 to queues 1..N.  It also flips the default active flag of the
> 64 KiB pool to 0.
>
> A few questions below.
Hi Jakub,

Thanks for the careful read.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 1007dd95cde02..7a2ed49cad4f1 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -625,6 +625,145 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>>   	}
>>   }
>>   
>> +/**
>> + * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue: queue index
>> + *
>> + * Allocates all active buffer pools for the specified queue.
>> + * Pool metadata must be initialized before calling this function.
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
>> +				   "pool %d/%d alloc failed (size=%u count=%u)\n",
>> +				   i, queue,
>> +				   bpool->buff_size,
>> +				   bpool->size);
>> +			bpool->active = 0;
>> +
>> +			/* Free pools allocated so far for this queue */
>> +			while (--i >= 0) {
>> +				struct ibmveth_buff_pool *fpool =
>> +					&adapter->rx_buff_pool[queue][i];
>> +
>> +				if (fpool->active)
>> +					ibmveth_free_buffer_pool(adapter,
>> +								 fpool);
>> +			}
> [Severity: Low]
>
> Is the free predicate here meant to differ from the one used by the sibling
> helper added in the same patch?
>
> This unwind path keys off fpool->active, while
> ibmveth_free_queue_buffer_pools() deliberately frees by allocation
> presence:
>
> 	if (pool->free_map || pool->dma_addr || pool->skbuff)
> 		ibmveth_free_buffer_pool(adapter, pool);
>
> and the changelog states "free paths release by real allocations
> (free_map/dma_addr/skbuff), not only pool->active".
>
> So on the queue that fails, a pool holding allocations with active == 0 is
> never released, which is exactly the case the allocation-based predicate
> was added for.  Since a failing ndo_open means ibmveth_close() is never
> called, would those free_map/dma_addr/skbuff arrays be leaked?
>
> ibmveth_free_buffer_pool() already NULLs all three pointers and is
> idempotent, so could the unwind just call ibmveth_free_queue_buffer_pools()
> on the same queue (or use the same predicate)?  The same helper is reused
> by the incremental resize path later in the series, where pools can hold
> memory while active is clear.
Agreed. That unwind is wrong because allocation state and `active` can
diverge on the failure path.  I will make the failure unwind match
`ibmveth_free_queue_buffer_pools()` by freeing on allocation presence
rather than `active`, so partially allocated pools are not skipped just
because `active` was cleared early.
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue: queue index
>> + *
>> + * Frees all active buffer pools for the specified queue.
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: Low]
>
> The kernel-doc summary says "all active buffer pools", but the body
> intentionally ignores the active flag and frees on allocation presence, and
> the in-body comment says the opposite of the summary.  Could the summary be
> reworded to say pools that have allocations?  Later MQ patches reuse this
> helper and depend on that distinction.
Agreed. I will update the kerneldoc to match the actual
allocation-presence free rule.
>> + */
>> +static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
>> +					    int queue)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> +		struct ibmveth_buff_pool *pool =
>> +			&adapter->rx_buff_pool[queue][i];
>> +
>> +		/* Free pool if it has allocated memory, regardless of
>> +		 * active flag. Pools may have memory allocated but not
>> +		 * marked active during queue scale-up, so we must check
>> +		 * for actual allocations.
>> +		 */
>> +		if (pool->free_map || pool->dma_addr || pool->skbuff)
>> +			ibmveth_free_buffer_pool(adapter, pool);
>> +	}
>> +}
>> +
> [ ... ]
>
>> +static int
>> +ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	int i, q, rc;
>> +
>> +	/* Initialize pool metadata for queues 1-15 from queue 0 settings */
>                                              ^^^^^^^^^^
>
> [Severity: Low]
>
> IBMVETH_MAX_RX_QUEUES is 1U at this commit, so queues 1-15 do not exist yet
> and this loop body cannot run.  Should the comment say "queues 1..N" until
> the bound is raised later in the series?
Agreed. I will make that comment generic rather than hard-coding a queue
range.
>> +	for (q = 1; q < adapter->num_rx_queues; q++) {
>> +		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> +			struct ibmveth_buff_pool *src =
>> +				&adapter->rx_buff_pool[0][i];
>> +			struct ibmveth_buff_pool *dst =
>> +				&adapter->rx_buff_pool[q][i];
>> +
>> +			dst->size = src->size;
>> +			dst->index = src->index;
>> +			dst->buff_size = src->buff_size;
>> +			dst->threshold = src->threshold;
>> +			dst->active = src->active;
>> +		}
>> +	}
> [Severity: Low]
>
> This turns the per-pool sysfs knobs into a per-queue template.  Is that
> intended to stay undocumented?
>
> Only queue 0 gets sysfs objects, in ibmveth_probe():
>
> 	struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
> 	...
> 	error = kobject_init_and_add(kobj, &ktype_veth_pool, &dev->dev.kobj,
> 				     "pool%d", i);
>
> and veth_pool_show()/veth_pool_store() read and write that single instance.
> After this change the queue-0 values are cloned above and each queue
> allocates its own copy, so writing num = 4096 to one pool multiplies the
> real allocation by adapter->num_rx_queues while sysfs still reports the
> single-queue value.
>
> The multiplier is 1 everywhere in this series (IBMVETH_DEFAULT_RX_QUEUES is
> 1), so nothing changes today.  Should these knobs stay adapter-wide (counts
> divided across queues), gain per-queue nodes, or should the multiplier be
> documented?
For this series, queue 0's pool sysfs nodes remain the shared
configuration/template interface: they define the pool geometry copied
into each RX queue rather than queue-0-only state. Later in the series I
add debugfs visibility for per-queue runtime information, but not
separate per-queue pool sysfs controls. I will make that split explicit
in the patch and cover letter so the multiplier effect is documented
rather than implicit.
>> +
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
>> +	return 0;
>> +}
>> +
> [ ... ]
>
>> @@ -927,14 +1055,10 @@ static int ibmveth_close(struct net_device *netdev)
>>   
>>   	ibmveth_update_rx_no_buffer(adapter);
>>   
>> +	ibmveth_free_buffer_pools(adapter);
>>   	ibmveth_cleanup_rx_resources(adapter);
>>   	ibmveth_free_filter_list(adapter);
>>   
>> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>> -		if (adapter->rx_buff_pool[0][i].active)
>> -			ibmveth_free_buffer_pool(adapter,
>> -						 &adapter->rx_buff_pool[0][i]);
>> -
> [Severity: Low]
>
> The teardown order changed here, which the changelog does not mention (it
> only says the helpers are wired into open()/close()).
>
> Baseline:
>
> 	ibmveth_update_rx_no_buffer()
> 	ibmveth_cleanup_rx_resources()
> 	ibmveth_free_filter_list()
> 	free active pools
>
> New:
>
> 	ibmveth_update_rx_no_buffer()
> 	ibmveth_free_buffer_pools()
> 	ibmveth_cleanup_rx_resources()
> 	ibmveth_free_filter_list()
>
> h_free_logical_lan(), napi_disable() and free_irq() have all run by this
> point, so neither PHYP nor NAPI still references the pool buffers or the RX
> queue, and the swap looks safe.  Could the reorder be called out in the
> changelog, since a future per-queue drain may need the RX completion queue
> still present while pools are released?
Agreed. The reorder looks safe in the current shutdown path, since LAN
teardown, NAPI shutdown, and IRQ teardown have already happened by then,
but it is still a real teardown-sequencing change. I will call that out
in the changelog, especially since later per-queue drain/free ordering
may care whether the RX completion queue is still present when pools are
released.
>>   	for (i = 0; i < netdev->real_num_tx_queues; i++)
>>   		ibmveth_free_tx_ltb(adapter, i);
>>   
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index 8eaa3942fc40b..abcd4054c67e2 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -265,7 +265,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
>>   static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
>>   static int pool_count[] = { 256, 512, 256, 256, 256 };
>>   static int pool_count_cmo[] = { 256, 512, 256, 256, 64 };
>> -static int pool_active[] = { 1, 1, 0, 0, 1};
>> +static int pool_active[] = { 1, 1, 0, 0, 0};
>                                            ^^^
>
> [Severity: High]
>
> Does this drop large-receive support for existing single-queue users?
>
> Pools 2 (16 KiB) and 3 (32 KiB) are already inactive by default, so with
> the 64 KiB pool off the largest buffer ever posted at MTU 1500 becomes
> 2048 bytes.  ibmveth_probe() seeds each pool from this array:
>
> 	ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
> 				 pool_count[i], pool_size[i], pool_active[i]);
>
> and the new helper skips inactive pools, so nothing larger is handed to
> PHYP:
>
> 	if (!bpool->active)
> 		continue;
>
> ibmveth_poll() does receive hypervisor-aggregated frames longer than the
> MTU:
>
> 	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
> 	    iph_check == 0xffff) {
> 		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
> 		adapter->rx_large_packets++;
> 	}
>
> Those arrive as single non-scatter buffers, and TSO/large-send is enabled
> by default in ibmveth_probe() when firmware reports
> IBMVETH_ILLAN_LRG_SND_SUPPORT.  With no buffer larger than 2 KiB posted,
> are such frames simply dropped by PHYP and counted in the no-buffer counter
> read by ibmveth_update_rx_no_buffer()?
Agreed. With the default RX queue count still at 1, disabling the 64
KiB pool here changes the historical single-queue default rather than
only reducing future MQ memory use. That makes any large-receive
dependency on the 64 KiB pool a regression risk for existing
single-queue users, not just an MQ tuning choice.

>
> The changelog says:
>
>      "MTU changes activate it when required; leaving it enabled would pin
>      about 16 MiB per RX queue in MQ mode."
>
> Is the first half accurate?  ibmveth_change_mtu() activates pools only up
> to the first pool whose buff_size covers the new MTU:
>
> 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> 		adapter->rx_buff_pool[0][i].active = 1;
> 		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size) {
> 			...
> 			return 0;
> 		}
> 	}
>
> At MTU 1500 that stops at the 2 KiB pool, so the 64 KiB pool is never
> re-enabled; ibmveth_set_tso() does not touch pool->active either.  Recovery
> then requires a manual write to pool4/active in sysfs.
You are right that the changelog claim about MTU changes re-enabling it
was not accurate for the MTU 1500 case: `ibmveth_change_mtu()` stops
once the first pool covers the MTU, so pool 4 does not come back
automatically there.
>
> The second half describes MQ, but IBMVETH_DEFAULT_RX_QUEUES is 1 both at
> this commit and at the end of the series (a3781f4ae789 still has
> pool_active[] = { 1, 1, 0, 0, 0}), so the only configurations affected are
> today's single-queue ones.  Would it be better to keep the default at 1 and
> scale the 64 KiB count (or deactivate it) when RX queues are actually
> scaled up?
Yes. If MQ memory pressure still needs separate handling, that should be
done only when RX queues are actually scaled up, not by changing the
single-queue default.
>
> Note also that commit cd7c7ec3687986 ("ibmveth: change rx buffer default
> allocation for CMO") enabled this pool on purpose and added
> pool_count_cmo[] = { 256, 512, 256, 256, 64 } specifically to reduce the
> 64 KiB count under CMO, which suggests the default was deliberate.
>
> As a side effect, ibmveth_get_desired_dma() sums only active pools:
>
> 	if (adapter->rx_buff_pool[0][i].active)
> 		ret += adapter->rx_buff_pool[0][i].size *
> 		       IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].buff_size,
> 					tbl);
>
> so does the CMO entitlement the driver requests shrink silently as well?
Yes. Because desired DMA is summed only over active pools, disabling the

64 KiB pool here also shrinks the requested CMO footprint....

and the earlier CMO change also suggests the 64 KiB default was

intentional rather than incidental.

In v5 I will restore the default pool activation so the 64 KiB pool
remains enabled in the normal single-queue baseline.

Thanks again for the careful review,
Mingming

>>   
>>   #define IBM_VETH_INVALID_MAP ((u16)0xffff)

