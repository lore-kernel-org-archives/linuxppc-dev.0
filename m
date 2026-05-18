Return-Path: <linuxppc-dev+bounces-21070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B94BCD4F48
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 07:26:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJq9H72ggz3c3D;
	Mon, 18 May 2026 17:26:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779089171;
	cv=none; b=cPlXZ23R/b8veXQ6f7xQRhT4nVsFN+oHlFO73b8WQvPCnH5kZfi2gH66VlHhvAPNU8m7l8KStxPo8p9NM2js9MXYq+3Fw7uopN1lfUTTbOW4jJqTSO7BLWTVvjXoJDer8d8Ng6FVE6zWF/Bz4gJUu6Ji+T9pyFbsx8TlW9sb0r9yTpBA8httQjCGQCEU0nGeJ6Cl1JduU32vLYoRMq8HqgZ5l7XPqdRZrZGVJ3aIqCL4NeP6MlGEoXU2BJeCypi/LEVNQE4kbRmOM36aDA2G9xsGqIueVZn6HEhXsje23JDFckNIgNE9WAiQZbpGZ15EdQHlWRNeizW7XLG4jQsIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779089171; c=relaxed/relaxed;
	bh=cb9nWJuF3hQ3miUzMebgNN6Kj7RqYUCcNl6nTWfgSd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+ZCbAHbMChAGKGawlJYTQ/8GdUoL2Qzqtkfi907NdzRDYrxoijspb0jCB52CieqzCHtTbOHVFZBa87NffPSA+p7KEqdsgAr7nRxa+dJ2PxyTonWdxcQcOeX8Azn16SJ8IK6QVFeP38mvXz9DK2yDbOCPF4u1hQYiIHJxem+8fGSUoSGzzzU8WBZ15P/2SK1x8xNt0E1FYJruDa7zH+r5YVF9kyHlRd3YkkmJegDZ1g+/h+IBo8xB15dhaHR+bKStbBLhzMoU+/aXCvV/kZJ/550aAQxyOjM+oVqMHvhMAOpep8obzW5HzySoc1onXCE5z+qleAQ1M8nNjzVLost3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W20J4MJP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W20J4MJP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJq9H0WQFz3byT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 17:26:10 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7HBUX3901160;
	Mon, 18 May 2026 07:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cb9nWJ
	uF3hQ3miUzMebgNN6Kj7RqYUCcNl6nTWfgSd0=; b=W20J4MJP+al4K0g9lt0N+o
	8Y4T0nr8BD/aG0V3GCwSjHdrdv449aFHU0NhIJ9FHBNeCEQpsVqfZH0WvIjw7BYV
	9GOZ7nweeMzHOePMe/v0zqSVdzeLWxfPTQMXI1mObyBFh41I7VEHopccmCDvP9NP
	mUIr4c+54w5eUeLK5nvogVEoowtFKm+iESo8G55q40dGbAT/Q4lzhHkHK6f/Fqrl
	ZKN7kFTr+7xBvNnC/K2JgEWfA40fRUjVOFp90D4akemCDFChBzyczFsQByFR1aCU
	7+hKB08j/daHXyIFGCAnqMXCjaALElxQGJprt2OG+gS6dNCXSQpavbbGXMBUt0iw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mess7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:25:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I7O4ri010865;
	Mon, 18 May 2026 07:25:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpvxku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:25:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I7Ppe244892500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 07:25:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1212420043;
	Mon, 18 May 2026 07:25:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C10220040;
	Mon, 18 May 2026 07:25:48 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 07:25:48 +0000 (GMT)
Message-ID: <e074658e-401f-4d12-8997-4007d86b9826@linux.ibm.com>
Date: Mon, 18 May 2026 12:55:47 +0530
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
Subject: Re: [PATCH v4 2/5] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260517214043.12975-1-adubey@linux.ibm.com>
 <20260517214043.12975-3-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260517214043.12975-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MF7cg5mXDx7I93ljsD12K5d6Cutk981Z
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0abf03 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=jJgxMy1UuW8321J8VzYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MF7cg5mXDx7I93ljsD12K5d6Cutk981Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2NyBTYWx0ZWRfX40xScc2nOQVE
 d5L/d1A0SmTd3+AVfStaX/sD/c4t0HUwUFo3M4LuYuAL7obV6nQAHNUB4vJ0C07x1GVs+fEN4kJ
 GdpvEAyte2k5lbR3PtH4QS6EtqEfzBjRatJTwSDAG+shF2qPuIUnOMGls7itPjBwjHj8SZy7qDL
 NeFovnGAEFXEtZUcZjtRkJe5JP6LZD0Vcua8Pe+eyl+a7J3Gabn6KJNSkEWzOQ+7r3/GXjpMv3d
 0WRcLVzUlODBBi4JvEnHpDPdPFhRo6jFmMLn+DYyVTPNpzJlrxDfF7QwmZa6WTro3XrIzNOEiCs
 RQKo4U4GhSWxA1lsNMBgh2vIxoBG27tpGzOOyzPnflSIo/YS+O2iT15RFWTvbtI+uHlYyDVZg15
 A2IVJrD5+BhgaNbCFm9rXvg2u4cgglY2H0rUS8BfsVS38AHbsuTIlLgGLWhGHBMMXfuD0nbWB+C
 IW4q8pVamAqsIR7ZJRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180067



On 18/05/26 3:10 am, adubey@linux.ibm.com wrote:
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
>   arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index ef7614177cb1..b73bc9295c31 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -57,19 +57,21 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   	 * In the final pass, align the mis-aligned dummy_tramp_addr field
>   	 * in the fimage. The alignment NOP must appear before OOL stub,
>   	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
>   	 */
>   #ifdef CONFIG_PPC64
>   	if (fimage && image) {
>   		/*
>   		 * pc points to first instruction of OOL stub,
> -		 * dummy_tramp_addr is past 4/3 instructions depending on
> +		 * dummy_tramp_addr is past 11/10 instructions depending on
>   		 * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
>   		 *
>   		 * The decision to emit alignment NOP must depend on the alignment
>   		 * of dummy_tramp_addr field.
>   		 */
>   		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);

> -		pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
> +		pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10;

To get the address, should multiply the instruction count with 4..

     pc += (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10) * 4;

Also, pc may not be appropriate name here. We are essentially
calculating the pointer address of dummy_tramp_addr. `addrp` maybe?

- Hari

