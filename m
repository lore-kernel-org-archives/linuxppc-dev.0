Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E032A68911
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 02:44:47 +1100 (EST)
Message-ID: <43AAC9E8.2060105@varma-el.com>
Date: Thu, 22 Dec 2005 18:44:40 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
References: <43A98F90.9010001@varma-el.com> <43AA65F4.10409@intracom.gr>
	<43AAAEA2.8030200@varma-el.com> <43AAB508.7000007@intracom.gr>
In-Reply-To: <43AAB508.7000007@intracom.gr>
Content-Type: text/plain; charset=KOI8-R
Cc: Andrew Morton <akpm@osdl.org>, jes@trained-monkey.org,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou wrote:
> Andrey Volkov wrote:
> 
>> Hi Pantelis,
>>
>> Pantelis Antoniou wrote:
>>
>>> Andrey Volkov wrote:
>>>
> 
> [snip]
> 
>>>
>>> Hi Andrey,
>>>
>>> FYI, on arch/ppc/lib/rheap.c theres an implementation of a remote heap.
>>>
>>> It is currently used for the management of freescale's CPM1 & CPM2
>>> internal
>>> dual port RAM.
>>>
>>> Take a look, it might be what you have in mind.
>>>
>>> Regards
>>>
>>> Pantelis
>>
>>
>>
>> Thanks I missed it (and small wonder! :( ).
>>
>> Andrew, Is somebody count HOW MANY dev specific implementation
>> of buddy/first-fit allocators now in kernel?
>>
> 
> Yes, it is indeed messy.
> 
> The rheap implementation is generic enough and I believe can fit most of
> the
> special memory allocators needs. If you'd like I could move it somewhere
> generic and test it.
> 
I'm sure lib/ will be appropriate place. and something like
"DON'T TRY REINVENT WHEEL, TRY FIX EXISTS" in documentation/ :).

Now couple word about rheap: I understand why you are use static
alignment in allocator, but its very specialized for CPM. IMO, align
must be a param of xx_alloc. For ex: device may demand alignment by
8 bytes, which ok until... you are try map this memory to the user
space (don't shoot at me, remember about framebuffer & co).

-- 
Regards
Andrey Volkov
