Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D3ACDDEEA
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 04:12:33 +1000 (EST)
In-Reply-To: <20070404.122129.45875882.davem@davemloft.net>
References: <65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
	<20070403.112813.35016105.davem@davemloft.net>
	<19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
	<20070404.122129.45875882.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a5ebb728f4c22755d884910149e43c86@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
Date: Thu, 5 Apr 2007 20:12:20 +0200
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

> On PowerPC misaligned data doesn't generate exceptions, the chip works
> it out transparently.

That's not true.  _Most_ chips will in _most_ cases
handle unaligned accesses, unless you have disabled
that.  You cannot depend on it working without taking
alignment exceptions.

> On sparc everything is aligned.  I know, I've been accessing OFW data
> structures for more than 10 years and I haven't gotten one unaligned
> trap on sparc yet.

It tends to work in practice, sure.  Nothing gives you
any guarantee it will, though.

>> So just do an of_decode_int() and its cousins -- platforms
>> that are trying to guarantee alignment, or that can handle
>> unaligned memory accesses, can just define these as direct
>> accesses; everyone else should use the read-by-byte sequences.
>
> No, that's just stupid.  Peppering simple accesses to properties
> with these wrappers is just going to make the code uglier for
> no tangible gain whatsoever.

It would remove the millions of casts (and the need for the GCC
-fstrict-aliasing flag for this code).

> And besides what Stephen is doing is just extending existing
> practice, he isn't changing how any of this stuff is already
> used.  So this discussion should not get in the way of his
> patches getting installed.

I agree.  However when making this code more generally useful,
it would be good to make it more correct at the same time, since
it will only get harder to do so later on.


Segher
