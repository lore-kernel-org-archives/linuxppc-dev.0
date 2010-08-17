Return-Path: <richardcochran@gmail.com>
Date: Tue, 17 Aug 2010 12:52:32 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Message-ID: <20100817105232.GA9079@riccoc20.at.omicron.at>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008162159.39734.arnd@arndb.de>
	<20100817083216.GA3330@riccoc20.at.omicron.at>
	<201008170925.55592.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201008170925.55592.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Rodolfo Giometti <giometti@linux.it>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 17, 2010 at 09:25:55AM +0000, Arnd Bergmann wrote:
> Another difference is that we generally use ioctl for devices that can
> be enumerated, while syscalls are for system services that are not tied to
> a specific device. This argument works both ways for PTP IMHO: On the one
> hand you want to have a reliable clock that you can use without knowing
> where it comes from, on the other you might have multiple PTP sources that
> you need to differentiate.

Yes, I agree. In normal use, there will be only one PTP clock in a
system. However, for research purposes, it would be nice to have more
than one.

I've been looking at offering the PTP clock as a posix clock, and it
is not as hard as I first thought. The PTP clock or clocks just have
to be registered as one of the posix_clocks[MAX_CLOCKS] in
posix-timers.c.

My suggestion would be to reserve three clock ids in time.h,
CLOCK_PTP0, CLOCK_PTP1, and CLOCK_PTP2. The first one would be the
same as CLOCK_REALTIME, for SW timestamping, and the other two would
allow two different PTP clocks at the same time, for the research use
case.

Using the clock id will bring another advantage, since it will then be
possible for user space to specify the desired timestamp source for
SO_TIMESTAMPING.

Richard
