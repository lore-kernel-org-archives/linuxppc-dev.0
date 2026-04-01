Return-Path: <linuxppc-dev+bounces-19147-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C4ED3517A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 12:08:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm3ft3fWwz2xpk;
	Wed, 01 Apr 2026 23:08:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775045318;
	cv=none; b=kXmf0/1SO3wcLZIh7I/0NdpQbYD5ODlsLpkqGzbhaXXzfDFblb+GDliyt6c8p862031tykc+pr9f+U3zvNPxWUn9nPjtoCPoy3Mt4Am0fw3cgMOC1fEcIP4kfK+Rp0Qm+qGeJgzXEfmtxqTXdnYlTRLbPcVs+745X2261idzL8GU8bu5fd9GmK01UWzgCa53Jdgvtoa3pF4dsUisjAeVyE5qRgWhxP4UNLCQ+M1/TnJI/j/lP/hcLQkarOgqE2dwryAmafaUJLffk5ukObO/cztA/HYHijR1rwVEWLqWpgTQKRGFHawO6tvE0Lp9txWU9nYH0HX/eUuFsOBZ+5aW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775045318; c=relaxed/relaxed;
	bh=5f0IffibYAA3+jXPPM0BXqcimagyKLeqM75QCj5Axwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiUbBUjRTFuYElr8mBlhxvHOb2aE0tOT2S1SNve7WafkL17GjMEKKIW8cSjwL4aKueulSmsVNlwUCPff5d4/Ey90hRFrLaUhauEvImW2GD4/bKcRo2X7pIoC9YvFL6yksomN6uNzRpo66nfYvE1DCpXyUBMZjHe7q/W+dAozqAoI5dt8L4GoAK8jEPcKlAHlIbe/JVkPehSAfUgZaT1/PjJEVhksPWJzzD5CmGO8s0cm+rfSJk5nExlZ5rkTUSEK7kUTtRnG3ICBBBUS4Cy4jSK5F0rf4uTmqRXKFl3Frkh5/4+GJPuE+2CjV6eTX8YtwJP4LwbdY0442IPQ4qU/bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fk3IuFu7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fk3IuFu7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm3fs3JWyz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 23:08:37 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VK44Vl236239;
	Wed, 1 Apr 2026 12:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5f0Iff
	ibYAA3+jXPPM0BXqcimagyKLeqM75QCj5Axwg=; b=fk3IuFu7LE/I/zPNDcfMp9
	9eKiSNPB2lNwpDxbVmnum7hfBws/ERARIKjl9IPjsStnmzbjilXXFLO99amrrTzX
	jClgs0yyOPv523XbnheI3/bQzstVkDPM25thSn6OnUUxOU/I6UtP/ZFsH6ge85mt
	OpiesL7bZ6CmFvse+nOZCx0W8TuXLImVBsKDSKBPl7y4ht89TpMVF8uDzjX0bOnb
	UQNEXCbNt7C5zQOufUQ4T4LcVdYvOUWBEHQ2IF6Jvuu97oZ1jUaMsZ+PMxxfqebT
	+nOFX7i8FwFcr47cCuUrjoP5c5Ajkawz/mHT5Fr2dFQ11bLlnVToNoI2yvg9kesg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q37xmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:08:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6317ZdoT008693;
	Wed, 1 Apr 2026 12:08:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11n778-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:08:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631C8IY126214778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 12:08:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F0B820043;
	Wed,  1 Apr 2026 12:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AB3220040;
	Wed,  1 Apr 2026 12:08:16 +0000 (GMT)
Received: from [9.39.18.157] (unknown [9.39.18.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 12:08:15 +0000 (GMT)
Message-ID: <af67c86b-b84d-4054-a78d-c3368a01a9ef@linux.ibm.com>
Date: Wed, 1 Apr 2026 17:38:14 +0530
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
Subject: Re: [PATCH v3 1/2] powerpc64/bpf: Implement fsession support
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260401141043.41513-1-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260401141043.41513-1-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wwSatRe_gFWADyMT5WfeEl2fktC8-xO5
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cd0ab6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=uVQQCN5PlBYlMZYk4qIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wwSatRe_gFWADyMT5WfeEl2fktC8-xO5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwOCBTYWx0ZWRfX3h1HEDiMsDG3
 g+nV0TJmicZl0PvrRypMYIsuj5v5ye+LnLO0PtXN7TWIL2IYVV+/vTFrRp88euWKLmEPeFsFKEm
 Bb8pgcO0xOdjPUMUpA+ac4+2RcNO4Hn9hqNO39dzC/yI+lhVKnhvZyVdUWzwALLe1m0oRvamUlo
 LxIppBG4JER9lZhyUuOuJP4IvBwJl5AVDCIwbBuGtHTGwidzcOZHWsumrdYRa9B+T8wwzAipvHE
 +MKW8TC8zWmFuVc8a7APV0E57XwQLxoQOej9QY6tDGzzGa3XiIOAvA5xQFQHMj73IRVlJ8Qf3Nr
 c02YWs3Moe4re7ZUHUmXJZDVEPmaGmlpc5NKIqR+23IWjRAMyz4DCu+Mp66fxv/aWHxb/rypDZw
 MXLorlLwnzZ5NokuQdoNmo8XY/XbD+Z3RqFr5O9W1b6Lkvw245YGO+3kgmfWCR6+a1WB1ag8ee2
 ZFtOBN5A8C2FNJUkcIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010108



On 01/04/26 7:40 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Implement JIT support for fsession in powerpc64 trampoline.
> The trampoline stack now accommodate session cookies and
> function metadata in place of function argument. fentry/fexit
> programs consume corresponding function metadata. This mirrors
> existing x86 behavior and enable session cookies on powerpc64.
> 
> # ./test_progs -t fsession
> #135/1   fsession_test/fsession_test:OK
> #135/2   fsession_test/fsession_reattach:OK
> #135/3   fsession_test/fsession_cookie:OK
> #135     fsession_test:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> 

Looks good to me.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
> 
> This patch is rebased over https://lore.kernel.org/bpf/20260401103215.104438-1-adubey@linux.ibm.com
> 
> v2->v3:
>    Rebased over latest changes
>    Collected Tested-by tag
> v1->v2:
>    No change since v1
> 
> [v2]: https://lore.kernel.org/bpf/20260226041217.18059-1-adubey@linux.ibm.com
> [v1]: https://lore.kernel.org/bpf/20260216155310.38457-1-adubey@linux.ibm.com
> 
>   arch/powerpc/net/bpf_jit.h        |  4 +-
>   arch/powerpc/net/bpf_jit_comp.c   | 69 ++++++++++++++++++++++++++-----
>   arch/powerpc/net/bpf_jit_comp64.c | 25 +++++++++++
>   3 files changed, 87 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index a232f3fb73be..f32de8704d4d 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -218,7 +218,9 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
>   void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
> -
> +void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
> +								int cookie_off, int retval_off);
> +void store_func_meta(u32 *image, struct codegen_context *ctx, u64 func_meta, int func_meta_off);
>   int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
>   			  struct codegen_context *ctx, int insn_idx,
>   			  int jmp_off, int dst_reg, u32 code);
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2018260f56c6..16d15ff3145a 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -540,6 +540,11 @@ bool bpf_jit_supports_private_stack(void)
>   	return IS_ENABLED(CONFIG_PPC64);
>   }
>   
> +bool bpf_jit_supports_fsession(void)
> +{
> +	return IS_ENABLED(CONFIG_PPC64);
> +}
> +
>   bool bpf_jit_supports_arena(void)
>   {
>   	return IS_ENABLED(CONFIG_PPC64);
> @@ -812,12 +817,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   					 struct bpf_tramp_links *tlinks,
>   					 void *func_addr)
>   {
> -	int regs_off, nregs_off, ip_off, run_ctx_off, retval_off, nvr_off, alt_lr_off, r4_off = 0;
> +	int regs_off, func_meta_off, ip_off, run_ctx_off, retval_off;
> +	int nvr_off, alt_lr_off, r4_off = 0;
>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>   	int i, ret, nr_regs, retaddr_off, bpf_frame_size = 0;
>   	struct codegen_context codegen_ctx, *ctx;
> +	int cookie_off, cookie_cnt, cookie_ctx_off;
> +	int fsession_cnt = bpf_fsession_cnt(tlinks);
> +	u64 func_meta;
>   	u32 *image = (u32 *)rw_image;
>   	ppc_inst_t branch_insn;
>   	u32 *branches = NULL;
> @@ -853,9 +862,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   	 *                              [ reg argN          ]
>   	 *                              [ ...               ]
>   	 *       regs_off               [ reg_arg1          ] prog_ctx
> -	 *       nregs_off              [ args count        ] ((u64 *)prog_ctx)[-1]
> +	 *       func_meta_off          [ args count        ] ((u64 *)prog_ctx)[-1]
>   	 *       ip_off                 [ traced function   ] ((u64 *)prog_ctx)[-2]
> +	 *                              [ stack cookieN     ]
>   	 *                              [ ...               ]
> +	 *       cookie_off             [ stack cookie1     ]
>   	 *       run_ctx_off            [ bpf_tramp_run_ctx ]
>   	 *                              [ reg argN          ]
>   	 *                              [ ...               ]
> @@ -887,16 +898,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   	run_ctx_off = bpf_frame_size;
>   	bpf_frame_size += round_up(sizeof(struct bpf_tramp_run_ctx), SZL);
>   
> +	/* room for session cookies */
> +	cookie_off = bpf_frame_size;
> +	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> +	bpf_frame_size += cookie_cnt * 8;
> +
>   	/* Room for IP address argument */
>   	ip_off = bpf_frame_size;
>   	if (flags & BPF_TRAMP_F_IP_ARG)
>   		bpf_frame_size += SZL;
>   
> -	/* Room for args count */
> -	nregs_off = bpf_frame_size;
> +	/* Room for function metadata, arg regs count */
> +	func_meta_off = bpf_frame_size;
>   	bpf_frame_size += SZL;
>   
> -	/* Room for args */
> +	/* Room for arg regs */
>   	regs_off = bpf_frame_size;
>   	bpf_frame_size += nr_regs * SZL;
>   
> @@ -995,9 +1011,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   		EMIT(PPC_RAW_STL(_R3, _R1, retaddr_off));
>   	}
>   
> -	/* Save function arg count -- see bpf_get_func_arg_cnt() */
> -	EMIT(PPC_RAW_LI(_R3, nr_regs));
> -	EMIT(PPC_RAW_STL(_R3, _R1, nregs_off));
> +	/* Save function arg regs count -- see bpf_get_func_arg_cnt() */
> +	func_meta = nr_regs;
> +	store_func_meta(image, ctx, func_meta, func_meta_off);
>   
>   	/* Save nv regs */
>   	EMIT(PPC_RAW_STL(_R25, _R1, nvr_off));
> @@ -1011,10 +1027,28 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   			return ret;
>   	}
>   
> -	for (i = 0; i < fentry->nr_links; i++)
> +	if (fsession_cnt) {
> +		/*
> +		 * Clear all the session cookies' values
> +		 * Clear the return value to make sure fentry always get 0
> +		 */
> +		prepare_for_fsession_fentry(image, ctx, cookie_cnt, cookie_off, retval_off);
> +	}
> +
> +	cookie_ctx_off = (regs_off - cookie_off) / 8;
> +
> +	for (i = 0; i < fentry->nr_links; i++) {
> +		if (bpf_prog_calls_session_cookie(fentry->links[i])) {
> +			u64 meta = func_meta | (cookie_ctx_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
> +
> +			store_func_meta(image, ctx, meta, func_meta_off);
> +			cookie_ctx_off--;
> +		}
> +
>   		if (invoke_bpf_prog(image, ro_image, ctx, fentry->links[i], regs_off, retval_off,
>   				    run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET))
>   			return -EINVAL;
> +	}
>   
>   	if (fmod_ret->nr_links) {
>   		branches = kcalloc(fmod_ret->nr_links, sizeof(u32), GFP_KERNEL);
> @@ -1076,12 +1110,27 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   		image[branches[i]] = ppc_inst_val(branch_insn);
>   	}
>   
> -	for (i = 0; i < fexit->nr_links; i++)
> +	/* set the "is_return" flag for fsession */
> +	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
> +	if (fsession_cnt)
> +		store_func_meta(image, ctx, func_meta, func_meta_off);
> +
> +	cookie_ctx_off = (regs_off - cookie_off) / 8;
> +
> +	for (i = 0; i < fexit->nr_links; i++) {
> +		if (bpf_prog_calls_session_cookie(fexit->links[i])) {
> +			u64 meta = func_meta | (cookie_ctx_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
> +
> +			store_func_meta(image, ctx, meta, func_meta_off);
> +			cookie_ctx_off--;
> +		}
> +
>   		if (invoke_bpf_prog(image, ro_image, ctx, fexit->links[i], regs_off, retval_off,
>   				    run_ctx_off, false)) {
>   			ret = -EINVAL;
>   			goto cleanup;
>   		}
> +	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		if (ro_image) /* image is NULL for dummy pass */
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 6670d8c69ade..d9038c468af6 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -179,6 +179,31 @@ static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
>   	BUG();
>   }
>   
> +void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
> +				int cookie_off, int retval_off)
> +{
> +	EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG_1), 0));
> +
> +	for (int i = 0; i < cookie_cnt; i++)
> +		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, cookie_off + 8 * i));
> +	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, retval_off));
> +}
> +
> +void store_func_meta(u32 *image, struct codegen_context *ctx,
> +					u64 func_meta, int func_meta_off)
> +{
> +	/*
> +	 * Store func_meta to stack at [R1 + func_meta_off] = func_meta
> +	 *
> +	 * func_meta :
> +	 *	bit[63]: is_return flag
> +	 *	byte[1]: cookie offset from ctx
> +	 *	byte[0]: args count
> +	 */
> +	PPC_LI64(bpf_to_ppc(TMP_REG_1), func_meta);
> +	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, func_meta_off));
> +}
> +
>   void bpf_jit_realloc_regs(struct codegen_context *ctx)
>   {
>   }


