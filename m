Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26C4767B58
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 10:26:05 +1000 (EST)
Subject: Re: [PATCH] Remove powerpc specific parts of 3c509 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <488875E7-CCBC-47E1-A273-A2D037A997B2@kernel.crashing.org>
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
	<45103C62.4080003@genesi-usa.com>
	<1158708269.6002.186.camel@localhost.localdomain>
	<488875E7-CCBC-47E1-A273-A2D037A997B2@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 10:25:35 +1000
Message-Id: <1158711935.6002.226.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2006-09-20 at 02:21 +0200, Segher Boessenkool wrote:
> > Nah. We have the basic rule that readl/writel are little endian.  
> > PowerPC
> > additionally provides arch specific low level in_{be,le}32 type
> > accessors with explicit endianness. Or you can also use
> > cpu_to_le32/le32_to_cpu kind of macros to convert between native and
> > explicit endianness.
> 
> Sure, PCI busses are little-endian.  But is readX()/writeX() for PCI
> only?  I sure hope not.

It's defined for PCI and possibly ISA memory. You can use it for other
things if you whish to, but "other things" are arch specific in any
case.

> It would make a lot more sense if readX()/writeX() used the endianness
> of the bus they are performed on.

No way ! Again, it's evil if such a simple thing start doing different
things depending on random external factors.

Different bus -> different accessor.

We defined on PowerPC that readl was fine for anything that comes out of
ioremap and is little endian, but that's also why you have the explicit
{in,out}_{le,be}{16,32}. That's what you should use in fact with non-PCI
busses unless you know you are LE.

> PowerPC byteswaps are cheap -- for 16- and 32-bit accesses.  They're quite bad for 64-bit though; it would
> be a pity to end up doing two of those for a 64-bit big-endian I/O  
> access
> (one on the access itself, one to convert the data back to CPU order).
> 
> This would happily solve the problem of the various variations of
> byte-swapping bus bridges, too ("natural" swap, 32-bit swap, 64-bit  
> swap,
> perhaps others that I thankfully have never seen or cannot remember).
> 
> Now you can say, use readl_be() or something similar, but that's a)  
> ugly,
> b) error-prone, c) exponential interface explosion, d) ugly.

I'd rather has an interface explosion than having black endian magic
happening inside of the accessors.

Ben.
