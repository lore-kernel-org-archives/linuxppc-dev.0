Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 70059DDFC3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:41:29 +1000 (EST)
Date: Wed, 25 Apr 2007 17:43:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070426004302.GP4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000043.GK4046@mag.az.mvista.com>
	<200704260221.20150.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200704260221.20150.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 02:21:19AM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Mark A. Greer wrote:
> > +static int __init mv64x60_i2c_platform_device_init(void)
> > +{
> > +       struct device_node *np = NULL;
> > +       int i;
> > +       struct platform_device *pdev;
> > +       int err;
> > +
> > +       for (i = 0;
> > +            (np = of_find_compatible_node(np, "i2c", "mv64x60-i2c"));
> 
> Same comment as about the ethernet driver: You should register an
> of_platform_driver from drivers/i2c/busses/i2c-mv64xxx.c.
> 
> Repeat after me: 
> 
> I will not call of_find_compatible_node() from device drivers.
> I will not call of_find_compatible_node() from device drivers.
> I will not call of_find_compatible_node() from device drivers.

Well, your comments are for Dale's patches so I'll leave it to him to
answer your questions in detail but...

of_find_compatible_node() is not being called from a driver, its being
called from platform code.  Its extracting info from the device tree and
setting up the platform_data required by the driver.

Mark
