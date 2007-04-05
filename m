Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0AC7DDE3D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 09:27:12 +1000 (EST)
In-Reply-To: <1175814107.30879.143.camel@localhost.localdomain>
References: <65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
	<20070403.112813.35016105.davem@davemloft.net>
	<19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
	<20070404.122129.45875882.davem@davemloft.net>
	<a5ebb728f4c22755d884910149e43c86@kernel.crashing.org>
	<1175814107.30879.143.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1e26dd33aaeae9c55962be681b85e75e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
Date: Fri, 6 Apr 2007 01:26:26 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It would remove the millions of casts (and the need for the GCC
>> -fstrict-aliasing flag for this code).
>
> Ugh ? We don't need casts with void *, that's the whole point ... while
> we would do if we used char * ...
>
> I'm not familiar with the details of the strict-breaking-good-programs
> rules also known as strict-aliasing but isn't void * supposed to alias
> all ?

Pointers never alias anything.  It's the data accesses
that matter.  You cannot access one type as another type
and expect it to work (unless one of those types is a
character type); that's the one simple rule.

Since you cannot access something with type "void"; no,
void pointers don't "alias" anything.

Perhaps you mean that you can cast any pointer to data to
"void *" and back to the same type.

> if not, that's really stupid... But even then, I fail to see how
> this would break an aliasing rule as we aren't accessing the same 
> object
> from two different types and we aren't even writing to it.

It doesn't matter whether you write to anything; you cannot
read the same data as two different types, either.

I'll have to trust you that the current code never does
that; it's really hard to see, with all the pointer casting
going around.

>> I agree.  However when making this code more generally useful,
>> it would be good to make it more correct at the same time, since
>> it will only get harder to do so later on.
>
> I think it's perfectly correct with void * ...

There's nothing wrong with a void * /per se/.  It's that
you need to cast it again later to access your data; and
I say you cast it to all kinds of wrong types, only u8 *
would be valid.  Feel free to ignore me though, at least
the PowerPC early boot makes sure all properties are
aligned to some power of two; as long as you never happen
to find a property where an int starts somewhere else
than a multiple of four into that property you should be
fine.  And SPARC can keep on depending on the OF it runs
on aligning everything by pure luck as far as I am concerned.

Other architectures won't be so lucky, so we'll just revisit
this when support for those is added.


Segher
