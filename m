Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 5E0D62BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 06:42:59 +1000 (EST)
Date: Fri, 8 Oct 2004 13:42:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20041008134250.A15724@home.com>
References: <E1CFESm-0002PH-00@real.realitydiluted.com>
	<4165E52E.60908@waitefamily.us>
	<20041008111345.GA23212@linux-mips.org>
	<1097234203.318.89.camel@hades.cambridge.redhat.com>
	<20041008122633.C17999@flint.arm.linux.org.uk>
	<4166D5E7.8080209@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4166D5E7.8080209@mvista.com>;
	from mgreer@mvista.com on Fri, Oct 08, 2004 at 11:01:11AM -0700
Cc: Brian Waite <brian@waitefamily.us>, lachwani@pmc-sierra.com,
	Ralf Baechle <ralf@linux-mips.org>, mdharm@momenco.com,
	linuxppc-embedded@ozlabs.org, sjhill@realitydiluted.com,
	David Woodhouse <dwmw2@infradead.org>, rabeeh@galileo.co.il,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: OCP vs. platform_device (was Marvell 64360/64340 GigE driver
	for MIPS and PPC....)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 08, 2004 at 11:01:11AM -0700, Mark A. Greer wrote:
> Moving to a wider PPC audience...
> 
> Mark
> --
> 
> Russell King wrote:
> 
> >On Fri, Oct 08, 2004 at 12:16:43PM +0100, David Woodhouse wrote:
> >  
> >
> >>On Fri, 2004-10-08 at 13:13 +0200, Ralf Baechle wrote:
> >>    
> >>
> >>>I was already considering to implement something like OCP for MIPS also.
> >>>Since it already exists on PPC I instead would suggest to move
> >>>arch/ppc/syslib/ocp.c into generic code, something like drivers/ocp/
> >>>maybe?
> >>>      
> >>>
> >>Fine... but if you're doing that instead of extending platform_device to
> >>meet your needs, make sure you remove platform_device while you're at it
> >>and convert its users to OCP.
> >>    
> >>
> >
> >There are a lot of users of platform devices, and this now includes
> >virtually everything in the input layer.  This would be a very large
> >amount of work to rip out platform devices.

<snip a bunch of valid points>


> >So I think ripping out platform devices and throwing in something
> >which is very different is a backwards step.

As I've mentioned a couple time now on #mklinux, we should be
moving to platform_device on PPC.  When I moved OCP forward from
2.4 it was because a bunch of work was done to fix it up there
by BenH and the 4xx stuff had been using it for a long time before
platform_device was around. There's a bunch of "backend" type info
that is PPC subarch specific that is encoded in the .additions field
of the OCP defs that can be moved to the platform_data field.  That's
really where most of the important stuff for OCP is at.  We really
just need somebody with time to convert all the subarches to add 
platform_devices and drivers to gather info from them. I may or
may not have time to accomplish this myself in the near future.
 
The point here is that I'm 100% behind converting from ocp_device
to platform_device as long as whoever does it preserves the
rest of the functionality (which should mostly can accomplished
by moving the additions info to platform_data. Maybe it's only
4xx that needs this so other PPC subarches can convert possibly
with a little less work.

-Matt
