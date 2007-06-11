Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 49742DDE48
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 08:51:36 +1000 (EST)
Subject: Re: [PATCH] Create add_rtc() function to enable the RTC CMOS driver
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <3e02d9714b50f74002e52153270e3e42@bga.com>
References: <3e02d9714b50f74002e52153270e3e42@bga.com>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 15:51:32 -0700
Message-Id: <1181602292.5674.291.camel@rhino>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-11 at 02:06 -0500, Milton Miller wrote:
> On Thu Jun 7 02:37:53 EST 2007, Wade Farnsworth wrote:
> 
> No changelog, just the subject?

Yes, I should have put something in the changelog.  I'll be sure to add
something in the next version.

> 
> > ---
> >
> >  arch/powerpc/kernel/setup-common.c |   31 +++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > Index: linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
> > ===================================================================
> > --- linux-2.6-powerpc-8641.orig/arch/powerpc/kernel/setup-common.c
> > +++ linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
> 
> A driver specific ifdef in setup-common?
> 
> Please put this in a file in sysdev.   Possibly linked on the config 
> with the existing ifdef, if you can't find a related file.

Sure.  I can't find a suitable existing file in sysdev to put this in,
so I'll just create a new one called "rtc_cmos_setup.c" or similar.  If
anyone has a better name, please speak up.  :)

> 
> > @@ -32,6 +32,7 @@
> >  #include <linux/unistd.h>
> >  #include <linux/serial.h>
> >  #include <linux/serial_8250.h>
> > +#include <linux/mc146818rtc.h>
> >  #include <asm/io.h>
> >  #include <asm/prom.h>
> >  #include <asm/processor.h>
> > @@ -447,6 +448,36 @@ static __init int add_pcspkr(void)
> >  }
> >  device_initcall(add_pcspkr);
> 
> Oh, we already did this with the pc speaker?
> 
> I stand by my first impression.  Although one could argue its similar 
> in scope to check_legacy_io_port, probe_machine is totally unrelated 
> and between pc speaker and check legacy io port.  At least the grouping
> of these functions in the file should be cleaned up.

Yeah, I was following the (bad?) example of the pc speaker.  sysdev is
probably a better place for this.

> 
> 
> > +#ifdef CONFIG_RTC_DRV_CMOS
> > +static int  __init add_rtc(void)
> > +{
> > +       struct device_node *np;
> > +       struct platform_device *pd;
> > +       struct resource res;
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "pnpPNP,b00");
> > +       if (!np)
> > +               return -ENODEV;
> > +
> > +       if (of_address_to_resource(np, 0, &res)) {
> > +               of_node_put(np);
> > +               return -ENODEV;
> > +       }
> > +
> 
> Ok you have found a resource, but not mapped it.

The resource gets mapped by platform_device_register_simple().

> 
> > +       pd = platform_device_register_simple("rtc_cmos", -1,
> > +                                            &res, 1);
> > +       of_node_put(np);
> > +       if (IS_ERR(pd))
> > +               return PTR_ERR(pd);
> > +
> > +       /* rtc-cmos only supports 24-hr mode */
> > +       CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_24H, RTC_CONTROL);
> > +
> 
> But now you invoke a macro from somewhere, which would appear to write 
> to the device.   Probably with some hard-coded isa port, as it doesn't 
> take any obvious device or resource argument.
> 
> Is this writing to the legacy io port?   What mapped that resource?

Yes, this uses the legacy io ports hard-coded. in asm/mc146818rtc.h
(0x70 is the address port 0x71 is the data port).

> 
> If the driver only works with the standard port, then should you check 
> the resource is that standard port?  Or does the compatibility also 
> dictate the resource, in which case assigning the resource is 
> redundant.

The rtc-cmos driver also invokes CMOS_READ() and CMOS_WRITE(), so it
will only work with devices on the standard ports.

I don't know if the OF spec defines the ports for the device, so it may
be a good idea to, as you suggest, check to see if the hard-coded port
and the resource match.


> This is after the device register, so the platform driver might think 
> it owns the device.   Or it my be off doing its own initialization.  Or 
> the driver subsystem may have requested the platform device be loaded, 
> and it has not run at all (assuming it can be a module for the moment).

Maybe this should be changed to an fs_initcall, so that we can be sure
it is run before the driver's initialization.

Thanks for the comments.

--Wade
