Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 6CCF567B1F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 03:49:38 +1000 (EST)
Date: Thu, 7 Apr 2005 10:49:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050407174936.GR3396@smtp.west.cox.net>
References: <424ACFF1.5000403@bitsim.se>
	<111d2ae873d1bfee413409dfc4f2f064@freescale.com>
	<424BEDFC.8080300@jonmasters.org>
	<1112284541.23088.77.camel@cashmere.sps.mot.com>
	<4250EACF.1040403@bitsim.se> <42511D55.4040507@ru.mvista.com>
	<20050407172003.GP3396@smtp.west.cox.net>
	<1112895351.11987.89.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112895351.11987.89.camel@cashmere.sps.mot.com>
Cc: Jon Masters <jonathan@jonmasters.org>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Jakob Viketoft <jakob.viketoft@bitsim.se>
Subject: Re: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys
	model...]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2005 at 12:35:51PM -0500, Jon Loeliger wrote:
> On Thu, 2005-04-07 at 12:20, Tom Rini wrote:
> > Part of the point of this is to move to a defined interface :)
> 
> I've extracted a defined interface for the _current_ bd_t
> structure so far.  I'm telling you, you're not going to
> like it... :-)
> 
> So what do you want to do with it?  Specifically, my tree
> is in this state:
> 
>     - I have made two files, a .c and a .h that contain
>       essentially a grand-union of all of the bd_t and 
>       board_info structure definitions that I could find.
> 
>     - I have introduced shim function definitions that are
>       simple accessor functions to front the common structure
>       definition.

It sounds like a start certainly.

> It is semi gross in that this file contains a plethora of
> #ifdef messes that span multiple PPC32 boards and architectures.
> Whereas these used to be nicely distributed (:-)) they are
> all gathered into one place that clearly demonstrates a 
> few things:
> 
>     - This is wrong and needs to be cleaned up more :-),
> 
>     - Obvious refactoring for common functionality that
>       is NOT board-specific is still needed,
> 
>     - There are 51 unique fields in all the bd_t defs.

The vauge idea was that we would contruct the flattened tree, somehow
along the lines of
cat totally_common.txt > tree.txt
cat cpu_specific.txt >> tree.txt
cat board_specific.txt >> tree.txt
... autogen a header, or whatever ...

But basically yes, we should and must refactor things a bit so that,
ideally, a new 440GX-based platform would just need to supply its own
board_specific.txt (or whatever) and get the rest of the truely common
bits easily.

And ideally, a lot of the generation code can be shared between
kernel/U-Boot/whatever.

> I am currently proving that various platforms still build.
> I'm not going to be able to run-test any boards except
> a limited few.
> 
> I will happily supply a diff of my messings to the list or
> a few individuals who want it.

Please post to the list as an RFC.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
