Message-ID: <3CB5DF9D.55A3EF95@mvista.com>
Date: Thu, 11 Apr 2002 15:10:21 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
References: <0204112051.AA29511@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> I have replaced gt64260_common.c with gt64260_data.c and gt64260_utils.c so
> that one can choose to use the utility functions for non-OF non-StarMON boards
> or not use them for good OF/StarMON, but still always have the crucial global
> variables.
>
> <snip>
>
> Then fine, keep that library and use it for your ports to your heart's delight.
> Just please let HEC ports not use it.

You never _had_ to use the gt64260_common code if you didn't want to.  Its just a
library of stuff there to be used (but I would expect most if not all boards with a
gt64260 to use many of the functions in it).  If you don't want to, that's fine.

My issue is that your gt64260_utils.c doesn't have a lot of functionality that
_common.c does.

I guess I still don't know what you want.  Do you want your _data.c and _utils.c pushed
too or instead of _common.c?  Either way, why not use the functions that are already in
_common.c instead?  If that functionality isn't there, add it.  If its the size of
gt64260_common.c, then it can be broken up.  I would already like to move the
find_bridges, bridge_init, and check_errata routines into their own file.  Doesn't
reduce the size that much but it splits it up a little so you can not link the .o file
with find_bridges, etc code if you don't want it, for example.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
