Return-Path: <linuxppc-dev+bounces-26449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C19AC624D3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:01:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZmBl3MCYz2xmh;
	Thu, 03 Sep 2026 01:01:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788361263;
	cv=none; b=kqMPXPJTsoQabWWju9MsjW4sHQi7jaFXiQrYCg3SFDyR87QQ0pkkLMWQtFjyFzoVMOzah0tcZV1DUsZEVWbUZ3G5ePpYmptQzCXtScmqboUYpYYQBCK2JT5coXjZd9XEAnKuXGtkZ6pT5ux7X7um387PAEsRlckrR8YPujsWmE3ambO/d/MQIA4xFBhhalp1XZAJUUwbm6+xagFpVYwPp177hyAJ5MEh5KXNUW7WwVQyA2tgSn0U4/gTPZ/XetoTapPDMJOcjkohBx1ubvgvV64jLSap7m8JJUqK5fpiTti2m5GNb8OmOr3rHDr3zaHScacF8ZMUM4xYtHRDx8MlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788361263; c=relaxed/relaxed;
	bh=f/afAMvcSG16JWmxCYcN8ObCZf6YrL853cw0BLFF6jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FijR04l3tRjv21S7jU7szTMICh6c8grNyAKHPZrfW7xmbEEqelp32oAtZt9W18d8uDD9L/DyV+aS+0RwYc0wvBvQ1XQV9zIdVNpPmbQ3rbwXf7wvLIW8kGXQhAK/IytwDhj+eCH+2mn5iO4/asRkYLQRmb5iozBKjwWhN4XTd+oEc5HI9MhbRRZBC54ViTcfO2ovtUs1CxgJ8GSu2XQuovqRX2HDMAqBZiLBH10h5xhOFHwCzJoLVuyyF8OijnjPD9f7bhan3OOVHQGWkHrYCfFo5/xCFZjisJkcLViCwv8PKKEA50YFBs8M9/Auwnn9sBcm8Zzfdpsiqz330818Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JXo+zsxB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JXo+zsxB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZmBk1Z40z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 01:01:01 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVsFH2312661;
	Wed, 2 Sep 2026 15:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f/afAM
	vcSG16JWmxCYcN8ObCZf6YrL853cw0BLFF6jw=; b=JXo+zsxBbXlJ/Q326jsmA2
	B6xfqca4Ox3Fa53mq+B7o/1fVhpSlDz8CKc/hw2P0i8Que5+rlsK9LPxnpitJWOz
	nnX/K+tcJH3Imol+so5IcYhmsYy5m/nmYKDUneNtwzwARqGcUsUTMqv4ezo5RJqL
	hAsKBnxneaHpJAssJtGgeXyAVHhSA3ow0n4tfvVmI9sTQu15I/ZPthhbZlJP5Zw4
	/2LiRVse7mYxEoZL0DbrwgGbq8g5ebmoi8QtHnlZAXAa9DRyaT+fBc4wsreo6DDr
	QS2vEsElBR84iykWQ7vu926ZdYGfw1qmY8ibYjkD79B+uAdxhMyfRCYBEKz/1pmQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rfd6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 15:00:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EuHni030023;
	Wed, 2 Sep 2026 15:00:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygjady-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 15:00:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682F0obW41681228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 15:00:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22BE720043;
	Wed,  2 Sep 2026 15:00:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F69220040;
	Wed,  2 Sep 2026 15:00:48 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Sep 2026 15:00:48 +0000 (GMT)
Date: Wed, 2 Sep 2026 20:30:35 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
Message-ID: <20260902202321.f96cca62-31-amachhiw@linux.ibm.com>
Mail-Followup-To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a983a27 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=k8QQlTQu1wMg4mGaVn4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zN3U4HZD8WQ9PLpk6uzzn8WLqQGjEl83
X-Proofpoint-ORIG-GUID: nWGX-v3s002pKyK87l9x_xhNpndE8Y-w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX8Q9cd+DvCaZT
 W2PbvISClzT7W/10uYRGfvR62YNCNLPpITP7Zy4Qz1rkqb7lZnIbfdAdYsBjgd2rwf2YOscIk8n
 DewHmyucP6AGc3HoVxiYxjRD+Zz+ByS3xJinTwVQksjqvq9UTJku8Y7AsdaCX9RYRmmS+tuLXCY
 BRBa0iAuE/CA7giXHtQXHiICrGaSls7IPrtx2E0UGgFZc9bczUmmSlcnvke+Asu0a+B926Lq5zW
 AE09sdVkwlXyixTQQVefuxlGkJlJiPHSBmoX6cy4DplDZl9EV9iD0rg9NamLjZNWfUP/Ug2XyBr
 xlD6Bqmg5YS2w1+40qRAQhxWdfIKFeCvy/ZR8nyKn3X7jXd4090T5VeOqqJ+5pM2MakU8HhC35g
 DUoMqnzeDKcr5I0kUack9ymukRL9dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX6jsFSNVhFybF
 Wok91A+ajvSywdb0RzT8cSU4ypZIFscqJPyxBKsXSUthNMohwv9K2iG4+FdWH0tzWwb3UOUzE4a
 NICF3ISK23NHW4FXcl0C5U3Oojfbqco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609020128

On 2026/08/29 09:49 AM, Ritesh Harjani (IBM) wrote:
> So the syscall return sequence is as follows:
> A syscall return to userspace is prepared and then a short asm sequence
> that actually does the RFI. Note that this asm range is restartable i.e.
> EE is still on, so an interrupt (e.g. decrementer or external interrupt)
> can hit while SRR/GPRs are being loaded. This is defined via:
> 
> RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)
> 
> This restart table then sends us to syscall_restart rather than resuming
> in the middle of the RFI. The same stub is also used if irq_happened
> already has a pending bit (soft-masked irq that has not been replayed
> yet (PowerPC special case of local_irq_disable())).
> 
> Here is a bit of a flow of sequence of code to visualize:
>   syscall_exit_prepare
>       decide full-GPR restore (_TIF_RESTOREALL) for signal,
>       rt_sigreturn or syscall trace
>       save that in regs->exit_result and return it in r3
>            |
>            v
>   .Lsyscall_rst_start .. _end     EE still on
>       irq_happened set or interrupt in this range?
>            | no                         | yes
>            v                            v
>       cmpdi r3,0                  syscall_exit_restart
>       restore all / zero            replay irq, try exit again
>       volatiles; RFI                must return flags in r3
>                                     again for the same cmpdi
> 
> Now r3 after prepare is the flags word, not the actual syscall return. A nested
> interrupt clobbers it, so the restart stub reloads RESULT into r3 and the
> C handler (syscall_exit_restart()) should put the flags back (because later asm
> checks whether r3 returned from C has _TIF_RESTOREALL set or not):
> 	cmpdi r3, 0
> 	bne	.Lsyscall_restore_regs
> 
> Note that syscall_exit_restart() already ORs any new _TIF_RESTOREALL into
> exit_result, but then it only returns the new sample and not the full
> regs->exit_result.
> 
> That sample could be often 0 even when restore-all is still required:
> 
>   - rt_sigreturn / syscall trace set the bit in prepare's local
>     ret and in exit_result. They never set exit_flags, which is
>     what restart samples.
> 
>   - a signal does set exit_flags but restart clears it. A
>     second pass through the stub then returns 0 while
>     exit_result still has the bit.
> 
> The asm as mentioned earlier then treats r3==0 as the fast path and
> zeros r0/r4-r12. That means the userspace that needed the full register
> set could SIGSEGVs, (which could happen often in ld64.so.2 like while
> doing a parallel kernel build as reported by Venkat).
> 
> So we should instead return the accumulated exit_result, like how we do
> in interrupt_exit_user_restart(). Note that prior to this commit
> 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
> we were returning regs->exit_result from syscall_exit_restart(), but
> this commit changed that behaviour.

Thanks for the detailed commit message — it really helps understand this
subtle path.

> 
> Fixes: 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> Sorry about the long commit msg. It took sometime for me to fully understand
> that complex path, so I thought I may as well document that properly.
> 
>  arch/powerpc/kernel/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 5b88bf72786c..55f9c0c9922a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
>  	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
>  	regs->exit_result |= ret;
> 
> -	return ret;
> +	return regs->exit_result;

This change fixes the userspace crashes which I observed while compiling
kernel on an LPAR booted with Linux 7.3-rc1.  Also, the change look good
to me.  Hence,

Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

