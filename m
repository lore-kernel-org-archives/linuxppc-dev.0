Return-Path: <alan@lxorguk.ukuu.org.uk>
Date: Thu, 23 Sep 2010 21:43:59 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 6/8] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
Message-ID: <20100923214359.3f287b11@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.DEB.2.00.1009231348150.2962@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<57b64051c816dc9cb856bbb9f38fc901c9d3d651.1285261535.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231348150.2962@router.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> Please do not introduce useless additional layers for clock sync. Load
> these ptp clocks like the other regular clock modules and make them sync
> system time like any other clock.

I don't think you understand PTP. PTP has masters, a system can need to
be honouring multiple conflicting masters at once.

> Really guys: I want a PTP solution! Now! And not some idiotic additional
> kernel layers that just pass bits around because its so much fun and
> screws up clock accurary in due to the latency noise introduced while
> having so much fun with the bits.

There are some interesting complications in putting a PTP sync
interface in kernel.
