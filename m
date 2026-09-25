Return-Path: <linuxppc-dev+bounces-28186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214B1C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:43:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrjP93bcWz2yDD;
	Fri, 25 Sep 2026 17:43:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790322205;
	cv=none; b=LgXyRoTTUQ3Y5BDeyVILZcsjkjEtaN76rOaSfjPhqjtxWFCYkr6x4NpAx7FyM46j/Fw2DUqnTS7zsbmz9Est5rWBJKYtnQdU6sqVZupqw2gH55HnHVml7NmXj0+MZI/00v0jBpQG7ImkK4iZ8QZFM2rf5vpdS0IumLUA+iFnOPssdx85Qz0pbX2dHw+wf3WhiGX1VMSdIfgEUs0Z7FtoINbViO7vaPgd4Pz5z5trYICyoYzW19sQcNLEP0LjVYA9okpZOgMZQIIUvPekKuh8gHkyzNedGg2SLysPKURlDIuXu1BIgEm0P4JPQmVZlkSoP+KNM9opPqK27zsTCXez+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790322205; c=relaxed/relaxed;
	bh=gJ8kSQb2VSXmPSiFXIt5VCAYt1B9muMoRUvj3DyXenA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVNcx2qHFWIb0ES/+mHb2MG2bZrpHKp7RL9MDnKMMXaH+lfPDcCtyE8cxwAjFBZUu/kL0GEJ6kMGf2Xyqmr8JUzKUqxwZ712C1vC1d4EbrQNbXUDw3b/Yp6rb6QHVnSQManVFnI8mmOydZS4vCcwAHCTw95lpeT66T9/ZCv0femB4E6c2AOaFdvYrCChxj2/ZVRr3nNy7NgT6CxXtCxaULLeaGcpRjQHRWZyehYLjduq5jIpwq6QYO63Tc9ATsXubXnkJmhJY/z7+0hHzS+ACtL77Ee4rh26HZ+RoKngHp3PcG5WZOMEBSBBFMGIikVLgZVHw36wyaUX9XWAAkXplg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rnQrzSqV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rnQrzSqV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrjP82fKDz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:43:24 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4bBdr3085707;
	Fri, 25 Sep 2026 07:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gJ8kSQ
	b2VSXmPSiFXIt5VCAYt1B9muMoRUvj3DyXenA=; b=rnQrzSqVNMGMX5SsK3N4TQ
	8VgaWuOGzP1hNSlbCCxZGF3afPjxrxyJzU3mUzy+Vljpt6XHRZeQEYxc7FLwhXuj
	d1exS5VW3ien27A6Pad9SVKRVkBkATI5T6wrVHIoUHr3w6QQxJhe7z4g/B5jlCIW
	XtlDuJX5n+u99eCo25K+aYoLB0GTP2Hrz5TZgCMiEvn3Y0Y0Wp0cId3Gpjm9maxq
	sC/8VvmAgXly0xGgJxslMQ3CJet1w+ivaS3GAouBrNfXO3SEk909Rc7fnwOLnwiQ
	uKKz98gkhYmiS+mioEUMXJDaIbwM03Y+amQlAkooTYoBqkTO9+FqXLeonkDzlYPg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqvuwy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:43:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lXe13248862;
	Fri, 25 Sep 2026 07:43:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt31f1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:43:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P7h7fN61014414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 07:43:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 129765804B;
	Fri, 25 Sep 2026 07:43:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DE7A58055;
	Fri, 25 Sep 2026 07:43:04 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 07:43:04 +0000 (GMT)
Message-ID: <b511dd06-70bd-4a8a-a1d6-ea39e4ccd0df@linux.ibm.com>
Date: Fri, 25 Sep 2026 00:43:03 -0700
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
Subject: Re: [net-next,v6,12/15] ibmveth: Report MQ-aware RX counts in ethtool
 get_channels
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <cfd6de05a68cd8a4f61a1f1e9e1c45a7d9ee2687.1788102125.git.mmc@linux.ibm.com>
 <178845904365.3394541.4016627609428622506@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845904365.3394541.4016627609428622506@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab6260e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=Fsu3MSCeboPIM76kHKcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfXzDB2PL6j+XGT
 cLOevslif3K8hd2aygLkOeaieCSUUF12NEP2zdQDun9pj8sOnj1NaW4eKH/NWppFkKGmC1nUEbF
 z6J2u8M3Mz6R+AkfVP5NLmKPCy6zvDIVkw/1ConYEcp4YXx1HltPqxRz62ugV7TvgOZwDoVT4aV
 Id4vkQrWnGAtMU8ehfOcPfv7NsiWaRHZViPBMFYvewD/B1bEf5OwMSzAjmdwSxrG/P6VWl8W/XG
 6d5YpvA/gX3QADCJbNBYLFe/rRqSc1GLvtjW6IC+tFtuKLHTbiR0lT2SU2nxOv3zXok7RbBpW4j
 0gMBM9gmN1usPtXrQobiTY1re4NXykKvE//4n1aSf6okx0cp1JbEKdg+XhX8hMGPbGTuh6n89+f
 PZ6iA5nmwPzxE+FHHOMOzr07+vqOjDxt3299mU19PwAwE1jX3gMLmxCL8cPgdWQuowgSTzkf32k
 REs0W6qYUErgx46UgpQ==
X-Proofpoint-ORIG-GUID: -HOgDOkqx4AZRnNYjfuQ6_Rn3ZVxxKrC
X-Proofpoint-GUID: SsYyoBySlMYFi3GJLxoW27fQqe3J3V51
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfX7Bfj5r8gM04Y
 irl7ZWuy2442PZ0ZydFtKo7GMJltynEk2UClCzL53Rmqni9rGomgoPhXmRly8Snq6vyrUdXgW7K
 JNbiNAJhwzMEHwHJ793ZzPodhXcc+ck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250030


On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 2
>
> - [Medium] Intermediate-state ethtool channel ABI mismatch:
>    ibmveth_get_channels() (drivers/net/ethernet/ibm/ibmveth.c:2537-2549)…
> - [Low] Advertised RX maximum not derived from any driver-side capability
>    check: ibmveth_get_channels() (ibmveth.c:2545-2548) reports a flat…
> - [Low] ibmveth_get_channels()
>    (drivers/net/ethernet/ibm/ibmveth.c:2540-2549) now sources…
>
> --
>
> ibmveth: Report MQ-aware RX counts in ethtool get_channels
>
> get_channels() now reports max_rx as IBMVETH_MAX_RX_QUEUES when MQ firmware
> is enabled (1 otherwise) and reports rx_count from the driver's published
> num_rx_queues instead of netdev->real_num_rx_queues.  The paired
> set_channels() is left unchanged in this patch.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index f4fddfa56571d..4f2d956b4c89e 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -2537,11 +2537,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
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
> [Severity: Medium]
> Does raising max_rx here make the kernel admit RX channel requests that the
> driver then silently drops on the floor?
> The core only bounds an RX request against the value this callback returns,
> in ethtool_set_channels():
>
> 	if (channels.rx_count > curr.max_rx ||
> 	    channels.tx_count > curr.max_tx ||
>
> and ethnl_set_channels() does the same check on the netlink path.
> ibmveth_set_channels() at this commit only consumes tx_count:
>
> 	unsigned int old = netdev->real_num_tx_queues,
> 		     goal = channels->tx_count;
>
> channels->rx_count is neither read nor rejected.  Since ethtool -L is a
> read-modify-write, tx_count arrives unchanged and the TX grow/shrink loops
> do not run, so "ethtool -L ethN rx 4" on an MQ adapter returns 0, generates
> an ETHTOOL_MSG_CHANNELS_NTF, and changes nothing; a following "ethtool -l"
> still shows the old rx_count.
>
> Before this patch max_rx equalled the live count, so the same request was
> rejected with -EINVAL by the core, which is why this reads as a behaviour
> change rather than a pre-existing gap.
>
> The commit message does acknowledge this:
>
>    "This patch only reports. set_channels() still reads only tx_count, so
>    an RX channel request returns success without changing anything;
>    raising max_rx widens the range of requests that behave that way from
>    the live count to IBMVETH_MAX_RX_QUEUES."
>
> and the later patches do close it: by the end of the series
> ibmveth_set_channels() reads channels->rx_count and calls
> ibmveth_resize_rx_channels(), which validates the range:
>
> 	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
> 		...
> 		return -EINVAL;
> 	}
>
> Would it be possible to order the widening of max_rx after the setter
> learns to consume rx_count, so no bisect point reports success for a
> request it ignores?
No, at this commit set_channels() checks
that rx_count matches the live count and
returns -EOPNOTSUPP if userspace attempts to
change RX queues. Read-modify-write TX-only
requests pass through with the live rx_count.
Patch 14 implements live RX resizing.
Patch 15 is the tip ABI: live rx_count,
max_rx capped once mq_fallback, and max_tx
at least the live tx_count.
> [Severity: Low]
> Should this ceiling be derived from a capability check rather than being a
> flat 16?
> The TX side bounds its advertised maximum by the CPU count:
>
> 	static unsigned int ibmveth_real_max_tx_queues(void)
> 	{
> 		unsigned int n_cpu = num_online_cpus();
>
> 		return min(n_cpu, IBMVETH_MAX_QUEUES);
> 	}
>
> while the RX side reports IBMVETH_MAX_RX_QUEUES (16) purely on
> adapter->multi_queue, even though the driver's own MQ default is
> min(num_online_cpus(), IBMVETH_DEFAULT_QUEUES), which is at most 8.
>
> The test also ignores adapter->mq_fallback.  After firmware rejects MQ,
> multi_queue stays true until the next open runs
> ibmveth_apply_mq_fallback():
>
> 	adapter->multi_queue = false;
> 	ibmveth_publish_num_rx_queues(adapter, 1);
> 	/* real_num_rx_queues is set later in open after resources exist. */
>
> so in that window ethtool -l advertises max_rx = 16 for a device the driver
> has already decided will come up single-queue.
>
> The mq_fallback half is handled later in the series, where get_channels()
> becomes:
>
> 	if (adapter->multi_queue && !adapter->mq_fallback)
> 		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
> 	else
> 		channels->max_rx = rx_count;
>
> The flat 16 does match the range the end-of-series setter accepts, so this
> is mostly a question about whether the commit message should say why the RX
> maximum intentionally skips the num_online_cpus() cap that TX applies.
16 is IBMVETH_MAX_RX_QUEUES, the ethtool
ceiling. TX uses the same max cap. The
default is min(cpus, 8). No extra PHYP
capability query this series.
>> +	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
> [Severity: Low]
> Can this disagree with the RX queue count the netdev core enumerates?
>
> The queue-stats side of the same driver deliberately keys on the core's
> count, in ibmveth_get_base_stats():
>
> 	for (i = dev->real_num_rx_queues; i < IBMVETH_MAX_RX_QUEUES; i++) {
>
> with a comment saying the split is bound by real_num_*_queues so it lines up
> with the core's iteration exactly.  After this patch, ethtool -l reports the
> adapter's private count instead.
>
> The two can drift.  ibmveth_apply_mq_fallback() publishes num_rx_queues = 1
> at the very start of open, and netif_set_real_num_rx_queues() is only
> reached much later:
>
> 	rc = ibmveth_register_rx_queues(adapter, mac_address);
> 	if (rc)
> 		goto out_free_buffer_pools;
>
> 	rc = netif_set_real_num_rx_queues(netdev,
> 					  ibmveth_get_num_rx_queues(adapter));
>
> If ibmveth_alloc_filter_list(), ibmveth_alloc_rx_queues(),
> ibmveth_alloc_buffer_pools() or ibmveth_register_rx_queues() fails, open
> returns an error with adapter->num_rx_queues == 1 while
> netdev->real_num_rx_queues still holds the previous value, and
> ibmveth_close() never lowers it.
>
> In that state ethtool -l reports rx_count = 1, the core still enumerates the
> old number of RX queues for netlink per-queue stats, and the per-queue
> ethtool -S strings (which use the adapter count) list only queue 0.
>
> No out-of-bounds access results, since rx_qstats[] is sized
> IBMVETH_MAX_RX_QUEUES and the live/retired split stays non-overlapping, and
> the state self-heals on the next successful open.  This divergence is still
> present at the end of the series, where get_channels() uses the adapter
> count and get_base_stats() uses real_num_rx_queues.  Would keying both on
> the same counter be preferable?
Yes, if this open fails first. real_num is
set after the resources exist; the helper
only publishes the count. The next successful
open calls set_real. get_base_stats stays
keyed on the core's count.

Thanks,
Mingming

