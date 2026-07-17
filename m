Return-Path: <linuxppc-dev+bounces-24326-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152E1C44512
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 00:53:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1WcG2HcPz2yRl;
	Fri, 17 Jul 2026 10:53:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784249598;
	cv=none; b=hLHPTZrUJoD+ox0gf1CyvvqCGWOlG/umkXsVzFofA/OjzPoceTaXAwrxNVpPFvxxmel7qkeD+lY4q+rB8IKeuEdZzLrfT1J39DL0M8sEG3VZ+lI44c0hreSo7JBSjrZxqG25N7/F2gZIJmw/5hA8Z7FE3dG8i3CoUEXx80ZZEbbNa4+MAEPPIP76rop5e6KIz45/91ZBQsUjqbwkgfHdXmR2z84I/ELPoTNXmAr9oFaj+Gz4hkKhXr20H2WsG5My10Kn/3xeVT5peYKDvWcbZHRxseTfW2tpFShxkCUzYZuXKUHQ+OzcJO6lwpukGAV0mkRBDsaxZcoyuwfeS/2m/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784249598; c=relaxed/relaxed;
	bh=C+YwasLxyvtU+4Kha6D3NxqJK6E85iK3nNko02JaWpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEEUM3iqsPIJUYZ9GQNXzboszlR9HDoxqB1QO/FGayAMr3jcHnHitJRIF7RZNs2tJmYDvac/alUURihbn/Kn7dG0JLjB5BgZ+Tb4t16T9Y61MiJB5EVaKznajJRrEE0QjBogoY85C2ggrz27bB68bG/4TfZMu2jLgrc7a9AqFpxdYmfq6NR/GYs6G/j/7M2ytKMg3Zuat0jaSs0N16QFP2w0OAFM2RaH3LEZ0Ug/tUOfAVQkZiIq4fZ7o1iuUFUpRTnfRrs8KmiQ3FECgSUC+M4V5n1vwQQzvCDKdpBtqjZofJl9A3u+VsXECdFCfRY0QdNSO6lgSHvQAmXPLeVK8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qr7bd0oI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qr7bd0oI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1WcF3rCQz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 10:53:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNgJo6429166;
	Fri, 17 Jul 2026 00:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C+Ywas
	LxyvtU+4Kha6D3NxqJK6E85iK3nNko02JaWpk=; b=Qr7bd0oIwMQCmSh8g+aJ57
	V3AVfr+BqLY4SJcljOVthWXUKcyap9Q7PoLW+ZUj082QRFGitl67iSvZ2E+dCuPT
	b2HeDEk9uPy65NMYwIgPxakfgHhBSCa/JvHDcMGncGbYLkhWV3ioHU5tqVMEUb56
	NX9ETlrRE+mKwgJUqVphXM4me1Nqpu2B3+O1OO9wO/8qjyjbaAAw+mH1Ll1MHLU9
	d4l5i3N6j/XxCVnhzdB63ZmkVLNUpPRyiDzfMJCEhFF2Lmu8lF0n4wViDy78cR9T
	rFXzpKXLRH5jom36/mV4EArhmbH8SK4+nLQST2eR60cMKM0iakiDaYYnYX5zLjpA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc303t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:53:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H0nmL9026499;
	Fri, 17 Jul 2026 00:53:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyf7ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:53:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H0qQD719006028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 00:52:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5D8D58055;
	Fri, 17 Jul 2026 00:53:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8731D5804B;
	Fri, 17 Jul 2026 00:53:00 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 00:53:00 +0000 (GMT)
Message-ID: <7262cceb-2e91-4107-8c24-d5a6b6c4281f@linux.ibm.com>
Date: Thu, 16 Jul 2026 17:53:00 -0700
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
Subject: Re: [PATCH net-next v3 08/15] ibmveth: Refactor open/close into
 MQ-ready resource pipeline
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, Dave Marquardt <davemarq@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
 <20260706193603.8039-9-mmc@linux.ibm.com>
 <20260714124736.GK1364329@horms.kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714124736.GK1364329@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a597cf0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=kw0fJWjWycK_0JI3rWYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=H1KAiuew1PUbUSSU8qhj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMyBTYWx0ZWRfX/lawfimWeup0
 PpDczANguxrKQ8Dtv2F9olidSEN3l75Jk8qAQ6mocmesCJ4KIHOs0Tv2cjdDlpykJUpmwtgHXSp
 9EbkBEq3oOXjbkQOHahLRXmbAutdiV9crLid3lu6oyJT0BZO+4+G4Z9EAoYEon9VHOtJXPuUeFt
 VoBzhUPIA7nPdOFoGL3ecwznjsRvd0Ph2RpLlPpLhy6T8DlmwcCdwNJ2Z7QVk7bz+8OUI4LksSm
 M78xKdFWejwGWrkZNddkm0hOnllVNdSRrRH5NxD6vikAIqCZwRtGKMwskJOPfj1fOQr/SiIanLY
 3K16hmFPjUmghWWb2ycwvKI08SXyPS/hiMqoivrH8raX66UgotqTiwja8Z4vU36kV0TB+UYqaPH
 kIA/UO1D9D5FRf37+0Jb2Q2uZtUipx3PMZlPNsdIPeGqjrPj/Wb65MfmTDu2nnly5nbTg/aDf1A
 pGIiy5qVEXeL91gVeow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMyBTYWx0ZWRfX1L4pVHdwsGe3
 a4tjTI2fXFdH1lxBYi8iUIc/2S41O0+eES+2jC49RnKeEcQZrTD6KpaXtcFb0feEMbm5RBlPUOi
 9Pw/CHCL0soolgyE++QFDuVcazKOLC4=
X-Proofpoint-GUID: MiCOPFzN1ZnRy_b2U4ZVCbo9d67ivL-C
X-Proofpoint-ORIG-GUID: BLOf8-U4N7qSNPTawTtFpQq7_uzWG2WH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170003

On 7/14/26 5:47 AM, Simon Horman wrote:

> On Mon, Jul 06, 2026 at 12:35:56PM -0700, Mingming Cao wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> ...
*

Hi, Simon


Thanks for the careful read on open/close — these were all fair points.

*
>>   /**
>>    * ibmveth_register_logical_lan_queue - Register subordinate queue with hypervisor
>>    * @adapter: ibmveth adapter structure
>> @@ -1466,208 +1479,108 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
>>   static int ibmveth_open(struct net_device *netdev)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> -	u64 mac_address;
>> +	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
>>   	int rxq_entries = 1;
>> -	unsigned long lpar_rc;
>>   	int rc;
>> -	union ibmveth_buf_desc rxq_desc;
>>   	int i;
>> -	struct device *dev;
>>   
>>   	netdev_dbg(netdev, "open starting\n");
>>   
>> -	napi_enable(&adapter->napi[0]);
>> -
>> -	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>>   		rxq_entries += adapter->rx_buff_pool[0][i].size;
>>   
>> -	rc = -ENOMEM;
>> -	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
>> -	if (!adapter->buffer_list_addr[0]) {
>> -		netdev_err(netdev, "unable to allocate list pages\n");
>> +	rc = ibmveth_alloc_rx_qstats(adapter);
>> +	if (rc)
>>   		goto out;
>> -	}
>>   
>> -	adapter->filter_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
>> -	if (!adapter->filter_list_addr) {
>> -		netdev_err(netdev, "unable to allocate filter pages\n");
>> -		goto out_free_buffer_list;
>> -	}
>> -
>> -	dev = &adapter->vdev->dev;
>> +	rc = ibmveth_alloc_filter_list(adapter);
>> +	if (rc)
>> +		goto out_free_rx_qstats;
>>   
>> -	adapter->rx_queue[0].queue_len = sizeof(struct ibmveth_rx_q_entry) *
>> -						rxq_entries;
>> -	adapter->rx_queue[0].queue_addr =
>> -		dma_alloc_coherent(dev, adapter->rx_queue[0].queue_len,
>> -				   &adapter->rx_queue[0].queue_dma, GFP_KERNEL);
>> -	if (!adapter->rx_queue[0].queue_addr)
>> +	rc = ibmveth_alloc_rx_queues(adapter, rxq_entries);
>> +	if (rc)
>>   		goto out_free_filter_list;
>>   
>> -	adapter->buffer_list_dma[0] = dma_map_single(dev,
>> -						     adapter->buffer_list_addr[0],
>> -						     4096, DMA_BIDIRECTIONAL);
>> -	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
>> -		netdev_err(netdev, "unable to map buffer list pages\n");
>> +	rc = ibmveth_alloc_buffer_pools(adapter);
>> +	if (rc)
>>   		goto out_free_queue_mem;
>> -	}
>>   
>> -	adapter->filter_list_dma = dma_map_single(dev,
>> -			adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
>> -	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
>> -		netdev_err(netdev, "unable to map filter list pages\n");
>> -		goto out_unmap_buffer_list;
>> -	}
>> +	rc = ibmveth_register_rx_queues(adapter, mac_address);
>> +	if (rc)
>> +		goto out_free_buffer_pools;
>>   
>> -	for (i = 0; i < netdev->real_num_tx_queues; i++) {
>> -		if (ibmveth_allocate_tx_ltb(adapter, i))
>> -			goto out_free_tx_ltb;
>> +	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
>> +	if (rc) {
>> +		netdev_err(netdev, "failed to set number of rx queues\n");
>> +		goto out_unregister_queues;
>>   	}
>>   
>> -	adapter->rx_queue[0].index = 0;
>> -	adapter->rx_queue[0].num_slots = rxq_entries;
>> -	adapter->rx_queue[0].toggle = 1;
>> -
>> -	mac_address = ether_addr_to_u64(netdev->dev_addr);
>> -
>> -	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
>> -					adapter->rx_queue[0].queue_len;
>> -	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
>> -
>> -	netdev_dbg(netdev, "buffer list @ 0x%p\n", adapter->buffer_list_addr[0]);
>> -	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
>> -	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue[0].queue_addr);
>> -
>> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
>> -
>> -	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
>> -
>> -	if (lpar_rc != H_SUCCESS) {
>> -		netdev_err(netdev, "h_register_logical_lan failed with %ld\n",
>> -			   lpar_rc);
>> -		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
>> -			   "desc:0x%llx MAC:0x%llx\n",
>> -				     adapter->buffer_list_dma[0],
>> -				     adapter->filter_list_dma,
>> -				     rxq_desc.desc,
>> -				     mac_address);
>> -		rc = -ENONET;
>> -		goto out_unmap_filter_list;
>> -	}
>> +	rc = ibmveth_setup_rx_interrupts(adapter);
>> +	if (rc)
>> +		goto out_unregister_queues;
>>   
>> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> -		if (!adapter->rx_buff_pool[0][i].active)
>> -			continue;
>> -		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
>> -			netdev_err(netdev, "unable to alloc pool\n");
>> -			adapter->rx_buff_pool[0][i].active = 0;
>> -			rc = -ENOMEM;
>> -			goto out_free_buffer_pools;
>> +	if (adapter->num_rx_queues > 1) {
>> +		for (i = 0; i < adapter->num_rx_queues; i++) {
>> +			netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
>> +			ibmveth_replenish_task(adapter, i);
> ibmveth_replenish_task() only has one parameter
> until a later patch in this series.
*

Agreed. Will address this In v4.

the multi-arg replenish call moves to the patch that introduces

the queue-index parameter (or that patch lands

before this open() wiring).

*
>>   		}
>> +	} else {
>> +		netdev_dbg(netdev, "initial replenish cycle\n");
>> +		ibmveth_interrupt(adapter->queue_irq[0], &adapter->napi[0]);
>>   	}
>>   
>> -	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>> -	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>> -			 netdev);
>> -	if (rc != 0) {
>> -		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
>> -			   netdev->irq, rc);
>> -		do {
>> -			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> -		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> -
>> -		goto out_free_buffer_pools;
>> -	}
>> -
>> -	rc = -ENOMEM;
>> -
>> -	netdev_dbg(netdev, "initial replenish cycle\n");
>> -	ibmveth_interrupt(netdev->irq, netdev);
>> +	rc = ibmveth_alloc_tx_resources(adapter);
>> +	if (rc)
>> +		goto out_cleanup_rx_interrupts;
>>   
>>   	netif_tx_start_all_queues(netdev);
>>   
>>   	netdev_dbg(netdev, "open complete\n");
>> -
>>   	return 0;
>>   
>> +out_cleanup_rx_interrupts:
>> +	ibmveth_cleanup_rx_interrupts(adapter);
>> +out_free_tx_resources:
>> +	ibmveth_free_tx_resources(adapter);
> The out_free_tx_resources label is unused until a later patch of this
> series, so it should be added in that patch rather than this one.
*

Agreed — will introduce out_free_tx_resources only when a caller

needs that jump target.

*
>
> And it's not clear to me that ibmveth_free_tx_resources() should
> be called when jumping to out_cleanup_rx_interrupts as
> in that case ibmveth_alloc_tx_resources() hasn't run successfully.
>
> The AI-generated review on sashiko.dev also highlights the error handling
> here:
>
>   "Are the unwind labels ordered incorrectly here?
>
>   "If ibmveth_setup_rx_interrupts() fails, it jumps to
>    out_unregister_queues, which is placed after out_free_buffer_pools. Does
>    this mean we skip freeing the buffer pools and leak memory?
*

Yes — those gotos currently skip free_buffer_pools(). Will fix

unwind ordering in v4 so buffer pools are always released.

*

>
>   "Also, if ibmveth_alloc_tx_resources() fails, it internally frees
>    partially allocated LTBs. It then jumps to out_cleanup_rx_interrupts and
>    falls through to out_free_tx_resources. Because ibmveth_free_tx_ltb()
>    calls dma_unmap_single() unconditionally without checking or zeroing
>    tx_ltb_dma, will this cause a double free and an invalid DMA unmap?

**

*Correct — on alloc_tx_resources() failure TX is already partially*

*

cleaned inside the helper, so falling through to

free_tx_resources() is wrong and can double-unmap. Will fix the

open() unwind graph in v4.

*

>
>   "Finally, in the fall-through path from out_cleanup_rx_interrupts,
>    out_free_buffer_pools is executed before out_unregister_queues (which
>    calls ibmveth_free_all_queues() to unregister the logical LAN). Does this
>    free and unmap the RX buffers while the hypervisor's logical LAN is still
>    active, potentially allowing the hypervisor to DMA incoming packets into
>    freed memory?
>
**

*Agreed — freeing RX pools before h_free_logical_lan() is unsafe.*

*

v4 will unregister/free the logical LAN before releasing buffer

pools on both open failure and close

**

*Thanks,*

*

Mingming

*

*

>>   out_free_buffer_pools:
>> -	while (--i >= 0) {
>> -		if (adapter->rx_buff_pool[0][i].active)
>> -			ibmveth_free_buffer_pool(adapter,
>> -						 &adapter->rx_buff_pool[0][i]);
>> -	}
>> -out_unmap_filter_list:
>> -	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
>> -			 DMA_BIDIRECTIONAL);
>> -
>> -out_free_tx_ltb:
>> -	while (--i >= 0) {
>> -		ibmveth_free_tx_ltb(adapter, i);
>> -	}
>> -
>> -out_unmap_buffer_list:
>> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
>> -			 DMA_BIDIRECTIONAL);
>> +	ibmveth_free_buffer_pools(adapter);
>> +out_unregister_queues:
>> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
>> +	ibmveth_free_all_queues(adapter);
>>   out_free_queue_mem:
>> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
>> -			  adapter->rx_queue[0].queue_addr,
>> -			  adapter->rx_queue[0].queue_dma);
>> +	ibmveth_cleanup_rx_resources(adapter);
>>   out_free_filter_list:
>> -	free_page((unsigned long)adapter->filter_list_addr);
>> -out_free_buffer_list:
>> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
>> +	ibmveth_free_filter_list(adapter);
>> +out_free_rx_qstats:
>> +	ibmveth_free_rx_qstats(adapter);
>>   out:
>> -	napi_disable(&adapter->napi[0]);
>>   	return rc;
>>   }
> ...

