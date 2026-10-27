Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1973606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IOB1Ba6R
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDXj11cFVz2ySC;
	Wed, 28 Oct 2026 01:20:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793110853;
	cv=none; b=jiVzaX8nVew3ekh6cHxsYVmOmtruHCBi3ummkgrsVesJHnBUA8q+qkP68zgGE1BdWUuZbfysCpJ11849sapbGBTU57Lu2wrNXUH12Fsfv5kG0JYHSneMBicQffrO+DNA003NuxWwu797xEFGvMbH5cpdrIcbwL9M6+HOvbqeb2jKaOtF/itQSNz/o/ppmGMioLozzxUL4Y+jAEeM0jW+5fOGbDoFeVDwbjzgW490wWq6K2zSRfVNV+Cz3TsybSckYXB69ISy8sERBTkvVzvEqcntMzNEn+NkPOdBfW4e8qSbgb+1NJ18K5CDuijh6NXvBQQOsPRED5fsNhovAVh96A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793110853; c=relaxed/relaxed;
	bh=oUdS14YPt4BdJgef939ru4BfL0jVHRie6PnlhVGCr2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6658NNNWEBDpdlmtrRrjEqvn8ikxdj51xJs+srP+p+XJTAIpgYLTsUW2KWz7Q5+s+x0zbyIhUGFvquGtJ3dDh18H3qI6b5EetObx8Lslnm5VS5g52jqwgo6D2Y8vLuaVx8uGzbbsSHvYkvX3ElcdsxCzUXqvui8FdF0STz9nWmczuhV+2gy1ZQ3sRxrhFE6euXqTmM0KKoH1Ld0VduIFYKzXs0T5ttNcokzsHry9KyUNDBakri8cFKalpulH4WJnHLIbANVmx+FtJXctWhReK4AgDF5evAHrXT62u96RihSw1b8uGdwYBe/VMUVaufY6zZrkisMNepZjrIfr9ZXyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IOB1Ba6R; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IOB1Ba6R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDXhy4Bwvz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 01:20:50 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REE8Be2676136;
	Tue, 27 Oct 2026 14:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oUdS14
	YPt4BdJgef939ru4BfL0jVHRie6PnlhVGCr2Q=; b=IOB1Ba6RrozCu40G6UA/T0
	nayyOs24IBFmux3Tfu468WO/1NOQRYwYVXbV2cJa+ccn8ASCylyaBl8wF6XigA/6
	DDdMhYVna4wtWDJCZ6LhKUIfs09ZpHNDhguUEC4/22F3pS0mE8fdEfqSjYC0Nv+H
	cVKmmhL3oU2HAi86bMiIrEjwTFx9VtBBTBptJ8T8nVrJbc2ORrZxQX0Zytq/T7H7
	S+ZEqNGBE15TKTxqJDwFfiFOdm0jBRl50666BNstjC/8OoA2EKwGYpQxugkrOmUb
	eSmcqd2tQD+ZC5r9/1pt0NtOEQZEe6SLh9JN24BycgPKtdIgi43sbiXgeBHWBGaA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6yvj4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:20:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoilc053900;
	Tue, 27 Oct 2026 14:20:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7rxdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:20:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REKWCE3081082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:20:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208F75805D;
	Tue, 27 Oct 2026 14:20:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E36A58059;
	Tue, 27 Oct 2026 14:20:26 +0000 (GMT)
Received: from [9.43.47.205] (unknown [9.43.47.205])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:20:26 +0000 (GMT)
Message-ID: <dea34b37-5042-48eb-a2c1-dcad02c27ff1@linux.ibm.com>
Date: Tue, 27 Oct 2026 19:50:24 +0530
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
Subject: Re: [PATCH v2 1/1] powerpc/syscall: Return the preset value of
 skipped syscalls
To: Renzo Davoli <renzo@cs.unibo.it>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
 <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V . Levin" <ldv@strace.io>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20261023180735.853655-1-renzo@cs.unibo.it>
Content-Language: en-US
From: samir <samir@linux.ibm.com>
In-Reply-To: <20261023180735.853655-1-renzo@cs.unibo.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae0b332 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=eEX7pEfrkeBYrpkNWPQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX+8czidmzCzAh
 1MtXnVnGZSjwOWB+4JJ9pWGmMp0JMocffuEZ4iS31JMOx5tmRBBc3QtNaBkfTsVDIhChTogvO9n
 uoKiJ1NE6gGsNXNJlX04g2/ctk1tZoPKyOHBp4rkvFm026cgT7O6BwhhiK3XINgvpx9PgJSHjER
 LRGLCtUedntGNhdKc28xfVRkDU9q7WTyZCdBj45e23K2zzLCxO/GUlHmZpyMVhuDZTY54FKoqIz
 a9wUuXGgciaB8FouE424q0I4/Uf8RPVp1+yoR9XqdTGGkM1/OZUXMErNDTAnX4CNeafCDPbp5zi
 HncXEq0kqxe5FFYw5SMkhHKk0n230FWWjOVo1lls/T36eaeccKeSIhAt4XnrU/evj3Q1tk7LDSf
 +YuAEVAdsd/BJNxVJhxppEwKXe7y4AlWEY0bNVHN+psTJRBgY30vgpjo+b79g8cLGVpZd1pEeSe
 RGTdk+xC7ern0carQdg==
X-Proofpoint-GUID: DwCJb8PrXwCdqs1qRQKqnQlkhPwgbIYU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX3cqzXvjVE+6K
 /AFQOlRU67M2jbPA3d7r8b7tzeCLUHzMM71EM5FdPnF5sO5YWe5ES7olKsrxFY3vq+xP+T/2LuA
 Y6laH6tV53LfcPjaJ0PpEzi/PU7Rl0c=
X-Proofpoint-ORIG-GUID: 4puvieYEX3Oig-MNcNG2MXV5dvxczR9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 23/10/26 11:37 pm, Renzo Davoli wrote:
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
> Cc: stable@vger.kernel.org # v7.3
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
> Changes in v2:
> - Rebased on current mainline (734bef548a96), which now contains
>    commit 66236558dfac ("powerpc/syscall: Avoid atomic
>    test_and_clear_thread_flag on fast path").  That commit folded the
>    TIF_SYSCALL_RET check into the skip condition, so the v1 hunk in
>    system_call_exception() no longer applied.  The resulting code is the
>    same as with v1.
> - Link to v1:
>    https://lore.kernel.org/lkml/20261018151539.440213-1-renzo@cs.unibo.it
>
>   arch/powerpc/include/asm/syscall.h     |  6 ------
>   arch/powerpc/include/asm/thread_info.h |  1 -
>   arch/powerpc/kernel/syscall.c          | 13 ++++++++-----
>   3 files changed, 8 insertions(+), 12 deletions(-)
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
> index 8529827d697f..52ceff4ef41b 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,11 +18,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	long ret;
>   	syscall_fn f;
>   
> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
> -			test_thread_flag(TIF_SYSCALL_RET))) {
> -		clear_thread_flag(TIF_SYSCALL_RET);
> -		return syscall_get_error(current, regs);
> -	}
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

I have verified the patch against the latest upstream Linux kernel and 
ran the PowerPC selftests. No issues were observed after applying the patch.

Test Results:

  * Without the patch: The "ptrace-syscall" test from
    "selftests/powerpc" fails.
  * With the patch: The "ptrace-syscall" test passes successfully.


Steps to Verify:
1. Clone the latest upstream Linux kernel and apply the patch.
2. Build the PowerPC selftests:
"cd tools/testing/selftests/powerpc"
"make -k"

Run the PowerPC selftests:
"cd tools/testing/selftests"
"make -C powerpc run_tests"


The patch resolves the observed test failure.
Thank you for the fix!

Regards,
Samir

