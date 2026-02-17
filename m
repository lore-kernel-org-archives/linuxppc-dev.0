Return-Path: <linuxppc-dev+bounces-16897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EDCE68172
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:34:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFcxW3pdvz2xjP;
	Tue, 17 Feb 2026 22:34:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771328079;
	cv=none; b=EXe/gvuq0WhuEM7wgF8fTRNWUDmfjNujPwPTvSN54ri3weLYra07w2Y4o0SxzPwuOxvl08NaNH/lqcLPGWVZc1GTPscYgCYs81nYWDFvIDpuv1SxmUmUtpue04B/DoB6v7Pi48ntDms/HUB3ounhd2FNwixLI7MPkG1ogQRDG6k4ZN6jm4PwaXcnfJKwkaBXU0UCAwboMSrO8L9rmn1vhnY4o7v/pNbur7BlQenIENj07uNgcSldh8MwEJkFGJkJM+QslZHYK8r9krupzTFueu9v0nA6LUeoWw+hD0C05D7IUvRMZDZpZWeFkBZ7Pksf9DaSsVV1fbuhkgQcdfwTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771328079; c=relaxed/relaxed;
	bh=1otDRsCt4B5p1swe4rH7t1IwcZC+eXMcjoxZiTgW1HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwqQk/JMikRdMMbwPzJT7a4VuBgzo0eT4zqVuGf2lZmu8rJugwOtgv6lCxfBLiETjbeBK9H+sI8XADlNdRfH54UTnSQV/nLMgMDMePuUFBv+TFLuagWrrYvcMaa/3mgFyO0ORnSYp9i634D93/h0tE8cosEjzCXW6INZnXLh5F5je3ZwHz/sPF91sbWGwws58fzl36qryK+8NQVQONUxoJGBkjEf7ETMlx6vYb77Yff6XvYFHoj+HCBZyLKB12ZtvLXSSgQ6QlaTFIW33fmomYYB8aonTOsbAq8ZXOWbiaibt1/99YTyYkwOFWb44Z80RFZPBnShbJ6iMv2WYdr35A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bYYY50+t; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bYYY50+t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFcxV2c3rz2xJF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2026 22:34:37 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9BTWU3669128;
	Tue, 17 Feb 2026 11:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1otDRs
	Ct4B5p1swe4rH7t1IwcZC+eXMcjoxZiTgW1HQ=; b=bYYY50+tv3gHsibSrHKI5J
	Gl9TkwkSpBTCL27qBTHy04bNTdoJW5DIYSGaxfXPO8AqFhp+7WTl5El4qjkCqcqR
	3974NMzIzqcW9rsg7Nwg6iK8Ks4RoEq0iRPO0e+BbxNo+qP1cVG0ulEGA8ZXS9iC
	sMUBwFUkrjLVYy+0eOqnrIlgEmOkcE2AgVU69BfgxzKv2cf/O+CNPdvLXcrAv3lR
	R6ZCSYqk03Uq/x9wZaDcF+yGqKI2SimvAnhYu7P/WhVW0mHQde3jBAC9cjWXSbnB
	UsJ5E5bu9czj3f3LC22rL4GmiA7tpUtm11L4tejH520b2H/g+djKge4umbjQB1lQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjav04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 11:34:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H8cWTW017804;
	Tue, 17 Feb 2026 11:34:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28a736-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 11:34:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HBYWZV31064404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 11:34:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 110D520073;
	Tue, 17 Feb 2026 11:34:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F652004B;
	Tue, 17 Feb 2026 11:34:30 +0000 (GMT)
Received: from [9.111.58.187] (unknown [9.111.58.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 11:34:29 +0000 (GMT)
Message-ID: <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
Date: Tue, 17 Feb 2026 17:04:29 +0530
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
Subject: Re: [Linux PPC] KVM PR and KVM HV do not work if the kernel was
 compiled with PREEMPT
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
References: <b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de>
 <185d7a42-f7b4-44e1-a129-f5989d211c74@linux.ibm.com>
 <40154f6a-39da-959d-e039-5ab9ff62db3c@xenosoft.de>
 <709b864f-9daa-4a48-b3d6-39baedce63b2@linux.ibm.com>
 <dbbb7998-5245-170f-626b-81bc75a32591@xenosoft.de>
 <843b7c60-23f1-47d0-b4e8-2147c3e40c23@linux.ibm.com>
 <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KBeM5nFn1I02PmWUOi6RPQZOJOo390EO
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6994524b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=oxC9TbpiAAAA:20
 a=1dHfNYS583wDdfE0NnsA:9 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5MyBTYWx0ZWRfXzh+NWaStyfZz
 o/WJjaH1HUis8sDCj2G2S42YMAwGE15Ujycq/gzfv5MuYS9O2eZ9utL93GXYh1GkGA3BcBZlt8J
 g8Xnd+lUBDiU1mc3kXhtHLRQ3gE/j+W5Ih6Zg285QQlNjHQmC4BFYOUjLSVJiq//mD0RSjQvGWb
 QIGkvTn9NNNxxTiPx2UYk7cuhjqrnEWlo0ymtS3NzYE2C+zeX/MgFPAG3M/tTr5XTksbwsejElY
 YKiD9Er0UzGEPVTnJbya7disPtsmGSMJR6elNhFAocm9f9Eqe5CyRLfyjfQbps+TVVrBOViP0Sf
 oOJBGg8dvlX0kGI+9ZFZKrLmwEbjG4LH3OYJGGWCb+t6vNiNpsnLUzfEGOaJ0ZkQZLrUWmz8SX/
 aVdrFnl8FQP9fB8xmZraf2q9K7itE5+dNWikBAXHDGHGS6a9YbCrRc1hd9FXUkO5jAOfmuve4Ip
 VUqF2I+WZ4guGOSxmsA==
X-Proofpoint-GUID: Aaf5uLnFVdx7-j9Ev4SG9eJVv45sI25l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170093



On 2/17/26 3:56 PM, Christian Zigotzky wrote:
> On 17/02/26 11:17 Madhavan Srinivasan wrote:
>>
>> On 2/17/26 3:14 PM, Christian Zigotzky wrote:
>>> On 17/02/26 10:03, Shrikanth Hegde wrote:
>>>>
>>>>
>>>> On 2/17/26 2:22 PM, Christian Zigotzky wrote:
>>>>> Hi,
>>>>>
>>>>> Thank you for your patch. I tested the latest git kernel with your 
>>>>> patch today. Unfortunately the system freezes while booting the VM 
>>>>> with KVM HV.
>>>>>
>>>>> Cheers,
>>>>> Christian
>>>>>
>>>>>
>>>> Would it be possible to share the console log or boot log of KVM to the
>>>> point it freezes?
>>>
>>> Unfortunately there aren't any error messages.
>>>
>>> I also tried it with:
>>>
>>> gdb --args qemu-system-ppc64 -M ppce500 -cpu e5500 -m 1024 -kernel 
>>> uImage-7.0-preempt -drive format=raw,file=void-live-powerpc-20230317- 
>>> updated2.img,index=0,if=virtio -netdev user,id=mynet0 -device virtio- 
>>> net,netdev=mynet0 -append "rw root=/dev/vda" -device virtio-gpu-pci - 
>>> device virtio-mouse-pci -device virtio-keyboard-pci -enable-kvm -smp 4
>>>
>>> and with gdb in the guest:
>>>
>>> qemu-system-ppc64 -s -S -M ppce500 -cpu e5500 -m 1024 -kernel 
>>> uImage-7.0-preempt -drive format=raw,file=void-live-powerpc-20230317- 
>>> updated2.img,index=0,if=virtio -netdev user,id=mynet0 -device virtio- 
>>> net,netdev=mynet0 -append "rw root=/dev/vda" -device virtio-gpu-pci - 
>>> device virtio-mouse-pci -device virtio-keyboard-pci -enable-kvm -smp 4
>>>
>>> The system freezed without any error messages.

Anything on host console?

>> can you please share the config.
>> I tried kvm-hv in my power8/power9 and seems to boot fine without any 
>> issues with today's upstream
>> Maddy
> Here are the configs.
> 
> With PREEMPT: https://github.com/chzigotzky/kernels/blob/ 
> d50d259ca63dd2b3b9a9eaabc82e5cc69c8cc9f0/configs/e5500_defconfig
> 
> Without PREEMPT: https://github.com/chzigotzky/kernels/blob/main/ 
> configs/e5500_defconfig
> 
> - Christian

I looked at the code. there was one more place where cond_resched was 
there.

If possible give the below try.
(Note: Didn;t replicate your issue)

---

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7667563fb9ff..bf0ca49c9915 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4825,10 +4825,13 @@ static int kvmppc_run_vcpu(struct kvm_vcpu *vcpu)
  		vc->runner = vcpu;
  		if (n_ceded == vc->n_runnable) {
  			kvmppc_vcore_blocked(vc);
-		} else if (need_resched()) {
+		} else if (need_resched() || spin_needbreak(&vc->lock)) {
  			kvmppc_vcore_preempt(vc);
  			/* Let something else run */
-			cond_resched_lock(&vc->lock);
+			spin_unlock(&vc->lock);
+			schedule();
+			//cond_resched_lock(&vc->lock);
+			spin_lock(&vc->lock);
  			if (vc->vcore_state == VCORE_PREEMPT)
  				kvmppc_vcore_end_preempt(vc);
  		} else {
@@ -4901,7 +4904,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, 
u64 time_limit,
  	}

  	if (need_resched())
-		cond_resched();
+		schedule();

  	kvmppc_update_vpas(vcpu);

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9a89a6d98f97..54963c1d8b58 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -86,7 +86,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
  	while (true) {
  		if (need_resched()) {
  			local_irq_enable();
-			cond_resched();
+			schedule();
  			hard_irq_disable();
  			continue;
  		}


