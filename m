Message-ID: <3CB5CD07.82DEA7AD@mvista.com>
Date: Thu, 11 Apr 2002 13:51:03 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
References: <0204110308.AA27139@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> Paul Mackerras <paulus@samba.org> wrote:
>
> > A laudable goal.  I like the idea of having each platform selected
> > with a bool rather than just having a single choice of platform.
>
> So how about pushing it into 2_4_devel?

When you say push "it" are you referring to all of your changes or just the
CONFIG_GENERIC_PPC32 stuff?

If you are including the changes you made to arch/ppc/kernel/gt64269* and
arch/ppc/platforms/ev64260*, then I have some issues.  From what I can tell, it
looks like you moved much of the init functionality that was in gt64260_common and
put it into ev64260_pci.c, et. al., and got rid of the "library" routines in
gt64260_common.

IMO, this is a large step backwards.  The purpose of all the arch/ppc/*_common
files is to provide a "library" for each bridge.  They aren't perfect and one of
my TODO item over the next few months is to improve all of them but they provide
common code that initializes and supports that particular bridge.  Having these
files have played a large part in making ports to systems with MPC106/107/824x
chips, for example, much simpler and much faster.  That is the purpose of
gt64260_common.c but you just deleted it and put that code in a non-reusable,
board-specific file.

Again, this is a separate issue from the common kernel issue and bi_recs.

As far as bi_rec's are concerned, I'm waiting to see what benh produces and then
apply it to the gt/ev code (assuming Ben's patch is accepted).

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
