Return-Path: <imp@bsdimp.com>
Date: Fri, 01 Oct 2010 19:44:50 -0600 (MDT)
Message-Id: <20101001.194450.1113329769525619655.imp@bsdimp.com>
To: cl@linux.com
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <alpine.DEB.2.00.1009271035110.9258@router.home>
References: <20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
	<4C9BC7CE.8020400@riesch.at>
	<alpine.DEB.2.00.1009271035110.9258@router.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: richardcochran@gmail.com, alan@lxorguk.ukuu.org.uk, peterz@infradead.org,
	johnstul@us.ibm.com, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	christian@riesch.at, netdev@vger.kernel.org, tglx@linutronix.de,
	linux-api@vger.kernel.org, giometti@linux.it,
	davem@davemloft.net, linux-arm-kernel@lists.infradead.org, khc@pm.waw.pl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <alpine.DEB.2.00.1009271035110.9258@router.home>
            Christoph Lameter <cl@linux.com> writes:
: On Thu, 23 Sep 2010, Christian Riesch wrote:
: 
: > > > It implies clock tuning in userspace for a potential sub microsecond
: > > > accurate clock. The clock accuracy will be limited by user space
: > > > latencies and noise. You wont be able to discipline the system clock
: > > > accurately.
: > >
: > > Noise matters, latency doesn't.
: >
: > Well put! That's why we need hardware support for PTP timestamping to reduce
: > the noise, but get along well with the clock servo that is steering the PHC in
: > user space.
: 
: Even if I buy into the catch phrase above: User space is subject to noise
: that the in kernel code is not. If you do the tuning over long intervals
: then it hopefully averages out but it still causes jitter effects that
: affects the degree of accuracy (or sync) that you can reach. And the noise
: varies with the load on the system.

Please see the earlier posts in this thread about why this doesn't
matter as much as you might think.  What matters is the measurements
(which are done in hardware and the results buffered), not the latency
in processing those messages through your servo.  This is due to the
fact that the errors that even long latencies introduce are
proportional to the change in fractional frequency[*] of the clock being
steered.  This change is usually on the order of a part per million.
Even with 10ms of latency would mean that you're introducing on the
order of sub-nanoseconds of phase error that will be measured in the
next cycle and steered out.

That's why latency doesn't matter.  Do you have other math to show
that it does?

Warner

[*] abs(1 - (clock_freq_old / clock_freq_new)) where clock_freq_old is
the old estimate of the clock and clock_freq_new is the new frequency
estimate of the clock.  Second to second, these change on the order of
a part per million or less...
