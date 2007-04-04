Return-Path: <tnt@246tNt.com>
Received: from outmx035.isp.belgacom.be (outmx035.isp.belgacom.be
	[195.238.6.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F99DDDF1B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:01:19 +1000 (EST)
Received: from outmx035.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx035.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l34I1Bi7001585
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 20:01:14 +0200
Message-ID: <4613E7CC.1020001@246tNt.com>
Date: Wed, 04 Apr 2007 20:00:44 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com>
In-Reply-To: <4613E39A.70606@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Kumar Gala wrote:
>
>> I'm concerned the error handling isn't correctly.  What happens if 
>> the rheap I'm managing has addresses at 0xf0000000.  When I compare 
>> offset to 0, its going to report as an error, even if the offset 
>> returned is valid.
>
> The return value is an offset INTO the actual buffer.  Unless you have
> buffer larger than 2GB, the return value will never be negative unless
> it's an error.  So technically, the maximum size of the remote heap is
> 2GB.  It doesn't matter where it was located.
That's what I tried to explain yesterday on IRC. Using rheap to manage
offset into a buffer is one of the usage model. The other one is to use
rh to manage addresses directly.
Since the case where you manage offset is more common, it make senses to
change the types to unsigned long. However the other usage model (manage
addresses) should still be possible (using type casts only).

I agree that _for the moment_, no code make uses of rheap to manage
addresses but that could happen.

> Please keep in mind that I'm not changing the actual numeric values
> that are being returned.  I'm only changing the types, because they
> were wrong.  rh_alloc() was returning a void pointer, but it was NEVER
> a pointer.  It was always a simple offset.
That's because _currently_ all the code use it like that, but nothing
prevents them to use it other wise ...

But you're right, your not changing the actual values returned,
ERR_PTR(x) == x ....
So if someone wants to use it with addresses, he still can. He should
just do cast to (void *). And to detect errors on alloc he should he
IS_ERR(...)

>   The first time you call rh_alloc(), you will get back a value of 0,
> because that's the beginning of the heap.
No, it doesn't always return 0.
That depends on what free region you "attached" at initialisation. And
you could have attached 0xffff0000 -> 0xffffffff ....



    Sylvain
