Return-Path: <linuxppc-dev+bounces-29296-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E0CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:38:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3R7F08Jkz2xnQ;
	Tue, 13 Oct 2026 05:38:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830312;
	cv=none; b=S0F8Tg1td6H8kOX/SBrtACD5GlKqe0ZDIdlhf7b6XxcZoB5fMBVmtex3eSIMf/MPriCgBDOHcn/GP4a6eGG9Yl5dYYH1FjvfuR6nuAy14jv4IMtWpjZ+A1bOWkrmTWggt1BtvM7GuBdLEp4x9r6X2Uw455+73jDT3YHuuELMb0Qo/l2p1SQh/OHbOR/I+dLOIdq8qT3MaSAfG4bCdwle7DOxT+/cxiQCtJsDdjnoL4zmKvvSIDT+kdoHe5MhwfYrFLnUbqW9eSKWQOcOVq11P/w0CxDm8o/mddmfTVSs9FMSfv9OQWad6K9yr6OCwq6W7puVVAfdE4dhHym6/vFhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830312; c=relaxed/relaxed;
	bh=n9mBE65GVjIOFbJ7hGQJWa9dJHLVxop6r7GrgLGk3Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agxrT41nssH4k9DC6cqpKuzbbkP2zt8oTaLj/ZeV5dNIP8Ye6HnlG+qkxbuXlMERucw8/sj/8bMPmFfhEFccwGY5Wuc7yZyqCrhRV/D3JCfPyF3dsLem5YcujeZ8oOeRlUqN8LQs1GnlkuA6r4fSeNYdIkA7kzwEjdwwW6wSgXXnx77RO+F0kaHmSbnGJv3pdeGX41zt/CdLwQ3xj8xt50Cpocj9mWbcnHER3D+F4RD5HaeNzcwQwKpBhxAHHljs1fWJ0JGAfnk0A5Ju9pY4o6D5GZFwNRr3XdcVsYDZJG49k+rZFNGfMsnYZOUdzAwy4KZnON9n9Dr1Fkmp25x+FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIy5Ut26; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIy5Ut26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3R7C4L71z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:38:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4ECC41812;
	Mon, 12 Oct 2026 18:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531051F008A1;
	Mon, 12 Oct 2026 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830309;
	bh=n9mBE65GVjIOFbJ7hGQJWa9dJHLVxop6r7GrgLGk3Zw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aIy5Ut26xaWOdGg5T1QMiKhN5V5Ct4//dUTXsfdtk+CSwTWKRDFL4XbVRJ3y1nQCO
	 3iLeH0Ry8W3rXHeiNc5RWrV0T3pCeIF46FFJwJUpYwmqX0RwnLoeSXzw9Yu0pDwAHY
	 Ok28nYXuO05gyldhihMMndmdxjHOO3kMpyoZ1JMoil7jOsF2nP9cnrs8VHy/ckfKUb
	 mPcVG7cnMzof3I5e8RdTRlzBqueaK6epe22x5WrNvjE3MfkI20PeH8rQ0nE9uptpOe
	 jm/ltSHB2vRcMIssYLtJtHfS+AD9dolZvkRkfgzDd7EIpOr/k6GTQXMvHdvKpUFwJg
	 PWwOQv8a89W5g==
Message-ID: <04d806cb-24dc-4597-ae03-6dbef11d0a86@kernel.org>
Date: Mon, 12 Oct 2026 20:38:24 +0200
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
Subject: Re: [PATCH v2] powerpc/lib: prefetch ahead in __csum_partial()
To: Rosen Penev <rosenp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261012180052.55578-1-rosenp@gmail.com>
 <a877ad04-c4ed-4e32-a1eb-da524146be14@kernel.org>
 <CAKxU2N-VQ9fWGvdNvyZ7te1gp08qMSvbSpgLrKRkqDO+Y+bYwg@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAKxU2N-VQ9fWGvdNvyZ7te1gp08qMSvbSpgLrKRkqDO+Y+bYwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/10/2026 à 20:28, Rosen Penev a écrit :
> On Mon, Oct 12, 2026 at 11:18 AM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>>
>>
>> Le 12/10/2026 à 20:00, Rosen Penev a écrit :
>>> __csum_partial() walks the buffer linearly and reads each cache line
>>> exactly once. On cores without a hardware prefetcher, such as the 464FP
>>> in the APM82181, every new line is therefore a demand miss that stalls
>>> the loop. Packets received by non-coherent DMA are never in the cache,
>>> so this is the common case for GRO checksum validation: when routing
>>> TCP with GRO enabled on a Meraki MX60, __csum_partial() takes about 30%
>>> of all cycles and is the top entry in the profile.
>>>
>>> Issue a dcbt four cache lines (128 bytes) ahead in the main loop.
>>> dcbt is only a hint and never faults, so prefetching past the end of
>>> the buffer is harmless. Lines that are already cached, for example when
>>> checksumming data the CPU just wrote, are left untouched.
>>>
>>> Measured on a Meraki MX60 (APM82181 at 800 MHz), single TCP stream
>>> routed through a qca8k DSA switch, iperf3 median of 5. Only the dcbt
>>> was toggled at runtime, in the same boot:
>>>
>>>                 LAN->WAN               WAN->LAN
>>>                 Mbit/s  csum cycles    Mbit/s  csum cycles
>>>     before      495     30.5%          439     27.2%
>>>     after       599     15.3%          520     13.7%
>>>
>>> That is 58% less time spent in __csum_partial() per byte.
>>>
>>> The prefetch distance was chosen with an earlier, slower driver
>>> configuration (median of 3, Mbit/s):
>>>
>>>     distance    LAN->WAN   WAN->LAN
>>>     none        370        341
>>>     64 bytes    430        381
>>>     96 bytes    438        397
>>>     128 bytes   438        385
>>>     160 bytes   434        386
>>>     256 bytes   423        383
>>>
>>> Prefetching the first lines before entering the loop made no
>>> measurable difference and is not done.
>>>
>>> Assisted-by: LLM
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> csum_partial_copy_generic() does the same, so your patch makes sense.
>>
>> Wondering if you should use MAX_COPY_PREFETCH instead of hardcoding value 4.
> li      r9,MAX_COPY_PREFETCH*L1_CACHE_BYTES /* prefetch distance */
> 
> LLM comment:
> 
> What changes per platform: MAX_COPY_PREFETCH is 4 on every 32-bit
> config except 8xx, where it is 1. So 44x, 47x and e500mc behave
> exactly as before; on the 44x (canyonlands) build the instruction is
> still li r9, 128. The one difference is 8xx, which now prefetches 16
> bytes ahead instead of 64. That fits how the copy routine already
> treats 8xx, but I didn't benchmark it.
> 
> My comment:
> I don't have an 8xx device so I don't know if this works properly there or not.

I have an 885 and might do the test one day, but I won't have time 
during the coming weeks. Nevertheless I have the feeling it makes sense 
to implement something based on MAX_COPY_PREFETCH to resemble 
csum_partial_copy_generic()

>>
>> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> I'll keep this in v3.
>>
>>> ---
>>>    v2: reword commit message and retest numbers.
>>>    arch/powerpc/lib/checksum_32.S | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
>>> index cd00b9bdd772..5a14d45c7b9d 100644
>>> --- a/arch/powerpc/lib/checksum_32.S
>>> +++ b/arch/powerpc/lib/checksum_32.S
>>> @@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
>>>        bdnz    2b
>>>    21: srwi.   r6,r4,4         /* # blocks of 4 words to do */
>>>        beq     3f
>>> +     li      r9,4*L1_CACHE_BYTES     /* prefetch distance */
>>>        lwz     r0,4(r3)
>>>        mtctr   r6
>>>        lwz     r6,8(r3)
>>> @@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
>>>        lwzu    r8,16(r3)
>>>        adde    r5,r5,r7
>>>        bdz     23f
>>> -22:  lwz     r0,4(r3)
>>> +22:  dcbt    r3,r9
>>> +     lwz     r0,4(r3)
>>>        adde    r5,r5,r8
>>>        lwz     r6,8(r3)
>>>        adde    r5,r5,r0
>>


