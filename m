Return-Path: <linuxppc-dev+bounces-19062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AF21061B21
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 10:38:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flPjT1HD8z2ybQ;
	Tue, 31 Mar 2026 21:38:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774953517;
	cv=none; b=R736WedgTVI9r5gHaNlFOSvNp1raK5OpLtAfKvdJ31RYTecdroEe1u/d1lYMinXFvck7bMVCLByyEsFYVNf1Vb/AvYtn9zhB/E4m1cVhCczV1Dk+i7xFUhPiMr/6rZfjvsOy+vPPkv9j6IPV2jzPSso897pdDGoi1hnKXaVZrYhqxN9FSnsZWPrEWeYEVAraA7V9mNccX4TA13dBjDgWCezSMzOoTeJGslsWyvcAjKWKYimWyw2RcV1EjrQ3FCU1CMl0naXDo2dOFxEFFADm4jo2VewdMsfnAdkEEwJxPxl8EUOQp+Yjpgg5w0RjlY7CBO76Ux/XMeN69YL+GtkXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774953517; c=relaxed/relaxed;
	bh=xJCJW4uKcvNQlqCwJnt5LcIwVKIpIhLOc/E2DQ21lRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wup39US3k6Qr+e6MF2BbEnfZd4AFZsObrven9PGzRYXnysnnTeondF4QzgknL9bJMd7cXTH0aGnLEdOZfzayemmdQ5TINPDS7I6upjpQGwl9dsY2Tg6VBQntvajbXCmLbTb8yqAORlPbErJUNs6dOHjo58TeozFd1r7QpycfbbwOm4Vv6cso4p0kfX4eITxvSX0YNdaxYYaHw8UhU6wmWEBEYA8Z0xOdSCvfbmesomOV1fsq+w9aSTLmT+IhrRJ1DUugE/QiSX66x4e/PSSj43vEnYTi25z0cXRJTHD1qYJw7924lVZ+MDJjbyX1WRIobVT97vqxl126gbCgzggGNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RshvlOTn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RshvlOTn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flPjS33C2z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 21:38:35 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8bErR449675;
	Tue, 31 Mar 2026 10:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xJCJW4
	uKcvNQlqCwJnt5LcIwVKIpIhLOc/E2DQ21lRU=; b=RshvlOTnwBrqI/GgXDwKex
	NB958ZgfD273WWndKCZO9b8s76BIDwZGb6AckPthZ6PxcGKCCcaoWttEwaoskFIM
	Vl9I399YYSa70c2VBsYMLBt9UQu+MQjfR3tZhmsB9XqAjebx3o5gN2Nm8EmdJ+BC
	/X6KQkqSmJ4M36IAMkfyE+CZheNWa0dsw95y9snPJVtID9wvRQipjpoF/mAUcCY4
	7JPXXC+itCjfAkvrVlYh4UGsrH62lb4xJnr55y4HdGGUrx1jsMCUp6f+xY2V9Kgc
	zCM2chleUBiNg4WnIW0zItNoY+7z8Rx39sau/d8uDBSW3EUgGuvQiVVqA5lWaxbQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1tt3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 10:38:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V5uvsW021665;
	Tue, 31 Mar 2026 10:38:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasgrxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 10:38:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VAcE0M56754518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 10:38:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 690152004D;
	Tue, 31 Mar 2026 10:38:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF0320043;
	Tue, 31 Mar 2026 10:38:13 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 10:38:13 +0000 (GMT)
Message-ID: <2fa9bd2a-6cee-4c59-a66d-049e503cea71@linux.ibm.com>
Date: Tue, 31 Mar 2026 16:08:12 +0530
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
Subject: Re: [PATCH v2 1/4] powerpc64/bpf: Add support for instruction array
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, maddy@linux.ibm.com
References: <20260227014315.39980-1-adubey@linux.ibm.com>
 <20260227014315.39980-2-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260227014315.39980-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cba41b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=LiiZRlpjulW5djIf0KoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3vPS9-C3mv6Radad6FzExNAHTb7uM26i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA5OSBTYWx0ZWRfX2ifHvXnBtOez
 j8I5lcv+qftHAmK71RdmaUYrc8CWsz107F4OF1SXyCtpK3C1sUOroQvkG+zYFXe3q/fitfYap/s
 ZThB0CjnnlyFcRxepL/0SR3aUB+4h4YgN6Gn4nYLZ47iW3cBuIoLCezFoYtfFIHj8IFfLI+2Ij0
 Od+otaYHZtb0vI+sFeUeA2OZDq8ID9MgLgOwGsMypOw1Wuylwl1OYffXqYrWAKMTfAfDHuJIiQl
 4Xsk2m7TvVtyvpmzY/W8oo6cTotllH09L5o2BYDFw7gFSncsR40rB87LBI4d/BNAw+6U3lLxMse
 jP1/W01pDH5W0HyILXWCmTvUxNBewmwTipG/y9oYpxepFsqJGNTt+S6eNl2BlidkNMwNKPlKSTn
 BlEp+dL4RcTu52gKXxNOjUaBnyi5C7o7Lk8wv2cyuH1nosqPw7ecPyHBwEGhDFn2FXNQ5aFsV/+
 BQOyf6Z5HSFk0MEPdlw==
X-Proofpoint-GUID: 3vPS9-C3mv6Radad6FzExNAHTb7uM26i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310099



On 27/02/26 7:13 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> On loading the BPF program, the verifier might adjust/omit some
> instructions. The adjusted instruction offset is accounted in the
> map containing original instruction -> xlated mapping. This patch
> add ppc64 JIT support to additionally build the xlated->jitted
> mapping for every instruction present in instruction array. This
> change is needed to enable support for indirect jumps, added in a
> subsequent patch.
> 
> Invoke bpf_prog_update_insn_ptrs() with offset pair of xlated_offset
> and jited_offset. The offset mapping is already available, which is
> being used for bpf_prog_fill_jited_linfo() and can be directly used
> for bpf_prog_update_insn_ptrs() as well.
> 
> Additional details present at:
> 
> commit b4ce5923e780 ("bpf, x86: add new map type: instructions array")
> 

Looks good to me. Except for a minor nit below..

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 9ec5ab9b020e..620667c3400b 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -373,6 +373,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   			goto out_addrs;
>   		}
>   		bpf_prog_fill_jited_linfo(fp, addrs);
> +		/*
> +		 * On ABI V1, executable code starts after the function
> +		 * descriptor, so adjust base accordingly.
> +		 */

> +#ifdef CONFIG_PPC64_ELF_ABI_V1
> +		bpf_prog_update_insn_ptrs(fp, addrs,
> +				(void *)fimage + FUNCTION_DESCR_SIZE);
> +#else
> +		bpf_prog_update_insn_ptrs(fp, addrs, fimage);
> +#endif

You don't need this ifdeffery as FUNCTION_DESCR_SIZE is already defined
based on this CONFIG option.

- Hari

