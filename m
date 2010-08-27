Return-Path: <alan@lxorguk.ukuu.org.uk>
Date: Fri, 27 Aug 2010 16:06:24 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Message-ID: <20100827160624.433b3374@lxorguk.ukuu.org.uk>
In-Reply-To: <20100827143437.GB3293@riccoc20.at.omicron.at>
References: <363bd749a38d0b785d8431e591bf54c38db4c2d7.1281956490.git.richard.cochran@omicron.at>
	<AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>
	<20100817085324.GB3330@riccoc20.at.omicron.at>
	<1282090963.1734.97.camel@localhost>
	<20100818071942.GA4096@riccoc20.at.omicron.at>
	<1282176776.2865.100.camel@localhost.localdomain>
	<20100819055518.GA4084@riccoc20.at.omicron.at>
	<1282594125.3111.344.camel@localhost.localdomain>
	<20100827123849.GC11657@riccoc20.at.omicron.at>
	<20100827143844.646eccf6@lxorguk.ukuu.org.uk>
	<20100827143437.GB3293@riccoc20.at.omicron.at>
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

> Sorry for causing confusion, but please understand "a hardware clock
> with timestamping capabilities than can be used for PTP support"
> whenever I wrote "PTP" or "PTP clock."

Ok that makes sense.
> 
> Well, what I just said is not entirely true.
> most are bound to the PTP protocol. That may change in the future...

Which seems fine to me too - its an implementation detail of that time
source.

> > Specialist applications will presumably need to know which time source or
> > sources they are tracking and synchronizing too out of multiple potential
> > PTP sources
> 
> Yes, the PTPd will have some special knowledge.

Not only that but consumers of different time synchronizations will need
to be able to describe which time source they want to talk about from a
selection of PTP or similar things.

> > system time bimble track a source makes sense just as with NTP but making
> > it a new clock seems the wrong model extending a non-too-bright API when
> > you can just put the time sources in a file tree.
> 
> Don't get your meaning here, what did you mean by "file tree?"

Something like

	/sys/class/timesource/<name>/...

at which point we don't have to enumerate them all, add special system
calls and then fret about the fact you can't access them from things like
shell scripts.

The fact SYS5.4 Unix and SuS got obsessed with numbering things
rather than using names unlike Unix doesn't mean it's the right model to
number them - usually the reverse is true, a heirarchy of file names is
rather more future proof.

Alan
