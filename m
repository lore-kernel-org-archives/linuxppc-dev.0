Return-Path: <linuxppc-dev+bounces-26290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD71C624CE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 13:30:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYVHS4J6Jz2y2J;
	Mon, 31 Aug 2026 23:30:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788183044;
	cv=none; b=evrh3Vatgg9IQIiX+40RgT+8Bgv1cRq/ajEZtOj6FaCTM+lYOvR323SyB+FCgPPTRLqT0t0n96Fg1ODHTpUk44btszpnv2OOaMzp0LOecFPn5SnK9W7Ak/Wi4xkd1zRGiQ+0aMZFBiX38FelgQROxj/1IEoTENhTfx1ECsVwLYROWAy0KfjsTadu0J7lB7nE7EVm8Xq+WQfQ7a9Ywz2f6hoyBWE8OG2kuJvxRHSzXjpFU70S2ylQEuxNkzaxxpnie7GgYjS0gipUkY8Qiam4v1dXHzSkGTLFGoCptyXe9GVGQILDk8X4OT7BfpxE6cRmvaYmXSOzW2axRWHXuDFUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788183044; c=relaxed/relaxed;
	bh=bclo5dNXV+6Jy1wwsMfxD1j5QCeC9PLq5D/ZXM1ZV+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKyW0NPReMe+aK4mwlZhLbbH8W+6XYkPWH2Cc/jRCgSa8VvG38T5w3ewt5nvTh7aa6bxlSHLIZpxC/HPva8edLLvqNPlDqlgyDrnWeRcnMb+l/PtHe+mB/sXB23bh4YXV8tB7ZfN/diefHis4XsDX1BbQe5HKLi+/hv7iY2raGP8tIUXbTee+CMO+moeT68o8qWOhsYW/hZ7L1a1AfMYtkwLO+s0OgSdPrvTnOJA7mYrDdgzz1va8L6gVnhRpkQkk9jQ8pvJKkZT2ymEUnNmAttdlJPVcrNNZDzsGqX90Md/irR/Atf0b3BtSbaw4yghN8N6SroIBK86be1324GZ/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=T3PAypEu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=T3PAypEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYVHR04s4z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 23:30:41 +1000 (AEST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c2544ff970dso542019966b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788183038; x=1788787838; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bclo5dNXV+6Jy1wwsMfxD1j5QCeC9PLq5D/ZXM1ZV+o=;
        b=T3PAypEuH41VMMz0DCyBgvY0djXj6ez9WK79Qzp3bhMSw1yra1J3fOBh+igXD04IXu
         rErX8HBBgsLga5CLyeg096KvSRddRRVBDizSlhWxcHevImM1G41YaTGDtKS5ppinl41E
         tv6y4dUmiUT4CYG9fyRvebdCpqR/xDd6ZdvwSTMu+FqBtq8k+HQZ1S8XRM1d91vB79I5
         9K4Ou6r9Ie4cFYnZMafzM5jXY27C4WoRMJ/35DpD+PXlnXA5cb98N0gMGJ9Bq4PQyRTU
         MtoA5VBW1bhKE16dexkk0s460uhtMSaF1R96uT0YCJNcxBSguJKEqA8X7jn0JjGg7xky
         pmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183038; x=1788787838;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bclo5dNXV+6Jy1wwsMfxD1j5QCeC9PLq5D/ZXM1ZV+o=;
        b=fScXACks69fW9QBcFp66w1Wx8Mv4DndMgJD7FJe3N1f0ORs215bc4m89SzD3cO4itF
         6QUlX+PadSysdKK6JC87IzU0wwoGAlopCWKO4VixDbrGW938wMylvKaDWfWmKfzmyC1j
         k6n7pOiV85lQDlrs62SlINgbxCeLODkqKyIWRfCumO/It/oehWMDkk2yA67o4gTxxKOs
         +Q1Mxm0Ur4hfNLIpcBhfejTpDOrWooOUKfLWlracn4oR8km+qKRSoS7JQNkIoGtp2hxi
         YeoD9kdiRb4HkIRMn0erxFUpe5Ho8gD/YH7x0hWvC9PIkRz71m2lOzc7J3qcGUVKyryb
         uN6A==
X-Forwarded-Encrypted: i=1; AHgh+RopS9ihpQN5pBGMNwWKE+YcuiPUfGnwyVxh9jWmNc3L1Vk8RJqDQ2nFTf6bcM/ysGf0KTjEx8ZjYyOQ3Sw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nOlZJk0t8D5Gy1W3OnPnRn1KBCNxX8F4l9pd1G5zD+Y45TT1Q3
	PQgXsVQ5snxAB4kJKKU1jFS/NT+kXpL1pEbFITy0TL4nbYhZj3cShYFRBck3rajarBE=
X-Gm-Gg: AR+sD11GCSmg+L+/+j9ynICHERAt6OMIfTa1kZo+/DSt1Z/qTo06z7VSYGkhwdH6HBP
	O83+WbcKWHPHHuDk9zYnXpARN28+Wq74JOc9ybu0SJYDDJdlmBQbLZrRbLn8RQRnWn8yIjWPKxC
	01faaeTNQgGNJyKyli8+dT6QCY3GNW/Aq02HnJFUuiLvuL5IJp/3NHGJXurxafyGpeMwmkocJBT
	ikLp+0iG+rXD0i2bz+HC6TuEnaTVQsdqcnJ6nmHWPu4kdpyTJ0NZcmUmN00LH8IDZ3LEQEkmf+b
	nlMwloMeEmBTcLV1W6ZlUO//5tzxveLATOj35PoyyPStf/bmstVg4lBHGPHZ8NRuVRjt8AAEexT
	cxB2tazKIX+4IkTepj0BxcNutb+htDAP2w1AgcCJuBHWe4B9vc+8mtHv7z7zgmsZiuHFxAh2UDK
	r7SOBdfu9Q9yYNAdW5SWRS6WkEfGnmJM/dyKwH5xXyZVY8SSc8r7SB2ShlC1rvDFqsNS6lVH8pk
	+TupubfpNVDnFprPaS3PJk2
X-Received: by 2002:a17:907:3cc2:b0:c1c:5aa1:de57 with SMTP id a640c23a62f3a-c2557030696mr1575327866b.13.1788183038289;
        Mon, 31 Aug 2026 06:30:38 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee0b233sm435317266b.11.2026.08.31.06.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:30:37 -0700 (PDT)
Message-ID: <5e6231aa-10b9-4c41-b7ab-dee5e8f64bec@suse.com>
Date: Mon, 31 Aug 2026 15:30:36 +0200
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
Subject: Re: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20260822135323.795946-11-ardb+git@google.com>
 <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
 <cee89666-9de0-4012-b665-69da3846c5ef@app.fastmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <cee89666-9de0-4012-b665-69da3846c5ef@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 3:45 PM, Ard Biesheuvel wrote:
> On Fri, 28 Aug 2026, at 15:07, Petr Pavlu wrote:
>> On 8/22/26 3:53 PM, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The arm64 module loader has to deal with a couple of corner cases that
>>> may occur when .init.text is placed out of direct branch range of .text:
>>>
>>> - ordinary direct branches from .init.text into .text may require the
>>>   use of a PLT entry (i.e., a trampoline aka veneer), which means not
>>>   only that additional PLT entries need to be allocated for
>>>   cross-section calls, but also that .init.text needs its own PLT
>>>   reservation, as the one in .text will be out of range as well;
>>>
>>> - dynamic patching of the ftrace handler into .init.text code needs its
>>>   own dedicated trampoline as the one in .text may be too far away.
>>>
>>> - recent compilers may omit BTI veneers for static functions that never
>>>   have their address taken, and so additional veneers will need to be
>>>   added to .text in case cross-section direct branches from .init.text 
>>>   require a PLT entry (and therefore a landing pad at the target end).
>>>
>>> This is unfortunate, because it is actually somewhat unusual for .text
>>> and .init.text to be so far away from each other: only when allocating
>>> either of them (but not both) exhausts the 'near' (PLT-less) module
>>> region, the other will be allocated from the spillover region, which is
>>> not in direct branching range, and therefore requires PLT entries for
>>> cross-section calls.
>>>
>>> This series addresses this wart by allocating both of them as a single
>>> chunk, and freeing the .init.text part along with the other init
>>> sections at the appropriate time. This ensures that the two regions will
>>> never require veneers for cross-section calls, allowing the arm64 module
>>> loader to be simplified.
>>
>> It looks like this should also be useful for ppc64, which currently
>> merges .init.text and .text because keeping them separate would require
>> stubs between the two, and consequently .init.text is never released in
>> modules on this architecture.
>>
> 
> Thanks for the data point - are those stubs needed when there is some
> distance between the placements of .text and .init.text?

Yes, my understanding is that these stubs are primarily needed because
the BL instruction on ppc64 can only reach a range of +-32 MB.

Another aspect on ppc64 is the use of the Table of Contents (TOC). In
theory, when splitting .text and .init.text, one would also want
separate TOCs, along with stubs to support switching between them.
However, I don't think this is particularly feasible. As far as I can
see, the ABI and GCC don't allow separate TOCs within a single
relocatable object file. In practice, it shouldn't be a large problem to
keep a single TOC, even if some data related only to .init.text remains
present after the module is loaded. Being able to free .init.text is the
important part. On newer Power10 with PCREL, the TOC is not used, so
this issue goes away.

-- 
Cheers,
Petr

