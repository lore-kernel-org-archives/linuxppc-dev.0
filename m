Return-Path: <linuxppc-dev+bounces-18367-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E6103E195
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:01:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbX8N24QQz2yk6;
	Thu, 19 Mar 2026 02:01:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773846068;
	cv=none; b=i18WS0h1DehRFXYzgqx3kHVq2+MlHHk3w4aTVlgNIyhjZ6mMXxlEv69DCNDrSKVlc4rqWRhEnAscDjeqF29TeA2PDBRFPWC8UIBRtO8IJB5fh6eY3JYXdBccfjA842wYlE73Qejpv2t5Fu197OyjLbeeqsGSOaeOomYv6hkGGvDDr41qdfLuz5D0IIwaLJRSQ8MOpaFhkKHlk+kGNcg8BfgY0EQKN5FhmBOtQtzxD3exdMg6HEU5qePpC7sIwbR88CCQwwVeaZ97zUZs7ENdZtD9ZLlIJiIXqPcmeZAOGfF2KdvN9RYbCnMGyHlWWlefeBlXw/u3TOT/Mwo4QAK5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773846068; c=relaxed/relaxed;
	bh=GoRA2L8D/wURa/t15xJL/5XRoOAzSYwjg4eZrkQhmRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0vJAGVj9JMAXhybO/kzzP/50hpZXw3dmg/TIeFBOII0Rlohixd+M5wd8T3aorCo4Lz4QaoAP3D5/g4Uq8CoipwPnf7E6OFTJpWmWd1TINU0aQoZs49fOTV9hs0uM5CINjxc8Tzvlc5/C6XHYO/JAMHDzmYUY6aDDlrphWYs2TlsdXWJlO7e+x9/Bu76ZpMKh6ZRxmv2ofMWM7OEnG0tZHXqksAvnnswRPQh7GShlrnkXdMLKQYZZYouMdHTIi4GHg4vrYlS9p2SFva6RUWWVSORg6BNn342NyhWTBu+OgOv+kISQc1gp0qivZhozc/uLbuQiipvt71q7CC/HGzqrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AtqAR6tM; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=blLCZpnq; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AtqAR6tM;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=blLCZpnq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbX8M4Hghz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 02:01:06 +1100 (AEDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I8mtHB084761
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 15:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GoRA2L8D/wURa/t15xJL/5XRoOAzSYwjg4eZrkQhmRQ=; b=AtqAR6tMi3ikpWkL
	in8e0PAi3EBWndJlXJobe6bmgyDzv2lkO+SkJOoZb6pRkKPjhAhtE4/qCbLXxG5o
	C69L+LZtpBAg00LODkiljNSvZ+jlxNUztu5kEHU5a3g+L8xaDCL1tFWJglhcpDRD
	AjXCL3C3ZbH9JbbuSOjqM0RS9Tm/9lWMwuyxj02QtagIBzgSz1biNYK08n/fL0rC
	t0fSKdq25gqKBxOMl+dZYg20x7gWEpzJwqu2DBubchpcHM0SelkUR5LNyPSxMf5W
	XT6mMDnH7ICg9U98Fcwfngn25xLUJ6ftJF4SKpHAZiemlSW7tRPJfQqyDL81SYV+
	kM+Oxg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cykqets0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 15:01:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5093787e2fdso1008619341cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773846063; x=1774450863; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GoRA2L8D/wURa/t15xJL/5XRoOAzSYwjg4eZrkQhmRQ=;
        b=blLCZpnql3yT9Nj0YrXI3lTFDW+yf195+3royJU5DSv8/YEs077SoqBsdUbcqolqd1
         kKnbj+7QrEfGwOWoyHOBwdWXziPGUHSpqJJ8oJl+71CfzNt8HMqYS916MKxF3FYAtrR4
         lpeZgCkB8m95A0lg5IdoUMn4lKCOg6MLtPMxppVcvEclKw5z2cbboYxW7vsSpZbc7SAf
         Uq7/2m8HL305xYRO6P84x/RyPQNudYbNsh+lqu165U4XghpvsUEwyuqwaz/VjlQGYOx5
         B1WqI5n+udi4jGJFjr+wVwLRhvnUKSAGeZ9pvL/1hnilPF4Mn4hg91JjKWHH4iANW1C2
         OVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846063; x=1774450863;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoRA2L8D/wURa/t15xJL/5XRoOAzSYwjg4eZrkQhmRQ=;
        b=T7+JXHCWxOLsmfaoaNgNNl0M6WWXvfK3lTI6AGNRbiXczfy85bHvBxcXb6oStK5P0p
         ElnqnDX5VBDP29Wwpox3Tsp30vbrCuJWMnIveBW1rgSWbgXFfyKlRa6d9bG/RoCedWiC
         dGiA5JfkPmf2lkv2sGDZnWRsjlUwXZ5cJlJ9wrWvlFGTy5p5vtITF3j1peTRTcg/L7o9
         9VG9mMxElnn/OkH9/iVMjuWw8YjueF1SiCLtL6paSuQFsLCu6uHR/fe5WE1N1B2nQG+D
         /e7osAHhw5/LZroZoxuQQbaA2bJsOvR//Lqf4AWWGH8sj6N1RxoRM/KzKYpNjgLu6MV8
         8jfg==
X-Forwarded-Encrypted: i=1; AJvYcCUi47noqFRpapBOfAXmDiLV1l5jRXFbPHV1Dkf106LHPXVLk9li6VhklrxTDifR18aCya0WQRU8pSOtSWo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxny1NFYe8WPuOg3SGmbGaOtdZqQsOdu7EDCf/CqTM/nXjv+vLV
	FwL55VgRVdQtD+dRYcPOogtBglDcgvOJBv7+qAcGNjPONqEMMV7ybatYeOsUCBaAZibepoArvgv
	xYKAlXLub97GtydQTIFjI943T2iPtKGSF97n/0FPZSRlpdZxrwjPuVyRqS58C28R4sNbP
X-Gm-Gg: ATEYQzxuCDLHWMeWQXi7k91MwZiLJNd+RNa4bI15Ptd+Spa4Sy/+zHjC7SC03JT1Pp6
	kJe1kVPgZdgsnAM2v7V4GZA1OyQ+dM+czZYKCi6U2NuDBQZ29ITTtC/nLTDygURVCXSPUWokbMa
	YrUO+Py5YUeFJhmc0P/aLmLFzF0J9w6EB6iJLp+C1qtmfgIiv9QcX6SkfDeMkxsXAW/kmosKjbk
	bKgQ7OsGRNWJU7efuLf6qJrU8P4YXCI8RDQTgDWMsIXMtBQatFxsiv2UnJ6WNXal6watoArkoDp
	0hCtgFIbssq7DtPnYqCOrI9ejRMeLNWxry7K3jrLE5abXVM4n/NXoQ3g9JoFPeWT/3jsCBfHfpz
	2hXu/dXdNd1IniSHaQsJebdn6kHPWUgNuH4N7t9Pauf7FTOQR
X-Received: by 2002:ac8:5755:0:b0:509:4410:4492 with SMTP id d75a77b69052e-50b14796234mr47711671cf.22.1773846062596;
        Wed, 18 Mar 2026 08:01:02 -0700 (PDT)
X-Received: by 2002:ac8:5755:0:b0:509:4410:4492 with SMTP id d75a77b69052e-50b14796234mr47710741cf.22.1773846061978;
        Wed, 18 Mar 2026 08:01:01 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaee04fsm144565215e9.13.2026.03.18.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 08:01:01 -0700 (PDT)
Message-ID: <f40ec9bb-ab51-4f20-b67d-c2eda1b646d0@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 16:00:59 +0100
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
Subject: Re: [PATCH RESEND 1/2] powerpc/ps3: Drop redundant result assignment
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
 <abqRvDiAI85w2bCe@gate>
 <dfb53d65-ee34-47bf-b305-5694c7224ec7@oss.qualcomm.com>
 <abqTSG-wg-9ahRTe@gate> <9434f836-aa96-44e7-8f34-243d6c94f6dc@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <9434f836-aa96-44e7-8f34-243d6c94f6dc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyNyBTYWx0ZWRfX8/3f80LpCr4M
 4JEhY6gAYM9NhAHUfrRijyQxdb0/MSWuOBhaEG807fkPMiuvYjdJ8NiiQCzFonEez1gQRErimZJ
 hibjL6qZRJqmNYLsh/D3/oGxye40DHDphnD6q8Ry6osyEZDsFpXktyhS+MVIwZpiIVgAbCuqGrz
 XxM9at0dFXVITqsb2rb9LWMUu+xOQlTeuIFey8EPgkFJbzsbEDfP9EnAQuK6FEEk/PgYdkr74zp
 H9za2dQZV/mPkhysiY5ocaHS+E+0LY4BFNb17DJTixblhEH+Tp1gczc7ZPp+G52VqCkTQkE/RYq
 qay54gy8qO3nqiP6ld3V2Q4oEzgy/IgqHacSVi4lfrFFbtNc7bSYmIJASYGguBNgBRVGTaf57J6
 FhqHyRtu8YNvCQX8SmmII99LS557afG9kqyCN9PgJM6712GQJZYDVSd5qP1UxA/V9rhtlDC+f7L
 UuDgnkA7t5f4MJsWJOg==
X-Authority-Analysis: v=2.4 cv=Cd4FJbrl c=1 sm=1 tr=0 ts=69babe2f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=LO4XtezffzH7F-Og_NQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: d0A-CNaeeNW356z8SSQ4RF--fDbuWkNZ
X-Proofpoint-GUID: d0A-CNaeeNW356z8SSQ4RF--fDbuWkNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180127

On 18/03/2026 13:21, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 18/03/2026 à 12:58, Segher Boessenkool a écrit :
>> On Wed, Mar 18, 2026 at 12:54:30PM +0100, Krzysztof Kozlowski wrote:
>>> On 18/03/2026 12:51, Segher Boessenkool wrote:
>>>> On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
>>>>> Return value of ps3_start_probe_thread() is not used, so code can be
>>>>> simplified to fix W=1 clang warnings:
>>>>>
>>>>>    arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
>>>>
>>>> And this is exactly why -Werror is harmful.  A boring harmless warning
>>>> turned into a build break :-(
>>>
>>> -Werror does not matter here. We do not want warnings either, assuming
>>> of course they are correct.
>>>
>>> So if this warning is correct, then patch should be applied and WERROR
>>> is irrelevant.
>>
>> The build is broken.  -Werror is positively harmful.
>>
>> Yes, you want the warnings fixed, but maybe something else has priority
>> right now?
> 
> But if I understand correctly this is a build performed with W=1

Yes

> 
> Without W=1 there is no build breakage.

There is no build breakage with W=1.

This is somehow total offtopic or trolling. :/

> 
> Someone who forces W=1 on its build can be expected to unselect 
> CONFIG_PPC_WERROR if it is needed for him, no ?

Of course :).


Best regards,
Krzysztof

