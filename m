Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id DC491DDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 16:00:27 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 25 Apr 2007 23:00:26 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/13] powerpc: Add arch/powerpc mv64x60_eth platform data
	setup
Message-ID: <20070426060026.GC2030@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000009.GJ4046@mag.az.mvista.com>
	<200704260218.45503.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704260218.45503.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 12:18:45AM +0000, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Mark A. Greer wrote:
> > Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
> > --- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.c
> > +++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
> > @@ -511,3 +511,138 @@ ret_node_put:
> > }
> >
> >arch_initcall(mv64x60_mpsc_platform_device_init);
> > +
> > +/*
> > + * Create mv64x60_eth platform device
> > + */
> > +static int __init eth_register_shared_pdev(struct device_node *np)
> > +{
> > +	struct platform_device *pdev;
> 
> No need to put this into architecture specific code, just register
> the of_platform_driver from mv643xx_init_module and use the device
> you get passed in there.
> 
> Once arch/ppc is dead, you can remove the platform_driver from mv643xx
> entirely.

Like with the mpsc driver, there is an existing platform-driver-based
ethernet driver used by MIPS and powerpc platforms.  OF isn't universal yet.

-Dale
