Return-Path: <linuxppc-dev+bounces-20567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72759CD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 13:37:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBCwR0Xrtz2xQC;
	Thu, 07 May 2026 23:37:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778161031;
	cv=none; b=nb6eyQ8fKSvlUBhmF3E8wzfL3VUxGtJfL/ahipT5Prw73JcG1YlmUy6KlIxonudr8uZ+axwEb6apvBBE5t4/V55TMbG0bgZdYH7lbQ9fEg0XQ11/lPgIEnwWIzBnsdU46GMNX/Sbb8C9ZZX2lbgHcELwbT0b+HTVYUh0zNDNsbCWajMBffcOQQQxVw1Lm5S3Nc6iu159kxcy/45M9XMsT3AuJz9549I+Djhim9TZngmGd8pne4opd+EQjDh51jsFdN0jYI4jL5bHay59lb0Vds4lo5vd2o70xf2WP4EBZ2uyGjNYaB+doLMU7zuoUIpftgi8YoT38fTjsssJY0btYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778161031; c=relaxed/relaxed;
	bh=+C06N/WhHckgQrTKAWXapMtm05UyaUKmH+Dyb2ixO5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzwF1H8AAgQbRzwYFwHNQTRdpBqz3pUe159ntnJbu2B5xQeMB6Gvw3/DMg3xZPL/mdVgxFejkZowMgTSj09QZpHo3oVmLUFS2koiQm4H0EZTXISygaP9zOAcvITpWYgECxN/HBeDG+4i+HfV+2NqZ7dn05OCrMWntK7VRNFmytoTSn057oQyW5jJIFzXX6AzTbk+Tm8jidImVzEd41YSDH/H7EGpXO5Mb+/WpoWgf9bwuqBYa4WXAGBOpXAQT8GVmF8w4bSiv83Dss5TfVQnOnBZZfbuwYvCJeUvSFp7hI878NWdwPiFnRzMME1JUs14chdhO5UwiK76IdyEptE09g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fk4MmUs1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fk4MmUs1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBCwQ2xHsz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 23:37:10 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6476MboM067384;
	Thu, 7 May 2026 13:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+C06N/
	WhHckgQrTKAWXapMtm05UyaUKmH+Dyb2ixO5o=; b=fk4MmUs1XYJsU9P+F4NuJI
	5GTdLbLJNLCYSz++N8YryipS7xRwL1p7J3BcRueU1qFJubhMZbxTP2WmJ3X6JL1N
	xLzY3ibecYAkQ6QJDyDZGstJXDdvvJlSjyFnY8mnwwWwS87MZvvqd3fRUaTsMmNU
	/+tToeZ3GXCJzUOHf4/tZOZThSK1vW9bkB5XF4Cvrjvu55wPhrr9WZEtuzjL/E2V
	aYDIHgEYPtvItMrRpK+cbXtNqrilOfWU+KBRB7Fn4IAZaZE/h1hqDEHs8sJ2h5QL
	wKGiGzaeU5wR9s/omJRXyMOdDx1/iT1Sp7aALNhjwIuMgbYhK8IFaCi3fO9r1lpg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1prv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:37:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647DOUDJ031725;
	Thu, 7 May 2026 13:37:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqkybb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:37:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647Db2Lk54133080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 13:37:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A80A2004B;
	Thu,  7 May 2026 13:37:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2E8920040;
	Thu,  7 May 2026 13:36:59 +0000 (GMT)
Received: from [9.39.24.53] (unknown [9.39.24.53])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 13:36:59 +0000 (GMT)
Message-ID: <02b09dd2-abb4-4df6-9ad3-74812f34cd60@linux.ibm.com>
Date: Thu, 7 May 2026 19:06:58 +0530
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
Subject: Re: [PATCH 1/3] powerpc/time: remove preempt_disable/enable from
 arch_irq_work_raise()
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, chleroy@kernel.org
References: <cover.1778057685.git.sayalip@linux.ibm.com>
 <a64fa7d86da51f78743bee26e16ae155c43016c7.1778057685.git.sayalip@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <a64fa7d86da51f78743bee26e16ae155c43016c7.1778057685.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TG00qyLQUiXVkIWy0xz9jHkRL7xrKept
X-Proofpoint-GUID: No0jCZpB6ba70jvTqSZwhqJQKlkR5BYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzNiBTYWx0ZWRfX0W/gj2+ohC+i
 WNcn0bldzqqsWLAKbqUBubTqFfBCW2Sm7QMNpEJdYglSP2/rkmDRdUuH6WoXaJVtMJ13Al4rKsu
 27+UatzoiqujRvsPd5p2oCk+tkTuEqNNeCJVJRbX3VJxuFT7Z6AlQyyi2KXvDdvAauP+sTeHuzN
 Aot0hsI/5bg89ttz8zhy/P6I4wrG/AXDLxvql/WBFgG07+MwGdaPO4QuCHBTanngYcmUCaD8Z+W
 /2YSd9wRj+RUAy5inlMKAwS8U1N+cPLphE2KeJK/ZvCojCHRXn0PmpHrR+3iDRLm7Gl8CbMAeYf
 w2/eqxGQjgVXpB4eXL6H23h3UA0fmepv8q+c090pyqnbGsUfRh4e1bcP51BrGbx+cvqJ/oVJphT
 Lo/jS5b0jLuFmv7ZNYQDLwYXhFsNlEh1+uPCNVUI14rKKHbNl4APmBQWqSJdKRgQqWp9LqqUykj
 40cXXBA/15cMjXqRCqw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc9583 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Mg_wskF81hBiSU2tnFsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070136



On 5/6/26 2:36 PM, Sayali Patil wrote:
> A kernel panic is observed when handling machine check exceptions from
> real mode.
> 
>    BUG: Unable to handle kernel data access on read at 0xc00000006be21300
>    Oops: Kernel access of bad area, sig: 11 [#1]
>    NIP [c000000000029e40] arch_irq_work_raise+0x10/0x70
>    LR [c00000000003ffc8] machine_check_queue_event+0xa8/0x150
>    Call Trace:
>    [c0000000179d3c70] [c00000000003ff64] machine_check_queue_event+0x44/0x150
>    [c0000000179d3d30] [c0000000000084e0] machine_check_early_common+0x1f0/0x2c0
> 
> The crash occurs because arch_irq_work_raise() calls preempt_disable()
> from machine check exception (MCE) handlers running in real mode. In
> this context, accessing the preempt_count can fault, leading to the panic.
> 
> The preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
> was originally added by commit 0fe1ac48bef0 ("powerpc/perf_event: Fix
> oops due to perf_event_do_pending call") to avoid races while raising
> irq work from exception context.
> 
> Later, commit 471ba0e686cb ("irq_work: Do not raise an IPI when
> queueing work on the local CPU") added preemption protection in
> irq_work_queue() path, while commit 20b876918c06 ("irq_work: Use per
> cpu atomics instead of regular atomics") added equivalent
> protection in irq_work_queue_on() before reaching arch_irq_work_raise():
> 
>    irq_work_queue() / irq_work_queue_on()
>      -> preempt_disable()
>        -> __irq_work_queue_local()
>          -> irq_work_raise()
>            -> arch_irq_work_raise()
> 
> As a result, callers other than mce_irq_work_raise() already execute
> with preemption disabled, making the additional
> preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
> redundant.
> 
> Remove it to avoid accessing preempt_count from real mode context.

I assume interrupt is disabled here. So it should be functionally safe
to remove it.

> 
> Fixes: cc15ff327569 ("powerpc/mce: Avoid using irq_work_queue() in realmode")
> Suggested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   arch/powerpc/kernel/time.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 4bbeb8644d3d..a99eb43f6ce9 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -471,10 +471,8 @@ void arch_irq_work_raise(void)

Could you please add a comment for the function that it expects to
be called with preemption_disabled?

>   	 * which could get tangled up if we're messing with the same state
>   	 * here.
>   	 */
> -	preempt_disable();
>   	set_irq_work_pending_flag();
>   	set_dec(1);
> -	preempt_enable();
>   }
>   
>   static void set_dec_or_work(u64 val)

Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>

