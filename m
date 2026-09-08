Return-Path: <linuxppc-dev+bounces-26816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EA1C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:32:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfTxS4h7Rz2yFW;
	Wed, 09 Sep 2026 02:32:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788885148;
	cv=none; b=AnmO+8iHKSNRzkYhT4Nz56CFARgoK3UmPZjSXclGupcJXaiFr1NbaklGrscHSILaSoJrwf2MmYZgkkgZWazruKLeUN9XybAwqgk8llu6EZ+/2apAOtNGUWRa9YJPnAMbQLKHIbBfT85s7gynvHYbdb1nMjs7rnY9UN1d+0T/aUBD/0ZxeWHRj2RUUI6Co7L8RIxu21MBBZDD4MDGZxQKK5v217JakmABl07TnisBCq9pUjMZANfz7aeeortOR9ivKat+OxQYRmr7sH2jfBvqKrGrbb84hD4Dx8uUC3kELHg/ZQMd54ut08gcfCF41X9VJN8S7bRI6fZ0OJfYZFAl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788885148; c=relaxed/relaxed;
	bh=GOFBSV1D3+PAhDjQPuz5kpIvBTMpZZJ9JFg6WpGjYRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kECGriWWFhZotmpq13aBwHa33jG3ccfTDYP8pDP4aP751XmlNbJTAbMyWfn/Tutx++CO3uWiSzCbl35XTXLUiQMYtbMWKFBr/UNdPrBvmMLK8gvmLzyw07CTkww50eDgwNOsydng5506EaKAsMq++L+s7GqrBgpXbPqp9mtaOJZO7tzhNRjCNhl7WMNRskEZ5fiiAlHiGD0hnkk9jclnYKbI9Tw1+T8Soznve4+kIIG2GY+rjGezvw/N+c1n4zgSdsu7stWI3LxEijwKrR7wbhWEoVBLel3MYv9XfIW8ryB2vXx/8tkrQdKZCNr1NZrKXvEX9I0EUUxy58CXviHOCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QUbCYEAe; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QUbCYEAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfTxR5zxhz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 02:32:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1bHS080358;
	Tue, 8 Sep 2026 16:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GOFBSV
	1D3+PAhDjQPuz5kpIvBTMpZZJ9JFg6WpGjYRo=; b=QUbCYEAewWRS9OsjMosOTD
	bv9kswI+IKwdEhBW64IHzQ52nsy0v3r99eo/iAcoU+OBFBE7G7Tt9BPrx6OFLxtp
	VFI248ZdCkZ7A0xG4HzI6bptvwl6Z4YpTs3hPOE4aMEWGw8NTUO96Odjjv+vmt5G
	TAbdK5MKn2VBCnmLIKxHdiJeSalUb2eTrrWT4kte6DVT9spD/4qdd+hJZejKWtA6
	CbF52LkzD1caDt0Wvbj1H5KfLgf6qO3yk6XZT8tIeFuq/PDgNW7EkDJKmElJbDE6
	cA0DFQdgzglMDczi/pmBhC6uZxIrygRamh1tRAFRmSZVWuYW/595kESj5Uvd34DA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrr52a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:32:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQEPp020670;
	Tue, 8 Sep 2026 16:32:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqd719-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:32:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GW4eG46268882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:32:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C6DA2004D;
	Tue,  8 Sep 2026 16:32:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E73122004B;
	Tue,  8 Sep 2026 16:31:58 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:31:58 +0000 (GMT)
Message-ID: <cb258de3-de0f-42b9-9147-726b6c9f51ed@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:01:55 +0530
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
Subject: Re: [PATCH v13 3/8] powerpc/bpf: fix buffer overflow in JIT for large
 BPF programs
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <e5fc39c4f3340791bec5e7a92e1d146d3ed6296e.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <e5fc39c4f3340791bec5e7a92e1d146d3ed6296e.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa03889 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=et7YBkXB-uCz4WkyIggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX7Ly/U6JBeZXU
 WUEHe4iIHDHD9loHFM7PJL0gJyQXyCvj2k2+XTnApp4WcP29/c92AxI4CZPJ8+XaVKpUgk/Xklq
 hQhyQ5vvtgjNrh73zgpYjNezILRXyuY=
X-Proofpoint-ORIG-GUID: e2FbJdGRAUh-E18LwWpjxrBLeYFXzRau
X-Proofpoint-GUID: e2FbJdGRAUh-E18LwWpjxrBLeYFXzRau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX+87jGyGPmgzL
 o/7/kFf+hN3NiQ+PsUrZr4CmIlJlAJJIZnUtyWTa5hB8T1+SvPeqnnmSrLR2pKrTeOdZk6v/xm7
 Z8+aVrifRwHEMx9XMu5dNOmULJP+UeFW3V9efZYZXsWqmckahVXomr1+GtUPD20N8Riz4J2VWg3
 sJj3BTQYYjgW4bKq7PTl067tl554yMH98k43cP5O3GR/7Hd3Kb2da+r/5al26S+VQaSEgQV+5R+
 paHB0dBWI2bMgL7tIH7qr68NYzyjemgkbQdwu8zX5TStSOEC04V7r+9KloS444YDkWif5wfQZuA
 S9tjPRybL45szcdgkSKesX0h4QHMPG9SLP8/OslyrIexp1088GlyY+9b2NpVAid4pky9ZiziTik
 3GACwfRetBveQjm+3HnkHba24SThXgY0Q8O9q66Lr+zgrM4HRCROMPbGy5NkQ/8xAfQjGp/kRcA
 U8kMmF4I3XrtcWstK7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:46 PM, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
>
> During size calculation in pass-0, exit_addr is 0 since addrs[fp->len]
> is not yet populated. bpf_jit_emit_exit_insn() treats a zero exit_addr
> as in-range and skips bpf_jit_build_epilogue(), so the alternate inline
> epilogue instructions are not counted in alloclen.
>
> In later passes, if the real exit_addr falls outside the 32MB branch
> range, the full inline epilogue is emitted into the already-allocated
> buffer, writing past its end and corrupting adjacent memory.
>
> Fix by ensuring exit_addr is non-zero before treating it as in-range,
> so pass-0 always falls through to bpf_jit_build_epilogue() and
> conservatively accounts for all epilogue instructions in alloclen.
> Also range check alt_exit_addr directly in the else-if condition.
>
> Since exit_addr handling now falls through to the epilogue, two
> related issues in bpf_int_jit_compile() must also be addressed:
>
> 1. Reset cgctx.alt_exit_addr before the second size-calculation pass.
>     Without this, a stale alt_exit_addr from the first pass causes the
>     second pass to emit a single jump instead of the full epilogue,
>     undercounting alloclen and reintroducing the overflow.
>
> 2. Recompute addrs[fp->len] at the end of each code-generation pass.
>     The larger pass-0 body can shrink in later passes as out-of-range
>     exits settle into in-range jumps; a stale addrs[fp->len] would
>     leave exit branches targeting past the real (shrunken) epilogue.
>
> Because shrinkage in a later pass can move the epilogue offset, the
> fixed two-pass loop is no longer sufficient: an exit that was out of
> range in an earlier pass may fall in range once the epilogue offset
> shrinks, shrinking the body further and overwriting the start of the
> epilogue. Convert the code-generation loop to iterate until the
> program size converges, bounded by CODEGEN_MAX_PASSES, and fail the
> JIT if it does not converge.
>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Link: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/net/bpf_jit.h      |  7 +++++++
>   arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++++++++--------
>   2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 35015d7ecb76..6d58df361648 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -14,6 +14,13 @@
>   #include <asm/ppc-opcode.h>
>   #include <linux/build_bug.h>
>   
> +/*
> + * We need at least 2 passes for proper code generation, and may need
> + * additional passes if code size changes between passes.
> + */
> +#define CODEGEN_MIN_PASSES    2
> +#define CODEGEN_MAX_PASSES    3
> +
>   #ifdef CONFIG_PPC64_ELF_ABI_V1
>   #define FUNCTION_DESCR_SIZE	24
>   #else
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8f7501954d9f..11981d2270a9 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -99,11 +99,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   
>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
>   {
> -	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
> +	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
>   		PPC_JMP(exit_addr);
> -	} else if (ctx->alt_exit_addr) {
> -		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
> -			return -1;
> +	} else if (ctx->alt_exit_addr && is_offset_in_branch_range(
> +			(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4))) {
>   		PPC_JMP(ctx->alt_exit_addr);
>   	} else {
>   		ctx->alt_exit_addr = ctx->idx * 4;
> @@ -274,6 +273,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	 */
>   	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
>   		cgctx.idx = 0;
> +		cgctx.alt_exit_addr = 0;
>   		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
>   			goto out_err;
>   	}
> @@ -306,10 +306,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
>   	fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);
>   
> -	/* Code generation passes 1-2 */
> -	for (pass = 1; pass < 3; pass++) {
> +	/* Code generation passes 1-2+, loop until program size converges. */
> +	for (pass = 1; pass <= CODEGEN_MAX_PASSES; pass++) {
> +		u32 prev_proglen = proglen;
> +
>   		/* Now build the prologue, body code & epilogue for real. */
>   		cgctx.idx = 0;
> +		cgctx.exentry_idx = 0;
>   		cgctx.alt_exit_addr = 0;
>   		bpf_jit_build_prologue(code_base, &cgctx);
>   		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
> @@ -318,11 +321,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   			bpf_jit_binary_pack_free(fhdr, hdr);
>   			goto out_err;
>   		}
> +		addrs[fp->len] = cgctx.idx * 4;
>   		bpf_jit_build_epilogue(code_base, &cgctx);
>   
> +		proglen = cgctx.idx * 4;
> +
>   		if (bpf_jit_enable > 1)
>   			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
> -				proglen - (cgctx.idx * 4), cgctx.seen);
> +				prev_proglen - proglen, cgctx.seen);
> +
> +		/* Check if program size has converged, but ensure minimum passes */
> +		if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
> +			break;
> +
> +		if (pass == CODEGEN_MAX_PASSES && proglen != prev_proglen) {
> +			pr_err("BPF JIT: Program did not converge after %d passes\n",
> +								CODEGEN_MAX_PASSES);
> +			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
> +			bpf_jit_binary_pack_free(fhdr, hdr);
> +			goto out_err;
> +		}
>   	}
>   
>   	if (bpf_jit_enable > 1)
> @@ -399,7 +417,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
>   	u32 *fixup;
>   
>   	/* Populate extable entries only in the last pass */
> -	if (pass != 2)
> +	if (pass < CODEGEN_MIN_PASSES)
>   		return 0;
>   
>   	if (!fp->aux->extable ||

-- 
Thanks and Regards
R.Nageswara Sastry


