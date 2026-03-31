Return-Path: <linuxppc-dev+bounces-19045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7409DFF60C8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 05:07:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flGMh0l9Gz2ybQ;
	Tue, 31 Mar 2026 16:07:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774933664;
	cv=none; b=Ak3SVLnOlr5qM6EyLcX3IM9alKxy0dkjGnjAgHo/vVJks+dV8/cohnmg2BokvsEIn+JA+EuXX05WuZzarYFL88TClOjtr3oJbrbnExuU7PyHIj/eGfXP6f4sDfMchyDJkoeyK6oVlc5Wmk3CpH2tlU8JJGYjLGlbPPtcjpxbLL/HeEbR2NWNMKc0PHS0Po/cqa4JbzqxXZyV8D2tye8RCmrFBeXmeeru2SgbITzo2kA25z7SVtLuEEdWmthM8SMzCy8VEm+9UMzieGz+zJBzZxO+9CAkAJgJ57tPxmYrgMt9RIhpvB9t7kQFsVMzI6p8ekb7JxT+cNtS0Upq9p/Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774933664; c=relaxed/relaxed;
	bh=mKXCNYCP6gqE0JnBljQXUiy7ssQpocmU/ho1y7WXCjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9S15VhsVYGD20gayU9h7R6VvRmwapBvc2UOIgdPUsf+8rDmf9kA+JVJGMq064aNFcndv2lJz4J1fUmnwV/5ZF7EfkGejdpbcNU08OB6sDkztIsyl1WfAS+tMrhkQUyLDSjrxcmakDlLP3YDit+00PWpCN97upYN75L2QLV5d1Y/RNROzV1o1o464ZfmQQQB7sjw7c+mwcNUcYOW9YA992NLT74dOz6d/x9/3IIeYpduiHL0Uforvq3UBI2vMIAAgZfQxjpg5ZafSr1/+NoE64T/3ndCGwYhtBqNtQlLBNoT+8dleYuZynaeTez/I2vDzC/HoZtMBZrjn/r7FZFsOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tTPQUyIm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tTPQUyIm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flGMg0Vlxz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 16:07:42 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UESO8v115373;
	Tue, 31 Mar 2026 05:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mKXCNY
	CP6gqE0JnBljQXUiy7ssQpocmU/ho1y7WXCjU=; b=tTPQUyImzq2o2PWSIiJRJz
	rTWJ/cSDpwyw/RZhtOhim+SQL0JoSx7ZupHhUMCYsEf+z/0veIMA6L5vQ3RVNyZ7
	M33I5VBsnl3G4zvXKsPr4BTTj8dCNW2GjDfjUX96uxUhvrrtX45sHO7qukG1eFG/
	njIqtm4Hdz6gPfFa3whtFmIvjz/esP0/1YvROWGAOnpjXY7LYx0+jynD9Zd6XNTz
	R+ogTVeFO3LOh5YHkTppHhEaBVjmn1J4oRg+O9zxJNQzlQgknbwElkXYhrr0jK0O
	arwgCXHjOWfWAToPxfzhhtOAP8wHpTk8VTDAG+fInkk6kNCdAai04Nl77vHnEWTQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q31qqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:07:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V13JJU022210;
	Tue, 31 Mar 2026 05:07:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamyn3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:07:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V57L6746268722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 05:07:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA9B92004B;
	Tue, 31 Mar 2026 05:07:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16BCF20043;
	Tue, 31 Mar 2026 05:07:20 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 05:07:19 +0000 (GMT)
Message-ID: <c953ad0b-df8a-4503-8ca1-d9bf5b285dc9@linux.ibm.com>
Date: Tue, 31 Mar 2026 10:37:18 +0530
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
Subject: Re: [PATCH v6 1/2] powerpc64/bpf: Implement JIT support for private
 stack
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
References: <20260331080309.173612-1-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260331080309.173612-1-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SLALUgtp3H_cQvS5mbTPpAE7ixsHaSl1
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cb568f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=03qNDuP-edZBIY4nEDcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SLALUgtp3H_cQvS5mbTPpAE7ixsHaSl1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0MyBTYWx0ZWRfX9Ha2Ln2OLKCv
 fbVFO+jXDyk6UOf+pUVuAsR4zjRo75tgaoWKbfXVJgOC8OQmYE5WXjXhHghuvw38p7B7FUPNaWH
 +Yv0jIFGIaqUGVsaPNS5mJPqbscaplueScSYxiJqF7/XSb2Jm4awAaKT0rRZs05LMjICDJ1bpBj
 wUjDj0CRZtL8Ouc4inCzliFs9NuR+W2xsl7BkNcP5L+r3UUrJh2srT59N6vU3PuqCf0Y1N3h1z4
 F0MVHhyJWvR9hCYPrI6RTKp/Q5nR2PzT/5+MzRtXBYhKD4AlvnUgSgWoreTmhP7y6UobSHzRhfl
 qE4tKd8iS56hD7NINmLKVNtF+szDM3Azyc+aix0kvHEuY66hFQs/h4ssV3mSJAlckViouNAgMPl
 Tdutx8waqKovDJNCTWo5G3MtYUdB6Ce2S65+swMMZ4LTv5/5+Uxh9e1BGqYJJ2Yjz5IeHMtAl2g
 Kfycj3E+eij+08VhDqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310043



On 31/03/26 1:33 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Provision the private stack as a per-CPU allocation during
> bpf_int_jit_compile(). Align the stack to 16 bytes and place guard
> regions at both ends to detect runtime stack overflow and underflow.
> 
> Round the private stack size up to the nearest 16-byte boundary.
> Make each guard region 16 bytes to preserve the required overall
> 16-byte alignment. When private stack is set, skip bpf stack size
> accounting in kernel stack.
> 
> There is no stack pointer in powerpc. Stack referencing during JIT
> is done using frame pointer. Frame pointer calculation goes like:
> 
> BPF frame pointer = Priv stack allocation start address +
>                      Overflow guard +
>                      Actual stack size defined by verifier
> 
> Memory layout:
> 
> High Addr          +--------------------------------------------------+
>                     |                                                  |
>                     | 16 bytes Underflow guard (0xEB9F12345678eb9fULL) |
>                     |                                                  |
>           BPF FP -> +--------------------------------------------------+
>                     |                                                  |
>                     | Private stack - determined by verifier           |
>                     | 16-bytes aligned                                 |
>                     |                                                  |
>                     +--------------------------------------------------+
>                     |                                                  |
> Lower Addr         | 16 byte Overflow guard (0xEB9F12345678eb9fULL)   |
>                     |                                                  |
> Priv stack alloc ->+--------------------------------------------------+
> start
> 
> Update BPF_REG_FP to point to the calculated offset within the
> allocated private stack buffer. Now, BPF stack usage reference
> in the allocated private stack.
> 
> v5->v6:
>    No change
> v4->v5:
>    Rebasing over latest changes
> v3->v4:
>    Added new field to fix priv_stack allocation
> v2->v3:
>    Fix ci-bot bug targeting clobbered NVRs on stack rollback
> v1->v2:
>    Fix ci-bot warning for percpu pointer casting
>    Minor refactoring
> 
> [v5]: https://lore.kernel.org/bpf/20260330232034.44776-1-adubey@linux.ibm.com
> [v4]: https://lore.kernel.org/bpf/20260226031324.17352-1-adubey@linux.ibm.com
> [v3]: https://lore.kernel.org/bpf/20260226005440.9570-1-adubey@linux.ibm.com
> [v2]: https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com
> [v1]: https://lore.kernel.org/bpf/20260216152234.36632-1-adubey@linux.ibm.com
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        |  6 ++
>   arch/powerpc/net/bpf_jit_comp.c   | 97 +++++++++++++++++++++++++++++--
>   arch/powerpc/net/bpf_jit_comp64.c | 29 ++++++++-
>   3 files changed, 124 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 7354e1d72f79..a232f3fb73be 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -178,8 +178,14 @@ struct codegen_context {
>   	bool is_subprog;
>   	bool exception_boundary;
>   	bool exception_cb;
> +	void __percpu *priv_sp;
> +	unsigned int priv_stack_size;
>   };
>   
> +/* Memory size & magic-value to detect private stack overflow/underflow */
> +#define PRIV_STACK_GUARD_SZ    16
> +#define PRIV_STACK_GUARD_VAL   0xEB9F12345678eb9fULL
> +
>   #define bpf_to_ppc(r)	(ctx->b2p[r])
>   
>   #ifdef CONFIG_PPC32
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index a62a9a92b7b5..2018260f56c6 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -129,25 +129,60 @@ bool bpf_jit_needs_zext(void)
>   	return true;
>   }
>   
> +static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
> +{
> +	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
> +	u64 *stack_ptr;
> +
> +	for_each_possible_cpu(cpu) {
> +		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
> +		stack_ptr[0] = PRIV_STACK_GUARD_VAL;
> +		stack_ptr[1] = PRIV_STACK_GUARD_VAL;
> +		stack_ptr[underflow_idx] = PRIV_STACK_GUARD_VAL;
> +		stack_ptr[underflow_idx + 1] = PRIV_STACK_GUARD_VAL;
> +	}
> +}
> +
> +static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size,
> +								struct bpf_prog *fp)
> +{
> +	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
> +	u64 *stack_ptr;
> +
> +	for_each_possible_cpu(cpu) {
> +		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
> +		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
> +			stack_ptr[1] != PRIV_STACK_GUARD_VAL ||
> +			stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL ||
> +			stack_ptr[underflow_idx + 1] != PRIV_STACK_GUARD_VAL) {
> +			pr_err("BPF private stack overflow/underflow detected for prog %s\n",
> +			bpf_jit_get_prog_name(fp));
> +			break;
> +		}
> +	}
> +}
> +
>   struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   {
>   	u32 proglen;
>   	u32 alloclen;
>   	u8 *image = NULL;
> -	u32 *code_base;
> -	u32 *addrs;
> -	struct powerpc_jit_data *jit_data;
> +	u32 *code_base = NULL;
> +	u32 *addrs = NULL;
> +	struct powerpc_jit_data *jit_data = NULL;
>   	struct codegen_context cgctx;
>   	int pass;
>   	int flen;
> +	int priv_stack_alloc_size;
> +	void __percpu *priv_stack_ptr = NULL;
>   	struct bpf_binary_header *fhdr = NULL;
>   	struct bpf_binary_header *hdr = NULL;
>   	struct bpf_prog *org_fp = fp;
> -	struct bpf_prog *tmp_fp;
> +	struct bpf_prog *tmp_fp = NULL;
>   	bool bpf_blinded = false;
>   	bool extra_pass = false;
>   	u8 *fimage = NULL;
> -	u32 *fcode_base;
> +	u32 *fcode_base = NULL;
>   	u32 extable_len;
>   	u32 fixup_len;
>   
> @@ -173,6 +208,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   		fp->aux->jit_data = jit_data;
>   	}
>   
> +	priv_stack_ptr = fp->aux->priv_stack_ptr;
> +	if (!priv_stack_ptr && fp->aux->jits_use_priv_stack) {
> +		/*
> +		 * Allocate private stack of size equivalent to
> +		 * verifier-calculated stack size plus two memory
> +		 * guard regions to detect private stack overflow
> +		 * and underflow.
> +		 */
> +		priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
> +							2 * PRIV_STACK_GUARD_SZ;
> +		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_size, 16, GFP_KERNEL);
> +		if (!priv_stack_ptr) {
> +			fp = org_fp;
> +			goto out_priv_stack;
> +		}
> +
> +		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_size);
> +		fp->aux->priv_stack_ptr = priv_stack_ptr;
> +	}
> +
>   	flen = fp->len;
>   	addrs = jit_data->addrs;
>   	if (addrs) {
> @@ -209,6 +264,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	cgctx.is_subprog = bpf_is_subprog(fp);
>   	cgctx.exception_boundary = fp->aux->exception_boundary;
>   	cgctx.exception_cb = fp->aux->exception_cb;
> +	cgctx.priv_sp = priv_stack_ptr;
> +	cgctx.priv_stack_size = 0;
> +	if (priv_stack_ptr) {
> +		/*
> +		 * priv_stack_size required for setting bpf FP inside
> +		 * percpu allocation.
> +		 * stack_size is marked 0 to prevent allocation on
> +		 * general stack and offset calculation don't go for
> +		 * a toss in bpf_jit_stack_offsetof() & bpf_jit_stack_local()
> +		 */
> +		cgctx.priv_stack_size = cgctx.stack_size;
> +		cgctx.stack_size = 0;
> +	}
>   
>   	/* Scouting faux-generate pass 0 */
>   	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> @@ -306,6 +374,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   		}
>   		bpf_prog_fill_jited_linfo(fp, addrs);
>   out_addrs:
> +		if (!image && priv_stack_ptr) {
> +			fp->aux->priv_stack_ptr = NULL;
> +			free_percpu(priv_stack_ptr);
> +		}
> +out_priv_stack:
>   		kfree(addrs);
>   		kfree(jit_data);
>   		fp->aux->jit_data = NULL;
> @@ -419,6 +492,8 @@ void bpf_jit_free(struct bpf_prog *fp)
>   	if (fp->jited) {
>   		struct powerpc_jit_data *jit_data = fp->aux->jit_data;
>   		struct bpf_binary_header *hdr;
> +		void __percpu *priv_stack_ptr;
> +		int priv_stack_alloc_size;
>   
>   		/*
>   		 * If we fail the final pass of JIT (from jit_subprogs),
> @@ -432,6 +507,13 @@ void bpf_jit_free(struct bpf_prog *fp)
>   		}
>   		hdr = bpf_jit_binary_pack_hdr(fp);
>   		bpf_jit_binary_pack_free(hdr, NULL);
> +		priv_stack_ptr = fp->aux->priv_stack_ptr;
> +		if (priv_stack_ptr) {
> +			priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
> +							2 * PRIV_STACK_GUARD_SZ;
> +			priv_stack_check_guard(priv_stack_ptr, priv_stack_alloc_size, fp);
> +			free_percpu(priv_stack_ptr);
> +		}
>   		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>   	}
>   
> @@ -453,6 +535,11 @@ bool bpf_jit_supports_kfunc_call(void)
>   	return IS_ENABLED(CONFIG_PPC64);
>   }
>   
> +bool bpf_jit_supports_private_stack(void)
> +{
> +	return IS_ENABLED(CONFIG_PPC64);
> +}
> +
>   bool bpf_jit_supports_arena(void)
>   {
>   	return IS_ENABLED(CONFIG_PPC64);


> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index c5e26d231cd5..8101e098d125 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -183,6 +183,22 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
>   {
>   }
>   
> +static void emit_fp_priv_stack(u32 *image, struct codegen_context *ctx)
> +{
> +	/* Load percpu data offset */
> +	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R13,
> +			offsetof(struct paca_struct, data_offset)));
> +	PPC_LI64(bpf_to_ppc(BPF_REG_FP), (__force long)ctx->priv_sp);
> +	/*
> +	 * Load base percpu pointer of private stack allocation.
> +	 * Runtime per-cpu address = (base + data_offset) + (guard + stack_size)
> +	 */
> +	EMIT(PPC_RAW_ADD(bpf_to_ppc(BPF_REG_FP),
> +			bpf_to_ppc(TMP_REG_1), bpf_to_ppc(BPF_REG_FP)));
> +	EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), bpf_to_ppc(BPF_REG_FP),
> +			PRIV_STACK_GUARD_SZ + round_up(ctx->priv_stack_size, 16)));
> +}

This will fail for !CONFIG_SMP case.

This change on top of th patch should fix it:

diff --git a/arch/powerpc/net/bpf_jit_comp64.c 
b/arch/powerpc/net/bpf_jit_comp64.c
index 8101e098d125..2971dafaa5d1 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -185,16 +185,18 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)

  static void emit_fp_priv_stack(u32 *image, struct codegen_context *ctx)
  {
-	/* Load percpu data offset */
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R13,
-			offsetof(struct paca_struct, data_offset)));
  	PPC_LI64(bpf_to_ppc(BPF_REG_FP), (__force long)ctx->priv_sp);
+
  	/*
  	 * Load base percpu pointer of private stack allocation.
  	 * Runtime per-cpu address = (base + data_offset) + (guard + stack_size)
  	 */
+#ifdef CONFIG_SMP
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R13,
+			offsetof(struct paca_struct, data_offset)));
  	EMIT(PPC_RAW_ADD(bpf_to_ppc(BPF_REG_FP),
  			bpf_to_ppc(TMP_REG_1), bpf_to_ppc(BPF_REG_FP)));
+#endif
  	EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), bpf_to_ppc(BPF_REG_FP),
  			PRIV_STACK_GUARD_SZ + round_up(ctx->priv_stack_size, 16)));
  }

Except for the above change, rest of the patch looks good to me.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> +
>   /*
>    * For exception boundary & exception_cb progs:
>    *     return increased size to accommodate additional NVRs.
> @@ -307,9 +323,16 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>   	 * Exception_cb not restricted from using stack area or arena.
>   	 * Setup frame pointer to point to the bpf stack area
>   	 */
> -	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
> -		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
> -			STACK_FRAME_MIN_SIZE + ctx->stack_size));
> +	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP))) {
> +		if (ctx->priv_sp) {
> +			/* Set up fp in private stack */
> +			emit_fp_priv_stack(image, ctx);
> +		} else {
> +			/* Setup frame pointer to point to the bpf stack area */
> +			EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
> +				STACK_FRAME_MIN_SIZE + ctx->stack_size));
> +		}
> +	}
>   
>   	if (ctx->arena_vm_start)
>   		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);


