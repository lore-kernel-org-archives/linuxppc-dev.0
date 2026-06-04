Return-Path: <linuxppc-dev+bounces-22024-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFF0CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 10:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWKy44CMhz2yRn;
	Thu, 04 Jun 2026 20:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780567676;
	cv=none; b=hGxAEp3A/cqzMqkE2e+maUqo792AoTJmvdQ5hfz099ID6XozG7S/U+/wHk1BHFtQ/Og58QttH5BLiSGuCTlM3jT3NigpnibUFMxwOMc3vD8aHHJ8yNQXXFMM1SsmLSrvTpkrxGdCeEhu7ILASWRFnEWyXtV/s47IA5PSehAE0weHItRTqaZvFE4VRIyDou5iw1fDXBHOlYlKfxaNYEy6S910NChKB7NhdktMiwhAef15gMj3E4QPbi0QCy2FMhkkMneQkNCl9x/04hnc3A9R53ueZ9YBh9en2QgDszMjydYFFlc2VwXz1+14DX2aOwnmLFdV9mzK/QDSgtMCeffRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780567676; c=relaxed/relaxed;
	bh=fY8792ZE1BP7gPWmzXejL4aYfAPt6W6e5+24pISv2II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRcZ8ga492evib1pU9LRpNdUa7iaxg8RbxcPekyb3ZGA9XfzggIpxfWeH80hgDeDSJ1/NDXYAyajFjXFekrT5/TTOB2x6aW6PNU/Y2Nv5o8/vXeN3Qh9l9qW32LgJUixXZHlayRZKXy0GSwDR5aSN/EXdG7xqcALhIRpIXAeZ22XUeY7Gh7REGts70lxSKiuRj3Ibe/DmMCKOC8/x0Oj8x6qGh7oZBtjaYrZtK6bCCZckN/UIC7d7RtvTQKZD24j1PNmdNRlaYOLZOnRhNbTjMsWbGLj4NoFmHxW/9Ti7DKPcTc7GHwKuRVRtm6jpkwSR6YQmp+h43doFNaZ2uYUSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hy56kqBc; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hy56kqBc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWKy35FrPz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 20:07:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2193660220;
	Thu,  4 Jun 2026 10:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41FB1F00898;
	Thu,  4 Jun 2026 10:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780567672;
	bh=fY8792ZE1BP7gPWmzXejL4aYfAPt6W6e5+24pISv2II=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hy56kqBck/YQl3WKGdZ2T8ttwcobp3++Pdf19f16BWU8t4NEGP1NsR2agZH1/t3D5
	 vc5WsTHmAHhBKkvWc/URg61QvH5+2Vp7qDgEpFVdkRec+iXiO4bdgE9fiuHZ65r8A5
	 DOo3iJ0QfVtsSI4w3WHL1KirvV2BFVKEbxBnqlmyJIYGadhcRO44QHK03Dq3QZ6T1U
	 wv95LiQThk022jkgzJCTCD9zQnbhK05Ai4dCgf9GmNLAF1RiZlCf+VqIVqS6z9AuGN
	 p/xR4Poy0lH+gxHKgJrNHMdPMSDhiA3Zxm6wYdp8rf2iUrvRkH37CCE2asyVf+an73
	 XsElxA4rqCosw==
Message-ID: <6f8df5e0-f630-40da-b94e-77202028d687@kernel.org>
Date: Thu, 4 Jun 2026 12:07:48 +0200
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
Subject: Re: [PATCH RFT] powerpc/8xx: implement get_direction() in cpm1
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
 <8a5a1bce-b841-4eff-ab3c-4f09a7ba3b60@kernel.org>
 <CAMRc=Mf-AeKDn6hi_jM99BLPaDXd04pgkUyuncuUBb2Kn-1mMw@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAMRc=Mf-AeKDn6hi_jM99BLPaDXd04pgkUyuncuUBb2Kn-1mMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/06/2026 à 11:53, Bartosz Golaszewski a écrit :
> On Thu, 4 Jun 2026 10:24:27 +0200, "Christophe Leroy (CS GROUP)"
> <chleroy@kernel.org> said:
>>
>>
>> Le 03/06/2026 à 10:26, Bartosz Golaszewski a écrit :
>>> The lack of get_direction() callbacks in this driver causes GPIOLIB to
>>> emit a warning. Implement them for 16- and 32-bit variants.
>>>
>>> Reported-by: Christophe Leroy <chleroy@kernel.org>
>>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F63487206f6e5a93eaf9f41784317fe99d394312f.1780399750.git.chleroy%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C94897fc3d78242b6193308dec21f300e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639161636389791222%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=an4ji%2Bk24tiNfOASUmnvOyp6kLJzRlH8qhihSkGp%2BVc%3D&reserved=0
> 
> What happened here??

Ask Bill Gates.

My company uses Microsoft 365 outlook, it mangles all links included in 
emails for security reasons they say, to minimise phishing.

> 
>>> Fixes: ec2cceadfae7 ("gpiolib: normalize the return value of gc->get() on behalf of buggy drivers")
>>
>> Isn't it e623c4303ed1 ("gpiolib: sanitize the return value of
>> gpio_chip::get_direction()") ?
>>
> 
> Sure, can be:
> 
> Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of
> gpio_chip::get_direction()")
> 
> Bart


