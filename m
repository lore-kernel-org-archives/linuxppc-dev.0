Subject: Re: [PATCH] Adding support for LXT971/2 PHYs
To: dan@netx4.com (Dan Malek)
Date: Fri, 5 May 2000 11:10:37 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <39119F4D.FD8C4DD1@embeddededge.com> from "Dan Malek" at May 04, 2000 12:03:25 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000505011037.B41DA3C97D@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

Dan Malek writes:
> Oooops, you almost missed out :-).  I have received a couple of these
> lately, all implemented slightly differently.  I am going to shake-n-bake
> all of these and see what falls out of the bag.......

Hmmm. Ours is the first patch for this I've seen posted to the mailing list,
unless there's another list somewhere I'm not aware of. We don't want to be
re-inventing the wheel; we'd rather contribute something useful that other
people aren't also doing. It would help if people posted stuff like this on
the list, so we know what's coming in the pipeline.

> I'll put it into the 2.3.99 tree first, then into one of the 2.2.xx
> releases.

OK. How do those of us without BitKeeper access grab your 2.3.99 tree?

> I think the #ifdefs for 8xx are soon going to be gone, replaced with
> a significantly larger board information structure.  Things like this
> will go there.  The #define IMMR is going to disappear, replaced with
> a memory pointer, among other things.

Are you sure we want to do that? I kind of like being able to define a
minimal board info structure, where the board info structure only contains
stuff that can potentially vary between models of the same board. My ideal
solution to the problem of supporting multiple board types is to move the
magic numbers like the PHY interrupt pin and the PxPAR/PxDIR/etc values into
each board-specific header file, giving definitions like:

    #define PAPAR_VALUE	0x....
    #define PADIR_VALUE	0x....

Doing this exhaustively (for all boards) would allow all the '#ifdef
CONFIG_boardname's to be replaced with generic macro usages which allow new
board types to be added by simply writing the new board.h file, and adding the
#include for it in include/asm-ppc/mpc8xx.h. The other advantage over
complicating the board info structure is that there's no runtime code size
overhead this way. Keep it simple and all that. The only problem is that the
support for existing boards only goes part way towards doing this at present.

We took this approach with our new custom board, and haven't had to add a
single #ifdef CONFIG_ourboardname outside the one which chooses our
board-specific header in mpc8xx.h. Of course we'll go with the flow, but I
think we can do a better job of multiple board support without a complex board
info structure. On the other hand, the mimimal-size approach runs counter to
the potential goal of having a single kernel config which runs on anything.
I personally don't think that's desirable, but it may be another motivation
behind the put-it-all-in-board-info approach.

I can post the relevant sections of our board.h file if an example help
illustrate this better.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
