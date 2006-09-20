Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0DB867B58
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 10:59:13 +1000 (EST)
In-Reply-To: <1158711935.6002.226.camel@localhost.localdomain>
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
	<45103C62.4080003@genesi-usa.com>
	<1158708269.6002.186.camel@localhost.localdomain>
	<488875E7-CCBC-47E1-A273-A2D037A997B2@kernel.crashing.org>
	<1158711935.6002.226.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F6F4A8E-C780-4358-97AA-570B33C0598F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Remove powerpc specific parts of 3c509 driver
Date: Wed, 20 Sep 2006 02:58:39 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	ppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Sure, PCI busses are little-endian.  But is readX()/writeX() for PCI
>> only?  I sure hope not.
>
> It's defined for PCI and possibly ISA memory. You can use it for other
> things if you whish to, but "other things" are arch specific in any
> case.

Huh?  You're saying that only PCI and ISA are standardised busses?

>> It would make a lot more sense if readX()/writeX() used the  
>> endianness
>> of the bus they are performed on.
>
> No way ! Again, it's evil if such a simple thing start doing different
> things depending on random external factors.

That's your opinion, yes.

I'm saying it's *not* doing different things: in both cases it just does
the correct-endian access.  Also it doesn't depend on "random external
factors" -- they're not random factors, and not external either: it only
depends on the bus the access is done on.

> Different bus -> different accessor.

Then please rename readX()/writeX() to pci_readX()/pci_writeX().

>> Now you can say, use readl_be() or something similar, but that's a)
>> ugly,
>> b) error-prone, c) exponential interface explosion, d) ugly.
>
> I'd rather has an interface explosion than having black endian magic
> happening inside of the accessors.

Any comments on a), b) and d) as well?


Segher
