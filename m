Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12646DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 21:11:55 +1000 (EST)
In-Reply-To: <20070403.112813.35016105.davem@davemloft.net>
References: <20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
	<20070403.112813.35016105.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
Date: Wed, 4 Apr 2007 13:11:43 +0200
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Why?  It should logically be an u8 * (and nothing
>> should ever cast it to anything else, accessor
>> functions should be used instead to get 32-bit ints
>> from it, etc.)
>
> Ummm, no.
>
> There are structures there, and other types of objects.

There are arrays of bytes there, with no guarantee of
any further alignment.

> Look at how some of the sparc64 code does this, it's not a "u8 *" by
> even the largest stretch of the imagination.

Maybe sparc64 does have some defined extra alignment;
on PowerPC, we get that alignment by making a copy of
the device tree.  That means no further interaction
with OF after very early boot (even before the kernel
proper starts); a less than desirable situation, and
certainly not something that a *generic* Linux OF
interface can require.  Also, in principle anyway,
you can have an integer follow a string in the same
property.

So just do an of_decode_int() and its cousins -- platforms
that are trying to guarantee alignment, or that can handle
unaligned memory accesses, can just define these as direct
accesses; everyone else should use the read-by-byte sequences.


Segher
