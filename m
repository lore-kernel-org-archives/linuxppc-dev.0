Return-Path: <linuxppc-dev+bounces-28164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E01C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:08:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgHx1HSCz2y2J;
	Fri, 25 Sep 2026 16:08:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790316525;
	cv=none; b=hA48ugYYiIYJYswW6zGqv36gHqVuFy7W5vFEfNuswbFWctAiVU4yguyhteEWBojVvuixx1L44Tm+7C6nUD94N+W26ZMlvbOLFaCYAVGuV2KQDtGeIlH0rcfu+XR1VIA+9/uJbpy3yfi3x7ixR347f+ro/BJYwpD/TZZ0E1CQQ+abP3/tFiLNyF6EVHq9eG7qFgN1h74iGbbjZCF0bI3TyDcBmadAULrEPVa1q/oFvDF3N/G28KsS9ss6M1It+Y0RSs343Idjqlu9xMVQYRXPsXLYFtstRC5sxvc5AdzF9nDIFBrYE+InKLkuS/++6Z7M/bxiJ2KL5MXHoMeDlbOFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790316525; c=relaxed/relaxed;
	bh=D6+634BFR04zd4UMnQfV8ZMiMgAoVEXWaW3dh133Css=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odhPay61WSjQygnZHbp5xqPe3sNqOiIcgPglWUZSEEJ5iNzIx2pmhvZfonbryHNOlVmphsnsHewqKTGRobxp2+FO5/iIDpwWIYsWc9E+ukMikfUIn7qAlHws1jzhOIP/aoxLrEfWPioICJXvtH+kFo4P0r55nmo2p940Rkze/fI0YiPqcfVE05fNqb5uZnRiKdU7hgh6La82Sf7xxI1yDCqDwZReB1opTXMJXdEvBsaNEKDDZRV2LB1AMpegfZsw4HlBzJiCsJWiTSSwtwY8Z1e9MuxLrrDuBOwlCA6YmKYH0/Ujjmf+B1zMAJnFJa8zeU8BUd2kKcLsTa/IFH4TTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Csa+nEEq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Csa+nEEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgHv666vz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:08:43 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aWOw102815;
	Fri, 25 Sep 2026 06:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D6+634
	BFR04zd4UMnQfV8ZMiMgAoVEXWaW3dh133Css=; b=Csa+nEEqHGSj4sT2/s65BO
	YOvWIKVgEo3e5fpblfUwB7ZOuvAuLs64/zWz/Bs2+fXVa7433DNiZAKn0/dxBh6m
	+3wtXkuJpEkZDXBm2ZnAJSpRB3JKIOZuyZ5I8eXKS9ncDpMUHBvS33CZKMETdcVh
	u5pzmPKRcIGhJPSsMrVLFpVq33lTAeDUylNiBn2dxmqpl5GXmU5gXtnk2vm/H0DK
	wLZtJ3ZQr7xdRwhUqRuu/s1q6SgSd7uEpPbXe8K6C9+Jc59PMlNulB4E0v2J4Rww
	yVatZiHwrSwAt/FrYoDB+itxdMoXnb0+4OM/80hQ9YsHjs32XJ7wH4hrXHtwC6iA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvmjww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:08:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lnha3245081;
	Fri, 25 Sep 2026 06:08:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu916bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:08:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P68Kvo57934272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:08:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1308F5804B;
	Fri, 25 Sep 2026 06:08:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A43958055;
	Fri, 25 Sep 2026 06:08:17 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:08:17 +0000 (GMT)
Message-ID: <728a5d27-0ef1-4687-b8bd-9e1b97f14125@linux.ibm.com>
Date: Thu, 24 Sep 2026 23:08:16 -0700
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
Subject: Re: [net-next,v6,03/15] ibmveth: Refactor RX resource allocation for
 MQ RX bring-up
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <35d4e6e84a68bb44d6f0968926b77e555abd126e.1788102125.git.mmc@linux.ibm.com>
 <178845903117.3394541.14494197434801526302@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845903117.3394541.14494197434801526302@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UhZDoOcBRnrU79d3KewVhfgG5ir6Ycg4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfXzyeeqBA79zGJ
 IA9OEVHcebZMOg2eLk/Mq36iPEgM4VfRB9WQgB3hsQEytoDPfqinNGfhT+U014O2BmRYqDexrbu
 73BE6QvAHzanLYc4qBJBzEr2w73yyrw=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab60fd7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=8GHEaj9Lk3615Prqp5sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nEqOBYSiRoFewfMKNfsf0i-cZDNqdUsH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX9wUf87erln1z
 b6GMG81xbcoQLyD6oYgGxcWuNw9OEMxzm2gmoxHga2Gb7byBiKoLid3IA6ctT2whBDHmLUzgaI2
 0NPGMHz4RaXP+PIXBcdXiGWDrw92Yq2VlLd6NlG5cifiM42FIfrNq1ep4Ho00phquqJPXBaCGI6
 qcwddKOFtRqxcb0BgHkUlX4kRXQO2RgaSwIh5n9PrsjEzjeBcIGN6qT2sQHG/bHzrAD3jsoMNab
 e6vkeZCZG4SV7psfMysWuUOirLKbZ60WQkoltXEUYRRHGX7diMw1lbD5kuhWlkSvw8W2gAkxkJR
 JMVOFI5FdK/ZvUd4Cd+1721DtfmUWuyEIi1AH2dzwcWUc0Am0g9OJPqn5yZmpU3yk+eViQ69U6E
 LDy+ZAyhIXbyL9Stod3E28f6+wZ/V5o1rMO5cHYBzAcl5vTfCV5M31cMvFGt7YYDO6Ig7kXKhQ7
 entDTD1PDPVD7pqhpyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250024


On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 (2) · Medium: 0 (3) · Low: 2
>
> - [High] ibmveth_cleanup_rx_resources() and ibmveth_alloc_rx_queues()'s
>    rollback newly store NULL into adapter->buffer_list_addr[i] (and…
> - [Low] The patch is presented as a mechanical refactor ("Runtime
>    behavior stays single-queue") but bundles a claimed memory-corruption…
> - [Low] The comment added above the err_cleanup: rollback loop in
>    ibmveth_alloc_rx_queues() states an invariant that the function's own…
>
> Pre-existing issues:
> - [High] ibmveth_open() calls napi_enable(&adapter->napi[0]) at entry and
>    napi_disable() on every failure at the out: label (ibmveth.c:907),…
> - [High] On the ibmveth_open() error path taken after
>    h_register_logical_lan() has already succeeded (buffer-pool allocation…
> - [Medium] TX long-term buffers are leaked when ibmveth_open() fails in
>    the buffer-pool allocation loop or in request_irq(): the loop counter…
> - [Medium] The TX long-term buffers keep the stale-DMA-handle pattern
>    that this patch fixes for the RX/filter lists: ibmveth_free_tx_ltb()…
> - [Medium] ibmveth_poll_controller() (ibmveth.c:1815-1819) calls
>    ibmveth_replenish_task() directly from netpoll context, bypassing…
>
> --
>
> ibmveth: Refactor RX resource allocation for MQ RX bring-up
>
> This moves the multicast filter list and the per-queue RX buffer lists and
> RX rings out of ibmveth_open() into ibmveth_alloc_filter_list(),
> ibmveth_alloc_rx_queues() and ibmveth_cleanup_rx_resources(), and wires
> those helpers into open()/close().  Runtime behaviour stays single-queue,
> and the helpers now NULL each pointer slot and zero each DMA handle as
> they free.
>
> (no Link: tags present in the commit header)
>
> Before the diff, a question about the changelog itself.
>
> [Severity: Low]
> The commit message says:
>
>    "The pointer and DMA-handle guards also close a baseline double
>     free_page() and stale dma_unmap after a failed reopen followed by
>     ndo_stop"
>
> Is that baseline sequence actually reachable?  ibmveth_open() calls
> napi_enable(&adapter->napi[0]) on entry and napi_disable() at its out:
> label, so after a failed reopen NAPI is already disabled while
> netif_running() is still true.  The following ndo_stop enters
> ibmveth_close(), whose first action is another napi_disable():
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_close() {
> 	napi_disable(&adapter->napi[0]);
>
> 	netif_tx_stop_all_queues(netdev);
> 	...
> }
>
> napi_disable_locked() leaves NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC set on
> exit, and only napi_enable()/napi_complete() clear SCHED, so the second
> call sits in:
>
> net/core/dev.c:napi_disable_locked() {
> 	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 		usleep_range(20, 200);
> 		val = READ_ONCE(n->state);
> 	}
> 	...
> }
>
> That is ahead of every free path in close(), so the double free_page()
> described in the changelog does not appear to be reachable as written.
>
> Separately, if these guards do fix memory corruption on stable kernels,
> would it be better to split them into their own patch with a Fixes: tag
> ahead of the refactor, rather than bundling them into a 200 line
> restructuring?
You are right. v7 drops that sentence. Failed reopen then
ndo_stop never reaches the second free_page() here: close()
hits napi_disable() first.

The pointer and DMA-handle checks stay in this helper extract
rather than being peeled into a Fixes: patch in this 15. On
current kernels that ndo_stop path never reaches the frees, so
the checks alone are not a stable hotfix. After this series a
standalone unwind for net can take
Fixes: d43732ce021f ("ibmveth: properly unwind on init errors").

>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 7cb828b476c1b..d2dad9e6068e0 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -151,6 +151,193 @@ static unsigned int ibmveth_real_max_tx_queues(void)
>>   	return min(n_cpu, IBMVETH_MAX_QUEUES);
>>   }
>>   
> [ ... ]
>
>> +		adapter->buffer_list_dma[i] =
>> +			dma_map_single(dev, adapter->buffer_list_addr[i],
>> +				       4096, DMA_BIDIRECTIONAL);
>> +		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
>> +			netdev_err(netdev,
>> +				   "unable to map buffer list for queue %d\n",
>> +				   i);
>> +			free_page((unsigned long)adapter->buffer_list_addr[i]);
>> +			adapter->buffer_list_addr[i] = NULL;
>> +			adapter->buffer_list_dma[i] = 0;
>> +			goto err_cleanup;
>> +		}
> [ ... ]
>
>> +err_cleanup:
>> +	/*
>> +	 * Every failure path above releases what it had already allocated
>> +	 * for queue i, so each index here is either fully constructed or
>> +	 * fully empty. Do not unmap buffer_list_dma[] without the matching
>> +	 * buffer_list_addr[] check: the two are only ever set together.
>> +	 */
> [Severity: Low]
> Does this comment match what the dma_mapping_error() branch just above
> leaves behind?  On that path buffer_list_addr[i] is freed and NULLed and
> buffer_list_dma[i] is zeroed, but rx_queue[i].queue_addr from
> dma_alloc_coherent() is still live, so index i arrives here partially
> constructed rather than "fully constructed or fully empty".
>
> The loop below is written with independent checks so it still frees the
> ring, but a later reader who trusts "the two are only ever set together"
> could collapse the two tests into one buffer_list_addr[] guard and leak
> the coherent RX ring on exactly that failure path.  Could the comment be
> reworded to describe the mixed state?
Yes — thanks. v7 rewords the err_cleanup comment: cleanup
frees by pointer presence. A dma_mapping_error on queue i
can leave queue_addr live after buffer_list_addr is already
NULL. The two checks stay independent.

>> +	for (; i >= 0; i--) {
>> +		if (adapter->buffer_list_addr[i]) {
>> +			dma_unmap_single(dev, adapter->buffer_list_dma[i],
>> +					 4096, DMA_BIDIRECTIONAL);
>> +			adapter->buffer_list_dma[i] = 0;
>> +		}
>> +		if (adapter->rx_queue[i].queue_addr) {
>> +			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
>> +					  adapter->rx_queue[i].queue_addr,
>> +					  adapter->rx_queue[i].queue_dma);
>> +			adapter->rx_queue[i].queue_addr = NULL;
>> +		}
>> +		if (adapter->buffer_list_addr[i]) {
>> +			free_page((unsigned long)adapter->buffer_list_addr[i]);
>> +			adapter->buffer_list_addr[i] = NULL;
>> +		}
>> +	}
>> +
>> +	return -ENOMEM;
>> +}
> [ ... ]
>
>> +static void
>> +ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
>> +{
>> +	struct device *dev = &adapter->vdev->dev;
>> +	int i;
>> +
>> +	netdev_dbg(adapter->netdev, "cleaning up %u RX queue(s)\n",
>> +		   adapter->num_rx_queues);
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (adapter->buffer_list_addr[i]) {
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
> [Severity: High]
> This helper now stores NULL into buffer_list_addr[i], but
> ibmveth_update_rx_no_buffer() still dereferences that slot with no check:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_update_rx_no_buffer() {
> 	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
>
> 	adapter->rx_no_buffer = be64_to_cpup(p);
> }
>
> Can that read fault after a failed reopen?  ibmveth_set_csum_offload(),
> ibmveth_set_tso(), __ibmveth_change_mtu() and veth_pool_store() all do
> ibmveth_close() followed by ibmveth_open() and only return the error if
> the reopen fails, so netif_running() stays true while
> ibmveth_open()'s unwind has already run ibmveth_cleanup_rx_resources()
> and left buffer_list_addr[0] NULL.
>
> The next netpoll poll then reaches the reader without going through NAPI:
>
> ibmveth_poll_controller()
>    ibmveth_replenish_task()
>      ibmveth_update_rx_no_buffer()   /* NULL + 4088 */
>
> ibmveth_free_buffer_pool() does not reset pool->available, so after a
> close the "available < threshold" test in ibmveth_replenish_task() is
> false for the fully posted pools and the loop falls through to
> ibmveth_update_rx_no_buffer().
>
> ibmveth_close() has the same ordering problem: it calls
> ibmveth_update_rx_no_buffer() before the new cleanup helpers, so the
> "failed reopen followed by ndo_stop" sequence in the changelog reaches
> the unguarded reader.
>
> In the baseline the same pointer was stale but still mapped, so this
> turns a silent read into a NULL dereference.  A matching
> "if (!adapter->buffer_list_addr[queue_index]) return;" guard, together
> with an "if (!adapter->opened) return;" gate in
> ibmveth_poll_controller(), only shows up in a later patch of this series
> - could that guard come in this patch instead, so the NULL state is never
> introduced without it?
Good catch — yes, at this commit. After a failed reopen,
netpoll can still reach the reader (IFF_UP is set, the
pointer is already NULL). The later ndo_stop hits
napi_disable() in close() first.

v7 adds the missing NULL return in
ibmveth_update_rx_no_buffer() here, so this helper extract
does not introduce the NULL state without a guard. The
opened gate on close() and poll_controller still lands in
the later patches — opened is not available yet.

>> +
>>   /* setup the initial settings for a buffer pool */
>>   static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
>>   				     u32 pool_index, u32 pool_size,
> [ ... ]
>
>> @@ -708,7 +855,7 @@ static int ibmveth_open(struct net_device *netdev)
>>   				     rxq_desc.desc,
>>   				     mac_address);
>>   		rc = -ENONET;
>> -		goto out_unmap_filter_list;
>> +		goto out_free_tx_ltb;
>>   	}
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the TX long term buffers
> keep the stale DMA handle pattern that the RX and filter helpers here
> now avoid:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_free_tx_ltb() {
> 	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
> 			 adapter->tx_ltb_size, DMA_TO_DEVICE);
> 	kfree(adapter->tx_ltb_ptr[idx]);
> 	adapter->tx_ltb_ptr[idx] = NULL;
> }
>
> tx_ltb_dma[idx] is never zeroed and the unmap is not gated on
> tx_ltb_ptr[idx].  When the h_register_logical_lan() failure above takes
> out_free_tx_ltb with the TX LTBs already allocated, a later
> ibmveth_close() loops over all real_num_tx_queues and calls
> ibmveth_free_tx_ltb() again, repeating dma_unmap_single() on a handle the
> driver no longer owns.  Can that tear down a recycled TCE?
>
> The changelog notes this is deferred, and the later "ibmveth: Refactor TX
> resource allocation in open/close paths" patch adds the pointer check and
> zeroes tx_ltb_dma[idx].
Yes. This patch only does the RX and filter side. The TX
long-term buffers get the same pointer check and a cleared
dma handle in the later TX helper patch ("Refactor TX
resource allocation in open/close paths"). That is already
in this series — deferred from here, not dropped.

>>   
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> @@ -735,8 +882,6 @@ static int ibmveth_open(struct net_device *netdev)
>>   		goto out_free_buffer_pools;
>>   	}
>>   
>> -	rc = -ENOMEM;
>> -
>>   	netdev_dbg(netdev, "initial replenish cycle\n");
>>   	ibmveth_interrupt(netdev->irq, netdev);
>>   
>> @@ -752,26 +897,12 @@ static int ibmveth_open(struct net_device *netdev)
>>   			ibmveth_free_buffer_pool(adapter,
>>   						 &adapter->rx_buff_pool[0][i]);
>>   	}
> [Severity: High]
> This is a pre-existing ordering issue, but the fall-through from
> out_free_buffer_pools now releases more state than before.  The buffer
> pool loop runs after h_register_logical_lan() has succeeded, and on
> ibmveth_alloc_buffer_pool() failure this label falls through to
> out_free_tx_ltb and out_free_filter_list, which now call
> ibmveth_cleanup_rx_resources() and ibmveth_free_filter_list() with no
> h_free_logical_lan() anywhere on the path.
>
> The adjacent request_irq() failure path does perform the
> deregistration first:
>
> 		do {
> 			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> 		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>
> Can PHYP keep DMA-writing the no-buffer counter in the last eight bytes
> of the buffer list page after those pages have been unmapped and returned
> to the page allocator?
>
> The changelog acknowledges this predates the patch, and at the end of the
> series ibmveth_open() allocates the pools before registering and every
> post-registration failure goes through ibmveth_free_all_queues(), which
> issues h_free_logical_lan().
Yes, pre-existing at this commit. The TX helper patch issues
h_free on that pool-fail path. The register-helper patch then
allocates the pools before register, and every later failure
goes through ibmveth_free_all_queues().
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
> This is a pre-existing problem rather than something this patch adds, but
> does this loop ever run when the failure came from the buffer pool loop
> or from request_irq()?  Both out_free_buffer_pools and out_free_tx_ltb
> consume the same counter i, and i has been reused as the buffer pool
> index by then:
>
> out_free_buffer_pools:
> 	while (--i >= 0) {		/* drains i to -1 */
> 		...
> 	}
> out_free_tx_ltb:
> 	while (--i >= 0)		/* starts at -2, never runs */
> 		ibmveth_free_tx_ltb(adapter, i);
> So every tx_ltb_ptr[]/tx_ltb_dma[] allocated in this open() stays
> allocated and mapped.  The changelog mentions the shared i leak, and the
> later TX refactor patch gives the rollback its own counter.
No — not on those two paths. out_free_buffer_pools already
walks i down to -1, so the fall-through while (--i >= 0)
never frees a TX LTB. Pre-existing. The TX helper patch
gives that rollback its own counter, and it allocates TX
after the pools, so a pool failure has no LTBs to leak.

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
> This is a pre-existing imbalance and not introduced here, but it is the
> path the changelog leans on, so it seems worth raising.
>
> Every open failure leaves NAPI disabled while the device is still
> administratively up, because ibmveth_set_csum_offload(), ibmveth_set_tso(),
> __ibmveth_change_mtu() and veth_pool_store() just return the reopen error.
> ibmveth_close() then calls napi_disable() a second time with no
> intervening napi_enable(), and napi_disable_locked() spins:
>
> net/core/dev.c:napi_disable_locked() {
> 	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 		usleep_range(20, 200);
> 		val = READ_ONCE(n->state);
> 	}
> 	...
> }
>
> Nothing clears SCHED at that point, and the loop runs inside dev_close()
> with rtnl_lock() and the netdev lock held.  Can an ifdown after a failed
> reopen wedge every later RTNL operation?
>
> The series later drops this by returning early from close() when
> adapter->opened is false and handling NAPI in
> ibmveth_cleanup_rx_interrupts().
Yes — at this commit that ifdown can wedge. open() enables
NAPI on entry and disables it on every failure, then close()
calls napi_disable() again. Pre-existing. Patch 5 ("Refactor
RX interrupt control for MQ RX queues") fixes it: close()
returns early when opened is false, and NAPI teardown moves
into ibmveth_cleanup_rx_interrupts().
>> @@ -780,7 +911,6 @@ static int ibmveth_open(struct net_device *netdev)
>>   static int ibmveth_close(struct net_device *netdev)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> -	struct device *dev = &adapter->vdev->dev;
>>   	long lpar_rc;
>>   	int i;
>>   
>> @@ -805,17 +935,8 @@ static int ibmveth_close(struct net_device *netdev)
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
> [Severity: Medium]
> This isn't a bug introduced by the patch either, but the failure mode
> changes here.  What serializes these frees against netpoll?
>
> ibmveth_poll_controller() calls ibmveth_replenish_task() directly, so it
> never goes through napi_schedule()/poll and the napi_disable() at the top
> of ibmveth_close() does not exclude it:
>
> static void ibmveth_poll_controller(struct net_device *dev)
> {
> 	ibmveth_replenish_task(netdev_priv(dev));
> 	ibmveth_interrupt(dev->irq, dev);
> }
>
> The teardown path holds only rtnl and the netdev lock, which netpoll does
> not take, and the internal close()/open() callers (ethtool csum and tso,
> change_mtu, veth_pool_store) never call netpoll_poll_disable(), which only
> dev_close()/dev_open() do.  With the slots now NULLed, a racing netpoll
> poll dereferences NULL rather than reading a stale but mapped page.
>
> The series later adds the adapter->opened gate in
> ibmveth_poll_controller(), the per-queue replenish_lock, and the NULL
> check in ibmveth_update_rx_no_buffer().
>>   
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>>   		if (adapter->rx_buff_pool[0][i].active)

At this commit, nothing does — netpoll can still call
replenish after cleanup has NULLed the buffer list. v7 adds
the NULL return in update_rx_no_buffer() in this patch, so
that read no longer faults. Later patches add replenish_lock
(patch 8) and poll_controller returns if !opened (patch 15).
What is still leftover is netpoll vs free_buffer_pool /
irqsave, for a follow-up after this series.



Thanks,
Mingming


