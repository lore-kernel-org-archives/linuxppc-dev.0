Return-Path: <linuxppc-dev+bounces-26338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC26C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYf2J4n9Qz2xlv;
	Tue, 01 Sep 2026 05:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788203992;
	cv=none; b=I/kiNEk5z9lIB0KJWbVj2NnhHvMDf3JvPUFXNYjJC9cQSwo4adZ0v/RVNpp5zZGOWqbc33vTMdS/IyndfloZVhX/vhAQZyh1WRQPnTkHVFYbPtNQP9VI6X8UxseYa1rlP0wgFUjmdcYsmmVknTiZAF1TYnHB6rCkvgIktUW6bUIzyVAkgeNmxzNIQKDe3u0keG1qUnJ/SXY9rjTwIz5WC/HzFLG6lnltD9E0ttpzKAEAKOWo3RHpR6cf2xZoDDYfxFi47qqbC+O8YFOtOfjtN3xgn4pFZdNlI8cXq0vJ1VKSpAehv+SXEh/cjV5JvPK9E+WXk9xFS+W6xXNqNSC7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788203992; c=relaxed/relaxed;
	bh=c3smvBpR+kez9et3daTyXO8GKIAn8FN8WunaTgmMP5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTSl9ghYbOvZfEH0UtGxtgNUQHzkSKrhFit9YeXFoBS/VFZCBNe3m5x1XFbXzxTiIfMSiYJgMMFJIMpoGh1shtA222O3uXmW7/B4QcEoGVLOw1PJ0APRhClWtzrutsALTEmm+1kiBXpQfH7cvyKBcrjtEwPNe6Zp0IacSmY0DSr4JWrexrP7BcurSiXOCQj97NL1RRfZJ5onXeufO85U+KqMGTzPF+93bIk0oYs7tqoH90H0BvstHvXX1wlcyS9FyokK6lcK9gbq1+9PHSvwBl5gyIl9mhkr0SFD5vQqqP+gRyVat0rKT/23lDrs5+M66Vvjpu4W3yATPH+99QKV5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WHNhgLds; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WHNhgLds;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYf2H2bKZz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:19:50 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVbf73108068;
	Mon, 31 Aug 2026 19:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c3smvB
	pR+kez9et3daTyXO8GKIAn8FN8WunaTgmMP5U=; b=WHNhgLdsxvgZ/Z97ilGFq4
	d8yUKKlXWGMSudIDFaM99hFs5dTkYkSUT6b0lsuYDgbJye9SUPW8njaYbinMyHrZ
	THimAvcj8fiUsB6AvUmn8UpaRI+jVdTjszOc/nfiN4+SMGQezuKg6lmUTReNdjWJ
	ZLy8Yadigpk7M+Wuwsbey5mnhJ+debKYbIdmgVVJMecASjzDiV9TkFr/oqqG2g1p
	iPHNCoIagq73qLejXnZgetoUQ4qIsH41Qkqmu1yLik6O3Y1mzUsp3fPMqq5FVb6d
	0JS+VJYQVHFRb+IdijSOb5Q5jY97ZvqAIQ3D1xFVPuu8zorj/UpGULF4hHdrW3wg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54kcft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:19:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJBO2Z007088;
	Mon, 31 Aug 2026 19:19:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq7txt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:19:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VJJc5l21889776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 19:19:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF84A5805A;
	Mon, 31 Aug 2026 19:19:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 399955803F;
	Mon, 31 Aug 2026 19:19:35 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 19:19:35 +0000 (GMT)
Message-ID: <99e8f07e-facf-40dd-a235-cec62270f981@linux.ibm.com>
Date: Mon, 31 Aug 2026 12:19:34 -0700
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
Subject: Re: [PATCH net-next v5 12/15] ibmveth: Report MQ-aware RX counts in
 ethtool get_channels
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-13-mmc@linux.ibm.com>
 <20260818014735.3854400-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014735.3854400-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX+oxJG7GX5gti
 kxLvMQ0IWquUPGRf7COsDOo8uUA83WmxTiIAvpyW6fGX+8xXYLSjYej5VdN2kl16zAcieO6Tv7X
 TVDoShPKHkQjtcq5EaTOm4VNJtl6wvcHHVthOQlnVxZbD/CTSxP2hTQ8SrU+3BwAn75KFrTMweA
 /nz6/qZebF3NYALukJqs+8dsgofPHt5dQQVUFtxDBUAddlTUbuWXyEyCczJZXZjBtkPmDeZMPn9
 kghiTB5twKRAjL9y2PbdIIHO2j69DDVjGqzq7VFJEehgNT1FSqpp32dtLZrW5YL2TufXyNZ9Bp1
 lvkUTV7ixwAWeT4cS7k+L9PO0UknhMiXA1ejrCICuq3Ur7/yeuQXt0lQdoXwdOxr/PZ4z8Zm8Xx
 xcfno87yLRHCuWKskrkSteBasmsqM3PX+wLw32RCd4qUvScUUK6bhs5Z1pmhd4Z/AvFmJkfv/MN
 IYEUKtFf0gUtFFafR7A==
X-Proofpoint-ORIG-GUID: mysNC9mnh9qjFuDHIFGsYa_P5ZFDASYf
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95d3cd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Nf8FFmMjq70KbZWXPFMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OlT4raL7cZjpnBWU0oheLa17_-FWOSmj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX55US76Vv4OcS
 JFey6pPbOdP59FdwHGQ0YSKfq1iS+1dqAco0U7OpcmLcu+SqVxLDtdq46RaxNHVqqsJT4r2DSJj
 SBV0QjXINsH6FNb0kbt0vBL39L2UJbY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310164


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Report MQ-aware RX counts in ethtool get_channels
>
> The patch changes ibmveth_get_channels() to report max_rx as
> IBMVETH_MAX_RX_QUEUES when the adapter has multi-queue firmware support
> (else 1), and to report rx_count from the driver's published
> num_rx_queues instead of netdev->real_num_rx_queues.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 3202b657c9b8f..5d4ca4b3d3d07 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -2522,11 +2522,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
>>   static void ibmveth_get_channels(struct net_device *netdev,
>>   				 struct ethtool_channels *channels)
>>   {
>> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> +
>>   	channels->max_tx = ibmveth_real_max_tx_queues();
>>   	channels->tx_count = netdev->real_num_tx_queues;
>>   
>> -	channels->max_rx = netdev->real_num_rx_queues;
>> -	channels->rx_count = netdev->real_num_rx_queues;
>> +	if (adapter->multi_queue)
>> +		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
>> +	else
>> +		channels->max_rx = 1;
>> +	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>>   }
> [Severity: Medium]
> At this point in the series, does raising max_rx here make RX channel
> requests silently succeed without changing anything?
>
> ibmveth_set_channels() only derives its work from tx_count:
>
> 	unsigned int old = netdev->real_num_tx_queues,
> 		     goal = channels->tx_count;
> 	...
> 	if (!(netdev->flags & IFF_UP))
> 		return netif_set_real_num_tx_queues(netdev, goal);
>
> channels->rx_count is never read there.  The core validation in
> ethtool_set_channels() only bounds the request by the driver-reported
> maximum:
>
> 	if (channels.rx_count > curr.max_rx ||
> 	    channels.tx_count > curr.max_tx ||
>
> so with max_rx now 16, "ethtool -L ethX rx N" for any N in 1..16 that
> differs from the current RX count passes validation, enters
> ibmveth_set_channels() with tx_count unchanged, runs no LTB loop
> iterations, and returns 0.  The netlink path in ethnl_set_channels()
> applies the same max_rx-only ceiling and maps the 0 return to success.
>
> Before this change max_rx equalled real_num_rx_queues, so an increase was
> rejected with -EINVAL by the core; afterwards it is accepted and ignored,
> and "ethtool -l" still shows the old rx_count.
>
> For the record, this appears to be resolved later in the same series: the
> final patch "ibmveth: Wire ethtool set_channels to MQ RX queue resize"
> makes ibmveth_set_channels() read channels->rx_count and apply it via
> ibmveth_resize_rx_channels() with range validation of
> 1..IBMVETH_MAX_RX_QUEUES, so the get/set pair agrees at the end of the
> series.  Would it be worth ordering that patch before this one, or
> mentioning the intermediate state in the changelog?
Yes. At this commit set_channels still only looks at tx_count, so
ethtool -L rx N can pass core validation and return success without
changing RX. Raising max_rx here just widens that window from the
live count to 16. v6 names the intermediate state in the commit
message, which covers your second option.

The reorder is not done: channel reporting stays reviewable on its
own, separate from stats and from the resize. Patch 14 reads
rx_count and calls resize; patch 15 finishes the down-path and caps
max_rx once mq_fallback latches.
> [Severity: Low]
> A second, smaller point about the same lines: max_rx is derived only from
> adapter->multi_queue and does not consult adapter->mq_fallback.  After
> firmware refuses multi-queue, ibmveth_apply_mq_fallback() defers the
> downgrade to the next open:
>
> 	if (!adapter->mq_fallback)
> 		return;
>
> 	adapter->mq_fallback = false;
> 	...
> 	adapter->multi_queue = 0;
> 	ibmveth_publish_num_rx_queues(adapter, 1);
>
> so between the firmware rejection and the next open, "ethtool -l" keeps
> reporting max_rx = 16 and rx_count = 8 while the adapter is going to run
> single-queue.  Should get_channels() also take mq_fallback into account?
>
> Also, at this patch the reported maximum of IBMVETH_MAX_RX_QUEUES (16) is
> above anything the driver publishes, since ibmveth_probe() caps the RX
> queue count:
>
> 		adapter->multi_queue = 1;
> 		ibmveth_publish_num_rx_queues(adapter,
> 					      min(num_online_cpus(),
> 						  IBMVETH_DEFAULT_QUEUES));
>
> The end-of-series patch "ibmveth: Wire ethtool set_channels to MQ RX
> queue resize" does make 1..IBMVETH_MAX_RX_QUEUES genuinely settable via
> ibmveth_resize_rx_channels(), so this is only about the intermediate
> state and the stale reporting while mq_fallback is latched.

Yes. While the latch is set, -l can still show MQ max_rx / rx_count
until the next open applies fallback — apply_mq_fallback() runs at
open entry, so get_channels() here still reads multi_queue and the
published count only, not the latch directly. Not taken here:
patch 15 consults the latch by capping max_rx at the live count,
not by understating rx_count. Clamping rx_count would turn the next
TX-only -L into a silent RX shrink.

Thanks,

Mingming


