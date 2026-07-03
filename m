Return-Path: <linuxppc-dev+bounces-23461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A0C43602
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 06:46:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs46J1vLRz2xdb;
	Fri, 03 Jul 2026 16:46:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783061192;
	cv=none; b=H1s0DGZI3zwUo3mzm7eKdNttgdJNYVOggUaA3wDkSgYAB3123lVBvCiNRx/adiiedlovAyfRbZYcILMJBtS3eWO6g8xF5jWOXBEfXenWGxKcfdzE7T/mFYBAiRaBLWNjJwhiSn1wO6I8CvGd5Wtd6Zcu6JpEZVUTM7vrXOzP1JAb5RCXVQyycdGOnTfiMI+3rRU8G9zd32dx0cJnt6n8MhgzzdV+k4FyQAxxkN8HoFNX/ZJSn8zqhatvr4MlmNUZORwIKWKmQvxWepWlKZnJoteIGkEbY8W4FzYbdLLOp6mSvg86dyG0cpXyFjTvIe+k1hy4n2kq/aRSbHqkorMyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783061192; c=relaxed/relaxed;
	bh=2hCxO22SktyjH1L1Nt7th1JbUy7K3ZfayYYzM0Zw25k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBdRFI9Gziknz4zK/VBzGFFPuy0Hgi8kdjA3TqZ/OrRGkjjbC6jdFcZMXyochjnhnvax4tMs84aLi9dOZARfzbYVbaNu5nDwXfdO1UwFOsSOkxMtREe3slE/0lnLM8ktP8NIdHJbGiiHCSySyExjfiS+j/AN53DzPkcc9cQTinGBxWmg6r4so91ZmFrovHJ2ltWDeK2SzVJHOBhO2eftOPq+CH99THfDeLiYGdApHI0j2vPvvfV3Mjig++2Zakby7TLGLrR2j7qnQ8iLasdIrMfRTOjTJm+ke9M2GlfzUlgvimf82Mv3y6mQ7Hlmd29yl4ciEgPF4gzQHRMcXJ4DfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YFZyrbvc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YFZyrbvc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs46H1S8Zz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 16:46:30 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IVMZ1814338;
	Fri, 3 Jul 2026 06:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2hCxO2
	2SktyjH1L1Nt7th1JbUy7K3ZfayYYzM0Zw25k=; b=YFZyrbvcgnXLvRvYxsiHBi
	7peOKepohjfnV+Cj/uawhldlkNFLJcHj3Me4gXbeNfpipWIzUHV7rTgpULXHPX0P
	vmHIRf7pSmZ4UHjlX1sUGv6bwpJmnAtso5f6R2wDhxxmeuiXRv3wgpGuuhi+m3Y/
	5X6YQOKdU6LeMLnEohQKy8iNSwRLYjwzG+DHRymr1PUgzwQo7xSoYzKJGN1jnj9Q
	jiEr/L++FS6b4tYVS/5Abdb85+iO73OPjbavyHXSVYd/bJy0/jeo3vdDq8NJ6yKx
	sUno7b0bLOgX0vd5MNeWw59I3cP2GKDenu9VG1jewiApaU+gkmwJm7LaGeX+9JDA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfd8m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:46:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6636Ygd6001791;
	Fri, 3 Jul 2026 06:46:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhqhbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:46:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6636kNAw21955266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 06:46:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F7B958052;
	Fri,  3 Jul 2026 06:46:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45C7558056;
	Fri,  3 Jul 2026 06:46:20 +0000 (GMT)
Received: from [9.39.23.40] (unknown [9.39.23.40])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 06:46:19 +0000 (GMT)
Message-ID: <efbbe11b-9e02-4878-b61a-f804b491ab4c@linux.ibm.com>
Date: Fri, 3 Jul 2026 12:16:16 +0530
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
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <7d9e6365-1b2d-4b18-8fb5-d8048fddb7f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a475ac1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=f93Im0tUpS4rTDHlxOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: F18mxmh2d_EZZhvgb-adW3Cw6Bwds2jJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfXwTM5KJckJNXO
 FJ5IRwIWlQXoxdex21Eq7jje51OhO6jBMa5kN5ENLw6Xbfpzboz2xiWCMwEELBuUQbqWPuVlLwv
 kYHQNYIeh5jteTErCPPGx8fpPpIdOU9fU+TlFvIMr117a+4PWALZ6H3cvOV+L3IekyaCqwdz8lt
 42sof45ZGYxUkMsTxds3IEs6hbatGYpD5+YEz0aClziwFuXCQFY0s2OIQhJPgbChtxfj19KpZBr
 UTWjaAXkuu/EtjkX+7Yy5DNzZIriDgwxw7AGMbqQh0CqdfE2UA/QpYWhqFB+F+2dLiqxL5eKOXz
 v/7pfP45xwq8SYyxL1eL1CWieGyx4OXwv2UmIgOueB7kNZ/GvjqYrbe/hdKF8yXLroPaf8Omj8F
 vvtlJEbqrTeYNC8vXNzkLJ5Vw1JyFssp5Rpit4CV20oPYihZtgmGpeB0i7EJBk68TxWbqkTJpnF
 z1vYZsfzj+gphgzaMjw==
X-Proofpoint-GUID: CuumxRvOfuiz5Ai5BxWgVw1Y_PkzCuDF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX7pEcZhfH8V07
 Thz1iYCt3pFNxcKjXFjyEeyL0hW2/PLRmDtH/f7uN9+wENdmwA4q/pqDRnYFxKjwvEkbVtC4Bp9
 ZGAwKTkPLW0sxFvLMRGOr+tSesjetbQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030058


On 6/10/26 17:00, Thomas Huth wrote:
> On 02/06/2026 08.48, Chinmay Rath wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> arch_libdir was brought in to improve the heuristic determination of
>> the lib/ directory based on arch and testdir names, but it did not
>> entirely clean that mess up.
>>
>> Remove the arch_libdir->arch->testdir heuristic and just require
>> everybody sets arch_libdir correctly. Fail if the lib/arch or
>> lib/arch/asm directories can not be found.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   Makefile  |  2 +-
>>   configure | 20 ++++++++++++--------
>>   2 files changed, 13 insertions(+), 9 deletions(-)
>
> FYI, this patch seems to trigger yet another issue with Clang (I used 
> v21):
>
> clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float 
> -mno-altivec  -I /root/kvm-unit-tests/lib -I 
> /root/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -fverbose-asm -S 
> -o lib/powerpc/asm-offsets.s lib/powerpc/asm-offsets.c
> lib/powerpc/asm-offsets.c:10:10: error: 'asm/smp.h' file not found 
> with <angled> include; use
>       "quotes" instead
>    10 | #include <asm/smp.h>
>       |          ^~~~~~~~~~~
>       |          "asm/smp.h"
> In file included from lib/powerpc/asm-offsets.c:10:
> lib/powerpc/asm/smp.h:5:10: fatal error: 'asm/processor.h' file not found
>     5 | #include <asm/processor.h>
>       |          ^~~~~~~~~~~~~~~~~
> 2 errors generated.
>
> Could you please have a look?

Hi Thomas, back from traveling and looked into this.
I am using Clang v21 as well :
# clang --version
clang version 21.1.8 (Fedora 21.1.8-4.fc43)
Target: ppc64le-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/ppc64le-redhat-linux-gnu-clang.cfg

I see the above file, asm-offsets.s being generated properly without any 
error during the make process (used the extra flags for make that I have 
mentioned in my other reply).
Snippet from make :
cat powerpc/boot_rom.bin.tmp >> powerpc/boot_rom.bin
rm -f powerpc/boot_rom.bin.tmp
clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 
-msoft-float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I 
/root/chins/git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames 
-fverbose-asm -S -o lib/powerpc/asm-offsets.s 
/root/chins/git/kvm-unit-tests/lib/powerpc/asm-offsets.c
(set -e; echo "#ifndef __ASM_OFFSETS_H__"; echo "#define 
__ASM_OFFSETS_H__"; echo "/*"; echo " * Generated file. DO NOT MODIFY."; 
echo " *"; echo " */"; echo ""; sed -ne 
  's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; 
/^->/{s:->#\(.*\):/* \1 */:; s:^->\([^ ]*\) [\$#]*\([-0-9]*\) 
\(.*\):#define \1 \2 /* \3 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) 
\(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' lib/powerpc/asm-offsets.s; 
echo ""; echo "#endif" ) > lib/powerpc/asm-offsets.h
cp -f lib/powerpc/asm-offsets.h lib/generated/
clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 
-msoft-float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I 
/root/chins/git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -g -MMD 
-MP -MF powerpc/.selftest.d -fno-strict-aliasing -fno-common -Wall 
-Wwrite-strings -Wempty-body -Wuninitialized -Wignored-qualifiers 
-Wno-missing-braces -Werror -fomit-frame-pointer  -fno-stack-protector  
   -Wno-frame-address  -fno-pic    -Wunused-but-set-parameter  
-Wno-override-init  -Wmissing-prototypes -Wstrict-prototypes  
-mlittle-endian   -c -o powerpc/selftest.o 
/root/chins/git/kvm-unit-tests/powerpc/selftest.c

Infact, if I just execute that single command independently to build 
asm-offsets.s, it works as well.

However, I noticed that if that single command is executed in a 
directory (build or main directory) where configure command hasn't been 
executed first, that is when the error you have shared above pops out. 
It is probably because configure adds some file to ./lib and those are 
included in the clang command using "-I lib"

Thanks,
Chinmay

>
>  Thanks,
>   Thomas
>

