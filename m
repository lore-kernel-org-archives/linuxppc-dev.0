Return-Path: <richardcochran@gmail.com>
Date: Wed, 18 Aug 2010 16:04:40 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Message-ID: <20100818140440.GA22655@riccoc20.at.omicron.at>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008170925.55592.arnd@arndb.de>
	<20100817105232.GA9079@riccoc20.at.omicron.at>
	<201008171336.29375.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201008171336.29375.arnd@arndb.de>
Cc: Rodolfo Giometti <giometti@linux.it>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 17, 2010 at 01:36:29PM +0200, Arnd Bergmann wrote:
> On Tuesday 17 August 2010, Richard Cochran wrote:
> > I've been looking at offering the PTP clock as a posix clock, and it
> > is not as hard as I first thought. The PTP clock or clocks just have
> > to be registered as one of the posix_clocks[MAX_CLOCKS] in
> > posix-timers.c.
> 
> Ok sounds good.

I've been working turning the PTP stuff into syscalls, but here is a
little issue I ran into. The PTP clock layer wants to call the PPS
code via pps_register_source(), but the PPS can be compiled as a
module. Since the PTP layer is now offering syscalls, it must always
be present in the kernel. So I need to make sure that the PPS is
either absent entirely or staticly linked in.

How can I do this?

Thanks,

Richard
