Return-Path: <linuxppc-dev+bounces-25508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C119AC5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:25:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDgV1hLBz30B0;
	Fri, 07 Aug 2026 03:25:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786037110;
	cv=none; b=VeS5reEpOtiZeXUYGyU88cm78vcMXs+vQ/x+AXKMY5K9EhoUyXGhcjlgrkt6+LU3MvHgyy9dW9mwKwKPbELrlcm2QQGqXk/FvBoLT4UYwJt5EegXye5DENUrTWdaCrMiUBaDM+uwBH8MVVSnyZbTd5W8whOT2s7F2cNoPTIGYwWYepOSlv36Nbu8ChVUkJlUXCq8249RJx8Ca4UR2wz84IB3bxVc/nwdlmMtApCbDyPYmcsgCuYFwplM5TVex8tTIbZYYQHGfHWpkJfQGw9hJvopNUrPlBso5P21w7fvzzEeKQlQ2wNcu5ZxC9TQyxLsPo3bxD54nmnhCPGNrgs+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786037110; c=relaxed/relaxed;
	bh=KAlIcrYTRBfhUKyGl/zvlgpGbOodyQfw3ja+BaDE6iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwE6SNTPhwsehCfSgYMZC1Qij3TvYL6PFDIe3kZon8aTv+zlAbfGKrCvs3eDe2NqgdMZOMx+9VB/MvXolKTIVuEAErOQfEzsR5Kj0+kqpm5lW8IlVmawkP51czdExrG63O+F4DwY0X43jXPhartPUvIkL7cLGKFQF3FZ4KESyovfYJwq4T0iwULOWBuedmRQ2Z3XZUmVO1hy83ly5iuTAjL3mhK4YUjwr41mtrx9COysn0xDTieZaTi21WtU6xdWFfoaqbXAMVcnGoInPwVVOQ2Il/vzlIJ0bJ72seLtI8nFKqbddB5wkQSORzzSRAiFt5e2YZqz8lfgjdddmjvTRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AgO/aNbm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AgO/aNbm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDgT4TdHz309w
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:25:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HI4aV3266388;
	Thu, 6 Aug 2026 17:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KAlIcr
	YTRBfhUKyGl/zvlgpGbOodyQfw3ja+BaDE6iA=; b=AgO/aNbmIs8rPql888zUsa
	8OJJUxepASLBBzE8NpE3T90tlvVISW4ZkAevTKNDiXgUxGb4Emk/ulc8QChcWdXe
	WJP73sXFmysVLz5lODwKOOpAtIWMX0oGruBfTMC2AmyQpFRn30lWvtKJ3yoWqoeC
	Lw80XpQekMN6EmRuxllDOJrcWH3afryUub3n9sHv/lS7uojBE4idDXHyly17PSBp
	3YYAoTfm2xIQEQymM7sY+A9N8jqOqV7uGwSBtEIL/6a1w8muwwYdPFVcjJYHwXRf
	xbCTkDP5kEO3z+CQBz/hq3O82YcZhCljJSdV2Z1OuDJkio7FDWWSwfFH2uSov+Hg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a49ht9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:24:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HBGXT023332;
	Thu, 6 Aug 2026 17:24:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyuya6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:24:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HOltw49742292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:24:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4C0920043;
	Thu,  6 Aug 2026 17:24:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AABA2005A;
	Thu,  6 Aug 2026 17:24:44 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:24:44 +0000 (GMT)
Message-ID: <ff0fafc4-6c36-4e48-a2af-b296874b20e2@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:54:42 +0530
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
Subject: Re: [PATCH v10 5/8] powerpc64/bpf: fix compare instruction emitted
 for tailcall
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <43017d115c0398b22284c38b2a30d53753560f7d.1785906979.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <43017d115c0398b22284c38b2a30d53753560f7d.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a74c363 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=IFb2yVPMPt_hoG6OzaQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HafaYT45B6gagC8Pa3oBw77lfYPKZUCq
X-Proofpoint-GUID: HafaYT45B6gagC8Pa3oBw77lfYPKZUCq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX3V5cJHdVE6gZ
 PgQjZ353QxQzO5hsWFK/yyjNw6MYAVx9w/FqY1iSNZe/EiPzyhDexI6I5L6t2tFVEqvynwNlcrO
 /M3lZSzGC6DXbNsuPtNX3xzANJd2r3s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX79coRpKDVr+Z
 CxlOgAIwoN92TqtQIonnI21JyVdinKMtOTnlwrjKDdA0wXvMJYrfKAQ+PYjGpzrPg/qZynx2v3U
 GV7pddyKex/9Siivb/9uEG/2tGCfNTeta4au8os00xRJphLg8zD8s/fgCCmyuyoYLAhUHbUEIue
 hZI3z/6SknfPyiIyW+nefwlhtzPu9HZKhFNzMxh5qqHa0yHI1HRJXJfblH+rAOaxLXylnQzfekN
 1pOfCJJEUrg+XSIgRuTpaZIcC0e8wBSb/4DFtJkeEFrRH3RAny2waIXk52OP9Zgif0hRC/BnwWb
 kA7o+9f09Wt5H2DMYV+eBR3Z2Z94mwC2IfSS1KVzI4I3tQgu2UqVdKLjNp+wHMXv0xO1Z3mt27D
 cmPNoFIYEx/AwXUT2/LPiAylkDsubRg6xegxx9dzDI+O3eG67iPypFJb7tLPYjMiuOmUijhjjPw
 g5grxzzZh4WedmfYoIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060135



On 05/08/26 11:37 am, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The tail_call_info field can contain either a scalar counter
> value or a 64-bit pointer to the counter, using a 32-bit
> compare (cmplwi) only checks the lower 32 bits, which can lead
> to incorrect comparisions when location of counter is near 4GB
> boundary. Use instruction cmpldi/cmplwi for accurate comparision
> in corresponding cases.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
> Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        | 6 ++++++
>   arch/powerpc/net/bpf_jit_comp.c   | 2 +-
>   arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
>   3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 6632de9871dd..af510da12d8e 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -188,6 +188,12 @@ struct codegen_context {
>   
>   #define bpf_to_ppc(r)	(ctx->b2p[r])
>   
> +#ifdef CONFIG_PPC64
> +#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLDI(a, i)
> +#else
> +#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLWI(a, i)
> +#endif
> +
>   #ifdef CONFIG_PPC32
>   #define BPF_FIXUP_LEN	3 /* Three instructions => 12 bytes */
>   #else
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 5d559d613f3a..8be5ded13a4a 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -768,7 +768,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
>   		 * Setting the tail_call_info in trampoline's frame
>   		 * depending on if previous frame had value or reference.
>   		 */
> -		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
> +		EMIT(PPC_RAW_CMPLLI(_R3, MAX_TAIL_CALL_CNT));
>   		PPC_BCC_CONST_SHORT(COND_GT, 8);
>   		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 951eb10ca1f6..e80312171aa7 100644
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
> @@ -662,7 +662,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	PPC_BCC_SHORT(COND_GE, out);
>   
>   	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_CONST_SHORT(COND_LE, 8);
>   
>   	/* dereference TMP_REG_1 */
> @@ -672,7 +672,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
>   	 *   goto out;
>   	 */
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_SHORT(COND_EQ, out);
>   
>   	/*
> @@ -707,7 +707,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	 * tail_call_info.
>   	 */
>   	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_CONST_SHORT(COND_GT, 8);
>   
>   	/* First get address of tail_call_info */


