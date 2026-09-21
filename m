Return-Path: <linuxppc-dev+bounces-27864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60448C982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:21:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVPT5Py6z2yfH;
	Tue, 22 Sep 2026 03:21:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790011261;
	cv=none; b=dJ5IgGvNB4Gc7e9NRUQvkKyAXJNt5Bxo48FhwpSmfmk6rl6Up69ta2Cj7EuelxHPPi5+ToZOw3bqUYFsLuaqrsxYNUi6ZwEYvVy+4RB2zL7Te26TXlwv8mBXCLaLOg/e36u4v+nT6sZpfcIMKOyIcBac9bbheFNrH5/hspHDKXtrr5ykDkhU7S8F3wp+nMimyE2RH+fNFMIRsysQs3yUHXHUM9vCWJOBeVAFhpf9yGUrxRd7kdfj0y0/elsB9u5q/Sof3tSBfkbStntnXoeo0lVIDhs2JgT8ALyhWIYsGhtz7/e2FoYtoKMWp0375mhh5tbyuJeLnRK4g9KXloSdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790011261; c=relaxed/relaxed;
	bh=t3duhJIDMyv8h9ztqN7LlqhPy7Whv2C5EzxKkEVYA5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acgt7YVdnalOs6Yd49fdZRUCmGgflQcD5vW5tpEgDFT/c+MpUcW8l+bOdZz+p2XWJ+W7Tn7LECFP7M4uVEwXnz53wsFBgL0m2QBxQw2J0y+A3P5AOHIh02Y2VTyZ/R0V1trVF4nBKiU0/LQru4G+TN6qw/oypfaHjWqXmACPgWtv2e/gpb8uNumwDKcVNNQI6BaKJUg3L/bpuSqnCl7pPv7YWG3Zei3066wy8UrAGky7R7JcNjRjbCH1qr9dKEfVXXWmrDu73HsKrtESQ5zRqTT0E2AFJLdLHVMgsbAnJLm0rN5OqlNO74M3iP/R1eGUCRythysDrxT8KnNBok+etA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tdo0cbj5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tdo0cbj5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVPS6yblz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:21:00 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8N3t1869624;
	Mon, 21 Sep 2026 17:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t3duhJ
	IDMyv8h9ztqN7LlqhPy7Whv2C5EzxKkEVYA5U=; b=tdo0cbj5/Y4mUBw6+lAKMY
	/xvgY8tvRbvu3d3ZXPk/piGbEBkTkzyTvlxmL2M1v/KnsS4eWiSNrJqiMjRe9MXO
	fu2va0PyFKlg+oFEvPe8JsGz0B9F3Ff81D5+Wnc2cquRJXl7s1ogUet+JlP+Ue7x
	EA2TSAqmYQw1roVMKnUXV/uTp+9joDXZGhFjL/+AekI7tbaE3izkMO7Lgaz611Am
	ed2AouQR6IaXMItnzjnbYqSPKAN6JIaddjwhM/NcaWECklihJWBd5AyrX0GICCUa
	sH1JuXvH8MLx2QQ07lnhMR05fPe6j9HmGDotM00Y6Wf4EQ1p86ii78w+ghzYHm3w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs1uj1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:20:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHTVg1489431;
	Mon, 21 Sep 2026 17:20:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq6f2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:20:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LHKke251183998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 17:20:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9178920043;
	Mon, 21 Sep 2026 17:20:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADF032004B;
	Mon, 21 Sep 2026 17:20:42 +0000 (GMT)
Received: from [9.124.208.199] (unknown [9.124.208.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 17:20:42 +0000 (GMT)
Message-ID: <bebaa831-9d56-4276-9422-9c5da8ab220f@linux.ibm.com>
Date: Mon, 21 Sep 2026 22:50:41 +0530
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
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <d98e38cb-74d7-48b9-93f3-7c20ff910675@linux.ibm.com>
 <aplclgAsq1d6f5U-@kunlun.suse.cz>
 <1d83264f-8eda-4321-9200-f12897e38cda@linux.ibm.com>
 <aplnPuVk4LWgpu3n@kunlun.suse.cz>
 <e211e1fd-0923-4ab4-9e01-e9151807cf26@linux.ibm.com>
 <apl1-rm_-Hb_ROE4@kunlun.suse.cz> <arDlfmpHrN8sbP02@kunlun.suse.cz>
 <arFfc2apYaBuNvmC@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <arFfc2apYaBuNvmC@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab16773 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VLc2VSdLAAAA:20
 a=73RBZPNzplm5LS8RO98A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: ZgBODIZuHd8O_TMLh6Jy8rJCAVqbiAjb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1MCBTYWx0ZWRfXz4SuDkv/JfRz
 23surPU664lGvtJOCbI+mU0OfoYySyMYaTIVSBsq5EL1eLbPm8/bk8dEeysr3Y9DySVQRIy35OO
 pml2TaCZQzRj8tQ3yBefvc8e6f3bD386/73yyRuCrC+VuATgJZa3eXzUTBcVUANzX7MLPSzPkpI
 VRE309+DWurk0WDUn2143GINRga30wcw+3JIKwt2AfKooN0OgRIyt2y8nMLuP1ntZh12cIHr/xI
 jm9a88EIPylpi+OyvZxboeZ2hs4TyN/4ue8MZWhMszIhV+vNorsg3dBmhbLxRkDBcLcXOtorep9
 Xgroht+KiGpraLIUDULKuJEJRJ2KBK+mgYMPD+A4yH0BPC8EzvhDpG94V045Z7jk6GbkfyqTrUx
 zPpMQiKxB9j9xmIOJHQ7DVGRWsraxQ9srOJzL1pQKI3MTmY2vaQoqD+YqZ54gDMFqv42RC48XVK
 IQC6Oj6nvHVEvMwVVuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1MCBTYWx0ZWRfX7loOA+X9OFSE
 HS2D1AiKE6iWzgQCq54u8vWYoFRh2oaknEcf9sjjJitLYZgjaRJG07KveYax0BckYBXhs2IswiI
 nTXrNoXu8rkg7HXf1x0vrDndXUh/sOU=
X-Proofpoint-GUID: YtHlhqBN6uFeXpP9rTNxZ6uzIscURXFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210250

Hi Michal,

On 9/21/26 10:16 PM, Michal Suchánek wrote:
> On Mon, Sep 21, 2026 at 10:06:22AM +0200, Michal Suchánek wrote:
>> On Thu, Sep 03, 2026 at 03:28:26PM +0200, Michal Suchánek wrote:
>>> On Thu, Sep 03, 2026 at 06:06:16PM +0530, Harsh Prateek Bora wrote:
>>>> + Amit, Gautam - since they recently came across a similar regression which
>>>> is seen with non KVM workload as well.
>>>> + Venkat - for CI improvement suggestion below.
>>>>
>>>> Hi Michal,
>>>>
>>>> On 03/09/26 5:55 pm, Michal Suchánek wrote:
>>>
>>>>>
>>>>> There is another problem that Linux 7.2.2 often locks up on boot inside
>>>>> the guest, and as a result a different kernel is needed in the guest to
>>>>> reproduce the host crash. This is more recent, linux 6.12 does not have
>>>>> this problem. Will try some different kernel combinations to see if I
>>>>> can narrow this down. For this the repro is merely booting the kernel in
>>>>> the VM, it typically fails early before userspace produces any messages.
>>>
>>> This one regressed between 6.19.12
>>> https://github.com/openSUSE/kernel-source/blob/9f6830f/config/ppc64le/default
>>> and 7.0.12
>>> https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
>>
>> Which is when preempt was enabled.
>>
>> Very likely preexisting problem that was exposed by enabling preemption
>> again.
>>
>> @@ -121,9 +122,7 @@ CONFIG_BPF_LSM=y
>>   
>>   CONFIG_PREEMPT_BUILD=y
>>   CONFIG_ARCH_HAS_PREEMPT_LAZY=y
>> -# CONFIG_PREEMPT_NONE is not set
>> -CONFIG_PREEMPT_VOLUNTARY=y
>> -# CONFIG_PREEMPT is not set
>> +CONFIG_PREEMPT=y
>>   # CONFIG_PREEMPT_LAZY is not set
>>   CONFIG_PREEMPT_COUNT=y
>>   CONFIG_PREEMPTION=y
> 
> Looking more into this the problem is not reproducible with 6.19 with
> full preempt, and can be reproduced with 7.0 with full preempt where
> preemtion is mandatory. It only so happens that 1.19 was last kernel
> where preemption was not mandatory and where this problem also happened
> to not manifest with the Tumbleweed config.
> 

I am bit confused. Is it different problem than the kprobe/bpf issue
which was observed on host?

Is this kvm/guest specific problem you are observing? Is it still seen
even with that kprobe/bpf fix?

> It is not deterministic enough to bisect. It's probably some kind of
> race condition or code generation problem that can surface and go away
> or become too difficult to reproduce with seemingly unrelated changes.
> 

Can you try latest kernel?

There was change recently to move to use
generic transfer to guest mode work. i.e VIRT_XFER_TO_GUEST_WORK.

> Crash happens very early but it's eemu so the memory can be saved
> regardelss. The problem is that the crash tool refuses to load the core
> bacause it detects the core as SMP and vmlinux as non-SMP or the other
> way around.
> 
> Thanks
> 
> Michal
>

