Message-ID: <384EEDC8.EDDABF3A@netx4.com>
Date: Wed, 08 Dec 1999 18:46:16 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Cache Flush and Invalidate Routines
References: <Pine.SGI.4.10.9912081721580.155726-100000@brule.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grant Erickson wrote:


> I'd like to have a kernel that will boot on any 4xx-based board (maybe or
> maybe not realistic), so because the 403 uses 16 byte lines and the 405
> uses 32 byte lines, I need a dynamic solution such as the one Gary
> suggested.

So, let's just make them kernel variables and load them.  What's
a few extra cycles here and there :-).  You just end up moving
the #defines to one of the kernel setup files......

Another alternative that requires some investigation would be
using the 16 byte line size on the 405.  My concern is there may
be alignment restrictions, but if it works all it costs you is
an extra (and ignored) cache instruction.  If this would work
on all processors (and my puke green book indicates it should),
it would be a nice modification to the C library.  Those big-assed
processors won't care if they execute a few more instructions, and
the little kids will work with caches enabled.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
