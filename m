Return-Path: <linuxppc-dev+bounces-16235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F010D74EC0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 12:49:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyHnZ2FP0z2xKh;
	Fri, 23 Jan 2026 23:49:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769172578;
	cv=none; b=TzorkD6xceBonQS9R4yMj8ndlzCP84k3r1+6Q1gevMEkxqgefdM+CYrzh9dy/UkXZgbs4NNQO/R6955rFQ1SxppzxnTRiDmQaWJvXGpA0+yAjZZdssY2o7kUzBjezH0QMFVm0MdbKDCOoDwQXQbaNhLe1qEmgfbzbkcU5BnAoAV+qZexBJM6xGphjdRwtLy2tzZtTlIAtakz2Ts9qEuMqgsTxppy7tyxN2FsISSDHS1u8skbYhS/j1oPolYjQXyesxDnLWRPWdMXdfmM0cOdOLjz0dIVCgh2FobHwQV77AIh0EknM7wf9d49V71Gm1DOGN4hyR1KsV5rmNdVvFWWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769172578; c=relaxed/relaxed;
	bh=fzP6cpM1UJUMnw4ffhC9p8IiUwd++yajpBWDENdKRAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY6VfL0qHBPm2EtXWlJj34L3AH7X1+PLrrv7gGs3onT4lCZ3kHVcl4+A+I5v+lwVSx3TmEK+gCvL/dYzy9Nh/mzeuJZuyD308ZihYuIZbdViwx1LYwKZrcn/7TCLuAIgoTMMOUwxQXN5Wq02oSi8zmgkuirY2wEI5BzGsPQzhkbTK7oM6fWiIUFBOEDI7LapNggOLIc2PSnegKbToj9JPEBCD6bH2cZLydxPJgVovr1efMSjorZqqZ1SG/Y9wh19e53qX6DPdrdCUFy4kbp4ca1qzz6143wOaMg1KKhjDyJMgMjnoWfyj8MEQCpoPuj5ncFU4PBy8x+PCH4dPA92fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G/lQmOrx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G/lQmOrx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyHnY3KThz2xHt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 23:49:37 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NAUIi3007750;
	Fri, 23 Jan 2026 12:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fzP6cp
	M1UJUMnw4ffhC9p8IiUwd++yajpBWDENdKRAA=; b=G/lQmOrxjSgp2hIZGmo9N9
	DRuPiTUSKJmifBQPXd2bNxwMtjWhHfR2ilLS4lRzaAp/9hSy+r2fMs7a5qGKsOQF
	M6RplOKrGGJe8lxSoSG1KyLTgFcGl4s4Cu0KEgL/J+fMQ4LgHMDzeWZfAqeObZ4J
	1UGWwITxrGA2GRrob+mNJbrqL8HFln8W/SmSCQi4iQbYuubGKqGJkfcBqiZjMEFg
	MS7O8kquBPPwfK4E9IhjVAhxpHa6qoVqkchZ6dWDtdJ9rxDT8S9scGXTEtgpwb8F
	YMLW9h+fQhtjmeGTGzpVSYuLjmhQnglzosm9iSqWC9jpRScsHda1BVkoq0X+ba8A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukpbtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 12:49:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60NCeIxY002809;
	Fri, 23 Jan 2026 12:49:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukpbtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 12:49:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NCJUk2006427;
	Fri, 23 Jan 2026 12:49:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf20ryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 12:49:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60NCn3Nd48824616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:49:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9900F20043;
	Fri, 23 Jan 2026 12:49:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C8C20040;
	Fri, 23 Jan 2026 12:48:58 +0000 (GMT)
Received: from [9.78.106.105] (unknown [9.78.106.105])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 12:48:58 +0000 (GMT)
Message-ID: <238aa389-6c03-4695-872c-e73407cd953b@linux.ibm.com>
Date: Fri, 23 Jan 2026 18:18:57 +0530
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
Subject: Re: [PATCH v4 2/6] powerpc64/bpf: Support tailcalls with subprogs
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
References: <20260122211854.5508-1-adubey@linux.ibm.com>
 <20260122211854.5508-3-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260122211854.5508-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwNSBTYWx0ZWRfX9S/KtBeyEExW
 U8ogAtRp3UkfRm/fy/OE5t2JR3+3ex72joWBbRIzY6b3Dat+M0mSxxRSn0Sk27pixT7kdda/k8y
 A+jWVhmi2sr2YnDU/AxjtxByPV+URjt5krS6eP5v2QWUhO2zGLG68i5/JglyNw6Dbp4kPdneu/f
 fWZbCUjFQMm5sMlvRQwZVVGIrAJ2BEV9Cmq4xTX5/ztJke/cdwcUb6xLF20hl5532/RNQqNy/Ii
 E+OP4Tl5DYyT5HaCELLolXlZbmmjgtFfumLxr3BDb+6yi4iPqnKXERh8Eplvu4aQjX2GWPT1jjs
 WT1kr1pUHjS8Y1fcmo3DV3WOyOJlZQuEsKvhZnYOwtDFQdwrnyEKKq9zMOpyJBahAFsWoML6noh
 7e9zBGfX7REDHC0MoCoBEIvS3u+CEb455e43JgUYSmcWuUfu0kgf1THW5RbuzNeAQa/VPYQE3h1
 XmuYZtUE3dXv7RxZ51w==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69736e45 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iPzTbBT-8X3CtntodAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7sCcrDC7EStupvc0rxxFPQd7YV9xwy1W
X-Proofpoint-GUID: n1pCZvgEWt1CQw6T9cas5k5SxMpp3z41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230105



On 23/01/26 2:48 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Enabling tailcalls with subprog combinations by referencing
> method. The actual tailcall count is always maintained in the
> tail_call_info variable present in the frame of main function
> (also called entry function). The tail_call_info field in the
> stack frame of subprogs contains reference to the tail_call_info
> field in the stack frame of main BPF program.

Describe the changes in imperative mood..

Instead of:

"Enabling tailcalls with subprog combinations by referencing
method. The actual tailcall count is always maintained in the
tail_call_info variable present in the frame of main function
(also called entry function). The tail_call_info field in the
stack frame of subprogs contains reference to the tail_call_info
field in the stack frame of main BPF program."

use:

"Enable tailcalls support in subprogs by passing tail call count as
reference instead of value. The actual tailcall count is always
maintained in the tailcall field present in the frame of main
function (also called entry function). The tailcall field in the
stack frame of subprogs contains reference to the tailcall field
in the stack frame of main BPF program. Accordingly, rename
tail_call_cnt field in the stack layout to tail_call_info."

> 
> Dynamic resolution interprets the tail_call_info either as
> value or reference depending on the context of active frame
> while tailcall is invoked.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        | 13 ++++++
>   arch/powerpc/net/bpf_jit_comp.c   | 59 +++++++++++++++++++++++----
>   arch/powerpc/net/bpf_jit_comp64.c | 68 +++++++++++++++++++++++--------
>   3 files changed, 117 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 9f6ec00bd02e..56f56fdd4969 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -52,6 +52,13 @@
>   		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
>   	} while (0)
>   
> +/* When constant jump offset is known prior */
> +#define PPC_BCC_CONST_SHORT(cond, offset)							\
> +	do {											\
> +		BUILD_BUG_ON(offset < -0x8000 || offset > 0x7fff || (offset & 0x3));		\
> +		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));	\
> +	} while (0)
> +
>   /*
>    * Sign-extended 32-bit immediate load
>    *
> @@ -73,6 +80,10 @@
>   	} } while (0)
>   
>   #ifdef CONFIG_PPC64
> +
> +/* for gpr non volatile registers BPG_REG_6 to 10 */
> +#define BPF_PPC_STACK_SAVE	(6 * 8)
> +
>   /* If dummy pass (!image), account for maximum possible instructions */
>   #define PPC_LI64(d, i)		do {					      \
>   	if (!image)							      \
> @@ -167,6 +178,7 @@ struct codegen_context {
>   	unsigned int alt_exit_addr;
>   	u64 arena_vm_start;
>   	u64 user_vm_start;
> +	bool is_subprog;
>   };
>   
>   #define bpf_to_ppc(r)	(ctx->b2p[r])
> @@ -206,6 +218,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
>   			  struct codegen_context *ctx, int insn_idx,
>   			  int jmp_off, int dst_reg, u32 code);
>   
> +int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx);
>   #endif
>   
>   #endif
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index d51c696221d7..93355ba5382a 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -206,6 +206,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
>   	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
>   	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
> +	cgctx.is_subprog = bpf_is_subprog(fp);
>   
>   	/* Scouting faux-generate pass 0 */
>   	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> @@ -435,6 +436,11 @@ void bpf_jit_free(struct bpf_prog *fp)
>   	bpf_prog_unlock_free(fp);
>   }
>   
> +bool bpf_jit_supports_subprog_tailcalls(void)
> +{
> +	return IS_ENABLED(CONFIG_PPC64);
> +}
> +
>   bool bpf_jit_supports_kfunc_call(void)
>   {
>   	return true;
> @@ -600,15 +606,53 @@ static int invoke_bpf_mod_ret(u32 *image, u32 *ro_image, struct codegen_context
>   	return 0;
>   }
>   
> -static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_context *ctx,
> -					       int func_frame_offset, int r4_off)
> +/*

> + * Refer the label 'Generated stack layout' in this file for actual stack
> + * layout during trampoline invocation.

The above and the below comment seem to mean the same thing.
One is enough?

> + *
> + * Refer __arch_prepare_bpf_trampoline() for stack component details.



> + *
> + * The tailcall count/reference is present in caller's stack frame. Its required
> + * to copy the content of tail_call_info before calling the actual function
> + * to which the trampoline is attached.
> + */

Instead of:

"Its required to copy the content of tail_call_info before calling the
actual function to which the trampoline is attached."

use:

"The tail_call_info is saved at the same offset on the trampoline
frame for the traced function (BPF subprog/callee) to fetch it."

- Hari

