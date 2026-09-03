Return-Path: <linuxppc-dev+bounces-26489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19751C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 12:04:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbJDy2HJMz2y2Q;
	Thu, 03 Sep 2026 22:04:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788437090;
	cv=none; b=X1QMNIQc5IpuRX/dnBuVH/xiGCKk4O992keNswbUyge09eWXabvC6xNDV5bPuhOW0xfXyyEym/qZ14KNHr251LOgsp0wgpvMESE3wxF0EIxBby/SiMT0aki5JGfa+i8AHgwrdh9F82q1T4zqJmwnNCxFhRW9JDjZY4IEhWKLXHc27Iq1ubIdonBi2ZY3vVVsgSCGjKNdApl1G8WuOXRsVrf+6PKyaiNXp3LVVasERiAoWtMoYhunPnx6dViaP36pxWV7TU9ObigJSld45OywmVK0+lKz0qA99YAN5wsZc/9y1UfoRBXOE4BCSsE6TJgQvQEy6gE9ep7MVJKcxtzwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788437090; c=relaxed/relaxed;
	bh=lbc/cVsXyVU0Fo+5hdZjNnsqlg1mhw+qDVeFadlC8rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLpGMn/lPI/60nnDXYGj0BicJ37X9vhsxZd5w2uzPE2oX0NRtdrCBsosSx87ZmWHEgli2eLl0t32j8oOUZVWT/kvNGudtnvXqvFxllX2r7zIufRRolIPzvhLbTA3rP2J/X8qOHNaKDrcxhOCWUEXbN57bVB7CRQn8k/9BLgK6c9EifpKYIXhmzeYUaIdGjTlpX98LIc7ohjxYQ9dYAqlsPrc9r0GoVvzcNQxEdLsPa4FkDZugdRPABkSX7vhyorjD54Cf6zUb0JpFqh1Az5Lvs5xaSV5F58BR0AHINGGw2BfpjNQJnIcd1UBVqkj+DS+1SzmPnTqhK3SAE0qpgbpig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cPlu/iFg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cPlu/iFg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbJDx2pNKz2xyl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 22:04:49 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVqaH2617945;
	Thu, 3 Sep 2026 12:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lbc/cV
	sXyVU0Fo+5hdZjNnsqlg1mhw+qDVeFadlC8rI=; b=cPlu/iFgudxvVyGdqA6Pc7
	4ttSWEabR5ORfcBcubi9rtKoav+Kh+0YUzYuOttjCxVqG384jEeJvJqBJSEXUa3o
	R5KTWvj91jrDYeL0nHzf7fB6ik8eHiA4uNITH+1t84CiQL0UOHomYM9Px/AM8FwS
	STB5JJO1gZWAwc24NGuqAGOhrsZo23ICMJz2+EzGNSdN9ifo3TaYXMpuNYY4O9C1
	pd4H9kxjZCPXvwFINZz2Ld2cXvNEJ6ikfxoVj2l4sg6773S8yudC2PQ4QLFdGH+1
	GOH3T7i9SakjsOSe4CU/4xTVxqwnbtpDyWRkCEuCl6fuL7qUhTP7jmzyQSfylQ7Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj4edc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 12:04:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683BuML3016362;
	Thu, 3 Sep 2026 12:04:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hqf8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 12:04:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683C4ZqQ43319756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 12:04:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4081B2004E;
	Thu,  3 Sep 2026 12:04:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C9E20040;
	Thu,  3 Sep 2026 12:04:32 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 12:04:32 +0000 (GMT)
Message-ID: <1d83264f-8eda-4321-9200-f12897e38cda@linux.ibm.com>
Date: Thu, 3 Sep 2026 17:34:31 +0530
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
        harshpb@linux.ibm.com
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
 <d98e38cb-74d7-48b9-93f3-7c20ff910675@linux.ibm.com>
 <aplclgAsq1d6f5U-@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aplclgAsq1d6f5U-@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6BCL6OaMO1bEp9f5PtUWT0HudcAXqleo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfXwISdx5n0al4v
 906s9cGAp6AVWrTJ2kQOgi9/Gs0VzXrchIgOUYtMaZnzvrR0MKSY5KwTjj8Y19SKZaxpSsufArp
 9teg9Z8Gm9Xt0AqvrVvfmxesrAPNpzP+tSFFFeTVJZXBQRGWn0fPlf4WD/ErR5LzYyMV0GE3nmA
 Cg+NPGmsGwVZwOsmCZQ+i30WGeYwYKTltOGqZ6ncz6VFngtf0ZoUEY1LnmQP3HgfSfyz1Nxf7Mj
 m/dijtkCOMOiIVy3/Q2P6YWkkNj314TwJIIr1dkAZFctUxy0aXH6MS7YLVb58/oEqOoV6jF3tYR
 G5YZEmTv+neOBZMBAWg1i4d4FGwxrJ98sDIvUtILwPMGWtOB8IMf71xe9mx5jc7wowwQYTx1eN9
 e7BP/7hlu1RBzm3q6IhGNvl7l1/CDZ8dt1FwOn3UAcsyMmE/UIrzSRHAzROx3eqqKn/EoCSgBoY
 sp7+S9UzckgharrliOw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a996258 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VLc2VSdLAAAA:20
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=YFkY5LX_4jaAUoLubzEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNCBTYWx0ZWRfX+EScHkuSv9CY
 UjyMCnRuBdDMSSXfPB8dP6h+7xVjRXo9vWVvJf819NWugKpsu9wk0w1TkGpe/7cVAYX2wNvcBZC
 aBVk5VO2z3witZBeODf8moh61XVFcvk=
X-Proofpoint-ORIG-GUID: f5EUIsnjiv88IIuKaZVvkClkzGxmPNUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030104

Hi Michal.

On 9/3/26 5:10 PM, Michal Suchánek wrote:
> On Thu, Sep 03, 2026 at 05:01:13PM +0530, Shrikanth Hegde wrote:
> 
>>
>>>>
>>>>> This is not the latest kernel so it might have been fixed in the
>>>>> meantime for the platform in question. Will need to check that.
>>>>>
>>>>
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
>>
>> Will look into. btw the patch shared i.e below patch fixes the boot hanf issue?
>>
>> https://lore.kernel.org/all/1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com/
> 

I see code has changed a bit. So this patch is not correct anymore.
Sorry, i should have checked.

> I would not bet on that. It looks like host side patch, and the problem
> is with booting 7.2.2 as guest. Some 6.12 frankenkernel can be booted on
> the same host, and used to produce the crash above by running a kernel
> build inside the guest.
> 

I didn't get what you are saying. Could you see if it regression only in 7.2?
Does 7.1 works fine? If it is regression could you see if it is bisectable?
Also, could you share the repro steps?

Let me add harsh. He would know more on this.

> Thanks
> 
> Michal


