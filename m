Subject: Better board support (was Re: [PATCH] Adding support for LXT971/2 PHYs)
To: dan@netx4.com (Dan Malek)
Date: Fri, 5 May 2000 15:19:36 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <39123B16.945B1E6E@embeddededge.com> from "Dan Malek" at May 04, 2000 11:08:06 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000505051936.BA2B23C971@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again,

Dan Malek writes:
> There is lots of stuff that comes straight to me for merging into
> sources.......

I know it's beyond your control; My plea was for other developers reading this
to cc the mailing list when they send you patches, so we all know what's going
on.

> > .......... My ideal solution to the problem of supporting multiple board
> > types is to move the magic numbers like the PHY interrupt pin and the
> > PxPAR/PxDIR/etc values into each board-specific header file,
>
> I understand your point, but the other side of the argument is when you
> don't keep things like this together, people don't realize how many
> examples of how to do it exist.  They also don't realize how their
> change may affect someone else.

Not sure I'm with you here, but I think we need to have a simple single
solution to multiple board support, and to use it universally. If we replace
all the board-specific #ifdefs with feature-specific ones defined in the board
specific header files, everything related to a specific board is all kept
together. I don't think I'm proposing anything new here, just a more complete
use of the current scheme where each board type has its own header defining
the features present on that board. This is also the approach 8xxROM/PPCBOOT
uses, and it would be nice to keep them all consistent.

Another example under the scheme would be to replace most of the usages of
"#ifdef CONFIG_RPXCLASSIC" in fec.c with "#ifdef PHY_QS6612", and put
"#define PHY_QS6612" in rpxclassic.h. At present, anyone adding a board which
uses the QS6612 has to edit fec.c, even though it already supports their PHY.

> > We took this approach with our new custom board, and haven't had to add a
> > single #ifdef CONFIG_ourboardname outside the one which chooses our
> > board-specific header in mpc8xx.h.
>
> I do that with lots of custom boards.  Most are simple derivative of
> what is already there.  In fact, some have even choose the same I/O
> pins for Ethernet (there aren't many options, and most have been used :-),
> so we don't even need to add anything but another conditional on an
> #ifdef.

I'd much prefer the conditionals to test for board features rather than
specific boards. That way you _don't_ have to add another conditional on an
#ifdef every time you add a new board with existing features. In cases like
register names and bit definitions, we can even avoid the conditionals
altogether by using definitions like:

/* Ethernet : PHY controls - connected to port X
 *
 * Field        Value   Explanation
 * -----        -----   -----------
 * PHYPAUSE[x]      0   We don't support pause
 * PHYPWRDWN[x]     0   We don't support power down
 * PHYSLEEP[x]      0   We don't support sleep
 */
#define PHY_PAUSE               ((ushort) 0x0800)
#define PHY_PWRDWN              ((ushort) 0x0200)
#define PHY_SLEEP               ((ushort) 0x0040)

#define PHY_PAUSE_PORT          im_ioport.iop_pXdat
#define PHY_PWRDWN_PORT         im_ioport.iop_pXdat
#define PHY_SLEEP_PORT          im_ioport.iop_pXdat

> It's just not as easy as getting a patch and checking it in.

I appreciate your efforts co-ordinating all this. One of the reasons for
posting a patch is to stimulate discussion, and I'm interested in comments
from other people too.

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
