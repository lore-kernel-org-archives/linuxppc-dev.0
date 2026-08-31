Return-Path: <linuxppc-dev+bounces-26319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB3FC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 18:03:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYcLb209Mz2y2f;
	Tue, 01 Sep 2026 04:03:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788199431;
	cv=none; b=nAVjrvha+wGQnW0bEPdpvz8dfVq4tvm8U0NAKkDUg5o9RLo5D4S77DHBrjTpvAzjuuKQws2yg00nTx2OIkMwNoQLLMM9TNIi5vAVGmb8hXMWFlnDUIM3sP3V46rkO5/2GnKepvfvtr4E9YfLOV82NRdgjx3m0JkM6dL7oYu2CQ7Y3n8cntawqFCYgwhoQLod4udcpbAI3AyjelonYQqGQoLhwXbY9A+c7xfwLUAo2/ZSMx24upQb2SQ8JM6IoAjtENUdAFFs3oDRC5xWX9jsF2ignTBpXMLZcxGdTQ/fcKSVU156UJV5VXjc+/fzZMYCBgy5akn+Ee9CkbzUnFcFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788199431; c=relaxed/relaxed;
	bh=TNKG5yXCiGBtAfrQMq+oIh2uD0QZ+Kp5mEN6GcktyAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcX+008I3jDTTjw19bzSTy3XLr8OGsSljepmR7ZC8RI1LEJvOCIyGVIa4Rp9OLY1bgsEOmDRGNl9+3TpwDdJ9afgTATvXpOsQkhV7s0oaIFTL+npR1SRR5o/eg7rLxxGr0loJas2jp9z79PI8yIEYyWfgzMT9wpg2HbT/PlhL7hRRiYTtguGtosuZhNg4TegJzM3hRaS8OPrM1WUpfpXgUQcdVUjmJS59Pk4REF7VZftaeP9I+2skZ7Q+NIruR3APIT0c/ij8K+oltL1EHdc5uaN5nigdSZOhnav68C7Rj0YXVt90QVccjaA7ilOdHqCY/7eJ9/MGfJ8WG3OKS4Fnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iophY4wb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iophY4wb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYcLZ3l8Bz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 04:03:50 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1ZYe871285;
	Mon, 31 Aug 2026 18:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TNKG5y
	XCiGBtAfrQMq+oIh2uD0QZ+Kp5mEN6GcktyAg=; b=iophY4wbnmPxTv02nSYyqj
	6lVs0ag6Jeu3xZdYC9eBSH5WkNHHtKE8g/q7FvuKtHp6lmA407SW5Btn3QB83Bmi
	SHc9E1Fw62zYjjRcWHKLI9JrBre/LUZfm5OKP3dWGisItVBlEKWsQzumRTBW9JSI
	jMF6aBx+Wr4GEOxkpp70/ypnjiUlRZEWfle5JSrCkjHdiqZThfynBLyOuSL0Hn2d
	hOlkQIF82VlbE6tlWtayHF6oWP7ctbLvsakQKx7yvHGCeIjYKbaWMLtkMk2ywGWL
	AD6JpAD3YnL9LUsmsKvQVW+G4XAwt67wTEyL/gm6Cys56tV//BV91UD/fiaQWOdw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r30m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:03:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHuK9Q030184;
	Mon, 31 Aug 2026 18:03:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjybxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:03:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VI2sWP3539558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 18:02:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16BC95805C;
	Mon, 31 Aug 2026 18:03:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2320E58051;
	Mon, 31 Aug 2026 18:03:32 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 18:03:31 +0000 (GMT)
Message-ID: <5c875704-7dbd-494a-bac7-23ced0470b5e@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:03:31 -0700
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
Subject: Re: [PATCH net-next v5 02/15] ibmveth: Prepare MQ RX adapter data
 structures
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-3-mmc@linux.ibm.com>
 <20260818014717.3853945-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014717.3853945-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95c1fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=4HcSeIbklPDiGVuuh-cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX0sa83CjK4MJN
 v/s5emdQ1k6s4lX1OVnRzqOflcpwBR8TcLQezzmH1HKP5jRU0XfvMcrb4JDeqVMQ9zeBSBdv2m/
 KbMg2EzRAcTgZaVxIvYH0cccNe/ry9BMx6ubT6Ry53xZt3GR9RDNt7ky4Tx58RP5DPqJv1KwTjt
 IykIdUJ62eXv8XJPxTBEBrWM17RLWtgX0F7+BP3igB4L27BcjuSAUR2ommCFT9lXe7QNZUwzW4d
 +Ly5eR1sirYBc+qWsWgf8kDph8Y7pxgziiyJtyjrSxX5mBMAOI7gVzRnYCLtnd0dhv71oQdaa0K
 d66ITe7udpIdw1l3A/Gtlcgbitps3XxHa3T0eK4iQ50F4E5O9ilGgPcDnuJC6+RZfVEZroaStkj
 uJug3J282YLyqoh6AdZsVX9YXYfnHUelZ2/mZ+3OSDhV8CUAEqMhm7UhH3AKM7FESoXsHZsxymH
 nEIyiUd5/+4s5zJxcHQ==
X-Proofpoint-GUID: GcGy7p_QZBz8yyrjB1rGJy-J9IsKmgKH
X-Proofpoint-ORIG-GUID: kJIo2ahoSdazUY79CNHLnaVToZyVYFK5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX+VOP7URpxY5O
 BhAkVc1qqMm1XIS++7eAKqVomt2IZUoL9hSDd8eJ9jhkfVPKJvyxTZRQjKauuixNp8atRGYvWym
 vqrlqLKsKsahXb0MC3FHloIYyYZ11dA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310156


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Prepare MQ RX adapter data structures
>
> This converts the single-instance RX state in struct ibmveth_adapter (napi,
> buffer_list_addr/dma, rx_queue, rx_buff_pool) into queue-indexed arrays sized
> by a new IBMVETH_MAX_RX_QUEUES, and adds queue_handle[]/queue_irq[] plus
> multi_queue/num_rx_queues bookkeeping. All existing references are
> mechanically retargeted to index 0, and IBMVETH_MAX_RX_QUEUES is kept at 1 so
> behaviour is unchanged.
>
> No Link: tags are present in the commit header.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 73e051d26b9d8..7cb828b476c1b 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -482,24 +486,24 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>>   
>>   	mb();
>>   
>> -	atomic_dec(&(adapter->rx_buff_pool[pool].available));
>> +	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
>>   
>>   	return 0;
>>   }
> [Severity: Low]
> This isn't a bug, but the v5 change notes below the --- separator say the
> "extra atomic_dec parentheses" nit from v4 was dropped, and that "this tip
> patch keeps only the mechanical [0] retargeting".
>
> The atomic_dec() in ibmveth_remove_buffer_from_pool() still drops the
> redundant inner parentheses that the baseline had:
>
> 	-	atomic_dec(&(adapter->rx_buff_pool[pool].available));
> 	+	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
>
> Should the changelog be adjusted, or the parentheses kept as-is so the hunk
> really is index-only?

The hunk is the [0] retarget plus dropping those parentheses. Keeping them
fails checkpatch --strict (Unnecessary parentheses) because the retarget
rewrites the line.

>
> [ ... ]
>
>> @@ -1876,6 +1886,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		netdev->features |= NETIF_F_FRAGLIST;
>>   	}
>>   
>> +	/* Initialize queue count - always 1 for now */
>> +	adapter->multi_queue = 0;
>> +	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
>> +
> [Severity: Low]
> At this commit these two assignments in ibmveth_probe() are the only accesses
> to multi_queue and num_rx_queues, and queue_handle[]/queue_irq[] have neither
> a reader nor a writer anywhere in the driver.
>
> Combined with IBMVETH_MAX_RX_QUEUES being 1U, every array conversion in this
> patch is a pure layout change with no behavioural effect.
>
> Is it worth mentioning in the commit message which later patch first consumes
> each of these fields? Reading the rest of the series, queue_irq[] and
> queue_handle[] get their first users in ibmveth_toggle_irq() and
> ibmveth_register_logical_lan_queue(), num_rx_queues is read through
> ibmveth_get_num_rx_queues(), and IBMVETH_MAX_RX_QUEUES becomes 16U in
> "ibmveth: Enable multi-queue RX receive path", so nothing is broken here.
ch of these fields? Reading the rest of the series,
 > queue_irq[] and queue_handle[] get their first users in
 > ibmveth_toggle_irq() and ibmveth_register_logical_lan_queue(),
 > num_rx_queues is read through ibmveth_get_num_rx_queues(), and
 > IBMVETH_MAX_RX_QUEUES becomes 16U in "ibmveth: Enable multi-queue RX
 > receive path", so nothing is broken here.

Yes. v6 names the first consumer of each field. Three of those are
earlier than the map you sketched:

   num_rx_queues      RX resource-allocation patch
   queue_irq[]             IRQ control patch (ibmveth_toggle_irq)
   multi_queue           IRQ control patch (ibmveth_setup_rx_interrupts)
   queue_handle[]       register-helpers patch, from
                                 H_REGISTER_LOGICAL_LAN (queue 0), not
                                 H_REG_LOGICAL_LAN_QUEUE

>>   	if (ret == H_SUCCESS &&
>>   	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
>>   		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
>> @@ -1898,10 +1912,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
>>   
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> -		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
>> +		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
>>   		int error;
>>   
>> -		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
>> +		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>>   					 pool_count[i], pool_size[i],
>>   					 pool_active[i]);
>>   		error = kobject_init_and_add(kobj, &ktype_veth_pool,
> [Severity: Low]
> This is a pre-existing issue and is not introduced by this patch, which only
> rewrites rx_buff_pool[i] to rx_buff_pool[0][i] on these lines.
>
> The kobjects registered here live inside netdev_priv() memory, and the probe
> failure paths after this loop call free_netdev() without a matching
> kobject_del()/kobject_put():
>
> 	rc = register_netdev(netdev);
> 	if (rc) {
> 		free_netdev(netdev);
> 		return rc;
> 	}
>
> The only teardown loop is in ibmveth_remove():
>
> 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>
> which a failed probe never reaches, so a netif_set_real_num_tx_queues() or
> register_netdev() failure leaves live .../poolN sysfs directories backed by
> freed storage.
>
> Worth noting this is addressed later in the same series: "ibmveth: Enable
> multi-queue RX receive path" adds ibmveth_probe_cleanup(), which calls
> ibmveth_put_pool_kobjs() before free_netdev() on both probe failure paths.
>
> [ ... ]
Yes. v6 notes that the leak predates this [0] retarget. Inline
kobject_put on register failure starts in the MQ enablement patch;
ibmveth_probe_cleanup() replaces it in the statistics patch.

>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index c0ef03cad9b9a..fc6a01e810c6e 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -257,6 +257,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
>>   #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
>>   #define IBMVETH_MAX_QUEUES 16U
>>   #define IBMVETH_DEFAULT_QUEUES 8U
>> +#define IBMVETH_MAX_RX_QUEUES 1U
>> +#define IBMVETH_DEFAULT_RX_QUEUES 1U
>>   #define IBMVETH_MAX_RX_PER_HCALL 8U
> [ ... ]
>
>> +	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
>> +	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
>> +	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
>> +	int multi_queue;
>> +	unsigned int num_rx_queues;
> [ ... ]

