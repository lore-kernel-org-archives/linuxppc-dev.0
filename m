Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id DFF75DDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 07:56:23 +1000 (EST)
Date: Thu, 29 Mar 2007 16:56:14 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: publishing OF platform devices
Message-Id: <20070329165614.3410786a.kim.phillips@freescale.com>
In-Reply-To: <460C2F0F.3050808@246tNt.com>
References: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
	<460C2F0F.3050808@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 29 Mar 2007 23:26:39 +0200
Sylvain Munaut <tnt@246tNt.com> wrote:

> John Rigby wrote:
> > I have a question about the "right" way to publish platform
> > devices via of_platform_bus_probe.
> >
> > On 5200 platforms it gets called from
> > mpc52xx_declare_of_platform_devices which is registered as the
> > machdep_calls init routine.
> >   
> It's called by machdep calls so that it's only called if the platform
> is detected ...
> > On other platforms it is called via a device_initcall
> >   
> That will always be called which is bad.
> 
> Because if you have a kernel will multiple platform support built in,
> it will
> be called everytime, even if it's not running on the good platform.
> > Also I noticed that some 83xx platforms don't call
> > of_platform_bus_probe at all.  Thats ok because most of those
> > devices are register various routines in fsl_soc.c.  The one I have
> > not figured out yet is spi, I don't see anyone registering
> > mpc83xx_spi?
> >   
> On theses I have no idea ...
> 
spi_mpc83xx is a platform_driver.  You either have to add spi code to
fsl_soc.c, or, probably better, make it an of_platform_driver (see
drivers/net/ucc_geth.c).  Hopefully an of_platform_driver patch will
be accepted now that cuimage is here, and 83xx can be removed from arch/ppc.

Kim
