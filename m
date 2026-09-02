Return-Path: <linuxppc-dev+bounces-26446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECBBC624D3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 14:28:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZlTF1JXbz2xpn;
	Thu, 03 Sep 2026 00:28:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788359313;
	cv=none; b=TzTxDNAQiwdCoMXBGx/ND8Q7HdTiO/YkNejg3PTm17I6LyLRedc4H/ADqNZq24eZK2SKzn129+OSSmEcSjVOeMGIBqYfuLUUu9U+51VkoYRsbTben98iaoUc+zOEpyp7fsUFmLDJOmr6Ezb34LanXg8fFQwwJtVmUVDq2hL05mezICltmj2N1deIqSqyR4mkSPcM3obFlaeOGkylM+yDaiy1cJq8JaZPSNRaumcM6Mfnp11HnWsYU5/Onfx1CL8cnqjFWDruXHjoOR17pz38kOl7krM9Xq6sEXOAgON/3EJbs3GKrGrt6zI3RQB0KlcSblyv7XFRLYqdOmO0R0S7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788359313; c=relaxed/relaxed;
	bh=aDsDib7WoD5yINO0grisb6bOFBXtuOslcA7PoS7SqXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+opqGumyCA4Kl2bfIZHJr/BrwuoIkwC3Rbq+fnbPgXl3n1+sjbdgKtwwyKN1KuiP029P3JLXU/yLnLep62nrQH1bfNOwjGRdNM+PdJ7Jz+Yt1Ga4sR+ewngFhVK5NWD9wMeVmnSMGHyeWYFthPbYiDqV9iEPyxC7Kt/0cUMVZWbegN4wh9KidRVXqQe6knQ+IwYYoVx5BMGMfHPaaNXP/x5Vlc2smOQeYepkQ/5ubPN+rVSDlmLCy1HAH/yS5o8ZysQKoYLrOQ9343b6joFchPVYHPUxbozAKCA4fcVQR2LBL5Q1z6Pm9po3yq9aj2NLMgCyWjV4nEXvpIrmfXr/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=skv6iwYv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=skv6iwYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZlTC69hhz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 00:28:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVkYv2312056;
	Wed, 2 Sep 2026 14:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aDsDib
	7WoD5yINO0grisb6bOFBXtuOslcA7PoS7SqXs=; b=skv6iwYvdMPTcIgkLhjwp1
	3uExdxGsZY+UnwvgoNwtWG4BjLJL2fMExHfxz2R2VOiZj2KLSfxK/yqk1apVxPpp
	p1UGaIn4Xe32GcfSP0SWSX1gDHmr9IVQQwKFFUAGGFyozH990T2rGSQJVqzo49Qm
	IilHIBa7P7WXMtpe0g5iakTTL8NjG0GbSCWAmzIVhryleJAcC/3tLBZj2VrOM/Gj
	v5/yg/2Du5FX0BzJeCdRTZ4/0z0JX20eYbMF4XB+DCdjDwsyrf1P+jlMsV5BP/Ub
	BOXxEEAUP91dAZPfvhg1nF30hva/s0zcgeGTQ2xgPS1pO1ToVJ93rkSSF0invVDA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rf5r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:28:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EQFRc030336;
	Wed, 2 Sep 2026 14:28:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqjfcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:28:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682ESKlw38404472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 14:28:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFF8320040;
	Wed,  2 Sep 2026 14:28:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6778C20043;
	Wed,  2 Sep 2026 14:28:19 +0000 (GMT)
Received: from [9.39.25.199] (unknown [9.39.25.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 14:28:19 +0000 (GMT)
Message-ID: <8c1583c4-bd4d-4c38-84d0-a75780a4e5db@linux.ibm.com>
Date: Wed, 2 Sep 2026 19:58:18 +0530
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
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a98328a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=k8QQlTQu1wMg4mGaVn4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX/GSgJ6YHqj7p
 C+ZCcSIhqU2Z2Sz1J+/IK8j7L1g7TNCthur2PGqB17FC6Gjkh8g0j59ODnqWS277ulvTsMUkqjQ
 /hgqikzzsdCLf64p6GGK8m1j76/7iGXuoOVRWTa2UKYrzx6xI8QR6AD2PtzJZod68ICVbUBbNWB
 SPTNnvW+6WVKwBbOITggZ9Jew2GBqe0KS9M7CFz/hWgQSzNdKDrwysqsEu5UOgZBGIZ/DNZPRE2
 5gRh2jZZ11DWEF+eYFbYSt9BESALMzJki19NrekYWo8TAvW5A4HawGx0gQUbY1kaGBtNggcsQMk
 +FUrJWI7Yj+oHp0BMIr6FAmdFC2juQv14cQ4jUYEcCE8sEI4XEgUORzQlb9hpUIIO28f/h8jTli
 kkg5q0FN7DD6JSSlEDPuI/e1/zIjwGofJ5UTI1YLnWP5bomvbQZsnNgLnSOUHtIHZEgNu5pI6Yl
 4pamJhg8iczozZ1vNzw==
X-Proofpoint-GUID: IfaIlEis7rLee0NwIOlL0eGzOUT8mEfd
X-Proofpoint-ORIG-GUID: T85Dxqcf0JPz8RDIm7ePtIzJrtJ1JQSi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX04aPY4yivd4B
 xju9qzxona20HrayzFedV2Ga1z+x+Zlb/LJAB/eshypZ30dJWxEkt3F6wQCB1ugi/c5vFu2vEZ+
 QQGP5lzDTp4uW1PBVemO2A7m6kTuCew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020124



On 8/29/26 9:49 AM, Ritesh Harjani (IBM) wrote:
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
>    syscall_exit_prepare
>        decide full-GPR restore (_TIF_RESTOREALL) for signal,
>        rt_sigreturn or syscall trace
>        save that in regs->exit_result and return it in r3
>             |
>             v
>    .Lsyscall_rst_start .. _end     EE still on
>        irq_happened set or interrupt in this range?
>             | no                         | yes
>             v                            v
>        cmpdi r3,0                  syscall_exit_restart
>        restore all / zero            replay irq, try exit again
>        volatiles; RFI                must return flags in r3
>                                      again for the same cmpdi
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
>    - rt_sigreturn / syscall trace set the bit in prepare's local
>      ret and in exit_result. They never set exit_flags, which is
>      what restart samples.
> 
>    - a signal does set exit_flags but restart clears it. A
>      second pass through the stub then returns 0 while
>      exit_result still has the bit.
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
> 

Thanks for the fix. segfaults in ld64.so.2 are no longer seen with kernel
compilation.

Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Fixes: 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> Sorry about the long commit msg. It took sometime for me to fully understand
> that complex path, so I thought I may as well document that properly.
> 
>   arch/powerpc/kernel/interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 5b88bf72786c..55f9c0c9922a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
>   	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
>   	regs->exit_result |= ret;
> 
> -	return ret;
> +	return regs->exit_result;
>   }
>   #endif
> 
> --
> 2.39.5
> 


