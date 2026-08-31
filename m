Return-Path: <linuxppc-dev+bounces-26340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C33C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:23:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYf664CPPz2yCt;
	Tue, 01 Sep 2026 05:23:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788204190;
	cv=none; b=RjxqeH4B7J0lBS/aUB7Em8/N7/Tu0GZ7kOFQR/UWpCFEpH/6wjk1dHnPWV58MEB0bVA+NMrI3N9URap31FpK0mFPIDjLVsWThx6af78xcSVmqZGkS9jS16y32lTWlVtNq2aLd6Io66LwbnniWWBFgqhpJ6WI1gcyAMprNQnp/V5meyTI4Sb84z0BlQPaUiTFMZw0Qp6P4uHO1q13ys638CtQ9XZXz+YoCP0G28j710UPuM/a0lZnT3nnbQQwW0LZKg4Jxgo4kN3T82Jj02jByevxNwsb5kHcEiAsBCAj8KLtGerYsPNSloUNDaBCDRN7MkL9CRSuWElCM1QxHsFZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788204190; c=relaxed/relaxed;
	bh=YSLCo5sGIpM3FJ6RMEOolMeE8qPmf7bqjwebsT4Nh4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2vie5NutogQaAHs+5/JjdsmgiQeesQ/hx3Widy3EpQHLnWrjelYxbH9l/WdWVhFB45bwN0LY3qSx/2/nld3yZk1UmHQHGfCnYdVEvx1anKGLmWs7eMCzrOM8Tok6a2W4Ue683lQiCIlVTswBu9ks9BYdLKIJEApi2N67htThKH9hmX32cyRo9N3GajD4sAvjSSRG4Z/sb8j7KCSBdt6sZNgAuT8uraB8Tu+0wpN3UK2V/0jRDfv580PnCe3oxShCZMDdHB9IO4zu3ud/kWwEqRcCKTRZMod71BllIIrnjBBI+zq87ub68YsxyYKlQm5xbkv2RU2PkkyjnzIEDfYow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zs+zTemv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zs+zTemv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYf652bLpz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:23:09 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIWGub2998072;
	Mon, 31 Aug 2026 19:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YSLCo5
	sGIpM3FJ6RMEOolMeE8qPmf7bqjwebsT4Nh4k=; b=Zs+zTemvvqhQR4w/KInQVd
	rK47DjPotJl++Lw7EypaccQbwWw2uCc32JOZARaLxAsAn6BzPNb/Ym0VkdK/SHGL
	fa3phKRUAOf/XxdhQ+7Z36SEuBdr3Qb01F/fyGqTbGjTZyxb13mYlYMJRcTn6hhx
	PiBvQPDvLSCYnBIbPqRcope9gMYU6MQwnIcb8xT35MGPFXcn/q1B9zGcumnRMFGJ
	fxukCifN7/31bv91GkusJWPUYh8/z0LFJmh1LKMhTefCr9vt4xB6lk1LAnQ9Kxbj
	wvoPRTLkNq+XoxqDBoSe/cj87SrPiAzUuppeIig99IiKP54IdhfcYmNKRsjUAb9Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhkgmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:22:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJBRI4010307;
	Mon, 31 Aug 2026 19:22:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h7km3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:22:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VJMrXv21889630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 19:22:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA10D5803F;
	Mon, 31 Aug 2026 19:22:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A671C5805A;
	Mon, 31 Aug 2026 19:22:50 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 19:22:50 +0000 (GMT)
Message-ID: <bea4ec4d-7501-48e3-ab85-aaa0a627a829@linux.ibm.com>
Date: Mon, 31 Aug 2026 12:22:49 -0700
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
Subject: Re: [PATCH net-next v5 14/15] ibmveth: Implement incremental MQ RX
 queue resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-15-mmc@linux.ibm.com>
 <20260818014738.3854470-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014738.3854470-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ux0fmMFaMB-PHoLsFCPOD5sJDCStofUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX3qTs2GQLW+lO
 ljYuEbP1O2CE9FHw+o/6RRv0hVsdrx72Z7MKlpKjqsE5pj+sna7gKYBuXntOY+qzB8pf3w7vEVb
 0UfpSd3RqzHWbVV3YRo+HY9oG2VMtba+hHXtokE5RvyC+fXTtxSgAdT+ov7fnGbkRFyWERu8V8r
 8vRUdUYzgm7UfJsfS6/mWTcVnyIUPxfe/JLxqJxECuNG9J5yXJR+hqef0VwFb6mYEw5JzPWjvo8
 UKn4LZJaOEihk34WKZjSrNko1D3HPBlwgrrtGoIixTPYWhvMU1RhNuMUYXc9vkDV4krlOxTTQWg
 sELwZVkYca+rpSHQ58M9prm3XE691B4IgXCLR215i89EPU6algwWiIIlxUZeKrZ/EHU43CGBwGN
 D/Lb4ygGgw5DdjdKxhfs1ViQAqk+sfefaJVJ8W8S5JeYdSAils3AFnY8QlqAuG6R04anjCaRdYZ
 nMueAApxc2vCMrOvfWA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a95d491 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Tkd7cvprPNdnoz54A6AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX0YmjkW0vYxsF
 0XE3eLOO7JbyXW5u/KZmNjtiPeomG4x5X9OS64PZ1/MNqU4k/VoeSfZUArPGLWcqTtXX4I4hM31
 nJGhg/qYVk2HOHa6FUwVpNHI7uIt5o4=
X-Proofpoint-ORIG-GUID: YIjGON6b9oaKuMhiz3Ebu8VapguIHan-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310164


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Implement incremental MQ RX queue resize
>
> This adds incremental RX queue scale-up/scale-down helpers so that
> ethtool -L no longer needs a full adapter teardown, wires CMO
> entitlement updates and rollback paths into the resize, and factors the
> desired-DMA math into ibmveth_desired_dma_for_rxqs(). It also adds
> ibmveth_resize_rx_channels() and calls it from ibmveth_set_channels().
>
> A few questions on the changelog and on the new resize paths below.
>
> [Severity: Medium]
>
> Some of the work credited to this commit does not appear in its diff:
>
>> Strengthen correlator liveness (active pool + non-NULL backing arrays)
>> and clear freed pool metadata so torn-down pools no longer look
>> in-range. Restore schedule_work escalation for truly impossible
>> correlators.
>> Also implement incremental scale-up/down helpers, WRITE_ONCE
>> num_rx_queues publication, rollback/CMO updates, and related resize
>> error paths.
> git blame at this revision attributes those pieces to earlier commits in
> the series:
>
>    - ibmveth_rxq_correlator_valid(), including the
>      "!bpool->skbuff || !bpool->free_map" liveness test, comes from
>      6246916e4cdd ("ibmveth: Add queue-aware RX buffer submit helper for
>      MQ")
>    - the schedule_work() escalation in
>      ibmveth_poll_skip_bad_correlator() comes from d613a86a7fa2
>      ("ibmveth: Harden RX poll path with helpers")
>    - ibmveth_publish_num_rx_queues() with smp_wmb() + WRITE_ONCE() comes
>      from 4fbd8c64be1f ("ibmveth: Enable multi-queue RX receive path")
>
> ibmveth_free_buffer_pool() is not touched here at all, and it explicitly
> keeps active/size/buff_size/threshold, which reads as the opposite of
> "clear freed pool metadata".
>
> The changelog also describes a hang root cause being fixed, but the
> parent commit has no live RX resize path in ibmveth_set_channels() -
> this patch is what introduces it. Could the changelog be trimmed to the
> contents of this diff?
Yes. Those credits belonged to earlier patches. free_buffer_pool still
keeps the sysfs geometry. The commit message now matches this diff;
the hang claim is gone.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 1b58a3c6ce77a..84f4a0deb0c55 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1380,6 +1432,141 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
> [ ... ]
>
>> +/**
>> + * ibmveth_free_single_rx_queue - Free resources for a single RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue_idx: Queue index to free
>> + *
>> + * Frees buffer list, RX queue, and per-queue buffer pools for one queue.
>> + * Used during incremental scale-down without affecting remaining queues.
>> + */
>> +static void
>> +ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
>> +{
>> +	struct device *dev = &adapter->vdev->dev;
>> +
>> +	ibmveth_free_queue_buffer_pools(adapter, queue_idx);
>> +
>> +	if (adapter->buffer_list_dma[queue_idx]) {
>> +		dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
>> +				 4096, DMA_BIDIRECTIONAL);
>> +		adapter->buffer_list_dma[queue_idx] = 0;
>> +	}
>> +
>> +	if (adapter->rx_queue[queue_idx].queue_addr) {
>> +		dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
>> +				  adapter->rx_queue[queue_idx].queue_addr,
>> +				  adapter->rx_queue[queue_idx].queue_dma);
>> +		adapter->rx_queue[queue_idx].queue_addr = NULL;
>> +	}
>> +
>> +	if (adapter->buffer_list_addr[queue_idx]) {
>> +		free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
>> +		adapter->buffer_list_addr[queue_idx] = NULL;
>> +	}
>> +
>> +	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
>> +}
> [ ... ]
>
>> @@ -1797,6 +2034,356 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
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
>> +	adapter->hcall_stats.free_lan_queue++;
>> +
>> +	if (lpar_rc != H_SUCCESS) {
>> +		netdev_err(adapter->netdev,
>> +			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
>> +			   queue_idx, lpar_rc);
>> +	}
>> +
>> +	adapter->queue_handle[queue_idx] = 0;
>> +
>> +	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
>> +}
> [Severity: Medium]
>
> What happens if h_free_logical_lan_queue() returns a non-busy error such
> as H_PARAMETER or H_HARDWARE here?  The retry loop only covers
> H_BUSY/H_IS_LONG_BUSY; other failures are logged, the handle is zeroed
> and the function returns void, so the caller cannot tell.
>
> ibmveth_destroy_subordinate_rx_queue() then goes on to release
> everything PHYP may still own for that queue:
>
> 	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
> 	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
> 	ibmveth_free_single_rx_queue(adapter, queue_idx);
>
> ibmveth_free_single_rx_queue() unmaps and frees the posted RX buffers via
> ibmveth_free_queue_buffer_pools(), then dma_unmap_single() +
> free_page() on buffer_list_addr[queue_idx] and dma_free_coherent() on
> rx_queue[queue_idx].queue_addr.
>
> If the hypervisor still owns the ring and the posted buffers, can this
> let PHYP DMA into pages already returned to the allocator?  With
> queue_handle[queue_idx] cleared there is also no handle left to retry
> the free with later.  Should the deregister helper return an error and
> the destroy path skip the unmap/free (or force a reset) in that case?
In principle yes. Same log-and-continue as single-queue close. Skip-unmap
or reset would change teardown for every caller; it is on the cover
leftovers list.
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
>> +			/*
>> +			 * Fully ready before PHYP delivery, matching open():
>> +			 * publish -> replenish -> napi_enable -> enable_irq.
>> +			 * That way ibmveth_interrupt() cannot run on an
>> +			 * unpublished, empty, or NAPI-disabled queue.
>> +			 */
>> +			ibmveth_publish_num_rx_queues(adapter, i + 1);
> [Severity: Medium]
>
> Is the publication protocol complete on the reader side?
>
> ibmveth_publish_num_rx_queues() pairs a write barrier with the store:
>
> 	/* Per-queue state must be visible before readers observe num. */
> 	smp_wmb();
> 	WRITE_ONCE(adapter->num_rx_queues, num);
>
> but the consumer has no matching barrier:
>
> 	static inline unsigned int
> 	ibmveth_get_num_rx_queues(const struct ibmveth_adapter *adapter)
> 	{
> 		return READ_ONCE(adapter->num_rx_queues);
> 	}
>
> Readers (ibmveth_interrupt(), ibmveth_poll(), ibmveth_poll_controller(),
> ibmveth_replenish_task()) index per-queue state under only a control
> dependency on that count, which powerpc does not order for loads.  Can a
> reader observe the bumped count while still seeing stale
> queue_handle[i], queue_irq[i] or NULL rx_buff_pool[i][x] pointers for the
> queue just added?  ibmveth_drain_rx_queue() added by this patch does have
> an explicit smp_rmb(); should ibmveth_get_num_rx_queues() carry the
> acquire side instead?
Yes. The getter is smp_load_acquire(), paired with smp_store_release()
on publish, in patch 10. drain_rx_queue()'s smp_rmb() is the poll
descriptor/harvest barrier, not that pair.
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
>> +				 */
>> +				ibmveth_publish_num_rx_queues(adapter, i);
>> +				napi_disable(&adapter->napi[i]);
> [Severity: Medium]
>
> Is the ordering here intentional?  This path publishes the live count
> down to i before napi_disable(&adapter->napi[i]), while the scale-down
> loop and cleanup_new_queues below do napi_disable() first and publish
> afterwards.
>
> Queue i has already been published and napi_enable()d at this point, so a
> poll can be scheduled for it (netpoll via ibmveth_poll_controller(), or a
> PHYP interrupt if the unmask actually took effect and the hcall still
> reported an error).  ibmveth_poll() starts with:
>
> 	if (WARN_ON(queue_index < 0 ||
> 		    queue_index >= ibmveth_get_num_rx_queues(adapter))) {
>
> so can a poll scheduled for queue i now hit that WARN_ON?
Yes. Publishing first does not hide the queue from netpoll
(poll_napi() walks napi_list). v6 napi_disable()s first, then
publishes.
>> +				ibmveth_drain_rx_queue(adapter, i);
>> +				synchronize_net();
>> +				ibmveth_destroy_subordinate_rx_queue(adapter,
>> +								     i);
>> +				/* enable_irq returns errno; keep -EIO. */
>> +				rc = -EIO;
>> +				goto cleanup_new_queues;
>> +			}
>> +			ibmveth_kick_rx_queue_if_pending(adapter, i);
> [Severity: Medium]
>
> Can this leave a newly added queue permanently dead if replenishment
> posted nothing?
>
> ibmveth_replenish_task() is void and swallows both total SKB allocation
> failure and ordinary post failures (IBMVETH_REPLENISH_HCALL_FAIL only
> produces a rate-limited warning).  The kick afterwards is conditional:
>
> 	if (ibmveth_rxq_pending_buffer(adapter, queue_index))
> 		ibmveth_schedule_rx_queue(adapter, queue_index);
>
> With zero posted buffers PHYP has nothing to complete, so
> ibmveth_rxq_pending_buffer() is false, no interrupt arrives, and poll
> never runs to retry the replenish.  There is no timer or delayed work in
> ibmveth.c that would retry either.  The queue is still counted in
> real_num_rx_queues, so flows hashed to it are dropped until the admin
> runs ethtool again or does ifdown/ifup.
>
> The open path uses ibmveth_restart_rx_queue(), which always schedules one
> poll and therefore gets a retry.  Would the same be appropriate here, and
> in the scale-down rollback below which repeats this sequence after
> draining?
Yes to both. Both sites now call ibmveth_restart_rx_queue().
enable_irq() is still checked first.
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
> [ ... ]
>
>> +		for (i = new_count; i < old_count; i++)
>> +			ibmveth_drain_rx_queue(adapter, i);
>> +
>> +		synchronize_net();
>> +
>> +		ibmveth_publish_num_rx_queues(adapter, new_count);
>> +
>> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
> [Severity: High]
>
> Is the ordering of synchronize_net() and the count publish inverted here?
>
> The grace period runs before ibmveth_publish_num_rx_queues(adapter,
> new_count), and the destroy loop that follows the publish has no further
> grace period and takes no lock - in particular not the per-queue
> rx_queue[i].replenish_lock that readers hold.
>
> ibmveth_poll_controller() (ndo_poll_controller, so netpoll/netconsole,
> outside RTNL and outside the NAPI state machine) samples the count once
> and then walks it:
>
> 	unsigned int num = ibmveth_get_num_rx_queues(adapter);
>
> 	for (i = 0; i < num; i++)
> 		ibmveth_replenish_task(adapter, i);
>
> 	for (i = 0; i < num; i++)
> 		ibmveth_schedule_rx_queue(adapter, i);
>
> and ibmveth_replenish_task() re-checks the count before it takes the lock
> and dereferences the pool arrays:
>
> 	if (queue_index >= ibmveth_get_num_rx_queues(adapter)) { ... return; }
> 	...
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
> 	... if (pool->active && pool->free_map && ...)
>
> which looks like a pure time-of-check/time-of-use test against the
> teardown path.  Meanwhile ibmveth_free_buffer_pool() frees exactly those
> pointers with no lock held:
>
> 	kfree(pool->free_map);
> 	pool->free_map = NULL;
> 	... kfree(pool->dma_addr); ... kfree(pool->skbuff);
>
> Can a reader that already passed the count check be inside
> ibmveth_replenish_task() on queue i while free_map/skbuff/dma_addr are
> kfree()d, buffer_list_addr[i] is free_page()d and rx_queue[i].queue_addr
> is dma_free_coherent()d?  The changelog says dropping the live count
> means netpoll cannot walk dying queues, but with the grace period taken
> before the publish that does not seem to hold.  The same pattern appears
> in cleanup_new_queues below (synchronize_net(), then publish, then
> destroy).
Yes. v5 synced then published. v6 harvests under the retiring
replenish_lock (scale-down only), publishes, then synchronize_net().
set_real_num_rx_queues() is next: destroy on success, republish and
re-enable on failure. cleanup_new_queues publishes, syncs, destroys;
no harvest.
>> +		if (rc) {
>> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
>> +				   new_count, rc);
>> +			ibmveth_publish_num_rx_queues(adapter, old_count);
>> +			for (i = new_count; i < old_count; i++) {
>> +				int irq_rc;
>> +
>> +				ibmveth_replenish_task(adapter, i);
>> +				/* START: NAPI before PHYP unmask. */
>> +				napi_enable(&adapter->napi[i]);
>> +				irq_rc = ibmveth_enable_irq(adapter, i);
>> +				if (irq_rc) {
>> +					netdev_err(netdev,
>> +						   "Failed to re-enable IRQ for queue %d during scale-down rollback (rc=%d), scheduling reset\n",
>> +						   i, irq_rc);
>> +					schedule_work(&adapter->work);
>> +					continue;
>> +				}
>> +				ibmveth_kick_rx_queue_if_pending(adapter, i);
>> +			}
>> +			return rc;
>> +		}
>> +
>> +		for (i = new_count; i < old_count; i++)
>> +			ibmveth_destroy_subordinate_rx_queue(adapter, i);
>> +
>> +		/* Q0 (and any still-live queues) were not in the teardown
>> +		 * loop. Scale-down can leave Q0 masked with NAPI idle — kick
>> +		 * so ARP/RX does not die until rmmod (lab: -L rx 1).
>> +		 */
>> +		for (i = 0; i < new_count; i++)
>> +			ibmveth_restart_rx_queue(adapter, i);
> [Severity: Medium]
>
> Is it safe to call ibmveth_restart_rx_queue() on queues that were never
> quiesced by this function and are actively receiving?
>
> ibmveth_restart_rx_queue() falls back to an unmask when the NAPI schedule
> attempt fails:
>
> 	ibmveth_replenish_task(adapter, qindex);
> 	if (ibmveth_schedule_rx_queue(adapter, qindex))
> 		return;
>
> 	rc = ibmveth_enable_irq(adapter, qindex);
> 	WARN_ON(rc);
>
> napi_schedule_prep() failing is precisely the state "a poll is already in
> flight and has masked PHYP", so the fallback unmasks PHYP behind that
> running poll.  The poll's own tail then calls ibmveth_enable_irq() on an
> already-enabled subordinate queue, and ibmveth_toggle_irq() folds
> H_PARAMETER to success only on disable:
>
> 	if (h_rc == H_PARAMETER && !enable) { ... return 0; }
> 	...
> 	if (h_rc) { ... return -EIO; }
>
> so the poll gets -EIO and escalates to schedule_work(&adapter->work),
> i.e. a full close+open of the adapter.  In the reverse interleaving the
> resize-side enable is the one that returns -EIO and trips the WARN_ON.
>
> With new_count >= 2 and traffic running on a surviving subordinate queue,
> can ethtool -L rx <smaller> trigger a spurious adapter reset or that WARN
> splat?  Should the restart loop be limited to queue 0, or use a path that
> does not unmask when a poll owns the queue?
The shrink does not stop survivors (teardown is new_count..old_count-1
only). v6 drops that restart loop. Prep-fail is NAPI already
scheduled; enable_irq() then unmasks a subordinate behind that poll,
and the poll tail treats H_PARAMETER on enable as -EIO and resets.
Idle+masked is the prep-success path, so the loop was not the
insurance the comment claimed. Open and scale-down rollback still
call restart_rx_queue().
>> +	}
>> +
>> +	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
>> +		    ibmveth_get_num_rx_queues(adapter));
> [ ... ]
>
>> +cleanup_new_queues:
> [ ... ]
>
>> +	synchronize_net();
>> +
>> +	/* Drop the live count before freeing the half-added queues. */
>> +	ibmveth_publish_num_rx_queues(adapter, old_count);
>> +
>> +	for (i = old_count; i < failed_queue; i++)
>> +		ibmveth_destroy_subordinate_rx_queue(adapter, i);
> [ ... ]
>
>> @@ -2535,6 +3122,55 @@ static void ibmveth_get_channels(struct net_device *netdev,
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
>> +	/* Down / failed-open: caller stashes. Do not allocate here. */
>> +	if (!adapter->opened)
>> +		return 0;
> [Severity: Low]
>
> The kernel-doc and this comment say the caller stashes the desired count
> when RX resources are not live, but at this commit the only caller does:
>
> 	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
> 	if (rc)
> 		return rc;
>
> 	if (!adapter->opened)
> 		return netif_set_real_num_tx_queues(netdev, goal);
>
> There is no adapter->num_rx_queues update, no
> netif_set_real_num_rx_queues() and no CMO refresh on that path, so
> ethtool -L ethX rx N on a down interface returns success while
> ibmveth_get_channels() keeps reporting the old count.
>
> The following patch in the series, "ibmveth: Wire ethtool set_channels to
> MQ RX queue resize", does add the stash/publish/CMO block, so the final
> state of the series matches the documentation - only this intermediate
> commit does not.
Yes. At this commit !opened only validates. Patch 15 publishes the
desired count and CMO while down.
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
>> @@ -2543,10 +3179,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   		     goal = channels->tx_count;
>>   	int rc, i;
>>   
>> -	/* If ndo_open has not been called yet then don't allocate, just set
>> -	 * desired netdev_queue's and return
>> +	/* Validate RX (and resize when opened) before the down-path early
>> +	 * return so MQ/range errors are not deferred to the wiring patch.
>> +	 * RX stash + CMO while down still lands with that patch.
>>   	 */
>> -	if (!(netdev->flags & IFF_UP))
>> +	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
>> +	if (rc)
>> +		return rc;
> [Severity: Low]
>
> The live RX resize is committed here, ahead of all TX work, and at this
> commit nothing unwinds it if the TX portion later fails - the tail of
> ibmveth_set_channels() just returns rc after
> netif_set_real_num_tx_queues() fails.  So ethtool -L ethX rx N tx M can
> return an error to userspace with the hypervisor-visible queue set,
> adapter->num_rx_queues, netdev->real_num_rx_queues and the CMO
> entitlement already changed.
>
> The next patch in the series adds the rx_changed rollback that calls
> ibmveth_resize_rx_queues_incremental(adapter, old_rx, rxq_entries) on TX
> failure, so the series head does handle it; only this commit is missing
> the unwind.
Yes. RX commits before TX here. Patch 15 rolls RX back if TX fails.
>> +
>> +	if (!adapter->opened)
>>   		return netif_set_real_num_tx_queues(netdev, goal);
> [ ... ]
>
> [Severity: Medium]
>
> Not a problem introduced by this patch, but the in-tree KUnit cases in
> ibmveth.c look broken as of this series and are still broken at the
> series head.
>
> ibmveth_rxq_correlator_valid() requires free_map to be non-NULL:
>
> 	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
> 		return false;
>
> Both fixtures only allocate pool->skbuff with kunit_kcalloc() after
> ibmveth_init_buffer_pool(), which never sets free_map.  So in
> ibmveth_remove_buffer_from_pool_test() this case:
>
> 	correlator = (u64)0 | 0;
> 	pool->skbuff[0] = NULL;
> 	KUNIT_EXPECT_EQ(test, -EFAULT,
> 			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, false));
>
> gets -EINVAL from the correlator check instead of -EFAULT, and in
> ibmveth_rxq_get_buffer_test():
>
> 	pool->skbuff[0] = skb;
> 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
> 	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter, 0));
>
> gets NULL.  The liveness check came in with 6246916e4cdd ("ibmveth: Add
> queue-aware RX buffer submit helper for MQ").  Should the fixtures also
> allocate pool->free_map so CONFIG_IBMVETH_KUNIT_TEST builds pass?

Yes. Patch 8 fixtures allocate free_map.

Regards,

Mingming


