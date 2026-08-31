Return-Path: <linuxppc-dev+bounces-26324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9078C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 18:55:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYdV21Bchz2y2f;
	Tue, 01 Sep 2026 04:55:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788202522;
	cv=none; b=nidD34PbCrs1fCTJ/4NiCCexIgwacU4p7j5NtFu9pCmIHjFeUq7kIYG/S7k3v+XarXrV1TAHwvFGuGcuDiEEGxkNJj89+s4xIS5y5OI1LDxEHvm7OiKecIpvwQfjcKkQE7/1dxyg5Bvonz7EFQdZ0pmMKSDqcsiCvlcpqS/9rs8vLu6/XQh5ElPeCiltP+A5j/q0pp7DSxnpvCUtHb+k2cLZ86CIuIrwNrOgUWuLTbCFslODretKiGlUIpmvXCorQlh9Kj5Ub1ct7i8X9P25rbzlx1OT1PVYr+NYHT+MnKWOi6i9LvDkWEB0oVpy8aWfEpjN+QYx40uIYqLxd4B9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788202522; c=relaxed/relaxed;
	bh=koEfcFHEACRK6I5+dpP57zCBhpJfNerChyC3dMBDb5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEzJblMH9lRbuvDQ5MELRT2HxfR9JqU6nKh7/SkpzHsSu5XIrXyUV3hFw44n13M0eC2hi5aJmjaH09fSf1t3Zfjt4G7+Tq9K9hCb3VJomAyKrwLivMz+O7TbdaP4niY637xuF7KNGqQIu9UKbRXiqdnlSdO9uV8P5Fy7v6sacpfcVuEZzSk8rTQFiJmjk37/2k/FTKsri953vCpWUWo5Zrk+/HcRHD6dT69ghB3VAfcjU8C6v6X5d+gbPZeBaZ807RUExOxX4bZr+IT6bFy95sSAuyeFeVwrheDpjeP0LSKq8mFzBphikxubVw4/zYLmzr46Kg/dFzhqnwQqkn6+Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dQ377ESf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dQ377ESf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYdV11V8mz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 04:55:20 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVUog1234641;
	Mon, 31 Aug 2026 18:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=koEfcF
	HEACRK6I5+dpP57zCBhpJfNerChyC3dMBDb5k=; b=dQ377ESfxsj7ZjMIfXkBOk
	hs1feSluucSjn959WNV/+an8MEZBWyhoCoIt4/EyrzHfoJJPGdqE/VZLfxT//m0e
	8sOgkdkTK3an+yjjh4siW/oz4yMGL0huscBWUI8mHZ07b5+/6V6n7/L7zfSqO7cu
	KDEtrxnxHGSWE5uHj8uz48G4HeufvBaNm0gu2UiVYydDqDcyS9L0ePoNeOJRwxS4
	oNdhontCecd2re4TWaMGXWnFWXxNJWojI8g/zryOyWjj7/0xShsYfjTTxrfTbV2N
	aJUYSBa5Iia1OldIjZWbTUV9ENySDuHonvx2bGLjX9rWjWb6Kvv4NZxJ/EkC7tmg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r37p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:55:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIfHfm000506;
	Mon, 31 Aug 2026 18:55:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq7q7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:55:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VIt3sG53871096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 18:55:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F95158060;
	Mon, 31 Aug 2026 18:55:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7439058051;
	Mon, 31 Aug 2026 18:55:00 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 18:55:00 +0000 (GMT)
Message-ID: <8def7a5e-60b1-4309-a431-52b2d82c9377@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:54:59 -0700
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
Subject: Re: [PATCH net-next v5 07/15] ibmveth: Add RX queue register helpers
 for MQ
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-8-mmc@linux.ibm.com>
 <20260818014726.3854123-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014726.3854123-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95ce0f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=MCFLVD4pVMjOk_SXI_MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX+pYSaYFcWxhK
 qGximPXt1gBti143VC1sMsQfjMl2gZ889a10bJgfn3bQINvyFonZPgCCn0ateA2Fhzh41lUdw23
 ODE+GA1sF4vAxjf6hgeQLeizosqRXhif6+PRyBQLmW/RKwwFdXsIycrSkJGUZYjeYd8AA7wd3UE
 WBdfzW+c+3lsi10TaEWON5Rvq1x17qjQGgjlNzaP1evsfpWRPcNzklJwzBiHEn9LMUFCw4ZlYTk
 Io/o8vGNWo5RTZ3DVs9U3H+7X8bGDbeshb1uH9Z+61ALG7Nx3x3O0wt6W+OL85UdVs2W6qCpDU2
 +4aViKAwwV/MG08iNokwJ6LD/CDFT5dm0gsrdBVac6ZVjyWssdTbt5uvWYFfB3e9OApdMc9K2BH
 JmBwHLiCkyw6dT8kkSRzoR/pHCj9Hs8HHWRO3NWLhAmmb4eF3KxcZ2sU6x1S8GCKImezBnvUnLB
 WuQ36mZeiRI6lk4+W/A==
X-Proofpoint-GUID: UE6wbE1Eu_QKUUzD1eGAjiYLVcM-fr8e
X-Proofpoint-ORIG-GUID: Oo6aBVKTGSDpzITsnW7ScYfws_CCN9dP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX4qB2VeOxLQYH
 H7LX0qdS0DC7R09S9ai6Pnc7WiqVjo6+rAvqopzITdGBM4tcniyjRzW1aOeA7aV4bC6by4BS/fV
 m6PKPja0RihPLjD1/od5Eq+6bZiMr/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310160


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Add RX queue register helpers for MQ
>
> This extracts the queue-0 control-plane registration and teardown out of
> ibmveth_open()/ibmveth_close() into ibmveth_register_rx_queues() and
> ibmveth_free_all_queues(), and adds adapter->hcall_stats for register/free
> path accounting. Runtime behaviour stays single-queue since multi_queue is
> still false.
>
> A few questions on the teardown error handling and on the changelog text.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index b39e8c53cbfd1..8519cad503225 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1270,13 +1275,27 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
>>   	 * try again, but only once.
>>   	 */
>>   retry:
>> -	rc = h_register_logical_lan(adapter->vdev->unit_address,
>> -				    adapter->buffer_list_dma[0], rxq_desc.desc,
>> -				    adapter->filter_list_dma, mac_address);
>> +	/* In multi-queue mode, obtain a queue handle for queue 0 so all RX
>> +	 * queues can use the same per-queue buffer hypercalls.
>> +	 */
>> +	if (adapter->multi_queue) {
>> +		rc = h_register_logical_lan_with_handle(ua, buf_dma,
>> +							rxq_desc.desc,
>> +							filter_dma,
>> +							mac_address,
>> +							&qh0);
>> +		if (rc == H_SUCCESS)
>> +			adapter->queue_handle[0] = qh0;
>> +	} else {
>> +		rc = h_register_logical_lan(ua, buf_dma, rxq_desc.desc,
>> +					    filter_dma, mac_address);
>> +	}
>> +	adapter->hcall_stats.reg_lan++;
>>   
>>   	if (rc != H_SUCCESS && try_again) {
>>   		do {
>>   			rc = h_free_logical_lan(adapter->vdev->unit_address);
>> +			adapter->hcall_stats.free_lan++;
>>   		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
>>   
>>   		try_again = 0;
> [ ... ]
>
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
> [Severity: High]
> This isn't a bug introduced by this patch - the baseline ibmveth_close()
> already had the same log-and-continue loop ("h_free_logical_lan failed with
> %lx, continuing") followed by ibmveth_free_buffer_pools() - but the new
> helper makes it harder to fix later, so a question about it.
>
> The retry loop here only retries H_BUSY and H_IS_LONG_BUSY. Any other
> status (H_PARAMETER, H_STATE, H_HARDWARE) leaves the loop, is logged, and
> then the helper returns void, so neither ibmveth_close() nor the
> ibmveth_open() unwind can see that the logical LAN may still be registered.
>
> Right after the netdev_err(), queue_handle[] is cleared unconditionally:
>
> 	for (i = 0; i < adapter->num_rx_queues; i++)
> 		adapter->queue_handle[i] = 0;
>
> Should that clearing be conditional on H_SUCCESS? Once multi_queue is
> enabled later in the series, ibmveth_deregister_single_rx_queue() bails out
> on "if (!qh)", so zeroing the handles after a failed free removes the only
> reference a per-queue H_FREE_LOGICAL_LAN_QUEUE retry would need.
>
> Would it make sense for this helper to return the hypercall status so the
> callers can decide, rather than returning void?
Yes. Clearing handles after a failed free throws away the retry
reference. Returning status without a caller policy is worse than
matching SQ close — callers would have to keep the mappings too, and
resize has to match. Halfway is worse. v6 documents the void return
and the unconditional clear in the kdoc.
>
> [ ... ]
>
>> @@ -1309,37 +1407,23 @@ static int ibmveth_open(struct net_device *netdev)
>>   	if (rc)
>>   		goto out_free_filter_list;
>>   
>> -	mac_address = ether_addr_to_u64(netdev->dev_addr);
>> -
>> -	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
>> -					adapter->rx_queue[0].queue_len;
>> -	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
>> -
>> -	adapter->queue_irq[0] = netdev->irq;
>> -	ibmveth_disable_irq(adapter, 0);
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
>> +	rc = ibmveth_alloc_buffer_pools(adapter);
>> +	if (rc)
>>   		goto out_free_queue_mem;
>> -	}
>>   
>> -	rc = ibmveth_alloc_buffer_pools(adapter);
>> +	rc = ibmveth_register_rx_queues(adapter, mac_address);
>>   	if (rc)
>> -		goto out_unregister_lan;
>> +		goto out_free_buffer_pools;
>> +
>> +	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
>> +	if (rc) {
>> +		netdev_err(netdev, "failed to set number of rx queues\n");
>> +		goto out_unregister_queues;
>> +	}
>>   
>>   	rc = ibmveth_setup_rx_interrupts(adapter);
>>   	if (rc)
>> -		goto out_unregister_lan;
>> +		goto out_free_all_queues; /* setup already disposed IRQs */
> [Severity: Low]
> The changelog says:
>
>    "failures after successful LAN registration enter
>     out_unregister_queues, then fall through to out_free_buffer_pools"
>
> Is that the label graph the code actually has? Only the
> netif_set_real_num_rx_queues() failure jumps to out_unregister_queues. The
> ibmveth_setup_rx_interrupts() failure goes straight to
> out_free_all_queues, and the ibmveth_alloc_tx_resources() failure goes to
> out_cleanup_rx_interrupts which then does "goto out_free_all_queues".
>
> All three do reach ibmveth_free_all_queues() and
> ibmveth_free_buffer_pools(), so the "RX pools are not leaked" part still
> holds; only the description of which label the paths enter looks off.
> Could the changelog be adjusted to match?
Only set_real_num_rx_queues() enters that label. v6 dropped the walk
from the message.
>>   
>>   	netdev_dbg(netdev, "initial replenish cycle\n");
>>   	ibmveth_schedule_rx_queue(adapter, 0);
>> @@ -1357,10 +1441,12 @@ static int ibmveth_open(struct net_device *netdev)
>>   
>>   out_cleanup_rx_interrupts:
>>   	ibmveth_cleanup_rx_interrupts(adapter);
>> -out_unregister_lan:
>> -	do {
>> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> +	goto out_free_all_queues; /* cleanup already disposed IRQs */
>> +out_unregister_queues:
>> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
>> +out_free_all_queues:
>> +	ibmveth_free_all_queues(adapter);
>> +out_free_buffer_pools:
>>   	ibmveth_free_buffer_pools(adapter);
>>   out_free_queue_mem:
>>   	ibmveth_cleanup_rx_resources(adapter);
> [Severity: High]
> Same pre-existing concern as above, now on the open-failure unwind: since
> ibmveth_free_all_queues() cannot report failure, this path unconditionally
> continues into ibmveth_free_buffer_pools() (dma_unmap_single() plus
> dev_kfree_skb_any() of every posted RX buffer) and
> ibmveth_cleanup_rx_resources() (dma_unmap of the buffer-list page,
> free_page(), dma_free_coherent() of the RX ring).
>
> If H_FREE_LOGICAL_LAN returned something other than H_SUCCESS and the LAN
> is still registered, can PHYP keep writing received frames and the
> rx_no_buffer counter into those unmapped or freed pages?
Yes. If h_free does not succeed, PHYP can still write into those
pages. Same hazard as baseline close, and the same reason as above:
returning status without a caller policy is worse than matching SQ
close.
>> @@ -1395,15 +1480,7 @@ static int ibmveth_close(struct net_device *netdev)
>>   	synchronize_net();
>>   
>>   	ibmveth_update_rx_no_buffer(adapter);
>> -	/* Full LAN teardown (subordinates arrive with register helpers). */
>> -	do {
>> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> -	if (lpar_rc != H_SUCCESS) {
>> -		netdev_err(adapter->netdev,
>> -			   "h_free_logical_lan failed with %lx, continuing\n",
>> -			   lpar_rc);
>> -	}
>> +	ibmveth_free_all_queues(adapter);
> [Severity: High]
> This is the pre-existing log-and-continue behaviour moved into the helper,
> so the same question applies on the close path: after
> ibmveth_free_all_queues() the function proceeds to
> ibmveth_free_tx_resources(), ibmveth_free_buffer_pools() and
> ibmveth_cleanup_rx_resources() regardless of the hypercall result.
>
> The changelog states:
>
>    "free_all_queues() runs before free_buffer_pools() on open failure
>     and close, so PHYP cannot retain a registered LAN while its
>     DMA-backed RX pools are released."
>
> Does that hold when the hypercall does not succeed? The ordering only
> gives that guarantee on H_SUCCESS; on a non-busy failure the LAN may still
> be registered when the pools go away. Could the changelog note that, or
> could the helper propagate the status so close() can keep the DMA
> mappings?
>
> I also checked the end of the series (1f83fd44d867) and
> ibmveth_free_all_queues() is unchanged there, so this is not addressed by
> a later patch in the series.
No. Only on H_SUCCESS. v6 dropped that sentence; the kdoc records the
limitation. Still unchanged at tip.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index bf5dd5703773d..fae3473cc4985 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -268,6 +268,17 @@ static int pool_active[] = { 1, 1, 0, 0, 1};
>>   
>>   #define IBM_VETH_INVALID_MAP ((u16)0xffff)
>>   
>> +struct ibmveth_hcall_stats {
>> +	u64 reg_lan_queue;	/* H_REG_LOGICAL_LAN_QUEUE */
>> +	u64 reg_lan;		/* H_REGISTER_LOGICAL_LAN */
>> +	u64 add_bufs_queue;	/* H_ADD_LOGICAL_LAN_BUFFERS_QUEUE */
>> +	u64 add_bufs;		/* H_ADD_LOGICAL_LAN_BUFFERS */
>> +	u64 add_buf;		/* H_ADD_LOGICAL_LAN_BUFFER */
>> +	u64 free_lan_queue;	/* H_FREE_LOGICAL_LAN_QUEUE */
>> +	u64 free_lan;		/* H_FREE_LOGICAL_LAN */
>> +	u64 send_lan;		/* H_SEND_LOGICAL_LAN */
>> +};
> [Severity: Low]
> This isn't a bug, just a note on what was checked. At this commit only
> reg_lan and free_lan have writers and none of the eight counters has a
> reader, even though h_add_logical_lan_buffer(),
> h_add_logical_lan_buffers() and h_send_logical_lan() already exist in the
> driver.
>
> Looking at the end of the series (1f83fd44d867), all eight counters get
> both producers and a consumer through ethtool -S ("hcall_reg_lan_queue",
> "hcall_reg_lan", "hcall_add_bufs_queue", "hcall_add_bufs", "hcall_add_buf",
> "hcall_free_lan_queue", "hcall_free_lan", "hcall_send_lan"), so this
> resolves within the series and needs no action.
>
> For completeness: reg_lan is incremented even when registration fails, and
> free_lan is incremented once per H_BUSY retry. Given the field comments
> name the hypercalls and the struct is described as hypercall statistics,
> invocation counts look like the intent, so no change is requested here
> either.

They were invocation counts, so no semantic correction needed. The
incomplete-producers issue also resolves: v6 deletes all eight rather
than finishing them. No struct, no ethtool keys.

Thanks,

Mingming


