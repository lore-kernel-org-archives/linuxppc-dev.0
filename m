Return-Path: <linuxppc-dev+bounces-24115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9418EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 13:38:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzNnS1XL8z2xwN;
	Mon, 13 Jul 2026 23:38:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783949932;
	cv=none; b=XUiSE6dukPprX0rcvpVfxPvWiPVx1bEf26P2JYF4EJCGf5ZRhuOKTk3RYA2+4h6rsjRDJsyG0Bd5tK9MP7zcT9UbyWvsgPTnN+UvWCDt7uvXx22sLdx8ErTyzIb/Lkx3K1ePvUPXXh7gEebcwb61Gu1BxiHJ+dHNzmMwQVzLzN4Wgm6p4jvKlsEAfgyLSLDtjjVNf0FGwwzlXZd9U+uaMY1Wz3wrYMWi/51YcRnNAUyDLWZvdo0fXrruxIrOJgyDfp7rUAMA19kX+TwI2qIQJE77r1KDWgDTshfqr/DNTxyKQSFJ8+2565v3wwbKUOr8XTZQsEcTYmCYruozPkj3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783949932; c=relaxed/relaxed;
	bh=QDT6NxUXtQ0d7xpPP4Zq7vIAgPv2bMd/AWmrj8RSsp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNYfBO1T9MBLM+O0KHeVdNVlPhjTeA2GayHlYRxV/LHgo5ywFxz+pJ4naFgTngE+xDkgtyumtTfhkoGbshxLIOuX2hj3A2bvAFf9l7qADDlop0XjpDfo/6d/fLLoqFANWfOQz7ntcVH9k+w+9iu/BOpQvn9e+AiBCzro3qXOQVBOEizBnue+KqaOnAc+CcXHY4YZ/nhWgZfXYoHD2elaW/YFqtA/5Z73zCPpKUXMPotzo/uN5tUlJ5PaaU3t4pZAOojtVRCKHr4aTKDZMRHW76PkNAeRUyo7/X96ie5MQ2ytsk/K3tY/fD84bzkCHTlcnWoQrWc7hKGQfdEAaQr3SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=osqxt6al; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=osqxt6al;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzNnR15FNz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 23:38:50 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDH4j2437906;
	Mon, 13 Jul 2026 13:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QDT6Nx
	UXtQ0d7xpPP4Zq7vIAgPv2bMd/AWmrj8RSsp0=; b=osqxt6al24b5Ab5z3NPTRc
	sQUUDJIpfcrYtMYlCXYdx6gBifAx0jP9f3UEn7c7Mk+Tt8NK4mrCrsn8NUVjSgWA
	+GScONzIT7Ta0DRYcC34/XDLdff4CvNgRg5p+OPWFDtfcJwFTKtczOnmpfINuvl7
	qiQZzerr8e1PzWIOf1on5oG+NshlNOJ+1BINMXl1sxbGcvLR1HaaxOXMpxWCO0T7
	Jaxec/QAySgbvbWlrg4KZmqheQ2mGAq3eueRNB6BGb7RKSZwlBdniLnYb9O37OdF
	A49xN6BrypyhHJWHy+YgkitdNvOaj9OQzp+VbQPhwfIhzY9m2cGp/EtIg7PYKIQg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx8v75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 13:38:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DDYlq8024929;
	Mon, 13 Jul 2026 13:38:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxwjud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 13:38:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DDcaLe30736916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 13:38:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B212420043;
	Mon, 13 Jul 2026 13:38:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D16C820040;
	Mon, 13 Jul 2026 13:38:33 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 13:38:33 +0000 (GMT)
Message-ID: <eaf57ed1-216c-4ccf-9418-d3ac3e32f078@linux.ibm.com>
Date: Mon, 13 Jul 2026 19:07:51 +0530
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
Subject: Re: [PATCH v2 3/3] powerpc/crash: stop watchdogs before booting kdump
 kernel
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org,
        Mahesh Kumar G <mahe657@linux.ibm.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <20260713035954.1559605-4-sourabhjain@linux.ibm.com>
 <o6gbv5jl.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <o6gbv5jl.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cwabT_ne3oPpz8luNwdtUvsIYdM6W-bT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfX3gaKfNxfCtpE
 hKki+iv+VDoZPT7LSnfYQ+ch4liiXbB+k3SxuMspwTbG4SqzZgxrAH5vtqakxzEfG4yJwLxtqm2
 +JHLm1HJ/4r3QDTnlxQ7UfItDsy4L+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfXwITQfhe7hiGP
 CKcdJuOP4h+FVNPU+M2Kjs+nffiRVKRK/cO3M7kTpdaWTXmml9YNnsMusJ1iLDlUKAma3Yr4vFW
 izEKwnoUE1+PwRdDpDR6k/NionnitXOU7EZslMME4VAZM3gMfn98arEcFymY2ABagYqdF2Z6bJo
 OfN41XlcCKUrN42KkFcE2bmt2akGlOVDgqCJUcj7fkNjxlplClL7XkTd7RX0xQDWxcYi5FsfJoM
 Aq6aWff3FJDrjwbYF4qWvo0oKpAOptmyqBtT/7AB6qvrqQladuJn1IZwhv290TwAwo0F7LnrOjv
 y7nu6yZGrgSLPROwxM8ALEMIn2Gq9A/NbsffLUltDLMulP09jM83B5YzjZVKM0pXIzsXg6/tLK4
 aUl+UEOFHTyTp5Acx4BtgNkw/ZNAbzQOXTRGkR57M0vzQ1gBTIvBbHKpJq85CeBzgODbQA/j3Vz
 JCSidm851+98zKdP41g==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54ea62 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=D1YSW_bcgk-0_7OrHpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XlhPyuiRcGrhvbLG99jKz4skMF3Aw6eA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130138



On 13/07/26 10:40, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> On pseries LPAR systems, watchdog timers configured from userspace can
>> remain active after a kernel panic. When a panic triggers kdump, the
>> crashing kernel jumps directly to the kdump kernel without stopping
>> active watchdogs. As a result, the watchdogs remain active after the
>> kdump kernel starts.
>>
>> If dump capture takes longer than the watchdog timeout, PHYP resets the
>> LPAR before the dump is fully captured, causing dump capture to fail.
>>
>> Fix this by issuing the `H_WATCHDOG` hcall during the crash shutdown
>> sequence to stop all active watchdogs before booting the kdump kernel.
>>
>> Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
>> Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/papr-watchdog.h |  2 ++
>>   arch/powerpc/platforms/pseries/setup.c   | 18 ++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
>> index fb3a511aa861..84bbe1ddd56f 100644
>> --- a/arch/powerpc/include/asm/papr-watchdog.h
>> +++ b/arch/powerpc/include/asm/papr-watchdog.h
>> @@ -55,4 +55,6 @@
>>   #define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
>>   #define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
>>   
>> +#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
>> +
> minor nit:
>
> This should be defined at the end of the H_WATCHDOG Input section.
> /*
>   * H_WATCHDOG Input
>   *
>
> <...>
>
> Something like this maybe?
>
> /*
>   * R5: "watchdogNumber":

Makes sense. Since this is the third argument to the hypercall,
R5 is the correct register to use in the comment.

>   *       PAPR says use -1 (all ones) to stop all watchdogs.
>   */
> #define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
>
> /*
>   * H_WATCHDOG Output
>   *
>   * R3: Return code
>   *
>   <...>
>
>>   #endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index bbb2813f8ede..2e40a9dba637 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -77,6 +77,7 @@
>>   #include <asm/dtl.h>
>>   #include <asm/hvconsole.h>
>>   #include <asm/setup.h>
>> +#include <asm/papr-watchdog.h>
>>   
>>   #include "pseries.h"
>>   
>> @@ -185,6 +186,18 @@ static void __init fwnmi_init(void)
>>   #endif
>>   }
>>   
>> +#ifdef CONFIG_CRASH_DUMP
>> +static void pseries_crash_stop_watchdogs(void)
>> +{
>> +	long rc;
>> +
>> +	rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
>> +					PSERIES_WDT_NUM_ALL);
>> +	if (rc != H_SUCCESS && rc != H_NOOP)
>> +		pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
>> +}
>> +#endif /* CONFIG_CRASH_DUMP */
>> +
>>   /*
>>    * Affix a device for the first timer to the platform bus if
>>    * we have firmware support for the H_WATCHDOG hypercall.
>> @@ -203,6 +216,11 @@ static __init int pseries_wdt_init(void)
>>   		return PTR_ERR(pseries_wdt_dev);
>>   	}
>>   
>> +#ifdef CONFIG_CRASH_DUMP
>> +	if (crash_shutdown_register(pseries_crash_stop_watchdogs))
>> +		pr_warn("Could not register watchdog crash shutdown handler\n");
>> +#endif
>> +
> minor nit:
> I don't think we need any of the #ifdef. All definitions used inside
> pseries_crash_stop_watchdogs are already available and
> crash_shutdown_register() already exists for !CONFIG_CRASH_DUMP, so we
> may as well drop all of the ifdefs.

Yes, the #ifdef is not really needed  because crash_shutdown_register() is
always available.

I removed the #ifdef blocks and built the kernel both with and without
CONFIG_CRASH_DUMP. The kernel built successfully in both cases.

>
>
> Otherwise LGTM, so feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Thanks for the review.

- Sourabh Jain


