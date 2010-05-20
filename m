Return-Path: <THEMANN@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CA99B7D20
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 17:37:58 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id o4K7brCo007258
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 07:37:53 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o4K7bl2c757932
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 09:37:53 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o4K7blqt019915
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 09:37:47 +0200
In-Reply-To: <1274319248.22892.40.camel@concordia>
References: <4BF30793.5070300@us.ibm.com>	
	<4BF30C32.1020403@linux.vnet.ibm.com> <4BF31322.5090206@us.ibm.com>
	<1274232324.29980.9.camel@concordia> <4BF3F2DB.7030701@us.ibm.com>	
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
	<alpine.LFD.2.00.1005192244430.3368@localhost.localdomain>
	<1274319248.22892.40.camel@concordia>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
To: michael@ellerman.id.au
Message-ID: <OF17F8F35C.B09E4797-ONC1257729.0028292D-C1257729.0029E9AC@de.ibm.com>
From: Jan-Bernd Themann <THEMANN@de.ibm.com>
Date: Thu, 20 May 2010 09:37:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Darren Hart <dvhltc@us.ibm.com>, dvhltc@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
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

Hi,


Michael Ellerman <michael@ellerman.id.au> wrote on 20.05.2010 03:34:08:


> Subject:
>
> Re: [PATCH RT] ehea: make receive irq handler non-threaded (IRQF_NODELAY)
>
> On Wed, 2010-05-19 at 23:08 +0200, Thomas Gleixner wrote:
> > On Wed, 19 May 2010, Thomas Gleixner wrote:
> > > > I'm still not clear on why the ultimate solution wasn't to
> have XICS report
> > > > edge triggered as edge triggered. Probably some complexity of
> the entire power
> > > > stack that I am ignorant of.
> > > >
> > > > > Apart from the issue of loosing interrupts there is also thefact
that
> > > > > masking on the XICS requires an RTAS call which takes a global
lock.
> > >
> > > Right, I'd love to avoid that but with real level interrupts we'd run
> > > into an interrupt storm. Though another solution would be to issue
the
> > > EOI after the threaded handler finished, that'd work as well, but
> > > needs testing.
> >
> > Thought more about that. The case at hand (ehea) is nasty:
> >
> > The driver does _NOT_ disable the rx interrupt in the card in the rx
> > interrupt handler - for whatever reason.
>
> Yeah I saw that, but I don't know why it's written that way. Perhaps
> Jan-Bernd or Doug will chime in and enlighten us? :)

>From our perspective there is no need to disable interrupts for the RX side
as
the chip does not fire further interrupts until we tell the chip to do so
for a
particular queue. We have multiple receive queues with an own interrupt
each
so that the interrupts can arrive on multiple CPUs in parallel.
Interrupts are enabled again when we leave the NAPI Poll function for the
corresponding
receive queue.

Michael, does this answer your question?

Regards,
Jan-Bernd
