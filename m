Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252AB606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S8+9sYhx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJzg4xxxz2xMt;
	Thu, 19 Nov 2026 11:21:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795047679;
	cv=none; b=iAZ06Nrri5+d+KYuKdRPbfACh4p8QdaU3nminPi3qSgOe7wArs5kchQvJ3Y1smigvCzGBOMRm5PATiGk8ql/RBzWc1oqkgeqIjUSiuo5SIIsx2ziu/rpgIZER0Llz559R90eVhRxZS4pfbMiG5Mny5azR4EillL40yugEL83Dnf9On2E861puKn7eUbqJ/vh1P+slNQ9BsUv5djFGBx3cArwYgdG4r+vqaK6J7QIr8neVt6y0C99UXN93dh8DrdmIDbfWB6QBBnK2QN7+Wt+vKpWethJZXdbEiMY0kyUyN5rgxEPkZju7rUEwMjSkyxWFo3EmfRmPJZ1/Zo8SDm6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795047679; c=relaxed/relaxed;
	bh=y9g/SDWQtT1UZ868nSgzjGHvZwGb3p08ICUn3gSdGq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcUc+WOmlC+NL3xDct3B0sCNZ8ECfiu/cuP/AYQTMfKKgSoQmEOPc9LYW1I9PpSh2fhr4ErJ32jM1JlB1Txkxlaxc5p7ZVR6GwFsOI3pJ3hl7qdku5WNHYEryCXaPkct7Yggs6YTdVIvR+k/z1zpku4NzuSsnuSygW8ZPvsuSzHN+rRNJ8FEkV5lz/IKLkeCAxrY+GQ+Cg2arg+zz4rjrNBmXSgLt1AYeGSz4wPnkrumEli/zAuxfpWzQrZm2hiNsA3pvpqhpoFe9HJwSZjUrneyMj4ZhtOrlT9jpifkWwA1mQzqzX3GaQn7a+w5qF4PAf6oeq9MNF/ySM3/hOsjuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S8+9sYhx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S8+9sYhx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJzf3wWtz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:21:18 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQcHe2240616;
	Thu, 19 Nov 2026 00:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y9g/SD
	WQtT1UZ868nSgzjGHvZwGb3p08ICUn3gSdGq0=; b=S8+9sYhxSH4DVaR2DQBlgj
	asOvlKTXg237kA6EJf5B309uYp/nJY9zLzNDEiAOfmCO3dhVvCijDzGrbQ1ctoaB
	OKK3ifORzqJ9gOVVbo4/eHqEod8fNaoH0aV9AFduPv4bKMDmcCX2oIt5EFpKdYGQ
	pEWVtZP57zwo8SxMcrHVbYdj3VDOimE18/T29tqr9jflPgcM9dGvaJy74IfBYPfY
	frRkGOg0OQBELBrE4AJwfyKLZ5DLsJV+knqhIKV5Ulp7qJIHFf/pAG+L18D5M42G
	K0grNbH79sd37RQZxr3TyPiBdvJMf3oq+eUOvxeYa8T3cOWI5Fc1aKPG0fMMUenA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vn735-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:21:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILK4dq2652048;
	Thu, 19 Nov 2026 00:21:06 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5adyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:21:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ0L3bK197452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:21:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C81A58060;
	Thu, 19 Nov 2026 00:21:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01C895805A;
	Thu, 19 Nov 2026 00:21:01 +0000 (GMT)
Received: from [9.67.93.165] (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:21:00 +0000 (GMT)
Message-ID: <d3f613be-d545-4918-92f7-0196d50449ae@linux.ibm.com>
Date: Wed, 18 Nov 2026 16:21:00 -0800
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
Subject: Re: [PATCH net-next v8 00/15] ibmveth: Add multi-queue RX support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
        edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <20261109235556.60604-1-mmc@linux.ibm.com>
 <20261116174225.7d9e9611@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20261116174225.7d9e9611@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Xqeim3QM5e3K8oyRVD0aSg1w3CPk4a6L
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afe40f3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ws_xIJfpYnSn7AQFTckA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DlVZAw_XXSlXZSrnYbTRHGjH5H2rAeYw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX5/fgsQW2niaE
 MKcQhNIZ88pAyAcDDfzRRr6kX2qOVBndebQsxHNrlT9ChAFqB9Gu2OZM2VuR3El9epy82WIrs+W
 ys9xAVe+0pfI3gy7IAjTFbM2669sG16+utF/ar2XgPHCCX+4BACzh7dZapR+xAS1FPPKYd+BIaC
 +x4bHimY2bSRg9+lhptdiSV7js+Pj14Mq2jAa67hSC4C5br5/jlC/0Es/Z/u1hK0yNtdrJZSyVg
 n9VNwkLo7EQN4ujbM4PT26Vus0fTpCbquwMt6dt1x+By0N49iykuaN6WIBDrkC6bdTKEKQmvsoj
 GVuU3H2uKK56CEf4Z7faxPDvnwQokMyS3bUT/MQJkG3WFpUbb7vLxLootCcKQdBpEmF4VMc0XTl
 vqAmRctOtbi/5yJeDSSFiew43pyxnSRmRQsEb1BjsFnO73h/ESIpcglIIdZHPmMzDlVV8eA7X/m
 d3gE5qg7UOpHy47XMRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfXxIuRbqaOMfK0
 hxs1BwBZg0W36cijM6nLsWl/IE8l6h7cpT0JmDbGgpnc/1yQY0HmWu/9NKhZz9w0i0eqknjWFjO
 kPYpC6uWSy4Kls7FANOei7m1JR35bVs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180088
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/16/26 5:42 PM, Jakub Kicinski wrote:
> On Mon,  9 Nov 2026 15:55:41 -0800 Mingming Cao wrote:
>>   arch/powerpc/include/asm/hvcall.h   |    6 +-
>>   drivers/net/ethernet/ibm/ibmveth.c  | 5007 ++++++++++++++++++++++-----
>>   drivers/net/ethernet/ibm/ibmveth.h  |  240 +-
>>   tools/perf/python/powerpc-hcalls.py |    4 +
>>   4 files changed, 4318 insertions(+), 939 deletions(-)
> This is way too large, I spent half an hour reviewing and only gotten
> to patch 8. There's no reason for the series to be this big. The 15
> patch limit doesn't mean you should try to cram as much as you can into
> 15 patches. Please split this up into (3?) smaller series.
Thank you for the time, and for being direct. You're right, and
point taken on the commit messages too.

The plan:

   - net-next: two fixes for bugs that exist today, posted on their own
   - series 1: prepare the RX path, 8 patches (928+/431-, net +497).
     IBMVETH_MAX_RX_QUEUES stays 1; same hypercalls, no new ABI.
     Patches 1-5 move open/close onto helpers, 6 register/teardown,
     7 a queue index through replenish and poll, 8 splits poll
      into helpers. Your 07/08/09 comments are all addressed there

- series 2: the multi-queue work itself: the new hypercalls,
     registering the extra RX queues and their interrupts, per-queue
     statistics, turning multi-queue on, and ethtool -L for the RX
     count. Posted once series 1 is applied

I also narrowed the scope to what multi-queue needs to go in. v8
resized the RX queues live, without stopping traffic. Changing the
queue count is a rare admin operation, so for now ethtool -L closes
and reopens the device, as an MTU change does. That could remove
lots of complexity code. (Live resize can come back later if users need it.)

On the three series you suggested: with close/reopen the resize could be a
single small patch, so I'd like to end series 2 with it rather than
post a one-patch third series. If you'd rather have it separate, I'll
split it out.

I just mailed out the - net-next: two fixes and series 1: prepare the RX 
path.

Thanks,

Mingming



