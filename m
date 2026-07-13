Return-Path: <linuxppc-dev+bounces-24102-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C353C44506
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 08:29:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzFwF22NWz2xjN;
	Mon, 13 Jul 2026 18:29:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783931357;
	cv=none; b=DUCj00Me/7IfNVWVyNy5mBNJi2DBjb/MozjgAolT1gvdME4Rr7lbbfgZBQKWqkOuGMIf9AhMe7wrldO7/CeeZPbmBiK+7egxsf2svk15YXK6OLdgomj4ebBffVwWYKrvoH5ns+5bbYtGJS7leEDXZdWdnhovb9xgoSOJ4VzoOg1dzIeEptYJHoNOFLn/0WRRNS9wtqengIXCItDHxjBD0huiZmXmSgG/BkEwBxxNhue6bfskqaXjsaakyvli+w4dQoR+fJr5c6zQIkq/VymiSMWgIeQxjIYG0Rg3UqhW184Y31eindL/ORPfEaPvS4vGNziAzkme5uAWGyO7Dc5mHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783931357; c=relaxed/relaxed;
	bh=vIoEgw5pbLdorvQvxuaFURYG+aA/Uw4f0z74GU1Or3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH/eWdV7Fv42lvApM6IUN6uSpeXycHMmLZRLg7ATCvF07wwSBcW1hYOdumy3aGDChNo2QvxgLq2fRn+Xumbt3/vq9vlMXF42NIeJCtJA+m10drnZnTXfIk7eDUQaEuVrUFCs3EIE2E+xa0KYDQBInZW+jbl/CoPfbRrauvKkjIEKTSxAzSt3l0D3/nurh62i9mvNd2G2uBtALOHUgoDa5t0LkR+Qyp8X/f/PG31wiCKtM6ObJBYWsnLN7gM+mF5RtTZSjlXmiueCeq5xq+weTn36aMvB3ftMnFaIJ2Srr3FnhXAMYP74ehyjKxXpJGcu7owR8pf7qce0PnPnIazcjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FcuqLeiq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FcuqLeiq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzFwD0rVQz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 18:29:15 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6g47d1672473;
	Mon, 13 Jul 2026 08:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vIoEgw5pbLdorvQvxuaFURYG+aA/Uw
	4f0z74GU1Or3Q=; b=FcuqLeiqw08Ly1aCdRYrPhro7U7NcLU8d8E3LjkZKVeW5+
	HcADM1nKsYAtgSP5fmCebxWY4aMTEhWgRQ1TNyvf+YMgyu867oKmyMqM8hZjGaW2
	mKVTppGILGadHKTQAJ4N+JVgoYNFzv2GdmDlqoIZfDJeAxHm83AN6pWiILVyA6P1
	6AlynMAfr8NVvogsLyEuc0k6jsoJkKVc6JTSNrVqD4mxgl9OryfFo4BfdzuWWpET
	Tv3uy7QwvKnl/mnbYr/eZb6JsePb4N6yfHpvcbNWnfVgqLPOQUBizrUdNAEihTYX
	Ts9rDWzFbod5rBrt37qZvULk3Z7ae7GPPzgOa0SQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf29y8r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:28:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D8JcH6019124;
	Mon, 13 Jul 2026 08:28:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxvg4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:28:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D8SpDD35520910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 08:28:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1142620043;
	Mon, 13 Jul 2026 08:28:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53F3C20040;
	Mon, 13 Jul 2026 08:28:49 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Jul 2026 08:28:49 +0000 (GMT)
Date: Mon, 13 Jul 2026 13:59:02 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
Message-ID: <20260713134356.62f55781-f6-amachhiw@linux.ibm.com>
Mail-Followup-To: Thorsten Blum <thorsten.blum@linux.dev>, 
	Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260712151300.3664-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260712151300.3664-3-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX/GHCChCyVkQa
 Xnp1TF7GNvl9L9B70IbocZZ/v3dlHFmheUFKBQ1QqsW+ifEHO0//g8yyKrgRiZvUNGv8vqauOtl
 P0qnrDRh420uUAAPY0ZUJ092XUs2rDg=
X-Proofpoint-GUID: 9stl8d43IDgypFfEMXh6aIlS_QiZZl-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX1Mxp8ycPzAw/
 DCr2dalTiXkv4mGtsqE4CO7NRarWSI3tHu/AuZ+LMhiXDrcH5ZTHdqUdllO8zB8ISEbmtJ1WFjF
 P9r3Ewvv2b+A3/nlrMflnq4Ub+jKzlaYxXBkjDh8lQMuEPBC6R/1AQXcAcn2ETR89aiNMGLbSFk
 k1ruXrft/FfPTXMFRjqKcbbewwdw3fPDUvHHIJBGCcGCPwEIZscxPJ9gYhuU0Av3cZHlAzaTgWh
 I1B1rLPrmX1VbmJS9R0lLAYDx5xl5ixmF+fhQ7RMBrxQ/hiO9avHO6CyGu0uo7e7BorvdCOea9V
 ALFZqP5kncjnSL929WUdfz7tdBNRLZ/D4ebmfynzQXp8kfdP5t4pwMriyVPHRCeE2edeI6+I9sI
 kFMYAO/9WNBix8OqatE1S9JdvrLTA4M8feDVPTRAs4MtkejE0Bau/QijQ1U4qR72Jwgq+4rg9tr
 DGHa/nyTrGlWImKBPUg==
X-Proofpoint-ORIG-GUID: XrneFJ93c1UjkipwxE3EESJgU5D831og
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a54a1c6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=W-CXSa3aD2AiFYcJ9rAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130084

On 2026/07/12 05:13 PM, Thorsten Blum wrote:
> The local table structure is not used - remove it.
> 
> Remove % in the comment while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/platforms/ps3/spu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
> index e817def7f424..c904f9fa1caa 100644
> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -185,13 +185,11 @@ static void spu_unmap(struct spu *spu)
>   * The current HV requires the spu shadow regs to be mapped with the
>   * PTE page protection bits set as read-only.
>   *
> - * Returns: %0 on success or -errno on error.
> + * Returns: 0 on success or -errno on error.

The % prefix should actually be kept here I think. Per the kernel-doc
documentation [1]:

  %CONST
  Name of a constant. (No cross-referencing, just formatting.)
  
  Examples:
  
  %0    %NULL    %-1    %-EFAULT    %-EINVAL    %-ENOMEM

So %0 is valid and intentional kernel-doc markup that renders the
constant 0 with proper formatting.

The struct removal part looks good though.

[1]: https://docs.kernel.org/doc-guide/kernel-doc.html#highlights-and-cross-references

~Amit

>   */
>  
>  static int __init setup_areas(struct spu *spu)
>  {
> -	struct table {char* name; unsigned long addr; unsigned long size;};
> -
>  	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
>  					      sizeof(struct spe_shadow),
>  					      pgprot_noncached_wc(PAGE_KERNEL_RO));

