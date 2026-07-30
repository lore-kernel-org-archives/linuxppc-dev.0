Return-Path: <linuxppc-dev+bounces-25111-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF94C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 13:07:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9qHL5zGqz2yYd;
	Thu, 30 Jul 2026 23:07:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785416846;
	cv=none; b=JRBXB0XoQk68q0he9jkRI0gkSr/jkzgb6U641G9+otYd09HM7EgVE7wcUK03z62YRQrGCyLA8QixDU0T0G+FjDYDY5kyhXtPxPHGQFgRpE03wgiwdz1M4cRIBv1vpFGH+pUZtVuXs7S+S5jqHxPahXGMFrJ86Od4VPRvcy5evSyKwNNZbLCSpcCFLA9VCXCjQKdRWmmniO3z6gcmn8QgU+zFAytQgVdM8+XtUwiYk7bM8ubJdYXiGZoAEaaPAtdWw6m7BkA+NQswYsHlarO670y7WG/CxHFo/vCBqsoR/d2kRG3nfn+eB9C2Y45PLm9emaL8S4T8FEE5bAGIcZNbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785416846; c=relaxed/relaxed;
	bh=u7S96NlnLwqhOM4g+/DIgXu0js9BGleUB91EboBxTro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK/GEstYZwHsw3lN1dr/ipdqCpekNXLhAgSUkh9Mgb2hQajDyM63QUYU49AQUdrul/RrMZH57py5qi5rT1NwKzNTTQOj2FdvBfRQC0XxvaO8Cla0ggMq4huN7xvLP9TYpiincv21Uf9kPslynSbpV7o6PErB5KDCY2R03M2XVvGfTOK9UBin/mKCnzu+5Hx2uRMCUgomyl2qLO6DCB26or/g9ZrYNlibxHFNSc4ryKgweiwOvIL+zhMeeLP5LXol6M2G8KSbmSHF1IOO3uBvGQA3gPeMQGqpOTiHbqllLeb4IQtvIMSyv3pfqS+fGQ66QCJvDafx2Fl0kTissa5g8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kKQuNG35; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kKQuNG35;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9qHL1gTLz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 23:07:25 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHd732742051;
	Thu, 30 Jul 2026 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u7S96N
	lnLwqhOM4g+/DIgXu0js9BGleUB91EboBxTro=; b=kKQuNG35EZd6d/O/5mXGsk
	ZRbjLjGo7eVvXsM7BSfPrttHtk1RU/c5xCJ9sLURG/iReaIbkEKXR6yV6zd34LAG
	MKkiyyuHkGDTYVNP0QCiWiCixp34Iy4lgTzxmWmB3K6QHhl5CJCS0q4hoy/Dd5yN
	nc5odgEmWmUAfAlG0Jvc+jNsMrBZvtEG5GdYViS1VrHnl22pfTybzz5pvxt9a2kl
	RzIpUVZLlu1egOfwMS93TVuwildNEXdpoTcbgfB9F1JnkoBqf+9md3Y0kQbjJJqc
	C/kW2NB1NgJKZ95Zr5MBVevIHlq4oNmoZvByZePknX8zRuAAvzmfwrCCVgctVxfA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xyv0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:06:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCuMXA017081;
	Thu, 30 Jul 2026 13:06:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhkb5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:06:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UD6opG31195428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:06:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C68102004E;
	Thu, 30 Jul 2026 13:06:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA6082004B;
	Thu, 30 Jul 2026 13:06:47 +0000 (GMT)
Received: from [9.124.210.70] (unknown [9.124.210.70])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:06:47 +0000 (GMT)
Message-ID: <fcd85556-cc96-49ac-a715-09ab14d3f589@linux.ibm.com>
Date: Thu, 30 Jul 2026 18:36:45 +0530
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
Subject: Re: [PATCH v2 1/2] powerpc64/bpf: Fix build break in
 bpf_jit_emit_func_call_rel()
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, chleroy@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1785387718.git.skb99@linux.ibm.com>
 <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: WXe6Z8pYXvc1thTb6PfLW1rcFZE_Zj_V
X-Proofpoint-ORIG-GUID: fpi2A6djpuCClmCi2tmH40McNkTJRa-X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfXyN7w8RYSmq1k
 H6aS15sSXpDrBUQstfEsrskGC1CyzbusyawG3DskwHgvzVU15jKeAt1l2oamZFu0BrmA0dMPthF
 0rWXYQSsCN1SYU8k2ASUXM7oCgPUuLg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b4c71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=cvciGhUBELjveWF9BAcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX/D7ZdSCgfmlj
 5wkJGcWcg2hiABgZXFGraTAoA7Y3cxCOs0CTfX+dlTYq1R1xNceSx3RY1u5FDrvky4i74jMzaQM
 6iP4FDXIp1tTfUUssep6kD6BmyfVhGIZ/XHq8FmeyYUzA1ykLMd6LUGV4Sh09oHS7HwwS3j248R
 J3ZRd56sJ1eVLPUBv09QLfdDIHBJiYLoQpWUPRmsDOYzRgyJZH/LXPp3O8AFXdsuIQzwZjLFwBP
 ikkMjkBfKgqPl9vzm9zVRjRYWf1jNC19XLhSqAmkrmfN+Ex+EdXX8E5BbmTVoXKF9+B+cqMni4o
 VtXkUCC6LKZN7bBUiJg2MVSteKScO6qNFt+5uOJdRRTZoCqD7ryM35mrmI114/BI9A8faTlwQxO
 LsnfDMnNH+hxbHvQH9HKxeR8MMlTMpa8hxarV1EFxS+/3bDGApU6SfUxXu8gtgg+CnfAuUxQyKq
 MWUNPDOFY2j1CsmudAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300096



On 30/07/26 11:16 am, Saket Kumar Bhaskar wrote:
> From: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:
> 
>    CC      mm/dmapool.o
>    CC      fs/readdir.o
> arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
> arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
>    475 |         int ret;
>        |             ^~~
> 
> Commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> introduced "ret" at function scope, but it is only used within its
> respective conditional blocks. Same holds true for reladdr. Move both
> variable declarations to the scopes where they are actually used:
> "reladdr" to the CONFIG_PPC_KERNEL_PCREL block and "ret" to the non-PCREL
> else block.
> 

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index dab106cae22b..fc9db691e820 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -471,8 +471,6 @@ static int bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 f
>   int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>   {
>   	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
> -	long __maybe_unused reladdr;
> -	int ret;
>   
>   	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
>   	if (!func) {
> @@ -487,6 +485,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   	}
>   
>   #ifdef CONFIG_PPC_KERNEL_PCREL
> +	long reladdr;
> +
>   	reladdr = func_addr - local_paca->kernelbase;
>   
>   	/*
> @@ -525,7 +525,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   	EMIT(PPC_RAW_BCTRL());
>   #else
>   	if (core_kernel_text(func_addr)) {
> -		ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
> +		int ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
>   		if (ret)
>   			return ret;
>   	} else {


