Message-ID: <3BF5A01D.4040502@embeddededge.com>
Date: Fri, 16 Nov 2001 18:24:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net> <20011116094210.B3473@beef.az.mvista.com> <20011116101323.B9242@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm not arguing for/against anything here, just providing some information.

Tom Rini wrote:


> That and all of the 8240 'boards' are 7xx/74xx boards which can take a
> processor 'card' of some sort, yes?


The 8240/45 60x/7xx/74xx are basically similar, as they are standard
PowerPC processor cores with standard PCI bridges.  The 7540 and later
could throw a big curve if someone decided to use the 36-bit addressing
and we wanted to implement a software TLB manager instead of HPTE.

> Not getting too off course, but what's the difference in 8240 vs 8245
> (not much, yes?) vs 8260 (different I/O, yes?).

The 8260/55 and 8xx are very different because they can be very functional
without a PCI bridge or standard peripherals.  Adding a standard PCI
bridge signficantly confuses and complicates the software configuration.
Their flexibility is very challenging to support and configure in the
software.  In some cases, the Linux software has driven hardware designs
so people can utilize existing software, but for maximum performance and
special applications you can get quite creative with the hardware design
and have to nearly write the kernel support for these processors from
scratch.  The 8xx and 8260/55 are the true embedded processors with a
powerful (in the case of 8260 :-) core and lots of highly optimized
peripherals surrounding them in a single package.  You aren't ever going
to guess right at what may be useful to someone tomorrow :-).

> I think right now, 4xx is done in a different way intentionally.

I'm not so sure :-).  I think it started off badly, is getting better,
and from these discussions we have clearly learned how to better
structure the software.  From the variety of 4xx projects I have worked
on, I'm still making the kinds of changes to better utilize and structure
existing software.  I feel like I'm doing the same thing I did years ago
with the 8xx, only back then no one cared what I was doing (because it
was some embedded stuff that didn't seem to interest anyone :-).

> ..... There's common
> ground, with hooks for board-specific stuff.

I could argue the 7xx stuff is this way as well.  Every board should probably
have a platform_init() that calls the processor architecture unique functions.
I am a little confused that there doesn't seem to be as many platform_init()
calls as there are boards we support (just 'grep for it' in the kernel
directory).  So, there is probably work to do for all boards we support.

It seems we should call some early architecture generic init functions (if
necessary), then platform init, then more general architecture functions
if necessary.

> ....  This could probably use
> more cleanup & slight changes, but I don't think it's time to scrap the
> idea.

We don't have any cohesive idea.  The 8xx and 8260 are clearly different
because a "board" is really a collection of their embedded peripherals.
The 6xx/7xx/74xx is at the other end with very dynamic configurations
based upon PCI peripherals.  The 4xx is unfortunately stuck in the middle
and each side wants it their way :-).

I guess when the dust settles I'll just merge changes again :-).

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
