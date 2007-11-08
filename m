Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CDF9DDDE2B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:17:18 +1100 (EST)
Message-ID: <47331979.7030803@freescale.com>
Date: Thu, 08 Nov 2007 08:13:13 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] DTC: Polish up the DTS Version 1 implementation.
References: <E1IpWlT-0007Qd-IX@jdl.com>	<20071106231120.GG31367@localhost.localdomain>	<E1Iplfp-0003WY-MB@jdl.com>
	<20071107231942.GA8835@localhost.localdomain>
In-Reply-To: <20071107231942.GA8835@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> 
> Yes, I know, but I don't think it's even worth having the unused
> internal parameterization.

OK.  We can eliminate it then; no problem.

>
>> I ran my "old versus new DTC" comparison script and found it. :-)
> 
> Heh, we should fold that into the testsuite, too.

I'll start by simply adding the script to the test directory then.



>> Because it wasn't working, as explained in the comment I added.
>> Specifically, (1<<bits), with bits==64 overflowed and yielded
>> the value 0.
> 
> Ah...
> 
> Well, I assumed (1ULL << 64) would equal 0, which is why the
> comparison has the (-1) - I was expecting for bits == 64 it would end
> up being against -1, i.e. 0xffffffffffffffff.  This appears to work on
> the systems I've been using.

But not on an x86 system.

> But I just remembered that (x << n) has undefined behaviour in C when
> n >= word size. 

Exactly.  In fact, I think x86 takes the shift value, bit-wise
ANDs it with 63 internally, and then shifts left by that value.

 So I guess (1 << 64) is just returning garbage - I

In fact, it is yielding 1 on an x86 machine.

> suspect I didn't catch it because I've been building with -O0 for
> gdb-ability, which might change the behaviour of corner cases like
> that.

Or works on a PPC machine? :-)

> So I guess we need
> 	else if ((errno == ERANGE)
> 		 || ((bits < 64) && (val >= (1ULL << bits))))

Sounds good.  I'll commit --amend that into the patch!


>> And in the blue corner, touting consistent hex forms, ...
> 
> And in the red, compact bytestring representations.

> No, seriously, the inconsistency bothers me too.  But so does the fact
> that using 0x in the bytestring would double the minimum size for
> representing bytestrings, somewhat changing the flavour of [] as well
> (because spaces are no longer optional).  I'm looking for a killer
> argument one way or the other, but I haven't found it yet.

But why does it even have to be hex numbers at all?
I guess my point is that they could just be expressions.
You could use 0x31 or 49 or '1' or 061, whichever made
more sense in some application.  You don't necessarily take
a representational size hit.

jdl
