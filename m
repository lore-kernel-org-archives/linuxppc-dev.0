Return-Path: <linuxppc-dev+bounces-25693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EF8C5B569
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 20:45:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJmwL6n5fz2yrW;
	Tue, 11 Aug 2026 06:45:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786394706;
	cv=none; b=gDkbTnVatAqjcOM0j9k6SlJzYV4KIkk7hYg+6KfBlKL2pHRnQWUX/TD/NpZSRQ5cgSSSHtUhokP/Z2tMSNHYKY0RExf2OeFfHRG8c/Ub+v21kEqEajIcMQ/qTyx22yth7JkoxX6nPEl2jdPVuftsXNzURP4SKR2XOAEqtqr3VorjHjevvTr8kQ3EUq7kWjmAS5I1MM1flJCjQNuHfPt/d+i1SoBbEQZzF3Mh2nc1wiVeaw1fxj0ZUsoQfruAu1EYGKSsNEB69b+ltu1J1SkoOwWwQgap6LYe0jOXGqHjrtnWXg9BSeBSoDGCzYZKZftZFU+553a6juxRrqJP/V/lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786394706; c=relaxed/relaxed;
	bh=AjjF2NdV4CRSF5MbxUkEZmFkgpsPHM8phVSmK2DfJhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt2+6JNRbs/kEfUTwx3LxdkgqoZgLKo3wBQXjzCQWNudxrdo7iG+javuVmrUt/qJ0DjMCBEPPwIxx7np9F85T5w2IvXR8Q3MnsgrcHWnOMrsWO7txbq2w32JBEMAqyg4IwSxFE1orSDZUD+QWk4iP0jZS9uVCJTiqb93bkRhDw7BeBAD9Qd2q4q2x0eRRJHQA5tpGwfkTLziKjLl6fwu3AtvXQduKkMbl/aJuLZUBPxCNOf2AyN/S0DlhLxORlpUkLc6hQYu7TIyyoFCsEK9aimLAxud0cgqQsrmORoqcTjIVVxeZiccNM5DU/8MmeAUEud1NET8gdQRSheKvbdHrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YtltYse5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YtltYse5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJmwL09SJz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 06:45:05 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AK1YmT1504321;
	Mon, 10 Aug 2026 20:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AjjF2N
	dV4CRSF5MbxUkEZmFkgpsPHM8phVSmK2DfJhw=; b=YtltYse5F80QijuZXrA0DC
	w2bHTi8Wflb+wbLyjL6wx2MESvFD+Kl9j3Vaywx+kYpbqKddb1s3jOSvVAP1J9nR
	lmkBcTxkC2H1KP0O6f1+rjI71Ues6vJxGcZnoWr9UIMoQpDqgoyIfpKhsZhW9DMz
	ys2GJm8s3WrXysm8v0xFxdQfF+iUqAXCIqTEDCWgUsF7hPcCFA5xMrBROdHAZUzG
	p7xW04Ag7Xkt9Oa5uMDNedzj6dnC+LTkU7N2RS6/9axnRqFGnQqxP40mZrnR3BLG
	iLoeI3mH8Io2h0OKSP68Hlj0nPpBmqlAMAzJGsBccF/FxMvvOy9Jt8HMPPLkeKZA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23jw13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 20:44:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AKQKT5007193;
	Mon, 10 Aug 2026 20:44:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g67u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 20:44:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AKio3O18874892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 20:44:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC7258058;
	Mon, 10 Aug 2026 20:44:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEA558059;
	Mon, 10 Aug 2026 20:44:47 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 20:44:47 +0000 (GMT)
Message-ID: <cc289146-b5b7-4505-a628-4ebb135364ac@linux.ibm.com>
Date: Mon, 10 Aug 2026 13:44:47 -0700
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
Subject: Re: [PATCH net-next v4 03/14] ibmveth: Refactor RX resource
 allocation for MQ RX bring-up
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <984697bdc91a3c37f5f24750d7f24fc2d97031fa.1785457143.git.mmc@linux.ibm.com>
 <20260806183701.3175123-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183701.3175123-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7a3844 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=UjAjnVmcxQQvIb_wud0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE3MyBTYWx0ZWRfX6Z/szwll8nOs
 +1aXO2Ych1Xb1Wrf35oFEYGPd3XtXYkpMaUIhpZCXIjGsSp5F4UhZbOHYg8zMpHhYOFGrP3cpE2
 1XhONiQhxpEel78eKp58CxWeRmLL0+9+U9WXyKT80+xui9ZzUDxH3HLXp0Jge+jnm3Hab+YrJXq
 zDOwuoRSEt7G7Oth2J9Xs6CWXKce6O8zFqt9V9GwB8Y7fr2LJ5PXWzvXfugSkNZYAzgCOornfCi
 y22Wc14aGOzc6arcnPCwyacH9F+ncYt9GgtSQUEpHX2jCm8e5DggLh/NMye7odi4HpMr0GYyjRP
 dsaJ0JwbQeJatEy7xKh0sz+8MmYlAVFgZaPgP4FZWVaWvVTLvOhDDOMHwrbQ2SKDnvaQxjX7pbI
 IONSHCA4Jm9wKZFEL3C37t+sBYAYnG+vVodo9sWer1yC1VhtNUuHbAgoPeGP2fDhfh3AX+vozAc
 fEiLyJ903F3YtAu1d/Q==
X-Proofpoint-ORIG-GUID: 1iv-Uc83Qg47Ml-p1Xtmu5chqqPxwK6N
X-Proofpoint-GUID: 6B_knT4CCJ8je3I0W9Ag6_uAgGthc9gu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE3MyBTYWx0ZWRfXyjkXZ62dXKJB
 mSgoIb6HrORm9/bQ0Rn0VGHt6NEpPvKNidRfVQRjtmOWHWEpioepxT3enMWrUD/yWNmU/DnZZUs
 NVF8vMmmDbv0F5zfrfIrq213/D1R39w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100173


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor RX resource allocation for MQ RX bring-up
>
> This moves the filter list and per-queue RX ring allocation out of
> ibmveth_open() into four new helpers, and wires them into both the
> open error unwind and ibmveth_close().  Runtime behaviour is meant to
> stay single-queue since num_rx_queues is still 1.
Hi Jakub,

Thanks for the review.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 8e758362cb263..1007dd95cde02 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -151,6 +151,184 @@ static unsigned int ibmveth_real_max_tx_queues(void)
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
>> +		return -ENOMEM;
>> +	}
> [Severity: Medium]
>
> Should this error path also clear adapter->filter_list_dma?  On failure
> dma_map_single() has stored DMA_MAPPING_ERROR, which is ~(dma_addr_t)0 and
> therefore non-zero, and only filter_list_addr is reset here.
>
Yes. In v5 I will clear `filter_list_dma` on mapping error, matching the
existing `buffer_list_dma` convention.

> The sibling helper added in the same patch does zero the cookie in the
> same situation:
>
> 	if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
> 		...
> 		adapter->buffer_list_dma[i] = 0;
> 		goto err_cleanup;
> 	}
>
> so the two new helpers appear to disagree on the convention.

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
> [Severity: Medium]
>
> Can this unmap the DMA_MAPPING_ERROR sentinel?  ibmveth_free_filter_list()
> treats any non-zero filter_list_dma as a live mapping, and the mapping-error
> branch of ibmveth_alloc_filter_list() leaves the sentinel behind.
>
> The state looks reachable without dev_close().  ibmveth_set_csum_offload(),
> ibmveth_set_tso(), ibmveth_change_mtu() and veth_pool_store() all call
> ibmveth_close() and then ibmveth_open() directly while netif_running() is
> still true:
>
> 	if (netif_running(dev)) {
> 		restart = 1;
> 		ibmveth_close(dev);
> 	}
> 	...
> 	if (restart)
> 		rc2 = ibmveth_open(dev);
>
> If that re-open fails at the dma_mapping_error() check in
> ibmveth_alloc_filter_list(), open() returns through the out: label without
> calling ibmveth_free_filter_list(), so the adapter is left with
> filter_list_addr == NULL and filter_list_dma == DMA_MAPPING_ERROR while the
> netdev is still marked running.  A later "ip link set dev ethX down" then
> reaches ndo_stop == ibmveth_close() -> ibmveth_free_filter_list() and unmaps
> that invalid address.
>
> On pseries the dma_iommu path catches this in iommu_free_check(), which emits
> a ratelimited "iommu_free: invalid entry" message and a WARN_ON(1) (a panic
> with panic_on_warn set), so no TCE state is changed, but the backtrace is
> still user triggerable with CAP_NET_ADMIN plus a mapping failure.
>
> Setting adapter->filter_list_dma = 0 in that error branch, matching
> ibmveth_alloc_rx_queues(), would make the guard here reliable.
>
> This is still present unchanged at the end of the series (a3781f4ae789), so
> a later patch does not appear to address it.

Yes. The failure path here is:
- `dma_map_single()` fails for the filter page
- open/reopen leaves `filter_list_addr = NULL`
- `filter_list_dma` is still left at `DMA_MAPPING_ERROR`
- a later free path sees a non-zero DMA handle and calls
   `dma_unmap_single()` on the sentinel value

That leads to the later bad unmap/WARN.

In v5 I will free the page and set `adapter->filter_list_dma = 0` on
mapping error while keeping `filter_list_addr = NULL`, so the free path
remains consistent and only unmaps real mappings.

>> +
>> +	if (adapter->filter_list_addr) {
>> +		free_page((unsigned long)adapter->filter_list_addr);
>> +		adapter->filter_list_addr = NULL;
>> +	}
>> +}
>> +
> [ ... ]
>
>> +		adapter->buffer_list_dma[i] =
>> +			dma_map_single(dev, adapter->buffer_list_addr[i],
>> +				       4096, DMA_BIDIRECTIONAL);
>> +		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
>> +			netdev_err(netdev,
>> +				   "unable to map buffer list for queue %d\n",
>> +				   i);
>> +			adapter->buffer_list_dma[i] = 0;
>> +			goto err_cleanup;
>> +		}
>> +
> [ ... ]
>
>> @@ -627,74 +805,34 @@ static int ibmveth_open(struct net_device *netdev)
>>   
>> -	rc = -ENOMEM;
>> -	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
>> -	if (!adapter->buffer_list_addr[0]) {
>> -		netdev_err(netdev, "unable to allocate list pages\n");
>> +	rc = ibmveth_alloc_filter_list(adapter);
>> +	if (rc)
>>   		goto out;
>> -	}
> [ ... ]
>
>> @@ -753,26 +889,12 @@ static int ibmveth_open(struct net_device *netdev)
>> +	ibmveth_cleanup_rx_resources(adapter);
>>   out_free_filter_list:
>> -	free_page((unsigned long)adapter->filter_list_addr);
>> -out_free_buffer_list:
>> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
>> +	ibmveth_free_filter_list(adapter);
>>   out:
>>   	napi_disable(&adapter->napi[0]);
>>   	return rc;
> [ ... ]

Thanks again for the review,
Mingming


