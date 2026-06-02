Return-Path: <linuxppc-dev+bounces-21853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849A8C5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:57:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV3821SMZz2xdh;
	Tue, 02 Jun 2026 17:57:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780387026;
	cv=none; b=e/m5Yq2uTzCur43H690mx77XEIs1MtenxUHe5vzKNxeu/XHjRRl8Ue4mjogy1azMDnNGZRGJlYlJs4XV6ZN1A2ABdRAjhCqB1YIiGO5yCRQyhbzKqo62DX3mJE6hIt2lRL+d9Ss/xNhdp9uyPzEM1ANxwXkfZZmUyG5cpPPW2Vkoe2FAREl8CroyI8nx0Ug1nXAlHOKyb9+AGBwo5BQK3gXvPbjJCZ1GHHkpjntqvMLONhasjW0WlXTDHxEIQdjTEvJ1an8bmfunVPScIYvZwu98fMXo52xB9WUl70kWG300qgkgL7kdic9P9aM0aWx8eWooI85/I7I7Ec8eZ+fL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780387026; c=relaxed/relaxed;
	bh=2RiCExUDqzIUC37VEiebL+gInpqFXOsD0dTg+s1bUHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOwaTh/SUT15um8fGB3mmjH2ehskYo8t3l5G0jFGfw5wSpbUO24szYQ9Qy0FrVIZnG1ZTCSjCeX/ziMtiTxNXecP5vvMWdk9iJtpJDdEzOhHsQ6mG2mdhePEwtMNxHLSAxqAHSQitEnQ2/hy2aSSnatUEsS7QdMbx7NKgaOc79Y/u+4WRaZuQeOkCEzqmKZfKZPwKzmmNsYn2J5aMm8dS794JPDI7225HO1Ez4HAzo8UoyiyIcAbsQyBqHb+6nyvCvakCVNMoFUq3DKIJohEr2Uo7cmmv8tFOL3TKQeMY0JUJdBYUspyklxGjYjAXyqmYk3HJoffsHtbMF5S7A0+oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CJ/g5l/m; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CJ/g5l/m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV3804QXWz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:57:03 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65231tpU1038075;
	Tue, 2 Jun 2026 07:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2RiCEx
	UDqzIUC37VEiebL+gInpqFXOsD0dTg+s1bUHc=; b=CJ/g5l/mDcc+YnJKOa6jWc
	ky/gZp4eRNz8yFMSLwLqGUukP+R/jv4AJiUu8GypeC7ZrO32TzSI84uUeopxe6EJ
	Fs7EhCiGZWSXDNm4Ln1FzojK/+9d4ZTN7a8kMdp4zFbZvoTymFVNKj5XLIMqwPh7
	nJ7QrwBGJXSMTbY0P6cTS02UHFe1YUzw1f2el3169iCSSQIZ17FwVYXS/sQmJ68w
	0WQZiXR7RYsf4Gm/49iZ5rINC5yHaAdCYJrWFnTzBM4imWOzUUgJHMw6cbmWOxhl
	FXyU2L9YcneM6nIZrcHPK9hibFpfDzAHbQKCH4FIn426fzl3+LHNjFWXcbVV4yfA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht4cux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 07:56:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6527sD54013020;
	Tue, 2 Jun 2026 07:56:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qad99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 07:56:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6527uqbJ42205522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 07:56:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 760472004E;
	Tue,  2 Jun 2026 07:56:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ED2B20040;
	Tue,  2 Jun 2026 07:56:49 +0000 (GMT)
Received: from [9.124.223.169] (unknown [9.124.223.169])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 07:56:48 +0000 (GMT)
Message-ID: <37e69c39-564b-4ca9-bb27-1b99faab540c@linux.ibm.com>
Date: Tue, 2 Jun 2026 13:26:48 +0530
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
Subject: Re: [linux-next20260529] kernel BUG at kernel/sched/core.c:7512!
To: Peter Zijlstra <peterz@infradead.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>
References: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
 <2f8c3d75-de2c-48bf-bd05-46b816d55c69@linux.ibm.com>
 <20260601095601.GN3102624@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260601095601.GN3102624@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0ekaTWu51kDtCT5Y0WZSRnf4V9r5Apel
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1e8cc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bISAhmP2TGWogpIYQrMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NCBTYWx0ZWRfX1XKq6D8JwhJ2
 b2/YzwnW/UhMC9N0/Di2Ho0u4EcWRrjzaH9sg5JFZeIq5QZmPyCi0diA8N3nyao6kvaNGxnoL1g
 G3aTemZ0eS5wHN5kNEmzjToFD3EaCLVKeDsyVp/Qnkv7ZdFZx9uxqpS9UZ8/ygWrZJ0vYOvrmEb
 299r3sHTDoN7j3OuKnVJoJ+gbGqzDDOpZpgO9UrX4+mMljYtqb9gEI6nW4N5qhXYPIrmQct9MqP
 rzetkxiyaseqiymxRi9FYm9+Mn/rjDDXcohNqV3G+LDA2z7tmR6QbRhVT79/syFbkVoKdQapNJe
 a0eneV76zHPnMUW8+nEzOQ85r8JqjVK5CN1HdB+S/bJ7RUBtqOBQ/Y55XaEvSvSet6OycCIg7z5
 2hQehe4EZgYx85NTN3XtpRl3t5SzcZmRL1nNol2PFFUKdDhdZlyKu03YLEL/8HOpOH2tSOH0caO
 tpvl//EUf2oUoPkQJhQ==
X-Proofpoint-ORIG-GUID: i0gQjjgNI6h6w2BAP7sZN-HgD5wX4_Jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020064



On 6/1/26 3:26 PM, Peter Zijlstra wrote:
> On Mon, Jun 01, 2026 at 02:46:24PM +0530, Shrikanth Hegde wrote:
> 
>> Ritesh, Mukesh, Is below possible scenario?
>>
>> do_page_fault seems to enable irq's in the interrupt handler?
>> is that expected? if so, one might see
>>
>> -- do_page_fault (enter kernel mode)
>>     -- enables interrupts
>>     -- gets interrupt - Sets need_resched.
>>        -- irqentry_exit - Sees it is kernel mode. Just checks preempt count
>> 			 and calls preempt_schedule_irq, which catches both
>> 			 preempt_count and !irqs_disabled. Hence the panic?
>>
>> Should do_page_fault do preempt_disable when it enables the interrupts?
> 
> No, it is expected for page-fault to be able to schedule. Specifically,
> it must be able to sleep to support loading pages from disk.

Oh yes. Ok. Thanks for taking a look.

> 
> Please check the value of preempt_count() (does it perchance have
> HARDIRQ_OFFSET?). Also, if the fault handler does enable IRQs, it must
> also disable them again once done.

Will check it.

> 
> Notably, I see ___do_page_fault() do interrupt_cond_loadl_irq_enable(),
> but I'm not seeing a local_irq_disable() to match!

Yes, that's likely the culprit. It is possible that ___do_page_fault runs for longer
and it may set need_resched. If it was in kernel mode, then it may not disable the
interrupt and then subsequent irqentry_exit panics.

BTW I was able to consistently repro this on P9 with hackbench as below.

for i in {0..10}; do ./hackbench 10 process 10000 loops; done;
for i in {0..10}; do ./hackbench 20 process 10000 loops; done;
for i in {0..10}; do ./hackbench 30 process 10000 loops; done;
for i in {0..10}; do ./hackbench 40 process 10000 loops; done;    << usually panics here.
for i in {0..10}; do ./hackbench 10 thread 10000 loops; done;
for i in {0..10}; do ./hackbench 20 thread 10000 loops; done;
for i in {0..10}; do ./hackbench -pipe 10 process 10000 loops; done;
for i in {0..10}; do ./hackbench -pipe 20 process 10000 loops; done;
for i in {0..10}; do ./hackbench -pipe 30 process 10000 loops; done;
for i in {0..10}; do ./hackbench -pipe 40 process 10000 loops; done;
for i in {0..10}; do ./hackbench -pipe 10 thread 10000 loops; done;
for i in {0..10}; do ./hackbench -pipe 20 thread 10000 loops; done;

Note, if i run ./hackbench 40 process 10000 loops alone, it doesn't panic.
Likely some continous stressing needed to get into this case.

Below diff helps to fix it. With it see test passes. Hackbench numbers aren't super happy
about it. It is regressing a bit compared to baseline. But no panic atleast.
AND i have changed the BUG_ON to WARN_ON as irq_disabled right after. We could still fix the
call sites if the warning is seen.

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index de5601282755..7da373a56813 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -253,16 +253,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
  static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
  {
         if (user_mode(regs)) {
-               BUG_ON(regs_is_unrecoverable(regs));
-               BUG_ON(regs_irqs_disabled(regs));
+               WARN_ON(regs_is_unrecoverable(regs));
+               WARN_ON(regs_irqs_disabled(regs));
                 /*
                  * We don't need to restore AMR on the way back to userspace for KUAP.
                  * AMR can only have been unlocked if we interrupted the kernel.
                  */
                 kuap_assert_locked();
-
-               local_irq_disable();
         }
+
+       /* irqentry_exit expects to be called with interrupts disabled */
+       local_irq_disable();
  }
  
  static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)


