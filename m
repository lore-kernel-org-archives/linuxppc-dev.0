Return-Path: <alan@lxorguk.ukuu.org.uk>
Date: Thu, 23 Sep 2010 22:34:17 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
Message-ID: <20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.DEB.2.00.1009231533040.7522@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
	<1285268380.2587.11.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231402420.2962@router.home>
	<1285273684.2587.92.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231533040.7522@router.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, linux-api@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> There is no other scalable time source available for fast timer access
> than the time stamp counter in the cpu. Other time source require
> memory accesses which is inherently slower.

On what hardware ?

> An accurate other time source is used to adjust this clock. NTP does that
> via the clock interfaces from user space which has its problems with
> accuracy. PTP can provide the network synced time access
> that would a more accurate calibration of the time.

Accuracy does not require speed of access. Accuracy requires predictible
latency of access.

> Userland code would introduce latencies that would make sub microsecond
> time sync very difficult.

You can take a multiple micro-second I/O stall or SMI trap on a PC so you
already lost the battle on the platform you seem to be discussing.

> You dont need the user APIs if you directly use the PTP time source to
> steer the system clock. In fact I think you have to do it in kernel space
> since user space latencies will degrade accuracy otherwise.

PTP is not a 'time source' it is one or more source of time. The
distinction is rather important.

> It implies clock tuning in userspace for a potential sub microsecond
> accurate clock. The clock accuracy will be limited by user space
> latencies and noise. You wont be able to discipline the system clock
> accurately.

Noise matters, latency doesn't. And the kernel is getting more and more
real time support all the time.
