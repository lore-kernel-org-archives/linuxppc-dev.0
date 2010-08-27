Return-Path: <Patrick.Loschmidt@gmx.net>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by ozlabs.org (Postfix) with SMTP id 4DDF6B7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Aug 2010 01:28:31 +1000 (EST)
Message-ID: <4C77D804.9060500@gmx.net>
Date: Fri, 27 Aug 2010 17:21:40 +0200
From: Patrick Loschmidt <Patrick.Loschmidt@gmx.net>
MIME-Version: 1.0
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
References: <363bd749a38d0b785d8431e591bf54c38db4c2d7.1281956490.git.richard.cochran@omicron.at>	<AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>	<20100817085324.GB3330@riccoc20.at.omicron.at>	<1282090963.1734.97.camel@localhost>	<20100818071942.GA4096@riccoc20.at.omicron.at>	<1282176776.2865.100.camel@localhost.localdomain>	<20100819055518.GA4084@riccoc20.at.omicron.at>	<1282594125.3111.344.camel@localhost.localdomain>	<20100827123849.GC11657@riccoc20.at.omicron.at>	<20100827143844.646eccf6@lxorguk.ukuu.org.uk>	<20100827143437.GB3293@riccoc20.at.omicron.at>
	<20100827160624.433b3374@lxorguk.ukuu.org.uk>
In-Reply-To: <20100827160624.433b3374@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	john stultz <johnstul@us.ibm.com>, "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

I'd like to add my two cents about the discussion. Just to shortly
introduce myself: I'm working with PTP since version 2002 (now 2008 or
PTPv2) and I'm developing matching network cards, drivers, and also
sometimes a bit of the stack.

I always had the problem of different HW implementations (even my own)
and how to access the clocks there. So reading this thread, I strongly
support the idea to provide a driver class, which allows the userspace
to run certain standard operations (settime, gettime, adjtime, ...) as
proposed and leave the detailed implementation to a specific PTP clock
driver. I always made my own char device, but I don't want to open this
discussion again as for me it doesn't matter.

Concerning the long discussion about PTP clock, system time, etc. I'd
like to say, that from a point of view of PTP every node/host has only
one clock. That means, that if you have a NIC with integrated clock
(required for HW timestamping) it is counted as a node. As soon as you
want to use multiple NICs this is actually outside the PTP protocol
definition, unless you have only one clock available to both network
interfaces (which is hard to achieve).

So the solution to treat a PTP enabled NIC as a time source for the
system time is in general sufficient, unless for applications that
require precise timestamps in applications. I know of use cases where
code gets instrumented to measure time delays, processing time, and
sequence in SW, e.g. distributed databases for trading systems at the
stock exchange.

Summarizing I think it would be a huge step forward, if all the
different HW implementations could be controlled via a standardised
interface through the kernel. I need timestamps from my network card
with ps resolution and to steer the onboard clock from user space. Then
I would be happy already. :-)

Thanks,
Patrick
