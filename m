Return-Path: <linuxppc-dev+bounces-26323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5912C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 18:47:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYdJX0rD0z2y2f;
	Tue, 01 Sep 2026 04:47:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788202028;
	cv=none; b=Y/S4vdQXN0ctxtpHEnyCTNk82itFNIjEMWxFDOqHAXH8n2M85bCspqoNq4mKOSxmhvKvX1GTWbRHicukA3YZ1WFIoNJ9yQ+CEo2GOV8y2lBDnYNVrdnQ/35YO4uExA23dBHmKlSVDd59CyoSSXyJVBzY2rSBzjwOBg9fWyadRbp6k3ral7suC3pWefh83duREKuN7XhWFMd+HgMQeFu0yKmRQtpwmzC5UxV30ep258dLge6G/SQG5uRrtxy1yURi1qRsXQK/+6n99PvXk1kkFPzfK5kRemUWCOBgfX3buSIvJppf4ASUgQODz79IrdePEzCeyz5RFbnuLzkXoKW9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788202028; c=relaxed/relaxed;
	bh=LFWYno5XB8kjiSM3clbpLs5G+G7ACpft14tQrCoeH50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtT4vRk+vqUWcCEYecH5aEW2pCv5oJZQzYl1v0aaHo9DKNZXWbMRmfcMoHeaFk08UBC5ZXXJKxU7WDW+qWJOv7uUDGdvA6ydjhc4eRJtjD+p3Ck0mTXq1eVsTItC0xgFzxAitrgaSgloAynkSA2t/iA9Aihy1OmTjE+kj+Sn53Vif1YpezHoBz0fKebTBLnNh3oOObKhe+X7eF3r27H0y8ZNwiFkgxtcdH0FOi7PE97fk67ZbUOsk19kmfTBLgT/WxTxv+fwYz1OdJuxa7sdPW+q0eqAg3a1Ii43IGf6Prl51vLni+nCCf2kfhKMXRmQzs5EXBmYnVxofUDCaONatQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fHxlt9qR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fHxlt9qR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYdJV3DtNz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 04:47:05 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVjbS1979904;
	Mon, 31 Aug 2026 18:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LFWYno
	5XB8kjiSM3clbpLs5G+G7ACpft14tQrCoeH50=; b=fHxlt9qRLv0eJen30D8KhV
	FQQm/U1tzi2DTMpHVY/1Z71vfqbL7JjXH8JVjhoH3IY2Z5XqSWbXr8LZMA8VaNb4
	m/rvkNNqxRlQTwedwGqksHEeAo287oWCsNPR7lk/FROC4lQOBEF092DvaqD0K/6M
	RJ0mbdacAHyMv8y8qavhI2Wwp33TtMoOpzxfr9gfUKyLwEen/cY1iGqHa34KxG8B
	/nXx3J6XmJbbVXoLznGtqBmOOSV5MXlgtuMjTtTI4pG8p1zFvPSG8rCowaYu4uQj
	dgudfUGowC7KfTm+TsReQ45Zx0k+F85IDbnqXhCc4fc6Op+J70tdC4dJYAax27cA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudk6cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:46:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIfJDG015774;
	Mon, 31 Aug 2026 18:46:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexy9th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:46:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VIkkB513304528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 18:46:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1465805C;
	Mon, 31 Aug 2026 18:46:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6E0A5805E;
	Mon, 31 Aug 2026 18:46:42 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 18:46:42 +0000 (GMT)
Message-ID: <9d3412bf-a3ef-49ed-b9aa-7645dad7791d@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:46:41 -0700
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
Subject: Re: [PATCH net-next v5 06/15] ibmveth: Refactor TX resource
 allocation in open/close paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-7-mmc@linux.ibm.com>
 <20260818014724.3854085-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014724.3854085-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1DpfL0zYZ_EssowBaUKjELhIzF0OoIHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX6Uo+cPqzG3Gb
 bHARWWyD2UrWnjQQtbjcz590KjE71KTT0j5rXKf/DoqMyYmLjGDnZtSy8SW0882qqGmV5pDGbPu
 ZEYSwUbfZuzMo77P7RtRV7g2vJcsN26OgzU+bhPvbS+PmQSU1sMmWQZDsaA6yr3uVYWBpZXuUWN
 DwAk+whxLyUKk6+EN/niRs3bhrmmYCS1SgNbKO2bDpXN/O9bSMNo5f4VKixUsqqoHtRfb6mc5Rq
 4ycV+67bmsw0b1k9FEsXJrK8pH5Zz+aY2gEPfPu48ksX1NfAmaVIs8fxMemHa1eXWL60dEAjOzg
 OCNXOs3OTvmASvqEi5NzvGU86AQIwoS9OC3F0Tf/+QTwaM2LVP/lSAIyG4D1y4WtXjfzykSJOoP
 tMB3LsSzUiUPeil7UEEUR7qaF57Qau8GPhIkn5ETjwjL5YIFMbfrGupOu6UzJPzj4xAmBl6iqDH
 HM01nEshCORkiEhkR7g==
X-Proofpoint-ORIG-GUID: fq_8msL7b6Q19LFta-0_hLIWkc-XTpyv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX868wR7OW57wR
 2GSYaliJZkgoReQ0GGw11zhFNIUO3lKSYi4tggGwHlBrn+y7rL2Ug8dXkmr32kgMCZwBtq4SLAu
 mu7hKlSCAHCCs5Wbd1TpHsUttrnoydU=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95cc1d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ZNFeZsoBvMJ41n-zCT8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310160


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor TX resource allocation in open/close paths
>
> This moves the per-queue TX long term buffer alloc/free loops out of
> ibmveth_open()/ibmveth_close() into ibmveth_alloc_tx_resources() and
> ibmveth_free_tx_resources(), moves the TX allocation to the end of open()
> after RX is live, and adds a tx_ltb_ptr[] presence check to
> ibmveth_start_xmit().  No Link: tags are present in the commit header.
>
> A few questions on the LTB lifetime rules the patch establishes.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 99eeb6ef51bf3..b39e8c53cbfd1 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1183,8 +1183,12 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>>   
>>   static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>>   {
>> +	if (!adapter->tx_ltb_ptr[idx])
>> +		return;
>> +
>>   	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
>>   			 adapter->tx_ltb_size, DMA_TO_DEVICE);
>> +	adapter->tx_ltb_dma[idx] = 0;
>>   	kfree(adapter->tx_ltb_ptr[idx]);
>>   	adapter->tx_ltb_ptr[idx] = NULL;
>>   }
> [Severity: Medium]
> tx_ltb_ptr[] now doubles as the guard for tx_ltb_dma[], but the retire
> order here clears the guarded value first:
>
> 	dma_unmap_single(...);
> 	adapter->tx_ltb_dma[idx] = 0;
> 	kfree(adapter->tx_ltb_ptr[idx]);
> 	adapter->tx_ltb_ptr[idx] = NULL;
>
> Can an ibmveth_start_xmit() that already passed the new check
>
> 	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
>
> then reach
>
> 	desc.fields.address = adapter->tx_ltb_dma[queue_num];
>
> and hand a zeroed DMA address to H_SEND_LOGICAL_LAN?
>
> The publish side has the mirror-image order: ibmveth_allocate_tx_ltb()
> stores tx_ltb_ptr[idx] from kzalloc() before tx_ltb_dma[idx] is filled in
> by dma_map_single(), with no release/acquire pairing.
>
> Both the check in ibmveth_start_xmit() and its later uses (the memcpy into
> tx_ltb_ptr[queue_num] and the descriptor address read) are plain loads with
> no READ_ONCE and no common lock, so nothing prevents a reload of
> tx_ltb_ptr[queue_num] after it was set to NULL.
>
> Against ibmveth_close() this appears harmless, since ibmveth does not set
> lltx and netif_tx_disable() therefore takes every __netif_tx_lock.  Against
> ibmveth_set_channels() (more below) there is no such serialization.  Would a
> real lock, or gating on adapter->opened, express this better than a pointer
> used as a flag?
close() is safe: no lltx, so netif_tx_disable() waits out xmit. The
-L shrink window is real; answered below. v6 clears both slots before
unmap/free so a later start_xmit() fails the pointer check.

A lock or opened gate in start_xmit() would not replace that. opened
is false after a failed reopen, when the LTBs are already gone; the
-L race runs while opened is true. The right fix there is
netif_tx_disable() on the shrink path, not another flag on xmit.

>> @@ -1207,12 +1211,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>>   			   "unable to DMA map tx long term buffer\n");
>>   		kfree(adapter->tx_ltb_ptr[idx]);
>>   		adapter->tx_ltb_ptr[idx] = NULL;
>> +		adapter->tx_ltb_dma[idx] = 0;
>>   		return -ENOMEM;
>>   	}
>>   
>>   	return 0;
>>   }
>>   
>> +/**
>> + * ibmveth_alloc_tx_resources - Allocate TX resources for all queues
>> + * @adapter: ibmveth adapter structure
>> + *
>> + * Allocates TX Long Term Buffers (LTBs) for all TX queues.
>> + *
>> + * Return: 0 on success, -ENOMEM on failure
>> + */
>> +static int ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	int i;
>> +
>> +	for (i = 0; i < netdev->real_num_tx_queues; i++) {
>> +		if (ibmveth_allocate_tx_ltb(adapter, i))
>> +			goto err_free_ltbs;
>> +	}
> [Severity: Low]
> This isn't a bug introduced by this patch, and it looks unreachable by the
> end of the series, but noting it for traceability: ibmveth_allocate_tx_ltb()
> assigns the kzalloc() and dma_map_single() results straight into
> tx_ltb_ptr[i] / tx_ltb_dma[i] with no check for an already-populated slot,
> unlike ibmveth_set_channels() which does
>
> 	if (adapter->tx_ltb_ptr[i])
> 		continue;
>
> so a caller reaching this helper with a live mapping in the slot would
> strand the old TCE mapping.  With the later set_channels rewrite in this
> series the !adapter->opened branch allocates nothing and the opened branch
> frees everything it allocated on failure, so no path leaves tx_ltb_ptr[]
> populated while adapter->opened is false and open() cannot overwrite a live
> mapping.  Would a defensive check (or a comment stating the invariant) be
> worth it here?
A comment. A defensive skip would hide a caller that left a live
mapping.
>> +
>> +	return 0;
>> +
>> +err_free_ltbs:
>> +	while (--i >= 0)
>> +		ibmveth_free_tx_ltb(adapter, i);
>> +	return -ENOMEM;
>> +}
>> +
>> +/**
>> + * ibmveth_free_tx_resources - Free TX resources for all queues
>> + * @adapter: ibmveth adapter structure
>> + *
>> + * Frees TX Long Term Buffers (LTBs) for all TX queues.
>> + */
>> +static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	int i;
>> +
>> +	for (i = 0; i < netdev->real_num_tx_queues; i++)
>> +		ibmveth_free_tx_ltb(adapter, i);
>> +}
> [Severity: Low]
> Small wording mismatch: the kernel-doc says "Frees TX Long Term Buffers
> (LTBs) for all TX queues", but the loop is bounded by real_num_tx_queues
> while tx_ltb_ptr[] is IBMVETH_MAX_QUEUES wide.  Since ibmveth_free_tx_ltb()
> is now NULL-safe, either iterating IBMVETH_MAX_QUEUES or saying
> "real_num_tx_queues" in the comment would make the two agree.
The kdoc now says real_num_tx_queues.
>> @@ -1263,12 +1309,6 @@ static int ibmveth_open(struct net_device *netdev)
> [ ... ]
>
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
> [ ... ]
>
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
> This isn't a bug introduced by this patch, but is the changelog wording
> accurate about what changed here?  The commit message says:
>
>    "After LAN registration, open-fail teardown frees the logical LAN before
>    tearing down RX pool DMA (intentional safer order than leaving the LAN
>    registered while unmapping RX memory)."
>
> At the parent commit, an ibmveth_alloc_buffer_pools() failure after a
> successful ibmveth_register_logical_lan() went
>
> 	rc = ibmveth_alloc_buffer_pools(adapter);
> 	if (rc)
> 		goto out_free_tx_ltb;
>
> and out_free_tx_ltb fell through to ibmveth_cleanup_rx_resources() and
> ibmveth_free_filter_list() with no h_free_logical_lan() anywhere on that
> path, so the RX queue and buffer/filter lists were unmapped and freed while
> PHYP still had the LAN registered.  Post-patch that failure goes to
> out_unregister_lan, which issues the deregistration hcall first.
>
> So this looks less like a reordering and more like adding a hcall that was
> never issued on that path.  Should this be split out as its own patch with a
> Fixes: tag so it can be picked up for stable, rather than described as an
> ordering preference inside a TX-only refactor?

Yes. That path never issued the hcall; v6 says so.

The tag would be:

   Fixes: d43732ce021f ("ibmveth: properly unwind on init errors")

Same d43732ce021f origin as patch 3 — one standalone after this
series covers both. The posting stays 15.

>> @@ -1343,7 +1385,10 @@ static int ibmveth_close(struct net_device *netdev)
> [ ... ]
>
>> -	netif_tx_stop_all_queues(netdev);
>> +	/* Disable and wait for in-flight ndo_start_xmit (stop_all_queues
>> +	 * alone does not). Direct close() callers bypass synchronize_net().
>> +	 */
>> +	netif_tx_disable(netdev);
> [Severity: High]
> This isn't a bug introduced by this patch, but the reasoning in this new
> comment seems to apply equally to ibmveth_set_channels(), which still frees
> the same LTBs after only netif_tx_stop_all_queues():
>
> ibmveth_set_channels() {
> 	...
> 	netif_tx_stop_all_queues(netdev);
> 	...
> 	/* Free any that are no longer needed */
> 	for (i = old; i > goal; i--) {
> 		if (adapter->tx_ltb_ptr[i - 1])
> 			ibmveth_free_tx_ltb(adapter, i - 1);
> 	}
>
> 	netif_tx_wake_all_queues(netdev);
> }
>
> netif_tx_stop_all_queues() only sets __QUEUE_STATE_DRV_XOFF; it takes no
> __netif_tx_lock, and netif_set_real_num_tx_queues() only touches the qdisc
> root lock.  Since ibmveth does not declare lltx, an ndo_start_xmit already
> running on another CPU holds the txq lock and keeps going:
>
> CPU0 ibmveth_start_xmit()
> 	/* already passed !adapter->tx_ltb_ptr[queue_num] */
> 	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
> 	...
> 	desc.fields.address = adapter->tx_ltb_dma[queue_num];
>
> CPU1 ibmveth_set_channels()
> 	ibmveth_free_tx_ltb(adapter, i - 1);
> 	  dma_unmap_single(...);
> 	  adapter->tx_ltb_dma[idx] = 0;
> 	  kfree(adapter->tx_ltb_ptr[idx]);
>
> Can an ethtool -L shrink therefore memcpy into kfree()d memory and pass a
> stale or zeroed DMA address to H_SEND_LOGICAL_LAN?  The new one-shot
> tx_ltb_ptr[] check in ibmveth_start_xmit() does not close this window, and
> this stop-then-free sequence is unchanged at the end of the series.  Should
> ibmveth_set_channels() use netif_tx_disable() too?

Yes. close() already uses netif_tx_disable(). The shrink path stays
stop-then-free here and at series tip. Patches 14 and 15 switch the
IFF_UP vs opened gate; they do not add disable.

>> @@ -1359,13 +1404,14 @@ static int ibmveth_close(struct net_device *netdev)
> [ ... ]
>
>> @@ -1789,6 +1835,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>>   	int i, queue_num = skb_get_queue_mapping(skb);
>>   	unsigned long mss = 0;
>>   
>> +	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
>> +	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
>> +		dev_kfree_skb_any(skb);
>> +		return NETDEV_TX_OK;
>> +	}
>> +
> [Severity: Medium]
> Should this drop bump netdev->stats.tx_dropped like every other drop in this
> function does?
>
> 	if (unlikely(skb->len > adapter->tx_ltb_size)) {
> 		...
> 		netdev->stats.tx_dropped++;
> 		goto out;
> 	}
>
> The other drop sites (ibmveth_is_packet_unsupported(), the checksum-help
> failure, the oversize check, the total_bytes mismatch and the
> ibmveth_send() failure) all increment tx_dropped, and returning
> NETDEV_TX_OK tells the core the skb was consumed so the core cannot account
> for it either.  In exactly the abnormal states this guard targets, traffic
> is then discarded with nothing visible in ip -s link or in
> /sys/class/net/<if>/statistics/tx_dropped.  Could this reuse the existing
> out: label after the tx_dropped++ instead?
Yes. v6 increments tx_dropped and falls into out:.
> [Severity: Low]
> This isn't a bug introduced by this patch, and it looks resolved later in
> the series, but noting it for traceability against the claim in the commit
> message that "close/failed-reopen with IFF_UP set cannot UAF".
>
> The guard keys off tx_ltb_ptr[] rather than adapter->opened, while
> ibmveth_set_channels() at this point in the series still selects its live
> path from IFF_UP alone:
>
> 	if (!(netdev->flags & IFF_UP))
> 		return netif_set_real_num_tx_queues(netdev, goal);
>
> In the state the driver documents in ibmveth_close() (IFF_UP set,
> adapter->opened false after a failed reopen), ethtool -L would allocate LTBs
> and finish with netif_tx_wake_all_queues() on an adapter whose logical LAN
> was already released, so packets pass this pointer-only check and reach
> ibmveth_send() with no registered LAN, and those LTBs are not freed by a
> later close() because it early-returns on !adapter->opened.  The later patch
> "ibmveth: Wire ethtool set_channels to MQ RX queue resize" replaces the
> IFF_UP gating with an adapter->opened test whose !opened branch allocates
> nothing and wakes no queues, which removes this window.
The v5 claim was too broad. NULL-first only closes the check-then-use
window; close-path safety is netif_tx_disable(). The IFF_UP vs opened
window closes in patches 14 and 15.


Thanks,

Mingming


