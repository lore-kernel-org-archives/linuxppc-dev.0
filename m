Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8B70F2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 12:56:13 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r5H2tx6H000998
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 21:56:02 -0500
Message-ID: <1371437755.21896.150.camel@pasglop>
Subject: Re: PowerPC assembler question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Jun 2013 12:55:55 +1000
In-Reply-To: <20130616163041.fa5d1f2d41118b39e22241d5@mega-nerd.com>
References: <20130610090135.a002eba2401c06eedfa7b7ec@mega-nerd.com>
 <1370820095.14883.45.camel@pasglop>
 <20130610211439.a69d2b26ee216f34caf473bd@mega-nerd.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B727F@saturn3.aculab.com>
 <20130616163041.fa5d1f2d41118b39e22241d5@mega-nerd.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-16 at 16:30 +1000, Erik de Castro Lopo wrote:
> Been busy, but I'm back looking at this.
> 
> David Laight wrote:
> 
> > With a scratch register there are some two instruction sequences.
> > Reusing the destination register something like:
> >
> > 	addis	%r30,%r31,hi(.label - 1b)
> > 	lwzx	%r30,lo(.label - 1b)(%r30)
> >
> 
> I've managed to convert that into something gcc understands:
> 
> 	addis	30, 31, (.label-(1b))@ha
> 	lwz	30, (.label-(1b))@l(30)
> 
> The "@l" is the equivalent of lo() and "@ha" is the sign extending
> verions of hi(). Unfortunately, this code segfaults on executiion.
> I suspect that is because I have used the LWZ instruction instead
> of LWZX suggested by David.

No, lwz is the right instruction. The above should work, tried
stepping it in something like gdb to see waht exactly is going on ?

lwzx is a form that takes only registers (adds two registers to make
the address to load from). lwz takes a register and an immediate offset.

Cheers,
Ben.


> Unfortunately gcc doesn't accept LWZX which I found documented
> here:
> 
>      http://pds.twi.tudelft.nl/vakken/in101/labcourse/instruction-set/lwzx.html
> 
> and seems to have LX as a synonym, but that instruction only seems
> to work on registers, not on addresses as we have here.
> 
> I'm actually beginning to have a better understanding of the code
> and I've pulled out these snippets code code into a small assember
> program I'm compiling with gcc and running under gdb.
> 
> Cheers,
> Erik
