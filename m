Return-Path: <linuxppc-dev+bounces-20520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4BCD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 12:09:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Z1G2dFcz30Pp;
	Wed, 06 May 2026 22:09:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778069346;
	cv=none; b=ecgrw0yCMQdWYWcfTcP0v67Bg8q/hVMf/O4nD36gYuXy0N3WNcUvcTcLbkxwvrT0/mpTVbosa7SHlIQnS47urnl6asXCdY86iX73jRNs9d33l0tSCHyBzL4sRH11UeckCYwGYxq1i4yiF6Xsf+MVhNqt3FMkzE9SaG6Sj/XyNkI+4hf+a1rO+GFnFQXuT9Neu0Hvyy2greshTMPtG+xjq/vte8n1YcoHu/HKK+aKftBQcmlLvoS1/K7npydLlWF1EdNQAYZQsDF3cizhz9CKB8VAOrHd/OHL7/HY/YNjByot2L7+FP5B4ud7pBeKHAHzY6ZOtuf8fdmB9JdoGp+hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778069346; c=relaxed/relaxed;
	bh=RWx4nIYLk83UqaFWb1/ukrDvsP7QXx/EDHokPskBwzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYUDwxgOl7tr7QApWwexbdHeXDbrqzA25zINdVTjZU/7skdb+82L/RWyZRMxb2PzldmBB78gljuiTHWdEzLpWVv+0xY7VNpX8e0f468Rsx9UCoqrf9f2AJWH2UWQP2BiLkf5QIXEVe5qIV9ZMvJOvYvTpq5AoJKlOuOKOAm65evSsE7iAigvl8pXz+pxU0F/Q8Hol7tmwYewlpMtjmOlxdD8uZ5M9EqsjcrnvK5wJyOpWnVudwde2cMfFaZiJp+6ovBronbKDRscsEbLnUca61kcC1eCAEBDm+t4VVZlDioI1VNI3K5/kmVTNLjAtFkvWL9w30vB83Yo12s8t5rd/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=guFWe4Dh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=guFWe4Dh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Z1F0s8zz30Bd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 22:09:04 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645JOwtb2822130;
	Wed, 6 May 2026 12:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RWx4nIYLk83UqaFWb1/ukrDvsP7QXx
	/EDHokPskBwzI=; b=guFWe4DhPm4x8v6Tg7o5C0fE3Y12C1YKCa0buCEk3LgYTl
	C3ZHGgsrLYb6JKu8NBpjVEO0bfVHuT2n7xiUyHLa4vr05CvH0YsoSYK+CPcJVOOF
	LH6hGK9AavEHlQUEZ7n4/kZnPNr3hAmzIUsJLdt7akEGTZ/6/+VeV/iafgtf768J
	sLZv/MpuogsRbc7AyK0mEgIeUwtOmsGgfFSGt17Tfj+K9t+VcCu/KGdLwx8Oh61C
	AI0lbK/VTPFGPC3GkX9DDm9lN02tEZqfTfxxTcmvnco0rzrNXZg90fMb7MgTdY8r
	TYynxF+QN0JJnav6AAmK4nbSZrftMlDLMpcZi7Lw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4qvh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:08:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646C5LAB005155;
	Wed, 6 May 2026 12:08:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgdwv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:08:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646C8hJ835324196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 12:08:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 229C320040;
	Wed,  6 May 2026 12:08:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4D242004D;
	Wed,  6 May 2026 12:08:39 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.126.83])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 May 2026 12:08:39 +0000 (GMT)
Date: Wed, 6 May 2026 17:38:31 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, jniethe5@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
Message-ID: <afsvP9o5eh_ywGMJ@Gautams-MacBook-Pro.local>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExOSBTYWx0ZWRfXygrCa4yirrld
 5dX9ULVaN3a6A4W3n06KaeYVPoLPTiVMaxTKASLLyuRJnduMQz373uVc80MMxTL/e1QUxFuWKP4
 tYi6uNm8t9bRenhCh20/fi0/stIj/6r7i6kZmsxL/jQa+wMMam6hQQ4NJjNQCYz+lwzQn7xif8Y
 oNCNfg4hYxKLglX9TKHLACruZG85+jV10sXTnEh/9GX2acEeFrxJVrWc7mNdYpP1mEg3lE2H8ra
 eXnLvv0TZK3ruQUN39uL+zwRZo9k+G8TprvogKE/R+c3qQnVzqEQ4664ErE13VrhjD/OENS99oS
 tP16f7ov5Qube/oFxG0tdyegIeP0zyd2uovlSmznIYlKYe9SMSwcZm8DF4oNCF7G6Y7nex8YaOx
 JZsQV7UlZZsG9tKDJsEejzykIHo4ExIt1FexwrHqO0JvuLUVNaJgifTxVtc+3783iK3e619pM6U
 s4bG61VEveCKc9w2CRg==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb2f4d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=kLzKvu1pYhZp0h81DP8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: C5nl0Ur34Ch_vFUSL8u9tIUxDHAMXrEZ
X-Proofpoint-ORIG-GUID: CUXyK5XE1PeQjUj3lVhKbAB67miRvNgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060119

On Sun, Apr 05, 2026 at 05:15:45PM +0100, Julian Braha wrote:
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

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

