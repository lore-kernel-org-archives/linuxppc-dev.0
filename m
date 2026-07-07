Return-Path: <linuxppc-dev+bounces-23675-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875FEC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 06:47:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvWxb1r5yz3brm;
	Tue, 07 Jul 2026 16:47:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783406851;
	cv=none; b=OCv+hou8Tr9UqvLRiJzHgHhgRSyVML0Nxm2S5MO8HrygZYrb79tBYfS97/A4mDKVwJM5O5jm1vKLLZJfsSH9Qf/ble+j6xKLKeNk2khLVUNSmBlCbWGfJek909UJHZFvZ+zWX3ULEo0fg5gSEZEZObtAAst45C9egfeeLbVGsJ5y0GWZRhpw5tJpGlhiGmKaXDS3BGKy+Y4NzpFvALrfmtYH+aWnUppxvU+xQg3nUJP6gKGlRhLkI+Z7zZbnNwvexq8UfUL0YcKB6yx+cuuxb/hynj5a1u0hvpsiOVxdZ0qaBj5ibfw7bFFbtOj3x0etrNGExxdV9/p71FdgQ0NyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783406851; c=relaxed/relaxed;
	bh=QfWl/d0f8dPQpjfKqXxdLHZHiKJFU2JtiZPZuJYImRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdivE3p00hrEpDMOBBU2yP4/xDOhxPo/ORawg6Ef7wD+oYQufag2tc4F3ILeEStpEPGxHINNqO5XMBZ866ymhX+37aDWWGxdhL8H7DHOp9MeeFWfCS1JsFV++UgOew55CsOL/j2JXExHslRyMdApJuIYzzIyqctd7usCBRq3AE++94cwWfw/gd7MUvB0ZE9gJyciTVjZdrwgibZTF+cF5fG/yktb3SO/dBq6eVSSg6WjemZ/JFvkkXgM0zC4aDfui3lFjSOrhfyVA4g/MmMyJ/y7Sfh6wCzA92bcduMgUtwn4BSU1fljT90q+pe/YfcT0bXubAutyBEP5PUQzM3iUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NxHa7d02; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NxHa7d02;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvWxY3VSTz3brc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 16:47:29 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674IK3X2286263;
	Tue, 7 Jul 2026 06:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QfWl/d
	0f8dPQpjfKqXxdLHZHiKJFU2JtiZPZuJYImRU=; b=NxHa7d0248RT/hkopc3IbJ
	cxSTUYnDcf3lygyRBhU8lVwXCyRQvP9CLI5hjroFU3MbIi1RTSgn0QH2s5Qisks/
	c6fw5sPuIF7AerCLWIX8cXH0BgE1SmBGIeqNJbFhnN/KPKmfyGdX9t+QwbcGBvWD
	qm1ep6NxYr7GVVFDvPoZAov2Jfy5eipQojx2W9KVpo6QSXO0MO5M3HaF/W5Kj8la
	n/Bq7Qjic/4UFmeocQzxKTYaBG+WYVFB4zC2ll41VV/dkAh+as7bpiJNRtSLCUvM
	oLw21JlTZ6kRt/yzUcOi2llDGNef5s5h0QkBxDeMzfOURALaaQIWGS/ISEmr64vA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4nhr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 06:47:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6676Yanf006911;
	Tue, 7 Jul 2026 06:47:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq1jf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 06:47:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6676lKKR25297540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 06:47:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E28C358056;
	Tue,  7 Jul 2026 06:47:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFCB758052;
	Tue,  7 Jul 2026 06:47:17 +0000 (GMT)
Received: from [9.39.26.222] (unknown [9.39.26.222])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 06:47:17 +0000 (GMT)
Message-ID: <1fcb4ab1-5f5e-43a7-9c65-943c795ae98c@linux.ibm.com>
Date: Tue, 7 Jul 2026 12:17:00 +0530
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
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
To: Thomas Huth <thuth@redhat.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
 <7d9e6365-1b2d-4b18-8fb5-d8048fddb7f0@redhat.com>
 <efbbe11b-9e02-4878-b61a-f804b491ab4c@linux.ibm.com>
 <6e29ac41-383a-416c-bca4-c3d4349beda0@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <6e29ac41-383a-416c-bca4-c3d4349beda0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _LgnrYqp8q8NaXhnyP0FVgU0swqOXjo2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX6qDtlfrjR8W7
 l0X04lYcTuSUAP5F8pqhIlOARQbdNoGzQ2fqYDpqILF9d589Zq5ee3tA4aEdiqq7+co3e4fshg0
 IP7kSNEhV2X+E6fwO1Uqbo46HPrnhyUUmzx4SDqyRi+qYIGkcJ4tySQHK5D0v3cOoIo5yMCNRaM
 8Gpn79SfT2E2KMoQlN1fF++CZ+SC9RkbH9iT0v474qZdNmMqEIpD69YNYeVf4c1ObtZvF0TMaoH
 nIMd223Zj25X6JCV74fZxlYo7UcrVaadJ9TFLiXa++jfGlGCa3922K3dMrPM400CTBfrU2In3pN
 XLwKqqR7gqSjKEWUudM2ZRklo8ir1DF9h+lAFs59vk2y1zvd3s0XLi4vKQU2vo/q6GD728GZfgT
 yOCu9gWdpYhCPPC5SyJTZUtPZS910KJJ//EpspKZgHHbNtpqPKqkseP2/70rI3RUB1w7r5EkbQj
 Q6d6nz4VM+pYkEZkWZw==
X-Proofpoint-ORIG-GUID: T1DX8Yard4CYeDrBuqzzVFW4RCYVVNZB
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4ca0fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=uIRw34n5qooko5-z2rUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX4araACPv+3eS
 yy4Fj9DpnWebzqZi+xllifX3SpXQdoy484DAM+eKEP7z/gW7aUvD87r3R84v71PO8P2e8i6P7Mn
 babm9Y/DKQ5YLqtp9SvA7o4dgv7DRgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058


On 7/6/26 16:06, Thomas Huth wrote:
> On 03/07/2026 08.46, Chinmay Rath wrote:
>>
>> On 6/10/26 17:00, Thomas Huth wrote:
>>> On 02/06/2026 08.48, Chinmay Rath wrote:
>>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>>
>>>> arch_libdir was brought in to improve the heuristic determination of
>>>> the lib/ directory based on arch and testdir names, but it did not
>>>> entirely clean that mess up.
>>>>
>>>> Remove the arch_libdir->arch->testdir heuristic and just require
>>>> everybody sets arch_libdir correctly. Fail if the lib/arch or
>>>> lib/arch/asm directories can not be found.
>>>>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>>> ---
>>>>   Makefile  |  2 +-
>>>>   configure | 20 ++++++++++++--------
>>>>   2 files changed, 13 insertions(+), 9 deletions(-)
>>>
>>> FYI, this patch seems to trigger yet another issue with Clang (I 
>>> used v21):
>>>
>>> clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float 
>>> -mno- altivec  -I /root/kvm-unit-tests/lib -I 
>>> /root/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -fverbose-asm 
>>> -S -o lib/powerpc/asm-offsets.s lib/ powerpc/asm-offsets.c
>>> lib/powerpc/asm-offsets.c:10:10: error: 'asm/smp.h' file not found 
>>> with <angled> include; use
>>>       "quotes" instead
>>>    10 | #include <asm/smp.h>
>>>       |          ^~~~~~~~~~~
>>>       |          "asm/smp.h"
>>> In file included from lib/powerpc/asm-offsets.c:10:
>>> lib/powerpc/asm/smp.h:5:10: fatal error: 'asm/processor.h' file not 
>>> found
>>>     5 | #include <asm/processor.h>
>>>       |          ^~~~~~~~~~~~~~~~~
>>> 2 errors generated.
>>>
>>> Could you please have a look?
>>
>> Hi Thomas, back from traveling and looked into this.
>> I am using Clang v21 as well :
>> # clang --version
>> clang version 21.1.8 (Fedora 21.1.8-4.fc43)
>> Target: ppc64le-redhat-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/bin
>> Configuration file: /etc/clang/ppc64le-redhat-linux-gnu-clang.cfg
>>
>> I see the above file, asm-offsets.s being generated properly without 
>> any error during the make process (used the extra flags for make that 
>> I have mentioned in my other reply).
>> Snippet from make :
>> cat powerpc/boot_rom.bin.tmp >> powerpc/boot_rom.bin
>> rm -f powerpc/boot_rom.bin.tmp
>> clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 
>> -msoft- float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I 
>> /root/chins/ git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames 
>> -fverbose-asm -S -o lib/ powerpc/asm-offsets.s 
>> /root/chins/git/kvm-unit-tests/lib/powerpc/asm-offsets.c
>> (set -e; echo "#ifndef __ASM_OFFSETS_H__"; echo "#define 
>> __ASM_OFFSETS_H__"; echo "/*"; echo " * Generated file. DO NOT 
>> MODIFY."; echo " *"; echo " */"; echo ""; sed -ne 
>>  's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/ 
>> {s:->#\(.*\):/* \1 */:; s:^->\([^ ]*\) [\$#]*\([-0-9]*\) 
>> \(.*\):#define \1 \2 /* \3 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) 
>> \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' 
>> lib/powerpc/asm-offsets.s; echo ""; echo "#endif" ) > lib/ 
>> powerpc/asm-offsets.h
>> cp -f lib/powerpc/asm-offsets.h lib/generated/
>> clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 
>> -msoft- float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I 
>> /root/chins/ git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -g 
>> -MMD -MP -MF powerpc/.selftest.d -fno-strict-aliasing -fno-common 
>> -Wall -Wwrite-strings - Wempty-body -Wuninitialized 
>> -Wignored-qualifiers -Wno-missing-braces -Werror 
>> -fomit-frame-pointer  -fno-stack-protector   -Wno-frame-address 
>>  -fno-pic    -Wunused-but-set-parameter -Wno-override-init 
>>  -Wmissing-prototypes - Wstrict-prototypes -mlittle-endian   -c -o 
>> powerpc/selftest.o /root/chins/ git/kvm-unit-tests/powerpc/selftest.c
>>
>> Infact, if I just execute that single command independently to build 
>> asm- offsets.s, it works as well.
>
> Ok, I finally got access to a POWER system again and tried to 
> reproduce the issue, but I also cannot reproduce it anymore. No clue 
> how I managed to get into that situation, but looks like it was rather 
> due to a messed up build tree than due to your patch. So sorry for the 
> trouble, and please go ahead and simply ignore my objection here.

Not a problem Thomas. Thanks for taking the time to look this up again. 
Will post the next iteration asap.

Regards,
Chinmay

>
>  Thanks,
>   Thomas
>
>

