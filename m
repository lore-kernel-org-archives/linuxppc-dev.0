Return-Path: <linuxppc-dev+bounces-27561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5CAC88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 10:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlrzS365dz2y8G;
	Thu, 17 Sep 2026 20:07:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789639668;
	cv=none; b=AumxetsKgDJJQszGfeSXeqBVSnfZ3mROSVpcLDYX38ZAxBAOS2nuyuCHs4Hs5aOLgNTPH9TOsmTT6825nmCIwYxXdTCc2HSfgy7u4jFUStygoOXAq8BlP+iHxkYYxxUu3QmfaD3izY+9IizRxDVI5R7uTgeCAs7z17hxr3TXJUwEXyBAToDeCZFEgCGFPRCoyfrGa2Om/VjWzpqt0eKxe4vBzniQIEUFq5ZJdDNeILUMOSnI+gJKEYfPAF64oo7gRb8ikraKQtuen+d4bDL+o+APbfmfGarLSqVAgpVBc41x85X9zGoJOrzvzVpNIMWZVW0whHglIy0KEE8opy4g/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789639668; c=relaxed/relaxed;
	bh=qBJsTOu/IPPT3dbucX75kl/0dlD/Hyi3Sla1hCQGEfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfX1Z3wtNYttBscml90fMhMxVKxw2XBvr1p+dNK9iUdIEW4oss+luykPWEyRHuCytOt+GW1c1eBz2HdA/zdkgEGeDjtTituaCLawxJehVmKydme2Xy7GzALHN5XVvOH11wwjZjV4MByekViitpqocAH8GAiqnN6qJO7XMhwEfDkIctCn7egxg2KE8ctxedUsrIo1UEZ5K986LtmigQpFg2+CA4UMYf34QzqoVnZbS4m+saA58TcP+2TAXng7ERhQGT5LzPi/8iSvTKK+xBr28/WuqGh9ULj8/8Buulgbzk4F12L9y1wURsmQfnhdNF4mkwXunTm0S4hzbAd0Xp3KYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PG0voMdz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PG0voMdz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlrzR2dRdz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 20:07:46 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1ZKX2191648;
	Thu, 17 Sep 2026 10:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qBJsTO
	u/IPPT3dbucX75kl/0dlD/Hyi3Sla1hCQGEfc=; b=PG0voMdz7wIsnlQMaMOgKE
	pJr6N6LYEmqExTJly+KqHudQUcdhLbE0qJyLKXub5NeS5ZLg84ESkfRclbnTdPr2
	3yAXLw1ePWnFxkbTFwHaPHKhmU4QPM7kAnMZx/YKvmlelh36TMvmS9qnvU8UMmcv
	N4WGYAryjG1BptiDK5/GkXPAgPVUmGSkTmacJ87MgJW2TEbbUyQrFT1xZZb8/PSc
	x25GSt8/rY00M5DLmLgyWQIX3/E6Aw5tRCaYoU8DbXn8IirinkDLa0hYTIY5xl+P
	bBAS031K+5pTTIOIYzjOOEjGvZk1XZR/fcjYr6vCMKpmIDH+bIZsbVD2i2R3P+Lg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx841q53-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 10:07:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aKWk2879602;
	Thu, 17 Sep 2026 10:07:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3f8x84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 10:07:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HA7DTN30277964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 10:07:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8DB82006E;
	Thu, 17 Sep 2026 10:07:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4E52006A;
	Thu, 17 Sep 2026 10:07:01 +0000 (GMT)
Received: from [9.61.250.49] (unknown [9.61.250.49])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 10:07:01 +0000 (GMT)
Message-ID: <c52cf3a5-d831-4cb1-b22c-d04fd324f48d@linux.ibm.com>
Date: Thu, 17 Sep 2026 15:36:57 +0530
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
Subject: Re: [PATCH] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
        daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
        work@onurozkan.dev, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <tomo@flapping.org>
References: <20260819084825.969116-1-mkchauras@gmail.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260819084825.969116-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzOCBTYWx0ZWRfX/l9UUbC8fpyA
 aMTQnLi/CWSkMu08GpNSpMs7obpX9jpUEi8Bjk3U3xeO+O8pYum3sA0wOeNBqGMHf6AVUOCe1qi
 JFyknGkbNwZYGSfugkAk6UJRdmVWrR9q+Q0AiwKP2UOz1FRQMe0pnHc5q4X+Gm0LgalCXiONbHc
 YLOtuIX1jlY/q638R9QGvF/uSbHkYI/2Kj+zRJK0BKir0W0LQB9jvDKW8dctM+Wle0hcU9Aze/z
 MIR7qIt93JsE+YQ9rRBB+NPXn2QFx5rwusIfLNvaheCaBfKYMdMdWwEflCcv94sB2ZBa9M0pX+n
 TvfS4jMxfxQ3NxFNqMGlj21Bhdy13zUcCdL/zbuYSRhfbjmvxq8UPXZzs6HPUbsw255OKeMu4dT
 NwBYPL+M2+QUf+xinSOscwPl1H8ZG3wJpWLbcklVk6U4aVL5F/7lNWxn9X3o2rn2RQCt6u4dsQQ
 bI2zFMkxpwH7O0X/dPg==
X-Proofpoint-ORIG-GUID: AhHA6OE8t6-OwvhXsYezp_hGH2HgEAuE
X-Proofpoint-GUID: PdE9ocJZv5unX_ODRxpYIpQPLcE9YWJC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzOCBTYWx0ZWRfX/g4G73Cb0QAk
 Pk+xciUM4ANjOjCPxnx0ueN6QO4DNnQWcUqBxS5pgkgVZs7ISLOhDKXHB3JrKphQQ0bcyGsMS+n
 UGdFa4O1bPI5JMEBykwAX0AYskSAZ60=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aabbbd5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=5KbLO8kBAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=oeJeb_WNhhSxgeKwS9sA:9 a=QEXdDO2ut3YA:10
 a=YAFEAY7MpQUdBuZ-Sgsb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170138


On 19.08.2026 2:18 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> The Rust kernel infrastructure generates inline asm for WARN() via
> ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> arch-specific asm template string for use in Rust's core::arch macros.
>
> powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> Rust builds to fail on powerpc.
>
> Refactor _EMIT_BUG_ENTRY to accept explicit (file, line, flags) string
> arguments rather than relying on positional asm operand references
> (%0, %1, %2, %3). This allows the macro to be composed as a plain
> string concatenation, which is required for ARCH_WARN_ASM where no asm
> operand context exists.
>
> Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> the BUG_ENTRY() call site to preserve existing behaviour while enabling
> ARCH_WARN_ASM to supply its own size operand independently.
>
> Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
> convention, indicating that no additional reachability annotation is
> needed after a WARN on powerpc.
>
> This brings powerpc into line with x86, arm64, s390, and riscv, all of
> which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
>
> Suggested-by: FUJITA Tomonori <tomo@flapping.org>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Tested on PowerPC LPAR + 7.3.0-rc3 by creating a small .rs module to

trigger ARCH_WARN_ASM.

Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

> ---
>   arch/powerpc/include/asm/bug.h | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index 0db48977c70c..8aba39e0cf26 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -32,34 +32,38 @@
>   #endif /* verbose */
>   
>   #else /* !__ASSEMBLER__ */
> -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> -   sizeof(struct bug_entry), respectively */
>   #ifdef CONFIG_DEBUG_BUGVERBOSE
> -#define _EMIT_BUG_ENTRY				\
> +#define _EMIT_BUG_ENTRY(file, line, flags)	\
>   	".section __bug_table,\"aw\"\n"		\
>   	"2:	.4byte 1b - .\n"		\
> -	"	.4byte %0 - .\n"		\
> -	"	.short %1, %2\n"		\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +	"	.4byte " file " - .\n"		\
> +	"	.short " line ", " flags "\n"
>   #else
> -#define _EMIT_BUG_ENTRY				\
> +#define _EMIT_BUG_ENTRY(file, line, flags)	\
>   	".section __bug_table,\"aw\"\n"		\
>   	"2:	.4byte 1b - .\n"		\
> -	"	.short %2\n"			\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +	"	.short " flags "\n"
>   #endif
>   
>   #define BUG_ENTRY(cond_str, insn, flags, ...)		\
>   	__asm__ __volatile__(				\
>   		"1:	" insn "\n"			\
> -		_EMIT_BUG_ENTRY				\
> +		_EMIT_BUG_ENTRY("%0", "%1", "%2")	\
> +		".org 2b+%3\n"				\
> +		".previous\n"				\
>   		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>   		  "i" (flags),				\
>   		  "i" (sizeof(struct bug_entry)),	\
>   		  ##__VA_ARGS__)
>   
> +#define ARCH_WARN_ASM(file, line, flags, size)		\
> +		"1:	twi 31, 0, 0\n"			\
> +		_EMIT_BUG_ENTRY(file, line, flags)	\
> +		".org 2b+" size "\n"			\
> +		".previous\n"
> +
> +#define ARCH_WARN_REACHABLE
> +
>   /*
>    * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
>    * optimisations. However depending on the complexity of the condition

-- 
Thanks and Regards
R.Nageswara Sastry


