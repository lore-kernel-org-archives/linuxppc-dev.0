Return-Path: <linuxppc-dev+bounces-22554-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318EFCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 12:29:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcJk059cHz2ykX;
	Fri, 12 Jun 2026 22:29:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781267384;
	cv=none; b=DULUYVPphq5VD3VuPtZkyV4yR6wJvID/dJiaX96HMCO3tSOqbSrfubelLVPQl7/CudiD4/0jZa52GAeqkAH9YBaEQWQ3yhCgCmZufdn+4f0ANVwUn4pHrb89SxvivdV+OOPlQEXhAaoDkFSkGHhIBjhFn2ju0QKMlNT1jJVmTcERWZc9LnhQM3SgzcLSGsQD/torcFQ17JDkLk9foqolqvB3eIns4ov+hrZa5FsBay1ula9xfYQqJrFJocABpTi4stuFWOhyYwBIwU/SaZKiqhB6f7zC3b3nJE7mEAbnU1clX+Au59GjfwDkdALmmy4tCC+AaJPbhJMsQ5gZCLWjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781267384; c=relaxed/relaxed;
	bh=uezUXr7Pra2D8IjxaGOXxuRQsR05hLjVHXRyfmm3HUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez9+FYnokHTOOPX8QcEdvrE78ma0O3gEsFNHYR5wCEwGR7erlWemfvjby/VKnooFett0HBkGD6n/f+bc9UQX2qszEkH92a7pENTZxagMLo9ZSKOwfGRmn6rDN/cpCcT3aM3crnVEgFLELswyLRn/5I31fzTUKMpJkvkUa8K+vG5iVPlbqz+RPkOHhiymhscsf/pq60PNHLtOzzTsHHdnSwiWv4iJpJ995f7Gf4BQ6VDX3GzmOs9PfZsRMxVK3CjMTfZhLZRg0L8LnXTNaEL9ZKL0tZVBdx8ubPzTnIIfX1B+viRFqX+Ec7DtZOUyHPfQqmXH8XbKGHVQeMajzoK9+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ttdk10g3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ttdk10g3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcJjy588wz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 22:29:41 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMD9A21742344;
	Fri, 12 Jun 2026 12:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uezUXr
	7Pra2D8IjxaGOXxuRQsR05hLjVHXRyfmm3HUk=; b=ttdk10g3s+XPy8nEkY96OO
	GxGIxM2WMiyik5aIMfzkux/9Yw7TiONFRKbu36+dnCHt+0AqQayg9VI6aMyF3iXX
	mdEJgxNAmqmC0SDPSWbpfykNHKqWSJSj17CitUzdjenOg36HE4RFFqURFkG/eXTK
	y90JU0+hTdv4YekQOEOAixBwhq3PQy30ye9XDNIXxGP8TKl0k3msOasVvBipM0BO
	MKUleM/Zj1KllHRH70jI4VChJ+TIoyxHublCyikUg2G7U3/AyNZiz6vxCRkUzmI9
	gEzZwlsgARg3O4qAbT0OJeyIqqJRnGVfQvev/pbhcTz+c0SzFvlz+HMCPlu+RHdA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8brj1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:29:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CCJhIT014827;
	Fri, 12 Jun 2026 12:29:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08ytbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:29:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CCTGcA30999236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 12:29:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 928A15804B;
	Fri, 12 Jun 2026 12:29:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1551858055;
	Fri, 12 Jun 2026 12:29:13 +0000 (GMT)
Received: from [9.39.30.128] (unknown [9.39.30.128])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Jun 2026 12:29:12 +0000 (GMT)
Message-ID: <ac8931ff-5264-45cc-9842-bd240439cefa@linux.ibm.com>
Date: Fri, 12 Jun 2026 17:57:48 +0530
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
 <a406db02-3aeb-4922-b6b1-8a030ca45a7b@linux.ibm.com>
 <ab4d83d8-1ffa-4738-b4b5-12d9a4f2d9c0@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <ab4d83d8-1ffa-4738-b4b5-12d9a4f2d9c0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2bfb9f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=FPh58N5xAAAA:8
 a=OLL_FvSJAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=t1-onl6Wi8JrmCUjQxEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Q4WRRM2E_uQYcjguQaFu:22
 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfXy8Vz/vI2SSAz
 xJ9zVBYHhorjIS2PUnGwN1NFanK3aQi27THPxojvNNk711lcrlLksNbiO4PAdbvIHIRMk/L6xa3
 0hI2nHHIopPAZBoWmzxqBLNEBstPeJAul/j7oqtFNlv2J6HeOoyaM97JXNC/jwfuL1/kOxt0rOP
 3KK9vvBswAKAEpkOLP+Otym4PQl2nR0Z596CTsTUhruoetGhKqJP030ULxq79MQeLaTlO2cKGhJ
 psvH+uUMocQC+8F5F3noEh2wwQ2mVcXH9vtM8eejHAH2VMl2Z3vh1vLhKla7hx5Uz/pNH01Te7t
 N2UBgS3atO6zpDAeDyiH5vEnDV4brGekiiiGEh2O0q0gFT0Hs6dDcL+BzueOYiTYU5JKzCcC4Bf
 YJQsAGyF8E+kh0Q/o9Mtw6DW5TfCJcEHlQQtitZ8YQch5shc2F26e0CegcMYOEzDTUyuZRGvRcr
 uZPAy5RoO8K5m5iixug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfXzroopslJdfyh
 0h/p9Wsda62jfdrcVFQ6RATRRuEbNujuNlG/Z600e0l7H82pU/sLN2xwu5eqHmMS4eTSlMA9+UB
 uLsKQAdqTAPBbKp2WGCmJTHlofJq08c=
X-Proofpoint-ORIG-GUID: k0GyQlO6VH4FWCvjZxpwRsJ4WuAFk3Dc
X-Proofpoint-GUID: lxA_dqrPhy2bayeBrgt-11C9CO7nPqO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120111


On 6/10/26 17:03, Thomas Huth wrote:
> On 10/06/2026 11.27, Chinmay Rath wrote:
>>
>> On 6/8/26 19:27, Thomas Huth wrote:
>>> On 08/06/2026 14.45, Thomas Huth wrote:
>>>> On 02/06/2026 08.48, Chinmay Rath wrote:
>>>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>>>
>>>>> Add some initial PMU testing.
>>>>>
>>>>> - PMC5/6 tests
>>>>> - PMAE / PMI test
>>>>> - BHRB basic tests
>>>>>
>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>>>> ---
>>>>>   lib/powerpc/asm/processor.h |   2 +
>>>>>   lib/powerpc/asm/reg.h       |   9 +
>>>>>   lib/powerpc/asm/setup.h     |   1 +
>>>>>   lib/powerpc/setup.c         |  20 ++
>>>>>   powerpc/Makefile.common     |   3 +-
>>>>>   powerpc/pmu.c               | 567 
>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>   powerpc/unittests.cfg       |   3 +
>>>>>   7 files changed, 604 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 powerpc/pmu.c
>>>>
>>>>   Hi Chinmay,
>>>>
>>>> the problem with Clang on Travis [*] still seems to persist:
>>>>
>>>>   https://app.travis-ci.com/github/huth/kvm-unit-tests/jobs/639614142
>>>>
>>>> Could you please have a look?
>>>>
>>>>   Thanks,
>>>>    Thomas
>>>>
>>>>
>>>> [*] This already happened with Nicolas' last version:
>>>>
>>>>   https://www.spinics.net/lists/kvm/msg351218.html
>>>
>>> I managed to get access to a ppc64 machine. The error is:
>>>
>>> /tmp/pmu-eab466.s: Assembler messages:
>>> /tmp/pmu-eab466.s:1649: Error: unrecognized opcode: `ldat'
>>> clang: error: assembler command failed with exit code 1 (use -v to 
>>> see invocation)
>>> make: *** [<builtin>: powerpc/pmu.o] Error 1
>>>
>>>  HTH,
>>>   Thomas
>> Hi Thomas,
>>
>> Thanks for looking into this and providing the exact error message.
>>
>> I was looking into this Travis CI job that you pointed to and noticed 
>> that the clang version being used was 14.
>> I was wondering, would it be possible to use a newer version of clang 
>> for the job since LDAT is a legit PPC insn,
>> that was introduced with Power 9, ISA version 3.0, way back a decade 
>> in 2016 !
>> So I was wondering if using a newer version of clang that recognizes 
>> the instruction would be a better approach.
>
> I can reproduce the very same issue on a ppc64le box with Clang 22:
>
> # clang --version
> clang version 22.1.6 (Fedora 22.1.6-1.fc44)
> Target: ppc64le-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Configuration file: /etc/clang/ppc64le-redhat-linux-gnu-clang.cfg
> # make
> clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float 
> -mno-altivec  -I /root/kvm-unit-tests/lib -I 
> /root/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -g -MMD -MP -MF 
> powerpc/.pmu.d -fno-strict-aliasing -fno-common -Wall -Wwrite-strings 
> -Wempty-body -Wuninitialized -Wignored-qualifiers -Wno-missing-braces 
> -Werror  -fomit-frame-pointer -fno-stack-protector    
> -Wno-frame-address   -fno-pic -Wunused-but-set-parameter  
> -Wno-override-init -Wmissing-prototypes -Wstrict-prototypes  
> -mlittle-endian   -c -o powerpc/pmu.o powerpc/pmu.c
> /tmp/pmu-f0c247.s: Assembler messages:
> /tmp/pmu-f0c247.s:1656: Error: unrecognized opcode: `ldat'
> clang: error: assembler command failed with exit code 1 (use -v to see 
> invocation)
> make: *** [<builtin>: powerpc/pmu.o] Error 1
>
> Does compiling with Clang work for you? If so, which version?
>
>  Thomas
>
>
Thanks for sharing this observation Thomas. I did some digging on a 
ppc64 machine and found the following :

The problem isn't with clang. Clang is able to perfectly identify LDAT 
insn. This can be verified by writing a small C program using LDAT 
within a similar asm volatile block and compiling with Clang. Sails smooth.
The problem is, the GNU assembler does not identify LDAT, unless 
"-mpower10" flag is passed to it. Can be verified by writing a small .S 
program making use of LDAT and passing to 'as', the GNU assembler binary.
In your Travis CI log, as I can check, the following config is used :
$ export CONFIG="--arch=ppc64 --endian=little --cc=clang 
--cflags=-no-integrated-as"
"no-integrated-as" defers the assembling job to GNU assembler, and since 
no "-mpower10" flag is passed, the compilation fails.
Using the following flag in the config instead, passes -mpower10 to GNU 
assembler and gets the compilation job done : 
  --cflags="-no-integrated-as -Wa,-mpower10"

Thanks,
Chinmay

PS: I will be away traveling for a while, will get back to this as soon 
as I am back. Thanks for understanding   :)


