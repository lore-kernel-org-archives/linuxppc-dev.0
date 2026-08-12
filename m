Return-Path: <linuxppc-dev+bounces-25754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F79C5B567
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:16:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKcDT27SZz3br3;
	Wed, 12 Aug 2026 15:16:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786511817;
	cv=none; b=fzctA4e+NQoTaxmo0F8YCACd8fNtbZbHJfvJmXlTqpmYBQNPv0p0C4o+bDXrJIwIntbqp3bvU672uuyzILMohjAkEEfYFu1yuNgPM4iaQfN4oKieRjJ4x/6TfSrr4RVuIzOCZ/B5vaFslSZDVD9uLVON32sdNp36fKs/JVQEsb18gr0RdbkCR/dj4Gyd+YmQrK2BhjnMfQ4GWTZ1oP3L4tKmCmo0NZd6yrTU8+JvJb2TQ+QAOKUE6ceq1vZe3Hs32wc+oKb9eV42aWyG9W1tS0xIe0zl5nnzOf8kJLlpX+KW6xe7+b+mTqUsrQOW8OzPOs+j3TqnsnOAahLl/LB8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786511817; c=relaxed/relaxed;
	bh=5F8eE5cvnV6koOgwnr2W3bThcC7nAy6YoMWCnXhwMs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ww+GzcSMdALRwjZSoLsXipjT2ScHrHxQtM57Cn2Kd6KTNl/DzYuasv8f6BVFZL2mKFinxP7+1y0kR35cpzdY6r2C3oUAOxZGJRlexoMtPVxfW4YNDrNfUg9S78YRkVI5snr3vHcMV8KSPoKawzr8SeUBQ1YfD5riLLJN3agdFa44Nxw9afT9Dwxq4rTZetGsY0b2DoOTMM1LJUBILgsSQwaYkHRHFdGkn778Ym96eJNY4//cFs8ZSu5NgL2nPJFBotAGuwmwBSPklZ+TB2B+NDhuqtL47BIpQhXchIPtP+VfqWB4Ji48iX8uzcW/8arpZeMhY7HERn+LPkjIUTJmjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bBuN3FiU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bBuN3FiU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKcDR4bn8z303K
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 15:16:55 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31tRa2285545;
	Wed, 12 Aug 2026 05:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5F8eE5
	cvnV6koOgwnr2W3bThcC7nAy6YoMWCnXhwMs0=; b=bBuN3FiUGxXkfBEOltK5wM
	T5R/DBbt9J5Jzv/2Ho3W+igfS+dwKRvD5tAlhdDOH/Aei8JeWoFI+FMgBaUk10de
	hvq+3WHcPylnle8+UcacB/IpJzyg80SZ1NlAwYHsgCRvS/xUyiMZDBm0UQW3UFjr
	672DfJRsuNyMXxEBDRd0gXHkr2xS2eu8Gn2xhew3BsJIzYAYFQ1BoSF9ZKD54his
	+Czl2zxuMPphYd1j7LJJ5U8HU8lLEMwF54UVQX6ruMhWCO9HhzElKVvkFUg+rX0b
	g/yX2QjWlUdfuEFZw2HIqrv8ZmBxw01yLqD37iIZZ6WNLyuW2mKR778C6PcPpJcw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9rxyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:16:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5BJuj005628;
	Wed, 12 Aug 2026 05:16:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy4dej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:16:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5Gb485309100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:16:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F39C58065;
	Wed, 12 Aug 2026 05:16:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F264F58058;
	Wed, 12 Aug 2026 05:16:34 +0000 (GMT)
Received: from [9.61.253.67] (unknown [9.61.253.67])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:16:34 +0000 (GMT)
Message-ID: <2f7e6c34-7258-4b20-a38e-cedebccb835f@linux.ibm.com>
Date: Wed, 12 Aug 2026 10:46:33 +0530
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
Subject: Re: [REGRESSION] Power9 pseries boot hang in v7.2-rc6, narrowed to
 PowerPC GENERIC_ENTRY conversion window
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
 <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
 <6d1b5f38-f4e4-46ca-88b4-7c18dd6c6280@linux.ibm.com>
 <anq72IebDSu-wWbb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <ansZjSJMWMV8DDF-@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <ansZjSJMWMV8DDF-@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAzNyBTYWx0ZWRfX1GPQBrpsCBma
 5MOXAtEuSlGl0MLqWKrTJi1Pnt0+HEj1OA8XqOyQ7Kb9gzLRQ/MzP5yGnfiH6FNnfj50ixvW78O
 N8ZUwuJ4F4O9XRkoOaieCOOwaZFdH7/LK83/fqWwaKH1MOvlEO2X6QZWlP8PpQpGqMfChpSfhvm
 e56mzwkMA1wQ1fuiWRb5vXKrJYfw1OUBlhcfEQrsNYIPT1WO7HhECJPR3kYvhAbrXHFzvrXdxpZ
 oIxIbFjjd/vjv2Bo1fxm5plcRLy5VTV73YcgJeKaGg5CuoLIWv4El2Kd0qwVtGrraRnYhWnz88j
 XrDDPKwBu31oWYZ7iXokZIHUzhd02QFv8shwFBkt61rViKWPR400voi4sB9kraRLLRWbSicMSae
 pWTOtwgEdcJ2ah2H88BaLo9dBrca2AAkP4z4Wzr4iaACxHKs9SaK0JPBvfuz6LvJCDAHko+5bFj
 ynYadvdoyFwcS+lNGzQ==
X-Proofpoint-ORIG-GUID: AYx6LIiqA9DDYZ7iy00YUv9OKsw2RJMm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAzNyBTYWx0ZWRfX9w80p0+AgM+C
 l3lPjX2VImEUDvmC/WnoIfK+LjVCMBQxsB/qBcw0TWbD13Mbyre5FO1ZEYbdd57m9FxzvzyF8Wf
 Kt13tw0itRuozudXEdkcUSPVCbDiCKw=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c01b8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=qQ8GBYjWSL8R78bCLWMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: F9MGsweoeqnMYcmyDqf9kC6E2zzirsPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120037

Hello Mukesh,


On 11/08/26 6:16 pm, Mukesh Kumar Chaurasiya wrote:
> On Tue, Aug 11, 2026 at 11:37:45AM +0530, Mukesh Kumar Chaurasiya wrote:
>> On Mon, Aug 10, 2026 at 05:19:27PM +0530, Venkat Rao Bagalkote wrote:
>>> Hi Shrikanth,
>>>
>>>
>>> On 04/08/26 8:23 pm, Shrikanth Hegde wrote:
>>>> Hi Venkat.
>>>>
>>>> On 8/4/26 2:04 PM, Venkat Rao Bagalkote wrote:
>>>>> Hi,
>>>>>
>>>>> I'm seeing a boot regression on a Power9 pseries LPAR. The system
>>>>> hangs very early during boot after:
>>>>>
>>>>> Quiescing Open Firmware ...
>>>>> Booting Linux via __start() ...
>>>>>
>>>> That is strange. not sure where to look at without any logs.
>>>> Is it a specific config that fails or this specific LPAR that fails?
>>>>
>> Is this a specific lpar or all power9 pseries are exhibiting same
>> behaviour?
Its specific to a lpar.
>>
>> Regards,
>> Mukesh
>> [...]
>>
> Hey Venkat,
>
> Can you try the below fix?
>
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..de64389b0815 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -270,7 +270,7 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>   	}
>   
>   	/* irqentry_exit expects to be called with interrupts disabled */
> -	local_irq_disable();
> +	hard_irq_disable();
>   }
>   
>   static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
>

I tired this fix, but issue still persists.


Regards,

Venkat.


