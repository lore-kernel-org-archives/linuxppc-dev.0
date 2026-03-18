Return-Path: <linuxppc-dev+bounces-18356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E895D103E16C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 12:21:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbSc9478wz2ygd;
	Wed, 18 Mar 2026 23:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773836489;
	cv=none; b=DA6GZSCCBx9MfXPeKCFsQj/wynNpFqByHaf1PUcOCiZwc18BOMhphXo0ZjFYyYhFDgNb0r3xcWLd4Rc+N7Uqee2MSK8iUN3BMxtERE/+4kywuf5g9an+O0n/XkeId8aK10Njv2JQBBW2MKDimp289SL0jB0FSWZeAnzqIV7IFaAWfvrvDtJQh7D+KmBqiiDfe0DSgNd27T0JtDaJbQ0TDMNrWSvpCeUElnexYKqZBHuYHbXSPZ0lbKvQoCj/K3TocVuhgH8NUqCpmCVRaXzH9RnWRQ6P4yli0qbYvNgY6pRujKoposAbQl0b9boAL1e97FPUNg2spnnV1QawrP16qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773836489; c=relaxed/relaxed;
	bh=q7fWdiHMF8QyWtQ6u7yiKYVkwhIIwTRlYi8d1FPWS64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXGytsl3obe8yQMQdeKt6s8k+wVizWBGnvS80TJajqeHAayTIup9Mk+Xn2d+6RgVo4o1XMJ4mjyBQYXjEZDkW6Wpv5CquttNeUG9nKKyk5Mo/EU+IUjNSE5pLDiKOmXMgS/oxeNuQXwTnBgdRkczfafcSeERSBQIIxG6Yz6O2cJlT8KbfyBXpqLW2uK7X6Hw3BuP8v0TsJoVldgKo0tj3Wa/cVwXynHWRxAmhVsQkdb8/pxD+TwdjiAyuM4TTT7eNlxdGJro3Tq6wU8dxz1Da1MA2KIc5ibH0Tk5o0X/+fKZv+R3rDgEHyVb5MW6xUmEhgs65DLoeIvmT9XBf2G/2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oNJqUE7q; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oNJqUE7q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbSc843Wkz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 23:21:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2523141758;
	Wed, 18 Mar 2026 12:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB77C19421;
	Wed, 18 Mar 2026 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836483;
	bh=VETUb0Ok7/wSEHFBIMBMVSrMOraqztpcjMZcYixugyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oNJqUE7qC0JMEzUfSQhebxrMLRrF2cE4BV510qU7Bnu6OrVlvo6N2kLXxm4yacwVe
	 QkZcq6aAydkvefXCM6OFDT3RaDFeuRHErYMtNTRAO+LurstvZiOa6E4zKZB+hOgecN
	 Y8rIokqTAId1h63piwFI7OnTLFigYcZnS6qplYtfZwiEptKeaQgodUS67+LJtJUTLj
	 QZ2CFn8EubdMgNXw1vjK3AeaC30OcmZ+ChuuMsKpY5zjip0BmrexeNrpWluZ3s2XRG
	 aRSAAwPK8OBPIi1imVJyYq1UHPpY0s5hOgsE4EGrLdODoRjzQ0rxcfypkn3RUl8YSA
	 PiL4W7C6bdYyA==
Message-ID: <9434f836-aa96-44e7-8f34-243d6c94f6dc@kernel.org>
Date: Wed, 18 Mar 2026 13:21:17 +0100
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
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Geoff Levand <geoff@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
 <abqRvDiAI85w2bCe@gate>
 <dfb53d65-ee34-47bf-b305-5694c7224ec7@oss.qualcomm.com>
 <abqTSG-wg-9ahRTe@gate>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <abqTSG-wg-9ahRTe@gate>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/03/2026 à 12:58, Segher Boessenkool a écrit :
> On Wed, Mar 18, 2026 at 12:54:30PM +0100, Krzysztof Kozlowski wrote:
>> On 18/03/2026 12:51, Segher Boessenkool wrote:
>>> On Tue, Mar 17, 2026 at 02:08:24PM +0100, Krzysztof Kozlowski wrote:
>>>> Return value of ps3_start_probe_thread() is not used, so code can be
>>>> simplified to fix W=1 clang warnings:
>>>>
>>>>    arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
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

But if I understand correctly this is a build performed with W=1

Without W=1 there is no build breakage.

Someone who forces W=1 on its build can be expected to unselect 
CONFIG_PPC_WERROR if it is needed for him, no ?

Christophe

