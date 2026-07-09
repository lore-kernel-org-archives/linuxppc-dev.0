Return-Path: <linuxppc-dev+bounces-23909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AB0C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwmnR31pbz3c2Z;
	Thu, 09 Jul 2026 17:29:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783582187;
	cv=none; b=jL6BsGWfwVzS+3O98a0HLNk2AjWdGxpuv0A7X2uXTmHBOQZsnSWblOmJ0gIKFYG0T1dj0VfNxKwRMnMhRoFcy/nXmBZMH0dFFdgOuPsSSia/0wnhXIyjB0K9bl6fYit5uswlOeMfXR2CJk9B9abGo1bxtDRbLv1Lm8m9WjQzXlarboxZqj9q7DnWKD41HZKOLU2q6f8InrUX68DCvjbb42vyYh2nxE3x1B4PvcAge6cerg0mUrTWuFj4eOoejeKMv7Ca46nnhgXDjCqFslGq5yLVCZa3SB39niFK4u2tsgQNNcCK77UuC2EIOCuARu7xVhMTCPpKbrRs4IOWBClryw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783582187; c=relaxed/relaxed;
	bh=HoYSB070AE9GmBZBYCXfouvHrOoukyLXb8f3rE2iJ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do/Q5yvq93x7boQZH2Sk1uCI7hOj/sNjYNZpIz05msxqE3NElwY5yakoma6BV60UQpZxjAxIlRCANG/hpu3bnnS12uHXEM2hFAC76EAesOeJSoktTndebaH4IoYkFPdLEiMcQn/0nHmCN7ZdQaePtw57RzmMHZ2TKXi+qnaVZyHCTZvsjQV11qPnpBBwugWVUHyHiGiGx9tMhOhenz5oVFRaCHIu13WpofjDZJvKH0lNeWPMGfpyOZ2f9Pc2xztV6v4B1HJH9TTh7ImLSjojDKj4fOhPrUJJJZhaN08W14WH5FUgTWhF5E9unnmfNasJn4zSc6q7V79n11nUwcph0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PN/uzDZY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PN/uzDZY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwmnQ3hqHz3byF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:29:46 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696ITfC480079;
	Thu, 9 Jul 2026 07:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HoYSB070AE9GmBZBYCXfouvHrOouky
	LXb8f3rE2iJ6c=; b=PN/uzDZY7qxh/JvA6k8BG4MYe8LnrtzFp/GzO2frLIQmGd
	XD0PDBWDDr1BtM0jjhynJUW8+Uc6S6xWv++cqez5+ddA47VOXPAU9ztwtpDINOmU
	IntKO//CmudyF8jt6sPfjb0Z47skRkhxxYwYvm1gY4ekDdnkX453KaDFNWTmmMqO
	Plcb81Hkp4P/i36L67UsCfyiaNwu6LW016gKsJd6juTgkmB0Ed907gN/f67nDQrt
	FaRBYptxAh2AH+eU4LPouzwKEjP6skw0iaVVk5L1d8HmBt1ntNW5KCMcnbQe9/XS
	sHZbiGLHep+cBnpAL23NofLNzYV3qDc1E7pQFL4A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt0udh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 07:29:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6697Janp022900;
	Thu, 9 Jul 2026 07:29:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwc8gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 07:29:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6697TWTt37552474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 07:29:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41E8A2004B;
	Thu,  9 Jul 2026 07:29:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 963A320043;
	Thu,  9 Jul 2026 07:29:30 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 07:29:30 +0000 (GMT)
Date: Thu, 9 Jul 2026 12:59:53 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Salman Farooq <salman.farooq3310@gmail.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
Message-ID: <20260709125357.49cafeb6-1b-amachhiw@linux.ibm.com>
Mail-Followup-To: Salman Farooq <salman.farooq3310@gmail.com>, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
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
In-Reply-To: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: agTyseDtzM4VzIDF_xHjur58XB-rvhZ-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfXzVTDsAv6+Wpz
 5U4esU6dYKjK43ZjPZ85VIGha06hrmd+IOpBQZC8OWBv122ctlFxtpDbqF1cFiS92lu6jxw90CC
 FsPKy/DDDS26t1sTlBhDhG/kFmE2pz8=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f4ddf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=5qU1I9XWuyLpgvKMgcEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: TVsYKKcaJihrubqFZQvtHdbeKVs5z7oK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX+5yfAz0k32TM
 J+zkqPXn8DXJMGc22XlrE8vrngG0GU2dO8cLBxqyfkJ9UDbwGrFzp37QARDLnbTj6punWaqqUBw
 y57kYuK17D0CpsXWowG6f2QNOeJNM4Vw99cdPAXA0SB41UaL8nPg1LzZpp3DUhC7E9uL1G/mjIt
 xc+CgN47DUNVSHfpMjk6VsM6haguTtGqhDcX1KRScrhy6wxIpNRp+ohYVXrqpxU2E7K5EFEotER
 Ub8A06gso/8BTAZO2X238+J+552t/5bA2I0dENSRszcPj/7oJoTYF0Xgvro4wDPdERHlbUWpyU7
 Vpr45GkoPb22lYps7trhfKjWIcR3mJ4rYc2X9rfNEEI/ichCgVTG8uE6YSHM9EzsEsucHC24Dad
 zcEgRSzOq3jLNwLLK6BERwCw1YTen8PPFiaOhiiZLtoZ70hbiMjXqLD3hKCb920JPNFi71IBv08
 oLoLjXVkoL87DGVCAwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090068

On 2026/07/02 08:03 AM, Salman Farooq wrote:
> Fix two instances of a misspelled word in comments.
> 
> Signed-off-by: Salman Farooq <salman.farooq3310@gmail.com>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I agree with Ritesh on the amount of churn such misspell fixes may
cause.

Regardless, since this patch has no functional or code change, you may
want to add a 'trivial' suffix to the patch title, e.g.:

  KVM: PPC: Book3S HV: trivial: Fix comment typos

This convention is used to indicate non-functional changes, making it
easier for maintainers to apply without worrying about regressions. See
[1] and [2] for precedent.

[1] https://git.kernel.org/powerpc/c/d2827e5e2e0f0941a651f4b1ca5e9b778c4b5293
[2] https://lore.kernel.org/all/87fr3vvfvq.fsf@vajain21.in.ibm.com/

~Amit

> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 5fbb95d90e99..6ac8364a7639 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -163,7 +163,7 @@ static DEFINE_SPINLOCK(kvmppc_uvmem_bitmap_lock);
>   *  All its GFNs are moved to Normal-GFNs.
>   *
>   *  UV_TERMINATE transitions the secure-VM back to normal-VM. All
> - *  the secure-GFN and shared-GFNs are tranistioned to normal-GFN
> + *  the secure-GFN and shared-GFNs are transitioned to normal-GFN
>   *  Note: The contents of the normal-GFN is undefined at this point.
>   *
>   * GFN state implementation:
> @@ -1010,7 +1010,7 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
>  /*
>   * Release the device PFN back to the pool
>   *
> - * Gets called when secure GFN tranistions from a secure-PFN
> + * Gets called when secure GFN transitions from a secure-PFN
>   * to a normal PFN during H_SVM_PAGE_OUT.
>   * Gets called with kvm->arch.uvmem_lock held.
>   */
> -- 
> 2.55.0
> 

