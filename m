Return-Path: <linuxppc-dev+bounces-28480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7712ECA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 09:50:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvD1y4R1Lz2yft;
	Tue, 29 Sep 2026 19:50:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790675430;
	cv=none; b=je2uwZwQ9K2C+CJ1vavyt6Q5fKoXQqc5rZL1FK8GN3lxWWFAj15X66H+iysQxXchFLWA3+nt1YiqIma4Fc4k0OM7PnaS/fXm8xXq/yf7d2rbkygYXmD2A730YllgtCvb/u3PypYuw0N0F+Gqku5IAerkmh86KpUir0xehFzw5wJDtwCuFa9QuIPAYcZtK+p41GR6E6c2eXwAj8cP4S2KLTqPuiAfdYmr9i2H7ilkt5pT0EMeW8gOVXewADaIq8Jt53y+JZOw6UfM6bEHkWzSUr/42O0q0al639z7Kf40Ej125WRiXyhdmHfFINdbhM4L+OGz04ejCHJZvEH/1jnlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790675430; c=relaxed/relaxed;
	bh=rYjtN/7M8CDVNcpydFEayQy8ObAUd4kYCP3/y6ccfv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SgvZwC9skaw7Z9dJcPLLe8xxWhnpBJ3/do5fNhOjBc/1yIkDpyi4+vwSrFUhCPIQO+5hgy0YZiUXyv061h3rV0TCGkjRZgPO6G5P4WPe2U8QdlSkAV5Cnvc7MDFGa0RsSQJpVsB8Gshbi1v33e97m8EzAbMcT5FiRAu3Gma+CpwK2CEyjmYxuvFZI17FYt5loqYXoO6tHvBB8fcjTkZ73opAbCvPeQVXm5yg+1SU5QobW8A5ElT96EPW7bkmn7txI0/uW/6bbDIqvV/6MWTzucWIfF4Rr6f3ljpXggA3rdkqSzxom13908Sd5Wykn7wOSnKR5rmvm8og5mBV1sATUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P2p7oVUX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P2p7oVUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvD1w4LJDz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 19:50:27 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7a5US3526058;
	Tue, 29 Sep 2026 09:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rYjtN/
	7M8CDVNcpydFEayQy8ObAUd4kYCP3/y6ccfv8=; b=P2p7oVUXshROjgt53T41vW
	/cT/aYTfgl/Rj8/2Zd52NfUvMn0akofBwKbLuKXr/s5XSpc+h8FXx6pJjKZvVGD8
	jn3jc/ddC4C1veDzOTqJkDUanPUDF+3GBiUadzmMJxUNH0pv3nCCc3/Ugr0aqkGI
	+G0HNZwS9N4lWuE92jcianaR3j8fX8vEm/s21i0z80vSYyElZRCn6oYv/+D0QLPc
	jf+Kz3gCw7N6lkSWScr1TKfQfPK+ocDVhSi81aaJtKzrm32akUbIsgnj7i4EpVKt
	1LLZvtYURabLWmmsRBwpXcQkRsmzhPVVwZH9GqDKh5gBmT77uuzgIobuTZz0GWfg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt5km3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 09:50:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7WSVt1399779;
	Tue, 29 Sep 2026 09:50:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpsanf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 09:50:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T9o5c550201084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 09:50:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C414820040;
	Tue, 29 Sep 2026 09:50:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5D5920043;
	Tue, 29 Sep 2026 09:50:02 +0000 (GMT)
Received: from [9.124.214.246] (unknown [9.124.214.246])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 09:50:02 +0000 (GMT)
Message-ID: <84ceaa9a-79fb-4585-a571-7701750df5d1@linux.ibm.com>
Date: Tue, 29 Sep 2026 15:20:01 +0530
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
Subject: Re: [PATCH] powerpc/syscall: Avoid atomic test_and_clear_thread_flag
 on fast path
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
References: <20260929071744.2965058-1-mkchauras@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, ruanjinjie@huawei.com,
        tglx@kernel.org, mkchauras@linux.ibm.com, ryan.roberts@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260929071744.2965058-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ApzzVTlDQYCq2Y4V7Qkg3bkhsNJCRGJA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX8FAb0KGCzep8
 /eN1AM6bc65HWTWqsS2ucTj7hxu/C2l60Im4LSKrUi6bwQh/ublUCp1iLWm5Yn6PlAIN/JSjuwB
 xa0VHUmaEhxYKu9xvKKaT73PL8xDcmvDPm3DXGvPvZqn6hNNRzHgARpTCfars9FF8NhVchOOwdR
 v1U6ViBKfnLftZnr/oILHBDjcj6Bx+JDlRYLzNk55TAYvqEMgJNkzM7p6NC+GCNPepFQM4KVDh1
 z0ZM0CE6mRM/u2w6HwT1azffjeroGHTSzwVn5xkWvmrdLopno7qcz5qJ/xTJNpH4+PqsazrQm+H
 kpJfYh2D9KubeMDtdC/XDSRhtPOoaD60k6ZxYbgnFK75V7yUnXNWsFX+MC18M3DdDfha08nba1a
 oJVscSeYMsMieCm3Q08dMkFFABREciSr4d/UZ+2AEQ24OnIvtlyFvE8F1MwHuwuheaNcH0VONJW
 XxuY9gitZno0xVSO50w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX+05Um9/R7ZxZ
 w9opcbTGycOOVIwHfpG7msuyZMI9kWxssNa74ExOK/EDfEGKBIXSQQvV/tSxH8HJwJpuSOPsHXb
 zM437IKf51xSsr4BECmUpL7F6KRpuXo=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abb89d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=qzsYSUR3fVkzKN2XlXMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rkyr3gYrpHDPGkwfuuWFew15Jg18iSqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290038



On 9/29/26 12:47 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> In system_call_exception(), test_and_clear_thread_flag(TIF_SYSCALL_RET)
> performs an atomic bit test-and-clear operation on every system call entry.
> This introduces an unnecessary performance regression on the syscall fast
> path.
> 

Do you have numbers?

> Combine the TIF_SYSCALL_RET check with the unlikely error condition from
> syscall_enter_from_user_mode_randomize_stack() using non-atomic
> test_thread_flag(). If the flag is set or entry failed, only then clear the
> flag via clear_thread_flag() and return the error value.
> 

It probably needs a fixes tag.

> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>   arch/powerpc/kernel/syscall.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index fbefe1927b10..8529827d697f 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,14 +18,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	long ret;
>   	syscall_fn f;
>   
> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
> +			test_thread_flag(TIF_SYSCALL_RET))) {
>   		clear_thread_flag(TIF_SYSCALL_RET);
>   		return syscall_get_error(current, regs);
>   	}
>   
> -	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))

I am bit surprised that test_and_clear_bit does
atomic operations even when bit is not set.

> -		return syscall_get_error(current, regs);
> -
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
>   			/* Unsupported scv vector */


