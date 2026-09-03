Return-Path: <linuxppc-dev+bounces-26487-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8FDC624D7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbHVT6Nk5z2y2Q;
	Thu, 03 Sep 2026 21:31:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788435089;
	cv=none; b=X2YEsrc/EuJX6790z6HT6yBeyS6kWDB3WKZLFHFcgyVBFoIFloP9VFoIljjhT2QxhmcJJ0DPW8UxReKLhhnLlxWKHtfVOy5wYqUhqrbpck4JK3Mgc5BHRdRuh82lUG39rL3kqs+iySqhbUIqj//PMMe9iHZKle2iA1s9WmrPI/mteFG7UD6TvkJKHsbogbg/4+laNmFrleIflF1f017dSVvL9henC158NJuptO1LntCRxeaslNcM4GhF9CpLDPjgf3PSRrkAmRqCPmyKiY2sRjqTy6fMMgDQ+op69KliEkF2Duft6puQpAyTjHK2G70wHzt5Cx1D415YTntb/+qQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788435089; c=relaxed/relaxed;
	bh=ULh1E4SqKE7b0dPR0j+ktXiT4Nr18zmwqZxMCaOqxFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVg1hRZHufclC5vq+zTGjFnidueBcufrMyYsvOvQlSPXlMCyX/vEkRiXILhB+TSu99rCKKjaE3SL5QdcVZLpHv3Iy9rTwx0lo5yulNzEWaYvWH+hyoGMhTa38rBmQhQ5UyGp/8uJJXQS5G9hragz2zSM4WONds4EiAchKNMcU8w4yGh8OFq2ZgqkT2abKPR4shKzH2+RxcAN4E0fciqJqSc8/mnGrWgFy60WAlFrasFf/sJNib9bN+12ST1b/zIDCZ4j+C8Tyu7PRHkC+ODrFO+2dU++bNlmUgbxP9zb/ZIjn2aSv4r2ZC3BU3OqrGX00F5PukczW1dPEuYGw/jN4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oWZSxo4+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oWZSxo4+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbHVT0qjlz2y2M
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 21:31:28 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVxlW2737684;
	Thu, 3 Sep 2026 11:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ULh1E4
	SqKE7b0dPR0j+ktXiT4Nr18zmwqZxMCaOqxFQ=; b=oWZSxo4+BICnqooqKkQpTV
	a7YI4g/id4woyvFZScdcqf2Sv8v8DHnhrPG3eoTXQAaoNAWhj6khbYTTf1Z65B6v
	FhSgvmKODDMEtw44C8ClywubDFstGvtPct/NG7uKNuJxquWSaQhvFrstQeC1nwSR
	NmfqPkXdYtiG7h0HpRoh3vMw+nct4IGDIS1SUV87agu9aY/LaPAqRewWwjpZWZK+
	UiLc8G+6pY3TGW2y38XHj6ocZgNza9CtnA+wSDZW3XQobmp77q5JH4/vyDIfWUWC
	rRN6eV2eWeNYjhHr7nvU0fkF9aAJMLXYGCLwpkf5R5u96hW6pRI9IYmlj5Io6cjA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq554kg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 11:31:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683BQQYP002803;
	Thu, 3 Sep 2026 11:31:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkfe92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 11:31:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683BVGfB39190958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 11:31:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45A822004B;
	Thu,  3 Sep 2026 11:31:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF982004E;
	Thu,  3 Sep 2026 11:31:13 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 11:31:13 +0000 (GMT)
Message-ID: <d98e38cb-74d7-48b9-93f3-7c20ff910675@linux.ibm.com>
Date: Thu, 3 Sep 2026 17:01:13 +0530
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
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
References: <dbbb7998-5245-170f-626b-81bc75a32591@xenosoft.de>
 <843b7c60-23f1-47d0-b4e8-2147c3e40c23@linux.ibm.com>
 <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
 <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
 <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aplZNFMJUkfs-BFs@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5NiBTYWx0ZWRfX2IHb9eSeqq3g
 4GrKKuwjeGx1jZMq2WqozHcnq0oQh7i8zqJmAOrz14OYjHRzM8JMpF4ILBIf2L0lJxb+E5Vlo/+
 NNlvhNai7r8P0HAaP77aN2umNU2CaWz4InMBk2l0440AAFFqtMgKnQ4N535zv7GTsi5lrJ8YzLa
 kKTUSVpzALKskvD6+Z+ml7vU/ZE/TwR8EjvL8pnnsk8Tv/Qe077mE1mxpRxV6F0kmre0MzvvTpp
 d9AlSHfnK+RjO/LOh26uhq2+95kpQgUQ4oCHjBzIBVzT/Kp3fE8kPHY3hgzi1SAcwkSKTUo+aBk
 lbniX9KpxRu/aLHjZaucLV2Gc8J5dTH6PWc+GW+wjI0MIb8Wgofq7DEiaOMaLuMabz+aalQeLyn
 +pUuexJGZC0R102KOEo2Wi/KMjPJGOXgQq4W9yqffmhkuzPk6oe8izxIehIeO9OA41iwjMIJ4u+
 iE30M17kF6eFO1BE7Nw==
X-Proofpoint-ORIG-GUID: c66nIqAuh5CzoEOA_kAAP4cn2auF11uJ
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a995a88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VLc2VSdLAAAA:20
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=O8UgfSBJEMjtcfn6gRoA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: fW51GbS-eqmq804Pdq2NPMyOJIw69XCw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5NiBTYWx0ZWRfXyBjE9jw0kBM6
 AUFp5WBY6BBqf2qEZbNmFe5+gWcyCCVhrJTv+vs5QZsas5QwPmDOFBjxAklfBziXqIkgntVCMW2
 xxkpJbO0EBiFhqI+GU0IAx30HNvuSaw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030096

Hi Michal.

>> Is it the same issue that you said the bug which was discussed internally?
>> i.e around kvmhv_run_single_vcpu ? or is it different one?
> 
> Right, the very same
> 

Thanks.

>>
>>> This is not the latest kernel so it might have been fixed in the
>>> meantime for the platform in question. Will need to check that.
>>>
>>
>> If possible run against current upstream and share the results.
> 
> https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
> 
> [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
> [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
> [  472.091624][ T6181] Call Trace:
> [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
> [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
> [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
> [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
> [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
> [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
> [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
> [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
> [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
> [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
> [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
> [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
> [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
> [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
> [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
> [  472.091938][ T6181] IRQMASK: 0
> [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
> [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
> [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
> [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
> [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
> [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
> [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
> [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
> [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
> [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
> [  472.092033][ T6181] ---- interrupt: 3000
> [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
> 
> This is the host, cannot run the kernel as guest because it fails to boot most
> of the time inside KVM.
> 

Will look into. btw the patch shared i.e below patch fixes the boot hanf issue?

https://lore.kernel.org/all/1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com/

>>
>>> Nonethless, there are quite a few platforms. Originally no preemption
>>> was the only option, and that's the reason why many people run that.
>>> It's the conservative, known working option. And that's the reason a lot
>>> of platfrom code does not get tested with more aggressive preemtion
>>> models, and never gets fixed to work with them.
>>>
>>
>> Full preemption has been there for many years!.
> 
> Possible for years, forced only recently.
> 
>> Lazy is not that aggressive compared to that.
>>
>>> Simply disabling the no preemtion option does not make the platform code
>>> ready.
>>>
>>
>> Let's understand your crash case. Let's see where it is going wrong. I am suspecting
>> it is some wrong usage of preemption api rather than arch can't support preemption.
> 
> Very likely some wrong use of the preemption API by the arch code, or no
> use where it should have been used. It did not matter so long as people
> could run their no preempt configs and ignore the problem.
> 
> Thanks
> 
> Michal


