Return-Path: <linuxppc-dev+bounces-22606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE195CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jun 2026 12:44:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcx0s1jTxz3bsL;
	Sat, 13 Jun 2026 22:44:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781354685;
	cv=none; b=dtFKVYQeOcDut8T7YC2JC3mcwEuLvVagoxdb/7t3i9xoNbQTb0adKQ72aPyPdl4n9EiN6xirTecDqb2baoDKjw5tzftEDpmDlzP66KnAURMlHfJ9WcVLwctWC4wf8M6F4JuQl3yJnZmsQJeKVAPOczfA6pn/dP2jdBcpKEZVT4sUrUTaHiAuXltYSpw+rj7+ydK1s3Qo8ZeWaByIRBBh4XBlOh8ZPrJ2ev7zWpyK4IjB3S7DkkgQKw5fd65i43dXiMdkwZ5KLsPraopXcrypqNGRDd9Nxr0QBBIvYG7MNjAEIUIt5OIgN6bFNQwsevjdYUruYuidRrSlQ5gndyNfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781354685; c=relaxed/relaxed;
	bh=l6s/+bJ3iPfb1BkwzI8OcbDVmZpJENdiactxwwcwCFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOFJWhTnvirkcLWFZ2MAFBPGNN2P11rHymOAs2KxIJxuphWHQDkJHQbcCiqdaNRZQv7Pn0wZrka5rM/YvTr1H4QQbJZTV5KHQHNM2fsUIo2kxNdUQ24nL+LFizwbma99SNpN/ld+zr3HvohKjM621OyzoY5ZOBb0y1maoY6QPnfmzwTRoqJmmukNS3/eiZKVaJhfmU47cx87ytFY2GFImFMdM68tKnAbppSJNrNTX0ISM/1U5wyqIWTqTvd3ax3uOo2JSmZ4VmfuIegIZZf/26rHmNTiiyi1DUTIpepn+sGt/nEAuMhjLqL/r3JcKWz12R9JBV7w6J9iq8PtrYEp9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qFbw9193; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qFbw9193;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcx0r3s47z3brN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 22:44:44 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBILlx578010;
	Sat, 13 Jun 2026 12:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l6s/+b
	J3iPfb1BkwzI8OcbDVmZpJENdiactxwwcwCFA=; b=qFbw919345QiwesyRbKkf7
	C2Jg5OCJ12zIhgYABHngdE+kFtf8dxvdm2xbONBEaEltxNG2pQF7zcS88l3Hr7bZ
	B+OpKJwwDpKYBRMwYSnkFkgLo9pMoHbLOhn5aUsUvjh/znLQTnS49IPlzAsSo/yW
	AfR3AcWXZNDWp/U9OMBoVlvZG3DZ7Nq0YZD6zpCwVpuvepoGX4ag+plReQBZl2P6
	bvp/8rTvUjqm9J4XGu+CfFTiu2H8nAELdPMbMtQQzc091HmIIgyo434dKrxmLgV5
	28+aEjIJKmiqR6nBDxTHJJ43PmpAuN+oZVOzM68sROQlows+2rQMIRLmGvRz0z0g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23n8px3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:44:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65DCZFu8002121;
	Sat, 13 Jun 2026 12:44:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a3x9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:44:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65DCiQdi33620334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jun 2026 12:44:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9889B20043;
	Sat, 13 Jun 2026 12:44:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 543CB20040;
	Sat, 13 Jun 2026 12:44:23 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jun 2026 12:44:23 +0000 (GMT)
Message-ID: <038a115b-e2a5-4ecf-82b1-3689535e986b@linux.ibm.com>
Date: Sat, 13 Jun 2026 18:14:22 +0530
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
Subject: Re: [PATCH v7 7/7] powerpc/bpf: fix buffer overflow in JIT for large
 BPF programs
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        sashiko-bot@kernel.org
References: <20260611153826.31187-1-adubey@linux.ibm.com>
 <20260611153826.31187-8-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260611153826.31187-8-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2d50af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=MHLrIA3eTcbLxvwOaDgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfX18Ag9H7RKZiD
 9RwBi8vm2KHOUUaQ+2Qzf4YrNBMK3gLxixCdDVfEfWgT8sc/EsxF4cwTBa4WbgZrJRL1VY2zbdU
 iPx2DUw3xyBbFUm4mNYwRZz8Antb8WweM7hsSp0kQXXQHOFHh5KTJMFOIbaEfjaAIgJnf0EeZT5
 49OGKQzpPMynnVkD8mGHiucPEgrau7EN4nNMDjyW1OZxJzPPL3fAtwvKrfesD9g2qbBm+GR7+2I
 S+ExN9l1s61taF7A0JPMvd1l3Ut5p93nnvRuj+aKRQ4+7ctto8BGG5hmBzOpk56fHkviTsJv3Bb
 tlliGeneURugI2o/Vak+SB4PCnazAEB20tHQ1vynbftanNUs0CTNPTen5+dzTgfBtYgYWASotS9
 wYv0Rgn0KNDC+BqwZ/06+Ro801tCSOpVzP0esAYEbpih87wCpQ6OBKv8kKXQPEQJLXSInleSeYL
 /D+dmLImUp43FqHhggQ==
X-Proofpoint-GUID: c1bGiwQmV6yh7I7mExnjs77xTOEg6DcK
X-Proofpoint-ORIG-GUID: c1bGiwQmV6yh7I7mExnjs77xTOEg6DcK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfXybfsGi9KCE8X
 xwgbhD8iz+cJKDEcWaI/2Hcr21TLdZczKyWExSYASaSvIfEpH7BRvcAW5S+lHwB1+WrZY5iZeRQ
 xoAJ0/T6LrSoAoHW2crtcncP6RJUgXM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130125



On 11/06/26 9:08 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> During pass 0 (size calculation), exit_addr is 0 since addrs[fp->len]
> is not yet populated. bpf_jit_emit_exit_insn() treats a zero exit_addr
> as in-range and skips bpf_jit_build_epilogue(), so the alternate inline
> epilogue instructions are not counted in alloclen.
> 
> In later passes, if the real exit_addr falls outside the 32MB branch
> range, the full inline epilogue is emitted into the already-allocated
> buffer, writing past its end and corrupting adjacent memory.
> 
> Fix by ensuring exit_addr is non-zero before treating it as in-range,
> so pass 0 always falls through to bpf_jit_build_epilogue() and
> conservatively accounts for all epilogue instructions in alloclen.
> Also conditionally range check alt_exit_addr directly.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index b36b55f12a8b..470a359b7807 100644
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
> +	} else if (ctx->alt_exit_addr &&
> +		is_offset_in_branch_range(ctx->alt_exit_addr - (long)(ctx->idx * 4))) {

"(long)ctx->alt_exit_addr - (ctx->idx * 4)" is not the same as
"ctx->alt_exit_addr - (long)(ctx->idx * 4)" with alt_exit_addr
defined as "unsigned int". I doubt if that was intentional?
Can you restore the earlier syntax for this statement..

>   		PPC_JMP(ctx->alt_exit_addr);
>   	} else {
>   		ctx->alt_exit_addr = ctx->idx * 4;

- Hari

