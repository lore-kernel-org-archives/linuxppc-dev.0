Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F7606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xmyy9OyU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJtv156gz2xnQ;
	Thu, 19 Nov 2026 11:17:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795047431;
	cv=none; b=TQX6yPd0SquzRZFOtAibRItmg63NfN46ncM3grp6D4M1QhjpnMwtcEkYUbWCcQZW+DFHpc+8BuMYK6pxe93jcsnPnExAvEAqe2Otlao7V56bL2YLQXFSaQWweujUzp4QRHEP/BI9oCpxTvNmY/uKX9mVqgwYtYowz9M9B/aGguockvWdAQ3eJ/IdobsZ63HKOxHcfxrawRhvcyAl5KTueDWuT0gUqiaR7HdaiZdc6icQJwQoHDdLiF+4MHNEk4MOKCkWBqFwC/4mI4WalEB646mmVW7/r4o3/+cKfV+07iuW8Op+0OeBLECc25tRJ/LqYnHj8vEVrxm1BwGUKfWxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795047431; c=relaxed/relaxed;
	bh=xA0UJdaWjcLJwESH6GytqwneDgaiE76tWOywSb/nkYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImGlNAeI1rkbPpGoNSIq8DkZrhb6RkIS5MbIB6o81dnq+kV/rtFbKmBxztpk3BJ1+uzIXHszs48AaL8bglb8AkuYSHktI7rsmOkxV/0XAjl8MKB0BeXtRcB3Qu0WOiPyFBtsy1qXNgnDMEskGce4VCVnb+y3/TSOqj6hBMTm8bGhsc5pJRkNwOUYn+QfW8lL0KkKglOHW8lNIJXzELZTWkCssXZykUUjExfmE+ex2nzSXd1QdsuILHCpFS/t+gwq5QGzplbMcSyycWop5VIm8w3u8+JeR+2y/2ktOrYdaeF9zp/K8/x9SOHvl+iNAEvbKQl7LmhL1/8cF9OAeUQ9Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xmyy9OyU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xmyy9OyU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJtt2SsLz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:17:10 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQJlO2200331;
	Thu, 19 Nov 2026 00:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xA0UJd
	aWjcLJwESH6GytqwneDgaiE76tWOywSb/nkYI=; b=Xmyy9OyUMfsCqoLEnMV58E
	m99lLRtNmt+dSEaODtScwyWNqsSp3dQjf7ftvJLkw/skD0oZz9/DU8EhmzglJVH6
	KQwk4tlAovq7hRTrKAVpfTT1qQsrzP3KpSnDdMQQZFIgp4pLUnMlYmcvf+d4B22P
	YlCOLp25Kd4jIUPbW1KpZMmT/XdUJ1yeJMtcxSrjrYeFg3raJcJnkGWkAZmyR4Mc
	oDe6SEL159etFUfTRnV4g3hAu0c7Q9SaoyLAEF1E3awAd3gwyK19MKsGOs1PdLjq
	U/DhCcp4qolaStA4Lqqv2xTYTIlyu3nKpFVHcNPUtQjdXJTn+KrHarFlUJQcShrQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105ww5k1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:16:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILbI6W3716116;
	Thu, 19 Nov 2026 00:16:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3hre74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:16:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ0Gu8F11469800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:16:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B0658060;
	Thu, 19 Nov 2026 00:16:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077335805A;
	Thu, 19 Nov 2026 00:16:54 +0000 (GMT)
Received: from [9.67.93.165] (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:16:53 +0000 (GMT)
Message-ID: <614b3ef8-0e00-408b-a960-445c6bd2e405@linux.ibm.com>
Date: Wed, 18 Nov 2026 16:16:53 -0800
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
Subject: Re: [PATCH net-next v8 09/15] ibmveth: Split RX poll into per-slot
 helpers for MQ
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
        edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <20261109235556.60604-1-mmc@linux.ibm.com>
 <20261109235556.60604-10-mmc@linux.ibm.com>
 <20261116174018.6cd71ba5@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20261116174018.6cd71ba5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wTXqsLce92opVevaF0ucAAkeQ0oK3Kg7
X-Proofpoint-GUID: _bbz2iPGCP73pYV0sRuISME3X1GzWOpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX3TsJUPeTfUJ0
 af2Nuf8WkIrYnWsUHAeSbPX/JgBdjfb4YVEpwlG9NZ6FDHKZ2aKdehDc5iOlzgmYXMa8igpiD/m
 wJiorDyx7uaBmCfyMjLNSi+VWP3mGN9S5pb5KK/hk5b4uKfZQBjirBe7k5iQaOUbfQE9jwuIKxU
 RSI0Tmg8jKFxfxc95IOwsGuCAEzk8fioQ1sVDPxmc8olZtAn5os8m8/qHw4+Lx2SLvTYAdK3wHf
 C6Chvb45C+nEWJy889gH1hkGBh91jo7wfu9JV6Cka4v+JjI+DBJTUm5TOdZyNWnMjlfjiqBkA13
 48bIrJa92dKpMpXJ74wIwtDKrlb9qx5JW+Hi9ZnNlw7jNAt3W6+H6FXVF3i9a3wYpenyIzPQDfr
 rlCfekvqMNGrAfs+JwRKdEONJr8lMJ/lfRo5vX4ZukoEwVXpkAWT7lmKydZTkTc9FM1asqCdes4
 SEi1/9n+JZjdsB4e2qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX2Ub2+9IIRX+N
 Gbt/jZhXaV/LQOmKh1Q5y5giUNhXqCU46JakryFWi+megy3r7Xw9We/SmG63U+JtvvXgjirYleG
 Zchs4+SGqL4VOfJQMBUZ7gawe3HmiVM=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afe3ffb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=t5fRNr4mx1plWV7DNOQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180088
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/16/26 5:40 PM, Jakub Kicinski wrote:
> On Mon,  9 Nov 2026 15:55:50 -0800 Mingming Cao wrote:
>> +	if (WARN_ON(queue_index < 0 ||
>> +		    queue_index >= adapter->num_rx_queues)) {
> You add such checks all over the place, why?
> The kernel coding style explicitly recommends against defensive
> programming.
No good reason: no caller passes an out-of-range index. They are all
removed in the split series.
>> +		if (budget)
>> +			napi_complete_done(napi, 0);
>> +		return 0;
>> +	}
>> +
>> +	if (ibmveth_poll_stopping(netdev, napi)) {
> Why are you checking if the NAPI is stopping?
> Maybe I missed it in the avalanche of words in the commit message,
> you mention live resize, which I assume is patch 14. I don't get why
> you need to explicitly check this, core already does.
Yes, it was for patch 14's live resize. You're right that the core
already handles it.  The check will be removed in the splited series.
>> +		if (budget)
>> +			napi_complete_done(napi, 0);
>> +		return 0;
>> +	}
>> +
>>   	while (frames_processed < budget) {
>> +		if (ibmveth_poll_stopping(netdev, napi))
>> +			break;
>> +
>>   		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
>>   			break;
>>   
>>   		smp_rmb();
>> -		correlator = ibmveth_rxq_read_correlator(adapter, queue_index);
>>   		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
>>   			wmb(); /* suggested by larson1 */
>> -			adapter->rx_invalid_buffer++;
>> -			netdev_dbg(netdev, "recycling invalid buffer\n");
>> -			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
>> -							correlator, true);
>> -			if (unlikely(rc)) {
>> -				netdev->stats.rx_dropped++;
>> +			if (ibmveth_poll_recycle_invalid(netdev, adapter,
>> +							 queue_index))
>>   				frames_processed++;
>> -				continue;
>> -			}
>>   		} else {
>> -			struct sk_buff *skb, *new_skb;
>> -			int length = ibmveth_rxq_frame_length(adapter,
>> -							      queue_index);
>> -			int offset = ibmveth_rxq_frame_offset(adapter,
>> -							      queue_index);
>> -			int csum_good = ibmveth_rxq_csum_good(adapter,
>> -							      queue_index);
>> -			int lrg_pkt = ibmveth_rxq_large_packet(adapter,
> You should really factor out the pure code movement to a separate patch.
Done. The poll split is now movement only, apart from the bad-frame
message naming the queue. The behaviour changes it carried had no
reason of their own, so I dropped them rather than keep them as a
separate patch.

Thanks,
Mingming


