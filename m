Return-Path: <linuxppc-dev+bounces-19148-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F13D35179
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 12:09:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm3gs5cGNz2xpk;
	Wed, 01 Apr 2026 23:09:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775045369;
	cv=none; b=jeroMuBeQm6wI6qppSXHWXbcx5wRjtJ1z72QSRzT3BFDg6nruMxMld1mwX3M1ZmnIT3vjk2w0KW1fTRnK6aqbCGxNDlVgpjmA45Ja/11m6HEpo86HxP91XahXtmJEPxJ43v1FBrfe2i+R0tK6tp3GZIaoWXGnG6gBLWGE2yZSCIF2v8xAtEX8STmFtWXYs07BCXM8vjGBIV9C14yxXtEzOpCKO+S3em9w2+fwyqgX7EJJE533etCbnKwAeJvaunNFtMtLDNdzcXJFbOkKbLt1ahtOBHmlbrgoJd0C5woAJRceXgB5CW3a+Lofopp67wkhKr97L2S8sbPLlkLWRd30g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775045369; c=relaxed/relaxed;
	bh=bLaKYg7cW+DfVdy+wjH9OPaOx5lGM/QWJwUacRZzvWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0qCjpFfr01kwmFKLm+P9PfYBRCOB2+3ic1OVHqV70yTF/WL9ntDK51eneQMX58dcT4PY85r+Jfv3ZU2b8/odb7I5+dxrTCng/Z1JD04AUSVzuqwpPn9lpaJpD5R7Uz3YncHG9ini33JVuZsfGJAaXiYas0tqP19qtHD9JKrIy7EEchZr0ihY3Gc1yfhx0qT3xvmMKbUHsBFSNJ0dtWNmxjNzHk7s/x6mFTbs8CErkMDMfLpP4hsMOGJ6llnO608kRbTri3q/0cI3iER6hZzk5p6zIbpPoljlf+erzeDFQGE0oEgUktEeh3SFLzL2+KBm2mE7W7qBIwmRJx3f49CNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NCOOOrgz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NCOOOrgz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm3gs04Kpz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 23:09:28 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631Bm9Fx354949;
	Wed, 1 Apr 2026 12:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bLaKYg
	7cW+DfVdy+wjH9OPaOx5lGM/QWJwUacRZzvWU=; b=NCOOOrgztQaRVMlZSD3qfi
	PJLBYE1HzSeC13aXjz+3q2UaUr6CrZKyKuXRhxE9hAKvWqkXDShFrpaIL1THrwdT
	w1NfBi6xVLjkKi0jIRh1b8Uo9k9Q18HUgAuuuMHm0Lbc8oyEMRbQ8iPp9mwZivdA
	P722n6uHS/1PM3Uf5LtiN+bNUG7ThLviJtQ8SwRDVYtfwVex3qL2owJKVrbuSXed
	KiM6WWVJED+DNHGpJ4cOI5AtjZJ1Bo6hHYPXgacSmYRN+m2JDU0tMDBSEiD7hnqb
	TPZ9W926Phuls59PzRbGE9kiNG3Kds5DCSd9LHmQyCvY4OF6lVa5fZdu7ndHA7Cg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgqe15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:09:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631B6lpw006362;
	Wed, 1 Apr 2026 12:09:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy5hjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:09:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631C99jj12059134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 12:09:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B36062005A;
	Wed,  1 Apr 2026 12:09:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D663A20040;
	Wed,  1 Apr 2026 12:09:07 +0000 (GMT)
Received: from [9.39.18.157] (unknown [9.39.18.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 12:09:07 +0000 (GMT)
Message-ID: <c7a0e88f-3d12-44db-8078-f14c0a7554b6@linux.ibm.com>
Date: Wed, 1 Apr 2026 17:39:06 +0530
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
Subject: Re: [PATCH v3 2/2] powerpc32/bpf: Add fsession support
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
References: <20260401141043.41513-1-adubey@linux.ibm.com>
 <20260401141043.41513-2-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260401141043.41513-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwOCBTYWx0ZWRfX5zDOnCeQEKLC
 /0Bk/Sp1+UEQQK7sM7FjBuOtPI2TOQKLDozc9huVgu3e/RhhRhpGNTigfjXY9a7teib4XhtHxRQ
 StPQjVazcyrI4ACkmM2dl0VK9CU88jg9Ry4exJsnWMvf4MzoLdtHU4xg0N/I/R8eHDR9Kqso9By
 ar2/m8zOD/rOgP11oLjGt+399hhH+YNlftb1lk+U7zp93Ee51L3QN1rrzMa0rxiVedfq8NzaGo0
 EKgW4+yr5xsHZTGRadiTOj6jVw8Zd00jU/Sc3NZAmnLhe55HDkA0KQWdBYQbk8EevlRe7509GEO
 vQuiEzYC+v50kpOnTJCP4grzGkmq10itxoLgeKnKa0zC91G8yftrB0xzlyS7Piz3UsOmuCpXyqY
 yz4a0GK0oBZURidGBOfKlQWZ8FFhXgaWid2jpYjaNT1YH5/TVXoto1nXbtwp3o0H8zEacBTrpct
 X7JzBzOg/zfk62eo20g==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cd0aea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ehXamiNm_enUqQWXja4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iCBLQED9R6sepAnVz6kdAdrcG-MbC_m4
X-Proofpoint-ORIG-GUID: iCBLQED9R6sepAnVz6kdAdrcG-MbC_m4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010108



On 01/04/26 7:40 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Extend JIT support of fsession in powerpc64 trampoline, since
> ppc64 and ppc32 shares common trampoline implementation.
> Arch specific helpers handle 64-bit data copy using 32 bit regs.
> 
> Need to validate fsession support along with trampoline support.
> 

LGTM.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
> 
> v2->v3:
>    Address comments around PPC_LI32
> v1->v2:
>    No change since v1
>      
> [v2]: https://lore.kernel.org/bpf/20260226041217.18059-1-adubey@linux.ibm.com
> [v1]: https://lore.kernel.org/bpf/20260216155310.38457-1-adubey@linux.ibm.com
> 
>   arch/powerpc/net/bpf_jit_comp.c   |  8 ++++++-
>   arch/powerpc/net/bpf_jit_comp32.c | 35 +++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 16d15ff3145a..b2fdf8ff9c60 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -542,7 +542,13 @@ bool bpf_jit_supports_private_stack(void)
>   
>   bool bpf_jit_supports_fsession(void)
>   {
> -	return IS_ENABLED(CONFIG_PPC64);
> +	/*
> +	 * TODO: Remove after validating support
> +	 * for fsession and trampoline on ppc32.
> +	 */
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		return -EOPNOTSUPP;
> +	return true;
>   }
>   
>   bool bpf_jit_supports_arena(void)
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 3087e744fb25..f3ae89e1d1d0 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -123,6 +123,41 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
>   	}
>   }
>   
> +void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
> +						int cookie_off, int retval_off)
> +{
> +	/*
> +	 * Set session cookies value
> +	 * Clear cookies field on stack
> +	 * Ensure retval to be cleared on fentry
> +	 */
> +	EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG), 0));
> +
> +	for (int i = 0; i < cookie_cnt; i++) {
> +		EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, cookie_off + 4 * i));
> +		EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, cookie_off + 4 * i + 4));
> +	}
> +
> +	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, retval_off));
> +	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, retval_off + 4));
> +}
> +
> +void store_func_meta(u32 *image, struct codegen_context *ctx,
> +					u64 func_meta, int func_meta_off)
> +{
> +	/*
> +	 * Store func_meta to stack: [R1 + func_meta_off] = func_meta
> +	 * func_meta := argument count in first byte + cookie value
> +	 */
> +	/* Store lower word */
> +	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)func_meta));
> +	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off));
> +
> +	/* Store upper word */
> +	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)(func_meta >> 32)));
> +	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off + 4));
> +}
> +
>   void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>   {
>   	int i;


