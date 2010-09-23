Return-Path: <cl@linux.com>
Received: from smtp107.prem.mail.ac4.yahoo.com
	(smtp107.prem.mail.ac4.yahoo.com [76.13.13.46])
	by ozlabs.org (Postfix) with SMTP id CDB25B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 06:32:56 +1000 (EST)
Date: Thu, 23 Sep 2010 15:32:50 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/8] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
In-Reply-To: <20100923214359.3f287b11@lxorguk.ukuu.org.uk>
Message-ID: <alpine.DEB.2.00.1009231527330.7522@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<57b64051c816dc9cb856bbb9f38fc901c9d3d651.1285261535.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231348150.2962@router.home>
	<20100923214359.3f287b11@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Stultz <johnstul@us.ibm.com>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
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

On Thu, 23 Sep 2010, Alan Cox wrote:

> > Please do not introduce useless additional layers for clock sync. Load
> > these ptp clocks like the other regular clock modules and make them sync
> > system time like any other clock.
>
> I don't think you understand PTP. PTP has masters, a system can need to
> be honouring multiple conflicting masters at once.

The upshot of it all has to be some synchronized notion of time regardless
of how many other things are going on under the hood. And the spec here
suggests a hardware able to generate periodic accurate events that can be
used to sync system time.

> > Really guys: I want a PTP solution! Now! And not some idiotic additional
> > kernel layers that just pass bits around because its so much fun and
> > screws up clock accurary in due to the latency noise introduced while
> > having so much fun with the bits.
>
> There are some interesting complications in putting a PTP sync
> interface in kernel.

If the PTP logic internally has to juggle multiple clocks then that is a
complication for the driver ok. In any case the driver ultimately has to
provide *one* source of time for the system to sync to.
