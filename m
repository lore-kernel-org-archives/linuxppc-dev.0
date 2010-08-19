Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 7BF98B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Aug 2010 22:29:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Date: Thu, 19 Aug 2010 14:29:49 +0200
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008181702.03384.arnd@arndb.de>
	<20100819092246.GA8484@riccoc20.at.omicron.at>
In-Reply-To: <20100819092246.GA8484@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008191429.50008.arnd@arndb.de>
Cc: Rodolfo Giometti <giometti@linux.it>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 August 2010, Richard Cochran wrote:
> 
> On Wed, Aug 18, 2010 at 05:02:03PM +0200, Arnd Bergmann wrote:
> > You might want to use callbacks for these system calls that you
> > can register to at module load time, like it is done for the
> > existing syscalls.
> 
> Can you point me to a specific example?

The struct k_clock contains callback functions to clock source
specific implementations of the syscalls and other functions.
Adding a new clock source that is (potentially) implemented
as a module means you have to define a new k_clock in that module
that you register using register_posix_clock.

If you need additional syscalls to be implemented by the same
module, you can put more callback functions into struct k_clock
that would then only be implemented by the new module.

> > The simpler way (e.g. for testing) is using Kconfig dependencies, like
> > 
> > config PTP
> >       bool "IEEE 1588 Precision Time Protocol"
> > 
> > config PPS
> >       tristate "Pulse per Second"
> >       depends on PTP || !PTP
> > 
> > The depends statement is a way of expressing that when PTP is enabled,
> > PPS cannot be a module, while it may be a module if PTP is disabled.
> 
> THis did not work for me.
> 
> What I got was, in effect, two independent booleans.

Hmm, right. I wonder what I was thinking of then.

You can certainly do

config PTP
	bool "IEEE 1588 Precision Time Protocol"
	depends on PPS != m

but that will hide the PTP option if PPS is set to 'm', which is normally
not what you want.

	Arnd
