Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4680BDDF89
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 06:26:14 +1000 (EST)
Date: Thu, 26 Apr 2007 15:26:32 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070426202632.GA17302@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<200704261055.33739.arnd@arndb.de>
	<20070426164835.GA14149@lixom.net>
	<200704261911.22553.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704261911.22553.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, paulus@samba.org,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 07:11:21PM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Olof Johansson wrote:
> > SDC is the system and debug controller, it contains a number of smaller
> > devices such as the PIC, the PMU (Gizmo), RNG, and various debug
> > features. Some already have drivers submitted, others will later on.
> 
> Oh well, these chips all seem to be the same. On cell, we have solved
> the problem by introducing the 'cbe_regs' helper library that gives
> access to all those miscellaneous registers to the individual device
> drivers, so that not all of them need to scan the device tree for
> the same registers and map them individually.

Not a bad idea, I'll consider it for the future. Most of our devices are
on a pseudo-PCI bus, so it's only a handful that need special register
access. The stuff in the SDC is the biggest exception.

> The problem with an of_platform_driver for this would be that you
> can only have _one_ driver attached to the registers.
>
> > Unfortunately the setting of the current active state is done to an SDC
> > register, while information of the states is in the PMU, so access to
> > both is needed in the driver.
> 
> One thing that you could do is to list only this one register of the
> SDC in the reg property, not all of the SDC. 

That doesn't make much sense in this case. The register isn't in the
Gizmo.

Having a driver/library for the SDC that the gizmo driver can use is a
good idea, similar to what you've done on cell. I'll try to have that
ready for 2.6.23, but that shouldn't stop this base driver from going
in now.


-Olof
