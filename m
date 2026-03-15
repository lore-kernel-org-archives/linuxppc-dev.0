Return-Path: <linuxppc-dev+bounces-18203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C5FF3026D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 18:06:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYmPj5c21z2yYy;
	Mon, 16 Mar 2026 05:06:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773597993;
	cv=none; b=G50GCAB35W88robIJiSPjvJzcHNplWTYK7kejNPfx2Hsvy6njBLKxq8DK0/jMkwJo+qg5Vzl5LU5ZVfzuT8heXWYSc5MDl7sVphznQdJR0vlMl8gb5Nejx7ODThFxpoqEYT+nZH+MNYyKYbxTgLt+dza4j8MUoiIHz/95JMeZjzseguJtE/Mdwh7OgW+O3bSXvEMNTkFXOTyrypxs9ualp6/pcwVppyGzqmt3rEtjKSFxVSBZHPGOfMcnv7ma7c3tO65yOywJmADVc4Kvq5ARUx780fiRJAA+/KHOvaiLO3sxcuDZZ6am2a52wh88shzAtEwn4XTaCJDGXH4rAcVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773597993; c=relaxed/relaxed;
	bh=AY/YN89hCfHrp7rCwLky2No0pBxq7q1G9BpnBStbaQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFeCCEggR3q990OYR0JfooHnlAZnCCEnAGg0049mdpFHNVWtEZYaL2wZdbuMvEthd02LIilmYwLYeD+PxXIQtKYy7ujfYU1H1KtGS5404Bk8/Poetr38k48ku/KW/21Vv1YMjJu2X1q7NsbERc53vi8ZmFcPEvV8NM/CzMXWlcmXI8o/karXeUrvDbngQkdVqN68+evlQQQuyKOT/5E/tNovZqDdwqoSgu8Nj1Ih+5qj4A8x9qcoHugPbs3N1gdr8gb54IILj2MrhVhRGfLjz2s8sG8SB2p1DBbHpTEVI4njIV0YV5huqSSIZedIt0QIrezFyRXabdQn2J9zlrP+/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CKF4eVqY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CKF4eVqY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYmPh1Tnhz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 05:06:31 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62F9rG6k3727992;
	Sun, 15 Mar 2026 18:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AY/YN8
	9hCfHrp7rCwLky2No0pBxq7q1G9BpnBStbaQI=; b=CKF4eVqYITk0pA1MmHHWwR
	0tRQTl1uQqO9MWD6eplTHSmIH45kEwBoCPIiT3crCIglkt29VQcZlS7RwBTXdZAF
	pRxKJTCPSfRUSS+gy51SGR+PlVa9ydFfFMLSG1OIX7dYFGa8CHa7Dv8MAlz0D+hT
	2qd90VA7IQjsOgaTuC9cHbyxjTJA0tIR+DnniL5LcCLVEWSEp1/sDEfTF/NkM5YT
	FbG7yFsQ5lim/d+8Xatj9Ley3Dh3PhyH9bNYODRV+tYXnvaCcEE1fMChvHCyNlq9
	3vD2QVOPWrVS20DneoC+Z+8OdBzlYo87Rw38xEGTfEHv63+ZbBoMbhPWlEwFSfeQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau4j0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 18:06:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62FF1SRH005380;
	Sun, 15 Mar 2026 18:06:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s252b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 18:06:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62FI69OS11731232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 18:06:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165622004B;
	Sun, 15 Mar 2026 18:06:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2FEC20049;
	Sun, 15 Mar 2026 18:06:07 +0000 (GMT)
Received: from [9.43.8.96] (unknown [9.43.8.96])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 18:06:07 +0000 (GMT)
Message-ID: <e506a5b7-fd3e-4a9a-82e0-1d952c4ee949@linux.ibm.com>
Date: Sun, 15 Mar 2026 23:36:06 +0530
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
Subject: Re: [PATCH 1/4] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, maddy@linux.ibm.com
References: <20260225013627.22098-1-adubey@linux.ibm.com>
 <20260225013627.22098-2-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260225013627.22098-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDE0MCBTYWx0ZWRfX04lRG1UPc0bD
 bQniQojqpzMabOCdjetodfqXZWfdPMtWnaDW22QnRo/SZiMwwFqb7BGvBpmmf1i4+MFB6PEY/Z8
 V/Jfx4vTzuZXy9okNvVJZO4VjbRe3bSlbeFONH2P8iqGncPqMrgPPtkiCxjRLOMvxN2JuVrf5aj
 fueqtmpUBczlZFG3YzB/5uqxGLmSx99FwGsNKyP/GUWgyuDBfTDdVRg4cLjJu+pvCclrMBYqAi6
 KjDnU54d7zlHtLx6/IY8o8fGpYsGdlc7CJ2yT6YLOGPjzyoY/h/L95J70FURAF4UZbj2ui0h/H7
 PxE+MqYmxmF+ysFLeqEFJSaE6pTkiLaFtZDphvXkx1gpk+EAr/LSM9/VGuGivO853hM8k/OUqXY
 3+OB04D/XY3ylWAitFO41KKXu5F6wCMXtLZYpJ7OckRIcANXLjDu3CLj3BLi1ZYe3SNNcUBS0hi
 5HeqcDDxfwWxPdFZCgg==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b6f515 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-WBm0hErA7UDGeZFpsEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2XPUJndXfQ44cn0a5ZqNwcPbpdV5ny9l
X-Proofpoint-GUID: 2XPUJndXfQ44cn0a5ZqNwcPbpdV5ny9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150140



On 25/02/26 7:06 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Move the long branch address space to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 8 bytes. Exclude these last bytes from the overall
> program length to prevent failure in assembly generation.
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
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 45 +++++++++++++++++++++++++--------
>   1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 7a78e03d482f..f8f6305b0d9f 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -51,7 +51,9 @@ asm (
>   
>   void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   {
> -	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_stub_idx, long_branch_stub_idx, tramp_load_offset;
> +	bool tramp_needs_align;
> +	u32 tramp_idx;
>   
>   	/*
>   	 * Out-of-line stub:
> @@ -70,27 +72,45 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   
>   	/*
>   	 * Long branch stub:
> -	 *	.long	<dummy_tramp_addr>
>   	 *	mflr	r11
>   	 *	bcl	20,31,$+4
> -	 *	mflr	r12
> -	 *	ld	r12, -8-SZL(r12)
> +	 *	mflr	r12		// lr/r12 stores current pc
> +	 *	ld	r12, 20(r12)	// offset(dummy_tramp_addr) from prev inst. is 20
>   	 *	mtctr	r12
> -	 *	mtlr	r11 // needed to retain ftrace ABI
> +	 *	mtlr	r11		// needed to retain ftrace ABI
>   	 *	bctr
> +	 *	nop			// Optional, for mem alignment of dummy_tramp_addr
> +	 *	.long	<dummy_tramp_addr>
>   	 */
> -	if (image)
> -		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> -	ctx->idx += SZL / 4;
>   	long_branch_stub_idx = ctx->idx;
>   	EMIT(PPC_RAW_MFLR(_R11));
>   	EMIT(PPC_RAW_BCL4());
>   	EMIT(PPC_RAW_MFLR(_R12));
> -	EMIT(PPC_RAW_LL(_R12, _R12, -8-SZL));
> +
> +	/* Relative offset of dummy_tramp_addr wrt start of long branch stub */
> +	tramp_idx = long_branch_stub_idx + 7;
> +	/*
> +	 * Image layout need not be considered 8-byte aligned.
> +	 * Lower 3 bits must be clear for 8-bytes alignment.
> +	 * Adjust offset for padding NOP before dummy_tramp_addr
> +	 */

> +	tramp_needs_align = (((unsigned long)&image[tramp_idx]) & 7) != 0;

I would rather check:

   is_8byte_aligned = (((unsigned long)&image[tramp_idx]) & 0x7) == 0x4;

and handle alignment when !is_8byte_aligned for better readability.

This alignment handling needs to go under CONFIG_PPC64.

Also, this alignment handling fix has nothing to with the moving around
of dummy_tramp_addr. Have the alignment handled in a separate patch with
a fixes tag for stable releases to pick it...

- Hari

