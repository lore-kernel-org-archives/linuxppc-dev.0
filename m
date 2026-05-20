Return-Path: <linuxppc-dev+bounces-21240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FCACD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 13:14:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLBpc2GvGz2xPL;
	Wed, 20 May 2026 23:14:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779282888;
	cv=none; b=WTe6Dzmfd4IqudkUopsXTe5IuwahWVZRi7iZyDAMDsvGLK/WZwjWeme5x031bs1MVluQ4FUEj4weckTd8Be19ViXo19Ni/mptSSGMeGcfemMCs7K+oXRKywb1Ax73bqXnNIOirq51EosY7HY1dDSIYNyL4fyg7XHYjal20x2mFdxnigqbloIahokw07VLiFkDXr/8gnxr8bkkXdrZ0nqJj9F/V1ZD36d8tjiV5wYMHx/ZkXN75C1RBGwo/uUb2UBD991OH8REq0Z7sYuVd6DhCKgXWeEQ4PAgXmRHLrCOApcoodFWsN2bvaC2sIWuY0FXaR6+fGHW4czLGJFXc5bFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779282888; c=relaxed/relaxed;
	bh=l61V1ePK9sHn8zK/nyVF01xCrG/hivVTbasBGpfgkw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyIAwyypk6ybMB2ufWp6RS29j1VS/+iLH4HevUjcQLeCYMYa9CNvtX7IDEFWsJR5FNWctIIL8S2tdTpRRamG7cDKkLkiRBnRLdi46iQs0QesBhsPItzNKzx8bLdG0ae57yYIhfJ2T19gzzy+dNLfUeQFmMAeY64KF31qMYRaERrLVlWjltqcKVQCYP8E58wF3qhYBC49DPEiJiNOovFyEzRJIkaARw1C6IARjktJfXIv4YO/8cjVZgWXBD38/xpe6oZqOkczGN2AH99clC3uitdlTkHildc9BFSUI7N34dZ026pUuIBJdIkfw93yJVLHp3CYqMJQ1T1EIXEjTuZY9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtFKd/RU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtFKd/RU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLBpZ5NCWz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 23:14:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3828444330;
	Wed, 20 May 2026 13:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB741F000E9;
	Wed, 20 May 2026 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779282884;
	bh=l61V1ePK9sHn8zK/nyVF01xCrG/hivVTbasBGpfgkw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DtFKd/RUIPItLf4gpuOm3HWcKU/PTmroifXHUuLxoG70/aGDn/BMeQrB2QqNukF6F
	 bUGpfLKoIwAT5eh1c49OyEV4OjGApVaf2ulIqKD6+PO+8kN0r/CulxUhT2dbuUwIZt
	 Gb1SJL1KcoEnPUMas1hQw1z/gfAOCXoED1kZJMjquq72Y33ifvkkAsZAx1cDTD6IFU
	 vJs710X8uTMIpigJU/GVTwqd/shgYu7lUweFwhGSW0FaYpJimt8RUCvkLyVSn5lFMV
	 IklwB+OIea1Hh/z/2apPwKTF8pEJNXm7ATKqPl92VcLI3mwJKARrYYX8aQvniyJcFZ
	 kctjIHTa51NRg==
Message-ID: <eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
Date: Wed, 20 May 2026 15:14:40 +0200
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
To: David Laight <david.laight.linux@gmail.com>,
 Mingcong Bai <jeffbai@aosc.io>
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
 Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20260517041423.71243-1-jeffbai@aosc.io>
 <20260517145421.2d1ac77c@pumpkin>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260517145421.2d1ac77c@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/05/2026 à 15:54, David Laight a écrit :
> On Sun, 17 May 2026 12:14:21 +0800
> Mingcong Bai <jeffbai@aosc.io> wrote:
> 
>> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
>> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
>> warnings:
>>
>>    ./include/math-emu/double.h:59:21: error: ‘__BIG_ENDIAN’ is not defined, evaluates to ‘0’ [-Werror=undef]
>>       59 | #if __BYTE_ORDER == __BIG_ENDIAN
>>          |
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202507301656.7FEX6J5W-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C08977974fb1c495e9bd508deb41bd275%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639146228768693730%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4qGulR%2BL7i7inksEbEH9jNGZS8HG80uvm3I9IyYzZww%3D&reserved=0
>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>> ---
>>   arch/powerpc/include/asm/sfp-machine.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
>> index 8b957aabb826d..db8525605c026 100644
>> --- a/arch/powerpc/include/asm/sfp-machine.h
>> +++ b/arch/powerpc/include/asm/sfp-machine.h
>> @@ -319,10 +319,12 @@
>>   #define abort()								\
>>   	return 0
>>   
>> -#ifdef __BIG_ENDIAN
>> +#ifdef __BIG_ENDIAN__
>>   #define __BYTE_ORDER __BIG_ENDIAN
>> +#define __LITTLE_ENDIAN 0
>>   #else
>>   #define __BYTE_ORDER __LITTLE_ENDIAN
>> +#define __BIG_ENDIAN 0
>>   #endif
> 
> I thought the expected/correct value for __BYTE_ORDER__ was either 1234 or 4321.
> (apart from pdp11's 2143).

That's the case, in include/linux/kconfig.h we have:

#ifdef CONFIG_CPU_BIG_ENDIAN
#define __BIG_ENDIAN 4321
#else
#define __LITTLE_ENDIAN 1234
#endif

But as far as I understand the problem is that math-emu expects 
__BIG_ENDIAN to be defined at all time as it has tests like:

#if __BYTE_ORDER == __BIG_ENDIAN

Christophe


