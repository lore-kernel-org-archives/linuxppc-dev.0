Return-Path: <linuxppc-dev+bounces-28165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB956C98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:16:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgTH1TJ2z2y21;
	Fri, 25 Sep 2026 16:16:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790317011;
	cv=none; b=mKOWSmpj5LVvmHXYoOrWDukxh6ELSaoLn5oov48J9SdVRjXMypJ83NqB1RIiEiPtPVTJPIPP0FpaZ709SwOaRcHP1StDHcYvhPPEj7edeOVeAKg1m7D4dsOcuTfYKTgVmMlzZ9c1p7Y6Mb7tykQM6Nmuiym9eb4SCZhX1RYgkqd2Jq12zZ1b2o1z6mqYEVuEG+1Qe18IGBqia2wmTIEw+fqS0ZhiB2GpfGW3z442RXOB0GCTrQmGl88L4EFwsdkouZhgRkfN7MvDpbzK2Z3sGDI9NSjljFprrnl1Q85RTHdh4jk+q4N2IwnaJpkJK3U3q9Foo5v2sNafwrIuqi+TWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790317011; c=relaxed/relaxed;
	bh=8vc3E8p5jPtV9wYjqawn6mVOqMM++HSenqkDm1npJkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZokCUSLRZqdFWovhz4sT76PVSR98Y9t07wkk7nWzWaoFwHaEdMjxOLRmQDwJSbSbhMLXH3IzhbaTT+EO3iPd88iBLU/2lPNnyiIVMnm0V/zwQkezYq309jmu4I2aPOm3EWXvEonx7HjXJCqrzSd/c/MQAO+/xSUfreDo+bhvvjcPwnpVN7EUkyRAW2lMZiqTnnq5SCkBvm9opbori8Zzgm+b/vxYeMJPmNXA4GuLrH2sL6Lnbw+2TiS4Z3W/ixhAKfj4lbpk3pil6XgJUgh592mDBPWmPJ3LPeVxbMXkNh7MrjBE4vPo2bgK/M9ZCITkLMRFYPX0uJCW/0S90YSdUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S8Ot9ODY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S8Ot9ODY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgTG1H8qz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:16:49 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4Zr5h060832;
	Fri, 25 Sep 2026 06:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8vc3E8
	p5jPtV9wYjqawn6mVOqMM++HSenqkDm1npJkQ=; b=S8Ot9ODY1SKsjvExFtVHEk
	27xwFQmm+NQFo0GITzc9ZdM168sMPSassYlA0fQoANde4EIs5J0PU81Bq6dIOnT/
	Q/1iDRYNj5T3bgYM6hmDIWbgexk3QaLOZr516BJhIuIU7bqJXsoh7D1KzvwOCVqG
	NItiNVCiu21+Nq4TrwIqijPbJfVG45ONZatpGGeSeZoKQaC1mDxslSI8/cufl/yh
	+p37GHtVDGsnoorOvPfZK0Q+bg9lmn8qZa266/Pqcg7+RQTEdEJBpvlWmwwLE8gq
	7NMz1iaULbtkHyFwmQHObvmUbhBIWLeFpjNmDeXPsKTH2GLpmmqGr2P/brA14XrA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsnew6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:16:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lWLe3288196;
	Fri, 25 Sep 2026 06:16:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21adx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:16:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6GaPN32113310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:16:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8761058059;
	Fri, 25 Sep 2026 06:16:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E886658055;
	Fri, 25 Sep 2026 06:16:33 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:16:33 +0000 (GMT)
Message-ID: <1fc63d39-2a1c-4d4d-992c-e8341f3293c0@linux.ibm.com>
Date: Thu, 24 Sep 2026 23:16:33 -0700
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
Subject: Re: [net-next,v6,04/15] ibmveth: Refactor buffer pool management for
 per-queue MQ RX
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <8cec120af540e5e355dd6a1d3a6498dc0a7a98e4.1788102125.git.mmc@linux.ibm.com>
 <178845903273.3394541.7371277620792902309@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845903273.3394541.7371277620792902309@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab611c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=X6C284MIUuzw_x1hKeQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8cx4hVe6Ls4xKi1MkUWEMxAAekblpnZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX2qLOU5Qjz1Gd
 XHzHk2VTAhGvmEUjPPdRSB9OKKixftaqV0RzPQjskwgbTZ5xiZFKwjMLT1pgE5TTNKTBw1CDQZq
 rAz9MUeaSl6stJfPENMJ45yc64ov6XrETBjI6WFT5FFxb4fBUoJtTDjhjoVl15mBlxGmgzSTv+Q
 N38t8ETtCoWayrXoiSrvjR0le1mrP/0aXKEDlU9sMfmVQaB6E6g+ycak9UMmtzZDuSqJvPgFMuj
 GqApZjSgv9/Vz/rpCadTf+Rk+vc0OJPQAoXbBzI/1mC5pu3IXvhf15VswpD4ipqHHkpiQvFQyMp
 KkWeVN0RSmxCXNOGPIWc1m9toc++HtoL7IVj9XwuomvqEkrHDvQAxBXu/VYZBwXKZgBZfJy2oc5
 vWmw4i4EMKcy4uOZSlM5OO4tsc8pNNL9M4/dE/wPkhjIemb9QVL2FsmTLAfzD8NdJOdOrWuf4HQ
 qfRtzmqSGr0wbItLqmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfXz+EBn4prxZfH
 VxjP+P+ac0n9k43IyQ9pnugnJloD2UaL0ybc1VtuK7RW5vzDARRwrHz6Bo0PrjjlcC3+WUbJpyM
 y7vfzzdv3drO/X42qB+PgEgUmacD0mk=
X-Proofpoint-GUID: grKfWMj6NShnrBIG6aj5zZLCKj-gYDds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250024


On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 (1) · Medium: 0 · Low: 2
>
> - [Low] The refactor silently repairs a pre-existing DMA-coherent memory
>    leak in ibmveth_open() without a Fixes: tag.
> - [Low] The err_cleanup comment in ibmveth_alloc_rx_queues()
>    (drivers/net/ethernet/ibm/ibmveth.c:280-285) asserts an invariant the…
>
> Pre-existing issues:
> - [High] In ibmveth_open() at this commit, the new failure branch for
>    ibmveth_alloc_buffer_pools() (`goto out_free_tx_ltb`,…
>
> --
>
> ibmveth: Refactor buffer pool management for per-queue MQ RX
>
> This moves the five RX buffer pools from adapter scope to
> rx_buff_pool[queue][pool] and adds ibmveth_alloc_buffer_pools() /
> ibmveth_free_buffer_pools() plus per-queue helpers, wiring them into
> open() and close(). Queue 0 stays the template for pool geometry and
> activation; runtime is still single-queue.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index d2dad9e6068e0..37a6d13e603ea 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... helper additions snipped ... ]
>
>> @@ -858,16 +996,9 @@ static int ibmveth_open(struct net_device *netdev)
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
> [Severity: High]
>
> This isn't a bug introduced by this patch, but the rewritten jump lands on
> an unwind that frees memory PHYP was just told about, without any
> deregistration hypercall.
>
> At this point ibmveth_register_logical_lan() has already returned
> H_SUCCESS. The chosen label then does:
>
> out_free_tx_ltb:
> 	while (--i >= 0)
> 		ibmveth_free_tx_ltb(adapter, i);
> 	ibmveth_cleanup_rx_resources(adapter);
> out_free_filter_list:
> 	ibmveth_free_filter_list(adapter);
>
> and ibmveth_cleanup_rx_resources() dma_unmap_single()s buffer_list_dma[0],
> free_page()s buffer_list_addr[0] and dma_free_coherent()s
> rx_queue[0].queue_addr, while ibmveth_free_filter_list() releases the
> filter page. Those are exactly the three regions handed to the hypervisor
> by the registration.
>
> The neighbouring request_irq() failure path does the opposite order:
>
> 		do {
> 			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> 		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>
> 		goto out_free_buffer_pools;
>
> Can PHYP write into the buffer-list page after it has gone back to the page
> allocator on the pool-failure path? It stays an independent writer of that
> page for the per-page no-buffer drop count that
> ibmveth_update_rx_no_buffer() reads back.
Yes, PHYP can write that page: the LAN is registered,
no buffers are posted, and this goto frees the buffer
list without h_free. Pre-existing — the old inline pool
loop already jumped to the same labels.

> The same ordering exists in the parent commit, and the rest of this series
> does address it: the later patch that refactors TX resource allocation
> issues h_free_logical_lan() before the RX DMA teardown, and the patch
> adding the RX queue register helpers moves ibmveth_alloc_buffer_pools()
> ahead of registration so this window disappears. Would it be worth
> ordering the pool allocation before registration here instead, so the
> intermediate commits in the series do not carry the window?
The pool-before-register reorder stays out of this
helper extract. Patch 6 ("Refactor TX resource
allocation in open/close paths") issues h_free on that
pool-fail path. Patch 7 ("Add RX queue register helpers
for MQ") then allocates the pools before register, and
every later failure goes through
ibmveth_free_all_queues().
>>   
>>   	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>>   	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>>   			 netdev);
>> @@ -892,11 +1023,7 @@ static int ibmveth_open(struct net_device *netdev)
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
> [Severity: Low]
>
> The commit message describes the repair this hunk performs and then
> declines a tag:
>
>      Pulling the pool loop out has one side effect worth naming: it no
>      longer consumes open()'s loop index, so a pool failure reaches
>      out_free_tx_ltb with i still at real_num_tx_queues and the TX LTBs
>      actually get freed. The shared index that swallowed them was
>      pre-existing, so there is no standalone Fixes: tag;
>
> Should this carry a Fixes: tag for the commit that added out_free_tx_ltb
> and its second walk over the same index?
> Before this patch the old loop at out_free_buffer_pools drove i down to -1,
> so the following while (--i >= 0) at out_free_tx_ltb evaluated -2 and freed
> nothing. Every failed ndo_open after a successful TX LTB allocation
> therefore leaked real_num_tx_queues buffers, one dma_alloc_coherent() of
> adapter->tx_ltb_size each, reachable both from an
> ibmveth_alloc_buffer_pool() failure and from a request_irq() failure.
>
> Without a tag, stable trees keep the leak and the repair is only reachable
> by picking up this refactor.
The helper no longer consuming i is a real side
effect, but a Fixes: off this refactor would not
backport cleanly, and Patch 6 gives TX its own
unwind. That is why the commit message names the
side effect and declines the tag, and I am keeping
that in this 15. After this series lands, a small
standalone for net can carry the Fixes: tag so
stable can take the leak fix without this refactor.
>
> One further note on code this patch does not touch, but which the
> immediately preceding patch in the series added:
>
> [Severity: Low]
>
> Does the err_cleanup comment in ibmveth_alloc_rx_queues() state an
> invariant the function actually holds?
>
> 	/*
> 	 * Every failure path above releases what it had already allocated
> 	 * for queue i, so each index here is either fully constructed or
> 	 * fully empty. Do not unmap buffer_list_dma[] without the matching
> 	 * buffer_list_addr[] check: the two are only ever set together.
> 	 */
>
> The buffer-list mapping failure path leaves rx_queue[i].queue_addr
> allocated:
>
> 		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
> 			...
> 			free_page((unsigned long)adapter->buffer_list_addr[i]);
> 			adapter->buffer_list_addr[i] = NULL;
> 			adapter->buffer_list_dma[i] = 0;
> 			goto err_cleanup;
> 		}
>
> so index i arrives at err_cleanup partially constructed, and it is the
> per-pointer if (adapter->rx_queue[i].queue_addr) check that frees the ring.
> Nothing leaks today, but the first half of the comment contradicts the
> second half. Could the wording be changed to say the cleanup loop frees by
> pointer presence rather than claiming each index is all-or-nothing?
Yes — thanks. v7 already rewords that comment in Patch 3
("Refactor RX resource allocation for MQ RX bring-up").
Cleanup frees by pointer presence. A dma_mapping_error on
queue i can leave queue_addr live after buffer_list_addr is
already NULL. This patch does not touch that helper.

Thanks,
Mingming

