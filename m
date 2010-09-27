Return-Path: <imp@bsdimp.com>
Date: Mon, 27 Sep 2010 10:14:23 -0600 (MDT)
Message-Id: <20100927.101423.702773873740300798.imp@bsdimp.com>
To: cl@linux.com
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <alpine.DEB.2.00.1009271038150.9258@router.home>
References: <alpine.DEB.2.00.1009231533040.7522@router.home>
	<1285278136.2587.154.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009271038150.9258@router.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: richardcochran@gmail.com, peterz@infradead.org, johnstul@us.ibm.com,
	devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-api@vger.kernel.org,
	tglx@linutronix.de, giometti@linux.it, davem@davemloft.net,
	linux-arm-kernel@lists.infradead.org, khc@pm.waw.pl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <alpine.DEB.2.00.1009271038150.9258@router.home>
            Christoph Lameter <cl@linux.com> writes:
: On Thu, 23 Sep 2010, john stultz wrote:
: > The design actually avoids most userland induced latency.
: >
: > 1) On the PTP hardware syncing point, the reference packet gets
: > timestamped with the PTP hardware time on arrival. This allows the
: > offset calculation to be done in userland without introducing latency.
: 
: The timestamps allows the calculation of the network transmission time I
: guess and therefore its more accurate to calculate that effect out. Ok but
: then the overhead of getting to code in user space (that does the proper
: clock adjustments) is resulting in the addition of a relatively long time
: that is subject to OS scheduling latencies and noises.

The timestamps at the hardware level allow you to factor out variation
caused by OS Scheduling, OS network stack delay and internal buffering
on the NIC.  Variation in measurements is what kills accuracy.

When steering a clock by making an error measurement of the phase and
frequency of it, the latency induced by OS scheduling tends to be
unimportant.  It is far more important to know when you steered the
clock (called adjtime or friends) than to steer it at any fixed
latency to when the data for the measurements was made.  Measuring the
time of steer can tolerate errors in the range of OS scheduling
latencies easily, since that tends to produce a very small effect.  It
introduces an error in your expected phase for the next measurement on
the order of the product of the time of steer error times the change
in fractional frequency (abs( 1 - (nu_new / nu_old))).  Even if the
estimate is really bad at 100ms, most steers are on the order about
one part per million.  This leads to a sub-nanosecond phase error
estimate in the next measurement cycle (a non-accumulating error).  A
1ms error leads to maybe tens of picoseconds of estimate error.

This is a common error that I've seen repeated in this thread.  The
only reason that it has historically been important is because when
you are doing timestamping in software based on an interrupt, that
stuff does matter.

Warner
