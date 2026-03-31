Return-Path: <linuxppc-dev+bounces-19046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888A8FF60C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 05:12:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flGSl1d1gz2ybQ;
	Tue, 31 Mar 2026 16:12:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774933927;
	cv=none; b=SBqC3E3/CjkU7JUCWrGsG9CRmQQYrCCWktJ9ZIV+8KRKIH2HIDnp4P86N9RpcKJVQIHO8y7mPuTfyGS0bf+Dw3BxZ4TIdNf6hTqYPOqgPLTZJR2glG0W1IPnyVEDXx0CDiuVpflZQUDsM9yb6CsehPKEsEhCeW71JKQx58DxarLGEqKRaMjADP2xUkD+n/SnGpHqx5LnAFcsBbRlvP+FuxbmirZ07EzvuiNoKESzy4z7cgMxBsOBQdtvRM1uJR5klZ8rEauTAcozh4XXfEWk5k39kflE0EYKqfp9DlalPCR5+RmpVO18QtA1NXEXNO+aR7IGroFpvKn4e8oas6O72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774933927; c=relaxed/relaxed;
	bh=YWkgxX4Zi+vY1QYiJ6qFO4JXqriWLRlLw/eGyV4hwik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhaXs9ijPCMQi78uDOzfCIgxqwfWauDuiJEI+0RVpgYobwcZjDXaE5X96eLvKCnwaXYBSR23XnPC8GcedHBjUQUUdd6C2pXsgER9IvCrjHqUGMk3pfmK3yr8xX9WgssWZ9DpV25RE7oPmcGlLoYeeaSEolGOjBWFtuxxobJYtAuXDLGUyONkfGdmqYZWVozOCN06uQUNRqltYtigH9c2bnnXTxWl/j6XIVLDotQmvWeOWx5CEcyWuictsMQAxHP4a4FH0ZQBkpOkVrtBpMCf78PuZ55YT5Lm6hVGWQ0r8QZ0Er2qq9yvwL0Ih8GT68jzhcNFcZZ4r0+d2Nqcsd4m8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GEXcGIfF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GEXcGIfF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flGSk3hRkz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 16:12:06 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UE0m7N4192031;
	Tue, 31 Mar 2026 05:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YWkgxX
	4Zi+vY1QYiJ6qFO4JXqriWLRlLw/eGyV4hwik=; b=GEXcGIfF6uFDLfV6xtwIyv
	thvFacjTIy2Z6KCtIFT3el39zK3ig0r4Mnw+qSCqRO3f1NLb9hYKjs3ozFLf1opl
	6yqEDK+yJEI2Ks1qHlLUj4mD/I9izvr1MlYX/CB3Hr2QJ0unNsJ9C2EMcNmMOdha
	/T/PAnFWInZjQc1fdH1kkWbiZ2P1p1hJwv5/Y0YhfLLjR9NUSVTxt2rfIWVMjtZY
	9BeintOeeweofMYq5xio5QRw2g7PQk8T254HU0UaPre9YhZhzDhcytywsRcMrUIg
	BC3HNQ7s3kUqFJpCKL6kX4fwyA3JMwbZ1gzJZt/VUpfGOGvMrBrkFZtqu1RLZd2w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q31r1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:11:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V1Sobt030995;
	Tue, 31 Mar 2026 05:11:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjqgpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:11:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V5BlxM51708266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 05:11:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE01C20043;
	Tue, 31 Mar 2026 05:11:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C59620040;
	Tue, 31 Mar 2026 05:11:46 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 05:11:46 +0000 (GMT)
Message-ID: <7b1c95ac-1c65-43b4-bfd4-1bf4ce895853@linux.ibm.com>
Date: Tue, 31 Mar 2026 10:41:45 +0530
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
Subject: Re: [PATCH v6 2/2] selftests/bpf: Enable private stack tests for
 powerpc64
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
References: <20260331080309.173612-1-adubey@linux.ibm.com>
 <20260331080309.173612-2-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260331080309.173612-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uRdHim_O64l7ma7LrcJDfztLc3sf8d-l
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cb5798 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fzXNTZqiIB68qRgjTG0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uRdHim_O64l7ma7LrcJDfztLc3sf8d-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0MyBTYWx0ZWRfX7wDcZaom6MZH
 Jm9CijTMf8Xt6djkXzWzR+rAiwhlYbutac5uIIFbq/MUii9a87R4ydmAZzH3vLpQQHaxlGcsW6t
 +mvWSoLeo8CQrmfM+5RRE/X0sTiuKDzcRLbYbBR4BuumTbSbUpIb8LHZqC+M8Fk7Wgv3RJJ4aAU
 qA1CryOZHyA70Bgn4DXZ8mMN5Zhidcrbwjsy/Ca37PP3tqI0jOp2RTOFGNoyggOgdLlyQ51mT/1
 5PHS4dX4O8a77Giri2iBQeRzsM9scHHKKPXV0Cd4hYeeNCl9hYcgAVfqZq5K7FJQhmQxAnNAs2x
 ty2yAD79p+sGSA3oXkdFdko8XNxn+TlMTRKhkUQSxuEPW7ZGGP6DiiwkNx8JOIT96njxZ/MG+OM
 fMTOSsvYUv0XnzJxbsYZSoyq9I4sHNYKum2f2zKLdVExrcBIeMFwsHkVnTBvjtKHPIBsj2Lp8uS
 Uj6SIGHmkmmCBsVaKYQ==
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
> With support of private stack, relevant tests must pass
> on powerpc64.
> 
> #./test_progs -t struct_ops_private_stack
> #434/1   struct_ops_private_stack/private_stack:OK
> #434/2   struct_ops_private_stack/private_stack_fail:OK
> #434/3   struct_ops_private_stack/private_stack_recur:OK
> #434     struct_ops_private_stack:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED


> 
> v5->v6:
>    Remove unused label
> v4->v5:
>    Rebase over latest branch
> v3->v4:
>    No change
> v2->v3:
>    Enable testcase using __powerpc64__ instead of __TARGET_ARCH_powerpc,
>    to prevent it getting invoked on powerpc32
> v1->v2:
>    No change
> 
> [v5]: https://lore.kernel.org/bpf/20260330232034.44776-1-adubey@linux.ibm.com
> [v4]: https://lore.kernel.org/bpf/20260226031324.17352-1-adubey@linux.ibm.com
> [v3]: https://lore.kernel.org/bpf/20260226005440.9570-1-adubey@linux.ibm.com
> [v2]: https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com
> [v1]: https://lore.kernel.org/bpf/20260216152234.36632-1-adubey@linux.ibm.com

The above changelog should go below the "---"
Also, selftest ML missing. That being said, the patch looks good.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   .../bpf/prog_tests/struct_ops_private_stack.c | 30 ++++++++-----------
>   .../bpf/progs/struct_ops_private_stack.c      |  6 ----
>   .../bpf/progs/struct_ops_private_stack_fail.c |  6 ----
>   .../progs/struct_ops_private_stack_recur.c    |  6 ----
>   4 files changed, 13 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> index d42123a0fb16..98db9bafa44b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> @@ -5,6 +5,7 @@
>   #include "struct_ops_private_stack_fail.skel.h"
>   #include "struct_ops_private_stack_recur.skel.h"
>   
> +#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
>   static void test_private_stack(void)
>   {
>   	struct struct_ops_private_stack *skel;
> @@ -15,11 +16,6 @@ static void test_private_stack(void)
>   	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack__open"))
>   		return;
>   
> -	if (skel->data->skip) {
> -		test__skip();
> -		goto cleanup;
> -	}
> -
>   	err = struct_ops_private_stack__load(skel);
>   	if (!ASSERT_OK(err, "struct_ops_private_stack__load"))
>   		goto cleanup;
> @@ -48,15 +44,9 @@ static void test_private_stack_fail(void)
>   	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_fail__open"))
>   		return;
>   
> -	if (skel->data->skip) {
> -		test__skip();
> -		goto cleanup;
> -	}
> -
>   	err = struct_ops_private_stack_fail__load(skel);
>   	ASSERT_ERR(err, "struct_ops_private_stack_fail__load");
>   
> -cleanup:
>   	struct_ops_private_stack_fail__destroy(skel);
>   }
>   
> @@ -70,11 +60,6 @@ static void test_private_stack_recur(void)
>   	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_recur__open"))
>   		return;
>   
> -	if (skel->data->skip) {
> -		test__skip();
> -		goto cleanup;
> -	}
> -
>   	err = struct_ops_private_stack_recur__load(skel);
>   	if (!ASSERT_OK(err, "struct_ops_private_stack_recur__load"))
>   		goto cleanup;
> @@ -93,7 +78,7 @@ static void test_private_stack_recur(void)
>   	struct_ops_private_stack_recur__destroy(skel);
>   }
>   
> -void test_struct_ops_private_stack(void)
> +static void __test_struct_ops_private_stack(void)
>   {
>   	if (test__start_subtest("private_stack"))
>   		test_private_stack();
> @@ -102,3 +87,14 @@ void test_struct_ops_private_stack(void)
>   	if (test__start_subtest("private_stack_recur"))
>   		test_private_stack_recur();
>   }
> +#else
> +static void __test_struct_ops_private_stack(void)
> +{
> +	test__skip();
> +}
> +#endif
> +
> +void test_struct_ops_private_stack(void)
> +{
> +	__test_struct_ops_private_stack();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> index dbe646013811..3cd0c1a55cbd 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> @@ -7,12 +7,6 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> -bool skip __attribute((__section__(".data"))) = false;
> -#else
> -bool skip = true;
> -#endif
> -
>   void bpf_testmod_ops3_call_test_2(void) __ksym;
>   
>   int val_i, val_j;
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> index 3d89ad7cbe2a..1442728f5604 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> @@ -7,12 +7,6 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> -bool skip __attribute((__section__(".data"))) = false;
> -#else
> -bool skip = true;
> -#endif
> -
>   void bpf_testmod_ops3_call_test_2(void) __ksym;
>   
>   int val_i, val_j;
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> index b1f6d7e5a8e5..faaa0f8d65a4 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> @@ -7,12 +7,6 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> -bool skip __attribute((__section__(".data"))) = false;
> -#else
> -bool skip = true;
> -#endif
> -
>   void bpf_testmod_ops3_call_test_1(void) __ksym;
>   
>   int val_i, val_j;


