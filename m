Return-Path: <richardcochran@gmail.com>
Date: Tue, 17 Aug 2010 10:32:16 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Message-ID: <20100817083216.GA3330@riccoc20.at.omicron.at>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008161626.24083.arnd@arndb.de>
	<20100816190003.GB4166@riccoc20.at.omicron.at>
	<201008162159.39734.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201008162159.39734.arnd@arndb.de>
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

On Mon, Aug 16, 2010 at 09:59:39PM +0200, Arnd Bergmann wrote:
> Why does it matter how long it takes to read the clock? I wasn't thinking
> of replacing the system clock with this, just exposing the additional
> clock as a new clockid_t value that can be accessed using the existing
> syscalls.

Okay, now I see. You are suggesting this:

      clock_gettime(CLOCK_PTP, &ts);
      clock_settime(CLOCK_PTP, &ts);

I like this. If there is agreement about it, I am happy to implement
the PTP stuff that way.

> Why did you not want to add syscalls? Adding ioctls instead of syscalls
> does not make the interface better, just less visible.

I bet that, had I posted patch set with new syscalls, someone would
have said, "You are adding new syscalls. Can't you just use a char
device instead!"

If you add syscalls and introduce CLOCK_PTP, then you add it to
everyone's kernel, even those people who never heard of PTP. A char
device has the advantage that can it be simply ignored. Also, a
syscall has got to have the right form from the very beginning. If the
next generation of PTP hardware looks very different, then it is not
that much of a crime to change an ioctl interface, provided it has
versioning.

Richard
