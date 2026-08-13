Return-Path: <linuxppc-dev+bounces-25794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3C1C5CFEB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:36:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLFxn4KgJz2y0B;
	Thu, 13 Aug 2026 16:36:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786602989;
	cv=none; b=MOnM5g0AHCFlaPv7ixklDXi1URdwN/A/YfNK8t1XUqESoYkTi2Q+yF7olzPhKHI9ZhKQ/jfazcIvCb15OXmaY+CTIF9m+Z8uFhah/+4EluaEWd6HmSLWxFWe+utAfTw5PNoSpIKYrMNd+5a+POKi42laDcW7OPTbG5ds7I7dYszIHMhJ1ZLsP+Peso0J8Ddy8b24O0Y0e1jvdefLVhLDYwq1HY2SQmxsddezAV/tasRIugmU6z+18QdTeAl/rTusmv8ahBPYp30QVSx26nEtap9TQCjj82FLIl7cdugZx2eFxjvVdzIcp7rMXr4htQw8TBtLevlI+giintGGEaJe2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786602989; c=relaxed/relaxed;
	bh=ed6y/HXxdeDh3Xl18To4lBxD4Swf20Md9lnRP23uy+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XTh7X1z66/hLeRMtIgrlgemXk4ah/1PJCmyKVUxEXdaoSkDkto0KVZXo87SklWVRJKZOP7l3wjoyPELH551PiLwQklG8Ls107jFngypqbKrmVvcRNKTju0uUctoFf2yzJATVhwcagG/Mwb1rEgH6QDWkqmj6tBF+BcDkcI/iXNeKOniBuE6vyQk9pLcxPcO3vTrJH0XlEfHWfYWJRQBx4KAXTIEh9pjm55Nx0YtN2kRXobQsgssGFhFLyM1LIwt2aGbOD9McGlLnWE4RJ2PBUkWs8QpPkjVksx5nZzv9cEewV4DiGCVxfV1gNLKCrduAbpbCisw+LC+MM8IHS4jojw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eKny6r8g; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eKny6r8g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLFxm3TKJz2xd5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:36:27 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61Xh81527710;
	Thu, 13 Aug 2026 06:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ed6y/H
	XxdeDh3Xl18To4lBxD4Swf20Md9lnRP23uy+w=; b=eKny6r8gL4BIoj0yH34FYe
	hJRkqYntg6lyRlKnZ2l8WU5fP9Hm4a+vSgSxs8NPCcmP4G5jKrRn/pW+0Oh/CiP+
	EDcXTSqTOpiH57bE9/YfxBpkwY0u8/xPmOfFhPaH0VQWB1EqJcvaLFRbdOkY8Vye
	yKhFkOvNBpPGdIMc5H24v6QIKrWbuhIwpekPN43kkNx+Sz1mqh7kR/VjLUrF3vXW
	jS6kL94v4KVbM9/sFeE9gNaFngb54hyy0MMaMOLlws8iff1QGCpJR7G5QKuBPCjk
	NyWWIpxetxp2IDq4oDiiZZE2yj20F8qyXPUyeTcSd6b5N+1DvOxMKJUulyA5duXQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9xmjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 06:36:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D6QJjM014834;
	Thu, 13 Aug 2026 06:36:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy9ng1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 06:36:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D6a8tN29885156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 06:36:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8845B58056;
	Thu, 13 Aug 2026 06:36:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31205804E;
	Thu, 13 Aug 2026 06:36:05 +0000 (GMT)
Received: from [9.61.244.175] (unknown [9.61.244.175])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 06:36:05 +0000 (GMT)
Message-ID: <4882a3cc-30f4-477e-8126-0c244b4a5072@linux.ibm.com>
Date: Thu, 13 Aug 2026 12:06:04 +0530
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
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sshegde@linux.ibm.com, mchauras@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260812152035.1661781-1-mkchauras@gmail.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260812152035.1661781-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA0NCBTYWx0ZWRfXx05jEcgQGTPi
 SsiD25x8z1/dD5v2lesiX+85+bcr99mBHqrEbBL66DY7+QN9xaxIPyh1UjYVvpnoqz1lRauniPP
 68RJXg84FAoFk5NZ1T3lmtjJLT4P76Z1LJpv8lNBzDjq9uX+3CRsHdV+dTpnPCGMil6rcXIz1v3
 peT8FeqngUGemAGHBbjbN5WSB/HDrSUPorZHONliXcZFHXL76kMgJJGk5PrdaXydgKGbwthtvz0
 fdwKk6UUbaA6YgWTNQQdSKK8SSCv8ODnUrKSC/OVU87R8vZlzjTJa0dhbebXaAVtbsiUVGCbde2
 S9+CzdpLHZyrHCWvFEW1oK6dah/zYAGFGq3423HNfrXUpB84S5WM18Hj7luh0IifEKHjnCmEkX/
 p4350WrDQsV5UI9SsXS3PHtV/4Aqv2jXw+EKb6lbaBOUbmAL7jTEtChadvFydNlNtCT9VL4HeNo
 5RGY4Yev/Zp2+MK19xw==
X-Proofpoint-ORIG-GUID: 8InQDJ7HrrlUT3mCM3uQJyUg0jBFKI6R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA0NCBTYWx0ZWRfX+EG7Qg70oDn7
 g2za1ARurFTVM5rpXr7B8bKuncYoJBN4EoMDhwaetMB8YzLhT241OyY6aJVcLBFiXyhxQjigQJh
 34lMefmCVPH+0h+PNiWTJmlvhNJO4qo=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7d65dc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=2I_y1vSCpsRrOs2zh8UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6kwpSNPETsVGE9emirRxjTwcMviuwaDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130044


On 12/08/26 8:50 pm, Mukesh Kumar Chaurasiya (IBM) wrote:
> commit 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
> fixed a BUG in preempt_schedule_irq() by calling local_irq_disable()
> unconditionally in arch_interrupt_exit_prepare() before irqentry_exit().
> The fix is correct in intent but uses the wrong primitive for PPC64.
>
> On PPC64, local_irq_disable() only sets the soft-mask
> (irq_soft_mask = IRQS_DISABLED). It does not set PACA_IRQ_HARD_DIS in
> irq_happened and does not clear MSR[EE].
>
> This causes a continuous WARN_ON boot hang on Power11 pSeries LPARs
> using the dedicated-cede cpuidle path. When the CPU wakes from H_CEDE,
> interrupt_exit_kernel_prepare() calls replay_soft_interrupts(), which
> dispatches pending async handlers (timer_interrupt, do_IRQ) using the
> DEFINE_INTERRUPT_HANDLER_ASYNC macro. That macro calls
> arch_interrupt_async_exit_prepare() -> arch_interrupt_exit_prepare()
> before irqentry_exit(). With local_irq_disable(), PACA_IRQ_HARD_DIS
> is not set, but next_interrupt() unconditionally asserts it:
>
>    WARN_ON(!(local_paca->irq_happened & PACA_IRQ_HARD_DIS));
>
> This fires on every replayed interrupt, looping indefinitely and
> preventing boot completion.
>
> Fix this by replacing local_irq_disable() with hard_irq_disable().
> On PPC64, hard_irq_disable() sets irq_soft_mask to IRQS_ALL_DISABLED,
> sets PACA_IRQ_HARD_DIS in irq_happened, and clears MSR[EE] — satisfying
> all of:
>
>    - lockdep_assert_irqs_disabled() in irqentry_exit_to_kernel_mode()
>    - next_interrupt()'s WARN_ON(!(irq_happened & PACA_IRQ_HARD_DIS))
>    - preempt_schedule_irq()'s BUG_ON(!irqs_disabled())
>
> On PPC32/non-64, hard_irq_disable() is equivalent to local_irq_disable(),
> so there is no regression on those platforms.
>
> Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---


Tested this, and it fixes the reported issue.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


>   arch/powerpc/include/asm/entry-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
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

