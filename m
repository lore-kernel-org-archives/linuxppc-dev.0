Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CC606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mlAdMQRs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9xmV10kLz2xjh;
	Fri, 23 Oct 2026 19:59:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792745994;
	cv=none; b=bgoHa63aX+pCxZdQhAGhW7nU2MO/hCPGKUaRCKj2TP+kCrej90ct21zHqjkGysuUQ2el7rfN3vxp9+DS4uEliwiUUdO1E3/fkkI6t0xncoPIpXgIkAB6tDWkem25bsR2Dxgkz6lnQapHWYVddE/8PQXigJy4Q4ia4BIik63XandT28dYZ9Vq+lRUX/Jti18Sfv8wOVbDQmB3bY6GAM7jiUl5bvF6ZRzB8wgm1YMR+8n+h79ZX1w6Tgm7S4lznZtQVJs+KSRt9Y0rIhS1Ou4gDU1f/Lk3DA/TVX3Rz6T/RdcP/0ZEFBemdhE7mO+QfWv/khKrbJAXOFRkjHy/GAJAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792745994; c=relaxed/relaxed;
	bh=yCzLlhXTi1kXrYQJEEUdQmgNADRXaefQpeykOcaQ8U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTUzR81eDAR6CGG6KMAaJqo+6RJHU02ACfEepb+KFum9uX25ZveDQaO+1AHubIdMtFsAxwdrXUx5t8WZ0p9ZftqoVZSw49ah7pRD1UDOWQK9+8Tl7NaaEzx040PaRE8MdcGvNg/KTpmcEp3COPtxoqtXngUrmVM/SH14rwMAEHToGkXiicdvSFpUwfnZ3dmtNoiJ3/Mp+4X9xDihu/9u3DL9mnXPem1FZwv4vadUED6pafsqAVq4E1g4knbdMOvU0rUc/V6UxPyTjBHLPji+gjTyNLo8aaq6lbFsMhTUBOcS7Rt8siqnL0zA9jNzHTW/4UVOoXx81gCMsE8XgFnfOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mlAdMQRs; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mlAdMQRs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9xmT0SBGz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 19:59:52 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EfPY2174860;
	Fri, 23 Oct 2026 08:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yCzLlh
	XTi1kXrYQJEEUdQmgNADRXaefQpeykOcaQ8U4=; b=mlAdMQRsLSjWdhvRW9oGPW
	/mUllwYVG/wsfJzEqj8LoZCyIJ94NFdOcgiqDirOGKwLF5dnJFMkZ1R8HDrJTJUG
	jbTG6PUQOhq7T4aKrUE9YtVPXgVOqD/LS+v2PkmT546xaOsTpn90LET6SPpOxNZA
	oCge7lEXF4poRhYTx8LgWXYiwHkFqfqwHEv1ZFaBEFfikiuAPX5LNnEYuPamfcjA
	DHcs909gpEA8f/Dye9idxcZpkxgoE2oFxrjtdmd3gDfEPnbgQZ+tgL9kxU7rIFBs
	la56P0rLkYPFHGuCmD6f9X7jq526OOcz0x/fjpTTiSB96S8JP6sFqE/UZODgpJIQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b3n7s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 08:58:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7JsTw1800643;
	Fri, 23 Oct 2026 08:58:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn3qs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 08:58:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N8wGLe25559722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 08:58:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F06BE58065;
	Fri, 23 Oct 2026 08:58:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B4D25805D;
	Fri, 23 Oct 2026 08:58:11 +0000 (GMT)
Received: from [9.43.58.215] (unknown [9.43.58.215])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 08:58:10 +0000 (GMT)
Message-ID: <49f43f66-f516-413a-9842-bf6d8cef5fb1@linux.ibm.com>
Date: Fri, 23 Oct 2026 14:28:09 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/syscall: Return the preset value of skipped
 syscalls
To: Renzo Davoli <renzo@cs.unibo.it>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Davide Berardi <berardi.dav@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V . Levin" <ldv@strace.io>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20261018151539.440213-1-renzo@cs.unibo.it>
Content-Language: en-US
From: samir <samir@linux.ibm.com>
In-Reply-To: <20261018151539.440213-1-renzo@cs.unibo.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb21aa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=eEX7pEfrkeBYrpkNWPQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: 7c_KEsfJRvV2RRbWgSUimDVVLGvDcsDV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX82UqnYTX5H/L
 deJHTQX2t/n0Y3LnF8Oq5Leo1pjTEmGBCCJunlf4q62yKuGb3louajZNq1ie0x9PDPbAFrdFGY5
 fsYWAyCuM902kl5iDTdTwD6PQ/Q3JwIkQHVozByhhqLSZQF962URulOMrGxqsgtdLpIMFNm7+Ij
 qDQWWCTmuwPKbvSvkuFjo5bGn9Sdg96gnODoczyggcR8t6C1EwsRES62zvmbV/BYhVgcOETQsBJ
 R5kGaSfsXVgpvKjEeW215WFpquC31eSRz8aka/17drd1Zf+9jYssQcNl0TcpZJz6Tu2t5nB+go2
 HoDR842sakrLUWKaKQYhZ5+24HzhShat8aPa/ncFJmcNV34GSwRYCFg+jwsEYbbzewpl8usKLdh
 T07uCRNV3rpPqhzOD+t/go53FWCRgFOmqxlXZmW3WDWJHmgpNdriQqhLWMtQrtaZry87k8mrqou
 psc2ujNrvy8JF/7impg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX7M4ga6yqIN+m
 TqzEpIJCrvrEFfl4K1EBY1hdM7w2v3Myif5lbGlbm/Q8FeDEOKjinkO2hJdlu/pdFAc866MgB0Y
 fKPrmCDmnT91iKZ9dVX8LNIHV+lqo2I=
X-Proofpoint-GUID: LXuJuGUpdlreGuneYA4noi_09wS9zyNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230034
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 18/10/26 8:45 pm, Renzo Davoli wrote:
> From: Davide Berardi <berardi.dav@gmail.com>
>
> When ptrace or seccomp skip a system call, the return value they set in
> regs->gpr[3] gets lost or the tracer is affected, since two recent
> changes:
>
> 1. Commit 05c033db7e9a ("entry, treewide: Make
>     syscall_enter_from_user_mode[_work]() indicate syscall execution")
>     made system_call_exception() return syscall_get_error() for a skipped
>     system call.  syscall_get_error() is 0 for any non-error value, so a
>     success value set by a tracer at a PTRACE_EVENT_SECCOMP stop (e.g.
>     with PTRACE_POKEUSER), or by a SECCOMP_RET_USER_NOTIF listener, is
>     replaced with 0.
>
> 2. Commit 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for
>     seccomp and ptrace") made syscall_set_return_value() set
>     TIF_SYSCALL_RET with set_thread_flag(), i.e. on current rather than on
>     the task passed in.  When the caller is a tracer, as in
>     PTRACE_SET_SYSCALL_INFO with op == PTRACE_SYSCALL_INFO_EXIT, the flag
>     ends up on the tracer, and the next system call of the tracer is
>     silently not executed.  Setting it on the right task would not be
>     enough either: at a syscall-exit stop the flag would then skip the
>     next system call of the tracee.
>
> TIF_SYSCALL_RET is not needed anymore: after the change described in 1.
> the generic entry code tells whether ptrace or seccomp skipped the
> system call, and every in-kernel caller of syscall_set_return_value() on
> the syscall entry path (SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE without a
> tracer, SECCOMP_RET_USER_NOTIF) also makes it return false.  A user
> calling syscall(-1) without tracer or seccomp still gets -ENOSYS.
>
> Remove the flag and return regs->gpr[3] for a skipped system call, as
> done before the conversion to GENERIC_ENTRY.  The syscall exit path
> already converts a negative error value to the "sc" ABI, and
> syscall_set_return_value() keeps CR0.SO in sync for positive error
> values.
>
> Fixes: 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for seccomp and ptrace")
> Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
> Cc: Michal Suchánek <msuchanek@suse.de>
> Cc: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Assisted-by: claude-opus-5-5
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> ---
> How this was found and tested: QEMU pseries (TCG, -cpu power9), ppc64le
> guest config, v7.3-rc6 (7b63ef2d55f2), with a small reproducer
> (ppc_skip_repro.c, available on request) which
>
>   - sets the getpid() return value at a syscall-exit stop with
>     PTRACE_SET_SYSCALL_INFO, then makes a syscall in the tracer;
>   - skips getpid() at a PTRACE_EVENT_SECCOMP stop with PTRACE_POKEUSER
>     (r0 = -1, r3/CR0.SO = return value), with both "sc" and "scv 0".
>
>                                               v7.3-rc6      with this patch
>    tracer syscall after SET_SYSCALL_INFO      returns 0     correct
>    skipped syscall, success value, sc/scv     returns 0     correct
>    skipped syscall, error value, sc/scv       correct       correct
>    selftests/ptrace set_syscall_info test    FAIL          pass
>    selftests/seccomp/seccomp_bpf              11 failures   all pass (*)
>
>    failing in v7.3-rc6: user_notification_{basic,child_pid_ns,
>    sibling_pid_ns,fault_recv,addfd,addfd_rlimit,sync,fifo,wait_killable},
>    TRACE_syscall.seccomp.syscall_faked, plus the timing-only one below.
>
> (*) user_notification_wait_killable_after_reply (100000 notifications
>      with a 1 ms itimer) can hit the 30 s harness timeout under emulation,
>      with and without this patch.
>
> Build-tested with W=1: ppc64le guest config, ppc64_defconfig (BE),
> pmac32_defconfig.
>
>   arch/powerpc/include/asm/syscall.h     |  6 ------
>   arch/powerpc/include/asm/thread_info.h |  1 -
>   arch/powerpc/kernel/syscall.c          | 15 ++++++++-------
>   3 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 32be22b995cc..4b3c52ed6e9d 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -98,12 +98,6 @@ static inline void syscall_set_return_value(struct task_struct *task,
>   			regs->gpr[3] = val;
>   		}
>   	}
> -	/*
> -	 * Mark that a return value has been explicitly set by seccomp or
> -	 * ptrace so that system_call_exception() can skip the syscall
> -	 * unconditionally, even when the user requested syscall(-1).
> -	 */
> -	set_thread_flag(TIF_SYSCALL_RET);
>   }
>   
>   static inline void syscall_get_arguments(struct task_struct *task,
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 1e069a2e7ce8..0487e94d3416 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -120,7 +120,6 @@ void arch_setup_new_exec(void);
>   #endif
>   #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
>   #define TIF_32BIT		20	/* 32 bit binary */
> -#define TIF_SYSCALL_RET		21	/* syscall error value set */
>   
>   /* as above, but as bit values */
>   #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index fbefe1927b10..52ceff4ef41b 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,13 +18,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	long ret;
>   	syscall_fn f;
>   
> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
> -		clear_thread_flag(TIF_SYSCALL_RET);
> -		return syscall_get_error(current, regs);
> -	}
> -
> -	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
> -		return syscall_get_error(current, regs);
> +	/*
> +	 * If ptrace or seccomp decided to skip the syscall, regs->gpr[3] holds
> +	 * the return value they set (or the unmodified first argument, e.g.
> +	 * for PTRACE_SYSEMU). Return it as is, the exit path takes care of
> +	 * the error encoding for the "sc" ABI.
> +	 */
> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
> +		return regs->gpr[3];
>   
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
Hi Renzo,


I tried applying the patches to the latest upstream kernel (master 
branch), but the patch fails to apply with the following errors:

error: patch failed: arch/powerpc/include/asm/syscall.h:98
error: arch/powerpc/include/asm/syscall.h: patch does not apply
error: patch failed: arch/powerpc/kernel/syscall.c:18
error: arch/powerpc/kernel/syscall.c: patch does not apply

The latest commit on the master branch:
commit 734bef548a96e8774d6eef5dfa2026c6edc4e80b
(HEAD -> master, origin/master, origin/HEAD)


Could you please take a look and suggest how to resolve these conflicts? 
Does the patch need to be rebased against the latest upstream kernel?

Thanks for your help.

Best regards,
Samir

