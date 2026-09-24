Return-Path: <linuxppc-dev+bounces-28121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ED4C98321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 15:14:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrHS25WzNz2yD3;
	Fri, 25 Sep 2026 01:14:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790262866;
	cv=none; b=g2yYgGZp2bmkrakya1dmroTbE+a0oTJbT/fyKz3vOqbBhDdACNonYTf0TXMBqacQJUim3q6P+iyYUw/lMj07Wq6+Apthhg2FIjv+b42QLAPNzLdh+DataNxjg98UaDWkSDqBGGYVi8hwEZQ6ckp4DKK83r+2oRYWkS/NvJrzBUiPLLvwNYxO3Laqoi8mmLtpAMnaAmu4/pAi769XcsrA6SrG5usg5hxlivMAPp+mWShcGEHMgkWMrE9uBsYxAOjx+Bd95uauS6D3tuLQ0x3Omc2Fk/okuWr1e+eoFZ3XZdOflhziqRtFmA4qdALSACM4Whh4YsTcGi5D9JzDa9SzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790262866; c=relaxed/relaxed;
	bh=P+WVwqguNxyl2SKeCdntkuzuS0lMDGXmeyD47aHlfJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAM8e/FG5uyIqvia6iG0Y4N6iAEyEyQsLhH38nEI73HXZnY6IWzBbHV2wm259rX2IKGHzoiYifBxPHMBST/gD0Q9wA08KlzWGBfpPukjPRyMvOBbeSHTAO677B35c9an8lfcPyeVsXm9UsNUiRN7c1OF5wyLB8H9LbMJO5k5N0TQnRP5US4P2DYD4yeeCu2bIW/Qg5PD8b4fdV0GZclORQlujq7wwAePLYaH/oBZfvrmZdrNr7ANV1Af7dacZPg9QKnGgwbI/hRPx8/F8rEkwtFyGCbwSTi3D4OCusSvjmyIo0dEnX8xqEEYsHSpkbSgNJ7s90Z1cbEOnT3G6DE23Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FOBsQHFm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FOBsQHFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrHS10SJBz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 01:14:23 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC68BD2221127;
	Thu, 24 Sep 2026 15:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=P+WVwqguNxyl2SKeCdntkuzuS0lMDG
	XmeyD47aHlfJ0=; b=FOBsQHFmSKCEhKWRCk7KdKSv4aK0bSQSFx4PNGcAekB5Fk
	JGp1OUdiVsm2kwx7pLN7bPFcusZHU7ufjljrHKJTOTxtzQpA4miRFacY4KMLVNUO
	Hka1wVfcIh1IYBobpeNzxdwKaXAs/+wkLTfnsMZU/AoBI6+KXn/OAkgyo+JK5zE0
	9WZ5LZ9dplfAgTYr2+VPDArbpiDk1vpznGYNlq40s+Ofe47qYuzsUTktz0oIIpeq
	rWr55Os9nkjgJwqmZAXMNL9t7VNlzUTTibxjL1b+54Zd8GHZ3gbYlKrDXSfOg6aS
	m26ITitkdoVPRTzoOBBthMjwLnokH2OxNCEvnO5Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvh5q1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:13:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OEOtEU2194626;
	Thu, 24 Sep 2026 15:13:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2x9qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:13:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OFDcBG47776180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 15:13:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65B7A20040;
	Thu, 24 Sep 2026 15:13:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A43D820043;
	Thu, 24 Sep 2026 15:13:36 +0000 (GMT)
Received: from osiris (unknown [9.111.55.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 15:13:36 +0000 (GMT)
Date: Thu, 24 Sep 2026 17:13:35 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
        daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
        work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com,
        morbo@google.com, justinstitt@google.com, jszhang@kernel.org,
        japo@linux.ibm.com, jpoimboe@kernel.org, seanjc@google.com,
        pmladek@suse.com, thuth@redhat.com, ynorov@nvidia.com,
        joelagnelf@nvidia.com, david@davidgow.net, fujita.tomonori@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <20260924151335.18402A8b-hca@linux.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: AAkhnY0CHKXR5mUM658Up_ucxYfN9Yfy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX9JoxBpeNt8bn
 qVK0WkoAiRGO1SWWPxY3fQHtwY5RpPzkJK9UnGFrZ5YXlxk8TTgZRHgsjOwdWzcrohSy56+Cu6Y
 No0RDM8UgCwZJ/ckFoZliTl2HgNZgXo=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab53e28 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p4h_SoxtTXpsry2m2-cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gBUee2v9XE6ZUqdqRkJ7ALC9Gi6OUhGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfXy9jUDeCxsOh0
 Z5+1EiBTRH8DJh5vDCZ91uSrkJRy2u78zry9/MuhFURKvpWRuSfs4/dAnaBZjB5/0qn6A2vpnnE
 Hszov1Ze/lid5v9YfE1Mb61kTthY015SmgGc1o2UXpecDRg+97UWiVCGEfd8ntYqwLkefK7DwRe
 LZltlDuk24nz/YIWfnr9ricCrnss4YFxlE8iTCHU2dAuK9PXG+Ms2Lp0xU/1BtfX5l5MhxlTLq0
 SJL5ESoGzMWuPX5iR2gz8K1je+3v1vpEErHJO3oc8h7QgNlChgRJhA639iY1TllY8mqtpuDoDz5
 FhmuGZRv04+aOVbDOdzd3d7sqUFeCZPK0du4U+c5veOFCcteBY79zyRJfQUIpGqp7LsT5M5B04F
 djPNlo+TyjuwGhL5JtpnJZOzTE2fSmdFZPk8oMGLdX1YO1sEU/Yt3TyEkMQjCJlQvwVUWHk3rCs
 b3g6s+FYFJtc3aRDRpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240062

On Thu, Sep 24, 2026 at 01:15:57PM +0200, Peter Zijlstra wrote:
> Untested thingies for arm64 and s390x.
...
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index b6ba4465f59d..8bbb082fd5e3 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -26,6 +26,7 @@
>  #include <linux/entry-common.h>
>  #include <linux/kmsan.h>
>  #include <linux/bug.h>
> +#include <linux/uaccess.h>
>  #include <asm/entry-percpu.h>
>  #include <asm/asm-extable.h>
>  #include <asm/irqflags.h>
> @@ -55,7 +56,12 @@ static inline void __user *get_trap_ip(struct pt_regs *regs)
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long addr)
>  {
> -	return 1;
> +	u16 insn;
> +
> +	if (get_kernel_nofault(insn, (u16 *)addr))
> +		return 0;
> +
> +	return insn == 0x0001 || insn == 0x000e;

I have no idea why anybody wants to do this, but it looks like I'm not
alone :) In any case: the check is wrong.
s390 uses only the monitor call instruction and this should be

	return insn == 0xaf00;

At least it is not possible to set a kprobe on bug instructions, which
would make this "interesting".

