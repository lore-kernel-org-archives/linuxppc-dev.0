Return-Path: <dgibson@ozlabs.org>
Date: Wed, 20 Feb 2008 13:04:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: libfdt: More tests of NOP handling behaviour
Message-ID: <20080220020407.GC18944@localhost.localdomain>
References: <20080218050925.GH29975@localhost.localdomain>
	<E1JR6vQ-0000h9-2f@jdl.com> <47BB7FDB.3050809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47BB7FDB.3050809@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 19, 2008 at 08:18:19PM -0500, Jerry Van Baren wrote:
> Jon Loeliger wrote:
> > So, like, the other day David Gibson mumbled:
> >> In light of the recently discovered bug with NOP handling, this adds
> >> some more testcases for NOP handling.  Specifically, it adds a helper
> >> program which will add a NOP tag after every existing tag in a dtb,
> >> and runs the standard battery of tests over trees mangled in this way.
> >>
> >> For now, this does not add a NOP at the very beginning of the
> >> structure block.  This causes problems for libfdt at present, because
> >> we assume in many places that the root node's BEGIN_NODE tag is at
> >> offset 0.  I'm still contemplating what to do about this (with one
> >> option being simply to declare such dtbs invalid).
> >>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> > Applied.
> > 
> > BTW, declaring DTBs with BEGIN_NODES not at offset 0
> > as invalid seems like a fine choice to me.
> > 
> > jdl
> 
> FWIIW, I vote ditto on declaring DTBs with BEGIN_NODES not at offset 0 
> as invalid.  The root being at offset 0 assumption is pretty well 
> entrenched and I cannot think of any reason to change it that would be 
> worth the effort.

Well, it's actually not that hard to deal with.  I've already been
planning to add a helper function/macro which validates a node offset
(something currently open-coded in a whole bunch of places).  It would
be fairly easy to make it skip over nops as well.

But, likewise I can think of no reason that NOPs before the root node
would be useful or likely to occur in practice.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
