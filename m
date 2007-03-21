Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8646DDDF46
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 06:12:06 +1100 (EST)
In-Reply-To: <20070321160112.GA31655@ld0162-tx32.am.freescale.net>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172757.GC29784@ld0162-tx32.am.freescale.net>
	<20070320035005.GB21124@localhost.localdomain>
	<e07db139f025494f172389e2773a2e32@kernel.crashing.org>
	<20070321160112.GA31655@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d807f0516a5424a1a5291f2432c5c4b7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 03/17] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Date: Wed, 21 Mar 2007 20:11:59 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I didn't look at the actual code but it should be really
>> small; I hope it doesn't copy the Linux code with its
>> millions of workarounds for broken device trees -- we
>> should insist on correct trees, or even just fix them
>> if they *are* broken ;-)
>
> It's around 1700 bytes.  Most of the complexity is for dealing with
> different #address-cells and #size-cells -- if we could assume a max 
> of 2
> for each, then it could be simplified quite a bit by using u64 instead 
> of
> arrays.  However, that wouldn't work with PCI, which has 3 address 
> cells.

It is quite safe to assume a max of 3 for #a and a
max of 2 for #s.

One way to simplify the code (when writing it in C)
is to always store any address as the maximum supported
number of 32-bit integers (padding it with zeroes perhaps).
No need to micro-optimise this stuff, just make the code
real generic and simple, that'll buy you more in the end.


Segher
