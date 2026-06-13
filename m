Return-Path: <linuxppc-dev+bounces-22604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E66CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jun 2026 12:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcwxv6r5sz3brN;
	Sat, 13 Jun 2026 22:42:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781354531;
	cv=none; b=i1oH8IMkKAOODRFNei8JcwwTzE3nkIaou7LDHdMsD9V8dt503ugolAAASrz4W8badnRrJGVuSKcSia1eGMybRvD3bvZLT9zuA+0V4Nso1E/N9nfE3Jzdwg8OgIHspMx9IHlaI5NlcUItkklhrbsqL8G69g47VcQy3IwoUp1A95pmfqXCfHJP0tYju9CYUrSliP1mcz4NyAz5EaKYCrYQg52P1bIltYSVfPHAgWCNLWJHtMyyXwEyPHwQtuXK9diNjVmBF9gyPshPy4gt+CKzRoU/PuK00LKZLf7vqGJYfLvAB6BpFjD4XMIH3pcTLKS2MNbz3e67oqlTDzoz72HP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781354531; c=relaxed/relaxed;
	bh=Na7RqiBJhihiYPsVNYGmOwZKNNGyi+WpWaMCjqMszWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUVInxnvtXKg8kV8VF6ob3T1JlOofXrqbatezP6liGjOcvpRBi4+ZSfuRVJG3+qHmOgQr5Q9m94aGrPuHhekXTgEp2OJzbiLQ11RwQZvHtryK8kMKaAV2BiWhTIPmfyE+jQMYSj4eqg4NH13WtmYSnIWrn71tFPGWtFHiADEGKq6lyBqJYZaGd7YT9Gmex8AHKCWeC0/gNC641kycAAqarlbmYE3R1AwJxXOh82ucm/pO6F6m0KLA+yN4B8xLYEvSmBuDme1hPwoQ/TRxE24s8ZUPFL94kFN8TlRNpCzzsjldeVD+EEWNrquBCR/UP6nD2AN5sR5uZwGS4FUzltQxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nnf7xlPF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nnf7xlPF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcwxv1SYBz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 22:42:11 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBINOa619452;
	Sat, 13 Jun 2026 12:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Na7Rqi
	BJhihiYPsVNYGmOwZKNNGyi+WpWaMCjqMszWY=; b=nnf7xlPFp4pWotAW3GiYtT
	kpuU43Xbt+l5YevqX58VKwr/m8O0WMnORoI+XdJ3Tn/Ik/ymL21vRkjYFP1kG61g
	HJq2VPoo28Z6Eq69+hfIloeEf7UO0CbvvQIi5Qzi+30ngKjimxrEl3K+e9e9E7N4
	sgLUKfX0KuovU9wiDJHOqpbhA0ZZue9//qmlz4nM98aCRg7m9BwHQ0BvLPeDTrfA
	E7JmTn386mW+zb1LZsFH4AfHAm30M1kbvSjlxWU32oQOU63ZkB2zfwJhRj2rV6Md
	tH45zNxS7gU3p36lq1W56Fh+xwKq7qnCcybukKmFIRZSKgfmaVbg11TuCIPFntHQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u08p3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:41:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65DCYgOf023966;
	Sat, 13 Jun 2026 12:41:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe093xv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:41:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65DCfqT550266530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jun 2026 12:41:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 960F220043;
	Sat, 13 Jun 2026 12:41:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3860520040;
	Sat, 13 Jun 2026 12:41:49 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jun 2026 12:41:48 +0000 (GMT)
Message-ID: <5c095e3d-d554-4506-9dbc-96d568b4be5e@linux.ibm.com>
Date: Sat, 13 Jun 2026 18:11:47 +0530
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
Subject: Re: [PATCH v7 5/7] powerpc64/bpf: fix compare instruction emitted for
 tailcall
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        sashiko-bot@kernel.org
References: <20260611153826.31187-1-adubey@linux.ibm.com>
 <20260611153826.31187-6-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260611153826.31187-6-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: It8VuGnaUphzuVkLwNy0XFUTl2IhfmpK
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2d5015 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rha8zzndkR0rUmMabLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfXwA6B2gpMh0Oi
 yv/YeFNSPBXBDO91Z3R10fO3bt7cbdNWNtERwnpmwQGZBbAmvQwfUDIAXNYpqafhj+tUixRQWgt
 WHo3stEYhZ3vDbZVU5KoDW8owhXuOcrdHVqmLjJyRnJmfixLZz5MTrBvseOvD7nAW3fs+vmRDB6
 DhE1yvDJYC1iB9nsfrgDeki6d+PwM6q2ZswKc2FA21BsrHAbSqWjIQQ4DMitTUpHsNey5jzrt95
 fry0BN8pZYqrhy1ZpthzmbTEl2QHJhZ7vCFutQH/A9eCJauG6w4GRfMQ+e13n5OT1DijTjJHLfA
 CUMU3UMl5QdY0BvHxawXBLi/T8U6f6FqWN87DMPrxYegKqgnKIOHvV+cMcT64Lcfl5DvAh3kOCO
 /eliPCuv9ojI3O776ODeqgRacbMSTcRrDCqiJaui27aIrMi3y7KVqwHu0oRye8R+SN6EywVnnWv
 e6HaKGPZHNlk9DPvANA==
X-Proofpoint-ORIG-GUID: It8VuGnaUphzuVkLwNy0XFUTl2IhfmpK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfXxd1mWehmjgDf
 JkO16kIBJDJm/WuMJQdmJEcK/85t3TpRFtwaJ6z9lxzmX6Gv6g6u7BiToB2K7ObtGmRExbErPRB
 fDIOHgrHdX7wBz9+zFEoi4AOBL3Wqos=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130125



On 11/06/26 9:08 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The tail_call_info field can contain either a scalar counter
> value or a 64-bit pointer to the counter, using a 32-bit
> compare (cmplwi) only checks the lower 32 bits, which can lead
> to incorrect comparisions when location of counter is near 4GB
> boundary. Use instruction cmpldi for accurate comparision in
> all cases.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
> Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c   | 2 +-
>   arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index ebee23d33396..b36b55f12a8b 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -763,7 +763,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
>   		 * Setting the tail_call_info in trampoline's frame
>   		 * depending on if previous frame had value or reference.
>   		 */

> -		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
> +		EMIT(PPC_RAW_CMPLDI(_R3, MAX_TAIL_CALL_CNT));

This should be "Use cmpldi/cmplwi instruction" instead of "Use
instruction cmpldi"

This code is meant for both 32-bit and 64-bit powerpc. So, can't
simply use PPC_RAW_CMPLDI here. Instead, similar to PPC_RAW_CMPLI
& PPC_RAW_LL macros, define PPC_RAW_CMPLLI to resolve it as
PPC_RAW_CMPLDI for ppc64 and PPC_RAW_CMPLWI for ppc32..

>   		PPC_BCC_CONST_SHORT(COND_GT, 8);
>   		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index eaf816a07f14..086084abb184 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -276,7 +276,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>   		 */
>   		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
>   		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_TAILCALL)));
> -		EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +		EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   		PPC_BCC_CONST_SHORT(COND_GT, 8);
>   		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2),
>   								-(BPF_PPC_TAILCALL)));
> @@ -651,7 +651,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	PPC_BCC_SHORT(COND_GE, out);
>   
>   	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_CONST_SHORT(COND_LE, 8);
>   
>   	/* dereference TMP_REG_1 */
> @@ -661,7 +661,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
>   	 *   goto out;
>   	 */
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_SHORT(COND_EQ, out);
>   
>   	/*
> @@ -696,7 +696,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	 * tail_call_info.
>   	 */
>   	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_CONST_SHORT(COND_GT, 8);
>   
>   	/* First get address of tail_call_info */

- Hari

