Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <C08678384BE7D311B4D70004ACA371050B7632EA@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Geir Frode Raanes'" <geirfrs@invalid.ed.ntnu.no>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: custom mpc8240 student project (long)
Date: Fri, 22 Feb 2002 11:33:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Now, the parallel port is as we all know parallel.
> JTAG is, as we all know, synchronous serial.

JTAG is a four-pin protocol -- test data in (TDI), test data out
(TDO), TMS (test mode select) and TCK (test clock).  TRESET
(asynchronous reset) is an optional fifth pin.  And of course you
need at least one ground pin; more for higher clock speeds.

What happens, in the software-only solution, is that those four
pins are connected to a ribbon cable which plugs into the PC's
parallel port.  Inside the software on the PC, you just set/clear
bits, reading and writing a few bits in the byte-wide LPT/parport
interface.  No auxiliary microcontroller is required (although I
suppose Corelis et al. probably have a micro on their expansion
card).

I guess you can call the parallel port "parallel" and the JTAG
pins "serial", but that's how it works -- in software you use
just a few pins on the parallel port, and bit-bang each of them
serially.

> To interface the former to the latter, one would normally
> place a shift register with clock control inbetween. But
> ...
> ...
> ...

You've lost me here; I lack the hardware background.  Are you
perhaps suggests ways to build a JTAG hardware device?

> What I would like to know is wether this BSDL file can be used
> to reversengineer the functionality of the internal TRAP logic.
> We really don't want to do boundary scan in the true meaning of
> the words, but rather we want to do what BDM4GDB does for us on
> the XPC8xx series CPUs - control the core. I do HW, not really
> SW.

I don't know what you mean by "trap" logic.  I know that JTAG
itself is an open standard, in the sense that you can get books
on it, and if you want the official protocol document, you can
get that from the IEEE at a nominal fee.  I don't think that the
JTAG standard can be considered closed.

As for the PPC debug logic (the kind of stuff a probe plugs
into), my experience is that that is documented in the Motorola
8xx manuals.  (On the other hand, I've never attempted to control
the debug header in software, so I don't know if the manuals are
complete.  Perhaps someone can correct me on this.)

> This is all about control - the manufactures should not be
> allowed to place a NDA on this information.

IMHO, I don't think it's the *information* that's so much being
held closed.  From my experience, I don't see JTAG being in an
NDA state.  The JTAG protocol is conceptually simple; BSDL files
are published; we've written bit-bang software to flash our
boards and it does work (of course the code is time-consuming to
write, and slow to run).

> Redirecting customers to 3'd
> party vendors of debug equipment effectively means customer
> filtration. "If your are to small to afford the contiousely
> astronomical cost of 3'd party tools, then you're also too
> small for us." Need I remind you that the same melody can
> be applied to GCC and LinuxPPC vs. 3'd party too...?

Agreed.  I don't think it's a closed-information problem, but I
do believe that the current state of the marketplace (again,
IMHO; I've been doing embedded stuff for just over a year, so I'm
no expert) is that there are a few vendors out there who build
these kinds of tools and get away with charging astronomical
prices -- not because of closed *specifications* (a` la Micro$oft
& their ilk) but because no one has come up with a cheaper,
viable alternative *implementation*.  The protocols are open, but
the source is closed.

Which raises the question:  Do JTAG-tool vendors' prices really
reflect their true cost?  If so, then I wouldn't want to even
*try* to compete with them.  If not (i.e. they're getting rich
off the rest of us), then yes, I would hope that someone,
someday, *could* open-source tools like these.  By "tools like
these" I, personally, mean (a) flash programming and (b) boundary
scan for hardware verification.  & by which Geir means (c) BDM
tools.  All three are important.

& I agree that these are precisely the same arguments made in the
software world:  For example, OS's were solid gold for software
vendors -- BSD was revolutionary for even *selling* you a license
to see their source.  Everyone else thought that operating
systems were far too precious intellectual property to give away,
or even give you the slightest peek at -- enter Torvalds, and of
course the rest is history.  & people like Stallman with GCC,
Wall with Perl, and so on.

Maybe the JTAG world is ready to be similarly shaken up.

The unique problem with JTAG is that the software-only solution
is, I believe, severely limited by parallel-port data rate.  If
someone were to write and open-source a very flexible, elegant,
general-purpose BSDL-and-netlist parser which would read in some
data files & start flash programming, all without the user having
to write a single line of code -- it would still be slow.
Efficiency (I believe) requires a hardware component.

The open-source community thrives on downloadable source.  But
how do you download an expansion card?  Either (a) you
open-source the schematics, BOM, Gerber files, etc. for your card
(leaving the non-trivial assembly step to the end user), or (b)
you build them in your garage & sell them on a mail-order basis
for a reasonable fee.

A third possibility is (c) maybe the efficiency isn't a problem
-- if all you want is to open-source a software-only, and slow,
solution which can flash a boot loader into a board, to the point
where TFTP can take over.  What I do at my job is to use a tool
like Corelis to store my debug monitor (~200KB) into flash.
(Again, we can afford only the flash-programming part of Corelis.)
Once the monitor is on a given board, I rarely need to do it again.
My debug monitor includes TFTP server code, and on-board flash
programming logic written in C.  So I can then TFTP up my
zvmlinux.initrd (> 2MB) in about 30-40 seconds and, if desired,
have my debug monitor store it into flash in about about 2
minutes.  Or TFTP up a new copy of my debug monitor itself, &
re-flash that, in even less time.  So, for me at least, a
Corelis-like tool is only needed for small programs, e.g. our
monitor, or PPCBoot.

So those are the two feasability issues: (1) Can the software &
hardware really be done more affordably that what's currently on
the market?  And (2) how do you open-source hardware?  Or do
you have to?

----------------------------------------------------------------

List members:

Please excuse my having gone on at some length on this subject,
if it's not your area of interest.  However, these issues drive
to the very heart of the deepest frustrations, the most
time-consuming problems and the biggest budget headaches I've run
into in my embedded career.  The issues Geir is bringing up,
I believe, are central.

I write software not for pre-verified boards such as RPX, but for
custom-built boards designed by my co-workers.  One of my tasks
is to *be* the guy who verifies the board, mainly using our
homegrown debug-and-test monitor software.  And I've found that
issues I encounter are as likely to be hardware bugs as software
bugs.  This is brand-new for me; when was the last time you
*expected* to encounter hardware bugs programming your PC?

I've found that peeky-pokey testing can reveal many outright
hardware problems, but flaky, intermittent or irreproducible
problems are outside my current ability to diagnose.  & if I tell
my hardware-designing co-workers that I have an intermittent
problem that I can't reproduce, typically what they do is go look
at their schematics and/or VHDL code for a half an hour, come
back, and shrug: "Looks OK to me."  This is precisely where we
need (but can't afford!) automated testing.  And I don't think
I'm the only embedded programmer out there having to work with
hardware which has not yet been verified.  Most importantly, what
if you think you have a problem with your OS port, or your device
driver -- what seems to be a software problem -- and really, it's
a hardware problem which you simply hadn't found?

Once a board is known to be solid, then (& only then) can one
start to port an OS, write applications, etc.  Boundary-scan
would be useful for the board-verification phase; BDM tools would
be nice for the application phase.  & flash programming is useful
in either case.

I've found that JTAG is a very powerful thing, which (I believe)
could have saved me a lot of headaches and weeks or months of
wasted time -- except for the prohibitive cost in terms of either
time or money.  And I suspect I'm not alone in that either.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
