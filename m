Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3121D67AC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 03:36:24 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050407172003.GP3396@smtp.west.cox.net>
References: <424ACFF1.5000403@bitsim.se>
	<111d2ae873d1bfee413409dfc4f2f064@freescale.com>
	<424BEDFC.8080300@jonmasters.org>
	<1112284541.23088.77.camel@cashmere.sps.mot.com>
	<4250EACF.1040403@bitsim.se> <42511D55.4040507@ru.mvista.com>
	<20050407172003.GP3396@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1112895351.11987.89.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 07 Apr 2005 12:35:51 -0500
Cc: Jon Masters <jonathan@jonmasters.org>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Sylvain Munaut <tnt@246tNt.com>, Jakob Viketoft <jakob.viketoft@bitsim.se>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
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

On Thu, 2005-04-07 at 12:20, Tom Rini wrote:
> Part of the point of this is to move to a defined interface :)

I've extracted a defined interface for the _current_ bd_t
structure so far.  I'm telling you, you're not going to
like it... :-)

So what do you want to do with it?  Specifically, my tree
is in this state:

    - I have made two files, a .c and a .h that contain
      essentially a grand-union of all of the bd_t and 
      board_info structure definitions that I could find.

    - I have introduced shim function definitions that are
      simple accessor functions to front the common structure
      definition.

It is semi gross in that this file contains a plethora of
#ifdef messes that span multiple PPC32 boards and architectures.
Whereas these used to be nicely distributed (:-)) they are
all gathered into one place that clearly demonstrates a 
few things:

    - This is wrong and needs to be cleaned up more :-),

    - Obvious refactoring for common functionality that
      is NOT board-specific is still needed,

    - There are 51 unique fields in all the bd_t defs.

I am currently proving that various platforms still build.
I'm not going to be able to run-test any boards except
a limited few.

I will happily supply a diff of my messings to the list or
a few individuals who want it.

jdl
