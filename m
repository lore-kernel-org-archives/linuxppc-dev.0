Message-Id: <4.3.2.20000626105910.00b767f0@falcon.si.com>
Date: Mon, 26 Jun 2000 11:46:58 -0400
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: omitted kernel sections 
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20179.962030438@msa.cmst.csiro.au>
References: <Your message of "Mon, 26 Jun 2000 08:48:36 -0400" <4.3.2.20000626080626.00b482e0@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:40 AM 6/27/00 +1000, Murray Jensen wrote:

>On Mon, 26 Jun 2000 08:48:36 -0400, Jerry Van Baren
><vanbaren_gerald@si.com> writes:
> >* It isn't how everybody uses the load: everybody just strips the elf
> >header (pastes on a proprietary(?) header) and uses it as as a raw
> >binary image
>
>Here's one example of how people use the load ...

[snip]

>For the record, I support Dan's view - the way it is now, is very simple,
>and has worked fine for a long time. To me, it looks like the tools you
>are using are broken (or at least lacking certain features, namely the
>ability to load arbitrary sections from the ELF image into memory - which
>doesn't surprise me, because the JTAG stuff you mention sounds proprietary
>commercial stuff, and you always run into bugs/lack of features that you
>can't fix when you use software you haven't go the source for - sorry for
>the soapbox - you probably don't need me to tell you :-). The "loading" of
>the image (and stuff to support that) should be done outside of the kernel
>build area.

My argument is that the Makefile change simply _rewrites_ the existing
elf header to rename it from gzimage to .text.  To your tool, and
others like it, this should be a totally transparent change.  Since the
cost is nearly zero, why not help out the people with brain-dead
commercial tools?

Incidentally, I have not found an open source JTAG debugger.  There may
be ones available for other CPUs, I haven't searched yet, but they
don't exist yet for the 8260.  Part of the problem is that Motorola
requires a non-disclosure agreement (NDA) before it will tell you how
to access the CPU's innards via JTAG.  This effectively prohibits open
source short of reverse engineering it.  The CPU is too new and I
personally haven't had enough time (and likely won't in the near
future) to do this.  Macraigor supplies DLLs under windows that allow
things like gdb to drive it, but I don't believe they are open source
themselves.

On a similar note, I also have not been successful finding a 8260
flavor JTAG flash memory in circuit programmer.  The JTAG I/O chain for
the 8260 _is_ publicly documented and it would be possible to write a
JTAG based flash memory programmer that used the 8260 to wiggle the
flash pins sufficiently to program memory.  I have not needed it badly
enough yet to do that and the Macraigor folks told me they were working
on a linux version of their software which would either do it or help
me do it.  While the information for this is public, it still is a
staggering task to do "right" given all the potential combinations of
memories, even ignoring the

[snip]

>                                                                 Murray...
>--
>Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3
>9662 7763
>Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3
>9662 7853
>Internet: Murray.Jensen@cmst.csiro.au  (old address was
>mjj@mlb.dmt.csiro.au)
>

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
