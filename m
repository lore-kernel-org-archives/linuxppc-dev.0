Date: Thu, 19 Aug 1999 16:12:58 +1000
Message-Id: <199908190612.QAA04599@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: erick205@tc.umn.edu
CC: linuxppc-dev@lists.linuxppc.org, cort@cs.nmt.edu
In-reply-to: <Pine.SOL.4.05.9908181722290.24856-100000@garnet.tc.umn.edu>
	(message from Grant Erickson on Wed, 18 Aug 1999 18:50:42 -0500 (CDT))
Subject: Re: Xmon vs. KGDB vs. KDB
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.SOL.4.05.9908181722290.24856-100000@garnet.tc.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grant Erickson <erick205@tc.umn.edu> wrote:

> Did parts of XMON make the 2.2.10 cut and others did not or was this just
> a build oversight?

I haven't pushed xmon into the official source tree since I considered
it something that wasn't very generally useful.  However others
(including Cort) have found it useful enough that we have put it into
vger, and from there it looks like it will be in 2.2.12.

> Recently, SGI released, as a patch, KDB for i386 architectures which seems
> similar in spirit to KGDB and XMON. A small chunk of KDB seems specific to
> i386 and the rest is fairly architecture neutral, so perhaps it's a good
> candidate for a unified debugger?

Possibly, I'd need to look at it.

Xmon was designed to be really simple and robust, so that it would
work even when most of the rest of the kernel was trashed.  It's
mainly intended as a way to poke around when a crash occurs and get
information on what's in memory, etc.

> It looks like Paul Mackerras and Cort Dougan have done most of the work on
> XMON. Any opinion Paul or Cort on what direction you'd like to see things
> go?

Xmon is derived from a series of ROM-based monitor programs that I
developed over the years, starting in the late 70's, when I was
working on 6809-based systems.  When I started porting linux to the
powermacs (3 years ago!) I put in xmon to give myself a simple, robust
debugging tool.

Before he checked the xmon source in to vger, Cort rewrote some of the
code which was under a BSD license (basically a printf implementation)
so that we didn't get a license conflict.  I believe he has plans to
add symbol lookup, so you can use symbolic names in xmon commands.
That's fine by me as long as xmon doesn't get any less robust,
i.e. corruption of the symbol table shouldn't cause xmon to crash.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
