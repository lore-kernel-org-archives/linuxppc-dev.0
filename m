Return-Path: <linuxppc-dev+bounces-25702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58572C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 22:40:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJqTG4sV9z2yqX;
	Tue, 11 Aug 2026 08:40:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786401618;
	cv=none; b=e7znOkmjSffButLQrlykZ+755kmPcY1S3oCGpbMz4Q40qr5ZQQVF95Gy941uhgjMhm08K5tpthGrtg0MtbR5DIXZECN+6C7K0SGzLq9J7RxtxSHHAN2s8bjOTZf2j8O/dsG66idSvivf/6ZCkMh3zR650EbSPFrMZbnp9or11LFyaU7bVkzHbHe5zO073RC9k5cUKjB9K88lg6FiSauFQzLjbT44x6qr8xE9zUcgwUaRjKTZZ704Xfs+8ilZsy45zTT96tH1CmsE0uhkl3J701kH/KTQRYeEq66spbVniBlEiQXkczZgRXisfS5+HfkIpCaFe+ZWi0hU5GHScUBwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786401618; c=relaxed/relaxed;
	bh=cjRyDIe16iA/Xz0tv0QCB7Iqmu09SRKw/VWllhXjj9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Unbv8E0kH5wDJOlO8KQZiqJpoNP4qMGVJgxVfV0dEDN4zusoQ6CLuwf9Vuu5695764jfS8aTnLdj0zNVsWB9B9+N1ghDhuaeuwjiwy3jr4+y6q+5uCqAxTJ9J32Uwl6/T/hgCtWYZ7QwPp46zrcA8e8EPkQCyf0cNWTOBbQ6ofjQ3OGKWNNUawS1pdXrltBOEemjopGUa+CAahczK0ltUCfvbD9wqxrm+qTEUd6VBhtq2VVQFPj+SKf5cTPmjenYon/NiM3WV53i8wnHEC7dClziIkjsDBvEqn/uZYjk6TJcP3nBWROyhoVXhU+lqxOBWQBVoZhUUtzXSduR1yFgQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ASZzsMkZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ASZzsMkZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJqTF4mQsz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 08:40:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AK1ZZv2513977;
	Mon, 10 Aug 2026 22:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cjRyDI
	e16iA/Xz0tv0QCB7Iqmu09SRKw/VWllhXjj9M=; b=ASZzsMkZyjl7Ckq3fSoyLd
	9qeUtKB5kMJjCfaASpnHk8oBdWIui8QZO+OzHQSyu0FJzKN3qj9h5Z6zm5EJB/LG
	jVdBPonN3krP1YgNhaNMfWwRptjfLtynIS76U8cqB+dgqID7+ekZx/q4HHlMWVAR
	X8n2mqassdnteO7TKKtTA7hSNfdn1VLN3eIooIjXaBKIYnvfF/eCdw+/UzN24teJ
	Ex/Uk04iBKdkoZ7Gh2jW/PjonBSEE8qrihGHTZ0f5s0q3egRZ8vGlscjbIxjtxj6
	/2oQU0enBId7+NfqgSIqz5syG+F6uKdWJ8Kun/HuPxS6daKED1JhVgk+nj3LDeDQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2svy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 22:40:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AMQLMA001908;
	Mon, 10 Aug 2026 22:40:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gxmen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 22:40:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AMe1d328377774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 22:40:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E4CA580A5;
	Mon, 10 Aug 2026 22:32:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC3B15809B;
	Mon, 10 Aug 2026 22:32:41 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 22:32:41 +0000 (GMT)
Message-ID: <6a82b05f-1bca-4c2d-afe5-f7087d6c6d1d@linux.ibm.com>
Date: Mon, 10 Aug 2026 15:32:41 -0700
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
Subject: Re: [PATCH net-next v4 07/14] ibmveth: Add RX queue
 register/deregister helpers for MQ
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <e415d7657c48f0848763b9781c7af3d8d3abc276.1785457143.git.mmc@linux.ibm.com>
 <20260806183706.3175447-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183706.3175447-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a5343 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=YR9SFkWxU90doTTr-h0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YHjiNsFVRWnLqPZ5W0u3GIP-aUxYmhA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE5MSBTYWx0ZWRfX1mTVOMxUjC77
 3imRdp8wtldTjIPBAfjAtYg2U3EqssgYiS6CAbAKp2RLYlOMvszgOOkLZmk0InPeXyKQ9YugXbY
 oec9pbUXLkWciro9FdPwwc9J8OeZMeYYIjlcAmDdUScJZzETqx9zBUuro4EQSzMErx2AqFgz+tW
 x9TOb+h1FLOuMWvnTPpn+R9FwDSCtTNuD/PYeQzIgIPlAw/BQT23T/hQdWDWKC74K+qZSRiAldh
 GQtgXTVmoHlrP2PsauVAjp96nIdLkFU+wNQAJDkVf7zLP/UO2zSbnYqYerY3ZusGQS2LvxreMgW
 1HHCPncmycb6MyEfUXBQLcF1xTiLwR49m8EdbhzEgInRAZapCrObo9ggrATZTCbMBpoYQqi8Usc
 3zftdXkd7ugRLpo4UKusATfHXn6gAuaeKOIZyf2RubOt5VbC8/zFR3Mximeohd6n1nTsnAdawj7
 e4oOQYALcIYxnAf4D8g==
X-Proofpoint-ORIG-GUID: eCn-Kbs-_EBj9AvZdB7EAra0mFCnV3sl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE5MSBTYWx0ZWRfXw9T6Y93UHTP5
 MmU9XBN6hKUapdNR8LJGUNqVF0r//cyTDMcXThd5eWIpjlLd/U4A2HOpn+Xpcslfk4yCrFI8d0R
 cFFSom2yiuRKjMWwzbtkrplc/KvbNqg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100191


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Add RX queue register/deregister helpers for MQ
>
> This patch factors the queue-0 control-plane work out of
> ibmveth_open()/ibmveth_close() into ibmveth_register_rx_queues() and
> ibmveth_free_all_queues(), teaches ibmveth_register_logical_lan() to use
> h_register_logical_lan_with_handle() once multi_queue is set, and adds
> adapter->hcall_stats. Runtime behaviour stays single-queue.
>
> A few questions about the new open/close teardown pipeline below.
Hi Jakub,

Thanks for the review.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 131c1a61d9e7e..9d1242dbcb19d 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1182,14 +1201,89 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
>>   	return rc;
>>   }
>>   
>> +/**
>> + * ibmveth_free_all_queues - Free all RX queues at once
>> + * @adapter: ibmveth adapter structure
>> + *
>> + * Uses H_FREE_LOGICAL_LAN to free all queues in one hypercall.
>> + * Used during interface close and registration error cleanup.
>> + *
>> + * Clears queue handles only; queue_irq[] is released by
>> + * ibmveth_cleanup_rx_interrupts().
>> + */
>> +static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
>> +{
>> +	unsigned long lpar_rc;
>> +	int i;
>> +
>> +	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
>> +
>> +	do {
>> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> +		adapter->hcall_stats.free_lan++;
>> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> +
>> +	if (lpar_rc != H_SUCCESS) {
>> +		netdev_err(adapter->netdev,
>> +			   "h_free_logical_lan failed: %ld\n", lpar_rc);
>> +	}
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++)
>> +		adapter->queue_handle[i] = 0;
>> +}
> [Severity: Low]
> Where is the firmware contract for this documented?  The helper issues one
> adapter-level h_free_logical_lan() and then clears queue_handle[] for all
> num_rx_queues entries, which assumes that the single hcall also
> deregisters the subordinate queues that later patches register with
> H_REG_LOGICAL_LAN_QUEUE.
>
> The header already provides a per-queue wrapper that this path never uses:
>
>    static inline long h_free_logical_lan_queue(unsigned long unit_address,
> 					      unsigned long queue_handle)
>
> The assumption cannot be exercised at this commit because multi_queue is
> still 0, and the helper is unchanged at the end of the series, so nothing
> in the series validates it.  The changelog justifies the new ordering with
> "PHYP cannot retain a registered LAN while its DMA-backed RX pools are
> released"; if H_FREE_LOGICAL_LAN does not release subordinate queue
> registrations, then ibmveth_free_buffer_pools() and
> ibmveth_cleanup_rx_resources() would unmap memory PHYP still owns.
>
> Could the PAPR reference for the subordinate-queue semantics be stated in
> the kerneldoc or the changelog before the MQ enablement patch relies on it?
>
> [ ... ]
Yes. For full teardown, that is the PHYP/PAPR contract we are relying
on: one `H_FREE_LOGICAL_LAN` tears down the LAN and any subordinate
queues under it. `H_FREE_LOGICAL_LAN_QUEUE` is for incremental queue
removal during scale-down, not for full adapter teardown. I will make
that explicit in the kerneldoc and changelog.
>> @@ -1252,10 +1332,9 @@ static int ibmveth_open(struct net_device *netdev)
>>   
>>   out_cleanup_rx_interrupts:
>>   	ibmveth_cleanup_rx_interrupts(adapter);
>> -out_unregister_lan:
>> -	do {
>> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> +out_unregister_queues:
>> +	ibmveth_free_all_queues(adapter);
>> +out_free_buffer_pools:
>>   	ibmveth_free_buffer_pools(adapter);
>>   out_free_queue_mem:
>>   	ibmveth_cleanup_rx_resources(adapter);
> [Severity: High]
> This isn't a bug introduced by this patch, but should the unwind here leave
> state that a later ibmveth_close() can walk again?
>
> ibmveth_set_csum_offload(), ibmveth_set_tso() and ibmveth_change_mtu() call
> ibmveth_close()/ibmveth_open() directly instead of dev_close()/dev_open(),
> so when the re-open fails the error is only returned as an errno while
> IFF_UP and netif_running() stay set:
>
> 	if (restart)
> 		rc2 = ibmveth_open(dev);
>
> 	return rc1 ? rc1 : rc2;
>
> After that failed open, every RX resource is freed (buffer_list_addr[] is
> NULLed by ibmveth_cleanup_rx_resources()), NAPI is left disabled, and
> queue_irq[0] is deliberately kept populated.  The next ndo_stop, for
> example retrying the same ethtool command or an "ip link set dev X down",
> re-enters ibmveth_close() -> ibmveth_cleanup_rx_interrupts(), which does:
>
> 	for (i = 0; i < adapter->num_rx_queues; i++)
> 		napi_disable(&adapter->napi[i]);
>
> 	for (i = 0; i < adapter->num_rx_queues; i++) {
> 		if (adapter->queue_irq[i])
> 			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> 	}
>
> Can the second napi_disable() ever return?  napi_disable_locked() leaves
> NAPIF_STATE_SCHED|NAPIF_STATE_NPSVC set, and the second call waits in
> usleep_range() for bits that no poll will clear, with rtnl held by the
> ndo_stop caller.  The free_irq() that follows also refers to an IRQ that is
> no longer requested.
>
> If it did get past those, ibmveth_update_rx_no_buffer() would dereference
> the now-NULL buffer_list_addr[0]:
>
> 	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
>
> and ibmveth_free_all_queues() would issue H_FREE_LOGICAL_LAN for a LAN that
> is not registered.
>
> The baseline close() already had an unconditional napi_disable(), so the
> hang predates this patch, but this patch centralizes and extends the
> unconditional teardown (now also free_all_queues() plus the NULL-able
> buffer_list_addr[0] read) without an "already torn down" guard, and the
> same structure survives to the end of the series.  Would a state check at
> the top of ibmveth_close(), or switching those callers to
> dev_close()/dev_open(), be preferable?
Agreed. This one is high priority. I'm planning to add explicit
`opened` / `rx_irq_setup` state so a second teardown does not walk
partially initialized RX state as if it were live, and to fold that
back into the owning lifecycle patch rather than leave it as a tail
fixup.
>> @@ -1268,7 +1347,6 @@ static int ibmveth_open(struct net_device *netdev)
>>   static int ibmveth_close(struct net_device *netdev)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> -	long lpar_rc;
>>   
>>   	netdev_dbg(netdev, "close starting\n");
>>   
>> @@ -1277,18 +1355,8 @@ static int ibmveth_close(struct net_device *netdev)
>>   	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
>>   	ibmveth_free_tx_resources(adapter);
>>   	ibmveth_cleanup_rx_interrupts(adapter);
> [Severity: Medium]
> Does the PHYP mask taken by ibmveth_cleanup_rx_interrupts() actually stay
> in effect until free_irq()?
>
> The helper masks queue 0 and calls synchronize_irq() before napi_disable():
>
> 	ibmveth_disable_irq(adapter, i);
> 	synchronize_irq(adapter->queue_irq[i]);
> 	...
> 	for (i = 0; i < adapter->num_rx_queues; i++)
> 		napi_disable(&adapter->napi[i]);
>
> But a poll that is already in flight unmasks it again on completion, with
> no coordination against teardown:
>
> ibmveth_poll()
> 	if (!napi_complete_done(napi, frames_processed))
> 		goto out;
>
> 	/* We think we are done - reenable interrupts, ... */
> 	lpar_rc = ibmveth_enable_irq(adapter, 0);
>
> So napi_disable() can return with the source unmasked.  In the window
> before free_irq(), an RX interrupt is then delivered and
> ibmveth_interrupt() -> ibmveth_schedule_rx_queue() sees napi_schedule_prep()
> fail and returns IRQ_HANDLED without masking, since masking only happens on
> the napi_schedule_prep() success branch.  Can a VIO source with pending RX
> re-assert repeatedly until free_irq() shuts the line down, and can
> ibmveth_free_all_queues() then issue H_FREE_LOGICAL_LAN while the source is
> still unmasked?
>
> The kerneldoc in cleanup_rx_interrupts() states "Mask PHYP before
> napi_disable so ibmveth_interrupt cannot return IRQ_HANDLED without
> masking", which does not seem to hold when the poll itself is the entity
> that unmasks.  The pre-series code did napi_disable() first, then
> h_vio_signal(VIO_IRQ_DISABLE), then free_irq(); this patch propagates the
> new ordering into the open-failure unwind as well and places
> ibmveth_free_all_queues() behind it, and ibmveth_poll() still unmasks
> unconditionally at the end of the series.
Agreed. This is the same shutdown race as in 05/14. I'm planning to
make poll complete without `ibmveth_enable_irq()` when shutdown is in
progress, so I would not overclaim patch 7 alone as fully solving it.
That should be folded back with the lifecycle/shutdown fixes rather than
left as a tail fixup.
>> -
>> -	do {
>> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> -
>> -	if (lpar_rc != H_SUCCESS) {
>> -		netdev_err(netdev, "h_free_logical_lan failed with %lx, "
>> -			   "continuing with close\n", lpar_rc);
>> -	}
>> -
>>   	ibmveth_update_rx_no_buffer(adapter);
>> -
>> +	ibmveth_free_all_queues(adapter);
> [Severity: Low]
> Was moving ibmveth_update_rx_no_buffer() ahead of the H_FREE_LOGICAL_LAN
> intentional?
>
> Previously the counter was read after h_free_logical_lan() returned, so the
> hypervisor was no longer writing it.  ibmveth_update_rx_no_buffer() reads
> the last 8 bytes of the DMA-mapped buffer_list page that PHYP updates:
>
> 	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
>
> 	adapter->rx_no_buffer = be64_to_cpup(p);
>
> At the new call site the LAN is still registered, so frames can still be
> dropped and counted after the snapshot, and those drops are lost from the
> rx_no_buffer value reported by ethtool -S.
>
> The 7-step close pipeline in the changelog does not mention
> ibmveth_update_rx_no_buffer() at all:
>
>    ibmveth_close():
>
>      1. netif_tx_stop_all_queues()
>      2. ibmveth_free_tx_resources()
>      3. ibmveth_cleanup_rx_interrupts() - mask PHYP, napi_disable, free_irq
>      4. ibmveth_free_all_queues()       - H_FREE_LOGICAL_LAN
>      5. ibmveth_free_buffer_pools()
>      6. ibmveth_cleanup_rx_resources()
>      7. ibmveth_free_filter_list()
>
> Could the step list be updated to include it and to say where it belongs
> relative to H_FREE_LOGICAL_LAN?  The ordering is unchanged through the end
> of the series.
Agreed. There are really two separate points there. The NULL-deref side
needs fixing, and I'm planning to make that accounting path NULL-safe
and queue-local. Separately, if we keep the diagnostic snapshot before
`H_FREE_LOGICAL_LAN`, that should be called out explicitly as
intentional "last glimpse" accounting and included in the close step
list, rather than left ambiguous in the changelog.

Thanks,
Mingming
>>   	ibmveth_free_buffer_pools(adapter);
>>   	ibmveth_cleanup_rx_resources(adapter);
>>   	ibmveth_free_filter_list(adapter);
> [ ... ]

