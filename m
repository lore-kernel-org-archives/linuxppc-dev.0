Return-Path: <linuxppc-dev+bounces-23759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1927C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 04:28:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw4pP13Rkz2yQL;
	Wed, 08 Jul 2026 14:28:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783484893;
	cv=none; b=gnBng1grc2OT9ffbtC/3NwMD5U581VYuw9NlRk0scTwsQDLPXx3GA0ZJgYDJRuAy4EqA8u98VknYVDvji4QFAU43qcorsjN+iaLh56JLTHR7/YPxi90gUX32uN6i1TiOB4Ln/nU0zBJadXaGpARYvBxuj4JESRNH2/8gHJPvm1ZV5c47/pu6AKOl/wumgzPvpmtMcO+zJJfctw9NQkIExQSkp0hoTw5sPeO41JcuzhZR3zOzJhz4TwmKLYV2fRvTAzUqlkbSyY2ozxsmM785ADEGP7g/uMCJD2wAfLM6AD0XNRZfB4elYRlT9DQrxStd7Ab7mywYMwhdEiKGAtOwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783484893; c=relaxed/relaxed;
	bh=uGUGL/POIVv0M3ZtnYCAYH4seGHdEF7PBlI+l8AKKrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYZLqFhfueYPJn4DkvZoy0894KJGR7Is6vnL5hjhnmeACrL0jnV1bMNPoYKad9KsiTPx+F0k8YQckuoJdGMFhPiI6BR/hEDAaoU/Jq6nuFm8UL3wRkN04oNnBQpQP8lzMdyrk9TZVmFg513LFLpNPbQLHsrVnGZIRDif5G1jIVrzqV8jKFw8WUg66iHxqzmtEkYUE36dxJtTZbu7+vMzGHU3hUsrsPEtOf6GwOyy/xNt7qg1qUTVioQIEb5ShLXdfO3CLqamSLYDb3g3KMbZigdpRyxu9/CD66vo5qNxdW2TUk3FOOG9+DhgI8/df+Tm/EQLgIqHIFD82aMF7Y1BGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U6t1eSDW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U6t1eSDW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw4pN0D3gz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 14:28:11 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmcAm920904;
	Wed, 8 Jul 2026 04:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uGUGL/
	POIVv0M3ZtnYCAYH4seGHdEF7PBlI+l8AKKrc=; b=U6t1eSDWFIyvBMY4WzKlMj
	2oSG2JoA12HXwp6I9T4NLXikELXHaF4fpQlX0cucQdit+Nh7Bv8ftRslcvs/xGSp
	nZBusyOIrRLTBdRXfY4/T0zBpVp2+7se2f3OISfRYfmeiXuZuS9t0pR/Z3ZBczPd
	npIFSW27xBmpCWJUbRzMHTp9bkqdXrFICDMnNYMKxzd8j7H3K11fNOqZxNMGJE4J
	zS1hlNf04FtsuY3uZgHR5zPF5C5xsC/bCp+t+3vsoArd7mDSxAwy9hLKkgXJLAaR
	T75lYURSEMgY/qPF2yr25ahnzJcMoI8PKp5C4LaRVyh/itmhS0XlLlRaKlqeZQ+Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3tmc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 04:27:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6684JenT013074;
	Wed, 8 Jul 2026 04:27:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y5k4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 04:27:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6684RmvR60424526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 04:27:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF3D2004B;
	Wed,  8 Jul 2026 04:27:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E70C20040;
	Wed,  8 Jul 2026 04:27:46 +0000 (GMT)
Received: from [9.39.26.208] (unknown [9.39.26.208])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 04:27:45 +0000 (GMT)
Message-ID: <880eba74-6427-4fa3-941d-b67bbf98f3a4@linux.ibm.com>
Date: Wed, 8 Jul 2026 09:57:44 +0530
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
Subject: Re: [PATCH] powerpc/970: fix nap return address corruption on async
 interrupt exit
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        mchauras@linux.ibm.com, ruanjinjie@huawei.com, thuth@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>
References: <20260707172430.790040-1-mkchauras@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260707172430.790040-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4dd1c9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=tBb2bbeoAAAA:8 a=pGLkceISAAAA:8 a=R-5-Lu2bIDVPeb1iyBQA:9 a=QEXdDO2ut3YA:10
 a=Oj-tNtZlA1e06AYgeCfH:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzOCBTYWx0ZWRfXwV4t7gLSGBLz
 P+aLJD1I+cN/nLYMj4AywWAklUBueN2fp065Vlyq+Nd6IHAOVkAbjgVcU3/KWSJr0ICZVq1z9Uo
 zyyBWCZTt7fdjEOep9WjVjs1Dkd7S3s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzOCBTYWx0ZWRfXwL1vL8wPth2z
 Z0g2zMa1x3wIHfQaxC7TWvkVMMSuoRn/Kb/cZZFO52ZaFbRZwaHJI4MIoNNEF+uxNIVBy5RSPZC
 BW1um6Q1hhkiyr42XMIQJeeFynhNSYHtCaVnMVFiPiMTWw3Oaw0M6WQ08qtHPeM989PeEbsl78n
 F5hUkwx5ZgH+DUjJ6IFCr+IntKSRCa93kKatCyTVqmSjMNKX0cXTTjMVADh5ZA4RNP4lq/QxG3Y
 SGEefsy1PWCLVl38WinoLXIXaAbuZ3TVDNZ0m5Yrh++Iw0YKOt7ZrUsj15+7lYiNe03clgG5mUc
 Jgs56aKe6UwkO1Ao0yCFi7CXc2bkELaNkkIWVgRUc9Go8jaEA5DscuWNiaVL0rHiv4s7mXH3pFP
 6HM6B94/59CWiVohgrFMxuuQPS5gKESYIs4xJiQQJefd37lvdldhxfGGroLxIv1MrNlJ3X10kY1
 fcq5tDWdz0Mnv7GYVoQ==
X-Proofpoint-ORIG-GUID: LHpkbLgZtJzIDFZpAeZME05uGlBh69b2
X-Proofpoint-GUID: tqt656R1iEPo82XJFwvErZEAAfG5ek_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080038

Hi Mukesh.

On 7/7/26 10:54 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> On PowerMac G5 (PPC970, CONFIG_PPC_970_NAP) the system panics shortly
> after boot with symptoms including instruction fetch faults, kernel data
> access faults, and stack corruption, predominantly on SMP and always
> somewhere inside softirq processing.
> 
> The PPC970 idle path works by setting _TLF_NAPPING in the current
> thread's local flags before entering the MSR_POW nap loop.  When any
> async interrupt wakes the CPU, nap_adjust_return() is expected to detect
> _TLF_NAPPING, clear it, and rewrite regs->NIP to power4_idle_nap_return
> so that the interrupt returns cleanly to the caller of power4_idle_nap()
> rather than back into the nap spin loop.
> 
> DEFINE_INTERRUPT_HANDLER_ASYNC generates the following sequence:
> 
>      irq_enter_rcu();
>      ____func(regs);           /* timer_interrupt / do_IRQ body */
>      irq_exit_rcu();           /* softirqs run here, irqs re-enabled */
>      arch_interrupt_async_exit_prepare(regs); /* nap_adjust_return was here */
>      irqentry_exit(regs, state);
> 
> irq_exit_rcu() calls invoke_softirq() -> do_softirq_own_stack(), which
> runs softirqs with hardware interrupts re-enabled.  A nested async
> interrupt can therefore arrive while _TLF_NAPPING is still set.  That
> nested interrupt reaches nap_adjust_return() in its own
> arch_interrupt_async_exit_prepare() call, finds _TLF_NAPPING set, and
> redirects *its own* regs->NIP to power4_idle_nap_return.  Returning via
> that blr with an unrelated LR on the softirq stack jumps to a garbage
> address, causing the observed crashes.
> 
> The comment that previously lived in arch_interrupt_async_exit_prepare()
> even described this exact hazard ("must come before irq_exit()"), but
> nap_adjust_return() was placed after irq_exit_rcu() in the macro, so
> the protection was never effective.
> 
> Fix this by calling nap_adjust_return() inside DEFINE_INTERRUPT_HANDLER_ASYNC
> immediately before irq_exit_rcu(), ensuring _TLF_NAPPING is cleared and
> regs->NIP is adjusted before any code that can re-enable interrupts or
> invoke softirqs runs.  Move the explanatory comment into
> nap_adjust_return() itself and remove it from arch_interrupt_async_exit_prepare().
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Closes: https://lore.kernel.org/all/87wlvazrdy.fsf@igel.home/
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>   arch/powerpc/include/asm/entry-common.h | 15 +++++++--------
>   arch/powerpc/include/asm/interrupt.h    |  1 +
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index fc636c42e89a..c5adb5006361 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -66,6 +66,13 @@ static inline void srr_regs_clobbered(void)
>   static inline void nap_adjust_return(struct pt_regs *regs)
>   {
>   #ifdef CONFIG_PPC_970_NAP
> +	/*
> +	 * Adjust the nap return address before irq_exit_rcu(). irq_exit_rcu()
> +	 * may invoke softirqs with interrupts re-enabled, allowing a nested
> +	 * async interrupt to arrive. If _TLF_NAPPING is still set at that
> +	 * point, the nested interrupt would erroneously redirect its own
> +	 * return address to power4_idle_nap_return, corrupting the stack.
> +	 */
>   	if (unlikely(test_thread_local_flags(_TLF_NAPPING))) {
>   		/* Can avoid a test-and-clear because NMIs do not call this */
>   		clear_thread_local_flags(_TLF_NAPPING);
> @@ -286,14 +293,6 @@ static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
>   
>   static inline void arch_interrupt_async_exit_prepare(struct pt_regs *regs)
>   {
> -	/*
> -	 * Adjust at exit so the main handler sees the true NIA. This must
> -	 * come before irq_exit() because irq_exit can enable interrupts, and
> -	 * if another interrupt is taken before nap_adjust_return has run
> -	 * here, then that interrupt would return directly to idle nap return.
> -	 */
> -	nap_adjust_return(regs);
> -
>   	arch_interrupt_exit_prepare(regs);
>   }

This makes arch_interrupt_async_exit_prepare same as arch_interrupt_exit_prepare.
Maybe remove arch_interrupt_async_exit_prepare?

>   
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index fb42a664ae54..1b45a49e9bed 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -246,6 +246,7 @@ interrupt_handler void func(struct pt_regs *regs)			\
>   	instrumentation_begin();					\
>   	irq_enter_rcu();						\
>   	____##func (regs);						\
> +	nap_adjust_return(regs);					\
>   	irq_exit_rcu();							\
>   	instrumentation_end();						\
>   	arch_interrupt_async_exit_prepare(regs);			\


