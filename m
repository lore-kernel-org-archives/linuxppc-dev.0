Date: Fri, 13 Aug 1999 11:51:53 +1000
Message-Id: <199908130151.LAA31102@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: dgatwood@mvista.com
CC: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
In-reply-to: <Pine.LNX.3.96.990812115345.25431A-100000@mvista.com>
	(dgatwood@mvista.com)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.96.990812115345.25431A-100000@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood <dgatwood@mvista.com> wrote:

> No, that's not the only argument.  eieio and... isync, I think... causes
> the PPC 601 to shift one of its registers a few bits and send out an
> address only transaction using the address that results from that.  I

I can understand eieio causing an address-only transaction, but the
address should just be ignored.

> can't remember which register off the top of my head.  MkLinux ran into
> this in the late Pre-DR3 stage and it nearly cost us a large percentage of
> x100 support do to a hardware bug that can cause the machine to hang if an
> address only transaction is done into certain parts of the address space.

Hmmm, I didn't see any such problems with the 7200 and 7500 powermacs,
which have a 601 cpu.  It's a hardware bug in the x100's memory
controller or nubus bridge, right?  I guess it's lucky you actually
have some control over the address that gets put out. :-)

> The workaround is a really nasty bunch of code that creates a sizable
> performance hit by forcing that register to be cleared before the eieio
> and restored afterwards.  As a result, putting eieio in those macros will
> have a _very_ major performance hit if yuo ever start supporting x100

Surely it should only take a couple of cycles to move a register to
another and clear it?  I agree it's a pain though.  Actually, with gcc
the asm statement that uses the eieio could just specify the register
(which one is it?) as an input and give it the value 0.

I think a resolution of this issue is going to have to involve Linus
and the whole Linux community.  We may need two forms of the bus
access macros, one with the eieio's and one without.  I think the
`ordinary' form should have the eieio's, though.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
