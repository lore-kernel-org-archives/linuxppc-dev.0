Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C35CB6F98
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 19:23:06 +1000 (EST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE27@saturn3.aculab.com>
References: <m34o1ouyix.fsf@hase.home>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AE27@saturn3.aculab.com>
Subject: RE: [RFC] Optimize __arch_swab32 and __arch_swab16
To: "David Laight" <David.Laight@ACULAB.COM>
Message-ID: <OF35FB17D7.41EF05A7-ONC12578E9.0032D316-C12578E9.00338C07@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Aug 2011 11:23:01 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Andreas Schwab <schwab@redhat.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"David Laight" <David.Laight@ACULAB.COM> wrote on 2011/08/11 10:56:26:
>
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
> >
> > > unsigned short my__arch_swab16(unsigned short value)
> > > {
> > >    __asm__("rlwimi %0,%0,16,0x00ff0000"
> > >       : "+r" (value));
> >
> > You are creating a value that does not fit in a short.
>
> Which is a problem because the compiler could schedule
> it be written back to real memory between the instructions.

It can? There is no memory here, just registers. Even if it
is written to memory, how would that affect the register?

Assuming you are right, would rewriting it to
  __asm__("rlwimi %0,%0,16,0x00ff0000\n\t"
	    "rlwinm %0,%0,24,0x0000ffff"
	    : "+r"(value));
help?

>
> Actually the generated code would be better if the swap16()
> functions operated on 'unsigned int' fields - since it would
> save the compiler from doing a lot of shifts/masks elsewhere.
>
> For instance there is likely to be a mask with 0xffff prior
> to the call to swab16().
>
> Since one use of these is for htons() (etc), when
> the host is the correct endianness these are #defines that
> do nothing - so out of range values aren't masked.
> So it seems to me that defining:
>    unsigned int swab(unsigned int);
> would be fine - except it clashes with standard headers :-(
>
>    David
>
>
