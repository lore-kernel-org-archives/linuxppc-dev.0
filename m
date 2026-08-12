Return-Path: <linuxppc-dev+bounces-25752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3138EC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 03:17:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKYZs0Dj5z2yxN;
	Wed, 12 Aug 2026 13:17:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786504660;
	cv=none; b=FLqpzc4zIwuWXpIpfbmLAFp/lGMYnEaLhNDzEmDvPxZf3/j2rK6/lpjulSfe4Ky3XF/NLmu9s4W4Dl+8RuH6EcBsMspaXai4UoEWslzSeCsqGwmwqmIhtT6mFOF7JLbCNgn9nidiKLl0sS0scipkM2hrrjeTV7Rq9SPjyy8AhlXXqbYs+XaST2I9jGtxpzT+V/kplLKMP7u1TjEyzW9nSbYLOB9dkR5kntSqBdTy4IXFu24J3FR8t1XQ+PSGHEKEo8OsmQewrb//IQ6AKpSDTACYSX0qeY50RXF+xcMCiVI9SHWv7LHSPYeooA9bYE/HkklU1KW40Xn/Chwm1NciVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786504660; c=relaxed/relaxed;
	bh=TWnIukl0Eztet3TExvMc+VX3Agz0mfeEVQVyxC100g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXdKTkd+4HuI6XTyjlJl2sc5/ETib5KCAp5R8gzpZFgW16ADZ6oQP5nVgT2fd0GXch5pKjhRRcafOA5a94J09LiO6r+HDmMPsiAva4wyF4pcL3XHTd1Z09uyD+esXvIPJk4xMsLDa9mRcWZu2tWKNoAKQQjBAnxhOMUTzWg8k1KBFe/DxV61LSANH/p596hqDJyO45Ngt4rg1l14hdrPfis1DFFyOV8NIKmT1TC3ZEc7tV6WOBl31mCC56smJQOgl4TUM+I2jwg6clcX2DlW50Tzy8484b0Y+W+QPmXU4mB1r6dqHujHyIdisLhEJqhk3evpUmbd/aNuEuy/SV3WAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=II5I3C8c; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=II5I3C8c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKYZp3SW7z2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 13:17:37 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31Ywb2284959;
	Wed, 12 Aug 2026 03:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TWnIuk
	l0Eztet3TExvMc+VX3Agz0mfeEVQVyxC100g8=; b=II5I3C8cJ+yIyuT2p6bjcO
	8VQ8Ut2ShZqo1rYuE8ytCJve/u5rRLF/HA61oxSzueJ0esljgIFpy/Z28gNrSUT7
	LtWEkbfu3bo5GYNfjMf2UelRlgS6S7v0eYlZZ7rPYdGlkevVFvZFEpggwpXnN1Vp
	XizSbpjHPzdSqHDrjtaOcpEd9UveH5WZXSYHvMXvEXVWsIvPJFiZV+RBbtdEX/FL
	gvaSTU6D2iqgvuzA7YBC5wDxOoqDMAEQRdK3HqFFunI2j+JZA1nfDGMDy3qexPlX
	S3Y+WTAaZ5M8kw+R/YUWLJMwe07eCCuMI2/Nhjd+BMuRoFBl0tsGJTcWy32E98fQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9rj6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 03:12:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C3Bc0Y032311;
	Wed, 12 Aug 2026 03:12:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjv7q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 03:12:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C3C5W350856292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 03:12:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F7620040;
	Wed, 12 Aug 2026 03:12:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B91862004D;
	Wed, 12 Aug 2026 03:12:01 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 03:12:01 +0000 (GMT)
Message-ID: <b650f898-f0f3-4223-a507-3d833ab5c725@linux.ibm.com>
Date: Wed, 12 Aug 2026 08:41:59 +0530
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
Subject: Re: [PATCH] powerpc/kexec_file: Use inclusive range checks in
 add_usable_mem()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260809162403.18142-2-thorsten.blum@linux.dev>
 <ee531113-5a56-4e6e-bc16-95941aa5bbfd@linux.ibm.com>
 <anr_k9jzc2QYjsJz@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <anr_k9jzc2QYjsJz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAyMSBTYWx0ZWRfX7vYn22qtBf+R
 NV05vUAyfkWKwSKz8F76muRJPFRJ7iHMnP8JHrmMgIc0iEQNp91YKKiIM/35whRLBV5sTa3T8e8
 nHemB2EJ4/Q3/p/uR7nzKCAo8+snfdkIdkV1GJif5bQEYnLIgsUxYQCC3Uo05tohhnpLh6ydjgB
 lOPqIL3GJUX47BYsJZaQPkhexKvizQhMc1jEyI7KZdqtBPAfMruEGWYwLR4JdjK8ZpJ/NXsJjXX
 kmTnsFGeZ/xd+TIOpLplma1JGufjmiFZYPKs0MkA23y3O63P55cw8fpDDSYUB5Qezxf2iii5WIv
 LJbfA+L9ckrISEcbNHcMRRxrx9xLPI66kS7UrxZPXxfq93ZtFlIjhuJLRQKF/GBkBZZ4+RZYizx
 nU+A1KAdstd1WGqvvpNaLVGlHzcccNcBdhNFva09xLs+lu4WpT3O1NPH0O+qbLgdHnFbzKLHLS5
 i+HL0zzpN1BrHXnoN3g==
X-Proofpoint-ORIG-GUID: Umdw_SqfciE71JtB2jUmxEcJIxp9JETH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAyMSBTYWx0ZWRfX5Y7NDk1XFuYg
 lUOX01giTNWC1k8UiHuFsi5kGjboQV73DXXDuJjRzy0xEMYjvi+aredv2VDgd4MH787BMgN33pz
 mOJ7pEaeCOcjGzkrP8o7qgEhlcYSPMc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7be48c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jj04caz6BRDygnwrFwgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4VbLhUPN4kK0ZTQh0zwe7qYkUa317ppU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120021



On 11/08/26 16:25, Thorsten Blum wrote:
> On Tue, Aug 11, 2026 at 11:51:46AM +0530, Sourabh Jain wrote:
>> On 09/08/26 21:54, Thorsten Blum wrote:
>>> add_usable_mem() adds usable memory ranges for the kdump kernel.
>>>
>>> The ranges are inclusive, but the partial overlap check uses exclusive
>>> comparisons. This skips ranges with base == loc_end or end == loc_base.
>>> Use inclusive comparisons instead.
>>>
>>> Fixes: 7c64e21a1c5a ("powerpc/kexec_file: Restrict memory usage of kdump kernel")
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>>    arch/powerpc/kexec/file_load_64.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>>> index 8c72e12ea44e..f9e872693ca7 100644
>>> --- a/arch/powerpc/kexec/file_load_64.c
>>> +++ b/arch/powerpc/kexec/file_load_64.c
>>> @@ -113,7 +113,7 @@ static int add_usable_mem(struct umem_info *um_info, u64 base, u64 end)
>>>    		loc_end = um_info->ranges[i].end;
>>>    		if (loc_base >= base && loc_end <= end)
>>>    			add = true;
>>> -		else if (base < loc_end && end > loc_base) {
>>> +		else if (base <= loc_end && end >= loc_base) {
>> This is interesting. The updated condition basically handles exactly a
>> one-byte overlap on either side of the usable memory ranges. In practice,
>> it is very unlikely that we would have such usable memory and LMB ranges.
>>
>> Thorsten, have you encountered any problem that led you to propose this fix?
> Found by inspection only and I agree that this is unlikely in practice,
> which is why I didn't cc stable. Same for the other patch [1].
>
> Thanks for the review.
>
> [1] https://lore.kernel.org/r/20260810145827.157972-3-thorsten.blum@linux.dev/

The changes look good to me. Feel free to add:

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

