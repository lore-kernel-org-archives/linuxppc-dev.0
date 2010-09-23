Return-Path: <cl@linux.com>
Received: from smtp106.prem.mail.ac4.yahoo.com
	(smtp106.prem.mail.ac4.yahoo.com [76.13.13.45])
	by ozlabs.org (Postfix) with SMTP id A3EDEB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 05:43:59 +1000 (EST)
Date: Thu, 23 Sep 2010 14:15:09 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <1285268380.2587.11.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1009231402420.2962@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
	<1285268380.2587.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Sep 2010, john stultz wrote:

> This was my initial gut reaction as well, but in the end, I agree with
> Richard that in the case of one or multiple PTP hardware clocks, we
> really can't abstract over the different time domains.

My (arguably still superficial) review of the source does not show
anything that would make me reach that conclusion.

> I really don't think the PTP clock can be used as a clocksource sanely.
>
> First, the hardware access is much to slow for system timekeeping.

The HPET or pit timesource are also quite slow these days. You only need
access periodically to essentially tune the TSC ratio.

> Second, there is the problem that the system time is a software clock,
> and adjustments made (like freq) are made in the layer that interprets
> the underlying hardware cycle counter. Adjustments made in PTP (in order
> to sync the network timestamps) are made at the hardware level.

>From what I can see the PTP clocks are periodic hardware cycle counters
like any other clock that we currently support. If its configurable enough
then setup a hardware cycle counter that mimics nanoseconds since the
epoch as closely as possible and use that to sync the TSC rate to. Makes
it very easy.

> This would cause a disconnect between the hardware freq understood by
> the system time management code and the actual hardware freq.

We can switch underlying clocks for system time already. We can adapt to a
different hw frequency. But then I do not know why adjust the freq? I
thought the point was that the periodic clock was network synchronized and
can be used as "the" master clock for multiple machines?

> Richard, I'd actually strike this paragraph from the rational, as I feel
> it has the tendency to confuse as it suggests having the PHC as a
> clocksource is feasible when really it isn't. Or alternatively, maybe
> express more clearly why its not feasible, so it doesn't just seem like
> a minor design choice.

Sorry but I still feel that this is pretty much a misguided approach that
creates unnecessary layers in the kernel. The trivial easy approach was
not done (copy a driver from drivers/clocksource, modify so that it
programs access to a centralized periodic ptp signal and uses it for
system sync).
