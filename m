Message-ID: <393C0FA3.9208BAE1@embeddededge.com>
Date: Mon, 05 Jun 2000 16:37:55 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
CC: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx MMU Table Walk Base (was Re: kernel crashes at
 InstructionTLBMiss )
References: <21966.960193171@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> Here we come to a dilemma that I have had since I started with this stuff.
> I have never been able to get an 8xx kernel running without adding a patch
> to update the Table Walk Base register at the time that a new mm context is
> activated.


After reading your diatribe perhaps I should provide a little information.
There are many subtle changes to context switching that happen during
the minor updates (which could be weekly).  There are several patches
floating around (and probably more kernel sources) that certainly
are not correct.  I don't know where you get your source code, but there
are exactly two consistent and working kernel sources that I have ever
provided.  One is in ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded,
the mpc8xx-2.2.13.tgz tarball.  A better and completely up to date
kernel is in ftp.mvista.com/pub/CDK/wip/ppc_8xx/RPMS (along with
everything else to build an 8xx embedded system).  Everyone should be
using the kernel from MontaVista, and if something isn't in there
that you want, send me patches against that.

There are patches posted against that original tarball, and make sure
you are not mixing kernel versions and patches.

Finally, lots of bugs associated with porting to new hardware manifest
themselves as "problems" in any VM related function.  Since many people
don't understand the subtle interactions of all of these functions (as
evidenced by your message) you become convinced the problem is associated
with this complexity and fail to unravel the clues to the real cause.
This could be as simple as intrusive debugging hardware, some silicon
bug not understood, or prototype hardware not working correctly.

There are lots of products and systems in development running this software,
so you have to approach this generic software from the assumption that
it is first likely to be working.  You seldom hear from those people.
Are there possible bugs?  Sure, and you have to provide minimal information
for the rest of us to help out.  Where did you get the sources? What
patches did you apply?  What are your hardware details?  What
modifications did you make?


As for 2.4.xx, the 8xx still doesn't work correctly.  However, I
discovered it failed to work after the 403 additions, so I am now
learning about the 403 in an effort to make everything live happily
together again.  Note, this has nothing to do with M_TWB......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
