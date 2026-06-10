Return-Path: <linuxppc-dev+bounces-22395-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810FCD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 09:28:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb0nB3xzKz2yR5;
	Wed, 10 Jun 2026 19:27:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781083678;
	cv=none; b=l/HAIhcu+6X7xqhO+tcP0p+fTLgTMaqbhwoRO+htEm6Z9z2JRb74sVXpfbW09d8utrFhIpqSnJ+EEu+SSN6pCPgo+u4IZphBTsyznEKB5pJtfWpO0RLS8g9PvfdQ6sDpSs/isPCUEQJfrlCACvVu+C49muBcaK2ivK30rtGxA1jgImBTPy9Wix12bYwsatkT5P+rS7Uct0DBGCPxlrolZm4kdIDOaKKtwHMevenjtrxPYDh5gEdG9g2np5e2Swk2nhecztEkedjMlnwiBb4CJVseR3MKwCrjPotl4GTcEvigEMTMTOG4rwGz6GKWFveeBzCmbmKcXZ5ni7x5Qj+H0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781083678; c=relaxed/relaxed;
	bh=0l8o41VibrX/0Q5+SFQerCq1eT0fKLZTjZUPdFXK3a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d69Bwqv+ATQia7wOCXutm8t9KbiYrW8ZHUGIswsJZDAJtiyBvDOZmdEJJHzRCO5j+xPRZoEWWerWF4xeGO8qgs1cBVpJUjjoxza8feVEe2t8CnnNnOtmEuPoxDrJpusgD9ClhaQjPnYVNEb+auUVLiFfvDV4KOfg73lD7o2RY24v3b/H46FjxiDEtDSnXbJwJBO2bCIlcRD4Vzsxe7mkTwxbjojosQNqIzMUiRgfgybOPBZauDWHuFA9Y8dqmsRfmciD5SOqmff66e6Q+GE6ZmNHfZe8jGooyvY+2CX39cUvDchkSHBtL0oPvFGlgT0G7aLZ7eqk7sSPBz0dpY1E6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M0IYqq27; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M0IYqq27;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb0n83rjQz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 19:27:55 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659MMKq5957566;
	Wed, 10 Jun 2026 09:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0l8o41
	VibrX/0Q5+SFQerCq1eT0fKLZTjZUPdFXK3a8=; b=M0IYqq276Xn6S/J37uVaEc
	Zo64DlI9dLWSCDhwf1baffouK+zdIUl/4qfejrLAUzo7CWsgC1oatZKPZgUABO6M
	x0qULu57BDLipccanTvcEma6B4jSESJS29CVgP8Ed8Hj5Ffy/lQeyy2TQARJn73O
	D9kqT8HvAnpCUcOrN9KhdDGUFkw5F0OZSgpgxH5nvK291cAEXlw0s0l+R6FL8Lgk
	+Ylhp47RZuTpCVH6AUA++J/54TzQopvcZ6ZuaJgD4zIlWbR+O4TwEWm7hXLRaNW7
	6j6PfKeVxfEq+Qy2mB70VB+qOSgaepS+6hhLIclM5W5M5EP7X87SBYbyWQhn7QyQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qrd50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:27:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A9Jc0r020109;
	Wed, 10 Jun 2026 09:27:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g5u4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:27:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A9RUTj38470176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:27:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C3B458064;
	Wed, 10 Jun 2026 09:27:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EF3658062;
	Wed, 10 Jun 2026 09:27:27 +0000 (GMT)
Received: from [9.39.27.242] (unknown [9.39.27.242])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 09:27:26 +0000 (GMT)
Message-ID: <a406db02-3aeb-4922-b6b1-8a030ca45a7b@linux.ibm.com>
Date: Wed, 10 Jun 2026 14:57:04 +0530
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
Subject: Re: [kvm-unit-tests RFC PATCH 1/6] powerpc: add pmu tests
To: Thomas Huth <thuth@redhat.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-2-rathc@linux.ibm.com>
 <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
 <0c95c25f-1400-4912-befc-c5b32968d9ab@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <0c95c25f-1400-4912-befc-c5b32968d9ab@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a292e05 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=FPh58N5xAAAA:8
 a=OLL_FvSJAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=octOoDlM_WqTSxbGpL4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Q4WRRM2E_uQYcjguQaFu:22
 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: vSXMprX2JNWjTCqt8t7r3ekW_WSLkyhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfXzbn2wRIXVi7i
 OgalVTcpFmZGlCs3vEiHklDggrYjQEi+uHV1lfZ0DLOYRE5Z49PpaylBWoAe6vRfYeLesDCJo2b
 TWS3vzHdfTXVcJ2J/AIIMArcv15ViddYRV03NtJagI6IAjzVLX90JX/Wm91OxCXMrTHperkOshY
 87n96NpIpUAc6PJSr9ZUai+W2YIIHYn/qvH2dj350ewDYDcysSLHynFxGxQZno7ARz3hu+WlskX
 ghCJN5qZfrZopAyoyTiPB1xtXlEZiEJnHM+cgRglxxIkwL/4DzNFK6qWjhZI9L5MnTqItUTBNIY
 mew9YmYFk3qrf9Cr0zjkwfBIqhIQ51VHfl/Ezuo7fgr991N0LHmHKoxMsipmHqdc8jIcVEp4Edt
 XcSb8WUGzE3efli1B9CT88OSWQvwkaKEKw3PyuOB1a4mT7QSqVThu5VH6LxEF6e2gux6RQykvdt
 zvPDtwnuNubW88kA5uA==
X-Proofpoint-ORIG-GUID: sIREZPas2ym2ME0GwzmLs_F3j6FMhqYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086


On 6/8/26 19:27, Thomas Huth wrote:
> On 08/06/2026 14.45, Thomas Huth wrote:
>> On 02/06/2026 08.48, Chinmay Rath wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> Add some initial PMU testing.
>>>
>>> - PMC5/6 tests
>>> - PMAE / PMI test
>>> - BHRB basic tests
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>> ---
>>>   lib/powerpc/asm/processor.h |   2 +
>>>   lib/powerpc/asm/reg.h       |   9 +
>>>   lib/powerpc/asm/setup.h     |   1 +
>>>   lib/powerpc/setup.c         |  20 ++
>>>   powerpc/Makefile.common     |   3 +-
>>>   powerpc/pmu.c               | 567 
>>> ++++++++++++++++++++++++++++++++++++
>>>   powerpc/unittests.cfg       |   3 +
>>>   7 files changed, 604 insertions(+), 1 deletion(-)
>>>   create mode 100644 powerpc/pmu.c
>>
>>   Hi Chinmay,
>>
>> the problem with Clang on Travis [*] still seems to persist:
>>
>>   https://app.travis-ci.com/github/huth/kvm-unit-tests/jobs/639614142
>>
>> Could you please have a look?
>>
>>   Thanks,
>>    Thomas
>>
>>
>> [*] This already happened with Nicolas' last version:
>>
>>   https://www.spinics.net/lists/kvm/msg351218.html
>
> I managed to get access to a ppc64 machine. The error is:
>
> /tmp/pmu-eab466.s: Assembler messages:
> /tmp/pmu-eab466.s:1649: Error: unrecognized opcode: `ldat'
> clang: error: assembler command failed with exit code 1 (use -v to see 
> invocation)
> make: *** [<builtin>: powerpc/pmu.o] Error 1
>
>  HTH,
>   Thomas
Hi Thomas,

Thanks for looking into this and providing the exact error message.

I was looking into this Travis CI job that you pointed to and noticed 
that the clang version being used was 14.
I was wondering, would it be possible to use a newer version of clang 
for the job since LDAT is a legit PPC insn,
that was introduced with Power 9, ISA version 3.0, way back a decade in 
2016 !
So I was wondering if using a newer version of clang that recognizes the 
instruction would be a better approach.

I checked the .travis.yml file (config) for the job, which mentions :
|apt_packages: clang qemu-system-ppc|

Can we change it to something like :
|apt_packages: clang19 qemu-system-ppc |or (clang-19)  ?

In the same config s390x uses a specific version of clang that is 11 in 
similar manner.

However if you'd still prefer working around LDAT, I could try with 
LDARX instead, but I am unable to verify if
clang-14 will recognize that since the oldest version of clang I could 
find in ppc64le repo was clang-15 which
was able to work with LDAT as well. Hence, could you help me with 
providing the steps to use Travis-CI so I could verify ?
(I had skipped doing the credit card payment while signing up, in case 
that's mandatory for Travis CI. Pardon me I'm new to it XD)

Thanks,
Chinmay


