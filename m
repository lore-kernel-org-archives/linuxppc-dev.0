Return-Path: <linuxppc-dev+bounces-29371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DEECC6B08
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:06:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3x2v0Jt2z3brM;
	Wed, 14 Oct 2026 01:06:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791900390;
	cv=none; b=iciUVUNVNY5IsihRR2nVYwmOenhFWnLChUelr6FQe4fpFhGl7pisSu1tM2r+2An/Qe0/XZFsRA6dlcMVgpV9YCMcbyGlbbu+nqI5P3HT0Z/x0RFf6U1xJjtNrav9I3K1tFMkna0s+VgmFPQoki3gLmjNzjSi5BipblCLfv9wpPsoklWzLgH+87gHQjvJekwF1YDDxGvSLxHDbm+7tQ1qK4DsPnVsFL6V4mSCyxhDL3hwX2jESZ4fn7eQUwWvC0jH6BSDbxxZZMjR3q5BJNO12VnPf4VTnz3tMahYtVdWsLDQYm6iWzBqQlPUcd/Tdiw4qAf0Qc+ucWIJxD1sNURFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791900390; c=relaxed/relaxed;
	bh=hpV0oBLYfR9w5tt8LD6PbIXwQcysgHeuIBGRHU/cV1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duRJisBrzGX5PzxJ9HrIWBKuBB8xTWvP3+/ox0Brrhr1U0fvAbbAmZXu1RjjeX4DDw+s/MA9DOnTErDWaTFk0yeTxUFLQ4QrkfEZRHMohTmwOijIVjEtWT4U4azggLj3ClII/17krWatwerwagoRIUBnAQDNW70dOPHgGGSdP93AAYemdrG3FiFoQliogHO9IcqJecpo2875TpejunkkNXxRg4r/wbbpV3EamSWPz9W/CQARD9SJU6JN3r2UD8wM4DfADBMBbETJzOmwB7Ha1YSvFSMuCoUY+E5GHpb9fqVe95Lsl3YIc7gWbCE79Z4WUI3Ul3rJJufMVbXoGEw3YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fwkJNc6T; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fwkJNc6T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3x2s6645z3brH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 01:06:29 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE6D69727508;
	Tue, 13 Oct 2026 14:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hpV0oB
	LYfR9w5tt8LD6PbIXwQcysgHeuIBGRHU/cV1U=; b=fwkJNc6TxtLt5PhSlaDlGm
	3rCbJVb4rkIOsCtjsTomQ9HhSl/S5Ugt9IB8hics6Y8opA7RO1LHmtg1P+JyQNIG
	jZQYN9htferTgdCH3U7SZcDI7bGyjzFwEGBa59dWpPwi40xM0hX2HkMJa7QYYieF
	tDZWmapmwyqudUZg0rq+yPt4QsFbiN5WC+YoXCBS01yLZK4Oy+Mv8R5K3qM02JSw
	q5gNI71pd1Ze+8n3EwVYQ3UEdlSXXyaN9tpeHltBdLTVyecgInr9pmgZuhaU2jZd
	9XDeMOgKv3aCRiSqmDmuLYoLCKadbvBdxql0pMlx3MfFaDoUU+G34maSItT5+KAw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0e4yq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:06:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCU3mv2709266;
	Tue, 13 Oct 2026 14:06:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h25b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:06:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DE6Aod39911860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 14:06:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AFEF2004B;
	Tue, 13 Oct 2026 14:06:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 089EF20043;
	Tue, 13 Oct 2026 14:06:06 +0000 (GMT)
Received: from [9.39.27.235] (unknown [9.39.27.235])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 14:06:05 +0000 (GMT)
Message-ID: <02d5751b-f987-495e-85f9-25e8f2f2f2a8@linux.ibm.com>
Date: Tue, 13 Oct 2026 19:36:04 +0530
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
Subject: Re: [PATCH 2/2] powerpc: Remove unused thread info flags
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
        linux-kernel@vger.kernel.org
References: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
 <dcbd135c06fcf013b8aa902fbea8f6b1827d06c2.1791826411.git.msuchanek@suse.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <dcbd135c06fcf013b8aa902fbea8f6b1827d06c2.1791826411.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX5xGyK3KRpR9G
 nZk6PNoTjJPtOSipX9QIkFqWT4Kzr/lu4Ruy3kQs8PesnJavWqqbTKuqsng7Vq1ZMUHPyrRrMUb
 y11DOA3fHZDP1bzaMtQ0yX5K5Jn74TQN/ZVR0QdaDn755ImGcU7Vgv+AutKpjBk7+5HhU7XP7mj
 kGAN1vUzgjl1oB9+ACTgIFo6w6LBh0MmzIvwWZ9On9MivU41o67q7f1tVKaWSDlsXmDvkkM9wS0
 n+pYkaH0U3TgE2Sf/MNXhwkmTbvSKHSQjfuFuFIV8ZshXy2ZofRWOI8eZNWsql6uFtqD2CTaXLH
 V7OFlm1B1i5iwIIBYwJUZx6+BMQmQ/O7cQmfqTUU8b1X2gHiXpLNv4HF6UiWOnhtsJhjLdAByuJ
 /fYX4GXmEi1L0KAtLKVfwlb50WtQnhKPXd5ZbtYjYdoZJwwUIETgQvMHpxmTcyrl8b4xdBjRA31
 DgprNA0IopcUsJv9vLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX07+WsaBsSDxB
 86mYORCJ5ihPGV7M/iGEUMFuWNR9QpK32/iW5vbC2sAy59OLCDes4D1MFDVCvdlQzA23dVVUfIt
 ADHKgO28fxtUC3g+kB8f/ql8uMynqz4=
X-Proofpoint-ORIG-GUID: VpOg8SRHvyyT4Xw3ZTBnf6c-PvXJ44zQ
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace3ad7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=3CTQAW-Yv6UIpP-Ww4QA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: wuCxv0nbDO1oP1o3Q3PuR45LgLvPOT88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130054



On 10/12/26 11:08 PM, Michal Suchanek wrote:
> These are no longer used with the generic entry code
> 
> Fixes: 6ed60999d33d4 ("powerpc: Remove unused functions")
> Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>   arch/powerpc/include/asm/thread_info.h | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 0e8dc71c8d3fe..4b7ec1db30349 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -96,22 +96,17 @@ void arch_setup_new_exec(void);
>   /*
>    * thread information flag bit numbers
>    */
> -#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
>   #define TIF_SIGPENDING		1	/* signal pending */
>   #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
>   #define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
> -#define TIF_SYSCALL_EMU		4	/* syscall emulation active */
>   #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
>   #define TIF_PATCH_PENDING	6	/* pending live patching update */
> -#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>   #define TIF_SINGLESTEP		8	/* singlestepping active */
>   #define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
> -#define TIF_SECCOMP		10	/* secure computing */
>   #define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
>   #define TIF_NOERROR		12	/* Force successful syscall return */
>   #define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
>   #define TIF_UPROBE		14	/* breakpointed or single-stepping */
> -#define TIF_SYSCALL_TRACEPOINT	15	/* syscall tracepoint instrumentation */
>   #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
>   						for stack store? */
>   #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
> @@ -123,7 +118,6 @@ void arch_setup_new_exec(void);
>   #define TIF_SYSCALL_RET		21	/* syscall error value set */
>   
>   /* as above, but as bit values */
> -#define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
>   #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
>   #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
>   #define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
> @@ -132,16 +126,12 @@ void arch_setup_new_exec(void);
>   #define _TIF_32BIT		(1<<TIF_32BIT)
>   #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
>   #define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
> -#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
>   #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
> -#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
>   #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
>   #define _TIF_NOERROR		(1<<TIF_NOERROR)
>   #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
>   #define _TIF_UPROBE		(1<<TIF_UPROBE)
> -#define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
>   #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
> -#define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
>   
>   #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>   				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \

Thanks for the cleanup. It maybe possible to re-org the TIF flags. But that is
out of scope here.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

