Return-Path: <linuxppc-dev+bounces-23304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FBBC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 12:23:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqzgp136zz2ybQ;
	Wed, 01 Jul 2026 22:23:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782892247;
	cv=none; b=PHqBK18+9lfmrL8goNyejW1D/YeD3nDmsHLMFlU+ckq86S5x7FVs9Z3DF28M8CbkwDFlM3CwnkEwVYz643Vik8MCzg2cX7NkP1wsB75YCBCcq7qaHyzdN6kTPv/6BfW8CbiCsHkLRhawC79OdrJSn7nBLnpLe4lYl+yHx9iQO2nHWy11D8TwzSPt97exuwFWLq+tmRvYMzx23GWsUC9SwXR6TDJDtAxkvzv5zjqRhMPXoZFi4DVphgRHvGksIxjFr2NS7CRjqSvrdfwbPSQWuMsvaBHNJmcYspJ5B+Q6esoMK5heYxIs1XvvmqLURP03TLs/lYIsKrZlvYtaWglYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782892247; c=relaxed/relaxed;
	bh=kMxsrivrDzOgZ9YW+PMIw9Z8lpknReER1Olw9eV9c6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJ95ccvcG9uQ713Gvr9txdLNwXq5Frz7itNhtH+KYsG1LvPnMRqkFyLNcIqOVh1t7ZywK3iZh5XZjMkW+habb7KlzHTX3C49SlZBn/5lYgymKRW1CZpVi+ewQDhnzsURZ4ZeTBrZnTm0Grk7NME1AXb3y5GB9iKl/BptQvO7tPeAFqpQghjICdlY09+F+u0HpumyKPlDSKsm2wH+xAu42djywaAfkz0R/KAUYQbVwSDlmDj9hi5EdbpySDnnBu7DlT5U+aJGVprdHAqb0b6t5W6QIp+GvLrsIxdb56tHfz6OsXTUdJFgAlXHvarCPnPKGlcAlUuW12OaCxRZxO8eCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HMfEvFRx; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RszQNicb; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HMfEvFRx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RszQNicb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqsdL2Drtz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 17:50:45 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lT0E140737
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2026 07:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kMxsrivrDzOgZ9YW+PMIw9Z8lpknReER1Olw9eV9c6E=; b=HMfEvFRx6nTIAtVE
	sL68tzthEIkQnLnX9Rc76Z+NLktj5+RvYSmZqPoXUEE+E5o+LkIIfuBJhwlpfY+J
	RMsiwlNHkpZV8rVnPyoGGxfPrNXNI5lgDH8tqDgvkEi0b2grHF8dSFgpODSc72rh
	0EjqgCOhK8TjyWAMMdGQRQAKFqqBtvWcjIDdgCvtjeMJc+b1syAik1phPUjpeiHT
	+mHBBG2Zs+XrFMXA0iCK41ffFLvfiku70zwRFhoOXlj4J9G7qR2SE7MvpJEhyGW6
	6kHzfxIseJu5NpodNx6tFH/VgtdgKXREk5GcvUEPZwLchVew9XyUnsRofUu/umcl
	K3tSsA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99k8b1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 07:50:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so35766485a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892243; x=1783497043; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMxsrivrDzOgZ9YW+PMIw9Z8lpknReER1Olw9eV9c6E=;
        b=RszQNicbL9+rYVBCZ4JJVZGi/BwxZRYCtdjpTimPOVPQsyEqfs77DhqTjJuG+ASrwE
         m5ywF+8G+3SROn9XsuVdX9ufHfimxgEcPB9JQahqzcHKJN836LP5R8RkS5LpPqNCR67w
         k75/47OyyLpl2j72MYrJVrt82T8KHxbdreQmMHfbJuNLaSbAZu9wCJXkcuw3+Ogfl7ac
         aJChve884Eio2XX80iurjFhcwEFwARStZFkwbS6MIvnoV0Dio1wzc3G/dBoD3JfbUABP
         SyAgJwCBy9bWIIga2zymaOiW6jYhsw8ghskSowo/bhhvE69tgu1XlHpJUaXpBrjtfWKk
         yZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892243; x=1783497043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMxsrivrDzOgZ9YW+PMIw9Z8lpknReER1Olw9eV9c6E=;
        b=mxh6IsD+GGPVr0P2SpBL/1+v7QHa7qYUwRtbxWAkeojtdweM+vrc3TI0USDo3Sr5Vm
         A86CwBxAw6zL77FJaMIM07ukRsayPBQEfkjKm/VkUk/F7678XDZJztZg8GRWqHBCmXip
         ozWTaTbPG8+/5Jy8TxBB1M2jAIR+KQWRVBInH/15GRTC6hmzUzHuQgvc2bH3iOuWBX+v
         pJXpDTcF7D0rHSZCFjswm/jQChp67RjYWCxwPZ5zP1hTICffSya8muZvzjk3vXUhUBME
         6t9TjrFMcqpjNyyhblrYsOo4xdLraMF6JuvO3OvhjK1mjQZZHhka61xoTSQPOuO5DQoR
         Ff6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/rRKE0cUGLj9erP8zmtxos6PQEqa52qmSbEQzhkjjRB+cjtxBA2W1B6mA5mDyQAWcnbtr6fdMU4bSjOpA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzlogS2nhYjNEriDbzNeRApWpajfzF+LYGq9HaNSDC3qwdmURwS
	2b96lm6gQDFjvtP9ZYAD9RM8UoKlMD29likSDRUfoypsLp7Rzuda749pFQgSpTJ2zn0FzwZJcRh
	zXw88tjAq74b9j8/GNGMbnjvK1NhhnM2snYamncYxuXYbT6LBgHlCPU2bhgjsynAI+O4s
X-Gm-Gg: AfdE7cnh3d/BFZjTClFRH93UfYgRPMOt3E4rL3BKub0B0nsn1QE1U/tPdcH/CmJfFMq
	AK00nG3Scf0rzloH1ZVr4kMkOpBNb6fYQR8wvVK08rFvRuxo8YYADbPsNc184bzZQp9uw0GoMS6
	YOMSIB6UKXjB4w9m1XoJxqISWKK6w7VcRo+zOokc1aBXGteYpLbuyricboQ6fgoNBHZCM8FZhOX
	yeZ2keu2jTvs0Rj1ABNX+mJQG/tFefGftONIDlzx5kmuY5PaNcjS5pBdWubQxnM1iJBRuC96HK0
	SdNX9xRirfuj948Ir2xQyhv/4WeBT11R3VLb+5JUynkGKeo221OrdEwTDuFV7MZO3TfAQsIiPcB
	HTCxyo0/Zxrnhm2eoMQiUwI1JMpxNDAv9SpPQ+0kRq255WGwMpco4SJ2eNYsRyA==
X-Received: by 2002:a05:620a:4504:b0:915:8502:f7fe with SMTP id af79cd13be357-92e781f1943mr80047685a.15.1782892242433;
        Wed, 01 Jul 2026 00:50:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4504:b0:915:8502:f7fe with SMTP id af79cd13be357-92e781f1943mr80042985a.15.1782892242042;
        Wed, 01 Jul 2026 00:50:42 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm77836705e9.15.2026.07.01.00.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:50:40 -0700 (PDT)
Message-ID: <b7922ba1-60f0-4135-8b86-e414c058a135@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:50:37 +0200
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
Subject: Re: [PATCH v2 8/9] sparc: vdso: Respect COMPAT_32BIT_TIME
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
 <20260630-vdso-compat_32bit_time-v2-8-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-8-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX/aR2sPF46tT9
 Y0rMS5bnsA23PzsafOAZat6WBsv4r7mU0qvXoHz5YFzFx60QXBuFWZkb5pwZCn8ozA5elWiV84B
 ihI0nTqCY3biK1NI/piCd6yuhZykId0=
X-Proofpoint-ORIG-GUID: WnQ1YcYm6dCqch7RhG-v8-2RCx_aphzR
X-Proofpoint-GUID: WnQ1YcYm6dCqch7RhG-v8-2RCx_aphzR
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a44c6d3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX7vYfBHf5hPDV
 wTGaZCS98+nW4hhJAre27vMqQP+6rAPlHwxA0/lDKAng0uWE6fV3t8R7ay/vvxackX8wqIc0QGc
 lf9jt9ft3bqjOqoer5yRK8TAX69TW2s2v3KYLZVzEmjpYPQzJqDuW9PowBjDrM1sr1zupJMOUyD
 MYPn7D+vqp2T3p7oM1eZLksjvk9vF6cgVLNw7zQG4Aq/OCXA6luYMezDKFExlbi8NyK3AcDhCNN
 JDX8qyJH8yvQBwrL/HzyVl3AVH0kZ3N/PNh5JLcSxgkADkFrcDPuFsROKgkSwpfeFmHPRZvwK2t
 idmCmvg7/BwN5CPefGoqtEpXUiib8XUFoL/YUDD/VzpiTc9qfcWGqYtmcNsagxzqvwEVTWaLtLS
 11EvvNJ4Z7ikwEoPL9UjAUegal5Vatwl4++T7jOmmc2mdxdfECqTP12C51FPz8JetF48ehcjx5J
 +xVHI5Gs/ZpOJx9y7Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
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
>   arch/sparc/vdso/vclock_gettime.c    | 4 ++++
>   arch/sparc/vdso/vdso32/vdso32.lds.S | 6 ++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

