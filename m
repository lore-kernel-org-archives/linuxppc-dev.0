Return-Path: <linuxppc-dev+bounces-27853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EA4C982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 11:23:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpLSq5vYkz2xk7;
	Mon, 21 Sep 2026 21:23:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789989803;
	cv=none; b=iD58xv9K2PMgiGo5Pc8w3E0su0q9Hs3fxSE9LIX2i45jm+GjN3vdKHviq0EhGUOMsVuV4Dx0r6X0NrO57JvMhLaFpxYwq0GOLDMfc7fObEFd8sofhv+FyGs9BmUyou2uDcubi8ORxfh16lG1J+KYr9r9rC7+zHKypRJP3xVlzXbBD2/xXJND+BjsAp7lxVrZwpwOhmapCzAOfxqqBHdKW5Pf8lEfMx83I6BmcEcTVoYQCwn7iX/Mmv+M9LIZ34P0UOwcHPcoEgFmvCdTBJMT/LyFS8cOxiC4VbbyPWXpi6GNOM0tIYYxIYfzOtUpGT9kXN7dS8Swb5kQy9uhUghRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789989803; c=relaxed/relaxed;
	bh=JBUujFMgz4mIdKIH6tMo8Cil0mCiJd/6vR0P9XmbgBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEDb3x4PlxHjjnrI4IbiQMyQgFtAZA5h7yAO6ocRfC86w0l45ZRlTJgCy1uOZixBWRpaKaYoU96klfLW4BitJpXn/SICJDA1930UVeYh2hudYQLdHJDxcTi/ptwwjqv0iJUwmymDimbNOMoty8ZPfIh9tuXazd0NFGMxbrlb2RHmzP8rVqwc0Bk8f5j7CjxLFzLiXs+KPhAv0VP9zWdo2ff/Tvo1Hpx5Enc4VNI8lAskLRHF8gJQeJRlOsDqTkrdngqGMGd0i7Db2g2JRURlEso19UzaefqNFPKzP2sayO4WIoTBc+Ih8EvBdvwiAESnGUoLvXVmOU1t8CRICNUh2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YAUNx76r; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YAUNx76r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpLSp5qHmz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 21:23:22 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5WXh3651602;
	Mon, 21 Sep 2026 11:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JBUujFMgz4mIdKIH6tMo8Cil0mCiJd
	/6vR0P9XmbgBk=; b=YAUNx76ry59gnV0z5OsNz5pYlrmoMNJBU9k/a/DX/M9HT8
	IhI3kqcxR07zTmuuNF1kQIQv20aKqWKeZk3LUbbKO83vV07QvI6mPhX3Ohw1l280
	j+zcjlY6dz2sYQqdS/suUT4MyhFJXshPZrngebQR1qiw08YLqDxKBVQFZBGj2Q+F
	4OEY81sUxYF1IepHu55uA7K6adkO8twRzin13/NoJOkcMb+J+pZ3NIxsIbPM5HX9
	1os/b+rLRIzKZztMyg7m4LcyzH/qPDwnICZ96A5HDC45aD8chgXBp6EHTOZQ440X
	5Hm3dvWs4zu4r4HL7bJ7p02Za0R1zo6llidgQFtA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1g6rb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 11:23:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlWoO1095948;
	Mon, 21 Sep 2026 11:23:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vd4ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 11:23:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LBNASi45023720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 11:23:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A6452004B;
	Mon, 21 Sep 2026 11:23:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F30C120043;
	Mon, 21 Sep 2026 11:23:08 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.123.6.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 11:23:08 +0000 (GMT)
Date: Mon, 21 Sep 2026 16:53:06 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Fix callback check in
 kvmppc_gsm_refresh_info
Message-ID: <arETH5Z2Xlx7umw1@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
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
X-Proofpoint-ORIG-GUID: BB8wLv_hFBoehsrNQ4UkN6gOcFEZ9rig
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab113a2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=-UEHelddAeA3dXerUxoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfXybhi3qagsviN
 u3tv1AZRLHD8FhULgfJeN2SdXoAsiawQ+oeC12GUL6HdczmIwjY27PvrbXRnRkdFHtJoOPlHs8a
 ZGpaVMFSYyTM+8dupBZTbVVsLlAobh0=
X-Proofpoint-GUID: QTzQbzeTwzemSXggztCmEvnB1G5nxrm3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX4w0Sx87ssKh7
 pHBcFQw1Qh84t/ffHX/6E85Ox5/JluVt4n951dyiVpX/ur/srq5e5dIgPoxi72LTafWP0ezmNnh
 uWbCBCzJPYfQ0PS9UXzZrPHhMKBdMr6l6MY8EMSyxaEDvYjYLg2iY8p1Br6hSr1LIRJ+dlXNqjB
 uiikYBlIPMCpn0JRJZpH9EV9mO6fbvdjIIJgZ8G+LU45sei2Nc+1LmUnAPcc6+/tQ6gh+bkFWoN
 vrLRlA+OH343ZH/YCKybFqiHyp4HKOROwYoNHmXRsVOtvnEW39fnD316wPI5HF+15cSeiZ1eChS
 clEzHCchGSL41puOlc2EQhdqK1pp86fN6sUvAsQabKBhfKaSu4fGyk+gfG3mc10HRUPSbNDOI45
 J+79VvfUr12oQEDOrZsCG12bmtH1dgcAQiouZJ/5rpniPry/CKH6Hl6BbYgGQeHMqdRDPmq6ggX
 6kq6lPUQtAOOAtuIQ5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210160

On Fri, Sep 18, 2026 at 09:31:24PM +0700, Bui Nguyen Nhu Quynh wrote:
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
> 

You missed the v2 changelog here. You should mention all changes
introduced in every version.

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
> 

LGTM, this is a copy paste mistake. I did some quick sanity test with
this patch applied.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>


