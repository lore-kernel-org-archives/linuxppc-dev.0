Message-ID: <3BAAB9E7.16F9ED2D@mvista.com>
Date: Thu, 20 Sep 2001 23:54:15 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: Mark Salisbury <mbs@mc.com>,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <20010920171002.37DCA2B54A@marcus.pants.nu>
	 <3BAA363B.5010400@mc.com> <8xlmj9psnw.fsf@s62.informatik.uni-bremen.de>
	 <3BAA4F46.1020002@mc.com> <p05100304b7d00bd21d35@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:

> Finally, Book E has been mentioned.

Too bad.....

> ... a TLB entry bit (bit 'E' for endian) which marks a page as
> little endian.

This has been discussed in the past and suffers from the same
problem as trying to byte swap in a bridge.  Although you can use
any load/store in this space, unless you are performing the access
on the natural size of the object it won't have the proper effect.
Since you must require that knowledge, it is just as easy to choose
the proper byte swapping variant of the instruction.

> Unfortunately, Book E does not guarantee that the 'E' TLB entry bit
> is really supported in hardware:

For all practical purposes, the engineering world is already used
to working with the advantages of a big endian processor and dealing
with the issues of accomodating little endian when necessary.  Adding
a feature like this only complicates the use of legacy software and
creates significant discussion for a feature trying to find a
problem to solve.  This feature isn't a performance enhancement,
only a detriment because it requires additional software to manage
something not natural to use.  I suspect it was just easier to write
this into the specification (i.e. it's there but not required) than
spending time discussing it's technical merit.


> But so far as I can tell, the 750, 7400, 7450, etc. are not Book E

Thankfully.

> Too bad this part of Book E wasn't in the architecture from the start...

You are one of few to feel that way.  Those of us that have worked
with PowerPC from the start, and were part of the original design
discussions, view Book E as a totally new processor that may execute
similar instructions to traditional PowerPC.  I have spoken with several
embedded product companies, a couple very large, that have huge
investments in PowerPC software that are now trying to determine
what to do.  They are quite upset that they now have to invest in
a new processor design, and it makes them likely to choose something
else.  Motorola has proven you can build some very powerful embedded
processors with the traditional PowerPC core and memory mapped I/O
peripherals, a very nice and efficient programming environment.  The
Book E appears to be a marketing vehicle put together by people that
didn't understand or appreciate the previous PowerPC architecture
specifications.  We can hope the where Book E allows variation and
extension, designers will borrow from traditional PowerPC and not
go in some other "creative" direction :-).

I'm not really saying anything new here, this has been discussed
among all of us that work on PowerPC ever since the Book E announcement
long ago.

I guess I better go looking for those m68k projects now :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
