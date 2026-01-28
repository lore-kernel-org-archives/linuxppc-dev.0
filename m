Return-Path: <linuxppc-dev+bounces-16372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AFDD46BE2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:34:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1TsM4gTgz2xlK;
	Thu, 29 Jan 2026 04:33:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769621639;
	cv=none; b=a7BV41Fi77QT9ruDaJtI8Hn6EG1WJ0TYS3W0OMUFF7Xz0mVveAnnBOJTMuVSCDgi4zx/y9+Dxmy//zOgpAR8nydkUhzlDmUzTGBh0SHHSB6I8rR1GAUI8b3OtehWWTOkIXMWPgQgbJWUomk8o4fD11KEE1GJG7aFUt+S+y2fKeQ5FuC/W5JdXrQ/2NDyCWB+bQv2T6feu2+xQPo6dGNwZ7rvQjWeaggR/Yc7CZf9+6gcEIq/SXn1L8p4uxatTcZF2Dvh0ySVMrNKHEzEYV7emmPn/DX5T4kDyq9kQkThUvPsfZy/qLYTOR2evTlQoPeajyy6wqnoyk1EXB3Zx/1BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769621639; c=relaxed/relaxed;
	bh=2ygJA/z8hSL5aorTjtSi2FNVBOEwpYfcofUZ6rF/wUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPcARF07Aw0oGOn94dvLwHCyVO9D9ex/nQbj231nCTUoUCd9Gy0z8zq8xg2dXT1esxVmtNaKGhw/uDEQ6JYOBy4chluN/59fnQ+hCktQRLBKyxBhQXBV7T9MirVvaC8iBaEF4xlaLPetqQWWn5RHsNRB86lugAAeVhXrbo8Oh1rcGFIE3uK3xrztgc2LB8wFQ0ZRIquiTaopTAK9t9xZ57jmCfXBDuddCtl66chYWWODDLuDQ5qaYRGZQsEApwI1fC43FbKgRH4AKdCczWcPqk5W+Dkgb3Q6adcgwzhymNd0wF27nIxrNht6FbKmGcey4rVdF6UHx6tFbSNwgMYjzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1TsL23y6z2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 04:33:56 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64D841516;
	Wed, 28 Jan 2026 09:33:17 -0800 (PST)
Received: from [10.1.36.159] (unknown [10.1.36.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800BC3F632;
	Wed, 28 Jan 2026 09:33:20 -0800 (PST)
Message-ID: <670c2b78-02e2-4617-80d9-3c896077f02a@arm.com>
Date: Wed, 28 Jan 2026 17:33:19 +0000
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
Subject: Re: [PATCH v4 2/3] prandom: Add __always_inline version of
 prandom_u32_state()
Content-Language: en-GB
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20260119130122.1283821-3-ryan.roberts@arm.com> <aXpArjZ1QQowshnA@zx2c4.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aXpArjZ1QQowshnA@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2026 17:00, Jason A. Donenfeld wrote:
> On Mon, Jan 19, 2026 at 01:01:09PM +0000, Ryan Roberts wrote:
>> We will shortly use prandom_u32_state() to implement kstack offset
>> randomization and some arches need to call it from non-instrumentable
>> context. So let's implement prandom_u32_state() as an out-of-line
>> wrapper around a new __always_inline prandom_u32_state_inline(). kstack
>> offset randomization will use this new version.
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/prandom.h | 20 ++++++++++++++++++++
>>  lib/random32.c          |  8 +-------
>>  2 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
>> index ff7dcc3fa105..801188680a29 100644
>> --- a/include/linux/prandom.h
>> +++ b/include/linux/prandom.h
>> @@ -17,6 +17,26 @@ struct rnd_state {
>>  	__u32 s1, s2, s3, s4;
>>  };
>>  
>> +/**
>> + * prandom_u32_state_inline - seeded pseudo-random number generator.
>> + * @state: pointer to state structure holding seeded state.
>> + *
>> + * This is used for pseudo-randomness with no outside seeding.
>> + * For more random results, use get_random_u32().
>> + * For use only where the out-of-line version, prandom_u32_state(), cannot be
>> + * used (e.g. noinstr code).
>> + */
>> +static __always_inline u32 prandom_u32_state_inline(struct rnd_state *state)
> 
> This is pretty bikesheddy and I'm not really entirely convinced that my
> intuition is correct here, but I thought I should at least ask. Do you
> think this would be better called __prandom_u32_state(), where the "__"
> is kind of a, "don't use this directly unless you know what you're doing
> because it's sort of internal"? It seems like either we make this inline
> for everybody, or if there's a good reason for having most users use the
> non-inline version, then we should be careful that new users don't use
> the inline version. I was thinking the __ would help with that.

I'm certainly happy to do that, if that's your preference. I have to respin this
anyway, given the noinstr issue.

> 
> Jason


