Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 2A55BDDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 19:00:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Date: Thu, 26 Apr 2007 11:00:25 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260402.17248.arnd@arndb.de>
	<20070426060855.GD2030@xyzzy.farnsworth.org>
In-Reply-To: <20070426060855.GD2030@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261100.25650.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Dale Farnsworth wrote:
> 
> > Ok, I see your point there. But after looking at the i2c and net drivers,
> > I believe that they can easily be split into an architecture dependent
> > part that is either an of_platform_driver or a platform_driver, and
> > a common part that does not know about either of these.
> 
> Oh, it's certainly possible, but it doesn't seem desirable to me. Why
> should the drivers carry the burden of supporting both platform_driver
> and of_platform_driver interfaces?

The reason is that platform_devices are for stuff that fundamentally cannot
be probed but has to be hardcoded in some place.

The point about the of device tree is that it allows you to probe this
kind of device. This means you get automatic module loading based on the
device tree, and that the devices show up in sane locations in /sys.

	Arnd <><
