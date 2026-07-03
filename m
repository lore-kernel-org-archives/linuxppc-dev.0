Return-Path: <linuxppc-dev+bounces-23470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0030C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:56:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs6zl59KQz2xd2;
	Fri, 03 Jul 2026 18:56:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783068963;
	cv=none; b=iJFSV94rI809AYiJiZslH21zPlY/sLjcBIPoHUcxftc4JWr/vMiXH502VWFgJndi/qkSKzfVKNbv8F5JbA2srq2l+ti3ogQBqFSzyNrr4D/O6RdAEWiaEiktV8DFM+bv20HIbBuVLn3FxG1agADWby5rpqEAXNx741Brtd6KuVWObZtKwSQH7ouIN/awMA2cg7Rh2mGs67lH2N99Is/YkKj8xdow6GmagR1tHMtxe9ui2+PPbns+xA2AbUPQhLiz6zPPAX8zay0nAnL8jSLhTCZmP3eN5UCZvRlywKw4meXZQYw0oWzAgeGRZCLEaqUI4OKfl8jSnQLv41QeZiJeug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783068963; c=relaxed/relaxed;
	bh=hMZw2XLISUOW/38UWXrFjmJN15b2JuShmsh1yAj/HM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3s766kdJsfYljsF07yZvaPTE8eWKd/0NY8AZnyRrfo9jHBs03fVnvGsoUo27tmiEL8oNcqOgV1ZEc2IFBdr5MtmQQ3o09mURDFEPq3RryJg/vIh10on9VRxPe6RMNYVZL4f1cmEeqSjbLcPY24ZkISXUE7sqVyBlDMs71YM4Vy6S2ZfgW5LMV+SYNjRZfW+DKhdBLI45EfUfEruxS/kgs1pi5N81SmNKxRhgBu9BricZw/iHv57YIxHbFrpM60Hvrtv6xIj6OUWFX7lVgUvjW8lEoRDIVukTmBiz3D9my5AVEQWQFq5vEsXohx5Actb1Fy/hCsnG7Gi8SmZ4AaYXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YNOb13RX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YNOb13RX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs6zk0lW0z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 18:56:01 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636Imvg1761779;
	Fri, 3 Jul 2026 08:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hMZw2X
	LISUOW/38UWXrFjmJN15b2JuShmsh1yAj/HM0=; b=YNOb13RXKDXwLUZv2XwAI5
	T6DpAec/+/ZcdfNINwW/v6ZRudq5c1FO+B57c4HuNZ6yW6dkzriWkVcyBNgdEt3Y
	aSOn3YBGwuQtIvdkcC3UVwjqfqEKN2glOwJ39In4rRnNrAktA3oJfKXKbUxhFcim
	AdieIfqutAdh65N8Koa5YhH6dtCOiVB+C6QKJeHDgF1lk97/Q35VeK4XzXbrD/Hf
	IK3RskJJPhZk4MmtVz6a8ozGdyUM2DEPPWVifoguDvVY7IJukpATlbu2MbSyga7C
	vZgozaprU08B7u9ZwTPUhOw+iNgZMnzdSg7hHUjIwNBu8rjqBnJBqGxOwYA+O94w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk5vcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 08:55:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638niDf029611;
	Fri, 3 Jul 2026 08:55:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqr8ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 08:55:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6638tiD043843996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 08:55:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 982AB20040;
	Fri,  3 Jul 2026 08:55:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE94820043;
	Fri,  3 Jul 2026 08:55:42 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 08:55:42 +0000 (GMT)
Date: Fri, 3 Jul 2026 14:25:47 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mkchauras@linux.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ptrace: Add offsetof check for exit_flags in
 pt_regs_check()
Message-ID: <20260703134456.2d291388-8b-amachhiw@linux.ibm.com>
Mail-Followup-To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	mkchauras@linux.ibm.com, sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
References: <20260703074948.1668744-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703074948.1668744-1-mkchauras@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX2sYSKGQdl6G6
 CNMOeltq9RI193rg8sDzYagPdtF5zEHtIP3cEkW1JMXlw/Vl+pyQpbJMOhHUvW6GviM3FWKKeME
 /gV8OOCPtLWgbXdyR+WFB+b5amoQPaFabSEpplYVMCnh1d/VAr7OLed/EOvr1bAYnXJVE57iKwj
 A3T1OgsFSXfPb1Jnaf6ZFrbnHFf9e34crgeURd6wEjcJxzIHN5118rixA7LWfqSXjsfl70oY5Us
 c0l+h0OqnW4hSytLarm0QDfxUm/0gJkvzoNFHGyIiwOgVsKplRu6msBXSMmJ3xVoP9iaVTSNdC9
 CT2Aow06y7zssMdt5fK8/wEDGJ4kP0Ll4L98Fsht8fFCEYCRZ1GnQTKwGS8II2Z1n/3fmvjd/oe
 WRzQS6ePuBgsDsxDDCCzulbFFsqkgVZCLPlIaDPqhlDskVd8pxiKsNV/6hqB7XLSwgkA07NbkEr
 Adk3h+h8LbtNJUHhtmQ==
X-Proofpoint-GUID: jWINDpUbeklN-6HRgeiOFVovJ2MtXf2o
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a477915 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=gHNQbWQ14yc8XukLhS8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX5xXFdx2ISZm/
 rZRIKw49F5IFUjpkAo3cPD8ya6N1KD+hZZx+QxrM2FCB4XeRV3p5O0B3BVbE63KHDJrR9E7Aaow
 klj4uUDl/66HRVwwexewL8Csw50pvCA=
X-Proofpoint-ORIG-GUID: 5LAoR5CTZsDk5GnTDeBiKh9KrYPMWw30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083

On 2026/07/03 01:19 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> pt_regs_check() verifies that fields shared between struct pt_regs and
> struct user_pt_regs sit at the same offset, to catch any accidental
> layout divergence between the kernel and uapi structures.
> 
> Add the missing check for exit_flags, following the same pattern as the
> existing checks for result, dsisr, dar and the other shared fields.
> 
> Fixes: d7a6797e0bc1 ("powerpc: add exit_flags field in pt_regs")

You may want to add below in order to get this patch backported:

  Cc: stable@vger.kernel.org

> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  arch/powerpc/kernel/ptrace/ptrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index 316d4f5ead8e..fb3fec73f66a 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -235,6 +235,8 @@ void __init pt_regs_check(void)
>  		     offsetof(struct user_pt_regs, dsisr));
>  	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
>  		     offsetof(struct user_pt_regs, result));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, exit_flags) !=
> +		     offsetof(struct user_pt_regs, exit_flags));

At first, it appeared to be redundant as we already check 

	CHECK_REG(PT_EXIT_FLAGS, exit_flags);

which expands to:

	#define CHECK_REG(_pt, _reg) \
		BUILD_BUG_ON(_pt != (offsetof(struct user_pt_regs, _reg) / \
				     sizeof(unsigned long)));

But looking closely, it turns out to be non-redundant. CHECK_REG only
touches struct user_pt_regs — it validates the PT_EXIT_FLAGS constant
against the uapi layout. It says nothing about struct pt_regs.

struct pt_regs (asm/ptrace.h) embeds struct user_pt_regs in a union
alongside an anonymous struct that re-declares all the same fields with
kernel-internal aliases (dear/dar, esr/dsisr). exit_flags lives in that
anonymous struct. A field accidentally inserted there between result and
exit_flags would silently break the union aliasing without CHECK_REG
catching it. The new BUILD_BUG_ON closes that gap, consistent with how
result, dar and dsisr are already protected in the same block.

Looks good to me.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>  
>  	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
>  
> -- 
> 2.55.0
> 
> 

