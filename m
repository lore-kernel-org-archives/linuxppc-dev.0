Return-Path: <linuxppc-dev+bounces-20517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0254ECD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 10:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9XDD1tltz30TL;
	Wed, 06 May 2026 20:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778064508;
	cv=none; b=ZHYT6+7FyI8G7T4pAM0tBxw2ozTvP2qUzwVQ12lexBqijX0+7WfuJgwwaJv3NjQD3nuWe/Lq/tHRpMHz73/xWBMVSqAKTcdo6RbLhac7PV3M+YvXBUKJkcIUad6Bf29I6mBPwnBGnpShAJzAF8KYMVG4PTIr7AOBp7ZKGw5elBF5b2t4e61G9+N8Rju1ZCL7AMUomzUO84HTaqhxFYtdCh/5xtcrC9ecHb2nY2q4VfEIpMGpCcO/j8jfdk4uVEFuuyXoHnmec9SDITv8NWPsVS2jUlZI8ypxuyu5JSEu9EUQQPN83fFPqw6Q+laFQGruK7Ac3ywA+HFcaKusLY2vFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778064508; c=relaxed/relaxed;
	bh=1SdegPMKrh+nNGNt8RzmVOze7K+yG4TrAT4PqGXeYOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNpDLa2A0JWWzCV4PuhHqk0Kg0O2l0gZac+EA0jKHq4zXB03LZC89fJnoFjSxVQXQBkAn5oBIWKttWi4FJ8KPufS6xVMp1iRpZCHLJ/HpS2cmC1gqP/6T+3UCRfwktHta5B/fPBeLN+OJw+wH0Tz7fjzrvy/RrD2wn5yOFE1avUA6jluEAXXWGJXQtSoGlrunattku3d/sQ5XifTozdcT4riwlV/SrrCvMBvdRbh677NMHvkzQmOjxIaG0q1nDoX6nwNTVVcAuc/WIrtW74YtKCYI4+dWJuLp+W4rTukiRVdTIaDqDoeqTaNraW/C9ZwR5eYlGn4ceIvvf1YWwiTPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FP+Rb0M7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FP+Rb0M7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9XDC0tbSz30T6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 20:48:26 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645I22Aj2791324;
	Wed, 6 May 2026 10:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1SdegPMKrh+nNGNt8RzmVOze7K+yG4
	TrAT4PqGXeYOE=; b=FP+Rb0M7UHQulsozRvex6HMG0A8kl4+rokxzxyZSMXgIvp
	bfA1HUjPk/ypOgMszkSWogx8vk/B+EjWWep3UR+Zz3YT0N/enmf70NOCqtbGtBAV
	ttFcVGWdqt3eIVdTTGhWKWLgV5hyOgLyg6yImCx3Fp5oxkmvvSsUeGO0c2rIyNhW
	GoRjwlRd0xcfA5zMCaztvspDp52viF774ES/BCvGkJtUpT4w0UZUxuFM1vIsfiqM
	i9e3Q2NGyLGCxxFfo1zwoXiHDfXNZwGuidcimMev00qRt+9RuKcyKyQG86parh/S
	mpX/5p9g+VpRwF47YGmgO5Ue7XvLCv4oR0O8kbUQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1g6d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 10:48:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646AdX6n012251;
	Wed, 6 May 2026 10:48:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqe12q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 10:48:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646AmDD847972766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 10:48:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE68D20040;
	Wed,  6 May 2026 10:48:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6392820043;
	Wed,  6 May 2026 10:48:11 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 May 2026 10:48:11 +0000 (GMT)
Date: Thu, 7 May 2026 13:46:21 +0000
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, jniethe5@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
Message-ID: <20260507133231.7a92aed6-96-amachhiw@linux.ibm.com>
Mail-Followup-To: Julian Braha <julianbraha@gmail.com>, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	jniethe5@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260405161545.161006-1-julianbraha@gmail.com>
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
In-Reply-To: <20260405161545.161006-1-julianbraha@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: X8iZ-IcEeqdLZ-Egm_owv3I5mXYqoN8U
X-Proofpoint-GUID: QskwoA_Lz8FNRfnQaWTAtTD-3lg928w4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEwNCBTYWx0ZWRfX7wBPZKCvuF62
 fUNlsgzgwq4ljwWhU+Ju9jLdXw0//XkgJzAOq/nDB3x+S3t2NnQHRIXwq9tTZzkU7CfEHCOpGcH
 QI7rcqoJKr/JbL1SJc8wj8x3vPLknQp1d5iDPuG2y39vCspjhGNprDC1UVy1fIc/iPjlpzSoPOv
 eqx5wzwhdgxFoboKdhkQWK4Z/emBmTGOtpMdTCccJaajfajouP6ThGLxGBUTZKItKE/WjR+VBAm
 vXbFn61+hQZ4mad53dpRwp5HVB/u/YIwGl0e6LfSk+n1OBBq44Xy4XDSt9Ue32GipKAZMRfv7/U
 dMgvdfKQ+f954+GtUxX59joMR3hJvuKgYd9Me5NqhfEU1kCkQm+ErjLjeirXxJqkFdZ5POBOIRk
 bv9NbSzjyIkyE9tvTCKcdySc/5g5qPmfSE8HQe7cyoPORqYYPrN9nqDfj2jEtBDbjbQoHANfEhb
 PUQOMhBs2bsxqJM1maw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb1c70 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=kLzKvu1pYhZp0h81DP8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060104

Hi Julian,

Thanks for the patch.

On 2026/04/05 05:15 PM, Julian Braha wrote:
> The GUEST_STATE_BUFFER_TEST config option should default
> to KUNIT_ALL_TESTS so that if all tests are enabled then
> it is included, but currently the 'default KUNIT_ALL_TESTS'
> statement is shadowed by 'def_tristate n',
> meaning that this second default statement is currently dead code.
> 
> It looks to me like the commit
> 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
> intended to set the default to KUNIT_ALL_TESTS, but mistakenly
> missed the def_tristate.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  arch/powerpc/Kconfig.debug | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This test is specific to KVM nested API v2 and is currently opt-in only.
This patch enables it by default when KUNIT_ALL_TESTS=y.

Since PPC kernels in general are built for both PowerNV and pSeries
platforms, and the API v2 code is always compiled in. Also, the tests
operate on guest state buffer in memory and no hcalls are involved,
enabling the test by default makes sense. Hence:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index f15e5920080b..e8718bc13eeb 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -83,11 +83,10 @@ config MSI_BITMAP_SELFTEST
>  	depends on DEBUG_KERNEL
>  
>  config GUEST_STATE_BUFFER_TEST
> -	def_tristate n
> +	def_tristate KUNIT_ALL_TESTS
>  	prompt "Enable Guest State Buffer unit tests"
>  	depends on KUNIT
>  	depends on KVM_BOOK3S_HV_POSSIBLE
> -	default KUNIT_ALL_TESTS
>  	help
>  	  The Guest State Buffer is a data format specified in the PAPR.
>  	  It is by hcalls to communicate the state of L2 guests between
> -- 
> 2.53.0
> 

