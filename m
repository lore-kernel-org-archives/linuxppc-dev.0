Return-Path: <linuxppc-dev+bounces-18366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DA5103E195
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:00:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbX796GfNz2ykV;
	Thu, 19 Mar 2026 02:00:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773846005;
	cv=none; b=Cmzp0DThBcbOk92zJgUsdDTFoEMljJdUHRfj6ybldtrRGqoVicfIVp27GluJ7Y0tEbRpkREwy0kGJx1U8ocZjj5pnzJAEAlDsZy+u/Dq/AlXvRJsj/6kpFUOdFkgN1zJmuKakfZ/7Vc2BmXIGKi1wV7RDf04cvP8MAcoZyuMG+as8MpDu7BB3mtvCiOKjD1SngzICNgxTj1gNQFdhvBS/2byJPB+WV7Mz+kjFCkIKCTVGChqHST0EknDqrRJdKu8TyP21xx8g3btWkwlJqrXqFkMVPQc1nyKcnpISwnaEfJp8ZuTJUtUMUZqRqgQ/xbZmENNDEz3bY/0u044UfDS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773846005; c=relaxed/relaxed;
	bh=Uh4fOJXtDJzMwDO/bK1gSi/CJGtyJDbqAAiuVzFFqxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvLa431fn4rPtZCV54m86q8WpKy2sEX4ZRnP5c4ETCI1Yr2MXxqM9kzvYZl8v0JdqaLsr0E5Ip7aTQTlIfhYOZ09YGACvZo5t3xm67BlmeTQ3yqhhqXcVJaGLrx20b6EvrD5UrH09lYBwM1tkDC7OvefHST4t+CkbzXvNgvmfZlgYP0Ve7LGGAQiH4C4kkBHgSuywwXzp3kIKM2aXidoe/pZsvhv4Qo09cICacVcgDc3vg33hcMd6ZRTRkTTLAzh66qzKO2xOxnIIBxUcqBuG2Bl0ikRrAkzaR86vXdv2YpCHNUA8QTA33wB5FiOaZFfRIMYgmGTOLTV9wqSRu0gZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n1A+JtJH; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ULk9GLtT; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n1A+JtJH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ULk9GLtT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbX782gWHz2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 02:00:03 +1100 (AEDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ICUHUs2878103
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 15:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uh4fOJXtDJzMwDO/bK1gSi/CJGtyJDbqAAiuVzFFqxw=; b=n1A+JtJHtip4cIYV
	if9eIluoDP/ws/9uHbs2v4qOjcRVDBCaI984p6EhO9c/OJWpivq9p3muAWeUqGvm
	lZXU9ps6stZh4m+6iOw4AVyZgH6G/AGwAcJBk8yUBj8FFOY7lO6hNEM1FJ3+uivq
	Phih/Tdvs4GooweewWKbyZUyz/v14RtNf/hf8nZbxy0yjMxMMiZzl64ExfHTBCKY
	ysdsBnF7bIElDKdRAFBORWv+OAnPzeZDVGWMrCBtghwtRHHhBhUIltrsqr5Ca405
	rp5PWweIYAafo/P5pZwT6q6Mg8vfvbd5Iw55oVterNcAk6bqkWSB2dKltaKxcRIT
	DyNaFA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cypwr20c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 15:00:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-509007aea22so321797821cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773846000; x=1774450800; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh4fOJXtDJzMwDO/bK1gSi/CJGtyJDbqAAiuVzFFqxw=;
        b=ULk9GLtTFh0XDkBU2J+MwvZDEWEreOPL/V3NuuPk+3+6N6oxT8R18FX6PJYutA1RRU
         Dn+GQRaImK7xwIZ0IRURlsA2ihZPaRIt1Ajwd1WbWcejs2JBw2zFE4VwBKG1pCpaX1Yt
         EQd8cRvx/1nvqiZlbNn5lgbYzhuEHuAJl9MxAa7NdS9QgI28r9UqUlg3EiG0kvQoRwOj
         2qMgL7x2X/n61HhdRKnGdXyd2ksZauRxMgW8GbbDOW4dDf0jkHoj04lP2oQ3A4ykgc0f
         CccG5Yt7GHh+ULoSdShWO17IDuO0MvaUxPehgt+QnFT6Xa9pQPv56DovTDUP6j59aP93
         cG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846000; x=1774450800;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh4fOJXtDJzMwDO/bK1gSi/CJGtyJDbqAAiuVzFFqxw=;
        b=c74kotdorbNr/0zkmeD4kGoiOKIRQwLgVuIkf70LrRn7VYTIH5q7w/QcmH4mANpl2m
         CTmL/acwNFt2IyLOF9ryzkwG8rjvWIgJ4xii30WzQS51ge+TqTr1xIFM54Bnc86/hJgx
         brYYnVbTRC/cJA19/4CgMDxeOUSccCfut+TuWIIbURd9D4Zi6tIyWgM60iK0wR/ikHdu
         3Fjj+IRSOLgHv+epvaV+unS9vY/O2xfwtrb1tJeH5DGd8wzig+3/AzdrSjXEC84CgFFh
         a2f8OTyvxkldffbgjP1Bpw0wDXJkHFkc7GV2SJX2E7WVuWbmmKvLoPTBc6Tiu9gmKvio
         lgmA==
X-Forwarded-Encrypted: i=1; AJvYcCWpv6SwrPLbsEYMTATO5Sih7IXZDsjwDiK6nayB7AACq18ENAZvrDIEOdWYv5Bk+9F/K4n6Ctbmtnw7wNY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwTBgGASpnSIEdIOoYgqyyZyX4rwb4j7d7Nqhb+Fjq2CB46I0xK
	2PEdoxNt3i+6Q69Nks0n68XEWfLJvlwbK+5DPzl4Z8mW4eAoEoezPm5T6eZCkN0sQZdS56j5hJs
	qOvwnN0mL/6D7roiY1Mwksaw3DYCXsmCXhClmZfHqFmUQNP6kCDklBkrmfNcZ46GewpM5
X-Gm-Gg: ATEYQzwUJwvMrsz4wvpvT7jcQ2tQPP2jdwoTmkKW9KTdoKG1RL2eFW65N0BvSklEWHZ
	fjzTuz5ha/T6HveYQUYuWeNFGw5v67Ghz6mQkM4j0WGEdXhsaPNiMhOmHr3Lrd6sz8Fr3OoFHHE
	Wzly4Nck0ni1LF0YIPO1CbZFy5iqIbNFiawZffKlXZgk7zSEVlEAZ1NLfgWq/Z0/dnTq86tfCb4
	IqAkFeYn9jnfd7/Ry979XbwadGNh+g5p0z4JFZEeJquQH7V6lhrtWsvooqqFT3uyqpSiCOOmvPX
	jQr6lhRIdKDnX7jADRMHn4lr4bWU+hsX7CD4z3VMoXoHd8/FjIj64J/Dv9ql3nPT5cqxSk2XWoC
	V4Ki1xqS3r+HoThUOcUBaDz/AvhC0eJu6tBfQ57QfqhaBpAHU
X-Received: by 2002:ac8:5f93:0:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50b148bc253mr47157191cf.52.1773845999908;
        Wed, 18 Mar 2026 07:59:59 -0700 (PDT)
X-Received: by 2002:ac8:5f93:0:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50b148bc253mr47156641cf.52.1773845999308;
        Wed, 18 Mar 2026 07:59:59 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667b0eb9c02sm1767039a12.19.2026.03.18.07.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 07:59:58 -0700 (PDT)
Message-ID: <ec20e380-e68e-47a9-ace6-6488de14228e@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 15:59:56 +0100
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
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
 <abqRvDiAI85w2bCe@gate>
 <dfb53d65-ee34-47bf-b305-5694c7224ec7@oss.qualcomm.com>
 <abqTSG-wg-9ahRTe@gate>
 <42b99f91-02bc-4062-93ad-02db3fe81b49@oss.qualcomm.com>
 <abqWvBj5_t_Q-y6m@gate>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <abqWvBj5_t_Q-y6m@gate>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bIcb4f+Z c=1 sm=1 tr=0 ts=69babdf1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Pn7rgDPiDJE6iWDejmcA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: vfCWd7mZQiLy2CaEOAW1jXPX96l9U3Bs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyNyBTYWx0ZWRfX1PxgndpBxq9r
 UeYzM8/X9XDU0At7PUKQSya4miLCbrkkt14mzpHqQiMNa7D1sh7eCE6PIF3ZH80RMEErRdaBezZ
 VrZ5zizPk+QRhDqV3qhDlOpdGds2nGj8KqMVuescsjvwMufcuiTcMDt6a+cR2ZEQQOnVGtlybm9
 VnGOkyx3rshVVgoCP+h20agFyPCofansL6aW0V8df3arZSbhYRB75dJ1oZpRwIL2O1us8Nv8OTQ
 kYTgrwxbfAeXBmc+MglHXo0ZxjiM0s+bgOzcdYBc9dXpo/WBTzxvkhZAmZNqFSv+n56zfJhyDGz
 QDTNvir97E7citdEsyejhoIWA1r7NXV/3b67zb/BsGrj2DGwW+sGp6mmPRoiTge77FlYKIbYfZ1
 h+fm5xSf2MzXZN4gOSuXewkSkk/ZEJAlXp6cljk77rcZUN2HGTpi8nha1AI5SktEXUOdBGzDZP0
 +SnXCR3+OKBlLMNUQCg==
X-Proofpoint-GUID: vfCWd7mZQiLy2CaEOAW1jXPX96l9U3Bs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180127

On 18/03/2026 13:12, Segher Boessenkool wrote:
> On Wed, Mar 18, 2026 at 01:03:03PM +0100, Krzysztof Kozlowski wrote:
>> On 18/03/2026 12:58, Segher Boessenkool wrote:
>>> On Wed, Mar 18, 2026 at 12:54:30PM +0100, Krzysztof Kozlowski wrote:
>>>> On 18/03/2026 12:51, Segher Boessenkool wrote:
>>>>> On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
>>>>>> Return value of ps3_start_probe_thread() is not used, so code can be
>>>>>> simplified to fix W=1 clang warnings:
>>>>>>
>>>>>>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
>>>>>
>>>>> And this is exactly why -Werror is harmful.  A boring harmless warning
>>>>> turned into a build break :-(
>>>>
>>>> -Werror does not matter here. We do not want warnings either, assuming
>>>> of course they are correct.
>>>>
>>>> So if this warning is correct, then patch should be applied and WERROR
>>>> is irrelevant.
>>>
>>> The build is broken.  -Werror is positively harmful.
>>>
>>> Yes, you want the warnings fixed, but maybe something else has priority
>>> right now?
>>
>> What do you mean? This is waiting on the list for long time - note that
>> it is a resend - so if warning is correct, for how long it should wait
>> to get to the "priority" box?
>>
>> And why anything needs even the priority here? Why priority has to be
>> discussed, especially for some legacy (I think?) code? Why correct
>> patches cannot be simply applied after some time/review?
> 
> It is totally simple: without -Werror, you can build a kernel.  With it,
> you cannot.

What are you discussing here? This is a patch, not WERROR talk.

> 
> The ***warning*** is correct, there is something in the code that can be
> improved.  That is why such things are warnings: the compiler can
> produce useful output, there is no reason to scream bloody murder.
> 
> The main reason some people like -Werror is because they are too lazy to
> look at the warning messages they get from normal builds.  Such
> developers need potty training, this is not a reason to punish all more
> reasonable people!
How is this relevant to this warning?

Best regards,
Krzysztof

