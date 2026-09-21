Return-Path: <linuxppc-dev+bounces-27802-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9C2C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 05:11:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpBD516kBz2y71;
	Mon, 21 Sep 2026 15:11:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789967509;
	cv=none; b=lMN8wjdXqGfxRG9kt9SqrRiEIAlkvNKJDI28Hv4r2ULpcUNvG4dew4N3gVR5TdA1iJzgroTZpCj2+C1zod5LH/YcVNjvGV1ljt3nhGLU4VlYDxlYDQJouBfsNe3vWciTzsb3hElYzLpl1WnysSXdyRJgFMPz3u8USKXGKfiA1FZK/xm78RZbl5g0WOG0gjjWbA8QSxAJ1/vt06FnBLntHdIYtZ2OpXKoecx5X6ssC6M7DA52PWfiaLfs3GIv8YHOxTehChGsyh9rPvxksp/KiWv2DbsHmwUpJhWyJJiFkWrcPSeA1QkZmwWtg9zDUkSQT+O7SHQgJAuVMzNGe5Z9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789967509; c=relaxed/relaxed;
	bh=fwP7MgESMkF7TBS6aiLHUWHjtu96CKBrXSZYhObSh1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB3EJAqiolHZLmwimFOrTqCVPQvYzz9+ddEt7CKjx93lJh0Dtgz5hDC0LJsD6qxbwS8nFCDxyZ/VadZvz8fP4DdfEwZNoKiT6ARzOuZa7edYDeSAfOXdcTktpkf8puZd6NcYFvoaZS5mD92H4bZCfUqbQCC5Qj5WRiFTgVHLul1tw9PtN5jjdeMMVi/NzQxS4tDhDU4hSHeqH0N3lrn2KhYElhzuY0Y1WyMkGNKtvUBj47B262i8O/6AiNW70jXauX3foB3U5IshmDB3ij/TMu4vafTo6IUGZRN6uuJFRPvorh7noeCGImTlLXYRkiXNp3PY3BLY/9jFanlugZ/YBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=taBHsjQB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=taBHsjQB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpBD41mwlz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 15:11:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3bU5j3308982;
	Mon, 21 Sep 2026 05:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fwP7Mg
	ESMkF7TBS6aiLHUWHjtu96CKBrXSZYhObSh1g=; b=taBHsjQBjzDdBCeyyHSTB2
	PHjKPmwfPItuKyvPeEfII8bTjnFvAsYBrhL98Kjy7sx2HIxJdEHXkjWN3x/lTGU8
	VGgo0e8ZX2mjwIX56Cjp3aFWDO1JexUlz0iLhDFouGl5hNsEU7OHyuQbItyUinzl
	BZOgZulco/TLyWlChRB1t8Hcxu9VgnohVrye0CEICNffqdY4ZGv7IM6J7sZdJwiN
	2oM+pUvTgZ6AcCmAveJsxe3ukk5EFjuXk/oiZ0+ueg4v+SK7xJV2gmMWPy+6gF8Z
	4ZCYljyutHeLDnXncgNnMC8OIoJMx+JpbsiXe+5/O36jgE1L8YKXuxiN/2YPG/kA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq6nxd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 05:11:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3XWBm603394;
	Mon, 21 Sep 2026 05:11:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjkum7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 05:11:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L5BCkk46334288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 05:11:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 065FF20040;
	Mon, 21 Sep 2026 05:11:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF7820043;
	Mon, 21 Sep 2026 05:11:07 +0000 (GMT)
Received: from [9.124.209.148] (unknown [9.124.209.148])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 05:11:07 +0000 (GMT)
Message-ID: <b887c351-f7da-4e24-8cee-30a5a2dbfadb@linux.ibm.com>
Date: Mon, 21 Sep 2026 10:42:10 +0530
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
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
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
References: <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
 <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
 <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
 <7e06fb84-ca2e-dbb4-47bd-e95ee11113c9@xenosoft.de>
 <aqzj9xsPRsGgCI5M@kunlun.suse.cz>
 <79f9d4e3-ce55-d238-e4a9-b11e9ce27c5f@xenosoft.de>
 <33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0bc75 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=c3OQchQmIXNlVOc-g8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA3MSBTYWx0ZWRfX0fui0lRP8wZE
 lX6oyJlf/Q04o+p3iCUd/JOxnZBNPitRRmn0pncVyiuezFWCdExten9e1WN1PhweR4i4rReqZom
 cCGFMdYkw4WA5wF3i06OC/JrVbpO/YYZfjCuq6T0QvuLlW2NR+bB5Lwaygr1nD0MMGqYUIvKxg2
 VCIVcEUvp2pAS0mkK/Anj5W2IDcNoSCxsTQf/PZWUrdZLMz2NnB3qcDwIgxpvm4VHRkAVxmQy+k
 MXY7rXw14Z+TCaje9TJ/8NuXMQZGPw/VX9Genm6cMkmNrBjG6lIp/rCGKXwB90rkaRaCCQJur2t
 mNenzLjR+af/itgb7rold2CL3QgXSgafZk+E+WnGo0FzmTfPlKf4SFbG2eqFeTNx4YPCciXK1Su
 +/P1vAPUzuLz5KR8dlXnfo9zKC34hS+LrFVo9kl5/Amuhcg8PmZ1pNeIcS490CG50yM0/M4gx/8
 9BNFOTXxup/UV+SKQLg==
X-Proofpoint-ORIG-GUID: iDfdy2aqgn442U2Kx6zyvnoF2i5Q2YL7
X-Proofpoint-GUID: dZExppMaOjH1A6-mAmFv4AfcOwBmWjFu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA3MSBTYWx0ZWRfX7lwqXTqr3/iN
 IUHJTveXPn83iDXfXoa272PWee5oGr3FoRVa+KPaWNKJMunkUt6IZVhCuAE3ah1qJQx0jUtcqkD
 FEtbfMYfKfKVDzBDRN41i4xVklr842M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210071

Hi Christian.

On 9/20/26 6:34 PM, Christian Zigotzky wrote:
> On 09/20/2026 01:49 PM, Christian Zigotzky wrote:
>> On 09/18/2026 09:10 AM, Michal Suchánek wrote:
>>> On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
>>>> On 17/09/26 16:15, Shrikanth Hegde wrote:
>>>>> Hi Michal,
>>>>>
>>>>>>> Give it a try.
>>>>>>>
>>>>>>> I am suspecting both lockup, stack corruptions are secondary
>>>>>>> symptoms here.
>>>>>>> While recreate, I have different type of traces.
>>>>>> Yes, it does work for the crash I see.
>>>>> Thanks. Give me sometime to see further on that. Didn't get any time
>>>>> today.
>>>>>
>>>>>> However, we hijacked the report
>>>>>> of KVM locking up on FSL Cyrus+, and that is likely a different problem
>>>>>> still not addressed.
>>>>>>
>>>>> Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is
>>>>> stuck.
>>>>>
>>>>> I would need help from FSL Cyrus+ to get some logs or is there a way we
>>>>> can spin of
>>>>> a QEMU guest of it? We should have the log to start somewhere.
>>>>>
>>>>>
>>>> It's difficult to get a log because it freezes and can't write any error
>>>> messages to the log files. This bug is very old. We had this issue some
>>>> years ago but we was able to disable PREEMPT because we don't need it.
>>> I would expect serial console and sysrq could give something, depending
>>> on how much of the kernel is frozen.
>>>
>>> Thanks
>>>
>>> Michal
>> Here is a serial log: https://github.com/user-attachments/files/32433586/e5500_preempt_putty.log
>>

Thanks Michal for helping to get the traces.

> Another serial log with pcie_ports=compat: https://github.com/user-attachments/files/32434487/e5500_preempt_pcie_ports_compat_putty.log
> 

I see it is mostly busy with printing
WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884

The path seems to be same also.

[c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
[c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
[c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c


Does below help to boot or make it stable?
---
  arch/powerpc/kvm/booke.c | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..d4be7a306bfc 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
  		if (s <= 0)
  			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
  		else {
-			/* interrupts now hard-disabled */
+			/*
+			 * interrupts now hard-disabled. i.e EE=0
+			 * But irqs_disabled relies on PACA entries
+			 * and fixup below enables it.
+			 * So irqs_disabled == false
+			 */
  			kvmppc_fix_ee_before_entry();
+			preempt_disable();
  			kvmppc_load_guest_fp(vcpu);
  			kvmppc_load_guest_altivec(vcpu);
+			preempt_enable_no_resched();
  		}
  	}
  


