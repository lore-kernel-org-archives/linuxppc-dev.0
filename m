Return-Path: <mle+cl@mega-nerd.com>
Received: from hendrix.mega-nerd.net (hendrix.mega-nerd.net [203.206.230.162])
 by ozlabs.org (Postfix) with ESMTP id E0F862C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 16:30:43 +1000 (EST)
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
 by hendrix.mega-nerd.net (Postfix) with SMTP id 0D116106DDD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 16:30:41 +1000 (EST)
Date: Sun, 16 Jun 2013 16:30:41 +1000
From: Erik de Castro Lopo <mle+cl@mega-nerd.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: PowerPC assembler question
Message-Id: <20130616163041.fa5d1f2d41118b39e22241d5@mega-nerd.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B727F@saturn3.aculab.com>
References: <20130610090135.a002eba2401c06eedfa7b7ec@mega-nerd.com>
 <1370820095.14883.45.camel@pasglop>
 <20130610211439.a69d2b26ee216f34caf473bd@mega-nerd.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B727F@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Been busy, but I'm back looking at this.

David Laight wrote:

> With a scratch register there are some two instruction sequences.
> Reusing the destination register something like:
>
> 	addis	%r30,%r31,hi(.label - 1b)
> 	lwzx	%r30,lo(.label - 1b)(%r30)
>

I've managed to convert that into something gcc understands:

	addis	30, 31, (.label-(1b))@ha
	lwz	30, (.label-(1b))@l(30)

The "@l" is the equivalent of lo() and "@ha" is the sign extending
verions of hi(). Unfortunately, this code segfaults on executiion.
I suspect that is because I have used the LWZ instruction instead
of LWZX suggested by David.

Unfortunately gcc doesn't accept LWZX which I found documented
here:

     http://pds.twi.tudelft.nl/vakken/in101/labcourse/instruction-set/lwzx.html

and seems to have LX as a synonym, but that instruction only seems
to work on registers, not on addresses as we have here.

I'm actually beginning to have a better understanding of the code
and I've pulled out these snippets code code into a small assember
program I'm compiling with gcc and running under gdb.

Cheers,
Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
