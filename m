Return-Path: <linuxppc-dev+bounces-19843-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108CAEA71A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 00:13:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzQtT22Gtz2xTh;
	Mon, 20 Apr 2026 10:13:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776643985;
	cv=none; b=fmTiLC7pl6QbKCxX9a6SGWpuLdaW3mGF8GwXPeLwRSM33OnLAjbhP4qXIAoK2ROGjuCJHsn4LLamCqT1fC8ash9jUCKyemYSJBn8bioaAJZHNYf3ozjDYAixXNCXgBaQx5pj9N6RQ3NTYYHyAPQpWSkVlYADnK4FZUJVpvynRN9UYrF3MTaVoIwRhjOFcZjibCKjeRR0BvoJt3xNgykcrHIeNqmkvSP4wMR+P8vwo6FqqJQwIqahFGfiFtsx3yZx5JOeCHgciNFVU40Ndklp90QYcN0dw28bUVcBPucvwwUJaefSVrQOfj9SRTpuoVX2pBmItkqZbO7AfjPiOQl6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776643985; c=relaxed/relaxed;
	bh=aZBdItkfAsnP3W4OIPRwFKg8WBJUd9YO47VwRzMsse4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4Iy7W6uigNQrX+XRLO1Qb7BRkw1GilG39bvYcoGrcgzzz/PSqdF4z1qubO2e69MfJMKN+X53D3LPl2cy/40VEDzRhH2e2zM7v2xjenfHmTimVdS3a9tSCQmLVm0MnGm9HyhE0pBsctKWKCKDKjqrTb9ylcWsV/QM9sPt/sAgYwSCZ82NCaX867MyXiZ7WU3zMjmTeF3fFe3h3dLr/mDzlSFJzefBWpZi6R9ta0UbQq/1bOpg7tmMZH7ZfHmRZDD8ousuzXfWXmenDsiz5J6zylf2dzxXU5RJ6CU+IVlSzSQJyU7xIxNFtCYlwa5lPYJxsj3CWsXA/urQIx+pBE0dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YMCfY0nv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YMCfY0nv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzQtR58fRz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 10:13:03 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJjOLY2986195;
	Mon, 20 Apr 2026 00:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aZBdIt
	kfAsnP3W4OIPRwFKg8WBJUd9YO47VwRzMsse4=; b=YMCfY0nvUOHNNv1jrxoaGT
	HCdM/0wahsGi1rWOXRjIBLkUl6sfW84NefA+Q6ax5sIY9GgaxO2g3zF6yTBh6Lvz
	/8m10na03tz6nLUl4rXq/FBOOJbWEbGhd8Rv7iRckYfBXf1csEREf1mUGgzILOTq
	zT0BoAJqyJ4L6TZEQFjNVKJbfL2lOYQUzwFvrtsvaZI+NQwY+O13gSqDe3/BvdiC
	KM5oZtUQGS5dB6AuQPWm9HeWoAzXURJFPrvSeu9NfPapm/TYmdtqeNCrlKvJUVI8
	rxIFCoXFgaH1bvh2xYU8UHqlDZNg0v5a3V4h9EJLMqGPUs9826k3zryY8erlcV8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6dj2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 00:12:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K05Ktf031623;
	Mon, 20 Apr 2026 00:12:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg2mms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 00:12:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K0CgYo27918956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 00:12:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BE1B58058;
	Mon, 20 Apr 2026 00:12:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB205805B;
	Mon, 20 Apr 2026 00:12:40 +0000 (GMT)
Received: from [9.61.89.198] (unknown [9.61.89.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 00:12:40 +0000 (GMT)
Message-ID: <dcc2b7b2-47ac-475d-af6b-d5c2f2b812b6@linux.ibm.com>
Date: Sun, 19 Apr 2026 17:12:39 -0700
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
Subject: Re: [PATCH net v2] ibmveth: Disable GSO for packets with small MSS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, shaik.abdulla1@ibm.com, naveedaus@in.ibm.com
References: <20260417172910.81433-1-mmc@linux.ibm.com>
 <20260418175451.122193-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260418175451.122193-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDI1NSBTYWx0ZWRfXywkL4mbph7pn
 y9NDpS8ktWEK/Wt4Fwq5/CuAM97+q0nNiMhqGZaFuUiQw9x1UCKTP/kkMPoF7J1fRI9KDZWut9T
 P6MiRMGKehdZtNTgQLsvcMnwuWQDrOpTYJd8baM/IM5HZc7QQd4ojtHZTXuVNVHVYe0Y4LHkUy8
 NLXDUIQyljIQdV/2gUNYnMZnRxeV9F4/XSM3cTdU4uyborwffjqa3yZNNJ+REwSF8X0BXgHHV9D
 XURHdprmg7h/F8Lyp/aDfZN4bs547Ay8rRr/LF4UFwawjc0/8UfBU0kWrbasJrnjrLUhifaP5fo
 yZ3oB8TRpMysbe1KB3sdrIgAgH7raUfWm3i2SmhibM2HlOo2RxuwTzeE2HVK86A1TgDWoBud/Ck
 2+Gnh8NnRboVZPUgCc6J5xTbI1lpjtjH+rGkQbUGfehvw0910gk2l0UApS1sayntunEe6ZKUeP5
 GxSKH4WS5DraFJaozAQ==
X-Proofpoint-GUID: t6hNByzCcWjgl0WInHRfkkYPE8JpykPZ
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e56f7d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=sDADSKU7Kdt2IJdVO5YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e1yCFhD-mX4ZlgjEllJFepkfqH0W5lmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190255


On 4/18/26 10:54 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Thanks for the review and the questions!

> ---
> ibmveth: Disable GSO for packets with small MSS
>
> This commit adds an ndo_features_check callback to the ibmveth driver to
> disable segmentation offload when the MSS is less than 224 bytes. This
> prevents physical adapters in SEA configurations from freezing when given
> small MSS packets.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1756,6 +1756,25 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
>>   	return 0;
>>   }
>>   
>> +static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
>> +						struct net_device *dev,
>> +						netdev_features_t features)
>> +{
>> +	/* Some physical adapters do not support segmentation offload with
>> +	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
>> +	 */
>> +	if (skb_is_gso(skb)) {
> The commit message mentions this matches the ibmvnic hardware errata from
> commit f10b09ef687f. That commit disabled GSO for both gso_size < 224 and
> gso_segs == 1.
>
> By omitting the check for skb_shinfo(skb)->gso_segs == 1, could a
> single-segment GSO packet still cause the adapter to freeze?
Good question. Unlike ibmvnic, ibmveth does not need to check for 
single-segment GSO packets (gso_segs == 1).

In ibmvnic, the firmware processes all GSO packets, including 
single-segment ones, through the same LSO code path. This means even 
gso_segs == 1 packets can trigger the hardware errata.

In ibmveth, the PowerVM hypervisor intelligently bypasses the LSO path 
for single-segment packets. When gso_segs == 1, the hypervisor treats 
the packet as a regular (non-GSO) packet and transmits it directly 
without invoking the problematic hardware segmentation logic. Therefore, 
single-segment GSO packets never reach the code path that causes the freeze.

This architectural difference is why ibmvnic needs the gso_segs check 
but ibmveth does not.
>
>> +		if (skb_shinfo(skb)->gso_size < IBMVETH_MIN_LSO_MSS) {
>> +			netdev_warn_once(dev,
>> +					 "MSS %u too small for LSO, disabling GSO\n",
>> +					 skb_shinfo(skb)->gso_size);
>> +			features &= ~NETIF_F_GSO_MASK;
>> +		}
>> +	}
>> +
>> +	return features;
> When implementing a custom ndo_features_check callback, netif_skb_features()
> will bypass the standard dflt_features_check() function. Does this mean
> vlan_features_check() is no longer called for this driver?
>
> If vlan_features_check() is skipped, multi-tagged (QinQ) VLAN packets
> might retain GSO and protocol-specific checksum offloads that the hardware
> parser cannot handle.
>
> Should this return vlan_features_check(skb, features) instead?

You’re correct about the interaction with the default feature filtering. 
With a custom ndo_features_check(), the standard dflt_features_check() 
path is bypassed, so vlan_features_check() must be called explicitly to 
preserve existing VLAN/QinQ and checksum handling.

Thank you for catching this! I'll send v3 shortly with:
1. The vlan_features_check() call added
2. Updated commit message explaining why gso_segs check is not needed 
for ibmveth

Best regards,

Mingming


>> +}

