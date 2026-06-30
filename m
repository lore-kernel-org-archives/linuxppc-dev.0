Return-Path: <linuxppc-dev+bounces-23230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D2C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 20:11:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqZ6g6G3Rz2yQL;
	Wed, 01 Jul 2026 06:11:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782850299;
	cv=none; b=EATGxjV2EV5egLdJC+sFSZR0vBfBO1KG5wpuMteurYkpOsauU+S2E93qbHg01LyNRNlk3/Sts/cDSgnkxNB31J9j4KD8UsmmTdDuOu0iCYieyZhMkSsjMzzKhxeIIkNSqIFp37NsSb9o0AVNIG1yxwPReoXc5F7vpKa2ofPf+Dyqgf8nBHA5T8liZSmQBYZ2wdU8JxoUe6zd1VsUtR0FSFkmkd3ABCgQjWZyDGuj66jP3Svt9NPFIxjV8NPTpfOf90T8GGvU4CADceyZFi/33NRyXe1rTRTcVdnumtRUSpJljQUL3xEjeszOsccWqPbRRq+5Qc5Q8ikO+2XhCT8i4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782850299; c=relaxed/relaxed;
	bh=U7JzNiLIyE/JgD98jwmgvcBhE6jjLO9fv3pVszddyEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmJ1B+cRI0cyv2dvZD+0KE74KgrNZx1kUcFF7fRSdwcv1viYBXAz5sE0zQFcSO7UQktWe48woDlRKmhOtddt4iUAy0W3kpejJAxd0gHJ1eo5c+lugeCOnAGraTPmeBjcEUALXV8j/4uSnl3GRxMONPZMHHARlgib3cAa3i7gMbOL+v+Bf1zb+soThPpP7tBdGZFRcfiHWd6UhTOCwjZ4Eb0edq0kFo2oDFcK5dOmj9SbKJrQDK+SbOe2xaX7TgwVpRbzCq2ZyEXgN4cMxBq6POUx/o6sIhv588o4/eip9jSoIP6flhG5pPQc3/eZFMHOlq92PKV/WGvB+rkBfxZQJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h/P3Wviz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h/P3Wviz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqZ6f3MhBz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 06:11:37 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJIDhv3094868;
	Tue, 30 Jun 2026 20:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U7JzNi
	LIyE/JgD98jwmgvcBhE6jjLO9fv3pVszddyEI=; b=h/P3WvizkFwHsLvJPnfk3k
	ZJ718ul+g4obXRNaM872GGdmB16osR+nEpGIw9KAZxnn2lzA+9mHT91zbWdo/UFZ
	98TnzdCofhw/366TIAvZSKdz2VeT85aQ18UhWyNGw41u3hcFeUN0kGkUdHhGVHA5
	VpSgiw/lo3aNXtNUnDLetXl1x52iCc3Dmcwsb6IXVcIartSg25xYkZNmEEc0VK9+
	n97L/9Fowp25cOvnCsvLAmf2CvosQW3wj0KKVQCL8HuEemAa96BJYUNIZ+jpAOos
	WT7b3+cvh9aQt8byn3hN38klVNiR4Zb8vd0taiy4GpqhlFG6gaumawJxkSZC4KRg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg0vpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 20:11:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UK4a87025286;
	Tue, 30 Jun 2026 20:11:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w45rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 20:11:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UKBFxd13566400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 20:11:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 932A020043;
	Tue, 30 Jun 2026 20:11:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F6620040;
	Tue, 30 Jun 2026 20:11:10 +0000 (GMT)
Received: from [9.67.187.59] (unknown [9.67.187.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 20:11:10 +0000 (GMT)
Message-ID: <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>
Date: Wed, 1 Jul 2026 01:41:09 +0530
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
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        mkchauras@linux.ibm.com, ryan.roberts@arm.com, ruanjinjie@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
References: <20260629182946.419552-1-mkchauras@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260629182946.419552-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4422e9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=hz_0QarC9vV6fVt_2poA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5MSBTYWx0ZWRfX9ZMTHgauCDug
 llcwQ/2M8ARzzrXhao6x1XPT7dbgadTgeCq3QQzreKP0cee+2QbmfOjJ9KvzDbIZv2nOhhLetJ/
 4tVE59Wvk202LdThm3Mr/fudo/MPaM4=
X-Proofpoint-GUID: bpXhYkIQkDC4c_BIb7Ybam2vQQLP8ebn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5MSBTYWx0ZWRfX7hI+lvX7jBmU
 qEOXWRZyMpY606XaaA0Mv2D9jEtdc6AOs15uPxnqdxR4nJ6Gr/PDElLKfVrzhftT38DFo7Z1yCn
 S6M3MJB+J5vf8IVXN9NlTbGNOcO7adJn031/nyB3lb3F2YPn8F+2n6sZ8C/CYcqdKwwatNv5sNj
 s2fFHKZ3Fo2GZBPpbJI6XMqmRKmcNObnNnE7BEeC8qoQECKyr5fG+aicmk/CXz3YMfLaA4wKDg1
 1I+uqJHuLpuy7UwwQlRCOUrTH86s8lRqA3U55h7iiJVNgtKXPfH5qk0uQEGgohPYqhf0w445sBQ
 qfFCtI2HZGMlHT+i39bEWUy6LjOhVcAEHsSjrxkvvOIkmoN/4Cy0x3rJEfU4l86pcIRNexXsyDL
 F902UtCOhSqRlNw2DsR+4ff+wtB4zSDmCDHQZ84m0D6TOKHk0Z+dfq5x2fHd000NRIrfhdrvA1l
 5qA+NZASux0N6beDyiA==
X-Proofpoint-ORIG-GUID: 3ugxaWuliT9y4GqpnALEexoj-n8YEcTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300191

Hi Mukesh.

On 6/29/26 11:59 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> (Function not implemented) instead of the expected EPERM (Operation
> not permitted).
> 
> The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> The current code treats this -1 as a syscall number and compares it against
> NR_syscalls. Since -1 is greater than NR_syscalls,
> the code incorrectly returns -ENOSYS, overwriting the errno that seccomp
> already set via syscall_set_return_value().
> 
> The generic entry code in syscall_trace_enter() calls __secure_computing(),
> which sets the appropriate errno in regs->gpr[3] and returns -1 to signal
> that the syscall should be skipped. However, the PowerPC syscall handler
> was not checking for this -1 return value before validating the syscall
> number.
> 
> Fix this by explicitly checking if syscall_enter_from_user_mode() returns
> -1 and returning the value already set in regs->gpr[3] (the errno from
> seccomp) before performing the syscall number validation.
> 
> Also Move the syscall_enter_from_user_mode() call and the seccomp/ptrace
> skip check to after the NR_syscalls bounds check.
> 
> When syscall -1 was passed, the r0 == -1L check would trigger before
> the NR_syscalls check, causing syscall_get_error() to return 0 instead
> of -ENOSYS. This resulted in a silent success (ret=0, errno=0) instead
> of the expected ENOSYS error.
> 
> By moving syscall_enter_from_user_mode() after the bounds check, an
> initial syscall number of -1 is correctly rejected with -ENOSYS first.
> The seccomp/ptrace skip path still works correctly for valid syscall
> numbers that get overridden to -1 by seccomp or ptrace.
> 
> This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> and restores correct seccomp errno handling.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> 
> v1 -> v2:
>   - Fix issues in the previous fix (Michal)
> v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> 
>   arch/powerpc/kernel/syscall.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index a9da2af6efa8..36d73933a311 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	syscall_fn f;
>   
>   	add_random_kstack_offset();
> -	r0 = syscall_enter_from_user_mode(regs, r0);
>   
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
> @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   		return -ENOSYS;
>   	}
>   
> +	r0 = syscall_enter_from_user_mode(regs, r0);
> +

I see many arch first do syscall_enter_from_user_mode and then check for return value.
take x86 for example,

__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
{
         nr = syscall_enter_from_user_mode(regs, nr);

         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
                 /* Invalid system call, but still a system call. */
                 regs->ax = __x64_sys_ni_syscall(regs);
         }

}

So seccomp fails silently there if initial nr was -1?



> +	/* Seccomp or ptrace may have set return value, skip syscall */
> +	if (unlikely(r0 == -1L))
> +		return syscall_get_error(current, regs);
> +
>   	/* May be faster to do array_index_nospec? */
>   	barrier_nospec();
>   

Code per se, looks okay to me.

