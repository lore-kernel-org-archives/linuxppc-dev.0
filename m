Return-Path: <linuxppc-dev+bounces-21259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689A0CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 22:05:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLQZj6bG6z2xMQ;
	Thu, 21 May 2026 08:05:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779314717;
	cv=none; b=fRkEWDn89reytxfVQS9j3pD9YkRSOmbV4w3DThzM9mr0VoC1iLPAza41FqtlWcVoqk+pCwaZ2ABuF3D2ESd77XQc4alf824LKGvtScgC4X8A763gclTzG2YsBFdiBPce165GvNMrZecKrygkjVyfPEMmfW0tY3qY9d7gC+8PFh3+/lac4n2cFEcRaWci9NNb/Ctrxgb+oHyH2qvdjovHK4K+/ul0N0m9m87hBMaHikcFU8rjckUIeDJXktJFSoz5cuwrIma2GrReC8ZypIOcvjCLfi+ULRj2BtgAyJpCNbo8mgZhZ/qc39cNK9frEmkewmMAZPmtmsMWeS7ugaRJag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779314717; c=relaxed/relaxed;
	bh=oq9Mw1eKArGqNiiPPS6OfCCiC3moAy62JaIiwg4FYGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVQWdnB/U4+juyai2YSDOBim+6FqQXA3oQhyxuaWaRdLMr2X0HJnIrTUOsdmzkoqBKNrhRjnOharzqqM0tqGbNk61YWXtJ9tVxP5yl+elU1XUGzCvxM/j+/3G1+VHUognAwXCFM6vkuSbSAqEAjBvDq4F5sCPD2/Mt7jFD8azd4Br8p92cXdzNXAZ2n6hKqs5VW36qTaNRuJ900w18k4OppXL9pc5VxQEnT5MdHPHuTy2NN4HfVdYugBmQoBxjGZ0Gz/pAHUPKNSfaI70QDJILlUlom2ZQwqNIi/UcDBD+YXu5Egd0H8lfmM/9lRrB7/Zia2AnuEZfQs5o5+vSonhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjZptnA2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjZptnA2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLQZh4bHNz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:05:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 39971407F6;
	Wed, 20 May 2026 22:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C55E1F000E9;
	Wed, 20 May 2026 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779314714;
	bh=oq9Mw1eKArGqNiiPPS6OfCCiC3moAy62JaIiwg4FYGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OjZptnA2p7MwDsZqUia/e0Ldxb0S2eKL9tftaz8UoeriRZQwV8nzWf9ZZHU31Bbrm
	 dDsE6mDoprCn0JRJNfP/RDiJfxuReIOKBtU8RbzZa7CC1l8Rqi7TwfISLPCxHe/YEY
	 wu8E93XzdOT6Qdi8vXnEW8QNo+wHKmFWpcEkvTHbx2MqTYS4k+hPq3pBsVEeJI6/gO
	 CrKed2ZivtRm2CNqxHAXm8HpuldELoc6BLy7pl7XieADC4PADe7ByAxR4GHZ0rLkqo
	 VoJP3o+1I8KmcIEe1pMrmQPn/We54ZFzaq6sCW0SjJTShFB0QTv5uZ6JYfslnrjNtA
	 OMOks5OTaTomQ==
Message-ID: <9344c408-af6a-4ca7-b481-1c26c9491b64@kernel.org>
Date: Thu, 21 May 2026 00:05:09 +0200
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
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
To: David Laight <david.laight.linux@gmail.com>
Cc: Mingcong Bai <jeffbai@aosc.io>, linux-kernel@vger.kernel.org,
 Xi Ruoyao <xry111@xry111.site>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20260517041423.71243-1-jeffbai@aosc.io>
 <20260517145421.2d1ac77c@pumpkin>
 <eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
 <20260520194301.06d96a5f@pumpkin>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260520194301.06d96a5f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 20:43, David Laight a écrit :
> On Wed, 20 May 2026 15:14:40 +0200
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
>> Le 17/05/2026 à 15:54, David Laight a écrit :
>>> On Sun, 17 May 2026 12:14:21 +0800
>>> Mingcong Bai <jeffbai@aosc.io> wrote:
>>>    
>>>> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
>>>> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
>>>> warnings:
>>>>
>>>>     ./include/math-emu/double.h:59:21: error: ‘__BIG_ENDIAN’ is not defined, evaluates to ‘0’ [-Werror=undef]
>>>>        59 | #if __BYTE_ORDER == __BIG_ENDIAN
>>>>           |
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202507301656.7FEX6J5W-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C3ed26b8c3d6449fdc29608deb69fac66%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639148994069314641%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=FfFnXxMPXXxoOMM8fYU4df5gMjk3B2dPgQsjwUagaNA%3D&reserved=0
>>>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>>>> ---
>>>>    arch/powerpc/include/asm/sfp-machine.h | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
>>>> index 8b957aabb826d..db8525605c026 100644
>>>> --- a/arch/powerpc/include/asm/sfp-machine.h
>>>> +++ b/arch/powerpc/include/asm/sfp-machine.h
>>>> @@ -319,10 +319,12 @@
>>>>    #define abort()								\
>>>>    	return 0
>>>>    
>>>> -#ifdef __BIG_ENDIAN
>>>> +#ifdef __BIG_ENDIAN__
>>>>    #define __BYTE_ORDER __BIG_ENDIAN
>>>> +#define __LITTLE_ENDIAN 0
>>>>    #else
>>>>    #define __BYTE_ORDER __LITTLE_ENDIAN
>>>> +#define __BIG_ENDIAN 0
>>>>    #endif
>>>
>>> I thought the expected/correct value for __BYTE_ORDER__ was either 1234 or 4321.
>>> (apart from pdp11's 2143).
>>
>> That's the case, in include/linux/kconfig.h we have:
>>
>> #ifdef CONFIG_CPU_BIG_ENDIAN
>> #define __BIG_ENDIAN 4321
>> #else
>> #define __LITTLE_ENDIAN 1234
>> #endif
>>
>> But as far as I understand the problem is that math-emu expects
>> __BIG_ENDIAN to be defined at all time as it has tests like:
>>
>> #if __BYTE_ORDER == __BIG_ENDIAN
> 
> The gcc docs have (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fcpp%2FCommon-Predefined-Macros.html&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C3ed26b8c3d6449fdc29608deb69fac66%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639148994069350793%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=D0BlZT73XnqHXHN2ukPFFUQw5lCCwaKfkmp6vMHz0Gk%3D&reserved=0):
>       
> __BYTE_ORDER__
> __ORDER_LITTLE_ENDIAN__
> __ORDER_BIG_ENDIAN__
> __ORDER_PDP_ENDIAN__
> 
>      __BYTE_ORDER__ is defined to one of the values __ORDER_LITTLE_ENDIAN__, __ORDER_BIG_ENDIAN__, or __ORDER_PDP_ENDIAN__ to reflect the layout of multi-byte and multi-word quantities in memory. If __BYTE_ORDER__ is equal to __ORDER_LITTLE_ENDIAN__ or __ORDER_BIG_ENDIAN__, then multi-byte and multi-word quantities are laid out identically: the byte (word) at the lowest address is the least significant or most significant byte (word) of the quantity, respectively. If __BYTE_ORDER__ is equal to __ORDER_PDP_ENDIAN__, then bytes in 16-bit words are laid out in a little-endian fashion, whereas the 16-bit subwords of a 32-bit quantity are laid out in big-endian fashion.
> 
>      You should use these macros for testing like this:
> 
>      /* Test for a little-endian machine */
>      #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> 
> The doc doesn't mention the value, but __ORDER_BIG_ENDIAN__ is 4321 (decimal).
> 
> So the math-emu code is neither following gcc's rules or the kernel ones.
> 
> Your change will break anything that currently does:
> #ifdef __BIG_ENDIAN
> 
> Any change would have to be limited to code that is implementing math-emu.

asm/sfp-machine.h is only included by math-emu it seems, so the change 
should be safe.

Apparently math-emu predates git history, not sure where it comes from.

Christophe

