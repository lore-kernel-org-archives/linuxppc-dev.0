Return-Path: <linuxppc-dev+bounces-26537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02056C624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:04:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbrBd2MTXz2xlY;
	Fri, 04 Sep 2026 19:04:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788512681;
	cv=none; b=K5OAZKpDzogIlFDynj3Q1VxZ/IhARIi1XC65K8h1sv2DCnKD7n6Xck8p+VFk0FLY77fKVDmq6kilVaUkED1Fl0grGR9xzfP8Qoh82l7enwGB3Dj7SL1hK6PEFRbfXTLU0OymyB4zn5CgYXTqcj/6WlCuGtzOXJlrY8a/ytnYg1y1U0OideYQvIGlvy8O1eB+XpB4TiaF/P1r48u0+PzUmU5KIFpM3v7TczdGwRvSne999GttoI8KHt6V11Mj7egmhnowrFlq/xfCwXQMWL8sw2l4j2CP3OW1hfPlcFxHfb7UeDJHho+G2E5kD3S164WN2POSarOOlD++dC+R+waQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788512681; c=relaxed/relaxed;
	bh=Ji+dA8reK18dWrqXA13vJr9OYXzjqjapZ2Kp4Yvz9ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ4B45/e8FXKrAcl374SXnKXutXFwKPDb3XVhX36oEkKbDm8dHCFrjFg4cbS//J2sX7y+cdg+mcb/XeybjnBCEcV0wklvy0eIsZdhXgtEka5t4O1rSlableDaqNjkteI6mlS+NSP8g7uV3TvRt9L5FpW14P5ZRnx6Q8WKtODxzE06a+Zx1v66XKXBNIgDSA6BeE1RmZhYBoRuyEuCcyQu6+8NWQWhD7qnceVbhAWnji4tPctQgRNXuJx0LD1WXaSagx1JT/5r1mS5m7UaADoQzpgW7E1joxj2W/fxqCI0NSZqqkbaZosCMVqtUU9DQ2G2ZhKS6iom00Ud2AtKHXYCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ov3CA/ZQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ov3CA/ZQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrBc4BQxz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 19:04:39 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464ODc3254262;
	Fri, 4 Sep 2026 09:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ji+dA8
	reK18dWrqXA13vJr9OYXzjqjapZ2Kp4Yvz9ZE=; b=ov3CA/ZQUSKmrjxQAvOtBA
	oIe/H3O9PHr7BLXBQ07EOWRUBEd2Y3kCPK/dmAxsMFvXdSXL60ZQrL7FRoCd274k
	UVk5CCyrDyYzbGjsHXW64gYhdZLGbozO6fkReg7cYTV0t9c+JD7OJVhgOrO0l3pH
	c0vJHgxjstVJBuPTOnPpozVNauPI1teWyG5txCDJ67TW2WOMakguhES7MK93WpXY
	gYf7WLAG1jsCqeciWG965PTe72qxColCnzYcBsyGvQpapM2Ext/aqDPM1f2kY2n4
	bp/TNgyt4zSqTvGd/ZKcFJZWZ1hXWXEiOtlK8lvpTRWaEEBpKukDaCUWaM48t/DA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rss9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:04:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6848uIbR004329;
	Fri, 4 Sep 2026 09:04:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceykyjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:04:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68494Qw036635002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:04:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2EF20043;
	Fri,  4 Sep 2026 09:04:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F41F2004E;
	Fri,  4 Sep 2026 09:04:22 +0000 (GMT)
Received: from [9.124.221.192] (unknown [9.124.221.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:04:21 +0000 (GMT)
Message-ID: <4eef1f0b-0c02-4377-b950-43c3b120865a@linux.ibm.com>
Date: Fri, 4 Sep 2026 14:34:21 +0530
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
        harshpb@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>,
        amachhiw@linux.ibm.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
References: <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
 <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
 <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
 <app0zGv9bvtL4nHm@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <app0zGv9bvtL4nHm@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a899f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VLc2VSdLAAAA:20
 a=srzX4-GRdp9WVEN2qvUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfXygWihCe5xecx
 q5rcSF5822gOtYrJHIwUYbwyIrB1jdCurR/Fy+k88v5W5bd/YF4Dq6vj+tDqemlXfko3pIg1IMv
 U0c5Cx9ZLPh3kWCwKIpe23R7p35GlUXt0Q7kRcaxjdyTf/3GI28l8YqxlQ+gDN5IpGug6gD1NeQ
 hyRduQgo99fhBlIzBaoTgJIVzxOpkvwJ/mi8wC0GVdS9ejzTxlsvxHqE4dZzpwHZBwi9r7M0U33
 dzUCOGBqEWuRdp5K96DT3Tfvi0M9W2cJMoM5IpSdAFaEG/ZMYKEmyt/Xex+XOeOQblPR0uemxcG
 xj7RK66LFe1V0dKTOnC/Q6AJ2g2+2rxvLnk3xfpB1rwGPPtPIKn8+dWSguhJqp9cqm4h4DpgbDR
 cLcRnETPy0aBU/HN2/BToZfpfmaoHxPIy7g4cYe/favcLn9cXQzChbzWb1VGtBdD0TRmNnhBWjH
 TQt3jhWODdLP5C9kJcw==
X-Proofpoint-GUID: yQEQ0lpUoMIFs4iNYWk4co6sn3p7Y0aF
X-Proofpoint-ORIG-GUID: ccksbhtpTx-BVBaNymCju4q6T4MoR9rD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX6BeNUnNtI9oG
 1yONhcg5BzbiObicI7U2SAANjw7QO7khSSMLMz+Sy1LXTnI9n6nUuG992g5EP2Wpdp3dGQqGhr5
 gtxgggKr8Zf716EyP6Yvxv4J3zIJMkI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040082



On 9/4/26 1:05 PM, Michal Suchánek wrote:
> On Thu, Sep 03, 2026 at 10:52:59PM +0530, Shrikanth Hegde wrote:
>>
>>>> If possible run against current upstream and share the results.
>>>
>>> https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
>>>
>>> [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
>>> [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
>>> [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
>>> [  472.091624][ T6181] Call Trace:
>>> [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
>>> [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
>>> [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
>>> [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
>>> [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
>>> [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
>>> [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
>>> [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
>>> [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
>>> [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
>>> [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
>>> [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
>>> [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
>>> [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
>>> [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
>>> [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
>>> [  472.091938][ T6181] IRQMASK: 0
>>> [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
>>> [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
>>> [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
>>> [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
>>> [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
>>> [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
>>> [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
>>> [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
>>> [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
>>> [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
>>> [  472.092033][ T6181] ---- interrupt: 3000
>>> [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
>>>
>>> This is the host, cannot run the kernel as guest because it fails to boot most
>>> of the time inside KVM.
>>>
>>>>
>>>>> Nonethless, there are quite a few platforms. Originally no preemption
>>>>> was the only option, and that's the reason why many people run that.
>>>>> It's the conservative, known working option. And that's the reason a lot
>>>>> of platfrom code does not get tested with more aggressive preemtion
>>>>> models, and never gets fixed to work with them.
>>>>>
>>>>
>>>> Full preemption has been there for many years!.
>>>
>>> Possible for years, forced only recently.
>>>
>>>> Lazy is not that aggressive compared to that.
>>>>
>>>>> Simply disabling the no preemtion option does not make the platform code
>>>>> ready.
>>>>>
>>>>
>>>> Let's understand your crash case. Let's see where it is going wrong. I am suspecting
>>>> it is some wrong usage of preemption api rather than arch can't support preemption.
>>>
>>> Very likely some wrong use of the preemption API by the arch code, or no
>>> use where it should have been used. It did not matter so long as people
>>> could run their no preempt configs and ignore the problem.
>>>
>>> Thanks
>>
>>
>> Friendly LLM analysis says preemption is enabled too early and before
>> completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
>>
>> Below is ONLY a speculation and completely UNTESTED.
>> Maybe worth a try.
> 
> The patch is munged by the e-mail client, and it causes immediate
> voluntary preemprion in rcu critical section and hard lockup on starting
> a KVM VM.
> 
> Also it would be sort of bad news if it worked because that would be
> specific to book3s KVM HV and would not help with the KVM HV from the
> original report which likely is not book3s, nor with KVM PR.
> 

Thanks for trying. We will try a local repro and look into it why stack is
getting corrupted.

> Thanks
> 
> Michal


