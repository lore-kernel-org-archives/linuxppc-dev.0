Return-Path: <linuxppc-dev+bounces-27748-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3340BC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 17:47:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmg712ZDXz2y22;
	Sat, 19 Sep 2026 03:47:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789753629;
	cv=none; b=lQaKDdXLECZTYMjOUyeezv35mT12z985zUxnO1HwOAshuCptoHr2Olkn2A+MGFebOS/ZsO3kl++gOr6wFGf0+h/5PK3kLOzl9H4hcP2SsrLpiGwjKU46P133Q4rxwQnscZ1CtoUG49xMnKEDz29txD285KVOL/oSFVimA7Z7Bw7nIzhwM9CySfCMM3T9EnL/xiWu6hVE/VgPCczmT01wF8yiFyEtv1LiSkVwUuRs3QFkiHMwdddy26aVwQ03ai+EyghsqIEvlOXvP4f8lJgGQ/1S0jTDmQ3drOC6YlNl7ZW9U3ex1n/DZi0JpowT/Lh8mMxtWGayh1gPErlcIbSY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789753629; c=relaxed/relaxed;
	bh=7UxSnGfwu/IJRlG7OayfivP+4Kua5yrtKWWb1Og1sco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luPV8Eh5q/eVx7z1Tb5vmlFXluhIHOxP4c8n2J50EJUdEafm1CrmJVU1o+xU8z56Pa99/fLKBNsSbYetlAKqUIOLTz+4LU3xa4A8bgENY+2KZpuQKKt4C9Olf8s2mU7NEgsI8cQHr50lH0SW3Cva5LDfwliH7mU0rzx46hxT2rIAtZ3bzQXNq03MEhcahlU+RHfrixp3v25sSMPF1m57PA3Pa8BoNtaEOD3M4XFsQSXCdm52S77ASOpuR6ZYVGQ3QnX8Tg8CcFlaV+jx4/D+7dB27YfZSUBTUM0+vYfnxP862Qa36PBBHugfLl3ssSFqhsVpE3fGL59FizhxpbOT/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NRdRIv5J; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NRdRIv5J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmg7038bmz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 03:47:07 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IH1pOv660585;
	Fri, 18 Sep 2026 17:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7UxSnGfwu/IJRlG7OayfivP+4Kua5y
	rtKWWb1Og1sco=; b=NRdRIv5JwMV0/sxo82VFgpjnx1/qLJ7EHq7HKftCr+t+by
	H/vgI16WBKzfmE1pWH5IyUjnvO93kK64868Ch0l9BUJ5vBHlRDaPmA6cLXkQQeiG
	ibnnxBtjZC43Ig0porKMxNan7VKx9CWLIvnsi+GqnWKxZA6V9xaqEZQU9dMLqfNq
	hZS0kVDixXRRtQHRhwdozcsCqxR/8pq8ChF+Ir5Uda1y0PFKYiAUhrr27YoFw99Y
	v4PrIUf+2FjeDaaCZOHAlabB47n5sWOe40QwZ9bJI8WhjPARqvUHaZZKChgSJm5X
	W33+oEiDsHHpFw/75SsbScujf6ZpVIBW1FMkJ/iQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eh1nj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 17:46:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IGoxDB964976;
	Fri, 18 Sep 2026 17:46:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjrgc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 17:46:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IHksNE40305122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 17:46:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563902004B;
	Fri, 18 Sep 2026 17:46:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A524C20043;
	Fri, 18 Sep 2026 17:46:52 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 17:46:52 +0000 (GMT)
Date: Fri, 18 Sep 2026 23:24:38 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Fix callback check in
 kvmppc_gsm_refresh_info
Message-ID: <20260918232327.23112614-5a-amachhiw@linux.ibm.com>
Mail-Followup-To: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
 <20260918143124.9913-1-kaylovefoss@gmail.com>
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
In-Reply-To: <20260918143124.9913-1-kaylovefoss@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI1MSBTYWx0ZWRfXxo0Weyb6Nv18
 oSjAiTB1UtqtWeZjB4+nte5+1yeI0UtL8h4Bsl0vs0oRA/Wz7WgY/YCUzBB3fNt1/Qg2Ixh6ed6
 Ram/0J7IupAwLig3aJjxTHPOPJsgpRndq1Ue8BNw2s5QwtD/k+imM+TpjOjWY1IWIZHNhtWBTSu
 2LoLJD0RDwOQeUb8J16CNnr/jIMytvEbO1ZYvjH4/u6TXof1vftiPozFquxixGnG+hu3YoWnw1O
 v6d5BNneaRcx+Ze5e0NE33qu1W1YaryMuJ2LNTlIQdSVK0wachQAxMGaPHvCmYjYtArwMg+ZCsg
 +8zER/EUduFpoY0SYQVcGV5bUo+3kJh3TLUPRZN7juIMsG/uphWH38RGiaJNsQHcs34ams5wytJ
 SmjcDiRbXEjf1HP+u8G6V28tIZeKm17prUXD79a012uvmXJFQOOukRmRbYVpfhig1VuXGSziyl8
 bya6NUqGFiUJZNTgB8A==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad7911 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=-UEHelddAeA3dXerUxoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1PPkUjuENsZQUl2Q8L4HkEQjhCoVyRfJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI1MSBTYWx0ZWRfX04GLhenJ5PRK
 htoNYj4v8L3oKskVITFKnLNCWrQTH0rtbZUy7E1ZpGJZjijtQOHUAeX/d2JsFhGY3QbYKpZAf0r
 Ivyu3jpeU5uEDoPifFyod7yZzCxcAkA=
X-Proofpoint-GUID: cqYzEWGtmFKJ198q4Na91n3TSWR5RyHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180251

On 2026/09/18 09:31 PM, Bui Nguyen Nhu Quynh wrote:
> The kvmppc_gsm_refresh_info() function incorrectly checks for the
> presence of the fill_info callback instead of refresh_info.
> 
> This can lead to:
> - NULL pointer dereference if refresh_info is NULL but fill_info is present
> - EINVAL return if refresh_info is present but fill_info is NULL
> 
> Fix this by checking the correct callback.
> 
> Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers")
> Signed-off-by: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
> ---
> v3:
> - Resend to fix whitespace handling issue on v2. No code changes.

Thanks for fixing the spacing issues.  The patch applies fine now.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> 
>  arch/powerpc/kvm/guest-state-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest-state-buffer.c
> index 42843eca6727..aeb586ba4523 100644
> --- a/arch/powerpc/kvm/guest-state-buffer.c
> +++ b/arch/powerpc/kvm/guest-state-buffer.c
> @@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
>  int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
>  			    struct kvmppc_gs_buff *gsb)
>  {
> -	if (!gsm->ops->fill_info)
> +	if (!gsm->ops->refresh_info)
>  		return -EINVAL;
>  
>  	return gsm->ops->refresh_info(gsm, gsb);
> -- 
> 2.54.0
> 

