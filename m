Return-Path: <linuxppc-dev+bounces-20244-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1D3FF8868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 15:30:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4krv66ykz2xld;
	Wed, 29 Apr 2026 01:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777390207;
	cv=none; b=EJh2ydGVzwvnL2Vs2ZB2mKZa97yQLGIEbAvpfHC31sD4iX8zwols6bHPP2TG20vnEykCdX2KD8b2Ik2JPVoK04ceSLLRsioDyIjjHiwFEYjFmb2j40yQ99l0UINs/609zw2q4ccBulLdOFTyQMO6w5fb/2DkfKcB0zpYn/LlZhL1xEWxojtGvsKOjYSjJU1N9VtwrwBrFJdGI4aWLd7Sb8p0d3nZBqYVdiGun1csq0U8MCy27vWQuKmqcur7ROS5/Nk9d1b9MS82Rp0wRsNMhvs/ZVr44r1wUfFTdxoOMiYX2d742MNKwLVdTXaYAbE/RABTE2FdCHsp876B0Cna6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777390207; c=relaxed/relaxed;
	bh=YwP493ILC63v3+UTyJCc1eyOdyX+yQa9BtJobhiIseo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgerA3qk+cYvitHIC1/LajS4HNwE0OZVLdyCQ9RObTGS/6DsU8Zg63kxVw4mWRUzUEEZh5qkeL8RASR1w4DMNro/jNy7jLPu7vo8sSLr93u9/FBugz0+SzRkcAPp3sjDfI6wCWgAMn7qYDc9ZPo8lSZsmlgG15Fm+qR0uvb+aCUtuCWrDFI7AW6aEeKfK8AYQjA3bxt8YYSNQzOfwMxyutuNCqvSnCVVV3q026pC072wY0MjtjoHA+JOnB3g+eVYWEomEUbQGtJMzhSUMsHJxowPIJkTrUtqqE2jdc0lpNxPPFIqP0oTYsfam3ae0f3HGO3OpvgFL5PUH4vGgZZqQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PsdWffEK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PsdWffEK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4krt3YFXz2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 01:30:05 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6bkhe2999657;
	Tue, 28 Apr 2026 15:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YwP493
	ILC63v3+UTyJCc1eyOdyX+yQa9BtJobhiIseo=; b=PsdWffEK1/ENih1fDvZINM
	yXmTufIwIZ1g32nDNONaa2cF1DcBuvIwuv5IXeBIUQ1g8xM0oBwC3sEM9CeqIxl4
	NfZubhzYoVxvA6WyZbRXsyKM/z3Lww/ZdaGN9nriInLbSi9//3w03AbZAYTIzuk+
	+rSFHBPhFIjKLiUmmYb/WprKiF032NMfVTVHj9jhMu9v8tJ9CK5XvdAuE8r53U/4
	LfXc1AWajPOXdwj/dTruXO09KLBmcmITV2sa6+pFZTNRiWGC3iAvbcDaFwxDCxKM
	0cNBeLwy6NQR8Hs9UpBcF+t5TY2Nwb1UHQg4JcxtxGg/a6AdHpFSV1l4OFfb+rrQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb568nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:29:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFNo3i003786;
	Tue, 28 Apr 2026 15:29:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk2aa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:29:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFTiwr34996666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:29:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8760A2004B;
	Tue, 28 Apr 2026 15:29:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3531C20049;
	Tue, 28 Apr 2026 15:29:41 +0000 (GMT)
Received: from [9.39.16.179] (unknown [9.39.16.179])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:29:40 +0000 (GMT)
Message-ID: <7d3bbb94-575f-4119-9ef0-62cff98795ce@linux.ibm.com>
Date: Tue, 28 Apr 2026 20:59:39 +0530
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
Subject: Re: [PATCH v3 1/5] powerpc/bpf: fix alignment of long branch
 trampoline address
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260411221413.44304-1-adubey@linux.ibm.com>
 <20260411221413.44304-2-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260411221413.44304-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0d26d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=atBhxT8-om9CWOQYYk4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE0NSBTYWx0ZWRfX6u62VQKvlfki
 LSaFxCoPf2J8cLw+nHlZFUbhVJaq8DqhSKIv/sQouhuHaBomuEvBfYz8471q1qU7EnzCDne6YS2
 1NB1mbKMWUzaqo9HQvwfxNc/VbzEvN60xHP6EyfRV/NO+ZSoUWxU2FazOh4mn1DCzk8YkWQJ18C
 5sPyAR4xqOTOsQUbKxb2EtRWRlpchoNfnW5Bmm+YyYf9XcsZ/OmSlWOY70l8PIcXwtb+B6ypxIl
 vpgjlIAKj4vxxgXYkLe/Dmz3JsjqoLtW65sBQ19HMMHI8U70MUJOo+SXdO67GEA4a17ieHAqZjX
 g8H3LJ3cwizp9wH0udoBX/Jakb9kWrvF/pu57mcJol/Wfiqf4BwVU3PJFbj5MhKOW5ZzLQYlagz
 GQn9nZfpH3U08yAJIq8ndVMd7fgAXmWLDFXSVV7pH/qwEryW0HjkGKZypgLRlSQKqtipJP/OlAh
 cCcs0qizQnBy66hXZqQ==
X-Proofpoint-GUID: eAdXJj8nsRIqvr-NYA3wcRltfAJUWR6v
X-Proofpoint-ORIG-GUID: eAdXJj8nsRIqvr-NYA3wcRltfAJUWR6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280145



On 12/04/26 3:44 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Ensure the dummy trampoline address field present between the OOL stub
> and the long branch stub is 8-byte aligned, for memory compatibility
> when content loaded to a register.
> 
> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        |  4 ++--
>   arch/powerpc/net/bpf_jit_comp.c   | 34 ++++++++++++++++++++++++++-----
>   arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
>   3 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 7354e1d72f79..1184ad15d5a4 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -208,8 +208,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
>   		       u32 *addrs, int pass, bool extra_pass);
>   void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index a62a9a92b7b5..c255b30a37b0 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,34 @@ asm (
>   "	.popsection				;"
>   );
>   
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	int ool_stub_idx, long_branch_stub_idx;
>   
>   	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * Need alignment NOP in following conditions:
> +	 *

I don't think I follow this table..

> +	 * OOL stub aligned	CONFIG_PPC_FTRACE_OUT_OF_LINE	Alignment NOP
> +	 *      Y                               Y                     N

> +	 *      Y                               N                     Y

Please help me understand why a NOP is needed here

> +	 *      N                               Y                     Y

> +	 *      N                               N                     N

and also, why a NOP isn't needed here..

- Hari

