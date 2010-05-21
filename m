Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id BAFFFB7D45
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 19:18:05 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
To: Thomas Gleixner <tglx@linutronix.de>,
	Jan-Bernd Themann <themann@de.ibm.com>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
In-Reply-To: <alpine.LFD.2.00.1005201014250.3368@localhost.localdomain>
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
	<4BF3F2DB.7030701@us.ibm.com>
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
	<1274319125.22892.38.camel@concordia>
	<1274319125.22892.38.camel@concordia>
	<alpine.LFD.2.00.1005201014250.3368@localhost.localdomain>
Date: Fri, 21 May 2010 04:18:01 -0500
Message-ID: <1274433481_6943@mail4.comsite.net>
Cc: Darren Hart <dvhltc@us.ibm.com>, dvhltc@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Doug Maxey <doug.maxey@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 20 May 2010 at 10:21:36 +0200 (CEST) Thomas Gleixner  wrote:
> On Thu, 20 May 2010, Michael Ellerman wrote:
> > On Wed, 2010-05-19 at 16:38 +0200, Thomas Gleixner wrote:
> > > On Wed, 19 May 2010, Darren Hart wrote:
> > >
> > > > On 05/18/2010 06:25 PM, Michael Ellerman wrote:
> > > > > On Tue, 2010-05-18 at 15:22 -0700, Darren Hart wrote:
> >
> > > > > The result of the discussion about two years ago on this was that we
> > > > > needed a custom flow handler for XICS on RT.
> > > >
> > > > I'm still not clear on why the ultimate solution wasn't to have XICS report
> > > > edge triggered as edge triggered. Probably some complexity of the entire power
> > > > stack that I am ignorant of.
> > > >
> > > > > Apart from the issue of loosing interrupts there is also the fact that
> > > > > masking on the XICS requires an RTAS call which takes a global lock.
> > >
> > > Right, I'd love to avoid that but with real level interrupts we'd run
> > > into an interrupt storm. Though another solution would be to issue the
> > > EOI after the threaded handler finished, that'd work as well, but
> > > needs testing.
> >
> > Yeah I think that was the idea for the custom flow handler. We'd reset
> > the processor priority so we can take other interrupts (which the EOI
> > usually does for you), then do the actual EOI after the handler
> > finished.
> 
> That only works when the card does not issue new interrupts until the
> EOI happens. If the EOI is only relevant for the interrupt controller,
> then you are going to lose any edge which comes in before the EOI as
> well.

Well, the real MSIs have an extra bit to allow the eoi to dally behind
the mmio on another path and that should cover this race when the irq
is left enabled.

Jan-Bernd HEA has that change, right?

milton
