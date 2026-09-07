Return-Path: <linuxppc-dev+bounces-26661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CEAC79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 09:20:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdhPV1qKrz2y2L;
	Mon, 07 Sep 2026 19:20:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788772830;
	cv=none; b=c6RGpZ2BM+SxmULDbh4vACJS2R61UgNe06jQYR1iVMMDQcOVpWOd8ZB4HHl3ZIKVijBwGp2HJTZwt1nfr9NGdQkTuAqUsdA9f70OASfafTSx3evygQYPEylUgnIG9KKWmRxg08CJfwAM6xvKLBWfEpy15Tgk182AtfzuLTh7CVdX6aYo9Xx+zlDDgDiU8T+ptP9aZmorYKc5KwhF5rhY3GNCBUWcPYuwlcwsoR1gPd2rVvHuiY1Lyk7JkVyrv2gsHU3CnHhwgsHo9hJbh3QpZezPozXCGNibDFjzZVd5P1l9x4pv3TlWv61TGUVnQUkBdoLQe4fmQV3fwDKU2hak6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788772830; c=relaxed/relaxed;
	bh=ueaPeZQkPkdRMMtS6Hq/G5/R0qfzGyg4XdsGhINvZlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPGhDD7pu7ATAMA689hg9jbhaIUoNGiTaQtaysu97uRw2yzlrs7pK/tvcecBIvxnvuDARNI7uQ6ekrsOa/uwXkkmc9tYlwPpnyY7gsM+XjnjSLxhCFcMFQY5iZFWB/N/gHs1F05EBSQ3ZWKqUKk2rDBqpHY4L4gPgnLUQIMVL3bzwuZ42Wqv73+co7prXbYHLATFJt2qdSXXMoPt3BuDgDEBkhl6qwFTlYCK0aNeXZTn25rtm65/NrYivSSJhs1Ihu5L0j3Bf/XS2B+5kPkcU2ouQ1AuxFuwE8Dg4Epo44cQA+qrk+EhpH2CUXo4ARSGQqHA9xmk9XSvoat+eVVRtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YODo+Nh2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YODo+Nh2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdhPT10F0z2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 19:20:28 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877VXRa1287232;
	Mon, 7 Sep 2026 09:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ueaPeZ
	QkPkdRMMtS6Hq/G5/R0qfzGyg4XdsGhINvZlo=; b=YODo+Nh27/cMnhiWTMYzPd
	done4NP91hp2t7CIwVinx4ARi2S6WXalh2H++NRiIOYmz9a/VnKmib7a5KWqaVKI
	jylE/wftW5Jl/KK4Mij0HkV3/ocai2WuzzK7fI45GeYwvYeT1uaPSpfYYJFiYDDX
	4gISF5LhDp5N6+l2v2SWumfRzcvKW7TuMUjRl2rr3V/mk7V5U5EZPbwWc50F7o3Q
	LSPkS29L/gIueiwRfAmBNPTQuhLxwiT6uqMVRA3+E842oCj/epGXabjfra5DYUwA
	nLFeZ20uOkOcLkxXBoDU3eBZV63z+P+LvRq3BFY8aXvRvB3gKXqLj1Kccpmtfq6w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkftfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 09:20:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6879BCfw026602;
	Mon, 7 Sep 2026 09:20:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03y4u75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 09:20:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6879KGSP42926574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 09:20:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B58D20040;
	Mon,  7 Sep 2026 09:20:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08B120043;
	Mon,  7 Sep 2026 09:20:14 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  7 Sep 2026 09:20:14 +0000 (GMT)
Date: Mon, 7 Sep 2026 14:57:59 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: nhuquynh@tutamail.com
Cc: Maddy <maddy@linux.ibm.com>, Npiggin <npiggin@gmail.com>,
        Mpe <mpe@ellerman.id.au>, Chleroy <chleroy@kernel.org>,
        Linuxppc Dev <linuxppc-dev@lists.ozlabs.org>,
        Kvm <kvm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Message-ID: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
Mail-Followup-To: nhuquynh@tutamail.com, Maddy <maddy@linux.ibm.com>, 
	Npiggin <npiggin@gmail.com>, Mpe <mpe@ellerman.id.au>, Chleroy <chleroy@kernel.org>, 
	Linuxppc Dev <linuxppc-dev@lists.ozlabs.org>, Kvm <kvm@vger.kernel.org>, 
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <P0S7RHx--F-9@tutamail.com>
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
In-Reply-To: <P0S7RHx--F-9@tutamail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5OCBTYWx0ZWRfX6NYsgGxbe258
 +pv0Ph3Zjx+4VoSNg12L6lCM6gjybGIRGj4SkX4SmNlmzPxakR8ytO/jx5iovv1EHBX9i+BjgEE
 ZEQSRgppplKyQ9ZMbc2TC1esUJB/mVk=
X-Proofpoint-ORIG-GUID: IhqbsV6MnVA-fzWJ51WRt5D96PYvxuHI
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6a9e81d3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=opkI-JdcAAAA:8
 a=-UEHelddAeA3dXerUxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Ww8VKtPN2Pdc02dhIGwG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5OCBTYWx0ZWRfX+NgpwHfYXw/p
 MK+Q/UIxmcMjf0I/PJgOdml1csucA2tJBKr1O3KT8dRaO7Wx597NK9jErIMgkagbcjcB/J8mCxL
 ZWOkv0Gg0cMNHM3gc1+92YMsCIX4ACYPTC9IAYImUHjoOBKd2m+V5CwHtFj5Mw/Nz+J5/hVGB8G
 o0LdTRJdbMsWvOOVt+UnbzKGn1XoiHGQUGy0uGSM1uG2xSlje+unFrNvuReyfkiBzg6F0GZ9zRN
 kSLZGuhkxomexMxixtDAOouohfK1ox/mzKUh+hLMBRVimKceKEd8ybg/LCw+R3/Lv6FG85UCQZA
 XGwhhguBw2OryS9ftdrX5pgSm9VpsGqhUYkk2+in2dfWEIVG9BTmLPRWOwyYMLDYnuxo54ZtJ7T
 j8kGfNh2RGqcdstVBVuOm3vyDvQDrrrZ1DXGstfqGVBzR0OJFrnelCDF1bF+MhUHQptoJACj2jj
 +g/+6JNFFJTRFUwLQUw==
X-Proofpoint-GUID: QRy2YXKzGrWjbDLPtMGAmhfUddVY4Pu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070098

On 2026/09/01 03:26 PM, nhuquynh@tutamail.com wrote:
> From 80fd05e6d156d5a90d4908f2498bf6cc7acbdefd Mon Sep 17 00:00:00 2001
> From: Bui Nguyen Nhu Quynh <nhuquynh@tutamail.com>
> Date: Tue, 1 Sep 2026 19:39:49 +0700
> Subject: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
> 
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
> Signed-off-by: Bui Nguyen Nhu Quynh <nhuquynh@tutamail.com>
> ---
> arch/powerpc/kvm/guest-state-buffer.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest-state-buffer.c
> index 42843eca6727..aeb586ba4523 100644
> --- a/arch/powerpc/kvm/guest-state-buffer.c
> +++ b/arch/powerpc/kvm/guest-state-buffer.c
> @@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
> int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
>     struct kvmppc_gs_buff *gsb)
> {
> -	if (!gsm->ops->fill_info)
> +	if (!gsm->ops->refresh_info)
> return -EINVAL;

Thanks for catching this.

The patch appears corrupted by your email client (whitespace mangling /
quoted-printable encoding).

❯ git apply ./20260901_nhuquynh_kvm_ppc_fix_callback_check_in_kvmppc_gsm_refresh_info.mbx
error: corrupt patch at line 30

Please consider configuring and using git send-email to submit v2.

Thanks,
Amit

>  
> return gsm->ops->refresh_info(gsm, gsb);
> -- 
> 2.54.0

