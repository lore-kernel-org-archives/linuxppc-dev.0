Return-Path: <richardcochran@gmail.com>
Date: Tue, 28 Sep 2010 08:34:49 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
Message-ID: <20100928063449.GA7224@riccoc20.at.omicron.at>
References: <alpine.DEB.2.00.1009231533040.7522@router.home>
	<1285278136.2587.154.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009271038150.9258@router.home>
	<20100927.101423.702773873740300798.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100927.101423.702773873740300798.imp@bsdimp.com>
Cc: peterz@infradead.org, johnstul@us.ibm.com,
	devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tglx@linutronix.de,
	linux-api@vger.kernel.org, cl@linux.com, giometti@linux.it,
	davem@davemloft.net, linux-arm-kernel@lists.infradead.org, khc@pm.waw.pl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 27, 2010 at 10:14:23AM -0600, M. Warner Losh wrote:
> 
> This is a common error that I've seen repeated in this thread.  The
> only reason that it has historically been important is because when
> you are doing timestamping in software based on an interrupt, that
> stuff does matter.

Yes, thanks for your helpful explanation.

To further illustrate how small the effect of running the servo in
user space is, consider the following.

It is true that delays and jitter in the time to process the received
packet negatively affect the clock servo loop. However, the effect in
our case will be quite small.

John Eidson's book [1] presents a rigorous servo model that includes
an analysis of the delay from the time the samples (timestamps) are
taken until the corrective action is performed by the PTP software.

For PTP, the sample time is at the sender (the remote host, the master
clock). The master sends *two* packets, where the second one (the so
called follow-up packet) contains the hardware time stamp of the first
one. So, the computational delay includes the time spent by the sender
in its PTP stack preparing the second packet, the time the packet
spends in transit, and the time in the receiver's PTP stack and servo.

According to Eidson's analysis, a delay of up to 10 milliseconds would
be acceptable, even with a sample rate of 10 Hz. Therefore, saving a
few dozen microseconds by placing the servo (and PTP stack) into the
kernel is not worth the effort.

Richard


[1] title =     {Measurement, control, and communication using IEEE 1588},
    author =    {J. C. Eidson},
    year =      2006,
    publisher = {Springer-Verlag},
