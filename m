Return-Path: <linuxppc-dev+bounces-26657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E1EC79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 08:33:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdgMf2kRRz2yvY;
	Mon, 07 Sep 2026 18:33:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788770030;
	cv=none; b=I5AvFz6Qi9YqU/rZazcEtWgFNrlsNvNxUiyojQGoHW/X0J5vr+dfBlVd7Jw88mHUz1OroO/+bXufs3o6pLVaRN/o61FFdH91o2JGe4RjdhCKYKvJgqxLd2p8ru11C5SiM3R/Hs6A3jC6AAaSb49xtYKiVZVa5ze9rbKL6SVvM+1xNea1T7c1gKBvQ3mo1wrRmKOBY96UBcT/+RwLDG2yX8/o2cH2BYRCpByM4y8EmjH/WGnZmQSluC+q8fD12zeFHS0Qbx92Xunykr6m1ZverSCpSrMhngweUKOaBGITrI+sAWTrBALz8cXNFuUyc6BgTpMrqXIT0wZERV4cCvZduw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788770030; c=relaxed/relaxed;
	bh=ZoiwGS2pFKgVA+y83afWzWIUjIMjemxrI5kdbzIGBwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMWgSdOZVBYZv8iGVsy+1f/7yJmx6f6dSALWn8YAWDPefXq8qS9IajonGqNHQVIwcd1fEtZRqHDkpjP66aZOqzysolg0INX0tzq+4OqSeiauWr+sZYTAf0g5cd1smHtot4goGyjksAdFgMuzbFMRuA1VQFgDFD2rn81E0n4WsjARaVSRbKBrgwltX/1UBnafdzDV29nw+K5coANAMywV6QHvsZL72DFgbXgXIjU0Nap7gR46j7ot34/u1RCXRB1dasiNASrzDvpQIWeWWOd6yqknV2j4BadWTmxIqJq0egi5mZNDjHXYgJ40X/+pJxJfu8Jig6Ct1PuiC1v7vtVM/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YEoltXTa; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YEoltXTa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdgMd3kTyz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 18:33:49 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877VkRK3605798;
	Mon, 7 Sep 2026 08:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZoiwGS
	2pFKgVA+y83afWzWIUjIMjemxrI5kdbzIGBwU=; b=YEoltXTakyaqbdaCghG6Qz
	XYbuww2JR2B9RF9sJw3XA4Fpf82h8zMPsFlXaN1bSGG6jm63KWcv81gflsCBqlh8
	flFraSZalPnoIkPyMuya6NqK5/ECH9PQnGnvYjOPKGjjEcU/tNOHShUXB0cwx3PC
	P4O73umagVKkqRDPvfhGAGrS39Pov6BtQ/fvjJTotzp91+UzgZtqCa9XrnDv6yKg
	52ZJsDeNuaAuZ8Y58vGGRt5405emjln5LIfeMTh9jB5zAqQExMLFhoPBF0uScIIw
	SKZqAMPYLbpywxKvDYp0mTJ6OcyZ4HEuFzLmL19d1aQOQet70BtNKpZwvjd4AmkQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjqh0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 08:33:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6878QGc9032087;
	Mon, 7 Sep 2026 08:33:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03y4m8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 08:33:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6878XaU342926560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 08:33:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6E5720040;
	Mon,  7 Sep 2026 08:33:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF0B92004B;
	Mon,  7 Sep 2026 08:33:34 +0000 (GMT)
Received: from dhcp-9-123-3-18.bl1-in.ibm.com (unknown [9.123.3.18])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  7 Sep 2026 08:33:34 +0000 (GMT)
Date: Mon, 7 Sep 2026 14:03:32 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: nhuquynh@tutamail.com
Cc: Maddy <maddy@linux.ibm.com>, Npiggin <npiggin@gmail.com>,
        Mpe <mpe@ellerman.id.au>, Chleroy <chleroy@kernel.org>,
        Linuxppc Dev <linuxppc-dev@lists.ozlabs.org>,
        Kvm <kvm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Message-ID: <ap523IteSsBqzsVw@dhcp-9-123-3-18.bl1-in.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <P0S7RHx--F-9@tutamail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jDOeV9YhtMSYIT991h2GzNG7SyLAOB5u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5MiBTYWx0ZWRfX25ktg2jaxZ9L
 XC8whGm6ReEfA+ZsvlSba9PeZAh7VP8qixMIK9gO/fE9VSELvriHVSZOnQL46awxtW1DiAq9gUJ
 5fYyW4mzQN29Cf/pCMejd8Gp+A0ZwQ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5MiBTYWx0ZWRfX6grXX7B4QKhl
 gE++grhwxbz86+zGOI0nFdw4hWuvU/J+L4QHoEsKRisJ0unVRChZ5gc1cJRWCJyRmYt9nIHLEdQ
 bPHqznQ7hF7goCWGJ+ENFGGu7CLVnRSsCabhGBirj2QZeAyp4/RorneMnKNy7opwCHESHc/pJdk
 bD8E0/qRSQUXdYehB5swQial0dXmf4Acnav7gdDMOO+rIVQZzyoBZUfnJ+1IPJ5E6GN/YA3nALQ
 ARwd0lwh9IUlSXVeKdBnuWS0ogNvpJXvqnapwZ5VD+qz5kGRdBDgemU346ril0vawjHH1QnCpyY
 /pZqoJvvNfT1wIShyseCf+z3b4MUj2HP7PBzOQsNb7pSDnNL3fIF9Aft99KLM3NBiAUlcJPxF3r
 o24enzbszODyJw20DDN7buIS4kBjreqK/magcGaX5SIuPW6+eXqZ+a+OihQG+bLuv9nMpsNhi5o
 9yHgFWgTRXmdwf3nnBw==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9e76e3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=opkI-JdcAAAA:8 a=R09e3Zh0702w9eNjLlgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=Ww8VKtPN2Pdc02dhIGwG:22
X-Proofpoint-GUID: LavG8GBNDPuCOmI0Cv9KOaWXrzPsy3Fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070092

On Tue, Sep 01, 2026 at 03:26:56PM +0200, nhuquynh@tutamail.com wrote:
> From 80fd05e6d156d5a90d4908f2498bf6cc7acbdefd Mon Sep 17 00:00:00 2001
> From: Bui Nguyen Nhu Quynh <nhuquynh@tutamail.com>
> Date: Tue, 1 Sep 2026 19:39:49 +0700
> Subject: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
> 

This should not be in the patch description.

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
>  
> return gsm->ops->refresh_info(gsm, gsb);
> -- 
> 2.54.0


This patch does not apply

# git apply 20260901_nhuquynh_kvm_ppc_fix_callback_check_in_kvmppc_gsm_refresh_info.mbx --check --verbose
error: corrupt patch at 20260901_nhuquynh_kvm_ppc_fix_callback_check_in_kvmppc_gsm_refresh_info.mbx:30


The change itself is fine, but please fix the above issues and send a
v2. Refer the documentation in case something is not clear -
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks,
Gautam

