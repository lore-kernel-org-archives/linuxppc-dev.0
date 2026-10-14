Return-Path: <linuxppc-dev+bounces-29476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F50ECC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 11:24:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4TNy3mCGz2y8p;
	Wed, 14 Oct 2026 22:24:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791977042;
	cv=none; b=NFBvGkz7UhayA4xPz//M/hB9msCUsqs5qODVyZbl0MEy862VFiDa2UCck6rilKIV+dNumifW+ibcCOuSIMPGC5vnDSDJhRXq0kLvkB26pFxVDD3tHqE0Lhem+SiV3zn6zLoruwQnGBL15OyuGYZ1fmy4qP7LbNKu0V4Zk+7q/R7v3kVq9wHyz2LBeB/0GwO9nAAQO2VkZKaGqLTGk5aVgKlxoKcgXNEcpYlC138XkGDgMuZyEiriUbVtE/OnmYns8wF60/XITJiiPnBomBkhyGghws2KtBbAhGvnx62ScLdEYjftlM5WNiFKFo/Y0or/p/W8kFELbPfNCndA4KEisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791977042; c=relaxed/relaxed;
	bh=RPTBnYqf+Q9UVZ9B536ghf308gFzDaQ3D8a7r/DdR5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSiWTLsmMkZZXKhemlsN4NkANic98eSPsxweRAPZJNlijxjJdlYKzWsdMtDgZvBy3lh3J882hUjclrgI+L7rAiGaN7Xf12VSQzc6fVThxdi913WxMLTB/3xMbwayx1uoFpH/R7ylPbKvhU10Rc6vkR2qxnqNct4vUHOa92Y84mn7UBfoizg04Ean1qv3CF3wu/Tshf5vDNSUpxS/3SYYbILsRiT8yxgozKSptScX7z8AbocH7tHfolvTmHVGFl6jJv5kmV3aS5WeSHlXoxkwwXTDxccGjqpedjdDKmPA1exkVEHxT8xbl2YGOYMRrWrhqZk2nBz1sSLcl6wKS2LgZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RKO6cPe2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RKO6cPe2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4TNw23gTz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 22:23:59 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso523890f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977036; x=1792581836; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPTBnYqf+Q9UVZ9B536ghf308gFzDaQ3D8a7r/DdR5Y=;
        b=RKO6cPe2bprF11kA2MqXGfU/8RBTwsFkxPZPMXj03os8wdgipq1bQOaDfVJM2hSQHS
         drkEuNbe/al+cR4wOCEAPLAgxTx6vy8zmprYNNdWl4IiUBY9hktp8EXwm1yId+qh/UM7
         SNFxUZ5/+irsi84OUyStE5iNp4PJIU5a2zChzFohsSUWk/5bELCf2lWQZXBeks9U0nD7
         AY7K5z6HTsshWYVI4j63Kpb0HtE6/jBwmRMP7DnpaFxZZabBOUlYJG7nBOAYR1wRRgMg
         z16BRSCc1Nw2pThQONuocXwWOQ5soVGmTU3IgZmutkdkAY6GIiezlt4WEvXHjTiJNY4g
         pbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977036; x=1792581836;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RPTBnYqf+Q9UVZ9B536ghf308gFzDaQ3D8a7r/DdR5Y=;
        b=ht9VREtA52M08eBE1JSD5gcP/ik4q7UjHwTdyxYAbar/f3/6lCiGvMGaCxDMavc7dC
         3H0g4wVorAO+8BzU+cdN8nS5ZSM7kliaSGKwESplvu9EJI47/3RI9Uy0+Jnwakudbdtz
         ipZOGdAQwPPLcZgiCtZBXYNsbZGCxHpULamCiPo2siuiRs9DsAR334UFgPaf7+iy2GOj
         mNzsH1AMMM24a86TlWyls9zpjG18Fp5mIfkVrX/0H1STdy9Nzskv2fwNynHMgUFo/k25
         IXAB1obkBE1wXPSLvCRk+3tulJy5HQTIFEFtftZZ7ZbZah1P98hm8x5H/vzqW+pSR7kL
         X5zg==
X-Forwarded-Encrypted: i=1; AKwUvBwuz+wWmMfNvjIB//QbkSRm3CpKo2a/eBavuMTpVhtEYeTwMiE0AoZBly4NcLoAhPqcq6evnrwxt0r1Vo4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKsPdsmKHQDjlb/DilqVgWWoENPJDpq4w7xrTFVQFp4S/4k2exR
	K9uOwjHnhK72En5f/lIsbFkABksJ3MSu3Au+u1d7aRI4WDpuGDDWEBSX
X-Gm-Gg: AYBFou1DaNRJCiY7axtzuhyoPCkYW62dYq/jU+dIBJHx7YGiWaRvhZdtS05mdpx3WQ/
	UhN946SsSv4T02sKwLZFRmWLgygaUKaeWXCOVod98xNREekkGYLIJq+VAc7SagW6reRkRHp45w+
	nOOxZn7tIHNz0f50TXqbg54ZvbNflJ2EQ5tF8XJSc6z8oViwXSUNDLxi3GmPoU4UvyA8jeVGkaD
	W9mzGjys0jwEOPkFZGJssTt/lQ2k2skkLm+SF2IQGAgcvsLc+NufYd6PThkp7yl0XXAb3kuLv+O
	KDPARW1DR3/hRZlVWPrFGpTQyjNn47ozN2XvM7X5bWjteZuikbCgojxa5P2FwRjp/OTUTX2tAPc
	eFqbaAGpmNE0oUQ8fKch8hkeC942zuKLXTxZH6l4OnZBbgXzZOeNJ1Q6azrq3jhOqNU1iouj3Rt
	3beLWOIp76I+6FP9yRI5l4ZQaPqcm1B/UYBqHxFXbtbTFucE8ZX4ueSUlEhucBjNo5uDUx6bH4b
	Vu7XNXTWjuRquk15b+VIy/Y1pmRzXOEIyq8mqW73piERdbNTjiUpAi/AeBhVwCAiA==
X-Received: by 2002:a05:600c:524a:b0:4a0:251f:a726 with SMTP id 5b1f17b1804b1-4a18e4a54f2mr322936085e9.24.1791977035979;
        Wed, 14 Oct 2026 04:23:55 -0700 (PDT)
Received: from [192.168.1.28] (29.pool92-59-2.dynamic.orange.es. [92.59.2.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf3e044sm424801595e9.14.2026.10.14.04.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 04:23:55 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <7eafa839-ef4e-4856-be6d-d8e0a9ab3030@gmail.com>
Date: Wed, 14 Oct 2026 12:23:54 +0100
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
Subject: Re: [PATCH] powerpc/Kconfig: limit the PPC_85xx DATA_SHIFT range to
 STRICT_KERNEL_RWX
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261011113108.539470-1-julianbraha@gmail.com>
 <af5559f0-89f8-42d7-a43b-068bbd183161@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <af5559f0-89f8-42d7-a43b-068bbd183161@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/26 11:28, Christophe Leroy (CS GROUP) wrote:
> Le 11/10/2026 à 13:31, Julian Braha a écrit :
>> On PPC_85xx, enabling DEBUG_PAGEALLOC without STRICT_KERNEL_RWX activates
>> the DATA_SHIFT range of 20..24, but since the PAGE_SHIFT default is
>> outside the range (12), kconfig adjusts it to 20, causing 1mb alignment
>> instead of 4kb. However, the larger alignment is only needed for the
>> separate kernel permissions provided by STRICT_KERNEL_RWX.
>>
>> Since PPC_85xx uses page poisoning for DEBUG_PAGEALLOC and does not
>> support KFENCE, let's restrict this range to STRICT_KERNEL_RWX.
>>
>> This out-of-range default was detected by kconfirm, a static analysis
>> tool
>> for Kconfig.
> 
> Looks like with this change I'm now able to set DATA_SHIFT to any value
> when STRICT_KERNEL_RWX is not set and DEBUG_PAGEALLOC is set.
> 
> The range used to protect against that. 

Sorry, yeah kconfig can be tricky...

> +    range 20 24 if STRICT_KERNEL_RWX && PPC_85xx
I think if we keep this ^ and then add another range:

    range PAGE_SHIFT 24 if !STRICT_KERNEL_RWX && PPC_85xx

this would cover your STRICT_KERNEL_RWX=n and DEBUG_PAGEALLOC=y
configuration while resolving the 12 -> 20

- Julian Braha

