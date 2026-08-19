Return-Path: <linuxppc-dev+bounces-25968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C958AC5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPwlF4qQ3z2yFP;
	Wed, 19 Aug 2026 15:55:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787118905;
	cv=none; b=PDSfayMG7JMx1UhkwTm1GJyYfdZyTbw2saFyw2o74jmEOVQIxCtJ9xKM6D1WSRsXl6asjVkOpFN2dHFq8fTqe2sLn8bTYLc+aFXIuRpKQnuPapYX0e/RTpN/ALCRlJhnN8mR/7Fo2gLMUXPw8zaXkUbuXdB2g1itsXNdImRCvhYqFVYW0JeNRI7eMxarMvqnh9tsgKI5ravjwbf71v8wtkjawm3h//Lurc9/FzUNFW7/owV1X1J6Z/tE8IxOhzrWSgfX3bayrJP2teQ0UDLBW2wAuBeITaLVq6IeFpDEaej57GDdWPBT4stO9GHHl4vvzSGsGxHcAmvtnT6ldQK4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787118905; c=relaxed/relaxed;
	bh=uKvPs5gYVksH3k8c2iir+Z71qjT7+uNRRu56iwoGPpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KczVYjJgloc3LLNibYdoBGPL1v5xDMWk1QnuNEpQ8ltoTphvSmH7H43ODk9LqCBb0gP2UvbUBVrgT9C8nVKTPlS6sc84v0cELGCWbo4VdP7JZfIqmuRUYF1Yb+VF8p/NT5Yf0FVt34GL9DaAdX7QyoMzT/1jbJvPk9ZJyBBMmAcyVyAldbrQuwkrLYcBMNGBkarkPwMY/+/N4tXu4wEZOuL7UIxeqIb0NbuejgVKZjXIfhAmvUq0Gh8/HIMCw/sgSAFJUcqvAze4sbHkZyK3En6go6iRxBVKEIVK1Po4BSpe22pfou0h75LiOFOiWN01K01KnYqPfeQvbNPqEE9c0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZGC79hxV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZGC79hxV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPwlD27MXz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 15:55:03 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J31rhM352930;
	Wed, 19 Aug 2026 05:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uKvPs5
	gYVksH3k8c2iir+Z71qjT7+uNRRu56iwoGPpY=; b=ZGC79hxVH5D5aMKWdgqT9K
	u5X7F7iFfe9BDLZ2Xnz/HZfVeOA1fBrIVKw2ediFT5rv6QYcEY5oNw8843MNuc6v
	56CGc1csmLyL4YDW4QUIqgf14eH1i7OcfFdggvBGK/Qhwu9p4QnpfQgN5HlUyw3R
	x0f2rrPUMbRwjO3Dq4i6fX3X0VaagPM4DRXY8+gkmyUAXFR8aIm0aN/Xeu31WCCo
	f+rLfyHKt5mIscKSvCVxAaKFKHsY8FMCNZES8eAvPPMjND2ir/iQEnTf+JZX3GH1
	wkgwiSg2Yb56aoIAx9MHnMfGHudwHSgwq4nJHnI2zgDYFBlS1RFuu6DvVTHaq9HQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu01tea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 05:54:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J5fNQU030017;
	Wed, 19 Aug 2026 05:54:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh7ajj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 05:54:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J5siXj30999164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 05:54:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC96C5804B;
	Wed, 19 Aug 2026 05:54:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DC8E58055;
	Wed, 19 Aug 2026 05:54:41 +0000 (GMT)
Received: from [9.123.2.243] (unknown [9.123.2.243])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 05:54:41 +0000 (GMT)
Message-ID: <999c327b-3ec9-4636-a29e-57795d333912@linux.ibm.com>
Date: Wed, 19 Aug 2026 11:24:40 +0530
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
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
Content-Language: en-GB
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mchauras@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>
 <an6w517sUDWwpVfZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <an_xbqRgm4RaRw0r@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <an_xbqRgm4RaRw0r@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FET6jlX-4QDT3FV_uPahN7NfsCBs9ViE
X-Proofpoint-GUID: KBLAAArWPO7DTtih9Pr4I35YKRTw53O-
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a854527 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=-A3O-PPTHnIwpUFzzSkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzOSBTYWx0ZWRfX3sMll4UQyFOq
 O5MRgECYdZqLAogXixPNUk5eqIC3FkFFxUB7Ts69xAj0/CqhMOVEQXNxwEHfBw4SKkbwciuZw2L
 lFHfd3Zs990B/mgwkatruS8+XRg0mCM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzOSBTYWx0ZWRfX4yQ0GMUnwQJ1
 0XZg9pJlCoEHZXWB/r6At88ZyjUiXJHAd9sxyoUsLlfrAe1bfgfbGE6cbfzhrh172DYebZC5+kY
 Xy9WI7bskTgV3wwOauxN5cKIvXyibdnyNHBOvqz4ilIrxeoIbp8F0rLaYnKYS0DLom1gjPuiJZG
 CwmV0wISJJDAdWSzVq0tv91uhOhksQNC13xghuv6k1khUo358rlw/ZbEuCh8Wf2UmJIMQ6Ch1PI
 VN9Md22HvU2D/lAQvhJSn882tPiEpqdGY2/faEnL7OvtTbhiXwFjeLyY5aV7BMwZlbItaM0UtNp
 Nxn5vcZ6ALjItfMR41L3MDBsRO4G1aIU1W05JNwQr10ldmJ/cTd5L/+lx3umxfUShzUWpfQ9ZfP
 L0+HERDZYoCM0/jCfbldzIijIeqhbMYpOM0AP2XWiuba4AIbjb76zbAiyigekq3Sopi2l9Y83k7
 f4orymj1tO9tbgU+oBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190039


On 15/08/26 10:27 am, Mukesh Kumar Chaurasiya wrote:
> On Fri, Aug 14, 2026 at 11:42:22AM +0530, Mukesh Kumar Chaurasiya wrote:
>> On Fri, Aug 14, 2026 at 11:06:43AM +0530, Shrikanth Hegde wrote:
>> [...]
>>> This is good explanation, but what i not understanding is,
>>>
>>> why pattern of setting PACA_IRQ_HARD_DIS changed?
>>> Previous code at interrupt_exit_kernel_prepare which did local_irq_disable too.
>>>
>>> Please check where was PACA_IRQ_HARD_DIS set without GENERIC_ENTRY which was preventing
>>> this from happening?
>> That's an excellent point. I think we are looking at this incorrectly,
>> If this is related to the nested soft replay interrupt than this whole
>> dynamics changes, local_irq_disable will work for the actual interrupt
>> but when we go nested something is telling that the nested interrupt
>> that interrupts are enabled. Let me look at this more deeply.
>>
>> Regards,
>> Mukesh
> Hey Venkat,
>
> Can you try this diff,
>
> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
> index d5c48d1b0a31..2fbfebef74fe 100644
> --- a/arch/powerpc/kernel/irq_64.c
> +++ b/arch/powerpc/kernel/irq_64.c
> @@ -117,7 +117,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	local_paca->irq_happened |= PACA_IRQ_REPLAYING;
>   
>   	ppc_save_regs(&regs);
> -	regs.softe = IRQS_ENABLED;
> +	regs.softe = IRQS_DISABLED;
>   	regs.msr |= MSR_EE;
>   
>   	/*
>
Hello Mukesh,

With the proposed change, I still the issue.

[    0.742633] ------------[ cut here ]------------
[    0.742633] WARNING: arch/powerpc/kernel/irq_64.c:75 at 
__replay_soft_interrupts+0x104/0x220, CPU#6: swapper/0/1
[    0.742637] Modules linked in:
[    0.742638] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Tainted: G   W      
      7.2.0-rc7-dirty #25 PREEMPT
[    0.742639] Tainted: [W]=WARN
[    0.742640] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    0.742641] NIP:  c00000000003a384 LR: c00000000003a360 CTR: 
c000000000029f00
[    0.742642] REGS: c000000009757410 TRAP: 0700   Tainted: G W          
   (7.2.0-rc7-dirty)
[    0.742643] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE> CR: 
88024824  XER: 00000003
[    0.742646] CFAR: c00000000002a708 IRQMASK: 1
[    0.742646] GPR00: c00000000003a360 c0000000097576b0 c000000001b28100 
c0000000097576d8
[    0.742646] GPR04: 0000000000000000 0000000000000001 c00000000968d200 
c0000000096eb200
[    0.742646] GPR08: 0000000000000001 0000000000000041 0000000000000001 
000000002c1b8100
[    0.742646] GPR12: c000000000029f00 c0000005ffff8f00 0000000000000000 
c00000000968d200
[    0.742646] GPR16: c000000002f3aaf8 0000000000000000 c00000000284e138 
0000000000000000
[    0.742646] GPR20: c00000000303aaf8 c00000000303ade8 0000000000000001 
0000000000000000
[    0.742646] GPR24: c00000000303ae08 0000000000000000 0000000000000000 
0000000000000002
[    0.742646] GPR28: 0000000000000003 fcffffffffffffff fcffffffffffffff 
c00000000968d200
[    0.742662] NIP [c00000000003a384] __replay_soft_interrupts+0x104/0x220
[    0.742665] LR [c00000000003a360] __replay_soft_interrupts+0xe0/0x220
[    0.742668] Call Trace:
[    0.742668] [c0000000097576b0] [c00000000003a360] 
__replay_soft_interrupts+0xe0/0x220 (unreliable)
[    0.742672] [c000000009757860] [c00000000003a694] 
arch_local_irq_restore+0x1f4/0x2d8
[    0.742675] [c0000000097578b0] [c0000000002face0] 
console_flush_all+0x3ec/0x558
[    0.742676] [c000000009757a00] [c0000000002faee4] 
console_unlock+0x98/0x1d8
[    0.742678] [c000000009757a80] [c0000000002fc698] 
vprintk_emit+0x2c0/0x3f4
[    0.742680] [c000000009757af0] [c0000000002fdc70] vprintk+0x30/0x7c
[    0.742682] [c000000009757b10] [c0000000002f6c78] _printk+0x3c/0x50
[    0.742683] [c000000009757b30] [c00000000205d814] 
load_system_certificate_list+0x24/0x5c
[    0.742685] [c000000009757b90] [c00000000001111c] 
do_one_initcall+0x5c/0x3f0
[    0.742687] [c000000009757c70] [c00000000200684c] 
do_initcalls+0x11c/0x270
[    0.742689] [c000000009757d30] [c000000002006c78] 
kernel_init_freeable+0x228/0x3c0
[    0.742690] [c000000009757de0] [c000000000011600] kernel_init+0x30/0x260

[    0.742692] [c000000009757e50] [c00000000000df7c] 
ret_from_kernel_user_thread+0x14/0x1c


Regards,

Venkat.


