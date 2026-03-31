Return-Path: <linuxppc-dev+bounces-19064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369561061B21
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 10:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flPpX6c6yz2ybQ;
	Tue, 31 Mar 2026 21:43:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774953780;
	cv=none; b=MlkeO+seJNb42LnqrzD2+lLMUx1sGx9dIFZFr0EuZ+CjHiEi0M1r6FjaqKUWOqoQeVPlMdhE+sf2a9+JMNLafhGRrochThx0Hxv5awCLegcp03RvzsXebCAKFgTqTkwdCJfsIrtkyF5iOSq+5sgwIUZs3nA5ym5g8CTca3b7g7OjZS7jVmbzwU29/inFdI7IdD41jTJUW85eI/nHODJ/BXtZHwh3508bFaNhAxtHTq9R6I6tgKl5SNik6V16jB9y0cKM9nljg3h9Crxs91yWTaYLAhp6UbwW2uOkO7nIBS+8JikBnQesiuKX4gtNX3gTDX3dddH+9aMpGdDn75y92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774953780; c=relaxed/relaxed;
	bh=gio1AjQTECfRrWvSt8Wp7EvKzsqs+ww+mh3Lz7clbqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnibJYP06OXXKAjUUFZ58gw7zYYJRQa1tlVwoGnTzPC8TalhsN9+qycG4KtQYnz+XuwGI7SB5Nz06nyxm++ZUbeXbM5J57GI5s72IDOwOVXqg1c36B+atOgty3BGzoN7y/k5oLZKfa8D9BFd2kHVq7MBiuTX5y3yJfC5poi9Z7EH43qFTjcTxyw+cY0Q7ckzZX4hXX8eH4o2PRPW1eyqy6a+7Q5GGjngTGw6IcPRkWOnifkwuvYcf/YFqT7bxx0Wz9GABPup2AU5apFieiQv0xEaeoTKk9R5F8qNJxtvVsanh8cDE+mN8LcujiMzSfx/pNnNeNWOO6o25RJqWA0sJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S0f/uWY5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S0f/uWY5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flPpW5DsYz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 21:42:59 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5nd3K4097773;
	Tue, 31 Mar 2026 10:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gio1Aj
	QTECfRrWvSt8Wp7EvKzsqs+ww+mh3Lz7clbqU=; b=S0f/uWY5APjYCVE36adi9h
	WAPR7c9G3GrJ4XSz+v4HM6arpx9WD7TucewwVjlmrOFlcuBCeaMxPrqZ15QY7mUz
	A0DYpy1KuaFNhoYmI0Mv+UWqPHs4FasiY0OzP18iSSfXyAsuBD7WBKtN7XoGQ6Q+
	Z3oMn9fpMmRDe9iOnScdpnh/gnQTGBjmtHe2mRglKkqRYWPADvcpPz0+138QFXWN
	dpL3X6iMf+pAhIAiLpkZAm+AIbiOG6SKMGIV5jCS0GVfuou/YsEVvfOAvMR49PW1
	0z3s410dWhEsmjJgU0bD0mp26RkYH0LXBKvCLmIMk4BWIfYDW9GHkuUcfZ/GvaMQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnjry7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 10:42:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V6KnFo005977;
	Tue, 31 Mar 2026 10:42:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy0qek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 10:42:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VAgeGY62914956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 10:42:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E3C20040;
	Tue, 31 Mar 2026 10:42:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D52820043;
	Tue, 31 Mar 2026 10:42:39 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 10:42:38 +0000 (GMT)
Message-ID: <b8da91b7-94f3-4614-8b92-5085734953d4@linux.ibm.com>
Date: Tue, 31 Mar 2026 16:12:38 +0530
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
Subject: Re: [PATCH v2 3/4] powerpc64/bpf: Add support for indirect jump
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, maddy@linux.ibm.com
References: <20260227014315.39980-1-adubey@linux.ibm.com>
 <20260227014315.39980-4-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260227014315.39980-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pf4AmC1_k1kxYMk9dMQLNyq7Tp9vXSo6
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cba526 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=lo0OUDQOMmcdXGHtshcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA5OSBTYWx0ZWRfX1d8L16sUOhw6
 fycFUrWNkoI19YRWbTGs1CMzNp9WW1Lski5v8jab5Na24TZuwkpRporxnTBey/ay6s0WBdoXwlt
 csFEtQxjfhvyePMaK+RTY70w8BKNliFlP/YKFqBHkAtz+RMU84OUMTqt4vMrCYaa+Re5fC7Rkn+
 tixayfQzt1OsHZq6+mJoaPhJ0fk3f5GzcyK7fiLaZE3UkrrcXbU4s8U+NLbNm2AAd3pFmLhRehZ
 bOUZM65ViUcX3GmYrReFQ9Km49WvREyOePa/a08z84ZGa5iin08JjUeJoFWXTz1Nu2fnwZvQ3sZ
 1BWptaKG6rje9I/V1GP1ikRDdOTZ9GVMHvGzTXaK/zdY3Q3g+QgfzrBReh3FzjI/vWH24JgAbSZ
 IPa5BUcTy5Vu6nQTz69G9k5Q+cYMJTnYLNKuHXZCnCAicJAtRnbcyiQ2oRVUhHeWFwU2gGlaJLc
 shMsVOri4+CfOVuW9Xg==
X-Proofpoint-ORIG-GUID: Pf4AmC1_k1kxYMk9dMQLNyq7Tp9vXSo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310099



On 27/02/26 7:13 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Add support for a new instruction
> 
> 	BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0
> 
> which does an indirect jump to a location stored in Rx. The
> register Rx should have type PTR_TO_INSN. This new type ensures
> that the Rx register contains a value (or a range of values)
> loaded from a correct jump table – map of type instruction array.
> 
> Support indirect jump to all registers in powerpc64 JIT using
> the ctr register. Move Rx content to ctr register, then invoke
> bctr instruction to branch to address stored in ctr register.
> Skip save and restore of TOC as the jump is always within the
> program context.
> 

Looks good to me.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index c1d011046d8b..2cb550ca1dec 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1627,6 +1627,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   			addrs[++i] = ctx->idx * 4;
>   			break;
>   
> +		/*
> +		 * JUMP reg
> +		 */
> +		case BPF_JMP | BPF_JA | BPF_X:
> +			EMIT(PPC_RAW_MTCTR(dst_reg));
> +			EMIT(PPC_RAW_BCTR());
> +			break;
> +
>   		/*
>   		 * Return/Exit
>   		 */


