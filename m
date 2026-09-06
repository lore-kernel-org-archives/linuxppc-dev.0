Return-Path: <linuxppc-dev+bounces-26623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12663C79F99
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 09:03:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hd44l17hjz2y2S;
	Sun, 06 Sep 2026 19:03:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788685431;
	cv=none; b=ZoKEN3qxgHXpnp1RwVdFgGnzt8K4RrZqN+oXT85ZCz17O/wZTgF6ReB+4D+33je4fDV5T02QeX9tVqs++J6d5qdEdbSj+PpzTfrWmz5rD0Qbgrl+xBCfUP/FX+51AiCfUM4h8pfXtB9SA1Glfu48msaW8AcuoOMkK477+w571w0XCTI201XIxqfs8CzbRXA3ujYbQKAXySxUSFWzIZxYV2X34h9qDeSFeiXeVNKtSUQ0HodLs1NQQsU4f2KjKKP8hXK7fLOSC9MA++xzdwm5kVnytcM/w2VKHoNO6rPVciF7EtDU+tYzj6q9R1LQPST7s9eGu7Zr+OFAJzn+teRg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788685431; c=relaxed/relaxed;
	bh=u32qnIeOoL7s2TKUFguAHaNyN1zc5k7iOIP12zm7Cos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTJipwVJV6ECymFxsSZMhBvrnWlUmNOyfKuy2KM5anS7zBouBSRcq9BrLswlUjbpmU80hO6uyTLQfOyXPf9gWccP9fHD94r5IlpaM/rCM+d5XSl4OEmpkM4+aYiRM+WmErUkS29o5rXIWQKySUvp7PhI+TMdWYcJb/knenwgnxegLg/QWA9bg/NI2kp+WXiQ4vRln4l1wSXxOIG13PTpGk8gRPqfkoOrLSP6ripfSBVe1jcr6P5Uoh+c6pQ2IdtrGVOeVtncmXThqOVBQSEvyx1RvRB1jhWT6TLZLyscTAqb1W2WxkF5DHzSboAyEMDsigomK3OvmofDcrQExhaLwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AE6lsCLf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AE6lsCLf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hd44k26GBz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 19:03:49 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68601gw61593908;
	Sun, 6 Sep 2026 09:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=u32qnIeOoL7s2TKUFguAHaNyN1zc5k
	7iOIP12zm7Cos=; b=AE6lsCLfO8kN/XcpFkv5ym2q5UeOymumsUgpF3TbmKB92I
	5RAKKp5s2J5Bnuujeirxcvlo++2j3JDbFclTrvv1x824AppwJO9TREsZDXKQ6JtY
	FpEmkuxtRbZKcuf+ua0ssNFMd+ATAbOD3X7xkATBdBnHxESGv/2Lugxmc1qspLxD
	sA8uUZv6gdhoDdEtIYmDKnIlSi/sZ/FGT0TsZ4rqDmyMNVSGimO5kfqHqtKDXgjC
	Ygnr4ZHqVuvboq4s11V9I1RtsErGihxaBIxZ7ozqFCbXQHeDIcflr/c5pqHi1JKm
	HtCbrkvm/vuq0d4W2ylf9R9UsxmsCrLidOlzipEA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj7upjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 09:03:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6868ukcR012193;
	Sun, 6 Sep 2026 09:03:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03y0q5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 09:03:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68693eDq43319736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 6 Sep 2026 09:03:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C09A220043;
	Sun,  6 Sep 2026 09:03:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F28D020040;
	Sun,  6 Sep 2026 09:03:38 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  6 Sep 2026 09:03:38 +0000 (GMT)
Date: Sun, 6 Sep 2026 14:41:23 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        "Nysal Jan K . A ." <nysal@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/entry: Fix double accounting of user time on
 interrupt entry
Message-ID: <20260906143854.d5f6e8b2-19-amachhiw@linux.ibm.com>
Mail-Followup-To: Aboorva Devarajan <aboorvad@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, "Nysal Jan K . A ." <nysal@linux.ibm.com>
References: <20260904025831.3439809-1-aboorvad@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904025831.3439809-1-aboorvad@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: R9Y1jjbpGrm1LMe20f718skn-FAJcxkg
X-Proofpoint-ORIG-GUID: 8Fgm4GK64Txvx3wYkvnlUYVtsvHs_U87
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6a9d2c71 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=uId4siVdVRRDVQ4xNrcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDA5NyBTYWx0ZWRfX0Pqhzp0WdLXj
 UWyzZWxBWQnJEG8z9zibxLf5LDn+yeLnAfUQS1Pic/Cs0qdhDPmIKYVADVq10/t2AbAUf1eRtku
 4Oql0bg3j5vycQA+7Is7dIPKFj21oRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDA5NyBTYWx0ZWRfX7Ni1XySBs/72
 7lvrIKl0iQajVb+tXf30zPCN003kZ/kVzWgpGpcd+IQU+4kkElKmplLWQI7KB3BnG/6ODGieY/l
 YiUheNoeF0yfuPyFbHorgaryH4wTWos/J6GvronWACvJsUbkdhvUo5RRyADFnSBoCdPXsdjvQh5
 LsCfjjeCeR0DZN4biumPYSPbN14Uc7pPPoXmBcVa5MvndxDULx2dKoVNHq3hK21hC5IHlZQXH1e
 OmWmucfnv1i8uan100ZP4vmHawKVK19qqjTc/18H5VuYfPTPpmwD2Q4iRudNizY/kZoZ2j0u0e5
 EJpugKy6DuP/3QTOXzxfTDNslFrXI3E1blqYZA7rhl7V+wocIQh3DoefAZYeQVnbtMvw+E5cMZH
 A+uzUiD59gNtdkVBNooKTHz0wxKyyC6cZbCR1Yxlm1vpsUWGf9kzBBzJ7Ltv9gyjGZN/VAi8MWl
 pG3nyijAXfaNiJaIsWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060097

On 2026/09/04 08:28 AM, Aboorva Devarajan wrote:
> Since the switch to generic entry, an interrupt from user mode
> accounts user time twice: once in arch_interrupt_enter_prepare()
> and again in arch_enter_from_user_mode(), which irqentry_enter()
> invokes for the same interrupt:
> 
> 	arch_interrupt_enter_prepare()
> 	  account_cpu_user_entry()		/* first */
> 	irqentry_enter()
> 	  arch_enter_from_user_mode()
> 	    account_cpu_user_entry()		/* second */
> 
> The second call charges the same interval again, because
> account_cpu_user_entry() accumulates the time spent in user mode
> since the last return to user space.
> 
> The two calls come from the GENERIC_ENTRY preparation series,
> where each step was a no-op on its own. Commit 09a9d3a8499d
> ("powerpc: introduce arch_enter_from_user_mode") added the hook
> with the user-time accounting in it, but nothing called it yet.
> Commit 893082ac769b ("powerpc: Prepare for IRQ entry exit")
> copied interrupt_enter_prepare() verbatim into entry-common.h as
> arch_interrupt_enter_prepare(); that copy was equally unused, as
> handlers still called interrupt_enter_prepare().
> 
> Commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> made both live. On the syscall side it did the full conversion:
> system_call_exception() now accounts once through the hook via
> syscall_enter_from_user_mode(), rather than calling
> account_cpu_user_entry() directly. On the interrupt side it
> switched the handler macros to arch_interrupt_enter_prepare()
> followed by irqentry_enter(), which also runs the hook, but the
> accounting in arch_interrupt_enter_prepare() was not removed to
> match. The double accounting starts with that commit.
> 
> With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
> reported user time of any workload that takes interrupts. The
> other accounting modes compile account_cpu_user_entry() to an
> empty stub, so they are not affected.
> 
> Remove the accounting from arch_interrupt_enter_prepare() and rely
> on arch_enter_from_user_mode(), which already runs for both
> syscalls and interrupts. The duplicate account_stolen_time() call
> is removed the same way.
> 
> On a pseries LPAR a busy loop reports 6s user time in 3s elapsed
> (~210% CPU) before the fix, and 3s (~105% CPU) after it:
> 
>   $ python3 -c 'while True: pass' &
>   $ sleep 3; ps -p $! -o etime,time,pcpu
> 
>             ELAPSED     TIME  %CPU
>   Before      00:03 00:00:06   210
>   After       00:03 00:00:03   105
> 
> A 50% load reports ~70% usr / 30% idle before the fix, and
> ~49% usr / 51% idle after it:
> 
>   $ taskset -c 6 stress-ng --cpu 1 --cpu-load 50 &
>   $ mpstat -P 6 1
> 
>             CPU    %usr   %idle
>   Before      6   69.74   30.26
>   After       6   48.51   50.50
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

The fix is minimal and correct: removing the two lines from
arch_interrupt_enter_prepare() leaves arch_enter_from_user_mode() as the single
accounting site for both syscalls and interrupts, which matches the generic
entry design intent.  The benchmarks in the commit message are convincing.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> ---
> Changes in v2:
>  - Explain which commits introduced each accounting call and how
>    they overlapped in commit message.
>  - Drop the code comment.
> 
> v1: https://lore.kernel.org/linuxppc-dev/20260902050628.2553909-1-aboorvad@linux.ibm.com/
> 
>  arch/powerpc/include/asm/entry-common.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..000fa925e26a 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>  
>  	if (user_mode(regs)) {
>  		kuap_lock();
> -		account_cpu_user_entry();
> -		account_stolen_time();
>  	} else {
>  		kuap_save_and_lock(regs);
>  		/*
> 
> base-commit: fb442a6673ff1046bf67754957d95880fdb394b5
> -- 
> 2.54.0
> 

