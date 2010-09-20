Return-Path: <THEMANN@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.17.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02613B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 00:26:33 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.1/8.13.1) with ESMTP id o8KEQSaD014899
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 14:26:28 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o8KEQOL74116712
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 16:26:28 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o8KEQNc1009931
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2010 16:26:24 +0200
In-Reply-To: <1274433481_6943@mail4.comsite.net>
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
	<4BF3F2DB.7030701@us.ibm.com>
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
	<1274319125.22892.38.camel@concordia>
	<1274319125.22892.38.camel@concordia>
	<alpine.LFD.2.00.1005201014250.3368@localhost.localdomain>
	<1274433481_6943@mail4.comsite.net>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
To: Milton Miller <miltonm@bga.com>
Message-ID: <OF6B4F50FA.27908491-ONC12577A4.004EB556-C12577A4.004F51A1@de.ibm.com>
From: Jan-Bernd Themann <THEMANN@de.ibm.com>
Date: Mon, 20 Sep 2010 16:26:22 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel-owner@vger.kernel.org, Darren Hart <dvhltc@us.ibm.com>,
	dvhltc@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, Doug Maxey <doug.maxey@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Milton,

sorry for the delayed answer, was on vacation.

linux-kernel-owner@vger.kernel.org wrote on 21.05.2010 11:18:01:
> linux-kernel-owner@vger.kernel.org
>
> On Thu, 20 May 2010 at 10:21:36 +0200 (CEST) Thomas Gleixner  wrote:
> > On Thu, 20 May 2010, Michael Ellerman wrote:
> > > On Wed, 2010-05-19 at 16:38 +0200, Thomas Gleixner wrote:
> > > > On Wed, 19 May 2010, Darren Hart wrote:
> > > >
> > > > > On 05/18/2010 06:25 PM, Michael Ellerman wrote:
> > > > > > On Tue, 2010-05-18 at 15:22 -0700, Darren Hart wrote:
> > >
> > > > > > The result of the discussion about two years ago on this was
that we
> > > > > > needed a custom flow handler for XICS on RT.
> > > > >
> > > > > I'm still not clear on why the ultimate solution wasn't to
> have XICS report
> > > > > edge triggered as edge triggered. Probably some complexity
> of the entire power
> > > > > stack that I am ignorant of.
> > > > >
> > > > > > Apart from the issue of loosing interrupts there is also
> the fact that
> > > > > > masking on the XICS requires an RTAS call which takes a global
lock.
> > > >
> > > > Right, I'd love to avoid that but with real level interrupts we'd
run
> > > > into an interrupt storm. Though another solution would be to issue
the
> > > > EOI after the threaded handler finished, that'd work as well, but
> > > > needs testing.
> > >
> > > Yeah I think that was the idea for the custom flow handler. We'd
reset
> > > the processor priority so we can take other interrupts (which the EOI
> > > usually does for you), then do the actual EOI after the handler
> > > finished.
> >
> > That only works when the card does not issue new interrupts until the
> > EOI happens. If the EOI is only relevant for the interrupt controller,
> > then you are going to lose any edge which comes in before the EOI as
> > well.
>
> Well, the real MSIs have an extra bit to allow the eoi to dally behind
> the mmio on another path and that should cover this race when the irq
> is left enabled.
>
> Jan-Bernd HEA has that change, right?

I don't now. We never hit problems so we did not look very deep into this
area.
We probably have to talk to the HEA HW developers to be sure.

Regards,
Jan-Bernd
