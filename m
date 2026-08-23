Return-Path: <linuxppc-dev+bounces-26053-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC077C5DF8C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Aug 2026 13:53:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hSb9Q5Hnzz2xrL;
	Sun, 23 Aug 2026 23:53:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787493210;
	cv=none; b=CrcObrNcbKg/u66Rkufz/MVOFlXsqG/GjkqRswCG8qUod4YAOcqzIbnbtJvBHgnJc/4m4QRRVTijoe4UcraAC7RAgKUhdCNdA1Zi1W53VhVcvi+ttyumSipcQNEjZp3xImkPa//HpvA/tmbdEokRMRVFva5eMx6dL7LIgsonRU27PFcyOF67WKH8J1Hq40NuD4HtyXH9rNTlxbC8h855WjzIfHsGkfiZnSAnvW3HJWQFXdsw2Nj+7HZQ9eINK0raXcIY7s0byXNAyDYACkkTg0A1GGBgAHYP06+ixGvxATw4K31M/WCDA+p+dShtwPB1/kJScpHCpQHLYM6296nDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787493210; c=relaxed/relaxed;
	bh=/PSkdWoxxFZWMDZlH5CmES0JKLFIRxkLW52c+MbtjJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACpxMF/GHde2NQRYxadrgyiTalnI1noJAKn1acqe9EZo7z6UaYh8VG/M4sUW+qpDqukKPFFqiVI0tqAtLlyRnOdhHXshPgpUCvLm8YSkACLOnBJccwc1Ng+m3VDpReAmp+3ZbfSmj3mFG41XeBQW8nc3c1Ap3JtAmhjmT2q/Z0/7h+RJoV0A86v3E2iwKSypciMLIfSfe6Qc7ErFXRsIYH7ruHidNKD9dQYQpLj2rE9JItM8sREAiOrQRgtcliD6dWoG5B8gMs1jP0FWvSwcaapVfnu6cYLtj/LZCTrJb6JorDlKjkeSl4ii1AjdDvN7DNlSLCGtguakhsj6j5uzeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RsragAoC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RsragAoC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hSb9P2t9zz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Aug 2026 23:53:28 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NDVXJO1370431;
	Sun, 23 Aug 2026 13:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/PSkdW
	oxxFZWMDZlH5CmES0JKLFIRxkLW52c+MbtjJg=; b=RsragAoC7l8cDZTi9+o2Bk
	AA5bhR9HZSITZy1IkXmn1qk7586S4kF9gdHr8JUuF/IpFGE/D9NPlMpj92sC9l7w
	eQFzbbkFZmFHjb8mwGTEIoKYDkDDhoHp6y7LX/EY3NSvaY+rcPOJMcucppmY14pG
	TzW/Gzqb1OCy6d7BfJlwSwfCiH6cGa7tZ6RsaAAt1/4fik6JrwezTV+rvBoUfwFA
	5+/jyrkpEthXn6nWJtlP4/S1DedBgmmSxDv+eS5Go7IErM7U4hl/wsBVcyYZDvWH
	8S6aVVIsq46ddEYKF6c+TLzwQRNYVQHxY/yOQXXRAJhuV70xCJqVlUqqs2PBDkIQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqcsk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 13:53:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67NDfE9i016029;
	Sun, 23 Aug 2026 13:53:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pssgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 13:53:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67NDqwOu46006632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Aug 2026 13:52:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C75C20043;
	Sun, 23 Aug 2026 13:52:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6901F20040;
	Sun, 23 Aug 2026 13:52:52 +0000 (GMT)
Received: from [9.39.19.229] (unknown [9.39.19.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Aug 2026 13:52:52 +0000 (GMT)
Message-ID: <02cc93c1-b5ff-44f6-bbe5-f2f791092a6e@linux.ibm.com>
Date: Sun, 23 Aug 2026 19:22:50 +0530
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
Subject: Re: [RFC PATCH 3/3] powerpc/kho: exclude THP and HUGETLB_PAGE
To: Pratyush Yadav <pratyush@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Aditya Gupta <adityag@linux.ibm.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michal Clapinski <mclapinski@google.com>
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
 <20260821105609.983622-4-sourabhjain@linux.ibm.com>
 <2vxzecfrzoyv.fsf@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <2vxzecfrzoyv.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: s52PKxhJoxSqu7gQIRPqB42Kcg-iUlkr
X-Proofpoint-ORIG-GUID: GBtYw8Q2QL00Lftq1JMVDoVvPhEH5RAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDEyMiBTYWx0ZWRfX5rnZ/fVeuOHs
 GpPg4uuks+hBFavj0+RZIXNy4UlLL9Ku9T8Y1kYd8wAiGfhJMJmrbLdKXn5LBjy33atsnhIPgZV
 EK/z7Ex4EB5RbRqFSECgaaCKvb1/2S+7DoqEffTkrO1ut7O2frDN2KVQTJkeiZhO3AWHXnEozjF
 KeHMK2uKDrgvPKF2tCEGlluaubc+FfGJXGpA3KbQt6SF8ngo1pYmX7G8tyicToK5G/SEyC3+0BB
 tY0rqmGOyWKUy+iBfrM4mnYMrIb5DiqKQxjMgOyS2iFYSfCUItQCVoEChm8LV9fMuTtVrTICuqG
 L1hGlTr7CQX+RisUxW9L8mwsXI1a/C8WXfXRiFoBophRwTQcx/mWpq7u3jpNdnQaAL8QDHUj9Te
 CBNwUWDf+CrwWOnt0Ao/IPVdg9hz4CZPWJgVFMlpAzF9IexUoJaXKECJ64v2FefC9FwQb86x6tE
 Nj9iCOMrAIJKLtBREvw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8afb3f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8 a=jbd8uGjBXzmtj_AwXB8A:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDEyMiBTYWx0ZWRfX5kYcQlb2dkos
 dGXD21fuy/Ijm52p7xdJkl639XP9J4CLYl0wBU4Z99Zb10zUE97Bfd8RzjfKTItqr0145Ztgx9J
 QEOqdjdSDV//ugL3YI0MjpBkTmk0DPU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230122



On 21/08/26 17:04, Pratyush Yadav wrote:
> On Fri, Aug 21 2026, Sourabh Jain wrote:
>
>> Enabling CONFIG_KEXEC_HANDOVER together with CONFIG_TRANSPARENT_HUGEPAGE
>> or CONFIG_HUGETLB_PAGE on powerpc fails to build:
>>
>>      kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>>         49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>      ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>>         80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>            |                                                        ^~~~
>>      kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>>         49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>
>> CMA_MIN_ALIGNMENT_BYTES is derived from pageblock_order, which on
>> powerpc is not a compile-time constant when THP or HUGETLB_PAGE is
>> enabled -- powerpc can determine huge page size at runtime in that
>> configuration, so pageblock_order becomes a variable rather than a
>> constant expression. KHO's static_assert() on
>> SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES then fails to
>> compile, since it requires both sides to be constant expressions.
>>
>> Until CMA_MIN_ALIGNMENT_BYTES (or KHO's use of it) is made to handle
>> the non-constant pageblock_order case on powerpc, exclude
>> TRANSPARENT_HUGEPAGE and HUGETLB_PAGE from ARCH_SUPPORTS_KEXEC_HANDOVER
>> so the two can't be enabled together and hit this build failure.
> This should be a part of patch 2 I think. It is not a good idea to break
> the build in one patch and fix it in the next.

Agree. Since this is an RFC patch series, I kept it separate so that 
this issue could
be reviewed independently from patch 2. Going forward, I will merge them.


>
> That said, this is a debug check of sorts since SCRATCH_ALIGNMENT_BYTES
> is of MAX_ORDER_NR_PAGES, and pageblocks _should_ always be smaller of
> equal to this.
>
> Anyway, I don't think this is something you should gate by a config. I
> think you should either remove the static_assert(), or turn it into a
> runtime check.

Agreed. I will evaluate both options and decide which approach makes 
more sense.

Thanks for the review Pratyush.

- Sourabh Jain


>
> +Cc Michal.
>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Alexander Graf <graf@amazon.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <baoquan.he@linux.dev>
>> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 61350d3e7a19..f68b9fc883ba 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -720,6 +720,7 @@ config ARCH_SUPPORTS_KEXEC_HANDOVER
>>   	def_bool y
>>   	depends on PPC64
>>   	depends on !CRASH_DUMP
>> +	depends on !TRANSPARENT_HUGEPAGE && !HUGETLB_PAGE
>>   
>>   config ARCH_SUPPORTS_CRASH_HOTPLUG
>>   	def_bool y


