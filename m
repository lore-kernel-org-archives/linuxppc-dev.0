Return-Path: <linuxppc-dev+bounces-24333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8971C4450A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 03:03:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1ZV10r95z2ySg;
	Fri, 17 Jul 2026 13:03:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784257385;
	cv=none; b=CRGMncmZ0fCDwtSD+1I3cGVAbhNVX2haUJhhrM5d38MRxYIH1YxFRuX0M94ltb8L3xdBAF6MFomVUrP7KBwvgPMkavaxridnsxJgsBfQOBPQ6ZYuSyqZVWIJSVwKcxlwh21V575OSexCAb+9PIX75N7T4T/bx/PZrKkwCtZ23akG70BgDj38UNrCBrldZsd5HsWyoW/cV6Lyvpzrnj94mohx2h6jmtMBisiNMoPbqcBcfkns36Q/X3tMO5cH/V2b6hxlZxkaee2+BxG34loTRekPRxrRO8uLagmwmojR7TfyJoU46xUBeuwKSyEkY2VJl49FhpRrTZhDdh0Ey3+0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784257385; c=relaxed/relaxed;
	bh=/MdGINK6Se3jqqXCHdNdAaT6iOdjYsFR2lt0imh/Owo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCymNIKvjSQ5QWLm1pJSp7xLh3CwmdZEWw+pzAuS6oHgYslc9ULKoW1M16UzDY5A3Endp/YfGw8gmtrUGov5cek940RVxr+heVzQXn/1lfEnvjEAnrNZz92q5hZzKzlfegw8qlrr1V0trY+alRyz+r5MUAH2VdS22WxpLTfBSzkltd/kuM1BP+WsWZxXUioDT2S3GftFV8oKOEGyD+HsrAIcsQkIdIr8DnKBgF/ndQtehmVlOVtfaWnQullRALdD8Zb7dHklE5aAmOGxmEcv9GFgSGalgrJDmjFvwVImqpee1/ZVfOF0XmCUaAXauERHHQmH9lpRtfCQWi8eGNuU5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d1vtBjkh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d1vtBjkh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1ZTz39Dcz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 13:03:02 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNg0Xt365175;
	Fri, 17 Jul 2026 03:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/MdGIN
	K6Se3jqqXCHdNdAaT6iOdjYsFR2lt0imh/Owo=; b=d1vtBjkhGopu3VCf/AZglZ
	UmsIPzgmSIGG4b6A8/76K3KEzvc75W6d37sjQilphEQ/ACFQe1I87/5dFCz86TYS
	OgCKPYHP6rTlyAOi4o3gnjs5rpW07B4uCbMr9zHU/o0BFsvMvT8tqEA4w0dBe1pR
	7A9GpIx3hVEyMh4GcEXkkMT8gJmcRvdA1LLpBU6fNrHdKaOYJL5luxeKDGZifS4J
	xrXGQs54t06lbZrDo6AJ/TMzZyO/5Myt7g5Y7YkcAGjpY7fKYAY07SSdbc0FkaUd
	E6Yo+zV5Ot57MjeUyEamdJCZz3vZxaiBJNvfaLqKv4+Lh3Qa23z0fgzrhQGKG9uA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2akbyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:02:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H2nebc016812;
	Fri, 17 Jul 2026 03:02:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyfjta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:02:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H32lwo29360684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 03:02:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05C6358065;
	Fri, 17 Jul 2026 03:02:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C924558055;
	Fri, 17 Jul 2026 03:02:45 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 03:02:45 +0000 (GMT)
Message-ID: <f391ea5c-200f-40f4-afed-84d9b7bdd208@linux.ibm.com>
Date: Thu, 16 Jul 2026 20:02:45 -0700
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
Subject: Re: [PATCH net-next v3 14/15] ibmveth: Wire ethtool set_channels to
 MQ RX queue resize
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-15-mmc@linux.ibm.com>
 <20260714130752.1844153-1-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714130752.1844153-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfXyuSmHwBHI5CR
 vGsu85qrUBqYLiRhwZOiDR01qK7k7ecLd8HbR+7FWsM+3x6nw0+OjfxCc5+wZGgWqxqlzLisVIl
 zpRFlNaH0aYBzzOIqomOmL3UKc2fQes=
X-Proofpoint-GUID: 80AG8LOcg87g0lKe-MvYDkD1qwBJHnd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX9ofVUAhfjFdY
 csNQ6Xxut4zeXpD9c8uRObUNCoDXeUQk1qfOOB7G4NEabyKuk7WMteH7DoCywZnmGqiPoczGygr
 ynMaE5iEfVekNLm41nKBh15jeLYD7kn4zhLVe4bXBVoWBLTyxeOHsnCsPGDCKPObwCoXV3X3RfD
 Op23j9kOZyeXCUxrOdWpurg53a3SPnjhaXLxy36yXE/XjKLx1fi+5eXDPQIPce0lNmd2JmXkRsF
 Zi9cyyeCMZeRtPxVoQyXy06yosEpU9wuj7QZxhRVMLFSdbS7le2CTn4n5o9sUF/A91PckZcDqhQ
 bs8rZXhNIhCIjrQFHnrPeSOdM5JTeRRX6uGeSkWPLfnZQclBbAiJKwRoBl15Hsy8Ej/4wWgTrol
 +TWxHh5O2Ecb6bMMvGTZW1VsH7EBwxHTkEueOq9uPvPM9Vw6S3G8258eIUPmuFr2DxbaarIfZI8
 ZV8RmyNNV6Ms5OoZkbw==
X-Proofpoint-ORIG-GUID: cC0mAH2CrxfXvONhPE7P78AA819OMiG9
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a599b59 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=y_x8SVAwwHyuJgv4bskA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170023

On 7/14/26 6:07 AM, Simon Horman wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ibmveth: Wire ethtool set_channels to MQ RX queue resize
>
> Expose incremental RX resize through ethtool channel control.
> get_channels() reports rx_count from adapter->num_rx_queues and max_rx
> as IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1.
> set_channels() validates rx_count is within 1..IBMVETH_MAX_RX_QUEUES.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index ac4d89a66a8db..50a332ab83fd3 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -2534,19 +2534,69 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   				struct ethtool_channels *channels)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> [ ... ]
>> -	if (!(netdev->flags & IFF_UP))
>> +	if (!(netdev->flags & IFF_UP)) {
>> +		if (goal_rx > 1 && !adapter->multi_queue) {
> [ ... ]
>> +		/* Stash desired RX count; open() publishes it via
>> +		 * netif_set_real_num_rx_queues() after queue registration.
>> +		 */
>> +		if (goal_rx != adapter->num_rx_queues)
>> +			adapter->num_rx_queues = goal_rx;
>> +
>>   		return netif_set_real_num_tx_queues(netdev, goal);
> [Severity: Medium]
> If netif_set_real_num_tx_queues() fails and returns an error, the TX
> configuration command will fail, but the RX queue count has already been
> permanently modified in adapter->num_rx_queues. Will this leave the device in
> an inconsistent state where the new RX count is applied on the next open
> despite the command failing?
*

Agreed — will only commit the stashed RX count after

netif_set_real_num_tx_queues() succeeds, or restore on failure.

*
>> +	}
> [ ... ]
>> +	if (goal_rx != old_rx) {
>> +		rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
>> +							  rxq_entries);
> [Severity: High]
> Does this new ethtool scale-down path expose an interrupt storm?
>
> Looking at ibmveth_resize_rx_queues_incremental(), when scaling down queues it
> disables NAPI before disabling the hardware interrupt:
>
> drivers/net/ethernet/ibm/ibmveth.c:ibmveth_resize_rx_queues_incremental() {
>      ...
> 		for (i = new_count; i < old_count; i++)
> 			napi_disable(&adapter->napi[i]);
>
> 		for (i = new_count; i < old_count; i++)
> 			ibmveth_drain_rx_queue(adapter, i);
>
> 		synchronize_net();
>      ...
> 		/* Disable hypervisor interrupts and wait for handlers to complete
> 		 * before updating num_rx_queues.
> 		 */
> 		for (i = new_count; i < old_count; i++) {
> 			ibmveth_disable_irq(adapter, i);
>      ...
> }
>
> If the hypervisor delivers a packet during this window, ibmveth_interrupt()
> will execute. Since NAPI is disabled, napi_schedule_prep() fails, causing the
> handler to return IRQ_HANDLED without disabling the hardware interrupt. Will
> this leave the virtual interrupt asserted and force an infinite interrupt loop?
Yeah, *Same issue as on the incremental resize patch — **

  will fix IRQ/NAPI ordering in ibmveth_resize_rx_queues_incremental() 
in v4.

*
>> +		if (rc) {
>> +			netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
>> +			return rc;
>> +		}
>> +	}
>>   
>>   	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>>   	 * but we may need to alloc/free the ltb's.
>>   	 */
> [Severity: High]
> This is a pre-existing issue, but does this function use an uninitialized
> variable in the error path?
>
> When decreasing the number of TX queues (goal < old), the allocation loop for
> (i = old; i < goal; i++) is skipped, leaving 'i' uninitialized. If
> netif_set_real_num_tx_queues() then fails, the error path assigns old = i;.
>
> The cleanup loop then uses this garbage value:
> 	for (i = old; i > goal; i--) {
> 		if (adapter->tx_ltb_ptr[i - 1])
>
> Will this access adapter->tx_ltb_ptr out of bounds and pass arbitrary pointers
> to ibmveth_free_tx_ltb()?
*

Good catch — pre-existing, but we’ll fix it while touching

set_channels in v4 (initialize i / don’t use it uninitialized on

TX scale-down failure).

*
>> @@ -2580,7 +2630,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   
>>   	netif_tx_wake_all_queues(netdev);
>>   
>> -	return rc;
>> +	return 0;
> [Severity: High]
> Does this unconditional return of 0 mask TX queue configuration failures?
>
> If applying the new TX queue count via netif_set_real_num_tx_queues() fails,
> the code handles it locally, but the function exits with 0 regardless. Will
> this mislead userspace into believing the TX channel count was successfully
> modified?
*

Agreed — that return 0 is a regression versus returning rc. Will

restore proper error reporting in v4 (and be careful about partial

RX-success / TX-failure).

*
*

Thanks for your review feedback.

Mingming

*


