Return-Path: <linuxppc-dev+bounces-20260-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E59FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 06:03:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g56DW4tjjz2ySf;
	Wed, 29 Apr 2026 16:03:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777442603;
	cv=none; b=n4zak7iIKMW8+hpk1prM/rH9+bgHy2vNO8RmT5+MmnBtW8Wf7pxI5d14Ve8yHa53hNz5yTUrtYDpO7EQ2xjbEfXUPbzRwIyTMkp33IA5H2xq846cNMHl+qFMt+HTEG9EW9XlJVvT5P++LcZTt5Sn6YU41KYC0PU/wm86L2nEwhVZv38rVtLVHmkM8Kx13OpJ/MH+w9iajc7/inKYOPCwpd6EsEtcaEakpZUF3lmoiunwiSF5jJi4kg786r52AMTj3kQLQu6EOZEt+/BiEHT263CYGA/zyhQzd8WNZsoQowwnOC7+/dj4TQPLioBUW5MIugaP7EyxY0kaEjWRxLft7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777442603; c=relaxed/relaxed;
	bh=/RRTW6GJMQFD74GRMm5qCHethywFoA6NvTHxdjnYDRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TWgomKtmNmi5PlDJKelcARNycV9kIFkx1kxY5vfKELkwqDVl+/EWZhbmUr/skSEXfiXXG6vpp06jJYVAkemppZKX62LnuUjZfOi3YjvXcGZp5ZbTobaQU6jsMJRbJTteBN3NlepXekbaPFIsEtKqQgSDgshtk1P+nG4PiRoSe3alJ0X9mtOqRFJaORNATHo+ZWvpQdMggIb677ZRAOfQmxJoXYIdEsp6W7/mh8tINetyweS1Cpjd4MrvtRKR9/icxoKvI3uD2qzx3JMOh5fxkUR3UYqMvDNlUyBN7Hp7RpaNKOCad4XTuJrRo08dKOk4todv8KgUBWArBtSb+UVnLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=OJ7/bHzd; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=lists.ozlabs.org) smtp.mailfrom=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=OJ7/bHzd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ellerman.id.au (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g56DV10Vjz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 16:03:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1777442600;
	bh=/RRTW6GJMQFD74GRMm5qCHethywFoA6NvTHxdjnYDRo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OJ7/bHzdqP/D/PBwqvTeqWZi/62SIyIkSFycBqGDuKddM02BTqzdlmY06gX8IFrzj
	 f7szli7NQY3+uJxDmDPwgXgmKCWCJ4VFW4Vxz7k7JPherp2pox/udntYGtCk9c8HWY
	 FkKjYE0+9CC64y+0L3n/Q33VkMcYL7LQhS1WXsGQapF/wsagr3uY2refEn9/E6LSrN
	 PdT8Ht5BDFFsbhZSp2hvhBlebRqLjoijmf4LHV3idy8swZR7I3nC6/T0XYhSqjbs/1
	 u5Nc+TgLJnbJz9d6iBelpLu79DlNQWnZD7cYUeDakUbEaRzrE/SI5QcMkEP5XpZvv+
	 WTDcbiZlsg9QQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4g56DQ1KV7z4wj5;
	Wed, 29 Apr 2026 16:03:18 +1000 (AEST)
Message-ID: <946b79c2-ae4c-40ed-997b-ac654e148d47@ellerman.id.au>
Date: Wed, 29 Apr 2026 16:03:17 +1000
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Geoff Levand <geoff@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
 <90c122bc-3067-4e3d-8083-dd94844c31f2@oss.qualcomm.com>
Content-Language: en-US
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <90c122bc-3067-4e3d-8083-dd94844c31f2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/4/2026 23:22, Krzysztof Kozlowski wrote:
> On 17/03/2026 14:08, Krzysztof Kozlowski wrote:
>> Return value of ps3_start_probe_thread() is not used, so code can be
>> simplified to fix W=1 clang warnings:
>>
>>    arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>
>> Resend after ~2.5 months
>>
>>   arch/powerpc/platforms/ps3/device-init.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Ping. This also got a review.
> 
> I do not plan to resend second time... And I also understand if this is
> somehow legacy and fixing warnings is not desired, but then it would be
> great if you just responded "don't send such patches" and I would not
> waste my time.

Thanks for the patch, sorry it hasn't been picked up.

I have been AWOL, and I suspect Maddy is not sure about taking PS3 
patches directly without hearing from Geoff.

Maddy this is fine to pick up for next.

cheers

