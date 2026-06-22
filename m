Return-Path: <linuxppc-dev+bounces-22869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF362CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 09:20:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkN2t2MHyz2xyh;
	Mon, 22 Jun 2026 19:20:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782120022;
	cv=none; b=fGFlIPPXbfq3eNyfH/4Cp5SO7pIKivK1AsdAVJ26km+vZqkw7dSHa7RU6JNbvetTMY8Ve/VuhIlgtmXxSLIj/3R2D9wSLGPs6NJ3uH7ASz+FgUPO4PS1cURQkPs9FhGd8jQkuk4UF918jGnWCIQffdcAO2TTEphAdFI5VF6oB0bd0xdEa8e5ezYs2k+6HkVkObjZJU7ifPAF3Zo0xwHh9/22nroH2rNzEKaUj3+/3GVqWcq51meu5QOmMa3Z9N4XiJBL0GORHWCf3GxiccjaXCExDQQiTvtoT2zq1dSiNoTwfX+InWTZSfQ1YsYwhW69UbAOFOLoSEvKpaAshLPV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782120022; c=relaxed/relaxed;
	bh=0JUZe5dJJdUpHkKuRqCR5BVM3FwjgxO8hAmWO2x8SHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRLXAfjMrrYmUvUEeVtzNzTssTK0u5B54rsC3qi/6M+luBlZBBeVVZiHlPinBG5epsDSnmBlhXWJTRLV7KthgEfwZMlXAHzXTrMqiMYljyyn+2taYp7jNmnsyvBYiEmdE1VX17N6pNXvtllGXCvhPc2tgrONtVxXuhoBb06cU/hv8p8KnxmtfxqEUeMelFl4NYi55pP1BBppioC8+/HDjBj8WCuUZSuPmV4d4kStYko5/YEJ6q4siYp2ZS8VUAZaty7d/OWK58kUWHgIntFp9SSwdEpuWAkKbPaZhwhS0j0bGig0kQFWy8tOFFHqEvkJBwO9WDGYWQ0CCM4+eMevgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DP6wql/N; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DP6wql/N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkN2s3MCkz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 19:20:20 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5Ikfc1814109;
	Mon, 22 Jun 2026 09:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0JUZe5
	dJJdUpHkKuRqCR5BVM3FwjgxO8hAmWO2x8SHQ=; b=DP6wql/NmsQjPYpz2cOcHC
	B1VLiSlU+dg6z5ztZeVCAWcHKzLp3rUFKbrGQk65Thr3Pxke13fRzc2f7BA5bpht
	75opS4+wKNavlDLAgl0c1KzcuRiuPn0r8IBDcB3xWslDhCvUwcavsFyBoXzumtZt
	KeL4NKMx+J20xaKeJuDdr9aD8AYn/pHCoLe02UdzVaP6Kn+rmUiYijuwgvPlEonA
	5Il9lCGME28yeLuPYrMetUnM0HgcZGZFk3H/HZA/fVKWpVMT9/zKI8OgZPNJQgCZ
	o8byYYkdcj1rabEpkFkYpjSSk00m1Vd5ZEOv3f9owGXUEfzzsAEPY+sY0LmxrBbg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqg894-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 09:20:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65M9JbJ6017045;
	Mon, 22 Jun 2026 09:20:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph5by2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 09:20:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65M9K1ok59638238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 09:20:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D43620040;
	Mon, 22 Jun 2026 09:20:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664E92004D;
	Mon, 22 Jun 2026 09:19:59 +0000 (GMT)
Received: from [9.89.240.192] (unknown [9.89.240.192])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 09:19:59 +0000 (GMT)
Message-ID: <f0658993-b904-4b42-8cf3-916875703523@linux.ibm.com>
Date: Mon, 22 Jun 2026 14:49:58 +0530
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
Subject: Re: [bpf v8 7/7] powerpc/bpf: fix buffer overflow in JIT for large
 BPF programs
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        sashiko-bot@kernel.org
References: <20260616164741.32252-1-adubey@linux.ibm.com>
 <20260616164741.32252-8-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260616164741.32252-8-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a38fe47 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8c-tPXck8-7YJIjhN78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5MSBTYWx0ZWRfX9pq+SPCazsoW
 +OFptsHwBuucHwdW0AswjL/Stu4HBy+mxvmOfgagyF4Ov0BOFUIScFngjVELe1xU6wEfF5o5VVz
 UxBgcJ/eRRndN05Q8XQ9kCYusdbCkBWLq0WHkulKX0lNCHTRgc4djG/kG/EsZUWuSy9wZ2h96QK
 GCtzuy+XCx713BAszJLI1MHmsVf7COOwFvGrG+5QyWLHlnZcSLfC0U+McLP2tAq/PkwdHFrgSa3
 AFBwzI8ezqJZkmkaHytiUUJNbOqKO5myZzPa37UMhBTvY4xXN5qw9Sq1Xgi0gcpb7xCkc3fyNgT
 mCO3zb/wOM3Gh+Z9iLHiCWE68lCkfRu6tzumdSvH+c1qRdUepFbs64ge6X+LNE6SKSOVKuvrW/T
 gQkXAkgJambTrU6tLOlnisOctMj+xUFa9BKq4cuA2dl1Xx0OmDnHXEFOeeUNLZc1Vs22NdWSuJ3
 Vnn1Xxf5bQAyr7ggDxg==
X-Proofpoint-GUID: SUrNjkj5cl5S2zcJEP9e6-yHbL9EFKqO
X-Proofpoint-ORIG-GUID: SUrNjkj5cl5S2zcJEP9e6-yHbL9EFKqO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5MSBTYWx0ZWRfX8LWFzgmxznWG
 LNesHjg2Xz4H7IMU+gUPtKtc8QJl6VdQTtWl8WaUuI7c955wyM1AD3tB1uhBbdzPjP3z/S2FHEC
 fmfcSUxKJMUJFSusfIk7r53y7tPlywM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220091


Hi Abhishek,

On 16/06/26 10:17 pm, adubey@linux.ibm.com wrote:
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
>     undercounting alloclen and introducing the overflow.
> 
> 2. Recompute addrs[fp->len] at the end of each code-generation pass.
>     The larger body from pass-0 might shrink in later passes; a stale
>     addrs[fp->len] would leave exit branching past the real epilogue
>     into the padding.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 1c274df2b4f7..d48bc722d0dc 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -128,11 +128,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
>   							int tmp_reg, long exit_addr)
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
> @@ -303,6 +302,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	 */
>   	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
>   		cgctx.idx = 0;
> +		cgctx.alt_exit_addr = 0;
>   		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
>   			goto out_err;
>   	}
> @@ -347,6 +347,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   			bpf_jit_binary_pack_free(fhdr, hdr);
>   			goto out_err;
>   		}

> +		addrs[fp->len] = cgctx.idx * 4;

Something like the below is needed to fix the potential branching issues
due to code shrinkage, reported by sashiko-bot in the other thread:

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index af510da12d8e..09cb7128c46b 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -14,6 +14,13 @@
  #include <asm/ppc-opcode.h>
  #include <linux/build_bug.h>

+/*
+ * We need at least 2 passes for proper code generation, and may need
+ * additional passes if code size changes between passes.
+ */
+#define CODEGEN_MIN_PASSES	2
+#define CODEGEN_MAX_PASSES	3
+
  #ifdef CONFIG_PPC64_ELF_ABI_V1
  #define FUNCTION_DESCR_SIZE	24
  #else
diff --git a/arch/powerpc/net/bpf_jit_comp.c 
b/arch/powerpc/net/bpf_jit_comp.c
index 904d5fe157bd..f8c1d1a39a90 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -335,8 +335,10 @@ struct bpf_prog *bpf_int_jit_compile(struct 
bpf_verifier_env *env, struct bpf_pr
  	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
  	fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);

-	/* Code generation passes 1-2 */
-	for (pass = 1; pass < 3; pass++) {
+	/* Code generation passes 1-2+, loop until program size converges. */
+	for (pass = 1; pass <= CODEGEN_MAX_PASSES; pass++) {
+		u32 prev_proglen = proglen;
+
  		/* Now build the prologue, body code & epilogue for real. */
  		cgctx.idx = 0;
  		cgctx.alt_exit_addr = 0;
@@ -350,9 +352,23 @@ struct bpf_prog *bpf_int_jit_compile(struct 
bpf_verifier_env *env, struct bpf_pr
  		addrs[fp->len] = cgctx.idx * 4;
  		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);

+		proglen = cgctx.idx * 4;
+
  		if (bpf_jit_enable > 1)
  			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
-				proglen - (cgctx.idx * 4), cgctx.seen);
+				prev_proglen - proglen, cgctx.seen);
+
+		/* Check if program size has converged, but ensure minimum passes */
+		if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
+			break;
+
+		if (pass == CODEGEN_MAX_PASSES && proglen != prev_proglen) {
+			pr_err("BPF JIT: Program did not converge after %d passes\n",
+			       CODEGEN_MAX_PASSES);
+			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
+			bpf_jit_binary_pack_free(fhdr, hdr);
+			goto out_err;
+		}
  	}

  	if (bpf_jit_enable > 1)


- Hari

