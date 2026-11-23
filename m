Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0026606A32C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MRG10Ou3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXyQN2H8Yz2xGg;
	Mon, 23 Nov 2026 18:35:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795419308;
	cv=none; b=WXdVYQSkpNERCHOrEORcQ4UC9BV4OLWUdx5gxLYB4hhrsd+iE439gbnU6y/bbZPcN0pw0Z6WA6HSlXs9h7QlP466Hwqj2T7ZFgbu6HvyRr42aYcg5/A2aCEMvrNOHK9yFwX1q1kuV80XukH9WTR5m6QNDPiI7TkBcpNBQRSQBRiZkTr24KGK6qCupzVRYR6pM+0ZgUGDe6FoueOjpoYDmoVSaTlkT1rEsbDDRUGr18joVzm5/nSeAfsb0hQNMPu1YSP3RfAe9+Q7TLJ+ucvrP7g/0gkZCNudcr10kavrpZxIfVjz3gVcQV6YZuOyhdC+GIQuSenmEwZusz1b+BFfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795419308; c=relaxed/relaxed;
	bh=2TaN3x6VFwy0CfuNhEPxwMWb7ji2BJBljBenXKvqz5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1ibh4acMq/36cwuwfToEpGqKKvjFSlu8N/KHx7AeoFBFTb8Af7jTL+73IRpdhtOo0iHz7wnKIztYWE8MGX/FeHyFyBHPbhdm1eM+A4Ngif6YGcXZ7jRP24rBNGIhLhVcC7WbBuJPuvLrWNEquaeRPVYtOMf5Ra56eAa34Vo1UiCZzhMNaglGicv905yQp0mdp4VOK+7P363y1OuIjk8Pf6CC2RonLqNEJ/Molkw5bgr+Cxi/N+Ufw5gHoersmoGzfIlzCqe0YZY62mxbUEgxd4T7jDQpS4EzjbaY36W3Ucr9p73NAlkN1VuyHpRm6XFYgJ+mjRn8c9bl2hYDXdWfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MRG10Ou3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MRG10Ou3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXyQM351Vz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:35:07 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54gwD2574275;
	Mon, 23 Nov 2026 07:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2TaN3x
	6VFwy0CfuNhEPxwMWb7ji2BJBljBenXKvqz5s=; b=MRG10Ou3z+CePgFAF7eLoa
	Rf0Pz3Aj4V8/Kp/G30TloVTljSX3VNjp5LQbn2ch18pM+dtiLUEmfaXURk5v8HX0
	ptck39dK1s499PY3aRaSnbIf4GreKZahnnMDeSvxL2UMLaF+61IKh53yH/yhhy0q
	119MlA8HXmnF9e70j4jCs411fiAu5uCvcM9Dmr9hm05sRVDUMbps3bh7l95LtWl/
	eRWCT1KWNs+hztzDhbxG6166ED210Fa3PTopwPx/h5VyLeXJcARTFCS89hXf2AX7
	woUHtPvtX6tCsM/hrCEtjZSspSc1iDptMMcHmXg/qAOLzr9IYfrSdeIio6qSF4tA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv1reb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:34:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54HBS1436388;
	Mon, 23 Nov 2026 07:34:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3raydfb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:34:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7XwEE30081596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:33:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D60458063;
	Mon, 23 Nov 2026 07:34:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47985805A;
	Mon, 23 Nov 2026 07:34:46 +0000 (GMT)
Received: from [9.67.2.38] (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:34:46 +0000 (GMT)
Message-ID: <18121720-661e-4418-8fab-156092188b99@linux.ibm.com>
Date: Sun, 22 Nov 2026 23:34:46 -0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] ibmveth: Refactor TX resource allocation in
 open/close paths
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20261119000711.18093-6-mmc@linux.ibm.com>
 <179539596966.3135.308887197140765933@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179539596966.3135.308887197140765933@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b03ec9c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=2THoilGFPddiCwSmGqsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX2C+MSY7TnEct
 qKWYiLZYL7TLDpi2KsbH8OQ5qBWToBEw+gRL9T1liLERPnQ44pbOIOvW0jX/ZGgb4IAduZ9NEFd
 /Nh2+bMbhHcdTn1nT1IkBDPVGKbC7qQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX0w/x3p9oH38X
 ZtPOVXZPLfsC4VmpxLvWXVjIk8NBBivl+Dzw/hs+8nrUnh3Uj6kjdBAxN6W30EfiZ7IPe3jVRki
 FVIPxfyNS4trW7n62skMxuOunSq0hQ7Jxa/JeGGRnvO23DspeSDpxZ2QNXf8VFhB2WWbOm4oq6p
 ZOlUus7gHDYpvH0jE3siZwyS/lrETgawYndyp23uGsFpHeadhHzmMz39RPBnKfnKiGnwhfw3eVq
 B3hPLH/oy051djTxADCQ9qdUaUuK0wiBmkneW/YobXlqSGkXDAxx1y3JaXNpVJnTNn0mNSphJrU
 13BT9Uy1pKzOG2IpG3/hhHo91sizUc/3ieTIJXDTyGyqXIUAAfBcX21dxYER/ZFHExVCT184h5W
 kDIEOhwqP4UyLVDlRo2jliuYt83GIGhnViVrwmmmQGLnPVLYYqqIUFwognv5AvvJZjEVpo8fYBv
 6XVF1JG2KGHlDhfDiNg==
X-Proofpoint-ORIG-GUID: qWFxOOFQL-U11IJ3EEE1hlZRZEji-uTB
X-Proofpoint-GUID: vy61zn7oBSz_humx_GU5B586kYZM77Vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230030
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/22/26 5:06 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] In ibmveth_open() (drivers/net/ethernet/ibm/ibmveth.c), this
>    patch moves the TX long-term-buffer DMA mapping…
> - [Low] The commit is titled and framed as a refactor ("Move TX LTB
>    allocation and free ... into ibmveth_alloc_tx_resources() and…
>
> --
>
> ibmveth: Refactor TX resource allocation in open/close paths
>
> This moves TX long-term buffer allocation and free into the new helpers
> ibmveth_alloc_tx_resources() and ibmveth_free_tx_resources(). It also
> moves the TX LTB allocation in ibmveth_open() to after RX and NAPI are
> running. To cover that, it adds netif_tx_disable() at the start of open()
> and starts the queues under netif_tx_lock_bh().
>
> [Severity: Medium]
> With the new order, can open() fail on CMO partitions where the old order
> worked?
>
> With FW_FEATURE_CMO, every VIO DMA mapping draws on the device's IO
> entitlement through vio_dma_iommu_map_phys()->vio_cmo_alloc(). That call
> returns -ENOMEM when the free reserve plus the excess pool is smaller than
> the request.
>
> By the time ibmveth_alloc_tx_resources() runs, NAPI is enabled and
> ibmveth_schedule_rx_queue(adapter, 0) has scheduled the first replenish.
> The replenish runs in NET_RX softirq, either in ksoftirqd or at the next
> IRQ exit. It can map and post every RX pool buffer before or while the TX
> LTBs are mapped:
>
> ibmveth_open()
>    ibmveth_setup_rx_interrupts()
>    ibmveth_schedule_rx_queue()
>      __napi_schedule()
>        ibmveth_poll()
>          ibmveth_replenish_task()
>            dma_map_single()      <- per RX buffer, uses entitlement
>    ibmveth_alloc_tx_resources()
>      ibmveth_allocate_tx_ltb()
>        dma_map_single()          <- can now return DMA_MAPPING_ERROR
>
> The two failures are handled differently. An RX mapping failure in
> ibmveth_replenish_buffer_pool() bumps replenish_add_buff_failure and
> breaks out of the loop.
>
> A TX LTB mapping failure makes ibmveth_alloc_tx_resources() return
> -ENOMEM. open() then tears down the IRQs, the logical LAN registration and
> the RX pools, and the interface does not come up.
>
> The direct close()/open() pairs (change_mtu, pool sysfs, set_csum and
> set_tso) are affected too. There, IFF_UP stays set but the adapter is not
> open.
>
> Before this patch, the TX LTBs were mapped before any RX buffer went to
> PHYP, so TX always got entitlement first.
>
> ibmveth_get_desired_dma() seems to make this more likely:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_get_desired_dma() {
>      ...
> 	/* add size of mapped tx buffers */
> 	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
>      ...
> }
>
> This counts one 64K TX buffer, but open() maps one LTB per real TX queue.
> The default is min(num_online_cpus(), 8) queues, so up to 512K. Once RX
> has taken its share, is there any entitlement left for TX?
>
> The order is the same at the end of the series. In "ibmveth: Split RX
> poll into per-slot helpers for MQ", ibmveth_alloc_tx_resources() still
> comes after ibmveth_schedule_rx_queue().


You are right, the reorder isn't needed. v2 maps TX before RX buffers go to
PHYP again.

The get_desired_dma() undercount predates this series; I'll look at it
separately. The other Lows are fixed in v2 as well.

pw-bot: cr
Thanks,
Mingming

>> +
>> +	/* Start under the xmit lock so a sender that tests DRV_XOFF
>> +	 * there sees the LTBs this open just published.
>> +	 */
>> +	netif_tx_lock_bh(netdev);
>>   	netif_tx_start_all_queues(netdev);
>> +	netif_tx_unlock_bh(netdev);
> [ ... ]
>

