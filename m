Return-Path: <alan@lxorguk.ukuu.org.uk>
Date: Fri, 27 Aug 2010 13:45:32 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Message-ID: <20100827134532.6fbb40fb@lxorguk.ukuu.org.uk>
In-Reply-To: <20100827110855.GA11657@riccoc20.at.omicron.at>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<1282176776.2865.100.camel@localhost.localdomain>
	<20100819055518.GA4084@riccoc20.at.omicron.at>
	<201008191428.04546.arnd@arndb.de>
	<20100819153847.GA10695@riccoc20.at.omicron.at>
	<1282594899.3111.358.camel@localhost.localdomain>
	<20100827110855.GA11657@riccoc20.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	john stultz <johnstul@us.ibm.com>, devicetree-discuss@lists.ozlabs.org,
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

> > So if the clock_adjtime interface is needed, it would seem best for it
> > to be generic enough to support not only PTP, but also the NTP kernel
> > PLL.
> 
> For the proposed clock_adjime, what else is needed to support clock
> adjustment in general?

Multiple PLLs, at least with containers and certain classes of system you
want different containers in different timespaces, especially when doing
high precision stuff where you need your system tracking say a local
master clock for syncing musical instruments and sound events while
tracking other clocks like NTP for general system time.

> I don't mind making the interface generic enough to support any
> (realistic) conceivable clock adjustment scheme, but beyond the
> present PTP hardware clocks, I don't know what else might be needed.

Put the clock type in the new fields. It becomes

	u16 clock_type;
	[clock type specific data]

saves having to guess.

Alan
