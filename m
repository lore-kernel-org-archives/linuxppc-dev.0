Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id CA1CEDDEE2
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 15:57:17 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 25 Apr 2007 22:57:16 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/13] powerpc: Add arch/powerpc mv64x60 MPSC platform data
	setup
Message-ID: <20070426055716.GB2030@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235939.GI4046@mag.az.mvista.com>
	<200704260214.08329.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704260214.08329.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 12:14:07AM +0000, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Mark A. Greer wrote:
> > +static int __init mv64x60_mpsc_platform_device_init(void)
> > +{
> > +	struct device_node *np = NULL;
> > +	unsigned int i;
> > +	struct platform_device *pdev;
> > +	int err;
> > +
> > +	for (i = 0; (np = of_find_compatible_node(np, "serial", "mpsc")); i++) {
> > +		struct resource r[5];
> > +		struct mpsc_pdata pdata;
> > +		const unsigned int *prop;
> > +		const phandle *ph;
> > +		struct device_node *sdma, *brg;
> 
> This looks wrong to me. See drivers/serial/of_serial.c to find how we do it for
> 8250 compatible serial ports. You should probably just add your serial port
> stuff in there as well, instead of doing your own scanning of the device tree.

Unfortunately, this hardware is very much non-8250 compatible.

> > +		pdev = platform_device_register_simple(MPSC_CTLR_NAME, i, r, 5);
> > +		if (IS_ERR(pdev)) {
> > +			err = PTR_ERR(pdev);
> > +			goto ret_node_put;
> > +		}
> 
> Now this really needs some explanation.
> 
> Why the heck do you have a platform device that gets its resources from
> nonstandard properties of a serial port?

There is an existing mpsc driver usable on both MIPS and powerpc platforms
that requires these non-standard properties.

-Dale
