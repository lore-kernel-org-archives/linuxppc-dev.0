Return-Path: <linuxppc-dev+bounces-26320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47926C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 18:13:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYcYM4zZrz2y2f;
	Tue, 01 Sep 2026 04:13:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788199991;
	cv=none; b=TnnyU2wvhMzZXiZGmozPA3JD5VmfZqCABRPot7vhdhJuDK6ttDWQ+Ggmw8TslDJp5KR14IXbXYs7eDKOWMznaKQzwV11NZjmqQDwzOR/fq5+383qhFbBN8Edf87693KTKbx5QmdCeqF0nWyaIGG3svKCW9WIObNdysbnTfo72jayLYzqtqQAJRcEIEkxCKKIi6jvcNGXmoBBQI1Pl7TEAWSpRRv2Xd5OGdDqwV7o5Q8OXfg5R6WVcOogfnwIOrRY1fnX5xFpw5toR9Mm/JtiP8WnnEpR0TJ7b4SMcmZQYqD/kQOC1D8k+M6XjKtKcoV7CVgYiIwmCdtHymz2fh0QQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788199991; c=relaxed/relaxed;
	bh=8kGpLBENBSV/2Iyk28YMxI0nccCXyN3lxK/zwD4QPc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J17I2DKu8YnFKkkNu9mopeWNzwQoBbPBGOXQpW4+GuvDnyrkyJkltWUNbmR95+4M7S/QeLLvSQHLhemNLt3MmZEMKfXgGlJ/rHcgxLu3k2aD05lQbUlY10WXlx7HEjbi2Y2UmBPuIvGxbu3TnF+VyOQlFrAmFOdJ/vD/XLAolLnFZTkN5oQRVAJI0TEX4qRHPYi9wNRgaQ+X3A6BQF956gfYoI1b7AuUWHDB7zdW64x6xLiaM1Vm1prjHBmb2/22O+b/1YE53CEBTo+XbuuSAimmO4KLC/zQe8Z03igB4TZvHNLYCxHAwvAudkNm7wx0t6eWQ/2JOcxaJzc/WvjoQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p+Fy+n9g; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p+Fy+n9g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYcYL3dcFz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 04:13:09 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1jR01615924;
	Mon, 31 Aug 2026 18:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8kGpLB
	ENBSV/2Iyk28YMxI0nccCXyN3lxK/zwD4QPc0=; b=p+Fy+n9gbgQFUOMA4nZseP
	YA0zHdnm8Flw1wBm3eVi6Npe+TcoN6o2qSgH5i1DZ+CSjyBRRtVQmQJQHGKFjTse
	db8EQs6/NuXfAM0nYoCilgdvTgC+/D/JW1GwaJIqefKzCtJHEMp5L7uGlCl9OGo5
	wNLv/KrXpHR6K+/QXDjOnjmRuCv3BZ2YSlgVr7rOx4lRgZTDR1ar36VaElqzos55
	rD9DMytXhqCWWpeim7uv2g0NyZdnq6R75q6LOecYfiYsa0vXjNgkqs6PoiDFXR51
	xe5X6piufyFgJSjCZ252sUg3hMYUHdNEI9yEm+p/IiriXfJmju735khdUfJioahw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudk1xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:12:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIBPqr013188;
	Mon, 31 Aug 2026 18:12:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg772v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:12:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VICrkB32572134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 18:12:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD9D45805C;
	Mon, 31 Aug 2026 18:12:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A37CA58051;
	Mon, 31 Aug 2026 18:12:50 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 18:12:50 +0000 (GMT)
Message-ID: <59175ef0-4c2a-4a2b-97b3-2e179f49e1c3@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:12:49 -0700
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
Subject: Re: [PATCH net-next v5 03/15] ibmveth: Refactor RX resource
 allocation for MQ RX bring-up
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-4-mmc@linux.ibm.com>
 <20260818014719.3853980-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014719.3853980-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9RT7VpKNCTQMxtLE6IvFmN5l2d6LBtRh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX/dnziWl9Llmi
 DKAi+hn/T9w0vY/w3T5AasdlGsbvLAaThUE9eBlp9/2bbDaXV1J1sTuzPL3mjlu/DN0eGN/RzyG
 +w9BqRM93LsTk2Fm5RoIIeQH28h3qHT0KE7YvyQAWN2g8c2MWq/tvlhG1ziWMrt7/OJvOF3mB4K
 VCykEpb0KHl2cWeQIHJKRMH1d0ZZr6wlj3bL5qfRFMwnNXtcY/rl+cO87uP5ZP5ouw85FegFiG+
 C/23o6trkrTxJT0MPeAhcxY7ng7mKjEsqhXahuTTC0Cmn2WLfnXFDzhjtMeg/hCRvvdJHxaKzK/
 JD7rYDxD8O2vIDBgzGh9em6UvZbHdtorUVBMJgsWVc4MavoqsfTtuBgH8oRMMzEd4Nyq2S6AfRZ
 9QzcGoaDBeEert69be0FKpZFUOamYD5OU/yPaycKiIJg74PxfTz1R36XWgE5nEWRmvviLiH4SIP
 Djo5wpz1tU1PHjZhDDg==
X-Proofpoint-ORIG-GUID: 9b5Ax5L1gWZAJzoInYyiqKZF_b3rtpCI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX7EJg3lhzF+Ke
 FsQUMJGruA0YDcIDCkCbKeAftSMulVm5ChfaajqIIyHkMgSm30GaxNVHoWZGRzEPZ/OOijKyAQ4
 8dRCs37ZaajcVbyNmOR1Erw/k+Zemy4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95c429 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=P4xsUHNs_9QpIrpflkYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310156


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor RX resource allocation for MQ RX bring-up
>
> This moves the filter list and per-queue RX buffer list / RX ring
> allocation out of ibmveth_open() into four new helpers, and wires them
> into both the open failure unwind and ibmveth_close(). Runtime behaviour
> is meant to stay single-queue, and rc = -ENOMEM is now set before the TX
> LTB loop.
>
> A few questions below about the new release helpers and the remaining
> inline unwind in ibmveth_open().
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 7cb828b476c1b..168940bfa1094 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -151,6 +151,186 @@ static unsigned int ibmveth_real_max_tx_queues(void)
>>   	return min(n_cpu, IBMVETH_MAX_QUEUES);
>>   }
>>   
>> +/**
>> + * ibmveth_alloc_filter_list - Allocate and map filter list
>> + * @adapter: ibmveth adapter structure
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int
>> +ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
>> +{
>> +	struct device *dev = &adapter->vdev->dev;
>> +	struct net_device *netdev = adapter->netdev;
>> +
>> +	adapter->filter_list_addr = (void *)get_zeroed_page(GFP_KERNEL);
>> +	if (!adapter->filter_list_addr) {
>> +		netdev_err(netdev, "unable to allocate filter pages\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	adapter->filter_list_dma = dma_map_single(dev,
>> +						  adapter->filter_list_addr,
>> +						  4096, DMA_BIDIRECTIONAL);
>> +	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
>> +		netdev_err(netdev, "unable to map filter list pages\n");
>> +		free_page((unsigned long)adapter->filter_list_addr);
>> +		adapter->filter_list_addr = NULL;
>> +		/* Do not leave DMA_MAPPING_ERROR for free_filter_list(). */
>> +		adapter->filter_list_dma = 0;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	netdev_dbg(netdev, "filter list @ 0x%p (DMA: 0x%llx)\n",
>> +		   adapter->filter_list_addr,
>> +		   (unsigned long long)adapter->filter_list_dma);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ibmveth_free_filter_list - Free filter list resources
>> + * @adapter: ibmveth adapter structure
>> + */
>> +static void
>> +ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
>> +{
>> +	struct device *dev = &adapter->vdev->dev;
>> +
>> +	if (adapter->filter_list_dma) {
>> +		dma_unmap_single(dev, adapter->filter_list_dma, 4096,
>> +				 DMA_BIDIRECTIONAL);
>> +		adapter->filter_list_dma = 0;
>> +	}
>> +
>> +	if (adapter->filter_list_addr) {
>> +		free_page((unsigned long)adapter->filter_list_addr);
>> +		adapter->filter_list_addr = NULL;
>> +	}
>> +}
> [Severity: Medium]
> Is this patch doing more than a refactor?  The new pointer and DMA handle
> guards in ibmveth_free_filter_list(), plus the same guards in
> ibmveth_cleanup_rx_resources(), look like they also fix a double free that
> exists before this patch.
>
> In the baseline, the ibmveth_open() unwind released the pages without
> clearing anything:
>
> out_free_filter_list:
> 	free_page((unsigned long)adapter->filter_list_addr);
> out_free_buffer_list:
> 	free_page((unsigned long)adapter->buffer_list_addr[0]);
>
> and ibmveth_close() then repeated the same work unconditionally:
>
> 	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
> 			 DMA_BIDIRECTIONAL);
> 	free_page((unsigned long)adapter->buffer_list_addr[0]);
>
> 	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
> 			 DMA_BIDIRECTIONAL);
> 	free_page((unsigned long)adapter->filter_list_addr);
>
> ibmveth_set_csum_offload(), ibmveth_set_tso(), ibmveth_change_mtu() and
> veth_pool_store() all propagate an ibmveth_open() failure while leaving the
> interface running, so the following ndo_stop re-ran those frees on pages
> that were already returned, together with a dma_unmap of an already
> unmapped address.
>
> The applied commit message describes this as a pure refactor ("Runtime
> behavior stays single-queue"), and the reasoning for the guards only
> appears in the v5 changelog below the --- line, which is stripped when the
> patch is applied.  Could the commit message state that the double
> free_page() and stale dma_unmap are fixed here, and could a Fixes: tag be
> added so stable trees can pick it up?
>
> Note the sibling release helper ibmveth_free_tx_ltb() is still not
> idempotent at this point in the series; that is only addressed by the later
> "ibmveth: Refactor TX resource allocation in open/close paths" patch.

Yes. More than a refactor, and v6 names the double free_page() and
stale dma_unmap in the commit message rather than only below the ---.

The tag would be:

   Fixes: d43732ce021f ("ibmveth: properly unwind on init errors")

I would rather send it to net as a standalone than tag it here. The
fix is spread through this helper restack and is not a clean
cherry-pick for stable, and it pairs with free_tx_ltb() in patch 6 —
one defect, one patch. Putting that at the head of this
series makes it 16 patches, which exceeds the netdev single-series
limit. Sending it to net after this series keeps the posting within
the limit and makes the fix a clean standalone cherry-pick for stable.
Happy to restructure if you would rather have the fix in this posting.

>
> [ ... ]
>
>> +	netdev_dbg(netdev, "allocated %d RX queue(s) with %d entries each\n",
>> +		   adapter->num_rx_queues, rxq_entries);
> [ ... ]
>
>> +static void
>> +ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
>> +{
>> +	struct device *dev = &adapter->vdev->dev;
>> +	int i;
>> +
>> +	netdev_dbg(adapter->netdev, "cleaning up %d RX queue(s)\n",
>> +		   adapter->num_rx_queues);
> [Severity: Low]
> This isn't a bug, but adapter->num_rx_queues is declared as unsigned int in
> struct ibmveth_adapter in ibmveth.h, so should these two new debug messages
> in ibmveth_alloc_rx_queues() and ibmveth_cleanup_rx_resources() use %u
> rather than %d?  The same mismatch is still there at the end of the series
> where the value comes from ibmveth_get_num_rx_queues(), which also returns
> unsigned int.
Yes. Both use %u in v6.
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (adapter->buffer_list_dma[i]) {
>> +			dma_unmap_single(dev, adapter->buffer_list_dma[i],
>> +					 4096, DMA_BIDIRECTIONAL);
>> +			adapter->buffer_list_dma[i] = 0;
>> +		}
>> +
>> +		if (adapter->rx_queue[i].queue_addr) {
>> +			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
>> +					  adapter->rx_queue[i].queue_addr,
>> +					  adapter->rx_queue[i].queue_dma);
>> +			adapter->rx_queue[i].queue_addr = NULL;
>> +		}
>> +
>> +		if (adapter->buffer_list_addr[i]) {
>> +			free_page((unsigned long)adapter->buffer_list_addr[i]);
>> +			adapter->buffer_list_addr[i] = NULL;
>> +		}
>> +	}
>> +}
>> +
>>   /* setup the initial settings for a buffer pool */
>>   static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
>>   				     u32 pool_index, u32 pool_size,
> [ ... ]
>
>> @@ -752,26 +890,12 @@ static int ibmveth_open(struct net_device *netdev)
>>   			ibmveth_free_buffer_pool(adapter,
>>   						 &adapter->rx_buff_pool[0][i]);
>>   	}
>> -out_unmap_filter_list:
>> -	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
>> -			 DMA_BIDIRECTIONAL);
>> -
>>   out_free_tx_ltb:
>> -	while (--i >= 0) {
>> +	while (--i >= 0)
>>   		ibmveth_free_tx_ltb(adapter, i);
>> -	}
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does the fall-through from
> out_free_buffer_pools into out_free_tx_ltb leak the TX long term buffers?
>
> Both labels share the loop counter i.  On the buffer pool failure and the
> request_irq() failure paths, out_free_buffer_pools already runs
> while (--i >= 0) down to i == -1, so out_free_tx_ltb then evaluates
> --i == -2 and runs zero iterations:
>
> out_free_buffer_pools:
> 	while (--i >= 0) {
> 		...
> 	}
> out_free_tx_ltb:
> 	while (--i >= 0)
> 		ibmveth_free_tx_ltb(adapter, i);
>
> Every tx_ltb_ptr[] allocation plus its dma_map_single(DMA_TO_DEVICE) made
> by the earlier loop over real_num_tx_queues then stays around, and a later
> successful open overwrites the pointers and handles.
>
> The shared counter disappears at the end of the series, where TX LTB
> allocation moves into ibmveth_alloc_tx_resources() with its own err_free_ltbs
> unwind, so this only matters for this commit and its predecessors.
Yes. Pre-existing. Patch 4 stops the shared i; patch 6 gives TX its
own unwind.
>> -
>> -out_unmap_buffer_list:
>> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
>> -			 DMA_BIDIRECTIONAL);
>> -out_free_queue_mem:
>> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
>> -			  adapter->rx_queue[0].queue_addr,
>> -			  adapter->rx_queue[0].queue_dma);
>> +	ibmveth_cleanup_rx_resources(adapter);
>>   out_free_filter_list:
>> -	free_page((unsigned long)adapter->filter_list_addr);
>> -out_free_buffer_list:
>> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
>> +	ibmveth_free_filter_list(adapter);
>>   out:
>>   	napi_disable(&adapter->napi[0]);
>>   	return rc;
> [Severity: High]
> This is a pre-existing issue, but can the hypervisor still be writing into
> these pages here?
>
> On the buffer pool allocation failure path in ibmveth_open():
>
> 		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
> 			netdev_err(netdev, "unable to alloc pool\n");
> 			adapter->rx_buff_pool[0][i].active = 0;
> 			rc = -ENOMEM;
> 			goto out_free_buffer_pools;
> 		}
>
> there is no h_free_logical_lan() loop, unlike the request_irq() failure
> path just below it, so PHYP is still registered against the buffer list
> page, the RX ring and the filter list when control reaches
> ibmveth_cleanup_rx_resources() and ibmveth_free_filter_list(), which
> dma_unmap and free them.
>
> The consolidated helpers make that sequence easier to read but do not
> change it.  At the end of the series ibmveth_open() allocates the buffer
> pools before ibmveth_register_rx_queues() and every post-registration exit
> goes through ibmveth_free_all_queues() first, so is the ordering here worth
> fixing earlier, or is it intentionally left to the later "ibmveth: Add RX
> queue register helpers for MQ" patch?
It can, at this point in the series. Patch 6 issues
h_free_logical_lan() on the pool-fail path before RX pool DMA
teardown — that path never deregistered. Patch 7 then moves pool
alloc ahead of register_rx_queues() and routes every later error
exit through ibmveth_free_all_queues(), so PHYP has been dropped
before anything is unmapped. The staging is deliberate but the
intermediate state is real. both commit messages say so.
>> @@ -805,17 +928,8 @@ static int ibmveth_close(struct net_device *netdev)
>>   
>>   	ibmveth_update_rx_no_buffer(adapter);
>>   
>> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
>> -			 DMA_BIDIRECTIONAL);
>> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
>> -
>> -	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
>> -			 DMA_BIDIRECTIONAL);
>> -	free_page((unsigned long)adapter->filter_list_addr);
>> -
>> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
>> -			  adapter->rx_queue[0].queue_addr,
>> -			  adapter->rx_queue[0].queue_dma);
>> +	ibmveth_cleanup_rx_resources(adapter);
>> +	ibmveth_free_filter_list(adapter);
> [Severity: High]
> Can ibmveth_close() dereference a NULL buffer_list_addr[0] now?
>
> ibmveth_cleanup_rx_resources() clears the pointer after freeing it:
>
> 			free_page((unsigned long)adapter->buffer_list_addr[i]);
> 			adapter->buffer_list_addr[i] = NULL;
>
> while ibmveth_update_rx_no_buffer(), called just above, dereferences it
> unconditionally:
>
> 	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
>
> 	adapter->rx_no_buffer = be64_to_cpup(p);
>
> The baseline inline code in ibmveth_close() left the pointer stale, so the
> read did not fault.  With the helper clearing it, a failed re-open leaves
> the field NULL while the interface is still up:
>
> ibmveth_set_csum_offload() / ibmveth_set_tso() / ibmveth_change_mtu() /
> veth_pool_store()
>      ibmveth_close()
>      ibmveth_open()          <- fails, out_free_tx_ltb path runs
>          ibmveth_cleanup_rx_resources()   buffer_list_addr[0] = NULL
>
> and the next ndo_stop, or the queued ibmveth_reset() work reaching
> dev_close(), enters ibmveth_close() and reads through NULL + 4096 - 8.
>
> Later patches in the series appear to close this: ibmveth_close() becomes
> gated on adapter->opened, and ibmveth_update_rx_no_buffer() takes a queue
> index and returns early when buffer_list_addr[queue_index] is NULL.  Would
> it make sense to add that NULL check in this patch, since this is the commit
> that starts clearing the pointer?
Yes, for close(). Patch 5's opened gate stops that path.

It does not stop the other caller: replenish_task() from netpoll,
which consults neither opened nor RTNL. The guard that covers every

caller is in patch 10.

Thanks,

Mingming


