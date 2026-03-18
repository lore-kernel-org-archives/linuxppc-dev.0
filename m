Return-Path: <linuxppc-dev+bounces-18354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B39103E167
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 12:03:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbSC35V0Jz2ygd;
	Wed, 18 Mar 2026 23:03:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773835391;
	cv=none; b=EBYruhbcxbQYRffSUurlFvrMNS8TmHfvT6fgOEfbPNsL2TP4VwNYPJM9sviPpVJOrMy/ojUvcX98DsYFzncXYG7wf36G+S4hXzNFTGQlBr8VsqOPCOrr0IDc7pegHqfMFb2njHvDV15IHl2ck7uFxJuqaCv0vFhkJq/R40XrTBzTGaiQW5KPf/l9HRxwJN9tb0K6qBDTvp0oWDWHNwDuaQ2ekgrMa1QzHZWRWJuTQ9u7UFHackD+EVfP5enIK6cMPNdwIaaxLlqOIE447E02p5L+rDw9arjasHGEsRE4VfaBB+VsMd0BkKHAWGR3BwlqfSX60OyDXQPaTFEfTNM78A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773835391; c=relaxed/relaxed;
	bh=Qjwm62QJsYHzGpcjv5GBtAmLfJJ/nmxfwgjuhbT95mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FETuDvnt5QPOhXL/Hx8+MI501WayI9Id/An9H1LceXKPuwCYiXAwxwxSe87iePFLSrL27pW6taxx9h9twaCfmhVOCMna885qBWGP/c6CYXIvV2jlK1b0VYo5sEerD+rZgApD4ssLF32yUZhR0f29cNSQFhO7I3kRQZ/DQgM7U/GREQaIIROaMORarr1TGEdCxQaDh/HiYdO+buZyTtcn51/3a8ul+91RO8cpqD8N2ro9+3H5rmwoxfQVTU867pmgEV98pV06IdiRY1fEXoms6Se8/sJMV4KAWZc4ThdrtZg0Pi+RELnwC8dRnoU+6mgIDKLkW99TBxrz1NbEB3yi4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hUG4Kawf; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GH6yb5nS; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hUG4Kawf;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GH6yb5nS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbSC250pyz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 23:03:09 +1100 (AEDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I8IERt2789395
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 12:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qjwm62QJsYHzGpcjv5GBtAmLfJJ/nmxfwgjuhbT95mY=; b=hUG4KawfN/2Kdp3x
	cZ3YeKTsrAxE9gYqCDjzstSiBTKTqgThKVM7yzFZb6mhpTf9uf3fx7Hf2dp6YJ74
	QhZvR0K6+TECyNzB1hnZf0+KYmRNfc1YvlMfqs9jbVapEv7xvTSnFrNDLxJoMVsD
	fjkN9QDnDiZpuF8z19aE+elhxt4MgPKErDZ/NPhdAwEOv+j5VpwnSL7iR7rHOTXk
	gbsP2CLtiAZDM/cpG+V1Fujc++76g5LB6BpnCOUpS5LbBp8B6yYopZVJQcsIR03Q
	4s6gUu7auf7HZxcG7xtb6cTPJmZ6kV9B+wBZmd1XGKo119tW9boKq6NalUcInbmY
	czY9qA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyj4g2dn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 12:03:07 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56b07874e5cso1148347e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773835386; x=1774440186; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjwm62QJsYHzGpcjv5GBtAmLfJJ/nmxfwgjuhbT95mY=;
        b=GH6yb5nSOhHfHjOCwyBDrMpOClXnr4FKVCjQjLyBgLsU5ZNoRZsMptXp/d40VPza51
         JdtAQCSr6toExihvIle1g+N6HYRWI1CTeC1YXHDH4Kmxn8MZoZgw7wVAgYEouFgzkCfo
         dhdM0nkzX/jVW80UIvVd9qKMMMpvikkLCATTTvu1mq1fJiAlpxbAknJEsHF71U6Zf1ny
         5GlMneIlAZURqu5cAtHEdjWYfIj0638tXng3/Q2pjakoHsyLywY0RN5gBBAZfxl2OJl2
         dz0RFpr03x8+mMsROBTEhojKG1u1v4ftFgnVnrfJAFsc2i2pjP1bPLnHMVA7+dU5RMPM
         W8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773835386; x=1774440186;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qjwm62QJsYHzGpcjv5GBtAmLfJJ/nmxfwgjuhbT95mY=;
        b=KKsbnYlf9BfHDByGydRvQ10fgU66+Ccxp7A77VbYvPY2taeICZy7r06oxqEOXbsZTa
         x5y+Y+9mSQWETlx74nemAClbh/vBX36JQquFZJHDO5Aqe6JR8IF9mFgmm9WnHQZu83MY
         gU7HkOl0NciTUMYPherQE7k7HFNM+T8mEqRsQfNYzaarB1d18/10Og5rNs2wKmpcsDIv
         iOJaqjIY7SXEsiXConC0s+HmhDmrD6r7dKLj/AssVbMIeos72ddX0ESZ/pXFKOhOJVAl
         pZDhjW4bnOwGepIqH4QUDtZSFaAwzTmOuBTacqh0b6SoJ8oGpVJozL2/bKCvt9oOBw9m
         UndQ==
X-Forwarded-Encrypted: i=1; AJvYcCWATKtRcSsZKtyQ49XzYPTpJKxcQChJrtmsqWu8KXsBldUHus5+9fXda1C4J9EDvzGEu1It2/fpmDBksZw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0xbPikinnMTfR8yG5qi8APIAd0qAs2rZJddKnryPVk6mjpv0v
	JD+5JVuDYgRQnv3MRddSilxoQTV4uP1Dntn+HtftorqlStJd4e4M+o1VomnZM7Bd53Qsh8GYZvb
	QbpoNIzfOp4guHH5WkA1ziTzhijF5gqEirzzyP63xCGKJspvNSOw0c5GTe552HwANs7Nu
X-Gm-Gg: ATEYQzz7R9geerZWjYRFyqqnGGHf0JMbp6BGS/WdR7qTfT56hRt6zu+a1m4Nz7wkHGG
	cRrYgvAmxUUZq76UhNycvcGZ8qPahMFm7DX5FdfLDgjv8yhj+QlNmptJdol1jYjME0pbR4lwJBQ
	4zEGsUN8HENJJESC7Ei6NDHfeVdSvmufm4U+ONY/HDCzpa4D0gJGowR/lQeqoEBqURvwWYD0rep
	seM4W2EWCXEXWyhnxTzAghUG9rR/wnbGgCKIhMh6aKcpx2J61gagcSOqGlxFVkbd1CCOmXWZgPL
	uFjKk5WLIEIe/kX9u6t1z43X5HF+e4JfVv3XnzQnQku972dvud5qQpR2OtJzwWppyCPM/x74ISW
	6JuqKX8ZnfzXX0EUsEGHdH0riU8gAh/zif+4SU76SvgwXvtog
X-Received: by 2002:a05:6122:20a9:b0:56a:7f37:d18f with SMTP id 71dfb90a1353d-56ba7004427mr1657923e0c.3.1773835386516;
        Wed, 18 Mar 2026 05:03:06 -0700 (PDT)
X-Received: by 2002:a05:6122:20a9:b0:56a:7f37:d18f with SMTP id 71dfb90a1353d-56ba7004427mr1657889e0c.3.1773835386051;
        Wed, 18 Mar 2026 05:03:06 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5189221dsm7196761f8f.23.2026.03.18.05.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 05:03:05 -0700 (PDT)
Message-ID: <42b99f91-02bc-4062-93ad-02db3fe81b49@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 13:03:03 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <abqTSG-wg-9ahRTe@gate>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TPhIilla c=1 sm=1 tr=0 ts=69ba947b cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=nZMMRn6NZ40Q315s03oA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: ehxjFvofkfSSeeePi76FDbwmSG3A_aKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEwMiBTYWx0ZWRfX6Z8u7nlNeb4g
 4k8dV/pchqfBNekl9MOSFZM4PbMCp7lbblYHdnmHjYazKQziEulvaXWuRMFvJf9HkHdESjBwiid
 17IORBT0jBSmYqMLIGRRViCp5LvnN5VaHkuD5pW5aSVfC4rcrY5zb52Wi+SU996dE3p464ATSGI
 snya3+/h9SYkp+6Y2y4PQ5vqUXQCrp2ibcRQRYsi0rcePqAIBg9K2iiB04BjElb8sGQFYMnyULQ
 Lb6VAa9u4JfFgrw/3IWhhDxmcrCBeQ0sXHIwmMPmwrLmV1PR2WYD2Tfqw3Hbf1L2079jERZ2wXT
 nImMLXLNnrYPV4uLSNmxT4owPG6o2NgYBlfSAmg+dYIZKRmWBfq0kDXPzgrwp+uqMS60PASO/6p
 WHKtTN8ejsi+JNYmK4is6LBLiuC0389TERqT5KZTN1B7+5Cj76gGzzewTArg8NjkWOzoUGW/3x5
 I9EVpbl4KgTE8qigKVA==
X-Proofpoint-GUID: ehxjFvofkfSSeeePi76FDbwmSG3A_aKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180102

On 18/03/2026 12:58, Segher Boessenkool wrote:
> On Wed, Mar 18, 2026 at 12:54:30PM +0100, Krzysztof Kozlowski wrote:
>> On 18/03/2026 12:51, Segher Boessenkool wrote:
>>> On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
>>>> Return value of ps3_start_probe_thread() is not used, so code can be
>>>> simplified to fix W=1 clang warnings:
>>>>
>>>>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
>>>
>>> And this is exactly why -Werror is harmful.  A boring harmless warning
>>> turned into a build break :-(
>>
>> -Werror does not matter here. We do not want warnings either, assuming
>> of course they are correct.
>>
>> So if this warning is correct, then patch should be applied and WERROR
>> is irrelevant.
> 
> The build is broken.  -Werror is positively harmful.
> 
> Yes, you want the warnings fixed, but maybe something else has priority
> right now?

What do you mean? This is waiting on the list for long time - note that
it is a resend - so if warning is correct, for how long it should wait
to get to the "priority" box?

And why anything needs even the priority here? Why priority has to be
discussed, especially for some legacy (I think?) code? Why correct
patches cannot be simply applied after some time/review?


Best regards,
Krzysztof

