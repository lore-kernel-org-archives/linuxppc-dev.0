Return-Path: <linuxppc-dev+bounces-28187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3395C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:44:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrjPt1CDNz2yfD;
	Fri, 25 Sep 2026 17:44:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790322242;
	cv=none; b=lM2ml31fs59qie/QwooQZ1Dxeu6YI6URn4k+mR6VQRa4JeoDlDYxwT781BFltzZomajNJW1FGfvm1rdnrL1CHKgKqmdxSf814bzj1vBdZbLlTeXzK/YwaZ/jWYieAVPbduPxYW65Yb/F2JbEqVT1P4VCN8y/mCdkTvBJG2xssSJBrG1e8iw55DvCSnL/OcNrex3pW2m9yIodGXqpNuae0bgdX7Y2h4M/zdvvEcB9o1Fp15DJ9ZhsNxA8mJFWCtMbaXAl2IkkhA7F3mz7AVKBraPL4ytRMrsCNsWRlAKoe82uTQXJ9FUw4Kpt4IMcK2S29VW8v34EdD/t7/2aviWMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790322242; c=relaxed/relaxed;
	bh=ngTZjuoYpGcBT9N6kuhM4MTVQRkRJJRpbwEPFT6+cjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEzSpyyGtOyLnCkBLlrAlQ7LjxSawjWZ3YScmmFKPkUi2au6amglhAVoTUnMrMjf811NS8wO+YqWEXTe6dkXvMqcl9ysLo8wYCYq6yyfUYE3uNmUOmRxfrT36T6jr4qqmmGAhnAMMEiFofy4mw7Iu+vsvO6jqNAJG/Fh7oYbUfV1YXlQyl7eIAcLAdvlQ8YkF8UNYu+T51sXGWsLJojkUpGl2aCNpTkLQqiyBIqad2UQJ4dWOonTq+YgcnPrVu+5oYf8JLNTIA8mHVgMO7UnXo/YN3O48dt3dVdOCTJri4X6x8alnewrcp0W7lqT9oMMXP4Y7ZJFamLMyC7BNeT9Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G4IgAWnF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G4IgAWnF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrjPr4gZPz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:44:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4afGi4105075;
	Fri, 25 Sep 2026 07:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ngTZju
	oYpGcBT9N6kuhM4MTVQRkRJJRpbwEPFT6+cjE=; b=G4IgAWnFxoApPykARMmWm8
	+mvO++E31po/TM9w1QOGvbXL00yBokLzVon3s+XAqU8j4M6Mq3ZV962auWrv/RPw
	wyfZMPUTljlKRHtW0o5TcxH9Uy4Myi+3H/h8FCDwRrFqOmCtSj7m2YuPuro0hFKf
	4zSy73j2YP5eA+75e1g/YRugEeSkR/aEPOkyvqSwEBd5NPtiEmCfy99Ib81PKB+f
	N1+1S/dLysZt5Fku1n/A/CpwuJaDQT10knn442TjscOTqLhiexQoXtjyJvbkE/e6
	xZSUSVwGQ11It6ocmA8faH/1LSw2EBXHdpLQAB+zYEUdMOfPjqWO0t9kHGDFzI/w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1w0qr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:43:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lpSg3288818;
	Fri, 25 Sep 2026 07:43:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21j0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:43:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P7hiiA31195808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 07:43:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 403D15804B;
	Fri, 25 Sep 2026 07:43:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6144458055;
	Fri, 25 Sep 2026 07:43:41 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 07:43:41 +0000 (GMT)
Message-ID: <8b931ca5-acca-4dfe-b455-84a7f49e3497@linux.ibm.com>
Date: Fri, 25 Sep 2026 00:43:40 -0700
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
Subject: Re: [net-next,v6,14/15] ibmveth: Implement incremental MQ RX queue
 resize
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <78b7ee90a73d9849e2bf119d6c5f576e29b20159.1788102125.git.mmc@linux.ibm.com>
 <178845904516.3394541.1465539152870824625@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845904516.3394541.1465539152870824625@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mzIqjRUzS62TWL2qgYM2sMdEdu9BLEZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfX5rtPGioq2hdK
 Pe2q5Qnab9VUHinz8FlAmtfVBGX2GuESpsu2uufc4Hp1E/rlR7bpPQDVyybEfIo95Tdc/K243Mp
 HSbV7XQkQ6CfsrTgqwX2oWPrEDe+OalV2GecaqZndhNv6Xuu/vCW3NiUr4KshJ3tIutYzrshTxM
 PjQQawRcIfWxq+08m0kQEHJn2ja7iXofmXWMOt51nlg9RMURsqx5M8XW6txoX33s/9CfV03NxQp
 B7J2dr36d6MYZCVn2BCQG28HFnHwOnrfsSX7uDPTOiDiM8MDkR/wmYl9keDw0SDN+MdurpmE2bj
 i1r8uOGNXgFP25cT+j5r91+Kt4aZK0RK0Yk6NnECAQNFLMsVUyxWRXFenXIRi6Y6JwXh6LMLJ66
 aojwYn5C0t2/qmhGiiQnJPI63zQryH9XAkJgm6SVO6VTMaoWP7bJ5POHxDDn4QAuj7i7/zeYWbs
 iDLw44GOUqOSgFzx4FA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab62633 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=sb1N4kiGUXsl6yXlX00A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfX4Ew4v1LRZyVD
 OAJioGeScVkNwP8mHnOQmLcvWi+9EPyo2ZNDQtpAMTm7fux3rgmKicqk4idWEnmqH3IXurOF2jR
 cweJZQ3Hgye5aY7H7haU1kEIVeJIYFU=
X-Proofpoint-GUID: jROZGUtBlytMKPyCaMXBGclZHej8pH5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250030


On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 5 · Low: 4
>
> - [Medium] On scale-up, ibmveth_resize_rx_queues_incremental() publishes,
>    replenishes, NAPI-enables, unmasks PHYP and restarts each new queue…
> - [Medium] The new scale-up call site of
>    ibmveth_register_single_rx_queue() in…
> - [Medium] ibmveth_deregister_single_rx_queue() ignores a failing
>    H_FREE_LOGICAL_LAN_QUEUE: the retry loop covers only…
> - [Medium] The scale-down and cleanup_new_queues quiesce sequences assume
>    napi_disable() plus a second ibmveth_disable_irq() + synchronize_irq()…
> - [Medium] RX queue teardown proceeds without confirming that PHYP
>    interrupt delivery is actually masked.
> - [Low] ibmveth_set_channels() commits the RX resize before any TX work
>    and, in this patch, has no RX rollback if the TX side then fails, so a…
> - [Low] When the interface is not opened, ibmveth_resize_rx_channels()
>    validates the requested RX count and returns 0 without publishing it,…
> - [Low] The advertised ethtool channel range and the set path disagree
>    once adapter->mq_fallback is latched: ibmveth_get_channels() reports…
> - [Low] ibmveth_drain_rx_queue()'s kernel-doc says it "Recycles all
>    pending buffers back to the per-queue buffer pools" and "Return:…
>
> --
>
> ibmveth: Implement incremental MQ RX queue resize
>
> This adds ibmveth_resize_rx_queues_incremental() so the live RX channel
> count can change without a full device tear-down, plus
> ibmveth_resize_rx_channels() as the entry point set_channels() uses. CMO
> entitlement math is factored into ibmveth_desired_dma_for_rxqs() so a
> prospective queue count can be sized before the driver commits to it.
>
> A few questions about the new resize paths below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 954846c9ec7b3..5aef8a1f2c23d 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1613,6 +1808,56 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
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
>> +			/* -EINVAL/-EFAULT already advanced past the slot. */
>> +			if (rc == -EINVAL || rc == -EFAULT) {
>> +				drained++;
>> +				continue;
>> +			}
> [Severity: Low]
>
> This isn't a bug, but does the documented return value of
> ibmveth_drain_rx_queue() match what is counted here?
>
> The kernel-doc says "Recycles all pending buffers back to the per-queue
> buffer pools" and "Return: Number of buffers drained", yet this branch
> bumps drained for entries where nothing was recycled.
> ibmveth_rxq_harvest_buffer() only advances the ring for -EINVAL/-EFAULT:
>
> 	if (unlikely(rc)) {
> 		/* Skip a corrupt slot without claiming pool ownership. */
> 		if (rc == -EINVAL || rc == -EFAULT)
> 			ibmveth_rxq_advance(rxq);
> 		return rc;
> 	}
>
> So the value returned is the number of ring slots consumed, not buffers
> recycled. Would wording the kernel-doc as "slots processed" be more
> accurate, given the value only feeds netdev_dbg()?
Yes. A corrupt slot still advances the ring, so
the return is slots processed, not buffers
recycled. v7 updates the kdoc to that.
>> +			netdev_err(netdev,
>> +				   "Failed to harvest buffer from queue %d during drain: %d\n",
>> +				   queue_index, rc);
>> +			break;
>> +		}
>> +		drained++;
>> +	}
> [ ... ]
>
>> @@ -1881,6 +2126,378 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * ibmveth_deregister_single_rx_queue - Deregister one subordinate RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue_idx: Queue index to deregister (1..N)
>> + *
>> + * Deregisters a single queue via H_FREE_LOGICAL_LAN_QUEUE. Linux IRQ handler
>> + * teardown and subordinate virq mapping disposal are owned by interrupt
>> + * cleanup helpers; queue 0 is freed only through ibmveth_free_all_queues()
>> + * (H_FREE_LOGICAL_LAN).
>> + */
>> +static void
>> +ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
>> +				   int queue_idx)
>> +{
>> +	unsigned long lpar_rc;
>> +	unsigned long ua = adapter->vdev->unit_address;
>> +	unsigned long qh = adapter->queue_handle[queue_idx];
>> +
>> +	if (!qh)
>> +		return;
>> +
>> +	do {
>> +		lpar_rc = h_free_logical_lan_queue(ua, qh);
>> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> +
>> +	if (lpar_rc != H_SUCCESS) {
>> +		netdev_err(adapter->netdev,
>> +			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
>> +			   queue_idx, lpar_rc);
>> +	}
>> +
>> +	adapter->queue_handle[queue_idx] = 0;
> [Severity: Medium]
>
> Can a failing H_FREE_LOGICAL_LAN_QUEUE here lead to PHYP writing into
> memory that has already been released?
>
> The retry loop only covers H_BUSY/H_LONG_BUSY. Any other status is
> logged, queue_handle[queue_idx] is cleared anyway, and the function
> returns void, so no caller can observe or retry it.
> ibmveth_destroy_subordinate_rx_queue() then continues unconditionally:
>
> 	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
> 	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
> 	ibmveth_free_single_rx_queue(adapter, queue_idx);
>
> ibmveth_free_single_rx_queue() dma_unmap_single()s the buffer-list page,
> dma_free_coherent()s the RX ring and releases every RX skb of that queue,
> all on a live adapter, while ibmveth_resize_rx_queues_incremental()
> reports success to ethtool.
>
> The kernel-doc for ibmveth_destroy_subordinate_rx_queue() states the
> ordering rationale as "Deregister with PHYP before unmapping buffer pools
> so hypervisor buffer ownership is released while queue metadata is still
> valid", which relies on the hcall having succeeded.
>
> The driver already treats this class of hcall failure as unrecoverable
> elsewhere, for example the scale-down rollback and ibmveth_poll() both do
> schedule_work(&adapter->work). Should this helper return the status so
> the caller can keep the queue and schedule a reset instead of freeing?
Yes, if we unmap after a failed free. v7
returns the status and skips unmap, so the
queue stays mapped. Scale-up enable_irq fail
does the same; a failed destroy keeps that
queue in the live set. Scale-up register
fail keeps it mapped above the live count;
close frees it only after successful
H_FREE_LOGICAL_LAN (skipping the sweep if
it fails), and -L to that index returns
-EBUSY until then. The incremental free
helper also keys buffer-list unmap on CPU
allocation presence, not DMA-address
truthiness, because DMA address zero is valid.

Unrelated to the above, v7 also splits the
incremental resize helper: the two directions
are now ibmveth_scale_up_rx_queues() and
ibmveth_scale_down_rx_queues(), with
ibmveth_resize_rx_queues_incremental() left as
the validating dispatcher. Code motion only, no
behaviour change.
>> +
>> +	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
>> +}
>> +
>> +/**
>> + * ibmveth_destroy_subordinate_rx_queue - Tear down one subordinate RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue_idx: Queue index to destroy (1..N)
>> + *
>> + * Deregister with PHYP before unmapping buffer pools so hypervisor buffer
>> + * ownership is released while queue metadata is still valid.
>> + */
>> +static void
>> +ibmveth_destroy_subordinate_rx_queue(struct ibmveth_adapter *adapter,
>> +				     int queue_idx)
>> +{
>> +	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
>> +	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
>> +	ibmveth_free_single_rx_queue(adapter, queue_idx);
>> +}
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
>> +			if (rc) {
>> +				netdev_err(netdev, "Failed to allocate queue %d: %d\n",
>> +					   i, rc);
>> +				goto cleanup_new_queues;
>> +			}
>> +
>> +			rc = ibmveth_register_single_rx_queue(adapter, i);
>> +			if (rc) {
>> +				netdev_err(netdev, "Failed to register queue %d: %d\n",
>> +					   i, rc);
>> +				ibmveth_free_single_rx_queue(adapter, i);
>> +				goto cleanup_new_queues;
>> +			}
> [Severity: Medium]
>
> Should this call site latch adapter->mq_fallback when
> ibmveth_register_single_rx_queue() returns -EOPNOTSUPP?
>
> The helper maps a firmware H_FUNCTION to -EOPNOTSUPP, and the other
> caller, ibmveth_register_rx_queues(), does:
>
> 	/* Firmware MQ gone: fall back to SQ on next open. */
> 	if (rc == -EOPNOTSUPP)
> 		adapter->mq_fallback = true;
> 	goto err_unregister;
>
> ibmveth_register_logical_lan_queue() documents the same obligation:
> "Caller fails this open and latches mq_fallback so the next open applies
> SQ".
>
> Here the errno is only logged and propagated, so after a firmware-refused
> scale-up the driver still believes MQ is available: get_channels() keeps
> advertising growth, ibmveth_resize_rx_channels() keeps accepting rx > 1,
> and the next ndo_open() re-attempts subordinate registration, fails the
> whole open and only then sets the flag. Does that turn into an avoidable
> failed "ip link set up" before the device comes back single-queue?
Yes. When ibmveth_register_single_rx_queue()
returns -EOPNOTSUPP, this site now latches
adapter->mq_fallback so future scale-ups are
blocked immediately, get_channels caps max_rx,
and the next open transitions cleanly to
single-queue mode without failing ifup.
The surviving live queues continue serving.
>> +
>> +			rc = ibmveth_setup_single_rx_interrupt(adapter, i);
>> +			if (rc) {
>> +				netdev_err(netdev,
>> +					   "Failed to setup IRQ for queue %d: %d\n",
>> +					   i, rc);
>> +				/* request_irq failed: mapped but no handler */
>> +				ibmveth_dispose_subordinate_irq_mapping(adapter,
>> +									i);
>> +				ibmveth_deregister_single_rx_queue(adapter, i);
>> +				ibmveth_free_single_rx_queue(adapter, i);
>> +				goto cleanup_new_queues;
>> +			}
>> +
>> +			/*
>> +			 * Fully ready before PHYP delivery, matching open():
>> +			 * publish -> replenish -> napi_enable -> enable_irq.
>> +			 * That way ibmveth_interrupt() cannot run on an
>> +			 * unpublished, empty, or NAPI-disabled queue.
>> +			 */
>> +			ibmveth_publish_num_rx_queues(adapter, i + 1);
>> +			ibmveth_replenish_task(adapter, i);
>> +			napi_enable(&adapter->napi[i]);
>> +
>> +			rc = ibmveth_enable_irq(adapter, i);
>> +			if (rc) {
>> +				netdev_err(netdev,
>> +					   "Failed to enable IRQ for queue %d: %d\n",
>> +					   i, rc);
>> +				/*
>> +				 * Published, replenished, and NAPI-enabled,
>> +				 * but PHYP never unmasked. Match scale-down /
>> +				 * shared cleanup: drain posted buffers, then
>> +				 * deregister before unmap via
>> +				 * destroy_subordinate.
> [Severity: Medium]
>
> Is the comment's "but PHYP never unmasked" guaranteed on this path?
>
> ibmveth_toggle_irq() documents the enable side as ambiguous:
>
> 	/*
> 	 * H_PARAMETER is ambiguous (already in requested state vs bad
> 	 * args). Fold only on disable as an idempotent mask. On enable
> 	 * keep it an error so a stuck-masked queue stays visible to
> 	 * poll/resize recovery.
> 	 */
>
> So an enable returning -EIO can also mean the interrupt was already
> enabled. The queue has been replenished and NAPI-enabled at this point,
> so PHYP can deliver, yet this branch goes straight to napi_disable(),
> publish-down, drain and destroy with no ibmveth_disable_irq() +
> synchronize_irq() for queue i.
>
> The scale-down and cleanup_new_queues paths do issue the mask, but
> discard its -EIO result and drain/destroy regardless, and
> synchronize_irq() only waits for handlers already running rather than
> masking the PHYP source. With the index at or above the published count
> ibmveth_interrupt() also just returns IRQ_NONE without masking:
>
> 	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
> 		return IRQ_NONE;
>
> Should a failed mask be treated the way ibmveth_poll() and the
> scale-down rollback treat a failed enable, with
> schedule_work(&adapter->work) instead of proceeding?
We issue the mask. H_PARAMETER is folded only
on disable. There is no ack hcall. A failed
disable does not reset, same as close. I am
not waiting for a PHYP ack in this series.
>> +				 *
>> +				 * napi_disable() must come BEFORE the count
>> +				 * is lowered, matching scale-down and
>> +				 * cleanup_new_queues. Lowering it first does
>> +				 * not hide queue i from netpoll: after
>> +				 * ndo_poll_controller, netpoll_poll_dev()
>> +				 * calls poll_napi(), which walks dev->napi_list
>> +				 * unbounded by the queue count and skips a NAPI
>> +				 * only once NAPI_STATE_NPSVC is set. Queue i is
>> +				 * enabled here, so ibmveth_poll() would run and
>> +				 * trip its queue_index >= num_rx_queues
>> +				 * WARN_ON. napi_disable() sets NPSVC, so
>> +				 * poll_napi() skips the queue instead.
>> +				 */
>> +				napi_disable(&adapter->napi[i]);
>> +				ibmveth_publish_num_rx_queues(adapter, i);
>> +				ibmveth_drain_rx_queue(adapter, i);
>> +				synchronize_net();
>> +				ibmveth_destroy_subordinate_rx_queue(adapter,
>> +								     i);
>> +				/* enable_irq returns errno; keep -EIO. */
>> +				rc = -EIO;
>> +				goto cleanup_new_queues;
>> +			}
>> +			ibmveth_restart_rx_queue(adapter, i);
>> +		}
>> +
>> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
> [Severity: Medium]
>
> Can this ordering be inverted so the WARN window does not exist at all?
>
> Every new queue is published, replenished, NAPI-enabled, unmasked at PHYP
> and restarted inside the loop above, and real_num_rx_queues is only
> widened after the loop finishes. A frame arriving on a new queue in that
> window is tagged by ibmveth_poll_deliver_frame():
>
> 	skb_record_rx_queue(skb, queue_index);
> 	napi_gro_receive(napi, skb);
>
> and net/core/dev.c get_rps_cpu() then does:
>
> 	if (unlikely(index >= dev->real_num_rx_queues)) {
> 		WARN_ONCE(dev->real_num_rx_queues > 1,
> 			  "%s received packet on queue %u, but number "
> 			  "of RX queues is %u\n", ...);
> 		goto done;
> 	}
>
> netif_get_rxqueue() has the same WARN_ONCE for the generic XDP path, so a
> device that already had more than one RX queue splats when RPS/RFS or
> generic XDP is configured, and panic_on_warn systems go down.
>
> netif_set_real_num_rx_queues() only needs dev->num_rx_queues, which is
> sized at probe, so could it be called before PHYP delivery is unmasked
> and narrowed again on the cleanup path? The commit message describes the
> splat as expected:
>
>      "RPS then skips steering and takes the default path, tripping the
>      WARN_ONCE in get_rps_cpu() if the device already had more than one
>      queue. Transient, and delivery is unaffected."
>
> Is leaving a userspace-reachable WARN in place preferable to widening the
> count first?
Yes. v7 widens real_num before any new
queue is unmasked. Scale-up failure
restores real_num to the surviving count.
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
>> +		 * Mask PHYP before napi_disable so the handler cannot miss
>> +		 * a mask while NAPI is already dead. An in-flight poll can
>> +		 * still re-arm PHYP while napi_disable() waits, so remask
>> +		 * and sync again after NAPI is stopped. Then drain, harvest
>> +		 * final no_buffer stats, publish the surviving count, and
>> +		 * synchronize_net() before destroy so netpoll cannot walk
>> +		 * dying queues (handler may still be registered until destroy).
>> +		 */
>> +		for (i = new_count; i < old_count; i++) {
>> +			if (!adapter->queue_irq[i])
>> +				continue;
>> +			ibmveth_disable_irq(adapter, i);
>> +			synchronize_irq(adapter->queue_irq[i]);
>> +		}
>> +
>> +		for (i = new_count; i < old_count; i++)
>> +			napi_disable(&adapter->napi[i]);
>> +
>> +		for (i = new_count; i < old_count; i++) {
>> +			if (!adapter->queue_irq[i])
>> +				continue;
>> +			ibmveth_disable_irq(adapter, i);
>> +			synchronize_irq(adapter->queue_irq[i]);
>> +		}
> [Severity: Medium]
>
> Does this second mask pass really close the re-arm window, or can the
> poll tail unmask PHYP after it?
>
> napi_disable_locked() in net/core/dev.c returns once SCHED/NPSVC are
> observed clear and clears the DISABLE bit before returning:
>
> 	clear_bit(NAPI_STATE_DISABLE, &n->state);
>
> Meanwhile ibmveth_poll() is still running its tail:
>
> 	if (!napi_complete_done(napi, frames_processed))
> 		goto out;
> 	...
> 	if (ibmveth_poll_stopping(netdev, napi))
> 		goto out;
>
> 	rc = ibmveth_enable_irq(adapter, queue_index);
>
> napi_complete_done() is what let napi_disable() finish, and
> ibmveth_poll_stopping() is !netif_running(netdev) ||
> napi_disable_pending(napi). netif_running() is still true during a live
> ethtool resize and DISABLE has already been cleared, so the guard passes
> and the enable hcall can land after the mask + synchronize_irq() above.
> synchronize_irq() waits for hard-IRQ handlers, not for a softirq poll
> function.
>
> The retiring queue would then stay unmasked at PHYP for the whole drain,
> stat-harvest, publish, synchronize_net() and
> netif_set_real_num_rx_queues() window: before the publish
> ibmveth_schedule_rx_queue() fails napi_schedule_prep() and deliberately
> does not mask, and after the publish ibmveth_interrupt() returns
> IRQ_NONE, so the interrupts are swallowed without remasking.
>
> The same idiom is repeated in cleanup_new_queues for queues whose NAPI
> may already have been scheduled. Would a per-queue flag checked by the
> poll tail, or masking after the poll can no longer run, be needed here?
>
> The commit message says:
>
>      "Scale-down masks PHYP on the retiring queues first, then disables
>      NAPI, then masks and synchronises again, because an in-flight poll
>      can re-arm PHYP while napi_disable() is waiting."
>
> Is that accurate if the re-arm can also happen after napi_disable() has
> returned?
It does not fully close it. PHYP is masked
first, then napi_disable, then remask, but
poll_stopping is not a close barrier, so a
poll tail can still re-arm after that second
mask. Inverting the order left IFF_UP with
PHYP unmasked, so I kept it. The cover lists
this under known leftovers.
>> +
>> +		for (i = new_count; i < old_count; i++)
>> +			ibmveth_drain_rx_queue(adapter, i);
> [ ... ]
>
>> +		ibmveth_publish_num_rx_queues(adapter, new_count);
>> +		synchronize_net();
>> +
>> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
> [ ... ]
>
>> +		for (i = new_count; i < old_count; i++)
>> +			ibmveth_destroy_subordinate_rx_queue(adapter, i);
>> +	}
> [ ... ]
>
>> @@ -2550,6 +3167,68 @@ static void ibmveth_get_channels(struct net_device *netdev,
>>   	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>>   }
>>   
>> +/**
>> + * ibmveth_resize_rx_channels - Validate and apply a new RX queue count
>> + * @adapter: ibmveth adapter
>> + * @goal_rx: requested RX queue count
>> + *
>> + * Rejects rx > 1 without MQ firmware (-EOPNOTSUPP) and rx outside
>> + * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). When RX resources are not live
>> + * (!opened), only validate; do not allocate. When up, apply via
>> + * ibmveth_resize_rx_queues_incremental().
>> + *
>> + * Return: 0 or negative errno
>> + */
>> +static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
>> +				      unsigned int goal_rx)
>> +{
> [ ... ]
>
>> +	/*
>> +	 * Refuse any rx > 1, not just growth: once mq_fallback is set the
>> +	 * next open comes up single-queue, so an intermediate count could
>> +	 * not be honoured either, and accepting it would only repeat the
>> +	 * silent clamp at open. max_rx stays at the live count so that
>> +	 * read-modify-write TX-only requests still clear the core.
>> +	 */
>> +	if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
>> +		netdev_err(netdev,
>> +			   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
>> +			   goal_rx);
>> +		return -EOPNOTSUPP;
>> +	}
> [Severity: Low]
>
> Does the advertised channel range still match what this gate accepts once
> adapter->mq_fallback is latched?
>
> ibmveth_replenish_task() can set the flag at runtime while several RX
> queues are still live and published:
>
> 	adapter->mq_fallback = true;
> 	schedule_work(&adapter->work);
>
> and ibmveth_apply_mq_fallback() only consumes it at the start of the next
> open. In that window ibmveth_get_channels() reports max_rx as
> IBMVETH_MAX_RX_QUEUES (the live count with the follow-up patch, still
> greater than 1), so the core forwards rx_count = 2 on a four-queue
> device, and this gate refuses it with -EOPNOTSUPP.
>
> A pure shrink needs no firmware MQ capability, it only deregisters
> subordinate queues with H_FREE_LOGICAL_LAN_QUEUE, which the scale-down
> path does unconditionally. Should shrinks be allowed here, or should
> max_rx be reported as 1 while mq_fallback is set so the range and the set
> path agree? The errno message "multi-queue mode not supported by
> firmware" is also somewhat misleading for a request to reduce queues.
No, not at this commit: max_rx can still be
above what this gate accepts. Patch 15 reports
the live rx_count and caps max_rx once
mq_fallback.
>> +
>> +	/* Down / failed-open: do not allocate. */
>> +	if (!adapter->opened)
>> +		return 0;
> [Severity: Low]
>
> Should a changed RX count be silently discarded here while success is
> reported?
>
> With the interface down, "ethtool -L ethX rx N" validates and returns 0,
> nothing is published, and ibmveth_get_channels() keeps reporting the old
> live count:
>
> 	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>
> so userspace has no way to see that the request was ignored.
>
> This is closed later in the same series: the patch "ibmveth: Complete
> set_channels down-path and mq_fallback max_rx cap" adds a full down path
> in ibmveth_set_channels() which calls
> ibmveth_publish_num_rx_queues(adapter, goal_rx),
> netif_set_real_num_rx_queues() and refreshes CMO. Would it read better to
> fold that handling in here rather than leaving an intermediate commit
> that accepts and drops the request?
No. It was in v6; v7 rejects it instead. An RX
count change while down now returns -EOPNOTSUPP
rather than reporting success for a request that
is thrown away. Patch 15 publishes the down-path
count and lifts that rejection.
>> +
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
>> @@ -2558,10 +3237,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   		     goal = channels->tx_count;
>>   	int rc, i;
>>   
>> -	/* If ndo_open has not been called yet then don't allocate, just set
>> -	 * desired netdev_queue's and return
>> +	/* Validate RX (and resize when opened) before the down-path
>> +	 * early return so MQ/range errors are reported here. Publishing
>> +	 * the desired RX count and CMO while down is the next patch.
>>   	 */
>> -	if (!(netdev->flags & IFF_UP))
>> +	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
>> +	if (rc)
>> +		return rc;
> [Severity: Low]
>
> Can a failed ethtool -L leave the RX side already resized?
>
> The RX resize is committed here, ahead of the TX LTB allocation and
> netif_set_real_num_tx_queues() error paths further down, and this patch
> has no RX rollback, so those paths return an error with the RX queue
> count already changed.
>
> The rollback arrives later in the series, in "ibmveth: Complete
> set_channels down-path and mq_fallback max_rx cap", which records
> want_tx/rx_changed and at the tail does:
>
> 	if (netdev->real_num_tx_queues != want_tx) {
> 		if (rx_changed) {
> 			...
> 			rb = ibmveth_resize_rx_queues_incremental(adapter,
> 								  old_rx,
> 								  rxq_entries);
> 			...
> 		}
> 		return rc ? rc : -ENOMEM;
> 	}
>
> Would it be cleaner to introduce the RX resize and its rollback in one
> patch, so no commit in the series leaves a half-applied ethtool -L?
Yes, at this commit. Patch 15 rolls RX back
if TX cannot reach the requested count.

Thanks,
Mingming
>> +
>> +	if (!adapter->opened)
>>   		return netif_set_real_num_tx_queues(netdev, goal);
>>   
>>   	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
> [ ... ]
>

