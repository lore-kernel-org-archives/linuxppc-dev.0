Return-Path: <linuxppc-dev+bounces-25834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C10BC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 05:37:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLrZp27dZz2yQH;
	Fri, 14 Aug 2026 15:37:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786685826;
	cv=none; b=KC1x/HNa/sG0iGYv2/4w0x3eYZmrUgEe/xuWetmr5ReBbzVChBDp7NcHSEUPI4L9Q8g1IIthfZsBFXtvmVD2XrjuVrPcvy2qU4+ilGpQhc9GBsCfRJlxH/Qe8/XGEu6kjVN0zXGT4bZd1nXREZ+mWgNPEODRDax+fFdGA3kAFhjmLAmf+j85HDeIBrTvucgkiKVuGllgyaeS7w31mOkH5nx7bKRPkUPJmy0Sh/sgssWsHn6YxO88MtU7X+vGCtsD+WFJ/isrxxhi1do1GzKJF53s0hlpr75t2wCc98tl4VXatK6+/1IGcxqXovc3rfrbQstzKJ/5srKeCQXfxtSvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786685826; c=relaxed/relaxed;
	bh=2QHLr2QTuqLaRUhENSaHDsWR8jg+Jry/spbxygJsMHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZPpu+CNE/XJsDmt1sdytZVIFcITGugKmlwi8R4sFfqUAkYsMc4QbaRaVK8NHMVUZOr4lrEbO+rmOfx8yY75RU1LmaMSGiK90/5I2pQx3WCBBWI70F4x8ihtBvIx4N98zSMpauzlFjhdai1IhO42dUlqtsvaiU7ECsvjSM72bE9nkRyTSEioRPe82wsNzpIIpUrZtOjQkgnMv/qVy1KQDvHhCoQIBlaSu+3IAogxGeD4NNyIRHpdZbAMX7Zi1Ftd9EhN6Y1GkrXbgLtyjU0F8GVr3npr7cbYgzljBA/6iiid5bTb+EBGUQK6tCWK+BV9/aoRt8OkT9QNcqo4erAWYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LJxc+rTw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LJxc+rTw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLrZn2gC8z2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 15:37:05 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4Vown182958;
	Fri, 14 Aug 2026 05:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2QHLr2
	QTuqLaRUhENSaHDsWR8jg+Jry/spbxygJsMHI=; b=LJxc+rTwYM3uvi0hYsdf+n
	vk+5vS93DwLbOw6kGuafLsspF/VtAbfSdw8rhrFv+YzYfwVnrtXd5pGPu8IcrktN
	S2efc6pjdvVd/qrLU7zVOWBJZjkNAyGfokwBPWnqb+wP7ML04ZFZHllriJTiBgQQ
	egzCugrHShzKVT22dfkp/pRPAM4lvZD+BzsMgLqKlHg04zq1KIaxu4aIzr3uRX1B
	5ebPvcBUhKrzCHd726ZH+9/SuLpcqpvltftIPrVUT9D2Y4kSD5qcpyOMwpUIECxq
	loM+hOxKSE3ep3dJ6cuGPGqpz10WS3j+wtIke6lsdvDqTQhcVKwsSd+/yF440P7A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwj7qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 05:36:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E5QO32022956;
	Fri, 14 Aug 2026 05:36:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqe6ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 05:36:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E5allB40632794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 05:36:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8800320043;
	Fri, 14 Aug 2026 05:36:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F157F20040;
	Fri, 14 Aug 2026 05:36:44 +0000 (GMT)
Received: from [9.124.210.249] (unknown [9.124.210.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 05:36:44 +0000 (GMT)
Message-ID: <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>
Date: Fri, 14 Aug 2026 11:06:43 +0530
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
        mchauras@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260812152035.1661781-1-mkchauras@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260812152035.1661781-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ea974 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=oSVCPka-oEw81mTqY8MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6w2G6yLy3j83nUg8ggj-hon-knJdHvLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0MSBTYWx0ZWRfX6PkOiszOvXAE
 Sa4hYBnfOvLK6o1tMPvAQGX1hco/eiivRcgifJ4ACdIyKw/vPIr+aVe+uV2cSiB9eHJtxcq5ROF
 S8DFCaG6ODJ9SVjR0N2Z7WQV+5Jyw7koZlPWrSmPU32Z1Ba/PHVQ4Y3ehVpLuGIKdohON1D3XxE
 bk8YrelVbC/rG3sJ72bFZnIAZuF9kSek9cDtDNlO4xLpg0jrqIT1ifuJuSaHn8ypL4+b/M5ZXnV
 szSmH1CAndhLLgkLtwr8fYl8781bINorBpKldpc8jViluqz3ZXfHvWJJhJKdOsHz1BpPcV2Oeji
 +xtuW8ssRImrTh6xLyo/z1+AhlN2/KdcYEfvqNqKVlg47LSqUnxdTLXhpiAJS1QSKWtfnkwlPhA
 8mD4e3hPjI2dJtmPWG+tij5HX37cgVJhoBaqXoKThdHzP1/3ORLBtKdHuTIrULUEg/Q66khdutP
 fFczFUvLB0eXAht/SXg==
X-Proofpoint-ORIG-GUID: vuaINAksynpcryJfh1go3zVn3Plhaj9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0MSBTYWx0ZWRfXwfk8ztlaEj1t
 2IpI1gtuIzW6xq7Sig47HNNaFlQ1EKxlvJoVhYx8/XA5DtTuxDxOnXyXidiPwCNXoWOVFy7nIOf
 aAQo7VUkLPAX0OaSBN9tm9kYA6WVkjM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140041



On 8/12/26 8:50 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
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

This is good explanation, but what i not understanding is,

why pattern of setting PACA_IRQ_HARD_DIS changed?
Previous code at interrupt_exit_kernel_prepare which did local_irq_disable too.

Please check where was PACA_IRQ_HARD_DIS set without GENERIC_ENTRY which was preventing
this from happening?


> Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
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


