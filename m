Return-Path: <linuxppc-dev+bounces-27031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67141C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 14:14:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgfmy6GvBz2xjM;
	Fri, 11 Sep 2026 00:14:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789049650;
	cv=none; b=oQ12T6W1xEjT90TXH9fNF7x0ruv96JrUjbhezMfsfW92tr/364zFaKPYZyMcfCpl9+K2rNK5G/Q0kFJdAUwtsMHKc0mJvdB8cY7QVpYPAi534JlZGj5NymPUs6VwbvzS3RQdR2YdTQMKnUhBlGRNwecyCQG5KkRCp9xF2kdtGV4BM3YaUkRB4Ax4A2Mn9MfTuy82tOOVK9euKdwQ4AnLOcbP0XMjTehDTuMvPLugogy+gRHYSTT+cxHTnYx5ZE+wqOoNsjMUyW8HKmOCIDM//67MK16BwRtkwTw/ELxbUGtc/8PbcrEcC9XuyRoa3DQA0L3SzDd+xrOlrdH0BPTDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789049650; c=relaxed/relaxed;
	bh=Rsa+09XshQBqt7KTDIU4LcA8wjLUXgeN7I6YUPic3UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3R/aF9cK07I+Vce6vCFTCfxjVyxP2iXmvP1j5ek+6PK1ffKXiv5QfoRGwGuEvu6Nspn+aY4WasO4EPeyO34Q/t8tfer+hZYQdtE7NHNu6wqEWEVjfmhooH6ZrkMMVXcWXvquxtZ0NW32W4tL0glcrSvsDBhL1x1kQ9JWLb4FA/XBKbyHWrk/x1ZdHTtMaiQKobNrvW5fGCAV1cilNk3QNl1ycp7Ofh3suNZVadTZoqDKF+39LjRYhwyDXm8XJ+DutwpyC7FNEkd9SMjZmuCzn7t/tvGzhomus+IkCALhHV+XTirIkPefJ9vw9n9BUvnQOCaxYkEVQG52Zy6rHf0dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s1bpGVeK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s1bpGVeK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgfmy1J7sz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 00:14:09 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ACVQ4k1017565;
	Thu, 10 Sep 2026 14:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rsa+09
	XshQBqt7KTDIU4LcA8wjLUXgeN7I6YUPic3UE=; b=s1bpGVeKIHCAIsOQ244fhy
	3aYYKpAjVo0mejHL5QN2bZNUeyeniAEdR87tUIT7rwlVqOXaSDLeEOjx2Pbh+ESJ
	Xx+C+JohjyHuRtRmc4aKny/LB2iNpw/NxXEdKfhRwmiScTktMWTq7gHpgMuiAFcj
	LHeurv0bZJvgmg982oLTjXTIxuZMUEWUD/B61pNgT3aODnjeMUec5zK1FmYi3t+h
	+/xamNHp4pyrjnzYQWuq2f6CB1m2khHECuK/9nQgRS8Sqe67FJFi8VU7x9BV+uRy
	sOHsDNuIJFcAB8ts4DIHakXHCqfp75Js5c6y3kPS3LEZt62o5scEM3aLc/2JE2Qw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8n52ea-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 14:13:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ADAVaq044169;
	Thu, 10 Sep 2026 14:13:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtf8d8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 14:13:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68AEDuHu52887898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 14:13:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F42720043;
	Thu, 10 Sep 2026 14:13:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6484020040;
	Thu, 10 Sep 2026 14:13:54 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Sep 2026 14:13:54 +0000 (GMT)
Date: Thu, 10 Sep 2026 19:51:39 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Fix guest state buffer kernel-doc names and
 parameters
Message-ID: <20260910195045.996cb331-f4-amachhiw@linux.ibm.com>
Mail-Followup-To: Karl Mehltretter <kmehltretter@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Jordan Niethe <jniethe5@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260910033655.16127-1-kmehltretter@gmail.com>
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
In-Reply-To: <20260910033655.16127-1-kmehltretter@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa2bb27 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=yPVLcobRgUjX84E6IAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J-dMCcHPRX6nTUw6TjgMFsEGwK3oj0ut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE2OSBTYWx0ZWRfX04YIj3PSJDwq
 RCLzvLTxLEk94vfEWWmk9+1WPi6AkxRV8dBRWX6ZZXAj7wsZzKeW0Kd0ovYhiqu7NbnxA/7nDim
 7Ms7xvVkByMKRy/pnjb4qoWhE76SQYKyKxG1KvyzBy7uQqxVyci0BBNaihEm8FcsdjT2TnN/Ma+
 /m/DJ4wlifhh0xWyY4dCdu//KsJTqNiRh1hah/iHCVCC6Kk4mjR6NDIkkcD3gwNvfTAnR7Ld2a4
 zR4dg+27VjlUKaDBc9IftpXMRBdrHdd9RdINL6ds5na0zAFTYD9G3uhlYrgkSb6cpfW4OQzR6aH
 GiL+wJIMcdyv25LiuA1XQoWduuhhwjtzTFydeFFc9JhDjZrHrvr/pmfu85TpBUY8WNmrzq9siWC
 i4cpgQgpuaYLHxO3BrUct6/5Zlpybyb368F9TzOjIkT4WkhBBYRtYyITQ7IWNX8RDT7FPjOegmv
 kGgdSR54Rmhp1p5aYLg==
X-Proofpoint-ORIG-GUID: rwg0wXi8uBU91HmEltVOagbEFNv1f0Dv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE2OSBTYWx0ZWRfX0XnZOaffguB6
 jj9xE44WgyDH1CUjulw9PIvKwROWpRrjKgeztW1SJ6djVQqlkY4OtQR3GuQHc8Jjfrqj6G4GqBz
 SG/EutO39/hDio6+52TzFO004Qm9Pz4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100169

On 2026/09/10 05:36 AM, Karl Mehltretter wrote:
> Several guest state buffer comments use copied function or parameter
> names. In particular, kvmppc_gsm_for_each() describes a parser and an
> element argument, although it takes a message and yields IDs.
> kvmppc_gsm_include_all() also describes an ID argument it does not take.
> 
> Match the headings and parameter descriptions to their declarations,
> and describe the parser argument and vector output with their actual
> roles.
> 
> Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  arch/powerpc/include/asm/guest-state-buffer.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

The kernel-doc fixes are all accurate — heading names, parameter names, and
parameter lists now match their declarations. In particular, the
kvmppc_gsm_for_each / kvmppc_gsm_include_all / kvmppc_gsm_reset /
kvmppc_gsb_receive_datum / kvmppc_gsb_send_datum corrections are a clear
improvement over the copy-paste state left by the original commit.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/arch/powerpc/include/asm/guest-state-buffer.h b/arch/powerpc/include/asm/guest-state-buffer.h
> index acd61eb36d59..95d50ec7f2a9 100644
> --- a/arch/powerpc/include/asm/guest-state-buffer.h
> +++ b/arch/powerpc/include/asm/guest-state-buffer.h
> @@ -224,7 +224,7 @@ struct kvmppc_gs_buff_info {
>  
>  /**
>   * struct kvmppc_gs_header - serialized guest state buffer header
> - * @nelem: count of guest state elements in the buffer
> + * @nelems: count of guest state elements in the buffer
>   * @data: start of the stream of elements in the buffer
>   */
>  struct kvmppc_gs_header {
> @@ -779,6 +779,7 @@ static inline u64 kvmppc_gse_get_u64(const struct kvmppc_gs_elem *gse)
>  /**
>   * kvmppc_gse_get_vector128() - return the data of a vector element
>   * @gse: guest state element
> + * @v: output vector in host endianness
>   */
>  static inline void kvmppc_gse_get_vector128(const struct kvmppc_gs_elem *gse,
>  					    vector128 *v)
> @@ -849,7 +850,7 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
>  /**
>   * kvmppc_gsp_for_each - iterate the <guest state IDs, guest state element>
>   * pairs
> - * @gsp: guest state buffer bitmap
> + * @gsp: guest state parser
>   * @iden: current guest state ID
>   * @gse: guest state element
>   */
> @@ -866,9 +867,8 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
>  /**
>   * kvmppc_gsm_for_each - iterate the guest state IDs included in a guest state
>   * message
> - * @gsp: guest state buffer bitmap
> + * @gsm: guest state message
>   * @iden: current guest state ID
> - * @gse: guest state element
>   */
>  #define kvmppc_gsm_for_each(gsm, iden)                            \
>  	for (iden = kvmppc_gsbm_next(&gsm->bitmap, 0); iden != 0; \
> @@ -908,10 +908,9 @@ static inline bool kvmppc_gsm_includes(struct kvmppc_gs_msg *gsm, u16 iden)
>  }
>  
>  /**
> - * kvmppc_gsm_includes - indicate all guest state IDs should be included when
> + * kvmppc_gsm_include_all - indicate all guest state IDs should be included when
>   * serializing
>   * @gsm: guest state message
> - * @iden: guest state ID
>   */
>  static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
>  {
> @@ -919,7 +918,7 @@ static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
>  }
>  
>  /**
> - * kvmppc_gsm_include - clear the guest state IDs that should be included when
> + * kvmppc_gsm_reset - clear the guest state IDs that should be included when
>   * serializing
>   * @gsm: guest state message
>   */
> @@ -958,7 +957,7 @@ static inline int kvmppc_gsb_receive_data(struct kvmppc_gs_buff *gsb,
>  }
>  
>  /**
> - * kvmppc_gsb_recv - receive a single guest state ID
> + * kvmppc_gsb_receive_datum - receive a single guest state ID
>   * @gsb: guest state buffer
>   * @gsm: guest state message
>   * @iden: guest state identity
> @@ -998,7 +997,7 @@ static inline int kvmppc_gsb_send_data(struct kvmppc_gs_buff *gsb,
>  }
>  
>  /**
> - * kvmppc_gsb_recv - send a single guest state ID
> + * kvmppc_gsb_send_datum - send a single guest state ID
>   * @gsb: guest state buffer
>   * @gsm: guest state message
>   * @iden: guest state identity
> 
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> -- 
> 2.39.5 (Apple Git-154)
> 

