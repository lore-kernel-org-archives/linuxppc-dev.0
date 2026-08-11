Return-Path: <linuxppc-dev+bounces-25707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BB2C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 01:22:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJv3p00Wxz2yys;
	Tue, 11 Aug 2026 11:21:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786411317;
	cv=none; b=AtyY7h0iw87rY1zUBlpf8vtYqHZLS51oKQbQCkV0tJhlmRkrZ+VqDrh79ezS/EgLJg5w8y+zeWJnHLR7Bbdek0cTKWBLL7Zo1ZQgCPdTDfdFpoauf4aKNQHCWLYCkvV9XaL4QH5Uu21Uob5xO0mVVObddFEQhdcpe9NPtDO5oO77UIkS5tvxruz+ma3WJOdkvjx4Cov/4ePDf5Ig/mDgjJL5BwrhOcSCAdex9/Ug/esLzlPrQD41eM2EgDNjWlDm6+aQzUd7teDQAOEvxEWlhAw8iwwcJUzXX2l7HY4drLq81wUjP7jB3/USPf7Z0NP5MbEqJqaDC0nqimGQU40+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786411317; c=relaxed/relaxed;
	bh=w+dg5OyQHWvNF2WnFDp4vjddf5w5FOpCb/revXDgKxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBQDJzN74sTUQsplazAyZ5GifjhF6vDvRUnzvCXf1waVklIMdp8gbSwWedX7ggotP5nNVfHuVE2R4N0jF2/BFHnRSTBF68Xydkgd+I6wFFoswC8UaIjt8xu+KDHuWfx+t87pcFDx/PzlXs8Dukbzj5eJd/689vtHtCaw+ae4XAStBTUvwa3OxljyiuBUcz7waORqMCuC9qNgktWmQg6qlHa5PgLE4oV7U2iVuIm5jf77wVhB3g4S5In25M3SWnoWACC9YGde1j+aNolKpKHI27WykLhAydTZ4Uwa7LcnuotRe55GX+etmttuRBySR3U6UKbtjNdIaZe/kdK9BopOOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RWnjeVwh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RWnjeVwh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJv3m2c8kz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 11:21:55 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1cKd2878857;
	Tue, 11 Aug 2026 01:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w+dg5O
	yQHWvNF2WnFDp4vjddf5w5FOpCb/revXDgKxg=; b=RWnjeVwhC5cHhZIfRHespW
	8B9YYZ1i+L3JT6L1hIy+gtQAzPP1NadxYXNDWejbtj+QibAlNfIueKMnI4/Fj8E1
	nf4qv/XsaeRnpneYPExuCAkNdCB4ClfNrGcMCa16JGejIa+k4ShhTeSlHQbC8xBV
	tOSa5ll0zhjR4Ydodg7BpAwUZsNtkviMktM13zjuZ3SgW69E+XU2fe4sMgunGB2F
	HUu+e2z+AFwCkhVtaVnVCuBSCD8GzGTVBpi4DUdb7IQE+oqvUxoMbDvOo4i8F6FN
	pMSPB95G0aZ1bNRhnpZIqyGAaqwJh/LIpvFEkquGD5r7MwjCmHOFVTyUImPH2TQw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2t94b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 01:21:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B1BI6M002873;
	Tue, 11 Aug 2026 01:21:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gy1fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 01:21:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B1Lbji26477132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 01:21:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF755805A;
	Tue, 11 Aug 2026 01:21:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C895803F;
	Tue, 11 Aug 2026 01:21:35 +0000 (GMT)
Received: from [9.67.11.26] (unknown [9.67.11.26])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 01:21:35 +0000 (GMT)
Message-ID: <ad3365c7-36b7-432d-8c04-58c2b116cdbf@linux.ibm.com>
Date: Mon, 10 Aug 2026 18:21:34 -0700
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
Subject: Re: [PATCH net-next v4 12/14] ibmveth: Implement incremental MQ RX
 queue resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <7d183a47b3649a98da8505eccbea3b0be3ef6eec.1785457143.git.mmc@linux.ibm.com>
 <20260806183711.3175827-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183711.3175827-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a7924 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=PXVfn_wPYez5XgSzDgEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: 366r1tDaAp8U8Dow54096PnDb4HBZnCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAwNiBTYWx0ZWRfX+uSUiK5QRp1v
 QD2fqlCom4kzgkGmm+4bU9kGj9J/HcabIn5geIT0mdoQyZPYpn1KtitR3OfjZLQA7c3nooYLFdU
 KHu8l3ZzTwao6W9DHAQhBhrsOkMZYJsH4M+FYOI38qPJ0T9x3CysEae6XEXxuTfUvYjPiO7NNWj
 jXJ2Lkn5NSu4j1+gxjkQvXt8ZbOFVT5bKVSAvZVywDCHXOKkn//KfpLRKSOa482VX403Zpg6X6q
 J25Hp5MovuUUY9Q/du81Ha5vjhV9FkNmFlJB0d8KOC18+fcL7FRweErwB55protd24dhNFyilCT
 fx+Nk1AGVd+PkfTVxcSrhfoG0RD+ZDoOBw1ZOW+41J5dEWHHJHjX7JLOcYUrpQC+EBPP946X1L7
 MjlFdYTdlu4wNqK8kZpWAkSZA3W6ZUlCm+BCJqQSurCKXDTNojSDgBZVIZdIecsKxQKn+uTKfvr
 JGrNaClh9lUnUnBEv3w==
X-Proofpoint-ORIG-GUID: NiyFzD1eOGK4llmABWBNC0J7c3ZsoKy1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAwNiBTYWx0ZWRfX9XmiMRVMUYLE
 MSDQBRU8og9oktXAYuKZ7i2YK3cxxTKTR7ZqRov8YmrXmJPnDV6ChT1ZfMHP5LoiwU+lFFLXfsv
 YKmOSaH3Kd1Lc/dfY31DFnG0LCwgLp4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110006


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Implement incremental MQ RX queue resize
>
> Adds per-queue alloc/register/irq-setup/free helpers plus
> ibmveth_resize_rx_queues_incremental() so the live RX queue count can grow
> or shrink without tearing down surviving queues, and wires
> ibmveth_resize_rx_channels() into set_channels() when the interface is up.
>
> A few questions on the new resize paths below.
Hi Jakub,

Thanks for the review.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index db13747466025..b57c7df92853f 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1307,6 +1494,51 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * ibmveth_drain_rx_queue - Drain pending buffers from an RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue_index: Queue index to drain
>> + *
>> + * Recycles all pending buffers back to the per-queue buffer pools.
>> + * Must be called with NAPI disabled for this queue.
>> + *
>> + * Return: Number of buffers drained
>> + */
>> +static int
>> +ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	int drained = 0;
>> +	int limit = adapter->rx_queue[queue_index].num_slots;
>> +	int rc;
>> +
>> +	netdev_dbg(netdev, "Draining RX queue %d (limit: %d slots)\n",
>> +		   queue_index, limit);
>> +
>> +	while (drained < limit &&
>> +	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
>> +		/* Match poll-side order before harvesting completion state. */
>> +		smp_rmb();
>> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
>> +		if (rc) {
>> +			netdev_err(netdev,
>> +				   "Failed to harvest buffer from queue %d during drain: %d\n",
>> +				   queue_index, rc);
>> +			break;
>> +		}
> [Severity: Low]
> Can this error arm ever run?  ibmveth_rxq_harvest_buffer() normalizes
> every failure to a 0 return:
>
> 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
> 	if (unlikely(rc)) {
> 		if (rc == -EINVAL || rc == -EFAULT)
> 			goto advance;
> 		return rc;
> 	}
>
> advance:
> 	ibmveth_rxq_advance(rxq);
>
> 	return 0;
>
> and ibmveth_remove_buffer_from_pool() only ever returns 0, -EINVAL or
> -EFAULT, so both non-zero values take the goto advance path.  The
> netdev_err()/break looks like dead code.
Yes, that error arm is effectively dead on the mailed patch.

I’ll make harvest return `-EINVAL` / `-EFAULT` honestly and keep drain
tolerant of those slot-advanced cases.
>> +		drained++;
>> +	}
>> +
>> +	if (drained > 0)
>> +		netdev_dbg(netdev, "Drained %d buffer(s) from RX queue %d\n",
>> +			   drained, queue_index);
>> +	else
>> +		netdev_dbg(netdev, "No buffers to drain from RX queue %d\n",
>> +			   queue_index);
>> +
>> +	return drained;
>> +}
>> +
> [ ... ]
>
>> @@ -1562,6 +1794,227 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
>>   	return 0;
>>   }
>>   
> [ ... ]
>
>> +static int
>> +ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
>> +				     int new_count, int rxq_entries)
>> +{
> [ ... ]
>
>> +		for (i = old_count; i < new_count; i++) {
>> +			rc = ibmveth_alloc_single_rx_queue(adapter, i,
>> +							   rxq_entries);
> [ ... ]
>
>> +			/*
>> +			 * Fully ready before PHYP delivery, matching open():
>> +			 * publish -> replenish -> napi_enable -> enable_irq.
>> +			 * That way ibmveth_interrupt() cannot run on an
>> +			 * unpublished, empty, or NAPI-disabled queue.
>> +			 */
>> +			adapter->num_rx_queues = i + 1;
> [Severity: Medium]
> Should this publish store be ordered?  adapter->num_rx_queues is the only
> gate that makes rx_queue[i].queue_addr/num_slots/toggle/replenish_lock,
> rx_buff_pool[i][*] and buffer_list_addr[i] visible to lockless readers,
> and it is written with a plain store here while the queues added in
> earlier iterations are already running NAPI with PHYP unmasked.
>
> The consumers also use plain loads from hardirq and softirq context:
>
> ibmveth_interrupt():
> 	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
> 		return IRQ_NONE;
>
> ibmveth_poll():
> 	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
> 		return 0;
>
> and ibmveth_update_rx_no_buffer() dereferences buffer_list_addr[i] for
> every i below the count.  On powerpc, can a reader see the incremented
> count while still observing stale contents of that slot (for example a
> buffer_list_addr[i] left NULL by an earlier scale-down), or the converse
> stale count for the queue whose interrupt was just unmasked?  Would
> WRITE_ONCE()/READ_ONCE() plus a release barrier before the publish be
> appropriate here?
Yes, the publication model needs to be explicit here

`num_rx_queues` is the visibility boundary for lockless readers, so I'm
planning to publish it with ordering only after the per-queue state is
ready, and use matching read-side accessors on the IRQ, poll, and
other lockless reader paths.

>> +			ibmveth_replenish_task(adapter, i);
>> +			napi_enable(&adapter->napi[i]);
>> +
>> +			rc = ibmveth_enable_irq(adapter, i);
> [Severity: Medium]
> After the unmask, should the queue be re-checked for descriptors that
> PHYP enqueued while delivery was masked?  Buffers are posted by
> ibmveth_replenish_task() before ibmveth_enable_irq(), so PHYP can write
> descriptors during the masked window.  ibmveth_poll() does exactly this
> compensation:
>
> 	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
> 	...
> 	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
> 	    napi_schedule(napi)) {
> 		ibmveth_disable_irq(adapter, queue_index);
> 		goto restart_poll;
> 	}
>
> Without an equivalent pending check plus napi_schedule() here (and in the
> scale-down rollback loop further down, which is even more exposed since
> PHYP may have enqueued during the disable/drain window), can the new
> queue sit with unharvested descriptors until unrelated traffic raises the
> next interrupt?
Yes, after unmask the queue needs the same pending-work kick.

The right rationale is that PHYP may already have posted descriptors
while delivery was masked. I’ll kick the queue after scale-up
enable_irq and after scale-down rollback unmask so pending work is
serviced promptly.
>> +			if (rc) {
>> +				netdev_err(netdev,
>> +					   "Failed to enable IRQ for queue %d: %d\n",
>> +					   i, rc);
>> +				adapter->num_rx_queues = i;
>> +				napi_disable(&adapter->napi[i]);
>> +				ibmveth_cleanup_single_rx_interrupt(adapter, i);
>> +				ibmveth_deregister_single_rx_queue(adapter, i);
>> +				ibmveth_free_single_rx_queue(adapter, i);
>> +				goto cleanup_new_queues;
>> +			}
> [Severity: Medium]
> Is rc an errno at this point?  ibmveth_enable_irq() -> ibmveth_toggle_irq()
> returns the raw plpar_hcall_norets() result and only normalizes
> H_PARAMETER to 0, so rc can be H_HARDWARE (-1), H_FUNCTION (-2),
> H_PRIVILEGE (-3) or the positive H_BUSY (1).  That value is returned
> unchanged through ibmveth_resize_rx_channels() -> ibmveth_set_channels()
> into the ethtool ioctl, so userspace sees EPERM/ENOENT/ESRCH, or for a
> positive code a positive ioctl return that ethtool reads as success even
> though the resize failed and unwound.
>
> The pre-existing ibmveth_setup_rx_interrupts() converts the same failure
> with rc = -EIO; should this path do the same?
Yes, that should return a Linux errno, not raw `H_*` status.

I'm planning to keep the helper contract normalized to errno and make
the resize path return `-EIO` on enable_irq failure rather than leaking
hypervisor status upward.
>> +		}
>> +
>> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
>> +		if (rc) {
>> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
>> +				   new_count, rc);
>> +			goto cleanup_new_queues;
>> +		}
>> +	} else {
>> +		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
>> +			   new_count, old_count - 1);
>> +
>> +		/*
>> +		 * Mask PHYP delivery before napi_disable/drain. Otherwise
>> +		 * ibmveth_interrupt returns IRQ_HANDLED without masking when
>> +		 * NAPI is disabled, and the HV can storm during drain.
>> +		 */
>> +		for (i = new_count; i < old_count; i++) {
>> +			ibmveth_disable_irq(adapter, i);
>> +			synchronize_irq(adapter->queue_irq[i]);
>> +		}
>> +
>> +		for (i = new_count; i < old_count; i++)
>> +			napi_disable(&adapter->napi[i]);
> [Severity: Medium]
> Does the mask actually hold across the drain?  synchronize_irq() waits
> for the hardirq handler, not for an ibmveth_poll() already in flight on
> another CPU, and that poll re-arms delivery unconditionally:
>
> CPU0 (resize)
> 	ibmveth_disable_irq(adapter, i);
> 	synchronize_irq(adapter->queue_irq[i]);   /* handler idle, returns */
> 	napi_disable(&adapter->napi[i]);          /* returns after
> 						     napi_complete_done() */
>
> CPU1 (ibmveth_poll for queue i, scheduled before the mask)
> 	if (!napi_complete_done(napi, frames_processed))
> 		goto out;
>
> 	lpar_rc = ibmveth_enable_irq(adapter, queue_index);  /* unmasked */
>
> so the drain can run with PHYP delivery re-enabled.  With NAPI disabled,
> ibmveth_schedule_rx_queue() fails napi_schedule_prep() and returns
> without masking, and once adapter->num_rx_queues is lowered each further
> delivery hits WARN_ON(qindex >= adapter->num_rx_queues) in
> ibmveth_interrupt() and returns IRQ_NONE.  Is the storm rule stated in
> the comment still guaranteed?  The same ordering is repeated in the
> cleanup_new_queues label below.

Yes, the drain and rollback comments were too strong as written.

Teardown-first is still the primary fix, but poll also needs to stop
re-enabling delivery while the queue is being stopped. I'm planning to
tighten that stopping behavior so the drain window cannot remask PHYP
during teardown.

>> +
>> +		for (i = new_count; i < old_count; i++)
>> +			ibmveth_drain_rx_queue(adapter, i);
>> +
>> +		synchronize_net();
>> +
>> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
>> +		if (rc) {
>> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
>> +				   new_count, rc);
>> +			for (i = new_count; i < old_count; i++) {
>> +				ibmveth_replenish_task(adapter, i);
>> +				napi_enable(&adapter->napi[i]);
>> +				ibmveth_enable_irq(adapter, i);
>> +			}
>> +			return rc;
>> +		}
> [Severity: Medium]
> Should the ibmveth_enable_irq() return code be checked in this rollback
> loop?  This is the only new call site that discards it.
>
> If the H_VIOCTL enable fails for one of these queues, the queue stays in
> the live set (adapter->num_rx_queues is still old_count) with NAPI
> enabled and buffers posted, but with PHYP delivery masked, so that RX
> queue is silently stalled until a close/open or another resize.
>
> Elsewhere the driver treats this as actionable, e.g. ibmveth_poll():
>
> 	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
> 	if (lpar_rc != H_SUCCESS) {
> 		...
> 		schedule_work(&adapter->work);
> 	}

Yes, rollback should not discard that return code.

I’ll check it there, log it, schedule reset work on failure, and still
kick pending work on success so rollback does not leave a queue
silently stalled.

>> +
>> +		adapter->num_rx_queues = new_count;
> [Severity: Medium]
> Do the interface statistics go backwards here?  ibmveth_get_stats64(),
> ibmveth_get_ethtool_stats(), ibmveth_sum_rx_invalid_buffers() and
> ibmveth_sum_rx_large_packets() all sum rx_qstats[0..num_rx_queues-1]:
>
> 	if (adapter->rx_qstats) {
> 		for (i = 0; i < adapter->num_rx_queues; i++) {
> 			stats->rx_packets += adapter->rx_qstats[i].packets;
>
> so lowering the count drops the packets/bytes already accumulated by the
> removed queues from the reported totals.
>
> In the other direction, ibmveth_alloc_single_rx_queue() resets
> rx_queue[queue_idx].index/num_slots/toggle and copies the pool geometry
> but never clears adapter->rx_qstats[queue_idx], so re-adding a previously
> removed index resurrects its old counters and the totals jump up.
>
> Should the retired queues' counts be folded into an accumulator and the
> slot cleared on (re-)allocation, so rtnl_link_stats64 stays monotonic?

Yes, that is a real integration issue with the stats model.

I'm planning to preserve monotonic aggregate stats across resize,
either by folding retired queues into a persistent accumulator or by
otherwise ensuring removed queues do not disappear from the reported
totals and then reappear later.

>> +
>> +		for (i = new_count; i < old_count; i++) {
>> +			ibmveth_cleanup_single_rx_interrupt(adapter, i);
>> +			ibmveth_deregister_single_rx_queue(adapter, i);
>> +			ibmveth_free_single_rx_queue(adapter, i);
>> +		}
>> +	}
>> +
>> +	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
>> +		    adapter->num_rx_queues);
>> +
>> +	if (firmware_has_feature(FW_FEATURE_CMO))
>> +		vio_cmo_set_dev_desired(adapter->vdev,
>> +					ibmveth_get_desired_dma(adapter->vdev));
> [Severity: Medium]
> Is the entitlement raised too late on CMO LPARs?  All the CMO-charged DMA
> work for the new queues has already happened by the time this runs:
> dma_map_single() of the buffer-list page and dma_alloc_coherent() of the
> descriptor ring in ibmveth_alloc_single_rx_queue(), plus every RX skb
> mapping done by ibmveth_replenish_task().  Those run while the device's
> desired entitlement still reflects the old, smaller queue count, and
> vio_dma_iommu_alloc_coherent() refuses the allocation when
> vio_cmo_alloc() cannot cover it.
>
> It is also skipped on every failure and rollback return, so a resize that
> fails leaves the entitlement untouched.
>
> The driver's own convention is the opposite order, in
> ibmveth_change_mtu():
>
> 	vio_cmo_set_dev_desired(viodev, ibmveth_get_desired_dma(viodev));
> 	...
> 	ibmveth_open(...)
>
> Note that simply moving the call is not enough, since
> ibmveth_get_desired_dma() itself loops over adapter->num_rx_queues, so
> the target count has to be accounted before the allocations and rolled
> back on failure.
Yes, on CMO systems that entitlement update is too late.

I’ll raise the desired entitlement for the target RX queue count before
scale-up allocation, and restore it on failure so the entitlement
tracks the surviving geometry.

>> +
>> +	return 0;
>> +
>> +cleanup_new_queues:
>> +	failed_queue = i;
>> +	netdev_err(netdev,
>> +		   "Scale-up failed at queue %d, cleaning up queues %d-%d\n",
>> +		   failed_queue, old_count, failed_queue - 1);
> [Severity: Low]
> When the first newly added queue is the one that fails, failed_queue ==
> old_count, so this prints an inverted empty range such as "cleaning up
> queues 4-3" while the three loops below correctly iterate zero times.
Yes, that log should not print an inverted empty range.

I’ll log the cleanup range only when there is actually something to
clean up, and otherwise say there is nothing to clean up.

>> +	for (i = old_count; i < failed_queue; i++) {
>> +		ibmveth_disable_irq(adapter, i);
>> +		synchronize_irq(adapter->queue_irq[i]);
>> +	}
>> +
>> +	for (i = old_count; i < failed_queue; i++)
>> +		napi_disable(&adapter->napi[i]);
>> +
>> +	for (i = old_count; i < failed_queue; i++)
>> +		ibmveth_drain_rx_queue(adapter, i);
>> +
>> +	synchronize_net();
>> +
>> +	for (i = old_count; i < failed_queue; i++) {
>> +		ibmveth_cleanup_single_rx_interrupt(adapter, i);
>> +		ibmveth_deregister_single_rx_queue(adapter, i);
>> +		ibmveth_free_single_rx_queue(adapter, i);
>> +	}
>> +	adapter->num_rx_queues = old_count;
> [Severity: High]
> Can a concurrent NAPI poll dereference the pages this loop just freed?
> adapter->num_rx_queues is restored only after the free loop, so for the
> duration of that loop the indices [old_count, failed_queue) are freed but
> still inside the published live range.
>
> ibmveth_free_single_rx_queue() unmaps buffer_list_dma[i], frees the
> coherent ring and then does:
>
> 	free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
> 	adapter->buffer_list_addr[queue_idx] = NULL;
>
> Meanwhile every surviving queue's poll reaches
> ibmveth_replenish_task() -> ibmveth_update_rx_no_buffer(), which walks the
> published range with no NULL or liveness check:
>
> 	for (i = 0; i < adapter->num_rx_queues; i++) {
> 		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
> 		u64 drops = be64_to_cpup(p);
>
> So for a 2->4 scale-up where queue 2 came up and queue 3 fails, a poll on
> queue 0 or 1 reads buffer_list_addr[2] either as a just-freed page or as
> NULL + 0xff8, in softirq context.  ibmveth_poll_controller() reaches the
> same range from netpoll without rtnl, and additionally posts buffers into
> pools that are being freed.
>
> The guard in ibmveth_replenish_task():
>
> 	if (queue_index >= adapter->num_rx_queues) {
>
> does not help while the count is still the higher value.  The inline
> enable_irq failure handler above and the successful scale-down path both
> lower adapter->num_rx_queues before freeing; should this label do the
> same, i.e. set adapter->num_rx_queues = old_count before the free loop?
Yes, that is a serious publish-before-free hazard in the mailed patch.

The published live range needs to be shrunk before those queues are
freed, otherwise lockless readers can still walk freed queue state. I'm
planning to restore the old published count before the destroy loop in
`cleanup_new_queues`, just like the successful scale-down path.

>> +	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
>> +		    old_count);
>> +	return rc;
>> +}
>> +
> [ ... ]
>
>> @@ -2217,12 +2670,62 @@ static void ibmveth_get_channels(struct net_device *netdev,
>>   	channels->rx_count = adapter->num_rx_queues;
>>   }
>>   
> [ ... ]
>
>> +static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
>> +				      unsigned int goal_rx)
>> +{
> [ ... ]
>
>> +	if (goal_rx == old_rx)
>> +		return 0;
>> +
>> +	if (!(netdev->flags & IFF_UP)) {
>> +		adapter->num_rx_queues = goal_rx;
>> +		return 0;
>> +	}
>> +
> [Severity: Low]
> This isn't a bug in the final series, but at this commit the stash branch
> is unreachable: the only caller, ibmveth_set_channels(), already returns
> early on the same !IFF_UP condition before reaching
> ibmveth_resize_rx_channels(), so ethtool -L <dev> rx N on a down
> interface returns 0 while the requested count is discarded.  The next
> patch in the series ("ibmveth: Wire ethtool set_channels to MQ RX queue
> resize") replaces that early return and makes this branch live, so this
> only shows up at this bisect point.
Yes, that is a series-split artifact rather than a final-series bug.

I’ll fold the down-interface stash handling into the next patch so this
intermediate commit does not accept and then discard the requested
count.

>> +	rxq_entries = adapter->rx_queue[0].num_slots;
>> +	rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
>> +						  rxq_entries);
>> +	if (rc)
>> +		netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
>> +	return rc;
>> +}
>> +
>>   static int ibmveth_set_channels(struct net_device *netdev,
>>   				struct ethtool_channels *channels)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>>   	unsigned int old = netdev->real_num_tx_queues,
>>   		     goal = channels->tx_count;
>> +	unsigned int goal_rx = channels->rx_count;
>>   	int rc, i;
>>   
>>   	/* If ndo_open has not been called yet then don't allocate, just set
>> @@ -2231,6 +2734,13 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   	if (!(netdev->flags & IFF_UP))
>>   		return netif_set_real_num_tx_queues(netdev, goal);
>>   
>> +	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
>> +	 * in this patch. !IFF_UP RX stash ordering lands next.
>> +	 */
>> +	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
>> +	if (rc)
>> +		return rc;
>> +
> [Severity: Medium]
> Should the RX side be unwound when the TX phase below fails?  The RX
> resize is committed here first, and then ibmveth_allocate_tx_ltb() can
> return -ENOMEM or netif_set_real_num_tx_queues() can fail, in which case
> the function ends with return rc and no compensating
> ibmveth_resize_rx_channels(adapter, old_rx).
>
> ETHTOOL_SCHANNELS then reports failure while half of the requested
> configuration is in effect: on scale-down the excess RX queues have
> already been deregistered from PHYP and freed, on scale-up new queues are
> registered with IRQs installed and DMA memory pinned, and ethtool -l
> afterwards reports the new rx_count.
Yes, the combined RX/TX transaction needs a rollback story.

I'm planning to roll RX back to the old count if the later TX phase
cannot reach the requested configuration, so `set_channels()` does not
report failure after committing only half of the change.

So my updated view is that patch 12 got materially better in follow-up
on several of the biggest resize-path issues: publication ordering,
teardown ordering, errno normalization, post-unmask pending handling,
rollback robustness, and CMO timing. I would still avoid claiming the
live-resize model is fully closed out until the remaining publication,
teardown, and transaction story is tighter.

Thanks,
Mingming
>>   	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>>   	 * but we may need to alloc/free the ltb's.
>>   	 */
> [ ... ]

