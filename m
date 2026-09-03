Return-Path: <linuxppc-dev+bounces-26479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D5BC624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 08:41:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbCks27WLz2yrr;
	Thu, 03 Sep 2026 18:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788424917;
	cv=none; b=nPBcEjCk0dgU94ZeHQS4ycwOIR1Bq0A18gSEXUUE/vaQUT9Ueg/VvX08Bv4+yqLsjbtw7E4HXOzXMxHV9vhQ3bWzVit/iyDHr5lkCOLHJq+nHyTWMHEhaaMGUi5KFrrUI+89txpkkmrcDIMNHtFp2vTxkLLlOAwQpC0xkjDxd6+oMqx6iUSQe6+WLw3/hsnDN2PFoj2mQpfxTHqYjtDTPJL7VGi+t7UaEqisB96M4UX+cIIDQ/M4aURlM67eOQ82+CMY3JTzCXder8hzYWuybDwDAh/8RWtB5b974WBPcYtP3D/rKNamazw5fUn2mK3Q0f0QGPnQQKVNoyOG+FToTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788424917; c=relaxed/relaxed;
	bh=D4J7l7+GI8i1Iz/91kpi7I2d/PApSXUNf8K6zGQYz5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETMti184RM1Xnt+JZ1Kl8OP6oUueeWsdW0JnBYqRhgXk+ENtlCJ5fFxQIMFx+8v6OXev5bguMK3R4h1ihPN3wEojLMVWb1ev8QuJwhLKCH40uPwzyJoXgPNbH52maeKQMMM7YuxxeceYGE/1PKQoPjacoe9KYlnZ1f49Pk+eGKcVnPw1jGmXIMS3dcUXsSCYJ7OJ061ZAPn0yXqRzhajwIjvQ4CJ3tmy8poAhOOuTasQ/Ka2DGY52ebcJOCme6EBc9MzmFvwUtOtXcfzaD7cutB7bjEFnn7oxYAzFvLPwqQzAJKjOHSG30dMJABLVEya/I22moove2Birqm7Z5KzBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tBmVPuh8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tBmVPuh8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbCkr1nTZz2yrd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 18:41:56 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361fp81056176
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2026 08:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D4J7l7
	+GI8i1Iz/91kpi7I2d/PApSXUNf8K6zGQYz5U=; b=tBmVPuh89iFCGpQqxTeQul
	lOh+3VyAzQYQnarkkElxb0EaGG3eGHAx962CodOquq6CMz1aJhQT2VkZw+tviD4Q
	YhQtPod4fvly/sYsG0uGQe53bFA/kYE9lPmMyZIWCAnEf2Gd9AuPybxXQu8nseC0
	KLFUcLylDsHFQdSYwZ/BgNsIW7BbBLfsggIC33eLiOLYaMINwnsLGmTBL1QHDmEz
	n6juW0ZFHIbMW0WguLNCOyVHyC1sL2ouJwyGNoEq/DuEOFlplBbkd+pCavNuDoh4
	wI8GhOvs57X4dQHzpdoxGDGiFs+3MmHDGuF1HQtCLDEPXykV2QetWRZVXGZIVaEw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue3j79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 08:41:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6838fMJs008100
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2026 08:41:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hpr8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 08:41:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6838eZIH27984414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 08:40:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41FC55803F;
	Thu,  3 Sep 2026 08:40:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194BF5804E;
	Thu,  3 Sep 2026 08:40:33 +0000 (GMT)
Received: from [9.61.240.230] (unknown [9.61.240.230])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 08:40:32 +0000 (GMT)
Message-ID: <10bf1464-62a0-4524-aec7-7818297491c0@linux.ibm.com>
Date: Thu, 3 Sep 2026 14:10:31 +0530
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
Subject: Re: [PATCH] selftests/powerpc/pmu/ebb: fix lost_exception_test hang
 with sched yield change
To: Athira Rajeev <atrajeev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com
Cc: hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com, tshah@linux.ibm.com
References: <20260903074036.63309-1-atrajeev@linux.ibm.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260903074036.63309-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X_Pz2Yx8Ji3SlEp80dhkzULrV2J0mpbl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX0m5rOf6SLbMM
 E0YK6qMyD2KRahfmtLGRIoEHfv5Ov2NmhA+BHFlupcb4EPPEOxWpnLyBd6LrlQvT5MvnCZsaQF3
 OXfShNrUyitPj+p31gYlNHdkNS13uvVCKT//LTlS/rGdc+226JRXdntkyItcqxsyut1jsuU0YsK
 tCBSyVQTvPwjryTu6Qwif51L//AE1sZo5RyxF1SCqW+bS1WHgM2bGykPqqzeT65MUZXAUniLGw1
 /zexMnK8stBsGippe8uqQ/rc1xfWgsZNv3Z9cuvB4RI9NjGro/YTNFjp6Br9KhoV49KRUF057EE
 KxUK/nOgX2iuEI/7z2ZpPMIwXO5bE7DaAcyGx7Gi8cp7WF28Tbva03EJ8QSBYGO7/ujadoU1Yfi
 GW9PiPFPjA/FL076ZI4z5aLzXR+HTz4RZXU94OJzLTBUATsw/AT1HxudXtP3a6u1jlOd7u7Vx7q
 ufdyLHSvWLufB1WOaYA==
X-Proofpoint-ORIG-GUID: X_Pz2Yx8Ji3SlEp80dhkzULrV2J0mpbl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX9dAkdK7+oTAZ
 7ndSLOkNxjUkpwdMqHKAzl/KIhVKwh9LgDvLAmWfCe06wi/EOLp+7a1ltX7ioNhwdEyWQ1EQYhj
 5mfxYjWs7lcWZ0ZU3L8OS+L7aa0UEVk=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9932d1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=uW0JSaxYGtqh6RIesKsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030073


On 03/09/26 1:10 pm, Athira Rajeev wrote:
> commit 79104becf42b ("sched/fair: Forfeit vruntime on yield") changed
> yield_task_fair() to only bump the deadline when the entity is eligible
> (vruntime <= avg_vruntime). When the entity is ineligible the yield
> becomes a complete no-op from scheduling perspective.
>
> lost_exception_test calls sched_yield() 100,000 times per iteration to
> race the EBB exception delivery with a context switch to the eat_cpu
> companion process. After enough iterations the test process's vruntime
> races ahead of avg_vruntime (each eligible yield bumps vruntime to
> deadline, then advances deadline by one slice). Once ineligible,
> yield_task_fair() does nothing: so the scheduler won't pick the
> eat_cpu child. No context switch occurs, the PMAO race is never
> triggered, and ebb_count stays at 0 forever causing the test to
> hang until timeout.
>
> Fix by replacing sched_yield() with nanosleep(0, 1ns). nanosleep() goes
> through hrtimer_nanosleep() -> do_nanosleep(), which puts the task into
> TASK_INTERRUPTIBLE and removes it from the run queue entirely. This
> guarantees the scheduler picks the eat_cpu child, restoring the
> context-switch guarantee the test requires. The 1ns duration is enough
> to engage the hrtimer path while keeping the sleep effectively
> instantaneous; the same race window between PMU overflow and context
> switch is preserved.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---


Tested this by applying on top of todays mainline, and this patch fixes 
reported issue.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



# ./lost_exception_test
test: lost_exception
tags: git_version:v7.3-rc1-102-gdfad704d6abd
Binding to cpu 8
main test running as pid 370267
EBB Handler is at 0x10005c60
ebb_state:
   ebb_count    = 1017999
   spurious     = 0
   negative     = 0
   no_overflow  = 0
   pmc[1] count = 0x0
   pmc[2] count = 0x0
   pmc[3] count = 0x0
   pmc[4] count = 0x1a0b3f13
   pmc[5] count = 0x0
   pmc[6] count = 0x0
HW state:
MMCR0 0x0000000084000000 FC PMAE
MMCR2 0x0000000000000000
EBBHR 0x0000000010005c60
BESCR 0x8000000000000000 GE
PMC1  0x0000000000000000
PMC2  0x0000000000000000
PMC3  0x0000000000000000
PMC4  0x000000000000dead
PMC5  0x000000000000008a
PMC6  0x0000000000000568
SIAR  0x0000000010005104
PMC4 count (0x1a0b3f13) is between 0x125318b2 and 0x1e37a62e delta 
+0x7b82661/-0x42c671b
success: lost_exception


Regards,

Venkat.

>   .../selftests/powerpc/pmu/ebb/lost_exception_test.c   | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
> index ba2681a12cc7..9be5945f3b1f 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
> @@ -8,6 +8,7 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
> +#include <time.h>
>   
>   #include "ebb.h"
>   
> @@ -22,6 +23,7 @@ static int test_body(void)
>   {
>   	int i, orig_period, max_period;
>   	struct event event;
> +	struct timespec ts = { .tv_sec = 0, .tv_nsec = 1 };
>   
>   	SKIP_IF(!ebb_is_supported());
>   
> @@ -57,10 +59,15 @@ static int test_body(void)
>   		 * kernel to decide our timeslice is up and context switch to
>   		 * the other thread. When we come back our EBB will have been
>   		 * lost and we'll spin in this while loop forever.
> +		 *
> +		 * Use nanosleep(0) instead of sched_yield() to guarantee a
> +		 * context switch to the eat_cpu child regardless of the
> +		 * eligibility state. sched_yield() via yield_task_fair() may
> +		 * become a no-op when the task is ineligible (vruntime ahead
> +		 * of avg_vruntime), preventing the required context switch.
>   		 */
> -
>   		for (i = 0; i < 100000; i++)
> -			sched_yield();
> +			nanosleep(&ts, NULL);
>   
>   		/* Change the sample period slightly to try and hit the race */
>   		if (sample_period >= (orig_period + 200))

