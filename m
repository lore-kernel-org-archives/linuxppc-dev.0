Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 0F7B02BDB6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 04:21:52 +1000 (EST)
Message-ID: <4166D659.9070008@mvista.com>
Date: Fri, 08 Oct 2004 11:03:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
References: <E1CFESm-0002PH-00@real.realitydiluted.com>
	<4165E52E.60908@waitefamily.us>
	<20041008111345.GA23212@linux-mips.org>
	<1097234203.318.89.camel@hades.cambridge.redhat.com>
	<20041008122633.C17999@flint.arm.linux.org.uk>
	<4166D5E7.8080209@mvista.com>
In-Reply-To: <4166D5E7.8080209@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Forwarding to a wider PPC audience...

Mark
--

Dale Farnsworth wrote:

On Fri, Oct 08, 2004 at 08:25:18AM -0400, Brian Waite wrote:

>> Just because I am a bit unclear as to what the concensus let's outline again 
>> the alternative as I see them and see which makes the most sense.
>> 
>> 1) Move ocp to generic code and move MIPS to ocp.
>>  - Not good because there are too many uses of platform_devices and ocp 
>> appears to be an inadequeate solution
>> 
>> 2) Move PPC, or at least Marvell PPC platforms, to the platform_device. 
>>  - I think the above argument can apply.
>> 
>> 3) Keep MIPS on platform_device and PPC on ocp and provide glue logic to stick 
>> either interface to the ethernet driver.
>>  - Not the cleanest solution as it still keep 2 independent interfaces that 
>> essenitally do the same thing in the tree, but it hurst everyone the least 
>> amount to make work.
>> 
>> Of those three options, I am thinking 3 is the way to go. If we can agree on 
>> that then we can start working out the details.
>  
>

I prefer a variation on option 2.  Only support platform_device on the
Marvell ethernet driver and support both OCP and platform_device drivers
on Marvell PPC platforms.

When I added ethernet support for redwood5 and redwood6 in 2.6, I used
the arm smc91x driver, which has a platform_device interface.  I found
it easier to add the platform_device calls to the redwood platform
files than to add an ocp interface to the smc91x driver.  Check out
arch/ppc/platforms/4xx/redwood5.c for a simple platform_device example.

More important than ease of implementation is that I think OCP has
already lost out to platform_device.  (I raised a ruckus on #mklinux
a few months back when I suggested this. :-)  As others have said,
they perform essentially the same function* and platform_device is
already supported in multiple architectures.  OCP must die, but I
prefer a slow death. :-)  We can transition from supporting OCP to
platform_device one driver at a time, by having platforms support
both during the transition.

This doesn't mean I'm thrilled with platform_device.  Shoehorning
everything into a struct resource is ugly.  I also think it needs
to better describe device hierarchies (which OCP doesn't do today
either), which will be a major change.  But platform_device is as
good as OCP now.  The pros and cons between them are nits, trumped
by platform_device's cross-architecture support.

-Dale

* BTW, for the PPC folks, I also think bi_recs and the OF device tree
serve nearly the same function.  IMHO, we should use the same mechanism
to pass device info to the kernel that the kernel uses to pass device
info to the drivers.  But that's extraneous to this discussion, and I'm
not proposing that we do anything on this now.
