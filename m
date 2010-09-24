Return-Path: <alan@lxorguk.ukuu.org.uk>
Date: Fri, 24 Sep 2010 15:57:13 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
Message-ID: <20100924155713.45be6513@lxorguk.ukuu.org.uk>
In-Reply-To: <20100924135001.GB3113@riccoc20.at.omicron.at>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<1285270733.2587.46.camel@localhost.localdomain>
	<20100924135001.GB3113@riccoc20.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Instead, I think having the id hanging off the class driver is much
> > better, as it allows mapping the actual hardware to the id more clearly.
> > 
> > So I'd drop the "timesource" listing. And maybe change "id" to
> > "clock_id" so its a little more clear what the id is for.
> 
> Okay, I will drop /sys/class/timesource (hope Alan Cox agrees :)

It makes sense to hang anything off the physical id

> I threw it out there mostly for the sake of discussion. I imagined
> that there could be other properties in that directory, like time
> scale (TAI, UTC, etc). But it seems like we don't really need anything
> in that direction.

They can still hang off the physical device. Thats really a detail

> > interrupts are awfully frequent, so systems concerned with power-saving
> > and deep idles probably would like something that could be done at a
> > more coarse interval.
> 
> We could always make the pulse rate programmable, for power-saving
> applications.

I would expect the kernel drivers to be responsible for
- Turning off when they can
- Picking rates that are power optimal for the requirement

The latter is a bit interesting as I don't see anything in any of the
timer APIs to express accuracy (a problem we have in kernel too).
Historically it simply hasn't mattered.
