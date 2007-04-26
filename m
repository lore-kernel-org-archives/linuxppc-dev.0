Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 30AB8DDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 16:46:29 +1000 (EST)
Date: Wed, 25 Apr 2007 23:48:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070426064830.GA29536@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260255.04490.arnd@arndb.de>
	<20070426011328.GR4046@mag.az.mvista.com>
	<200704260402.17248.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704260402.17248.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 04:02:16AM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Mark A. Greer wrote:
> > > location is the smaller part of the problem. Even if it was the right
> > > thing to scan the tree and then create platform_data instead of using
> > > the of_device, that code would still belong into the device driver.
> > 
> > I don't think of_device is going to work very well on MIPS.
> 
> Ok, I see your point there. But after looking at the i2c and net drivers,
> I believe that they can easily be split into an architecture dependent
> part that is either an of_platform_driver or a platform_driver, and
> a common part that does not know about either of these.

Back when I originally did the mpsc driver I did something similar.
The lkml folks told me pretty clearly to get rid of the arch-specific
code and use platform data.  All-in-all, I think that's the best solution
(until all arch's move to a device tree model).  So, I think we'll have
to agree to disagree on this.

There does seem to be a lot of duplicate code, though, so we should try
to clean that up (if possible).

Mark
