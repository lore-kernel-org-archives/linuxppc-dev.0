Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D95D0DDF6B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:21:29 +1000 (EST)
Date: Wed, 04 Apr 2007 12:21:29 -0700 (PDT)
Message-Id: <20070404.122129.45875882.davem@davemloft.net>
To: segher@kernel.crashing.org
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
From: David Miller <davem@davemloft.net>
In-Reply-To: <19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
References: <65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
	<20070403.112813.35016105.davem@davemloft.net>
	<19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 4 Apr 2007 13:11:43 +0200

> >> Why?  It should logically be an u8 * (and nothing
> >> should ever cast it to anything else, accessor
> >> functions should be used instead to get 32-bit ints
> >> from it, etc.)
> >
> > Ummm, no.
> >
> > There are structures there, and other types of objects.
> 
> There are arrays of bytes there, with no guarantee of
> any further alignment.

On PowerPC misaligned data doesn't generate exceptions, the chip works
it out transparently.  It's not very slow at it even, and these paths
accessing this stuff aren't performance critical anyways.

On sparc everything is aligned.  I know, I've been accessing OFW data
structures for more than 10 years and I haven't gotten one unaligned
trap on sparc yet.

> So just do an of_decode_int() and its cousins -- platforms
> that are trying to guarantee alignment, or that can handle
> unaligned memory accesses, can just define these as direct
> accesses; everyone else should use the read-by-byte sequences.

No, that's just stupid.  Peppering simple accesses to properties
with these wrappers is just going to make the code uglier for
no tangible gain whatsoever.

There is no reason to make a mountain out of a mole hill wrt. this
stuff.

And besides what Stephen is doing is just extending existing
practice, he isn't changing how any of this stuff is already
used.  So this discussion should not get in the way of his
patches getting installed.
