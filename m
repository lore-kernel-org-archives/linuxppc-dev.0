To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx MMU Table Walk Base (was Re: kernel crashes at InstructionTLBMiss ) 
In-reply-to: Your message of "Mon, 05 Jun 2000 16:37:55 -0400"
             <393C0FA3.9208BAE1@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 06 Jun 2000 16:31:08 +1000
Message-ID: <23333.960273068@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 05 Jun 2000 16:37:55 -0400, Dan Malek <dan@netx4.com> writes:
>Murray Jensen wrote:
>
>> Here we come to a dilemma that I have had since I started with this stuff.
>> I have never been able to get an 8xx kernel running without adding a patch
>> to update the Table Walk Base register at the time that a new mm context is
>> activated.
>
>
>After reading your diatribe

Diatribe? Hmm.. Sorry, I didn't mean to offend you - I thought I was being
reasonably clear, and definitely polite. I wasn't being at all critical of
anyone associated with Linux/PPC or the 8xx embedded version - I think you
and they all do a great job, and I am very impressed. In my eagerness I left
out some information I should have provided, sorry. I will try to correct
that now.

I use the linuxppc_2_3 bitkeeper repository at hq.fsmlabs.com as the
base for my local changes. I use a Sun Ultra 60 dual cpu sparc workstation
running Solaris 2.7 as my host o/s, with gcc-2.95.2, the latest binutils from
the CVS repository at :pserver:anoncvs@anoncvs.cygnus.com:/cvs/src, and
glibc-2.1.3 configured as an mpc8xx cross-compiler for Solaris. I build
my own root filesystem, based on sources from the net. When I compile the
kernel, I build zImage.initrd and download it to the target using the GDB
protocol via a serial port.

My hardware is a Cogent CMA102 motherboard, with CMA286-60 CPU module
(MPC860 cpu - rev no. XPC860MHZP66C1), and CMA302 I/O module with 8Mb
flash. The motherboard has 32Mb RAM, 2 serial and 1 parallel ports, and
LCD display. The cpu module has a 128K boot eprom, which I load with a
small ROM monitor I wrote based on the GDB eprom stubs configuration of
eCos (embedded cygnus operating system - which supports the cogent
platform). The monitor supports downloading via the serial port (at
230400bps) into RAM using the GDB protocol, programming flash from a
RAM image, and booting an image that resides in flash, among other
things (I call it ELILO :-).

Modifications I make to the kernel are minimal - just drivers for devices
on the cogent platform (including the I/O mappings, which are different
to the MBX in that they reside in the lower half of the address space which
required me to use ioremap() correctly by setting ioremap_base and saving
its return value and using this to access my devices) and some other minor
changes, which I believe are not relevant. The only major change I have had
to make to the kernel is the one I discussed in my previous message.

I checked this out again, and one other change was moving most of the code
at _start in head_8xx.S to after the exception handlers because the extra
mappings required for the Cogent devices caused this code to exceed 0x100
bytes. The other thing I added was making use of the MPC860 watchdog
which I could do because I had control of the boot eprom code (if the
kernel hangs I get a watchdog reset in some circumstances, depending
on the type of hang).

>There are many subtle changes to context switching that happen during
>the minor updates (which could be weekly).

I usually update daily, or every couple of days, a local copy of the
bitkeeper repository (using rsync, but I also maintain a read-only
anonymous bitkeeper clone which I bk pull at the same time, because I
like to use bk sccstool to follow the changes), which I then "import"
into a vendor branch of a local CVS repository. My local changes are
maintained in the HEAD revision. I also maintain a "stable" branch
which is a working kernel, based on repository as at October 1999.

>There are several patches
>floating around (and probably more kernel sources) that certainly
>are not correct.

I don't use any patches from the net - all changes made are local.

>I don't know where you get your source code, but there
>are exactly two consistent and working kernel sources that I have ever
>provided.  One is in ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded,
>the mpc8xx-2.2.13.tgz tarball.  A better and completely up to date
>kernel is in ftp.mvista.com/pub/CDK/wip/ppc_8xx/RPMS (along with
>everything else to build an 8xx embedded system).  Everyone should be
>using the kernel from MontaVista, and if something isn't in there
>that you want, send me patches against that.

These are all 2.2.x, no? I believe I need 2.[34].x because I want to use
the latest RT-Linux stuff eventually, which only works with the 2.3.x, or
later, kernels.

>There are patches posted against that original tarball, and make sure
>you are not mixing kernel versions and patches.

As I say, I use a pristine 2.[34].x kernel with local changes only.

>Finally, lots of bugs associated with porting to new hardware manifest
>themselves as "problems" in any VM related function.  Since many people
>don't understand the subtle interactions of all of these functions (as
>evidenced by your message) you become convinced the problem is associated
>with this complexity and fail to unravel the clues to the real cause.

I don't think I deserve this sort of belittling. Treating potential
contributors in this way can only have a negative effect on open
source development. I admit I don't yet fully understand the PowerPC
architecture, or the MPC8xx implementation of it, but I am learning,
and with nearly 20 years experience in computer science I believe I
should be able to pick it up eventually (I've "seen it all before" :-).

>This could be as simple as intrusive debugging hardware,

I use kgdb.

>some silicon
>bug not understood,

I included my chip revision above. It appears to be a C1 revision chip.

>or prototype hardware not working correctly.

Definitely.

>There are lots of products and systems in development running this software,
>so you have to approach this generic software from the assumption that
>it is first likely to be working.

I did. I said I was intrigued as to why this problem only affected me. And
once I make the described change, the "generic software" works for me also
(at least an older revision works - current revisions still crash, something
to do with the memory allocation stuff, I believe).

As I said in my previous message, I suspect something else I am doing is
triggering this bug (that much is obvious), but there are two possibilities:
either I am doing something wrong in my local changes, or the "generic
software" has a bug which does not show up in anyone else's implementation. I
was wondering whether the latter was the case (I wasn't blaming anyone, I was
excited that maybe I had discovered a long existing hidden fault in the
software, that may explain some mysterious failure modes, that someone else
might be getting - other developers may then post, saying "yeah, that would
explain my problem, blah blah", and so the discussion goes on. Upon searching
the archives, I found that a similar problem had been discussed for the 2.2.x
kernels, so maybe the fix or fixes didn't make their way into the 2.[34].x
kernels. I don't know, anything is possible, that's why we have these
discussion groups).

>Are there possible bugs?  Sure, and you have to provide minimal information
>for the rest of us to help out.

Again, apologies for not providing enough information in my message - I made
assumptions I shouldn't have. Obviously, on my first post I should have been
completely anal, because no-one knows me from a bar of soap. I can then start
to be less exacting after I have been around for a while.

>Where did you get the sources? What
>patches did you apply?  What are your hardware details?  What
>modifications did you make?

See above.

>As for 2.4.xx, the 8xx still doesn't work correctly.  However, I
>discovered it failed to work after the 403 additions, so I am now
>learning about the 403 in an effort to make everything live happily
>together again.

It was my feeling that the problems were to do with the new memory allocation
stuff introduced a couple of months ago.

>Note, this has nothing to do with M_TWB......

I know. Now that we have gotten past treating me like a dill, please can you
re-read my original message and see if I am making any sense at all? I would
very much appreciate some insights and even constructive criticism. Cheers!
								Murray...

PS: I haven't contributed the Cogent platform changes yet, because I wasn't
happy that I had done everything properly. This was really my first foray
into taking part in the Linux/PPC embedded development community - I can't
say it has been particularly successful (despite my good feelings about
contributing a small fix a couple of days ago). I will try not to be too
discouraged.
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
