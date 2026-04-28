Return-Path: <linuxppc-dev+bounces-20242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9BDFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 13:22:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4h262N0hz2xld;
	Tue, 28 Apr 2026 23:22:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777382574;
	cv=none; b=OhxuTm5Gaq80zNrkg/nYP32e1/ARYiZx3lZQrREEc9VSbwIWy6M7oINYtChWpM1hbWIcr6yKYX3feQZWL2ieBLpFF6VKuZgKc1yqjNvHN4Yx+IAugHKFRCLIbFR8h4bl9NvFB/brkPgXObt7aZ8bjsSWCqS5hdXdwahrvNGH4UCMVqCHWbeISdEdg+VISlZRoQlJ/C089v1UsJkM6iiWq9vSIZUdYwQpCGJcHt63eRzUAvhcdvpqC9qvW+HE3UNtUSXPiZRrKuaFwZY27YL4IJ5I/MmBhOQTYpRcmZkZekRx8P45+zDbWeWr2Iva5j6abYS0mJJTae2MErplBHbPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777382574; c=relaxed/relaxed;
	bh=eew3AfWV+nZ0YhkogIjTf3ZyKiO+xSxJ40Lv4P3DaCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YxI4UBkXCVB/W+3gl4o/svbmYaEz4y+uhXCphTQ+vAdb1F3yauLTkGMDuHlzPehcnW5ntyKdM84DCDvkY7yDCrvAtkofDbSIb2X6FA7T/3HYHZoTo/bvlEWgSUeyoX+Y/DCqt0ccGRz9D/fdkScVnis16VjpgoLaRi+fUyQZfYREgJX3+g6dqKuJkFv4VQO4vdvjNLABswYFOpNYfOMGP575OoSE7Q7sJVdr252z7kP35AM5scJiA7QM4HmCbgMoFUGhSOWOd7aDwBSAiRnDKHtXZuhH5qSdJ6op4flF9caSWqE2f+E4ZSdEnOQzivtziVzqzuQFnRCw31wEqjwo3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isowwp8H; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B1imoEwW; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isowwp8H;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B1imoEwW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4h236lk1z2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 23:22:50 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA3uSr3274994
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 13:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eew3AfWV+nZ0YhkogIjTf3ZyKiO+xSxJ40Lv4P3DaCo=; b=isowwp8HsZtNLSFh
	r7r4yn2LPiURmnNtwPKDubRpHsVdqsH0IiBZ6kRd3qf1TYR+KTnaPMNxmzW0M8L7
	bWq9rRw8a+GeimCy8hL4fK92G/P1BIiv/Oq1OZXHsdtCwh/hXZNEn9qModCdY9Kv
	6SR4lkAebtNi4OeTqC4lon+hzuPnmi1QwHx0VusdrVhWwtZhdYRcw4T4kAUO/+59
	2e7cXN5iN0HY0Je/LWiMyMJbYifDtW1TF2oRNvlJyYfrtyCNfIGfcOWHlPh038p1
	Amy0s24Pc1cd/fhWE6W6oBMaJmQ2cWw0izWt2fHdJZ8bMfuw4WCYj7ypNuMFCttv
	WNsHUg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjgpuf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 13:22:47 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56d849e9277so20654782e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777382567; x=1777987367; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eew3AfWV+nZ0YhkogIjTf3ZyKiO+xSxJ40Lv4P3DaCo=;
        b=B1imoEwWwC2BgPnvvlVpm/naLp5vQhlo2CbJyVkG1p/hnff5AYQXpys896ZfVe5SDb
         /RqDXkwaIera+ZPQUT0608ZdyRTjXwAtPZV5NyoFOGikVqAo+wF/CVx8dia5mFkHqW17
         jKvC54Udw1yvvMmN9IgJ+7olQE4K1ND9NWKd0w9m7k3IpTs+EirQ3sRYWE8C6YEwgy+T
         ZA3WiPDxlEuCt3rt6C8u+4lKl2+G3i+BCf35cYSJFUTMZOiH5GIrt5rQN5LfSqJh058y
         lhZ+zAX4z9VwILvYGL0T6AUbV4tUUn0+HXRs+0l/1HK0LUt8hYV8cC8to2d6xwu4jKCX
         cFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382567; x=1777987367;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eew3AfWV+nZ0YhkogIjTf3ZyKiO+xSxJ40Lv4P3DaCo=;
        b=GOP/g5tMOYStcK+01kdt8K4R8NVHplNUXqu35DlaVCMz7CuJQNDvOGCmQD9fOWP8CC
         HSa1egEqVhWsFaMPXGcFKXImrqA+OCzVxVc9lVZxqNIJAjWPzwmW7K9CsQNY8+2d6WEj
         m82iln2nGzeMri9NlopTbGpBb/Cy5cAb4TW1pVZLehkJDbPp103ukHaXWQwemu9BPPwu
         5/I76mLHrv8rlRgvlsUcreZe5KDaBu1/zMOWv+P52Ws4snay9D5tKE1Up7QhI4A2YLWR
         3ONCldGSKxlVLNt/yR7WCdq2Au2lINPEwHribkkG8T/AepskX+yJwrmWHiMA7rQnD3qu
         evXg==
X-Forwarded-Encrypted: i=1; AFNElJ8+uEX+2xWCRHt9TT1UcyDNtQwI8VQLtBislR5sAO2aQxy3Gz0i6hDsa+Yu61yRigeFuD4UxKeCOyZOR2U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWFQkmawNNQIQ2qENF39zpSCdAnmIvIQyw8+ckTDhp8TWjnZEF
	OfsUUSu4J44trcvdQJ59i/EDOgBC5TGM+KaGDH1JiP2n1ORcrAW4EKEnOUhoB/Tbj/GRoGKOZfR
	DmNv6p9raxQ6p6YxFdYhLu3ffjbVF2AIFySOHmryIv76HOYVjoLAiltl1B6IBW3G85JIi
X-Gm-Gg: AeBDiesGz2CTbweoTMOtZ0CEUiqACcUQXLAi+BlQWSuNjgmZdqz6+7s5qaEQ8sRyr/Z
	iQ4iSu4/F2NDYg1jHet/z22Ft78gdlxpQr1tR238qg/VqJ87cexyap7jb3u2V1+fdd7HRwgkdfP
	QtiTVxM69JSCX8vVZrqOMTNriP+OOmvP03rDazc0cwHYndnZYfWyfV3RFxlGnYyVMVLgAgeBS9N
	kJ3TA3WLCOSj7RCg8XH1jbiJBYqZK9Oh9vLeRGs8Mn9p3igDumyrSUglgYxi1kh+95y+bm4UKMx
	lp1aDzdXE7ZxdUOo4RYZjtFaGoR6XjMbVnw8nYMCoGWBoE9Tl77aEwO4AdTdis4eEDd8MLPXLS2
	VhlWrTSWh07cmJ4AwTPqnLBB6y5/AeUi+rKMqCuRWPwOdc0qsQuNRKS/mvIU=
X-Received: by 2002:a05:6122:311c:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-573a55155b5mr1411370e0c.1.1777382566832;
        Tue, 28 Apr 2026 06:22:46 -0700 (PDT)
X-Received: by 2002:a05:6122:311c:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-573a55155b5mr1411330e0c.1.1777382566322;
        Tue, 28 Apr 2026 06:22:46 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77afabcdsm83499125e9.8.2026.04.28.06.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:22:45 -0700 (PDT)
Message-ID: <90c122bc-3067-4e3d-8083-dd94844c31f2@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 15:22:43 +0200
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
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyNSBTYWx0ZWRfX1wQoWVtalW0v
 VOguLgIRrn2pFbsXSMGX/TUX61pw9iZKUS2nfLrajT/UmwbGAJIflfEEz5700l7QKfMNnHZ8IJt
 qb8MqmEP8KY84BXrSALrFhoRfnGxB4bSPQbH6vB7athUKDp10LErRIet4FUD5a6Bh+xSwRg7Vlc
 RoPsWXqkmhMsxohOAXtEM/aw3631aCf7GTjc2A8EauPeY6ZZ/cLG+MzkUhbI6+lGuVTgnd6tNBr
 BskexbDuR/1u/p070dZzBDPjL2qwm2GCDdHCY80pv4I9BjB+QKYb1L1YjHeaAhMcO+P57adX32D
 NqQ8PvF7/Xmf87mehV+n9Xuqscne4rZA8FVGlpzIxwn4wzOx7BrSYr2AgNzqX8m2toNHf3E/nRi
 hn8PNe+m22P4v2AoC/y35a3McwQktgo+5jq4ILQpPtLwukUbNJctTyTS3vAcciCuExp/rSg7ISy
 MJFrLZOJz4sNon5QGxg==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f0b4a7 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ws6guhHAfqZ2DLpO_VEA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: qRnm16EEx3PfDyaNitee68kfdEH-BlfD
X-Proofpoint-ORIG-GUID: qRnm16EEx3PfDyaNitee68kfdEH-BlfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280125

On 17/03/2026 14:08, Krzysztof Kozlowski wrote:
> Return value of ps3_start_probe_thread() is not used, so code can be
> simplified to fix W=1 clang warnings:
> 
>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> 
> Resend after ~2.5 months
> 
>  arch/powerpc/platforms/ps3/device-init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Ping. This also got a review.

I do not plan to resend second time... And I also understand if this is
somehow legacy and fixing warnings is not desired, but then it would be
great if you just responded "don't send such patches" and I would not
waste my time.

Best regards,
Krzysztof

