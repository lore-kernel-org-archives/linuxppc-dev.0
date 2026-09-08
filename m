Return-Path: <linuxppc-dev+bounces-26771-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5012C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:46:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfHc61DHnz2y8G;
	Tue, 08 Sep 2026 18:46:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788857206;
	cv=none; b=XzZnFduSrsclmDZyTpN13PeYEtCf4KXt+eIjpt9/JUnABAXoXBiBlTTMklVIHdofiAgJv0+wPwN7g0I/NRnrKDQKJHWEAObCvfBbla03jMYU00y4NEbGYLjS32fmkWLYRQMV046NFhaOCJWq2muZTVisZGstcd5iPypVZUCUdTXSMKYNOv1scfmltKGIveLcY0cPyfxlR2TN6aqB/vMjpFF3g4/amJoOFbIJkQxgtENQ2xewa8l+37uXFsdOmJMcgfBzoQk7hLyqFcpYHuqHqXgaWnE2lPZS3MUCm2qnTybXIEZwUU6ecnLaftkE682wZAjdaWfgWWXSC1+LVlzqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788857206; c=relaxed/relaxed;
	bh=OukIKjJheiHb1Mp71qSgoz6oGaQ4KoVicLb4Eqf+VW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggRex79ZqZMmmLmCjFhX/mq1Eu8xHtzOEj9yI0MVMcatNuibOEWn3LYsy+FBuvCw4YzhfZhpABfUlNIq9CfC/0PEF1Ml1xRt1GlHP9s1kzv2VoILyUlMuDZKTbEvw/mdEEJaQAYMu4vIeozJ/o6L7YBi71Y+LrimlOYEmyXynqNEdu3isqBW9CpbUdiaZs5h83gTJd9QKQWoKDzOc/IS7zYmQ7Bfl461U+ujyM1V1MSCV4EkUGyLiN7AfSTaieUM8AZxsbNK1bnHyw4z9z9Fd8RaCVvGHR85U0Zfn8yb0ZVHDnJxomPEb10ELp+wYUL0TMZCBEFI25DwGsGBAw8jEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rwrg/sOw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rwrg/sOw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfHc51zYQz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:46:44 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886Vea64125532;
	Tue, 8 Sep 2026 08:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OukIKj
	JheiHb1Mp71qSgoz6oGaQ4KoVicLb4Eqf+VW4=; b=rwrg/sOwDJBsvs4xyWC2ot
	zDMfdftYitxpxmM7a4REBQM+VpGhEJwUbxt5Ef4j/nDj5gFtylgH4svOLeIvXEbn
	Ko+4jYvVtI7QYi/9RycD4kkKVMIG5hQLbg5hU86SG6BJvxljN1oRphNPkvGcoyBW
	5bGA3Rp2QixS9dY0rKr0s8UTF33rhqbomw0vwN6VRQbdBNQjeXIvK4cuW5NdG6Wf
	phF5KffJyqIY5AdMBxTVptHQnJ8S36ZHZ+qiCIft65MqLNpme0gHuypkrc8Szeeo
	c7FCzETfWTt5U7Rg+SnN5dc7q5bz7Xp+D1f9skVQEzNGEXiFBkgbGpeKLtg+qYuA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj85f7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:46:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6888fEAp024624;
	Tue, 8 Sep 2026 08:46:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yag1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:46:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6888kKhK29688270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 08:46:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A2A020043;
	Tue,  8 Sep 2026 08:46:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B04720040;
	Tue,  8 Sep 2026 08:46:18 +0000 (GMT)
Received: from [9.123.3.64] (unknown [9.123.3.64])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 08:46:18 +0000 (GMT)
Message-ID: <7f072a9a-c656-4f79-a805-f90dee35bfde@linux.ibm.com>
Date: Tue, 8 Sep 2026 14:16:17 +0530
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
Subject: Re: [PATCH v13 5/8] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <647e37d4e0049cc9c9a6977ac112a445f6ced6c8.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <647e37d4e0049cc9c9a6977ac112a445f6ced6c8.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dP32rPSy3aJnuhswsXMcLELoNvg8XxT5
X-Proofpoint-ORIG-GUID: dP32rPSy3aJnuhswsXMcLELoNvg8XxT5
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6a9fcb61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=JCM8ehL5gn53L53ZUGAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfXzzAp6e9SzPZ6
 n0txbtOan/YbJCz/RI16FRpi7zxkWmpB5VBAsyx+1DnzbKmxloINldUHw3UGH6ylUBe4FmmWE2H
 nfewlhpBdJA0UawLz3NIFTCGboKBbno=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfX6T3CTUyy971Q
 ouO8orilB3Grfxm/ZRuBGI6mPZ4GB0hixjfYPOZu3Atak6y/F7Dd9hb6ezoMB/Qx8CiUBb84mRn
 DC/dpJOuLjXMy+oXjZHsKg42AA+7bkDpb9Kq5Q1ojGmG6yQ31a3RZkiLIwF6RCqNwGM13fo2ayf
 hrqSY1vtDVXNcHIzLOKZ6Qo8DDICqqnjyaVIFko2MBrINyX8Vr1/NKOqtNP+GYwUJ2EnASoquWi
 t3iM5jR5mV8GrWqyUOlKAyiCzw8pjfnWGQ95UFhdimumjkg9RDFKaro8NpL9dkaE3gIjHjLR3oU
 OX0botNenMT5Og0/QkW+CMLXdsR9OF/llA9dOO1L6HsgF/UHf8jpVXkUDdjjQXOHZHCHs6H1eQy
 3vp+QnRmljkPBkjsE1auB4MkStrPuYdO2z2jJhbni8uTAIIks6JJl7IgYRdxBgKiV4Sric8fWUC
 k8Cdq1E2azcMSECR4yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080089



On 31/08/26 12:46 pm, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Move the long branch address field to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 4/8 bytes. The last bytes exclusion is logically necessary to
> prevent disassembly failure, otherwise the actual program layout
> is never altered. Hence no effect on overall program size.
> Also, align dummy_tramp_addr field with 8-byte boundary.
> 
> Following is disassembler output for test program with moved down
> dummy_tramp_addr field:
> .....
> .....
> pc:68    left:44     a6 03 08 7c  :  mtlr 0
> pc:72    left:40     bc ff ff 4b  :  b .-68
> pc:76    left:36     a6 02 68 7d  :  mflr 11
> pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
> pc:84    left:28     a6 02 88 7d  :  mflr 12
> pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
> pc:92    left:20     a6 03 89 7d  :  mtctr 12
> pc:96    left:16     a6 03 68 7d  :  mtlr 11
> pc:100   left:12     20 04 80 4e  :  bctr
> pc:104   left:8      c0 34 1d 00  :
> 
> Failure log:
> Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
> Disassembly logic can truncate at 104, ignoring last 8 bytes.
> 
> Update the dummy_tramp_addr field offset calculation from the end
> of the program to reflect its new location, for bpf_arch_text_poke()
> to update the actual trampoline's address in this field.
> 
> All BPF trampoline selftests continue to pass with this patch applied.
> 

This makes it easy to disassemble the bpf programs. Looks good.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 44 ++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8ca36a933c7a..c2717f0d9cdd 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -52,19 +52,19 @@ asm (
>   void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	int ool_stub_idx, long_branch_stub_idx;
> -	int ool_stub_sz;
> +	int stub_sz;
>   
>   	/*
> +	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
>   	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
>   	 * The alignment NOP must appear before OOL stub, to make
>   	 * ool_stub_idx & long_branch_stub_idx constant from end.
>   	 *
>   	 * The fimage can be non 8-byte aligned, so final alignment depends
> -	 * on start of fimage and the stub's instruction count offset. The
> -	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
> -	 * or 3 instructions (without) before dummy_tramp_addr.
> -	 *
> -	 * Emit a NOP here if address is not SZL aligned.
> +	 * on start of fimage and the stub's instruction count. The
> +	 * stubs block has 11 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
> +	 * or 10 instructions (without) before dummy_tramp_addr field. Emit a
> +	 * NOP if the address of dummy_tramp_addr is non aligned.
>   	 *
>   	 * In pass=0 when image==NULL, conservatively account for space
>   	 * required to accommodate alignment NOP. In case final pass skips
> @@ -72,8 +72,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   	 * jited_len signifies correct program size.
>   	 */
>   
> -	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
> -	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
> +	stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 44 : 40;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + stub_sz, SZL))
>   		EMIT(PPC_RAW_NOP());
>   
>   	/*
> @@ -94,28 +94,29 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   
>   	/*
>   	 * Long branch stub:
> -	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
>   	 *	mflr	r11
>   	 *	bcl	20,31,$+4
> -	 *	mflr	r12
> -	 *	ld	r12, -8-SZL(r12)
> +	 *	mflr	r12	// lr/r12 stores pc of current(this) inst.
> +	 *	ld	r12, 20(r12) // offset(dummy_tramp_addr) from prev inst. is 20
>   	 *	mtctr	r12
> -	 *	mtlr	r11 // needed to retain ftrace ABI
> +	 *	mtlr	r11	// needed to retain ftrace ABI
>   	 *	bctr
> +	 *	.long	<dummy_tramp_addr>  // SZL bytes aligned
>   	 */
> -	if (image)
> -		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> -
> -	ctx->idx += SZL / 4;
>   	long_branch_stub_idx = ctx->idx;
>   	EMIT(PPC_RAW_MFLR(_R11));
>   	EMIT(PPC_RAW_BCL4());
>   	EMIT(PPC_RAW_MFLR(_R12));
> -	EMIT(PPC_RAW_LL(_R12, _R12, -8-SZL));
> +	EMIT(PPC_RAW_LL(_R12, _R12, 20));
>   	EMIT(PPC_RAW_MTCTR(_R12));
>   	EMIT(PPC_RAW_MTLR(_R11));
>   	EMIT(PPC_RAW_BCTR());
>   
> +	if (image)
> +		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> +
> +	ctx->idx += SZL / 4;
> +
>   	if (!bpf_jit_ool_stub) {
>   		bpf_jit_ool_stub = (ctx->idx - ool_stub_idx) * 4;
>   		bpf_jit_long_branch_stub = (ctx->idx - long_branch_stub_idx) * 4;
> @@ -1309,6 +1310,7 @@ static void do_isync(void *info __maybe_unused)
>    * bpf_func:
>    *	[nop|b]	ool_stub
>    * 2. Out-of-line stub:
> + *	nop	// optional nop for alignment
>    * ool_stub:
>    *	mflr	r0
>    *	[b|bl]	<bpf_prog>/<long_branch_stub>
> @@ -1316,14 +1318,14 @@ static void do_isync(void *info __maybe_unused)
>    *	b	bpf_func + 4
>    * 3. Long branch stub:
>    * long_branch_stub:
> - *	.long	<branch_addr>/<dummy_tramp>
>    *	mflr	r11
>    *	bcl	20,31,$+4
>    *	mflr	r12
> - *	ld	r12, -16(r12)
> + *	ld	r12, 20(r12)
>    *	mtctr	r12
>    *	mtlr	r11 // needed to retain ftrace ABI
>    *	bctr
> + *	.long	<branch_addr>/<dummy_tramp>
>    *
>    * dummy_tramp is used to reduce synchronization requirements.
>    *
> @@ -1425,10 +1427,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>   	 * 1. Update the address in the long branch stub:
>   	 * If new_addr is out of range, we will have to use the long branch stub, so patch new_addr
>   	 * here. Otherwise, revert to dummy_tramp, but only if we had patched old_addr here.
> +	 *
> +	 * dummy_tramp_addr moved to bottom of long branch stub.
>   	 */
>   	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
>   	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
> -		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
> +		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */
>   				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
>   				  (unsigned long)new_addr : (unsigned long)dummy_tramp);
>   	if (ret)


