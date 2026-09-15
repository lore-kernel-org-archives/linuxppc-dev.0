Return-Path: <linuxppc-dev+bounces-27303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3312CC88E73
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:09:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkbn66SPhz2yjw;
	Tue, 15 Sep 2026 19:09:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789463370;
	cv=none; b=Tut7qOp5G5JALPkg7Hg0Y/jayi44bcePNQLilXfzs2tUf99EWLSNU7lencbJgcZtgYM60/Nf/Bbus9IyzRsWEpYRBeG+IvGqlCMPQdcvQ/d156/68LVeC3tRJ7tA60SFOjlPc/9mZ8c3pcoGz+DFp6KCu1UoR+PreHrGlL0rR6V0Ivt1OAEwIMUvNJamecNIRTbDHDc5+LJ6oRGJv7Vlesj4beI5uNKjgKH/uz1NB+yX7b09ZJJAON/rQtzPmz3WVHCHG2IcPn/LfmYXnAnxFkccDXz5O0+a4OCHLFI+Q24V1jKvzUPKBjtsE7KId26jHRmAG/j913JaSC2KjdrXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789463370; c=relaxed/relaxed;
	bh=kBvSQv5/DNDIA5TbequeZ7Wn5CVUy3dbzhohogiR6u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkvYs8qrOukib3focQCrx976yrP8G3rmhD9nnKsnxJZAnOXx/TSGF4CzL8bNBX+3eX1j2tf7ZrWJ+KFNmDV2YRl/+6icieCcgpPhtOA9hMq+4mdLT7HH51wH9HQfmMJL6jOqo8gxvn2ws9RogTx+/lvFfcnLNVLcu5+cDeMDP/0qMQ9ntgolIFf7e1gNvx+I4Eszs9cNZ5nnmuNmYrK643LNsbfc5fQ1u0LtfJ9epAEys/sJd6ohkI5gEfvjYjOrjJBTLvmukcJgNgjGJ1mkLiu0Lg67F/phstPg/LpmZUydfa7to0JjKtX4+8k7i1+fZ9J5EbEZ9rsutTjuwektfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d4sNwDWz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d4sNwDWz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbn52Czwz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 19:09:29 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F71SbD150551;
	Tue, 15 Sep 2026 09:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kBvSQv
	5/DNDIA5TbequeZ7Wn5CVUy3dbzhohogiR6u8=; b=d4sNwDWzGS7k9QCT5ax85M
	YeqiokkY2R5hYmDbEcF+p4gx91+sZKzsL/EsS7Hxl3M8NzKhuxmROjkUBCuXC3ss
	MWKVl09NznruRnrOq0pcpAX85WSwyRJra0+M1+SBXOzjLf6U28LObNkz3rJprnfc
	p3oy9LE7UCBYgLG3qCLnpdkssyv9llAWPhx6sQLc5/yz64USYi1u4Gap7ddE233e
	mtbhzzcICBAiAfsphJJmB16jsFSxVW7tPf3Jp+TWXIB7r1qnVLHXui1qb8qtMcx3
	mUdQ3GltNgWFeUTVCasQ7ETFxAtKcLBvngf1/P1i8TW6qy7t6G29mDYo/Npswp8g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4x7fs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 09:09:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZH1A3523880;
	Tue, 15 Sep 2026 09:09:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxs8nht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 09:09:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68F996Rh30540184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 09:09:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112BA2004E;
	Tue, 15 Sep 2026 09:09:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBB4F2004B;
	Tue, 15 Sep 2026 09:09:00 +0000 (GMT)
Received: from [9.124.211.238] (unknown [9.124.211.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 09:09:00 +0000 (GMT)
Message-ID: <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
Date: Tue, 15 Sep 2026 14:38:59 +0530
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
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Narayana Murty N <nnmlinux@linux.ibm.com>
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
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0wGGBOzAPovux8J8-1z1PDK9FdYwJ48e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEyOSBTYWx0ZWRfX01LVDtw1T/oX
 QdUNgX1PPbhnoq4Hp56VtEuaB9SRX8FYwC8jJ0aOisXZBL8IcpTK/PXlGTq9U2wLHuhgxBhL/Hr
 z2x8uecIFfU5UYqMROcALpwnk/WeD60=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa90b37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VLc2VSdLAAAA:20
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KSb9T-wMAAAA:8 a=NEAV23lmAAAA:8
 a=i6TPNiEBMHgyztv3R2gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=KF4VuIdXkMyp4E_ug72i:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: gS43ZeaRNsdRkUkdORaYmX1sd1A7cvxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEyOSBTYWx0ZWRfX7raeh7GnlJrO
 2woYG/VyY6qnAK9o5x46ncHPLZptuD9tfa8qjD3NBKEKfs1bkhB9PvEc60ADsMT1rPfGjAGJeZL
 2lGk+kN/esAr2TfsxX1FiIz36KxzS162ZZ4xvy2asIDEBlCm7qAPSxVmxyRGDRL4mD1Wi21HRTg
 M14yRsZUq+H1YKcxtJNruwxYQWf9NMfhPGRK8y8GDMl0uTneJVD5n0oMmA5220drmOfNwelXZ9q
 dTiOKCTaTFIZ9n9+zBo1ATF831dTroptyLNDfQuhCw7+vwHdfrJNyqUBFZUka0BqsYhexJa37X4
 thhN7jvoFqkJf+5iyZ0Z1ZYg8ickVxU8XtU+qoIzdcjOrempXhhf5P+3ZqZZTm4ZfKv0AhWMbJk
 yWO94CSlmgndJzEtw2awDSr9/sy1QeRCn/Mx8jxQSABB2jOkOzxF6IafQaer7b67Bm1b6VZfxeC
 ea40iafr9HJHABl+Y1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150129

Hi.

On 9/15/26 1:05 PM, Michal Suchánek wrote:
> On Tue, Sep 15, 2026 at 11:17:23AM +0530, Narayana Murty N wrote:
>>
>>
>> On 14/09/26 4:28 PM, Michal Suchánek wrote:
>>> On Fri, Sep 11, 2026 at 10:39:10PM +0530, Shrikanth Hegde wrote:
>>>> Hi Michal,
>>>>
>>>> On 9/10/26 5:46 PM, Michal Suchánek wrote:
>>>>> On Thu, Sep 10, 2026 at 01:29:08PM +0200, Michal Suchánek wrote:
>>>>>> On Thu, Sep 10, 2026 at 04:11:20PM +0530, Shrikanth Hegde wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/10/26 2:29 PM, Michal Suchánek wrote:
>>>>>>>> On Fri, Sep 04, 2026 at 02:34:21PM +0530, Shrikanth Hegde wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 9/4/26 1:05 PM, Michal Suchánek wrote:
>>>>>>>>>> On Thu, Sep 03, 2026 at 10:52:59PM +0530, Shrikanth Hegde wrote:
>>>>>>>>>>>
>>>>>>>>>>>>> If possible run against current upstream and share the results.
>>>>>>>>>>>>
>>>>>>>>>>>> https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
>>>>>>>>>>>>
>>>>>>>>>>>> [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
>>>>>>>>>>>> [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
>>>>>>>>>>>> [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
>>>>>>>>>>>> [  472.091624][ T6181] Call Trace:
>>>>>>>>>>>> [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
>>>>>>>>>>>> [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
>>>>>>>>>>>> [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
>>>>>>>>>>>> [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
>>>>>>>>>>>> [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
>>>>>>>>>>>> [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
>>>>>>>>>>>> [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
>>>>>>>>>>>> [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
>>>>>>>>>>>> [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
>>>>>>>>>>>> [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
>>>>>>>>>>>> [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
>>>>>>>>>>>> [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
>>>>>>>>>>>> [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
>>>>>>>>>>>> [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
>>>>>>>>>>>> [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
>>>>>>>>>>>> [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
>>>>>>>>>>>> [  472.091938][ T6181] IRQMASK: 0
>>>>>>>>>>>> [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
>>>>>>>>>>>> [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
>>>>>>>>>>>> [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
>>>>>>>>>>>> [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
>>>>>>>>>>>> [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
>>>>>>>>>>>> [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
>>>>>>>>>>>> [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
>>>>>>>>>>>> [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
>>>>>>>>>>>> [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
>>>>>>>>>>>> [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
>>>>>>>>>>>> [  472.092033][ T6181] ---- interrupt: 3000
>>>>>>>>>>>> [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
>>>>>>>>>>>>
>>>>>>>>>>>> This is the host, cannot run the kernel as guest because it fails to boot most
>>>>>>>>>>>> of the time inside KVM.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Nonethless, there are quite a few platforms. Originally no preemption
>>>>>>>>>>>>>> was the only option, and that's the reason why many people run that.
>>>>>>>>>>>>>> It's the conservative, known working option. And that's the reason a lot
>>>>>>>>>>>>>> of platfrom code does not get tested with more aggressive preemtion
>>>>>>>>>>>>>> models, and never gets fixed to work with them.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Full preemption has been there for many years!.
>>>>>>>>>>>>
>>>>>>>>>>>> Possible for years, forced only recently.
>>>>>>>>>>>>
>>>>>>>>>>>>> Lazy is not that aggressive compared to that.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Simply disabling the no preemtion option does not make the platform code
>>>>>>>>>>>>>> ready.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Let's understand your crash case. Let's see where it is going wrong. I am suspecting
>>>>>>>>>>>>> it is some wrong usage of preemption api rather than arch can't support preemption.
>>>>>>>>>>>>
>>>>>>>>>>>> Very likely some wrong use of the preemption API by the arch code, or no
>>>>>>>>>>>> use where it should have been used. It did not matter so long as people
>>>>>>>>>>>> could run their no preempt configs and ignore the problem.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Friendly LLM analysis says preemption is enabled too early and before
>>>>>>>>>>> completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
>>>>>>>>>>>
>>>>>>>>>>> Below is ONLY a speculation and completely UNTESTED.
>>>>>>>>>>> Maybe worth a try.
>>>>>>>>>>
>>>>>>>>>> The patch is munged by the e-mail client, and it causes immediate
>>>>>>>>>> voluntary preemprion in rcu critical section and hard lockup on starting
>>>>>>>>>> a KVM VM.
>>>>>>>>>>
>>>>>>>>>> Also it would be sort of bad news if it worked because that would be
>>>>>>>>>> specific to book3s KVM HV and would not help with the KVM HV from the
>>>>>>>>>> original report which likely is not book3s, nor with KVM PR.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks for trying. We will try a local repro and look into it why stack is
>>>>>>>>> getting corrupted.
>>>>>>>>
>>>>
>>>> As we discussed offlist, samir helped to run a similar test on his machine, and he didn't
>>>> run into issue so far. we will try more.
>>>>
>>>> I am just wondering what different in your case?
>>>> By any chance we are running into below one? Can you check your gcc version?
>>>>
>>>> https://lore.kernel.org/all/CAABZP2z=xu+07-y5fqFLidZz1VpSgrSwXa1mFHPb=b3Ezr3OtA@mail.gmail.com/
>>>>
>>>> Maybe CONFIG_DEBUG_PREEMPT worth a try to if it shows up anything.
>>>
>>> Does not change anything, the kernel crashes all the same.
>>>
>>> Nonetheless, I noticed that a tool that does some BPF tracing is
>>> running, and without it the problem is not reproducible.
>>>
>>> Thanks
>>>
>>> Michal
>> Thanks Michal for the update.
>>
>> Interesting finding! Since the crash is only reproducible when the BPF
>> tracing tool is running, could you share the following details?
>>
>> Which BPF tracing tool are you using (e.g., bpftrace, perf, bcc-based tool,
>> a custom tool)?
> 
> A custom tool, likely a version of this:
> https://build.opensuse.org/package/show/security:sensor/velociraptor
> 
>> What is the specific BPF program or filter being attached —
>> particularly which kernel function(s) or tracepoints it hooks into (e.g., is
>> it attaching a kprobe/uprobe/tracepoint anywhere inside
>> kvmhv_run_single_vcpu or related KVM HV paths)?
>> What is the BPF program type — kprobe, tracepoint, perf_event, fentry/fexit,
>> etc.?
> 
> It would be likely these programs:
> https://github.com/SUSE/linux-security-sensor/tree/sensor-base-0.76.7/vql/linux/bpf
> 
> Thanks
> 
> Michal

It seems easy to re-create.
The key is running bcc/bpf program in parallel to kernel build.

For example, these two in parallal, leads to stack corruption panic.
Stacktrace does differ sometimes.

./funccount  rcu* -d 100
make -j 32

Boom. Will try to debug this further.

[ 3979.381003][    T0] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: prb_reserve+0x498/0x4a0
[ 3979.385530][  C114] pstore: backend (nvram) writing error (-1)
[ 3980.385590][  C114] Oops: System Reset, sig: 6 [#1]
[ 3980.385605][  C114] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA pSeries
[ 3980.385611][  C114] Modules linked in: bonding pseries_rng rng_core vmx_crypto fuse ibmvfc ibmveth dm_mirror dm_region_hash dm_log autofs4
[ 3980.385630][  C114] CPU: 114 UID: 0 PID: 0 Comm: swapper/114 Not tainted 7.3.0-rc1-00026-gd3d9a20b4eb9 #23 PREEMPT(full)
[ 3980.385634][  C114] Hardware name: IBM,9043-MRU Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (RF1120_183) hv:phyp pSeries
[ 3980.385636][  C114] NIP:  c0000000001ae714 LR: c000000001552b08 CTR: 0000000000000000
[ 3980.385638][  C114] REGS: c0000007ffc2fd60 TRAP: 0100   Not tainted  (7.3.0-rc1-00026-gd3d9a20b4eb9)
[ 3980.385641][  C114] MSR:  800000000298b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 22000202  XER: 20040006
[ 3980.385649][  C114] CFAR: 000000000000011c IRQMASK: 3
[ 3980.385649][  C114] GPR00: 0000000000000000 c00000040030fd50 c000000001be8100 0000000000000000
[ 3980.385649][  C114] GPR04: 0000000000000001 000000000000003a 0000000000000000 0000010000000000
[ 3980.385649][  C114] GPR08: ffffffffffffffbf 0000000000000000 ffffffffffffffff 0000000000000000
[ 3980.385649][  C114] GPR12: 0000000000000000 c0000007fffdeb00 0000000000000000 000000002ef01f40
[ 3980.385649][  C114] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[ 3980.385649][  C114] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
[ 3980.385649][  C114] GPR24: 0000000000000001 0000000000000000 0000039e85974a0e c0000000029ab5a8
[ 3980.385649][  C114] GPR28: c0000007fe8f9a40 0000000000000001 c0000000022020a8 c0000000022020b0
[ 3980.385675][  C114] NIP [c0000000001ae714] plpar_hcall_norets_notrace+0x18/0x2c
[ 3980.385684][  C114] LR [c000000001552b08] check_and_cede_processor+0x48/0x60
[ 3980.385692][  C114] Call Trace:
[ 3980.385693][  C114] [c00000040030fd50] [0000000042000202] 0x42000202 (unreliable)
[ 3980.385703][  C114] [c00000040030fdb0] [c000000001552d30] shared_cede_loop+0x70/0x170
[ 3980.385708][  C114] [c00000040030fdf0] [c000000001552170] cpuidle_enter_state+0x300/0x748
[ 3980.385712][  C114] [c00000040030fe90] [c0000000011394f0] cpuidle_enter+0x50/0x80
[ 3980.385718][  C114] [c00000040030fed0] [c0000000002a5a78] call_cpuidle+0x48/0x90
[ 3980.385722][  C114] [c00000040030fef0] [c0000000002acb0c] do_idle+0x2cc/0x470
[ 3980.385725][  C114] [c00000040030ff60] [c0000000002acf7c] cpu_startup_entry+0x4c/0x50
[ 3980.385729][  C114] [c00000040030ff90] [c00000000005be80] start_secondary+0x290/0x2a0
[ 3980.385733][  C114] [c00000040030ffe0] [c00000000000e258] start_secondary_prolog+0x10/0x14
[ 3980.385737][  C114] Code: 3d220063 39295780 7c634a78 7c630074 7863d182 4e800020 3c4c01a4 38429a04 7c421378 7c000026 90010008 44000022 <38800000> 988d0931 80010008 7c0ff120


