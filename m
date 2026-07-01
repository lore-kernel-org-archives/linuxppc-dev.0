Return-Path: <linuxppc-dev+bounces-23303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0023AC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 12:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqzgZ2tyLz2xKh;
	Wed, 01 Jul 2026 22:23:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782892182;
	cv=none; b=NrgXOv/owL4nkXrf6sIiLAJrScfPIbq7psWNyqUjcvmnzmb+8GVAii5iIHa6iGPGnTeIC1PDpR/8MmAcXuT7uvweS8ZIALRnjTeYBl1kWLW94h2P2hwCA0XDUJTBpz376JK6oBxKgQhSGSZYY6OtKEJuvlGXdmfn53aypbcojnacTvbeOOWh+if7kLN8hfNniXEwYxSRKcKYvOBWxqBCpeQEo2Yyp/EthRd+4vknLCScS4t+QfYyEycQNAfS8HMgDHwTZvssSl1YlyK/tCzefDKoIvxyeg5NcxADMIijq3sKSHcB9DxRBDDo99YQMtdO14bOoJwdPIiPPegRh/OHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782892182; c=relaxed/relaxed;
	bh=tO+wGssHzCkwgLc1fyD6Bz2Zw0cVzq6FhbGs/0ytjg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJ2A2JUevR2gSXMAZewzaeEqsNHrZNiUYP5SGrEROywu++qCTUkPiRQpI75F+EglXcAr+M5bFLVXXUS4NHrvO7y3czRtT5MY/Co6ukdvbCtvwapqC0EdKh92XZXjfSq5uKfpSyeTGPYkPrDuHblAPTgOPqu/4spS6DMrJWkgJARNNRsNm9zxE/O0gdLaEcI1AlQFpsRHIt+/WGgSYvXcdA/33gzKthL+J9TZR2oqLXpr5z3jebkG7RvsoFQZwZsKvwV8Ww+MhVCSjwIcTJaRnHku+2gqlTJocvgPvDVAMAjDUS9JoL9ACnVBpSTCyqISEK1pSGHgM/J0B/v2DCjDDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cj9hPbcb; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e+VsOvUA; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cj9hPbcb;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e+VsOvUA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 112 seconds by postgrey-1.37 at boromir; Wed, 01 Jul 2026 17:49:42 AEST
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqsc61gqHz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 17:49:42 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lYjp059375
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2026 07:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tO+wGssHzCkwgLc1fyD6Bz2Zw0cVzq6FhbGs/0ytjg0=; b=Cj9hPbcbpWbTK+tF
	PIcK3PBPMaXTUuCv/sDEIZo5Y0/0nqsviQe1Sa2GXh1P431Pj3fnTpSPlaXTeDwn
	TejVsKuSbEwrL/m/AnaWDqhBuceZkeHF0ZsVBuk9HfOe8gugsp87HitC4zRCFssi
	k6ElK05VWfaFfa4ppKG4OagIrOqSKu1qzdm2FACtXswaGGtn3D+wovGnFISOY7GX
	OMvVD6rpHgm0xjYIk5hYyHMTHswLl1ybVHT0kDKMfw8cMtPhTll65hQ48rMgVW19
	6WCyma+Z3Xe8amIkZHwcyG4+oRHAwiriPfz76n406OSuMECtU/mf/hi9TS+eXug3
	o6S6LA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sjxc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 07:49:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1b4d961dso3445191cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892179; x=1783496979; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tO+wGssHzCkwgLc1fyD6Bz2Zw0cVzq6FhbGs/0ytjg0=;
        b=e+VsOvUARA0M68sbmkpDnV4oScT3JA1yCrRfMBr7TQHMLpz56Qzmc27522lVBzA6rW
         NkG6wGRtUkNHeTe3K70fngJHgcvnLHqIabSvhD5J05pUDG8cyq2u7EMwYb4W0OpA90HK
         h7NFwxKkP3PcnDPEJyAqEsKqApfaFxbxL+V5o+OKMR6RnwSoJW4VVdlFbQAe0IGfsmJt
         5HPb0bzT/mEqRrw8u/bt1lfeOGQUBv6zjBjb2mSc2lrpfARuewiOodoeO4uSyKpaEF6C
         JazEL60ZOHb+wGYjMG6eCVxXTyzQnEuaR9sM6tPMzBCZ4a238av6MN1FHLTaQEfNM3va
         hzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892179; x=1783496979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tO+wGssHzCkwgLc1fyD6Bz2Zw0cVzq6FhbGs/0ytjg0=;
        b=FcfbPKMzYpasZhJZBuKC2ToiOdvbD2ouwgxT+/51Xz/a7yjLxGsiiythOmD5FoT22P
         OcbCr0kHNXJ7MaH6abQYNMKzGBLYHiaC4mgJsUCAQ4HYckXYlhhglvlkeygf8dFMyhzD
         SGX7CQV0O3eHSPDq/FHURCcVbRvH5di2n1Ey354StCi79UtYo/OaAI/6UyW96QYeQi5p
         pDG2Y12pwtd46R2s2CG3n6RZjzqPP8CAOFdNci+PFYc5L6H4vHIcgl/ND2uDWI7feqF3
         ycOlEaW+WSPhkTFLv6Jw9Jl38Oi+VCETIT2S1RahuzAz34GhkF1Pi7dVMgYyixFj1lMr
         WoAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jnqpbLQrHXWBRmuKasal6S+LST1tlPnptDk/CK6mGOLJ9K9BQ63sj8WyvompbrsIIIkO4caa0N3P3Y3M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwsALWp7OLoz6B/ZX6VgPoZZlU/zHDoLJ3F+Fo9Zc6pi9G0Q/dD
	W2ui4OI78zdcV1R/c7jVRpcBHOYIUCRYPeKoDe32wjKMB54ggFaZUx3V6gqzPMxK2jkb1XkIW3T
	zKSVgucK8BQD+aW1aQ/9tVjpP35chgQurUwcxec7PI6vtxdqke+kfIDBd2U/+dgEKyZvo
X-Gm-Gg: AfdE7cmmVGNzmkUsVulkKT424sjrUXDP1SSAeUTGP7msiAtsw4qw+BV+tasxyKcmDmK
	IkrrsMYWYNJz+b1pFDt6KAwWO/ok39oJgSRJf4cZVmCOpxGv//28WuNbRFiZY4SBwRQIztIpFsP
	0HKC3SbF2brkQJzREXBtTgM3tBALbiAg/FeSeUAEY0+tg741yVCNyMRPG6ZtCqdyGtg2Zb+NvI8
	U543xmhLfUxW7R6n8ttt2JD5WTxjh9+rdNk0b7LMgDvo1JiV4dRif4XvJYBYaUR6WqxXzv5QcrD
	0XfclcHJNeRAUX443YnkMGNk+cQKTs+IrUdCVThE9XD2HpD6oMY7sQj52RUQ0dMUHg4dLblQNqZ
	QXzIuN9YlJ6J6F+Bb48XAZ6/UqexQQzH6y+7pDRNGuldi4kPgH3wTEiMZWPvPqQ==
X-Received: by 2002:a05:622a:4292:b0:517:146d:2cb5 with SMTP id d75a77b69052e-51c17e8f1ecmr60558781cf.20.1782892179082;
        Wed, 01 Jul 2026 00:49:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4292:b0:517:146d:2cb5 with SMTP id d75a77b69052e-51c17e8f1ecmr60558621cf.20.1782892178662;
        Wed, 01 Jul 2026 00:49:38 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d194bbsm13031759f8f.3.2026.07.01.00.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:49:37 -0700 (PDT)
Message-ID: <4eb126f4-f9c8-471e-94f1-ff40675dbe73@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:49:35 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] ARM: VDSO: Respect COMPAT_32BIT_TIME
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-5-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-5-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xRKJgZi-1Hu9uzhKHinM3StrbPCGqFgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfXwg/IA1JWB9cv
 n2EwQnwS4w8khFDad5JR4tnHWPwOiSXkGuPea78XgppbpaJSbDff1Aaj/+CaFvWIQ9nD7tCJReu
 pXY4ravAUgjTJtG/2u4VzWZQAB13Jd02u7wLKi+NR3Bj4jcaZITZKgzkUHe4JVCgoxrbXV/H/KB
 aeqoYBXlpQOAKGnS55RN2R25b886AT2GwL8Od21iqNvqOYQvj+v3EfVOXKxI3NKCp9SkNHn1b+e
 KxxTyCqO9bgQXLGDuGKlnSg9n0zC9sS+poUs9G4rpAsxy9kgi7ZQqwMkPeB4FqVb7XNjW5uLOI7
 dQVGpCo3khK7gNMMqR+di7MMNqyHRKHtwdV9FvLrRqjLtBg+sOJ4r6CdqXsrsOl4+oCNTHm+m5z
 kEvgSVmcE13YSyLhgLm9A/fq5QPdnG9tioBNUp6Yhm6tCCWVKiSalQOkbgOHLGtOteHfBGoNMKW
 pfpLBzDcXDv0L+MQZeA==
X-Proofpoint-ORIG-GUID: xRKJgZi-1Hu9uzhKHinM3StrbPCGqFgE
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a44c694 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX+qRN+VX6R5V1
 Uf9vJOqDu9+EtoxQjBp9RaVBuxiAIUkQm7HpJeslyeEDRU8woFekeLbiByWgRikIYuvtyPYcoEQ
 egCb3d31x9fwgTkIAiwRL/vgzgluMvE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010077

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality. This is the intended
> effect of the kconfig option and also the fallback system calls would
> also not be implemented.
> 
> Currently the kconfig option does not affect the gettimeofday() syscall,
> so also keep that in the vDSO.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   arch/arm/vdso/vdso.lds.S      |  2 ++
>   arch/arm/vdso/vgettimeofday.c | 14 ++++++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

