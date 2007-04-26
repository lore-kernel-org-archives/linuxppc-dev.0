Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 0BA3EDDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 00:19:05 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 26 Apr 2007 07:19:03 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070426141902.GB29241@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260402.17248.arnd@arndb.de>
	<20070426060855.GD2030@xyzzy.farnsworth.org>
	<200704261100.25650.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704261100.25650.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 11:00:25AM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Dale Farnsworth wrote:
> > 
> > > Ok, I see your point there. But after looking at the i2c and net drivers,
> > > I believe that they can easily be split into an architecture dependent
> > > part that is either an of_platform_driver or a platform_driver, and
> > > a common part that does not know about either of these.
> > 
> > Oh, it's certainly possible, but it doesn't seem desirable to me. Why
> > should the drivers carry the burden of supporting both platform_driver
> > and of_platform_driver interfaces?
> 
> The reason is that platform_devices are for stuff that fundamentally cannot
> be probed but has to be hardcoded in some place.
> 
> The point about the of device tree is that it allows you to probe this
> kind of device. This means you get automatic module loading based on the
> device tree, and that the devices show up in sane locations in /sys.

I understand the benefits of the DT; that's not the issue.

Here we have platform devices common to MIPS and PowerPC platforms.
The drivers must continue to support the platform_driver interface
for MIPS platforms.  The question is, where should we put the glue
that transforms the DT info into the platform_driver format?

You seem to suggest putting the ethernet-related glue into
drivers/net/mv643xx_eth.c.  That's bogus, IMHO. The base driver
shouldn't have to accommodate every arch-specific interface.
(I know OF isn't strictly arch-specific, but it's far from universal.)
I put this glue into arch/powerpc/sysdev/mv64x60.c. I still don't see
the benefit of moving it into the drivers.

-Dale
