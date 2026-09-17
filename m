Return-Path: <linuxppc-dev+bounces-27563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479E0C982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 10:29:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlsS63cl0z2y7Y;
	Thu, 17 Sep 2026 20:29:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789640950;
	cv=none; b=ar0WHyabUFqs655hkZaXojGvF6r2mtw07x2vPW04CKtdiXa7fRGkpbTN63EVtdxoHhcoHed35ENJhElQOjO8LL3/3P6qgvCkgb4ZXO23arahlfhbvLDEdoKn/5yNsrf8q6k5yfL3eV/GtcGH8RXMGJUaf8n46VYkOy0bUMImwhpE/GyYnZEnFHADZ5z6Fq99GC2l8ACpuHi/K81k94v2i56w6Ode7TaTeVsMuWmobs9/ihw4bWLn621YhGfW+oSpWUAE/gNShT+vcjJXuWTQDJLO9h4vMih8Ohtu9pnOCqQYvk39TK44pSj1is3pZ+6ZjxsJI58M6AanvjoXV2rY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789640950; c=relaxed/relaxed;
	bh=+LbJ8sb8tbczMZi2OZuBLEjEt/vDZC7a90/SRYbu4dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXU94IUIbzYH2EK//2v50ffpT6u9CYhzpR2S9//g1TFghis+F1ffGA8JOb50RCytPTZR8CrndjrD8xEQamGDjLXK6lpeSneZ5aab8h2o4EqQAhrDx5+0y4iYmFHMe1pfSiOg+20lwaLRDfBBnRRAkYhKfAja2PN8TKvfNvRLQE3MZo0+dqqup2AhbOxfH15gvmNBXAiC6s6EDtyItqf5h/Sil2G5yxWEx72fLjlnhndCz3l4r8GXOaX7wh/TFxDFZtQynyJq4qW+2vR6albChAFvc8egOsJDJmoHi4c8SuN7i6hhbNdDHNflAaZQiBaM4XqGHaTxnZGpm3oOrR/l4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BRILXYYE; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BRILXYYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlsS521W0z2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 20:29:08 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1fGZ1032192;
	Thu, 17 Sep 2026 10:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+LbJ8s
	b8tbczMZi2OZuBLEjEt/vDZC7a90/SRYbu4dQ=; b=BRILXYYE5yzV5ngclOAXCH
	sg7UxiF6fvAy47sKLn9AXdzpTTkn8aV3cM2v+k5XkihzCd1DHWunWMRNHoh73vNv
	fBbH8ha5BVMK+JCMSyaXx5kEFsFgtXqhpuicZxfjTO5hMF8qVXEHZ94FdBrL+J1b
	01PgZF555fmIQclaV1g4dLNTCzlyquwQQMMkSRAp7p4tkalsz8RvSqYE9yKYq4TJ
	PUuVlLHGTekiOtiJjQGEM1054XRrI7H2PVNrTLMyjgWWCHiUa0g9N70i2w2u2ITH
	HXxD5TYEVIbHe2uw3tpnN80eYI4HZgR49QsOmjR2x0/n/wOlR1ZHPB1o55v+u/nQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e9dc1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 10:28:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aSxr2900089;
	Thu, 17 Sep 2026 10:28:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjhxdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 10:28:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HASk7f48365876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 10:28:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A04202004B;
	Thu, 17 Sep 2026 10:28:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB05120040;
	Thu, 17 Sep 2026 10:28:42 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 10:28:42 +0000 (GMT)
Message-ID: <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
Date: Thu, 17 Sep 2026 15:58:42 +0530
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
        Narayana Murty N <nnmlinux@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
References: <aqJxcWC1dWKITCav@kunlun.suse.cz>
 <393117bc-094e-4c47-b061-f255f5bff937@linux.ibm.com>
 <aqKUhHb9UTfVq4As@kunlun.suse.cz> <aqKfsVArHHaIK6M9@kunlun.suse.cz>
 <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
 <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzOCBTYWx0ZWRfX622FybRPC7qu
 bq3870ojMzGRwA2hAPYJ2Wr0jEdSUre/xdnSki1fbu+rs9iL5E18Kc8Xq6JaRjRm3kpH1S6AATd
 Z6u6tZQqqaYtEQWPrOZRUYWt01iDiRzt52teWaytTfP3pHZn4KKMdOmDtHTmovlPFMW8XYS6I2s
 tewI0PfeNykn922bnSH5CTYkPV2QPqGsdu2onb4f/kdbOugWnkjT/cehucUJPuiJNE6KdEVHUcb
 cFP5gxdRDo+4/aUZ/oaClyKJNnaS4yemoZXvC2CmNKgmVdCRKXZSb+F3a84Bi+UNoxwarXHAqqu
 p5jagbXaJ/03omXLeraWxx2vggqsy+xZSfU6n6z/8d3hRxkVxHWG4B19fyv3OqFs+YnrkE7xO62
 coHcxKdZpZaftPeHvAD0J3L0vnXIQX3GkprBatbQdF4EC15+5zZavmcoVs2iI+cDs7QAR4S1VeG
 ZX9uvnxm51ImRZxKnzw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aabc0e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=vMVXlJkmbgminkodvmwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: N2FW1pmmq0irOBOdc7YhXFFzROEZ95ur
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzOCBTYWx0ZWRfX0zdO5ls3csNt
 HF7wnOd2/cy5gSGoufTqJP1ELQMSpVvV7iLwcuqC5l7o97HSXM4Uc4Uke9nZcRaPfDeNkKkQfxu
 D2e81hTTfjckp/gsZ225XV25egpI7D4=
X-Proofpoint-GUID: NBmd7lCXUg7_uguVmnXgR3X5wrX43E4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170138

Hi Michal,

On 9/17/26 3:44 PM, Michal Suchánek wrote:
> Hello,
> 
> On Wed, Sep 16, 2026 at 11:41:38PM +0530, Shrikanth Hegde wrote:
>> Hi Michal,
>>
>>>
>>> It seems easy to re-create.
>>> The key is running bcc/bpf program in parallel to kernel build.
>>>
>>> For example, these two in parallal, leads to stack corruption panic.
>>> Stacktrace does differ sometimes.
>>>
>>> ./funccount  rcu* -d 100
>>> make -j 32
>>>
>>> Boom. Will try to debug this further.
>>
>> A bit more debugging.
>>
>> 1. A few functions seems to crash, specially ones that call schedule.
>>     So picked schedule itself for tracing
>> 2. Used plain ftrace. No crash.
>> 3. Used kprobes. Boom. Crash appears. But this helped to avoid BPF JIT, or BCC part of it.
>> 4. Did some preempt count validation with annotations. Seems to be holding fine.
>> 5. Since unlock can call schedule while tracing schedule, there is possible looping.
>>     Need to see further why it happens to be crashing there. Maybe regs or paca
>>     handling needs a closer look.
>>
>> For now, below patch helps to keep the system stable under kprobes, bcc tools.
>> I will look further into see why exactly it is crashing and below one is going to
>> be the proper fix or not.
>>
>> Feel free to give it a try.
> 
> thanks for the patch.
> 
> While it is mangled by the e-mail client in different way compared to
> the previous patch it does seem to mitigate the issue.

Thanks for trying.

> 
> As it is unlikely the board where KVM lockup was originally observed is
> running kpbobes it will probably not address the original problem.
> 

Give it a try.

I am suspecting both lockup, stack corruptions are secondary symptoms here.
While recreate, I have different type of traces.

> Thanks
> 
> Michal
> 
>>
>> ---
>>   arch/powerpc/kernel/kprobes-ftrace.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
>> index f8208c027148..bcb1e8a8995d 100644
>> --- a/arch/powerpc/kernel/kprobes-ftrace.c
>> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
>> @@ -63,7 +63,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>>   		__this_cpu_write(current_kprobe, NULL);
>>   	}
>>   out:
>> +	preempt_disable_notrace();
>>   	ftrace_test_recursion_unlock(bit);
>> +	preempt_enable_no_resched_notrace();
>>   }
>>   NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>> -- 
>> 2.52.0


