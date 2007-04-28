Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 70F21DE0AB
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 12:40:30 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 27 Apr 2007 19:40:27 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070428024027.GA4133@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704261704.06790.arnd@arndb.de>
	<20070427235040.GA29498@xyzzy.farnsworth.org>
	<200704280305.26312.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704280305.26312.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 28, 2007 at 03:05:25AM +0200, Arnd Bergmann wrote:
> > This is a very OF-centric proposal.  IMHO it's a mistake for drivers
> > to call of_get_property().  There should be a firmware-independent
> > way of passing parameters to drivers.  I'm not a big fan of the
> > details of platform_device, but at least it's firmware independent.
> > I think it's a layering violation even when ppc-only drivers
> > query for parameters via of_get_property().
> 
> Calling of_* functions is the natural thing to do for an 
> of_platform_driver, just like a PCI driver calls pci_* functions.

It may be customary, and seem natural to you, but to me it includes
an unnaturally close coupling between the driver and the firmware.
Of course, I see many drivers have adopted it.  I also like the
interface better than platform_device.  However, I would like
it better if it were more decoupled from Open Firmware.

> Note that what I'm suggestiong here is that you have one file
> that encapsulates all the calls to OF functions (of_iomap,
> irq_of_parse_and_map, ...) and passes the raw information down
> to the main low-level driver.

I thought that's what I submitted.  The main difference is that
what you suggest requires me to also allocate a superfluous
of_device for each platform device, or to rewrite the driver
interface to handle an of_device and to do its own calls to
retrieve data from the device tree.

In the short term, since the of_ routines don't support the
platform_device interface, there's going to be ugliness.  We're
just discussing where to put that ugliness.  Do we keep the of_
functions clean and push the ugliness into the drivers, or
do we keep the driver interfaces clean and create platform_devices
rather than of_devices from the device tree info?  You want to
keep the of_ functions clean; I don't want to uglify the drivers
and am concerned about getting those ugly bits accepted into
the kernel.

> I think the main difference between your view and mine is that
> you see the OF model as an _architecture_ property, while in my
> view it is a _bus_type_ that devices are attached to.

Heh.  I see it as a firmware-specific bus type.  Of course, now
it's actually device-tree-specific, since we don't require OF
anymore, just some of its interfaces.

> It's like the OHCI driver, which has low-level driver for the
> a common register interface, but comes with a number of bus
> interfaces that it can attach to (PCI, PS3, OF, ...).
> [ don't look at the OHCI implementation, the way they did
>   the code is not a good example, but it can be done properly. ]
> 
> > Since you now recognize our need for platform_devices, I'd like to
> > understand your primary objection to our not creating of_devices.
> > Is it because it violates the assumption that of_devices be created
> > for all devices on the platform?
> 
> That, and the missing ability to do module autoloading.
> 
> > Is that a hard requirement? 
> 
> Not yet, but I'd like to get there, as I mention above.

Understood.  I still think it's an OF-centric view.  That wouldn't
be a problem if all architectures replaced platform_device with
of_device, a place that I think you'd also like to get to, which
I wouldn't mind at all.  We're just not going to get there any
time soon.

-Dale
