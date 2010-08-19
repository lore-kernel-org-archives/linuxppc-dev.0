Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id F1F02B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Aug 2010 01:23:03 +1000 (EST)
Date: Thu, 19 Aug 2010 08:23:01 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Message-ID: <20100819152301.GB25193@ovro.caltech.edu>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008181702.03384.arnd@arndb.de>
	<20100819092246.GA8484@riccoc20.at.omicron.at>
	<201008191429.50008.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201008191429.50008.arnd@arndb.de>
Cc: john stultz <johnstul@us.ibm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Rodolfo Giometti <giometti@linux.it>,
	devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 19, 2010 at 02:29:49PM +0200, Arnd Bergmann wrote:
> On Thursday 19 August 2010, Richard Cochran wrote:
> > 
> > On Wed, Aug 18, 2010 at 05:02:03PM +0200, Arnd Bergmann wrote:
> > > You might want to use callbacks for these system calls that you
> > > can register to at module load time, like it is done for the
> > > existing syscalls.
> > 
> > Can you point me to a specific example?
> 
> The struct k_clock contains callback functions to clock source
> specific implementations of the syscalls and other functions.
> Adding a new clock source that is (potentially) implemented
> as a module means you have to define a new k_clock in that module
> that you register using register_posix_clock.
> 
> If you need additional syscalls to be implemented by the same
> module, you can put more callback functions into struct k_clock
> that would then only be implemented by the new module.
> 
> > > The simpler way (e.g. for testing) is using Kconfig dependencies, like
> > > 
> > > config PTP
> > >       bool "IEEE 1588 Precision Time Protocol"
> > > 
> > > config PPS
> > >       tristate "Pulse per Second"
> > >       depends on PTP || !PTP
> > > 
> > > The depends statement is a way of expressing that when PTP is enabled,
> > > PPS cannot be a module, while it may be a module if PTP is disabled.
> > 
> > THis did not work for me.
> > 
> > What I got was, in effect, two independent booleans.
> 
> Hmm, right. I wonder what I was thinking of then.
> 
> You can certainly do
> 
> config PTP
> 	bool "IEEE 1588 Precision Time Protocol"
> 	depends on PPS != m
> 
> but that will hide the PTP option if PPS is set to 'm', which is normally
> not what you want.
> 

Arnd,

Perhaps you were thinking of the vhost example (taken from
drivers/vhost/Kconfig):

config VHOST_NET
	tristate "Host kernel accelerator for virtio net (EXPERIMENTAL)"
	depends on NET && EVENTFD && (TUN || !TUN) && (MACVTAP || !MACVTAP) && EXPERIMENTAL

They have a similar construct with both TUN and MACVTAP there. Perhaps
the parens are a necessary part of the "X || !X" syntax? Just a random
guess.

Ira
