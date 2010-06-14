Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id 0068DB7D5C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 05:40:21 +1000 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008;
	32bit))
	with ESMTP id <0L40000MTRZ7LSC0@VL-MH-MR003.ip.videotron.ca> for
	linuxppc-dev@ozlabs.org; Mon, 14 Jun 2010 15:40:20 -0400 (EDT)
Date: Mon, 14 Jun 2010 15:40:19 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: Request review of device tree documentation
In-reply-to: <4C1672FF.3060407@firmworks.com>
Message-id: <alpine.LFD.2.00.1006141432530.13427@xanadu.home>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop> <1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com> <1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org> <4C165FD1.6080505@firmworks.com>
	<alpine.LFD.2.00.1006141311580.13427@xanadu.home>
	<4C1672FF.3060407@firmworks.com>
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jamie Lokier <jamie@shareable.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 14 Jun 2010, Mitch Bradley wrote:

> Nicolas Pitre wrote:
> > On Mon, 14 Jun 2010, Mitch Bradley wrote:
> > 
> >   
> > > First, the primary use case for "keeping OFW alive" is for debugging
> > > purposes.
> > > OFW remains resident in memory so that, if the OS is set to allow it (not
> > > the
> > > default), a hot-key freezes the OS and enters OFW, where a human can
> > > inspect
> > > the state of devices and OS data structures. A high skill level is
> > > required,
> > > so it's okay if some fiddling is necessary to find or establish virtual
> > > addresses or do similar magic .      
> > 
> > Why would you impose such pain on yourself in order to try to make OFW a
> > viable debugging tool on ARM for live kernels, while you can achieve the
> > same and more much less intrusively and so much more safely with a JTAG
> > based debugger?
> > 
> > If the cost of a JTAG solution is a concern, you can order USB based JTAG
> > dongles on the net for less than $30 and use them with OpenOCD[1].
> >   
> 
> If OFW is present on the machine, when a customer reports a problem I 
> can tell them to do x and y and z and tell me what they see.  In this 
> manner, I have often solved difficult problems in minutes or hours.

That's assuming OFW is still intact somewhere and unaffected by said 
problem.

> Arranging for a JTAG dongle to appear at the customer site, then 
> getting it set up and the necessary software installed and configured 
> on a suitable host system, typically requires several days at best, 
> plus potentially a lot of fiddling depending on what sort of host 
> system the customer happens to have.

Well, if I may use the SheevaPlug as an example, the actual FT2232 chip 
currently used in most of those USB-JTAG dongle was provided directly on 
the board.  So you have this standard mini-B type USB connector on the 
side of the device from which you get both a serial console and a JTAG 
interface.  All you need is a standard USB cable, just like the one you 
get with a MP3 player or a digital camera, so there are plenty of those 
around.

Software wise, people have provided self contained packages containing 
OpenOCD, the necessary recovery binary images, and a script to bind it 
all into a nice debricking utility for when you blow your flash content 
away.

Oh and OpenOCD runs on Linux, Mac OS as well as Windows.

So there are ways to customize things and make this really straight 
forward to users.  But in the SheevaPlug case this ease of use was also 
planned further by integrating easy JTAG access into the hardware 
design.  And a couple other ARM boards out there are doing the same 
thing too.

> The phrase "impose such pain on yourself" presupposes that the 
> technical challenges are much harder than they actually are.  In fact, 
> most of the pain comes from dealing with the "yuck, why would you ever 
> want to do that" argument.  I first experienced that argument in 1982, 
> when Tom Lyon - Sun's Unix driver expert at the time - threatened to 
> "scratch my disk" if I ported Forth to the Sun 1 machine.  Tom later 
> recanted and said that he was very glad that I had done so, after I 
> used it to solve several stop-ship problems that came close to killing 
> the company.

Sure. Pioneering solutions to save your life is always worth the pain.  
But in this case some solutions were already developed and in use today.  
So all you'll be doing here is sort of reinventing the wheel with the 
only major benefit that it is a wheel that you're familiar with, while 
the rest of the crowd is using another one already.

> > Otherwise, what's wrong with already supported kgdb, or even kdb?
> > 
> > [1] http://openocd.berlios.de/web/
> >   
> 
> Requires setup.  The power of "it's just there, flip a switch to turn 
> it on" has to be experienced in the heat of battle to be appreciated.

Sure... when 1) the switch does still work even after damage was 
incurred, and 2) you have someone on-site with the appropriate knowledge 
for it.

> The other difference is that conventional debuggers focus on the problem of
> inspecting and controlling the execution of preexisting programs, instead of
> on the problem of constructing quick tests to test hypotheses.  While it is
> possible to use them to "poke around", it quickly becomes cumbersome if you
> need to do anything more complicated than just looking.  OFW's built-in
> programming language is particularly well suited for making little test loops
> on-the-fly.   

Just for completeness, OpenOCD is not itself a debugger.  It is a mean 
to provide a GDB remote debugging interface amongst other things.  It 
has its own interface that can be used autonomously, and if I'm not 
mistaken there is even a web interface to it.  And OpenOCD can be 
scripted (it contains a TCL interpreter).  So you can do all sorts of 
things with it.  The most popular usage is to reflash a hosed system.

I even saw someone use a modified OpenOCD version to wait until the CPU 
entered a particular function, have it single-stepped, and get 
statistics on cache hits and misses on a per assembly instruction 
granularity.  You just can't get that sort of info with software 
solutions running on the target as that screws up the results, nor with 
an emulator as it is usually too slow to emulate some real life 
situations.

> Also, OFW has drivers for most of all of the system's hardware, and 
> those drivers are independently developed from the Linux drivers.  
> That often serves as a valuable "second opinion" to help discover the 
> root cause of hardware misbehavior.

Sure.  I think this is a valid case, although it is quite a stretch to 
have a duplicate set of drivers there "just in case" and expect them to 
take over _live_ without skewed results.  You usually want to reboot 
into that other environment to perform your validation test, not to 
hijack the hardware from under the running OS, fiddle with it, and give 
it back to the OS hoping that everything will continue to go well.

Furthermore, those independently developed drivers are not the best 
utilization of resources.  You will hardly find people willing to 
re-implement something that already exists out there.  And if they have 
to do it once, they'll do it for Linux directly.  That's why ideas such 
as using Linux as a bootloader to boot Linux are becoming more popular.  
Even U-Boot is leveraging Linux for a lot of driver code.  Otherwise 
those duplicated drivers are simple versions for bootloader purposes 
with no similar concerns about concurrency and performance you typically 
find in a full fledged OS.

There is even a trend amongst hardware vendors to converge around 
"standardized" hardware interfaces for many class of devices, so they 
even don't have any, or very little, driver development to do.

So yes, in theory, this "second opinion" from independently developed 
drivers would be quite useful.  But in practice this is rarely 
affordable.


Nicolas
