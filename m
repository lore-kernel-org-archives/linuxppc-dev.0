Message-ID: <37CFEDCD.ACA47B7C@jlc.net>
Date: Fri, 03 Sep 1999 11:48:29 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: Graham Stoney <greyham@research.canon.com.au>, scott@broadlink.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: GLIBC wont compile for MPC860
References: <19990903021534.8F50974A@elph.research.canon.com.au> <37CFBC84.73A8BCAA@switchboard.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> Yes definitely. I intend to submit some patches as soon.....

Thank you.  This was discussed years ago when we first started
the 8xx port, but nothing was ever done in the old libraries.
I just used to make the couple of changes in the code and compile
with the -mcpu=860 flag and post the binaries on the server.

I don't mind doing that again.  If you don't get the patches
into the general release, just put them somwhere the rest of
us can find them.

Some of us actually creating embedded applications in this space
are a little concerned with the size of glibc2, and I suspect
we will be doing some major hacking to fit some of the smaller
environments.

> ..... but this
> also means that I don't know what you should do to build a compiler that
> generates 860 code by default and also is capable of generate code for
> other CPUs.

I don't know if this is important.  Most of us are used to using the
proper flags, want to use the same compiler on our Linux/PPC Macs
as is used for the other processors.  With the new 82xx stuff
coming up now, a different set of flags are necessary, and the
compiler supports it just fine.


 
> I like the former solution. Having the compiler keep track of what
> line sizes different CPUs have is good, but forcing other user-land
> code to know this isn't nice IMHO.

Well, see the comment below.  There is some merit to using a
standard binary distribution on all processors.  I have even
attempted to pass this information from the kernel through the
run-time startup as a variable, as most people don't want the
overhead of system calls to determine this.


> Yep, I have no problem with having it a compile-time option either,
> but some people want to run standard LinuxPPC libraries and binaries
> on 8xx, so then a run-time check is needed as well.

I get lots of requests for the standard distribution libraries
to run.  I put the couple of floating point hacks in the original
port just to get past the set/long jump FP load/stores.  Some
programs will run (like the shell) but not much else.

Keep in mind that just having the library isn't enough, you have
to compile all of the programs you want to use as well.


> Speaking of FPU code, I just noticed that there is an FPU emulator
> for PPC included in Linux version 2.3.16. We really don't need that
> here, but others might find that very interresting...


That has been on and off for a long time as well.  It is there
to specifically support the 8xx (and now 8260) using standard
distribution libraries.  I am just now porting that kernel version
to the 8xx, so we'll see how it works....

Don't get any ideas about using it for much, the performance of
floating point emulation on the 8xx is pathetic, trapping into
the kernel makes it pretty useless except for supporting the
generic PPC binary distribution.  For real product applications,
I first try to avoid any floating point, and then convert anything
else to fixed point.

In general, for all of the real world products I have done
using Linux/PPC and 8xx, I use the old libc-1.99 and static
linking.  Don't forget about trying that, as it could result
in the smallest (and fastest) executables.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
