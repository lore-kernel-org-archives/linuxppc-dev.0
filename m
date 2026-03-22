Return-Path: <linuxppc-dev+bounces-18561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C854FC72D6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 19:03:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ff5Kk73T9z2ySb;
	Mon, 23 Mar 2026 06:03:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774206186;
	cv=none; b=hqK3tyjkaGHJt2rc97gSfwYaianonY8mizvL3ehc5iT5VmV2+z5rSJNcq+8hKicg5aT8IBi/fUGP2ymNGVe0Au0K1Ho+hccmqeYA3xJU3MzKtlpbE4unAzrU0+AkQGmfKGWQ38bcg18D1CJToXogheBk8HrlKk2b2Y4m7UsGBJ9Hz8u422Q885fJlNzTFI/Fs5LBfEfUlFH27JyF06/SuxmAK3XJUM1da7yqjFTXKOXP41IDEVT4Bxc0gWV6UXbnJPQ6uUnQaIVbEOBBs2WrAiboDbwPsAYWnmO2sBBZw1RKWw6uPBTizkBF0FyjCXC4hhNArtTHPIn2Zojatg72xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774206186; c=relaxed/relaxed;
	bh=vNfa3OtNYwzPZhGlRR5ut8Lw9hv+C1oZwmQoUYGbOkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv5qx7XaQzr0l0RiwZVhL+c9GZXzshMWFBPDIsvBoF1t33keP54PL1DGvYO3Zt+VCWhh7YKNGDVkyyN3qSQp1ToUMW+aRJ7vRJjw5vMb6osbvlVMtJFK1kE67F7L4qHIbc18HEwqUTloHu3Hbe3O9pLqDkmm2GT9A1p0KAN2P4CBmqjT5rhl8T36tnxWXeUEHlASZXMOXnEU2PN9aPHEKnSBYINXVOEr0HkQgf9AtezRp7im2cW+dFKK/+C8YpjdDje/Fp+jvIQSSzGUlwvVU9ru8wkGqFVdVZmBy4ptjNwdbYVHSVDaL4yCANB4LhqayGh5OJVcDGE1ffppV3NWjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cda6LX99; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cda6LX99;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ff5Kj5tg8z2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 06:03:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EC3D260008;
	Sun, 22 Mar 2026 19:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6805DC19424;
	Sun, 22 Mar 2026 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774206181;
	bh=DJHyO84YCo8ei8PU6WLub3sRMUYnzFbDUoHdZCMm/0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cda6LX99EK2mmDHrw8hKLOSAxjwOnB4Ri5l/SwvV5yBhYMb0dXX/YmLY6rD5XS4SB
	 O3/rfr8FRdbI6YJ+r2YwtrOSB5rinHMb8DqCOC3Umoyvpyb8Jgd/lW4/iFkW4LA8QZ
	 JVWl601pTJa75FkELt+x1NfaxI7HVodJ5P34Vl0uYBcT9I7/6R7NoA/yujGr8gLt0X
	 z9FEMZ8Rt8AIis3vFnEUHD1y6Pt6bBgIkhSAsHYHvHXVXyieq6waEkS76aHLDfmiEG
	 0JWX19YzQYmyqwFm8U0U03tlP2NySSRfH6baRN694T9+I3kFNtyrfj0DLvkGDrgeOv
	 Au5F2e0ppYH2Q==
Message-ID: <833d9535-d241-4738-b5f6-28f9ec48329a@kernel.org>
Date: Sun, 22 Mar 2026 20:02:56 +0100
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
Subject: Re: [PATCH] powerpc: Simplify access_ok()
To: David Laight <david.laight.linux@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <56dd1a892279fade2292b7eef7a52112901ae2fd.1773770778.git.chleroy@kernel.org>
 <20260322110336.66cd54af@pumpkin>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260322110336.66cd54af@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/03/2026 à 12:03, David Laight a écrit :
> On Tue, 17 Mar 2026 19:07:04 +0100
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
>> With the implementation of masked user access, we always have a memory
>> gap between user memory space and kernel memory space, so use it to
>> simplify access_ok() by relying on access fault in case of an access
>> in the gap.
>>
>> Most of the time the size is known at build time.
>>
>> On powerpc64, the kernel space starts at 0x8000000000000000 which is
>> always more than two times TASK_USER_MAX so when the size is known at
>> build time and lower than TASK_USER_MAX, only the address needs to be
>> verified. If not, a binary or of address and size must be lower than
>> TASK_USER_MAX. As TASK_USER_MAX is a power of 2, just check that
>> there is no bit set outside of TASK_USER_MAX - 1 mask.
>>
>> On powerpc32, there is a garanteed gap of 128KB so when the size is
>> known at build time and not greater than 128KB, just check that the
>> address is below TASK_SIZE. Otherwise use the original formula.
> 
> Given that the whole thing relies on the kernel code 'obeying the rules'
> is it enough to require that the accesses will be 'moderately sequential'?
> Provided there are no jumps greater than 128k the length can be ignored.
> 
> I think Linus thought about doing that for x86-64.

You mean ignoring length completely ?

Yes we can probably do that on 64 bits. I don't know about x86_64 but 
powerpc64 has TASK_USER < 0x0010000000000000 and kernel space is above 
0x8000000000000000, so oring size with address and comparing it to 
0x0010000000000000 doesn't add much cost compared to just comparing the 
address.

> 
> I can't imagine that happening unless there is code that probes the end of
> the user buffer before starting a transfer - and that is pretty pointless.
 > > There are places that skip a few bytes (or just access in the wrong 
order)
> but it is likely to be alignment padding, and code should be doing the
> access_ok() check for each fragment - not on the entire buffer.

I don't follow you. Why not for the entire buffer ? We try to minimise 
amount of stac/clac (or equivalent) and access_ok() is associated with 
stac. When we use access_begin/access_end we tend to try and regroup 
everything in a single bloc.

> 
>>
>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> ---
>>   arch/powerpc/include/asm/uaccess.h | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
>> index 570b3d91e2e4..ec210ae62be7 100644
>> --- a/arch/powerpc/include/asm/uaccess.h
>> +++ b/arch/powerpc/include/asm/uaccess.h
>> @@ -15,8 +15,34 @@
>>   #define TASK_SIZE_MAX		TASK_SIZE_USER64
>>   #endif
>>   
>> +#define __access_ok __access_ok
>> +
>>   #include <asm-generic/access_ok.h>
>>   
>> +/*
>> + * On powerpc64, TASK_SIZE_MAX is 0x0010000000000000 then even if both ptr and size
>> + * are TASK_SIZE_MAX we are still inside the memory gap. So make it simple.
>> + */
>> +static __always_inline int __access_ok(const void __user *ptr, unsigned long size)
>> +{
>> +	unsigned long addr = (unsigned long)ptr;
>> +
>> +	if (IS_ENABLED(CONFIG_PPC64)) {
>> +		BUILD_BUG_ON(!is_power_of_2(TASK_SIZE_MAX));
>> +		BUILD_BUG_ON(TASK_SIZE_MAX > 0x0010000000000000);
>> +
>> +		if (__builtin_constant_p(size))
>> +			return size <= TASK_SIZE_MAX && !(addr & ~(TASK_SIZE_MAX - 1));
>> +		else
>> +			return !((size | addr) & ~(TASK_SIZE_MAX - 1));
> 
> The compiler may know an upper bound for 'size' even when it isn't a constant.
> It might be 32bit or from 'size = is_compat_foo ? 16 : 24', so:
> 		if (statically_true(size < TASK_SIZE_MAX)
> 			return !(addr & ~(TASK_SIZE_MAX - 1);
> 		return !((size | addr) & ~(TASK_SIZE_MAX - 1));

I think you are missing the case where size is constant and > TASK_SIZE_MAX.

Or maybe that case should be catched with a BUILD_BUG ?

Christophe

> 
>> +	} else {
>> +		if (__builtin_constant_p(size) && size < SZ_128K)
> 
> Again the compiler may know an upper bound even if the value isn't constant:
> 		if (statically_true(size < SZ_128K)
> 
> 	David
> 
>> +			return addr < TASK_SIZE;
>> +		else
>> +			return size <= TASK_SIZE && addr <= TASK_SIZE - size);
>> +	}
>> +}
>> +
>>   /*
>>    * These are the main single-value transfer routines.  They automatically
>>    * use the right size if we just have the right pointer type.
> 


