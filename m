Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 5B55C67D34
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:13:40 +1100 (EST)
In-Reply-To: <2B135C85-9FF6-435E-975B-D0D3E7ACFF5B@kernel.crashing.org>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>	<1165890570.11914.5.camel@localhost.localdomain>	<457F1F6E.4020502@freescale.com>	<1165960058.11914.72.camel@localhost.localdomain>	<7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>	<20061212162416.06f0dd76.kim.phillips@freescale.com>	<A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>	<457F2FE1.1080308@freescale.com>
	<513E2628-5785-4100-9E83-986990E06DF5@kernel.crashing.org>
	<457F8EC3.60201@freescale.com>
	<2B135C85-9FF6-435E-975B-D0D3E7ACFF5B@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1816B48E-3ABB-49C1-9D64-588F5B1C1492@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Wed, 13 Dec 2006 16:13:48 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 13, 2006, at 1:07 AM, Kumar Gala wrote:

> My question has been what's the value in trying to save a few lines
> of code for the reference boards.  The idea of a generic board
> doesn't make sense in the embedded space.

This grand unification of embedded board software just
isn't useful.  It's a waste of time for the reference board
developers that should be writing useful device drivers
for the SOC peripherals, and also for those of us trying
to develop real products.  I spend way too much time
trying to find configuration options or other indirect
function hooks so the special functions I need to be
performed are done properly.

The current 85xx is a pretty good implementation.
Things that are truly generic are provided as functions
that the individual board port initialization files/functions
can use as needed.

> ....  The majority of developers dont have the time
> to spend trying to come up with one to solve their specific problem
> so they hard code some solution that works for them.

Don't make it sound like some "hard code" hack :-)
We just have to write software to support all of these
unique product designs.  Many of these boards have
custom external hardware than needs to be controlled
with some special configurations or algorithm.  There
are just times I have to toggle a set of GPIOs with a
particular algorithm, for example.  This was my comment
about "generic" board ports and device tree a while
ago.  The device tree is just an information data base,
it doesn't help me when I really have to write some code
that is unique to a board.

If you want to make similar Freescale boards utilize
common code, that's great.  Don't assume any product
will look like one of these boards, no matter how much
you want people to do that.  In almost all cases, they
aren't even close due to other product design requirements.

All of these efforts to "help" us develop products by
providing generic board ports with the goal of a single
kernel on multiple boards actually costs us development
time due to the lack of flexibility we need.  We just need
a library of generic functions, and then 50 to 100 lines of
"board support" initialization that will initialize custom
hardware, data structures, variables, and then call the
more generic functions.  There may be only very minor
differences between the board files, but this simplicity
is much nicer than complex indirect paths to enable
features with cute #defines or other complicated
data structures.

Thanks.

	-- Dan
