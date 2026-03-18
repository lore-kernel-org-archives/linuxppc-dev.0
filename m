Return-Path: <linuxppc-dev+bounces-18352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CCA103E160
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 11:54:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbS1C3XQ1z2ygd;
	Wed, 18 Mar 2026 22:54:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773834879;
	cv=none; b=hY5wUSvQ31Gxewv4AfVFfPEqMRDQm1z8wCXDZSPA3P6mSQS3lWP1+0y0YtDiYw3qGTjH0z+AAru2eEetAD7/mZapRfHkP3Yuwllim8OpeJaOTFhsxCrUyythj89h0qHlLa+nI9wDnmmFNFQedqBiLWk2WJ29NPBm1tm7dy08FhrPTDG03quCQ7VAmVAbpEG6sjDAEVfHoFcjn8vNNxaCqKDrBCWu4s6DIiJIV7cLH0URZcVX7Ra5E5vMg2Nj8ZcZzTalVsntYLzujQxtUSTlt/Ugv2WQDc/xwpPkR/derEqN1v5AmUkXz9TtLIyFH9M0Dh/J5Q+oHY+7PcQZAw90dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773834879; c=relaxed/relaxed;
	bh=XVxumLqiZvi+keRJyd1O7rpbGVljgUvf3oYZKKrcgTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbfL14zAx2eGZRHeZeaQcJiHedZz4DjfsEtDzVut4QPpl3iX6yrNAkgmVEVp6/KMNmUZsSaq4LIfJ/8ELL1VzPmzs+sk7gqg1BaMey0K1ECkK1krLYlPxK76eH9oUZ2bGhSEcpcXzIdwo2fve+1LMIfxaU2pOokd/80ofJVgytfzt8VQudX8XsL1aczefeB7BGCsArO2Ok6uPNayG9eR08mygTGjG3dMQ7qbbJ0rGj2iJ1YYqmpl5v3nyhiEqXilPpgqW3P1pH3QXu6KOWYHE8BSF+/zXgbEdqOGJwXbv25Mki2QbOe3guMfhQwuHgKA+UpQrpnCwJETROPJ/EuoeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JJXjnhAW; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wz2MJUOv; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JJXjnhAW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wz2MJUOv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbS1B2ZgKz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 22:54:37 +1100 (AEDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I9N3lU3358710
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 11:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XVxumLqiZvi+keRJyd1O7rpbGVljgUvf3oYZKKrcgTQ=; b=JJXjnhAWR7tbnNIY
	5KmhRtR4bZe9/eEZJbQ28cf1f16C4MRud4c9a8GazF+ViOgmCvJjjFwGbyzQEIEy
	jCe86HPZ32IuqcalQwd7wrEaPswcuSWRWLwEdfrl2ae1dUT0KGPxDFVht1NuzF7W
	7NW6Ujdj4QQHDdQ6dxZcJj60/xo8FH3YYq5vAKV8FoEaOO7VKlJM+MMgFSMjkZ2u
	IIoeikpNcRR8J/sdryioug4OmJrPbFlnPVQXDDszvd3K2eoN6fsOs8TxGjPvBGJX
	4pFCLGuVc4zE0l7VbCm9drKuCN8f3XsR9qJQt5uyc8bHtbmz1HF7p2B4GT7OPrhN
	6F3IXw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb0h6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 11:54:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89a0684d05dso49239016d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773834873; x=1774439673; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XVxumLqiZvi+keRJyd1O7rpbGVljgUvf3oYZKKrcgTQ=;
        b=Wz2MJUOvQIwZQv7VK31rYzayBthc/79Pw7IrPXfrgHXLeM+pUc8XDQgzv9KaHioEOY
         uICH17nfheITM8F9uI1wVE3ejsvh26iQvElVL7IbbKOKRvH4Q6AtlPwnkGR9lK/64wNA
         fu5F6+VXbkTcCOm9Q0gvlvCKBpLXqniXSPo+QbaiFwjRKtZryjqMtNwBtLozpFgBaST8
         Q4zNAgPNidv5MYPfUmZdZYWkBmmEsJDRaL2wK+cuuKY46Ocz/qir3w0J9NChUnGfMew0
         GG6OcrOPiIOj3/QR4RV2ZuS3bV2Xa7379ha3LsaGrsP4c7woEKfOtY28V8j+mpISe+mi
         VDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773834873; x=1774439673;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVxumLqiZvi+keRJyd1O7rpbGVljgUvf3oYZKKrcgTQ=;
        b=QXrR+p7mNs6TqJYF+9HO/rYHoS2P6DbohiKhhTHVmiTR6cLPvYIPRQz4WqsiNCX7/g
         UG4e6C9A/QSYbvepLQdStgDzR6tCHlSoRDVilsJoI+TfALKgjhpvSAzzCcKH0O6ixekZ
         ARI7HrYXlYhtXdpBOUoEwT7WrD1rzx318GFGFco24p4SHG4KJqxPM5WGXpBshr7i68B9
         48qyDmjYSfdaQxts5FpbxEnMl3zkdDGpv9qXfndjRwDTZSKrkfwIMW9ixMSkwtNEWfH6
         qQqAvryPE9ytg04zcgNjvlEg0vhErjSKXmyQPEP8z/6iSXMpwXngCPB8EjDycqapSWxh
         eNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyceObdaTwMeZE7y4hvueEESE/OhBLk0vLAmyeM61NxF24LCosJ6G/whqBPsAvabX6uT9lHuPM512Jlws=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxepmeyp3+5B53jAqcliyZN3BxVQVy1jm3M5gyNAUi/rLb4rGW4
	vmVqGV4k2lu0GPNMtfaf07xfGoliVG9r8N1KrMtMqx07MlISiDKNweAiHx5G/IpdEyOeplhPt9o
	81fzeXsXqoc/rhdO0U3KpopkCBWR2CIw923X/+4CZX4WutAz0LQLlsUoRPieVzuFw8o00
X-Gm-Gg: ATEYQzzImFaXzJqpULG1g5QJdSjDQ9m7jssKjV9aW1DPsv4o0/hVAxlg5mZ+QEJfOnD
	aDEJhrmW7WcUNbRoQhyeYmHqvsDejmviB04cdyzgtgO1iQtN0Fj22OoUFm9lDA5yHaTevzNEicB
	WAE0XSGOAvchW4KQxYTE7tIxIMFGONtTvaMafX1PbIt4/8tkXWI0cRlG3Ummwnn4SeSjHPEHqtZ
	makQGqA5TMpTJYkT0KcJCDMRVyTGujUMemKaN2t1bI70nuEzPRlizz5OM9T14XrIw2BqRoQEQqh
	vjvDB0Yy8/P6/VgGrAdXlg5q9Neh3rtGYSDcgJcr6hoVm9veEs+qmKpFm4KCwyp2OE2KGNxo2R6
	8RI+qclVQL1TOmufVV7WAlYnahDOuR1UcETgDRxZdyzyVdqsy
X-Received: by 2002:a05:622a:24b:b0:501:4b9d:ad19 with SMTP id d75a77b69052e-509980cc3b8mr84816071cf.22.1773834873504;
        Wed, 18 Mar 2026 04:54:33 -0700 (PDT)
X-Received: by 2002:a05:622a:24b:b0:501:4b9d:ad19 with SMTP id d75a77b69052e-509980cc3b8mr84815431cf.22.1773834872931;
        Wed, 18 Mar 2026 04:54:32 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51899617sm7665953f8f.31.2026.03.18.04.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 04:54:32 -0700 (PDT)
Message-ID: <dfb53d65-ee34-47bf-b305-5694c7224ec7@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 12:54:30 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <abqRvDiAI85w2bCe@gate>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wZBsRG5q02z5UcFMjapYVjvr8dlMx0Xn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEwMCBTYWx0ZWRfX8F5DvpBs5TN1
 TJyjE0WotRbvTGxsstF1WCqIzZ04DnabsbrHhoinPF1eL/UwS1ghPET2BzvXMiYTVYbVKUPK3lU
 /W1RNo8089inXZBlKx8wWaZJtCXXu6lbFk55drSVv7sSC8Z0caWNbB2JvIegnff0eWPYWgyd8Oi
 +KA7rXYjA1Jn/L1QlSE4S8IECIfmDJh7fjBlYYBU4fECk5JrGQE9LAaj3ft+8BTGOkN3MMkujpZ
 UICdZuW8AjXa4JNmf/G82kDMd62inJHwSSxjIr3DaqLgumDEJSIFwHiA+HzP3KVIB6fQIC+fqDu
 //t3K3ifqvcEfjjMdCpTMliPbTe1rY4kPFWNYt0aWoXH1rlvf9hQvU5uz0sWjx4+rpv/+mfM83+
 ea6lLOJQKhB+fbF4ro9oWNa4uRBXTMkKMLuNOkxuVkZGEKVup71dF3r/tvdNz0oaZQWNDc3Xw0B
 6GMU5Du+XVizQ6QHn0g==
X-Proofpoint-GUID: wZBsRG5q02z5UcFMjapYVjvr8dlMx0Xn
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69ba927a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Pwrwc8hzLyJITHjMlkMA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180100

On 18/03/2026 12:51, Segher Boessenkool wrote:
> On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
>> Return value of ps3_start_probe_thread() is not used, so code can be
>> simplified to fix W=1 clang warnings:
>>
>>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
> 
> And this is exactly why -Werror is harmful.  A boring harmless warning
> turned into a build break :-(

-Werror does not matter here. We do not want warnings either, assuming
of course they are correct.

So if this warning is correct, then patch should be applied and WERROR
is irrelevant.

Best regards,
Krzysztof

