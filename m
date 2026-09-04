Return-Path: <linuxppc-dev+bounces-26540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA06C624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:24:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbrdf2wNZz2xlY;
	Fri, 04 Sep 2026 19:24:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788513878;
	cv=none; b=kEQVf83Ds+I2zlFpXC4ZERwYNmR1ZsqUpJ+utGP+QKKggTK5QRx8IogYMgbO4sqO+327FSkkOHVomlaBGTNXv+fGOvU7ZjsRDPwCrC3yxy1YINvXr1sk01WMgDxs99C0QfJsEq40iB9yuhS8iwDzuOi4+FiZ3sCJNT6I3m3HgrXPoGN9fzZEhEPTGIzLVNDxoviVnEfx4bU95KzU0ANm9JuQm8Z8pX2UysjzdKaIAFaTaKASmihflpdFpWgLY38V2msVzYBc+JKTgl8VASsiueWGjXBymLapSTbq7DD5cm/ImYuThMK1m+ZZJhbMDqJZj+D1kAR0aZ3u50M6pw4c9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788513878; c=relaxed/relaxed;
	bh=GCyo/z1PVKw/vEnQWI3Y65QBKHnd6p9MeF9Feaf7KqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn3WeW1DouFpNV0l3VOOf6zbMX5YbRv+fJJLIZizroZjqHBgB/wIt0kTaB1YVtvRkNJK2O9UAiNa2SN4L2iZpTaOcTqeLT8wlDFGdDWdg+hZXV8iE8KpB9XKkXsdU5L2Sr1nfXLqYQBd/rs1isYUWolHogyEPDXAtiwVXKLeI/VgoSah9bJBBsQScvuoNQxX7ryphuW39UAE55DsJ6Ibk8LDGRTbXCEIFhdbnIbitXrWR96RPXcdjtUIE8AaMAc9RJ/x7gWH2dXrZtHxPj/BC4KTnCLBHviBirV94T29m7nusvxFuisqGjJYNVyDDDHWsmkOnyxzVS0Nmm9og5SDNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bwwjuS1d; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bwwjuS1d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrdd4YMkz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 19:24:37 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464V9q937015;
	Fri, 4 Sep 2026 09:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GCyo/z
	1PVKw/vEnQWI3Y65QBKHnd6p9MeF9Feaf7KqE=; b=bwwjuS1dqHbKh+e2nh2S1q
	liikUKW9EDppBLtjAFMr2s9D4Z3+SKF0EBVHUM/azihQok5aeqsx+0YER3Z3xo9O
	VvnkGYfX5tEzuczdVdjwy+jkA8TO9lglUZBK+MMmSkULmu4As0XUZnHf5M3PEojV
	BV97XrMYJ6KBPnN7SzYRgvektT7bjoeTFtMi6gACESOXAGPeEAq5v8AvtNqg2APa
	vPw48J2w1UIDULM5+oP15fsiM15pTIn+Q8778HcQzl1EWzVzDZnkadw4gCiEiRy5
	dnH2hwQw71171XtF7EwSSMYL0ImsQ+xAyRq092zkt2H8b1Cu77awlhyyJW392QGg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx61v8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:24:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849BMtR016730;
	Fri, 4 Sep 2026 09:24:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkm862-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:24:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849OPTA40894746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:24:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3305B2005A;
	Fri,  4 Sep 2026 09:24:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 398E42004B;
	Fri,  4 Sep 2026 09:24:22 +0000 (GMT)
Received: from [9.124.221.192] (unknown [9.124.221.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:24:21 +0000 (GMT)
Message-ID: <af7a8fa3-8ac8-4b97-bff7-5257867e7209@linux.ibm.com>
Date: Fri, 4 Sep 2026 14:54:21 +0530
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
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Christophe Leroy <chleroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
References: <C78B55EA-2CA1-481F-9F85-597A88B80F94@xenosoft.de>
 <2F1C6E83-7A50-491C-B4F8-32885EED9D41@xenosoft.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <2F1C6E83-7A50-491C-B4F8-32885EED9D41@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9a8e4d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=6rdme_d54tlq89W0LHkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Hvn2tiHy5OOHoKa3sP7n_-RXMadeEURJ
X-Proofpoint-ORIG-GUID: ROaXn4PGrGh4sxs_V4A7yuU0le0XwE8a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX6QdJevZO3s3h
 3hDRtTL5TLV7j6zuBXs5/Phcl327gep51naDB2dwOcz7uhXaLxEQ3NA+n9rAb6/1T59YL0mqTR0
 rTIRvt4iPncwBL9tzFcok4r/Zq3LhJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX5i4BKO5MlsT+
 rsE6HXsSkBSOzO386GKktclNfXFIiExPnrvegXXMD1VUWEw8+woXjl4D7Sdpkn4jdHGK+UAxOC/
 0/NGZDr1X6vgD4iXLoOgRVEimQ/XWkXuMmF9URxMMxv2HEdUWXi92hHr+BfboZBH+SIyKZKxy8T
 PicZT1ArigCzonjzCvQyVqtRXVGhTzpAsKkvF2OaPVJsn5xYzIgBfItmKJgDubHMeSErVQ230AB
 c2wcKe+BmwMGHHaIa/aV+2q2SBOHJOrNfKNKN/czEglBknGfC0mv+p3ZxDde1pnM6pWG+tzabgB
 5X7WuEpmu7UINYxHArgZoQMmlcZFdQYcFYUZHrxuHVyLXqopnKEOqSzCe6sFX8kyIsQJEpymzv6
 WlLSlrrCpFSl266LX3xqZAoezSxfOsYL6LsY+RBua6SFqiFZAbsv2X7KtHqp6R8feUOMlilr2DU
 H7v6vLXkCj/XKheTMkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040082



On 9/4/26 2:50 PM, Christian Zigotzky wrote:
> 
>> On 04 September 2026 at 10:56 Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>
>> ﻿On 03 September 2026 at 07:23 Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>> ﻿Friendly LLM analysis says preemption is enabled too early and before
>> completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
>>
>> Below is ONLY a speculation and completely UNTESTED.
>> Maybe worth a try.
>>
>> ---
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 0409ac9e7b31..78d2b0618887 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -5049,8 +5049,6 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>>
>>        powerpc_local_irq_pmu_restore(flags);
>>
>> -       preempt_enable();
>> -
>>        /*
>>         * cancel pending decrementer exception if DEC is now positive, or if
>>         * entering a nested guest in which case the decrementer is now owned
>> @@ -5072,6 +5070,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>>        }
>>        vcpu->arch.ret = r;
>>
>> +       preempt_enable();
>> +
>>        if (is_kvmppc_resume_guest(r) && !kvmppc_vcpu_check_block(vcpu)) {
>>                kvmppc_set_timer(vcpu);
>>
>>
>> Michal
>>
>> - - -
>>
>> Michal,
> 
> Sorry, I meant Shrikanth.
> 

Leave that patch, it was only a speculation.

>>
>> Is this patch also for the issues with KVM PR and KVM HV if PREEMPT is activated?
>>
>> The entire FSL Cyrus+ board freezes when using KVM HV with PREEMPT.
>>

You have any logs? can you try with latest code? maybe 7.2? there is usage
of generic api to handle the work now which renders the patch shared long back
which you tried irrelevant.

>> The guest kernel doesn't boot if we use KVM PR with a PREEMPT kernel on
>> the PA Semi Nemo board.
>>
>> Bug report: https://github.com/chzigotzky/kernels/issues/19
>>
>> Thanks,
>> Christian
> 


