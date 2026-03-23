Return-Path: <linuxppc-dev+bounces-18622-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C21EC01BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:37:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffV3Y1HFTz2ySc;
	Mon, 23 Mar 2026 21:37:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774262233;
	cv=none; b=d3k7lIWazicC+iNTv1Uyhppued/j6omVKQ6bWu7RIR/XaSdzlpojR162/kSV/qgcX0f5Ji20DY5eEUEtDoMKKXW57f2IJewHqN3Y5S1e9cwe3CXdCGQRimP00xdaZrcrvdnB1bt4YsvxjE8LG8fzR4YKZum4cKAUIw+Y47usdwLo6T1elLmnPM4EKK385rG4vsUbZU2CDTbz85oWRYz6hrJ5qp5vVzIvTmMkqyQTTew/XzthDVgJ7ElxlVp6lc3GxgL2j7peAbMK4rDWYDvNCtb2j0SZ8IRavWETSWPRkXhOCvcpCESfbBXNjCXaWrf8NrZnKNkGcGiOpAFqhXXZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774262233; c=relaxed/relaxed;
	bh=T3383Mj0OhhI3RdzIFRVWGQFrnU0fbaLEsxzdQehq9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcIkn3JU91Nwq3UHyZ3py5goHPvlRI/kRnn9gL8NHH24567Pjw6oE8IWuuog8IMtLkQEcIxMjXdDaPcYPuvA5XAQiewUVUrHGmVVvj07aFvpx/p1KZ6PZkTd047dUtqw3dOcZwZcIml3wdYZfDrVSLIYGwTj0GVX8blVrKNMLN8ctlC4yBnWjc78wYVy4LVULEplpmrvW0UKCb2Nv8za8hFgQQyLNtDn3jTo5FeGAu+wWjLQNL2227J+D8eCvo0oHZjYJmnYKrEBEqObtck/JcteOWulaURRHYWRYmuiTwhxz4rxyAVACbAX00pOr96yXJY4Ky+wx7lwAkT0r8tC0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DBfJaX9z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DBfJaX9z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffV3X093jz2xN5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 21:37:11 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNVoQX564224;
	Mon, 23 Mar 2026 10:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T3383M
	j0OhhI3RdzIFRVWGQFrnU0fbaLEsxzdQehq9g=; b=DBfJaX9zhaxAy0oLWJ4bv/
	eyZSBDcgC0tYNnGMTHLFY/7pLcROw1Zz186DlQapmW49YpM4U/+sWDG6fq1RKTIb
	kDjtbFkzengIG7ADavE1Sv0mWkPGtmkc8WJCJBTTuJMO9P1Wr7EqIyI6fh/hVDsq
	4OhSlB+qqGZkaocR85W9u7nBJBPXmkyyteN/B+T/fzqrgJz40wD1n2zsMxSfJHWy
	XgoLDNU4QfPLMSoYrTuJIi/ZMH7IIGvJbxhlnfv8cVgzJb8YIWPtlJxmREFluG9d
	YLquWL/FSm0Yx/02PrrRq/qcmDw2S2oZJhC/243QUZrrFzQnnrjC/gZWw6ig9XgA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxyx3cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:37:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N8F79Y012213;
	Mon, 23 Mar 2026 10:37:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjvsv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:37:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAatO125231706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:36:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077092004F;
	Mon, 23 Mar 2026 10:36:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A20EE2005A;
	Mon, 23 Mar 2026 10:36:52 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 10:36:52 +0000 (GMT)
Message-ID: <f754e457-408e-4860-9ecd-fdff9f031f21@linux.ibm.com>
Date: Mon, 23 Mar 2026 16:06:51 +0530
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
Subject: Re: [PATCH 1/2] powerpc/kdump: fix KASAN sanitization flag for
 core_$(BITS).o
To: mahesh@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
 <acDZNdku8sR_O9Ba@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <acDZNdku8sR_O9Ba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MCBTYWx0ZWRfX0so057ALMt9S
 6aXAxakv0Er1s4eSVUA5lzr8lxK1W/nQDuRbd4cT4SbTT/VzPnHQ2GDPLLtkadtROeCJsNNPmvc
 RUuxXub0pK51ByNF/kUyYDjbJ8JcbLsJqjlF1nMiGzE2nGQGvPH3GwrkcQrIi1iphT18JdcoXSN
 pnArNnVHfeUJq2MIbjOrwH8VWSDf4oq4YNwVYlBrxVA0+0MGqNRBelrHLYYF8pr4NwYGKlaRtw2
 ubW1/fMmeQD03fAbpM5+KZyEJXawKhi9iEhZ1OXZ1JDnNxugB0LRYnyPHrzM9JW1NQj3hI5HbZU
 lffb9Xr7CMSINJIalXrXg7o4lQ3re8UOMN4i7IbB6uENNVGdl6KanLqe0ruQzL8GU4VA/7LoCmY
 mEv+wSP82KA44G3wAaqHuTN+THbgaurUOlmJ5GsUFgMU9ya3gjRfD3LH37k/KWVOvmWsA+XeseQ
 VDoBKUXp+77/wAA7wZA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c117cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=z_-sTByYZSztUN-XcZAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-ORIG-GUID: 5h4jF0Psw1JgkLQscf_FZaMm7OpBehgb
X-Proofpoint-GUID: 9iV5EsOwFEDn8KOvRbnaY0CGBF10LIiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230080



On 23/03/26 11:41, Mahesh J Salgaonkar wrote:
> On 2026-03-21 11:01:17 Sat, Sourabh Jain wrote:
>> KASAN instrumentation is intended to be disabled for the kexec core
>> code, but the existing Makefile entry misses the object suffix. As a
>> result, the flag is not applied correctly to core_$(BITS).o.
>>
>> So when KASAN is enabled, kexec_copy_flush and copy_segments in
>> kexec/core_64.c are instrumented, which can result in accesses to
>> shadow memory via normal address translation paths. Since these run
>> with the MMU disabled, such accesses may trigger page faults
>> (bad_page_fault) that cannot be handled in the kdump path, ultimately
>> causing a hang and preventing the kdump kernel from booting. The same
>> is true for kexec as well, since the same functions are used there.
>>
>> Update the entry to include the “.o” suffix so that KASAN
>> instrumentation is properly disabled for this object file.
>>
>> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
>> Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Daniel Axtens <dja@axtens.net>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/kexec/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
>> index 470eb0453e17..ec7a0eed75dc 100644
>> --- a/arch/powerpc/kexec/Makefile
>> +++ b/arch/powerpc/kexec/Makefile
>> @@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
>>   KCOV_INSTRUMENT_core_$(BITS).o := n
>>   UBSAN_SANITIZE_core_$(BITS).o := n
>>   KASAN_SANITIZE_core.o := n
>> -KASAN_SANITIZE_core_$(BITS) := n
>> +KASAN_SANITIZE_core_$(BITS).o := n
> Nice catch. Thakns for fixing.
>
> Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Thanks for the Ack Mahesh.

- Sourabh Jain

