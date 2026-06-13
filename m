Return-Path: <linuxppc-dev+bounces-22605-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB31ACD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jun 2026 12:43:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcwzD3ZwZz3brN;
	Sat, 13 Jun 2026 22:43:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781354600;
	cv=none; b=iCO3EuHYCXyZCcMcw9ZzyesPZUP7oeGfkZ1pGFibdu2lQDE1zR2gZI0Nzwjf+0AY5DheQF+oCK4LqxmN1o0F6YaQ5g6f6f2MRVCknAcKJkMOkUtgC3ZztuFO/w8MBXUMWA4i2BMdE1QCCNwZ4KRN42ivz6m0zx+rhiUov2kd7AL/pSqjSg9GR/VOPfzmThYUf0vW/Us9UU9yLC+/ceSryaOsvNZXPFFKtdMZTH6WD7zehlsJGSuKzLb/VI9V6CiQzha3yN0eAFmQUrcxhN2TsBFWOGRm+1kz75I1JkNk6tpA9YcZ0ILPkNx0STRsPixp4geGhT+Y5yqp32okRSKYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781354600; c=relaxed/relaxed;
	bh=Zc2dP2uiCwhaTNRutMgyWmncdT0jGA+cyNjIRAxxlWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2uy9m9f0zKN932fMrX9ESc2rN3B0DxHbUapMvdQ5nuEVKotPSTXMQ9YXbKmxIoD3Gc3HY1YiQrwA+opDatbUF/hyvD+5f7lSzKMvIg07PW+Uc1GzXHfSHMxmkzfd7eMGU8vRQPHzcSJLKffP3kKiOaYt0vbMJAbd1et8c7RxfcIgsr2dzwW3ewjnL3BO44W4Ho8aQDph1SMXllkKjB+X5AacsH06emf7sZb8NmypW4eErQ541jBa1Eya6KlCZIu0r//1ayirU7l4TttnBWQ7if2JE3cD5/wdmmfB2LUBkMhiIv6lL/8RCVbskW2F+uueZsmnoGjl4ZUfCMkdDmEYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eNUIK9BK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eNUIK9BK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcwzC57Vwz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 22:43:19 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBIQ0N578072;
	Sat, 13 Jun 2026 12:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zc2dP2
	uiCwhaTNRutMgyWmncdT0jGA+cyNjIRAxxlWg=; b=eNUIK9BKFXjD2om/bllIJP
	vNkNYpruPlsE5QFeupDhPMrYDAZY0s9R1X86W7JPlYgXarlLJdpkadIugNopXVYH
	lSYasZr9quoXBqGJGV28uupBe1ceH/syCvDA+1FuK9J/21y8N4DuJbWzzJD2kXEr
	n8c7k3TZfeHoYyZ1xang4izZhxZz7kTo/uNHQtiLOnCLfN84COuqD0A9TlI/SZlF
	1rLv6t15QdWdzCAdYxmwijwjgMQd/sGMDO7Q1iWUOe+cZuzrjTCJKdeHRfHnmcXb
	PoLPb66fgqC6fOKUMcTjNjA61GC7yc444NcJShfzNfVQl8w3o0NKucN8P7utAIkw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23n8pur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:43:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65DCYbvE023493;
	Sat, 13 Jun 2026 12:42:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe093xwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:42:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65DCgtp853477734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jun 2026 12:42:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4580A20043;
	Sat, 13 Jun 2026 12:42:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3289D20040;
	Sat, 13 Jun 2026 12:42:52 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jun 2026 12:42:51 +0000 (GMT)
Message-ID: <f4248818-67dc-4044-9738-5b5bec56bd2d@linux.ibm.com>
Date: Sat, 13 Jun 2026 18:12:50 +0530
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
Subject: Re: [PATCH v7 6/7] selftest/bpf: Add tailcall verifier selftest for
 powerpc64
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260611153826.31187-1-adubey@linux.ibm.com>
 <20260611153826.31187-7-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260611153826.31187-7-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2d5054 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=I8lMKGCQO8fzqh1HI5wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfXyMNVor+G7wAB
 oXbyOhjkQsh+kBdRa+Mh9H7g5EHP8eCUcEIc6Zm67tWUZIfgv6aMiX4KlHewGQ118htVZeMBxTg
 IdAiQujQb6BMK+8pd9ymyUQKg4KlGvmx2oLtkIrlE+E//Y5/cgUCPj4D4C+t3zs+05cnwNCNJqd
 KJ/qYRecQDYpyo6etx6HPqnOn+cGrg141pSVSVfTm6au4xQsRyaUB1/iDK7L09QS7ZUJ4px0ywW
 V7ULa7vy9FwPOCHzHfuYXGNaG8g+vqG1/8ckc4m3VoHKOM8vL0RL6m3wY8pMSponiXihzqJ9iIt
 VpbiLLtelDTTv8s3DLFN5A8QYSgejh1KkBY6Dgnck7EmQu+Xx3/3Y9Rq4iYLcE5NREASahReFrP
 xagGYBPyXo9I4FY4rFb9dMvXhFKaQiWJoQFwwFyFgo0hG1sdUMdtyu51hhwoWiXRxVrsPnS2aRw
 HSnAwqrLRLM6Hk9Pm/A==
X-Proofpoint-GUID: gztfT6Qrt0QzWssWjj69Iu_kPtcJsK-7
X-Proofpoint-ORIG-GUID: gztfT6Qrt0QzWssWjj69Iu_kPtcJsK-7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfXwD6TiQuakIYm
 MvlzNevMn/AVrgTKvokL7aHK7D2NVxw4iQtKSx5wmgEdLIRJDEh1+sndVPNC0JPSU8vevTVeF8g
 306xNGziOkEAfePChj7uBkW3AUDXiVg=
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
> Verifier testcase result for tailcalls:
> 

> # ./test_progs -t verifier_tailcall
> #618/1   verifier_tailcall/invalid map type for tail call:OK
> #618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK
> #618     verifier_tailcall:OK
> #619/1   verifier_tailcall_jit/main:OK
> #619     verifier_tailcall_jit:OK
> Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED

You may want to put a space or two before each line of the above
output to differentiate it as a command output.

> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f..09d7e92c8491 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -91,6 +91,75 @@ __jited("	popq	%rax")
>   __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
>   __jited("L0:	leave")
>   __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
> +__arch_powerpc64
> +/* program entry for main(), regular function prologue */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
> +__jited("	li 9, 0")
> +__jited("	std 9, -8(1)")
> +__jited("	mflr 0")
> +__jited("	std 0, 16(1)")
> +__jited("	stdu 1, {{.*}}(1)")
> +/* load address and call sub() via count register */
> +__jited("	lis 12, {{.*}}")
> +__jited("	sldi 12, 12, 32")
> +__jited("	oris 12, 12, {{.*}}")
> +__jited("	ori 12, 12, {{.*}}")
> +__jited("	mtctr 12")
> +__jited("	bctrl")
> +__jited("	mr	8, 3")
> +__jited("	li 8, 0")
> +__jited("	addi 1, 1, {{.*}}")
> +__jited("	ld 0, 16(1)")
> +__jited("	mtlr 0")
> +__jited("	mr	3, 8")
> +__jited("	blr")
> +__jited("...")
> +__jited("func #1")
> +/* subprogram entry for sub() */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
> +/* tail call prologue for subprogram */
> +__jited("	ld 10, 0(1)")
> +__jited("	ld 9, -8(10)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 10, -8")
> +__jited("	std 9, -8(1)")
> +__jited("	lis {{.*}}, {{.*}}")
> +__jited("	sldi {{.*}}, {{.*}}, 32")
> +__jited("	oris {{.*}}, {{.*}}, {{.*}}")
> +__jited("	ori {{.*}}, {{.*}}, {{.*}}")
> +__jited("	li {{.*}}, 0")
> +__jited("	lwz 9, {{.*}}({{.*}})")
> +__jited("	slwi {{.*}}, {{.*}}, 0")
> +__jited("	cmplw	{{.*}}, 9")
> +__jited("	bf	0, {{.*}}")
> +/* bpf_tail_call implementation */
> +__jited("	ld 9, -8(1)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bf	{{.*}}, {{.*}}")
> +__jited("	ld 9, 0(9)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 9, 1")
> +__jited("	mulli 10, {{.*}}, 8")
> +__jited("	add 10, 10, {{.*}}")
> +__jited("	ld 10, {{.*}}(10)")
> +__jited("	cmpldi	10, 0")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	ld 10, {{.*}}(10)")
> +__jited("	addi 10, 10, {{.*}}")    /* offset depends on CONFIG_PPC_KERNEL_PCREL */
> +__jited("	mtctr 10")
> +__jited("	ld 10, -8(1)")
> +__jited("	cmpldi	10, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 10, 1, -8")
> +__jited("	std 9, 0(10)")
> +__jited("	bctr")
> +__jited("	mr	3, 8")
> +__jited("	blr")
> +
>   SEC("tc")
>   __naked int main(void)
>   {

- Hari

