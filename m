Return-Path: <linuxppc-dev+bounces-24334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D41C4450A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 03:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1Zcq3pBCz3bqD;
	Fri, 17 Jul 2026 13:08:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784257739;
	cv=none; b=JVtF6NEwEFE3ptCTGFfbxcoQXaq8akIQyBIlnVdVED749o9UFMb+lR0OABvdPX20VRZSYSMSqsMJKtUeEdEZ65RirULMzBGbMaaJ9jfZG2sZ9ZfRdqjM0pnhDSwM43pmLWY4ZYs+ab7AnnyGU8ryefyeATLoOoty4XLwqfoUqYHrmc42G/zaMM0P7leCLnkNfhKY28ZBzdkeM4gSPTKYYaXb7GnvFRToL9DL2DNn8imFCHBsoJ8TRy/8PiVHUXzXdvcSfgiF6vNu93BrDU9LsQZiwjMgMB/DMxR/CQLpjkGpd6KbO7zD9ImTQ6pTFeOrzggtLoZRSY7pzLChnLPtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784257739; c=relaxed/relaxed;
	bh=S82E3EjNNGbgK4VAidPgvm6IUiKAQ3ZMbFuR7UCjtVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcqjaaroWJtMqbmViIZ9PRmQIdLwSJgavsYaVO++MqISKu/vk6BxBfE4cKfpOTySRvpJIzMN7dprpcGp6OzWtc2eNj+mdiek+7Cb+XTm7YTsYtZbAEan4+GLtUfDSlLiA5stJrZi7ZCy5qo4nQgG9+gJv+iBLPh3O03B1gXDcbgikUfYA5UBUWSNQ73jb0+q2NVhRAYjs1OvUsrZinTTCTNyMOwjfKOl8q738WND2pUdR+AI6S0EzECgTLAZmw1FmqAextYII6jT8ZyWl5fLPXwEkb0m9tFhzPaT2EOdlFRPgAGmLE+0IcY74gAwSdT52SO6YjBGTLE3K3G368SC0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GJeWefVv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GJeWefVv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1Zcp3m2Mz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 13:08:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNfuY5365048;
	Fri, 17 Jul 2026 03:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S82E3E
	jNNGbgK4VAidPgvm6IUiKAQ3ZMbFuR7UCjtVM=; b=GJeWefVvxjZzx8yyP9A8a5
	jb1p9N3GjJAHcStO89TYDtkt9cacoa5ZOaIsLgLMSXZXElXif+az3C0EZIPlNRND
	eSvj1WOM+daYdFHj66BegBZ+DebirJYgENN0XmE26Wr0hff4JPEyus4p/1+YVYh+
	ZdIxo5Cun4KtRs7vhfHuLHSBYq+LCfslFozdWquvLa5PPkJxFSRcWm7Q2EW+maJM
	0DSU4sgkZwyWmxYzwKi1ArT1yTutnmknTH4pqbI3lf2f3Vy81LYZaOWoTlaGonsz
	443F0vROSqP0MDHrBPA+pOFNtVQBqNcynLNuYh1WF4JBuiqV2YAkn8pI04ZQTv0w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2akcnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:08:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H3522d009153;
	Fri, 17 Jul 2026 03:08:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhqtgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:08:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H38iUb15401618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 03:08:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C61558063;
	Fri, 17 Jul 2026 03:08:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E61305804B;
	Fri, 17 Jul 2026 03:08:42 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 03:08:42 +0000 (GMT)
Message-ID: <0510c106-7ee6-4100-86a1-bfdfdae8ca19@linux.ibm.com>
Date: Thu, 16 Jul 2026 20:08:42 -0700
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
Subject: Re: [PATCH net-next v3 15/15] ibmveth: Fix MQ RX poll and shutdown
 hangs after queue resize
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-16-mmc@linux.ibm.com>
 <20260714131053.1844276-2-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714131053.1844276-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfXwfm0XknqAa4N
 VMBXgE7s0ckZUqmiG7biQitG3pA2sv8vrZqGUmfq6kDKpp616T3P/zYFjk3cmvU9nPF3AKAsXf3
 lD7ol5TItkC70+Ru00/QvQMZDLiqjcs=
X-Proofpoint-GUID: 0zx3wtyEskpsaPiTcECwUvC3gwGrwCHH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyMyBTYWx0ZWRfX/HHB9S5nXR7J
 L8l2muMOnp0Hi4XfuuihOfWS81WwRdeamUSt05hJ+G/yZmg0yk6+/B7CKC+KV9RoK9lfRCVXwz7
 oS9cJ6TtQKRohuXJR9Z4CtZf8KlYf9AdJdrCB16Ifw+USnIjQsopYioR2EMJ64rmjF2R2/e0kGS
 2+/6X3oqZUW4IK3hCejTEfLpXWr/Q+ZPXVPIDEfblfgX7Q+248zx0+FVuYOyKZupPQnZ9ClTm6s
 UbEgVxIWVgcglmIcOquVOmkcyK/YPxzT/rh7GbYQnrUbUs1JpJw7pEf1WIlmON/BTQrBpR1pOtG
 r+5Ga1QXZuQ+rcFmKgUFPp48zHViIzKgHbhtVzIUub4UYHXhUElHJREecc3Zhtyd6CghZ2BTO9n
 pMQ/Uz6cAKyhJyBjbLBJLNxLVg14zt36wry4CsrxEaYtrRmRTEs6hc2GG9XkdmUk3aUxt5gMBJC
 A93/535dXAvvF+qGXnA==
X-Proofpoint-ORIG-GUID: noBkPIxWF8qj7DLKQcEnmg2F8yoTuWtW
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a599cbe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=xZpLByrsDzKB3dXjTIgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170023

On 7/14/26 6:10 AM, Simon Horman wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
>
> This commit fixes polling hangs in the ibmveth driver after queue resize
> by skipping over bad correlators instead of retrying endlessly. It also
> ensures NAPI completes when the interface is down or being disabled.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 50a332ab83fd3..eb84b4e5f69fd 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -2959,8 +2978,23 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   			__sum16 iph_check = 0;
>>   
>>   			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
>> -			if (unlikely(!skb))
>> -				break;
>> +			if (unlikely(!skb)) {
>> +				if (net_ratelimit())
>> +					netdev_err(netdev,
> [Severity: High]
> This isn't a bug introduced by this patch, but can the unvalidated packet
> lengths and offsets from hardware descriptors trigger an skb_over_panic()
> here?
yes
> Further down in ibmveth_poll(), the driver reads length and offset directly
> from the hardware receive descriptor and passes them to skb_reserve() and
> skb_put() on the reused SKB:
>
>      int length = ibmveth_rxq_frame_length(adapter, queue_index);
>      int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
>      ...
>      } else {
>          rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
>          if (unlikely(rc))
>              break;
>          skb_reserve(skb, offset);
>      }
>
>      skb_put(skb, length);
>
> If a faulty hypervisor provides an abnormally large length or offset,
> skb_put() will extend the tail past the end of the buffer, which triggers an
> skb_over_panic() and causes a crash.
>
> Should the driver validate that offset + length is within the known buffer
> size before modifying the boundaries?

**

*Agreed this needs guarding. I'll add in v4: validates*

*

offset + length against skb_tailroom() before skb_reserve/skb_put, and

skips bad correlators.

*

>
> [ ... ]
>
>> @@ -3034,8 +3068,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   
>>   	ibmveth_replenish_task(adapter, queue_index);
>>   
>> -	if (frames_processed == budget)
>> +	if (frames_processed == budget) {
>> +		if (!netif_running(netdev) || napi_disable_pending(napi))
>> +			napi_complete_done(napi, frames_processed);
>>   		goto out;
>> +	}
> [Severity: High]
> Does calling napi_complete_done() here conflict with the NAPI core contract?
>
> If the polling loop exhausts its budget (frames_processed == budget), returning
> the full budget after calling napi_complete_done() might cause issues with the
> NAPI state machine. The NAPI core (__napi_poll) will operate on the instance
> assuming it still holds the NAPIF_STATE_SCHED bit.
>
> If napi_disable_pending() is true, the core calls napi_complete(), which will
> hit a WARN_ON_ONCE.
>
> If napi_disable_pending() is false but !netif_running() is true, the core will
> add the NAPI instance back to the poll_list. Since the driver cleared
> NAPIF_STATE_SCHED, a subsequent interrupt can trigger another napi_schedule(),
> causing a double list_add_tail() and potentially leading to list corruption.
*

Good catch — completing and then

returning a full budget is wrong. In v4 I'll complete on

shutdown/disable and return a value < budget (same as at the top of

poll), and leave the normal budget-exhausted path returning budget

without completing.


Thanks,

Mingming

*

