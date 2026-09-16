Return-Path: <linuxppc-dev+bounces-27507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA61BC982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 18:12:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlRmk5MByz2y71;
	Thu, 17 Sep 2026 04:12:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789582326;
	cv=none; b=S5Ihh36WNclJgSNjd9crvEMsiAvf+mljO7umNRVa6RFPGBOQXUWAmUX6SuSY6IUA5tlICFyIDfhPi6VWDfl/JhkH3bVTo2coUN5kK5HfcoaL9eCnN/+qUFIBuEn5NeIHqKiSkDCC5SnoQK+Q/x1aJdHaJ8Hqqu7nDMQ6j4mfSyHMMFipM+NaXlq/FWaDSxfOZTeTtvTQc6hl8m9pRoaI3LVFDZYMnYdcR3yxfEp89RJwCB81rpxzb0s3S6QT4oYEpoNbFbbIiZG0NoX56uKGdN2w6IE3n4GMm9y8zpOGkUasmHKyj4L2Yx+Eo67aTP9ndRFBzGSjBqXJ49A/LgH7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789582326; c=relaxed/relaxed;
	bh=9bfsouon0yWRpaf+eMX81jGyrvm2CXZlCIOmzpWS2p0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dAD7rjymBMMb53oaEhbazqji1pz0M1i0xru893iMdhVtjUJCWF5/TRD9x4qqydH63wtabR6BE5RzQoSyYhyKiWpLfCVcwiW+FZrKTVkGY/yVWhvmXj0aomEbidX8YI3/uWRhEVtDFibJYynCl0gLFAs69CiaSCICCAeqSmYPgId1UYHcdEcpIxuzf2oeQ12l6hUEgvvNhCawlrN6WUK0NRoThyEeJM3qPjlKBmRTQYm5z+fOnmS7U5ohOV14JtAtuukRACxIkrZPCbjZvoCv8UT8g/Kta54Ija93puTN4+bDqjocxbbB5FTHr/s8quk878q8pvdeULXcsCfzV4yupA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nHO8cH9d; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nHO8cH9d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlRmj4TPRz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 04:12:05 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1eZY2330067;
	Wed, 16 Sep 2026 18:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9bfsou
	on0yWRpaf+eMX81jGyrvm2CXZlCIOmzpWS2p0=; b=nHO8cH9ds1ImvuHWTsYPuO
	G7IRIVEHNuIZIoAP71POUGGtVyF+/EzLL7jXMDvY+Pxkhrgn3HxUmhsbd+qhaOIO
	zCVbzWn21OaKwr/cp40DzFVB9oRiUIOFSa6e8jP3mpjhYzTAwzW50FKTu9QUKugD
	9Wvr5FoivoZhpnqMeciQE553Ds5Cnop3VEgs0obiTYR8zhOa2BDxmikYCIvoaE3Y
	p/RQ7G3q3rYgnKYUMCzwnhAMuwqLIgtwt46zRWDM6tftcxiEWpCA5x5E4aHYW8Xa
	PmytqMX6XywIcnMiRqrscXcgj6CyCEP+zFr9ypn8rsKCARdHWDSrhphjMKg+I+Ww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqe63n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 18:11:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFe4Yj1713037;
	Wed, 16 Sep 2026 18:11:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpyweyqsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 18:11:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GIBhNM25952752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 18:11:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6600020043;
	Wed, 16 Sep 2026 18:11:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 345F520040;
	Wed, 16 Sep 2026 18:11:39 +0000 (GMT)
Received: from [9.39.21.238] (unknown [9.39.21.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 18:11:38 +0000 (GMT)
Message-ID: <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
Date: Wed, 16 Sep 2026 23:41:38 +0530
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
Subject: Re: [Linux PPC] Disable PREEMPT
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>, Samir M <samir@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Narayana Murty N <nnmlinux@linux.ibm.com>
References: <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
 <app0zGv9bvtL4nHm@kunlun.suse.cz>
 <4eef1f0b-0c02-4377-b950-43c3b120865a@linux.ibm.com>
 <aqJxcWC1dWKITCav@kunlun.suse.cz>
 <393117bc-094e-4c47-b061-f255f5bff937@linux.ibm.com>
 <aqKUhHb9UTfVq4As@kunlun.suse.cz> <aqKfsVArHHaIK6M9@kunlun.suse.cz>
 <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
 <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI0OCBTYWx0ZWRfX+0UAaLokyp6R
 dEf3WjFrlV1HEPWVo+0mvBXjrwuItUl7R/oCDWUK65+ZcO+UkpANUjBPIIAmhghr3GmsXz1Dqbn
 tolyjGoGnNwAsraNThqzK0RF/+ImfANZHEBUPV8KKGorVBdkK78E7+ybctEelcBe5PM8BSFzhYP
 xl/MylpO7yLYEfke6iT7fe4qbxbtNFD9ZjaRq8uA30F3oVekrMLhy6r7shVj3nUFa97YebJs3FB
 j9gA7cPrElcY7ijSkuqGCvBbvAUbmL1XUg12Et7bcSokCtGCyrYHgBg9YUdeQDsU/Jq8A4SRs+E
 YZpM78AOTT41PPZNgd0co1tRm/42Fm38CwR/Vsv24Lg2Aoayfj5XZqyuByzvwQGAOqrW5nhQgBy
 XF9h6yi7hu5+0peV3i895GHR3nlJb/GPd9BiTF7RVqg+bJkaYXH68UILgLDors2CYJvfNdhv6ag
 2q9q/I6AuPC4L275T/Q==
X-Proofpoint-GUID: cbuSvpAasOnQbLmrPo0J5F9gsvoqm4j9
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaadbe4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=t9zRotgyz75Mt5sWWRYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Yrq15UHCBxwAmXM_4CePaMou8iJnIeMb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI0OCBTYWx0ZWRfXyM9WgoRpCRGI
 VHbrwx6DgNub5tmAcYo1SlgQPWxTEARTQ1ll1KxQAAGTfSn64b7s+adbgD4mieEyiE21J1JoZ+7
 zb6KukvQWJU4WFXuO0Fju6lPDs4xZxU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160248

Hi Michal,

> 
> It seems easy to re-create.
> The key is running bcc/bpf program in parallel to kernel build.
> 
> For example, these two in parallal, leads to stack corruption panic.
> Stacktrace does differ sometimes.
> 
> ./funccount  rcu* -d 100
> make -j 32
> 
> Boom. Will try to debug this further.

A bit more debugging.

1. A few functions seems to crash, specially ones that call schedule.
    So picked schedule itself for tracing
2. Used plain ftrace. No crash.
3. Used kprobes. Boom. Crash appears. But this helped to avoid BPF JIT, or BCC part of it.
4. Did some preempt count validation with annotations. Seems to be holding fine.
5. Since unlock can call schedule while tracing schedule, there is possible looping.
    Need to see further why it happens to be crashing there. Maybe regs or paca
    handling needs a closer look.

For now, below patch helps to keep the system stable under kprobes, bcc tools.
I will look further into see why exactly it is crashing and below one is going to
be the proper fix or not.

Feel free to give it a try.

---
  arch/powerpc/kernel/kprobes-ftrace.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index f8208c027148..bcb1e8a8995d 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -63,7 +63,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
  		__this_cpu_write(current_kprobe, NULL);
  	}
  out:
+	preempt_disable_notrace();
  	ftrace_test_recursion_unlock(bit);
+	preempt_enable_no_resched_notrace();
  }
  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
  
-- 
2.52.0

