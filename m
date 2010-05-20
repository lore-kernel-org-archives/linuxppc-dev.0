Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9A99B7D2E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 19:19:36 +1000 (EST)
Date: Thu, 20 May 2010 11:19:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jan-Bernd Themann <THEMANN@de.ibm.com>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
In-Reply-To: <OFCBBE5EB9.FD616EDA-ONC1257729.0030B539-C1257729.0031FB06@de.ibm.com>
Message-ID: <alpine.LFD.2.00.1005201112000.3368@localhost.localdomain>
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
	<4BF3F2DB.7030701@us.ibm.com>
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
	<alpine.LFD.2.00.1005192244430.3368@localhost.localdomain>
	<1274319248.22892.40.camel@concordia>
	<OF17F8F35C.B09E4797-ONC1257729.0028292D-C1257729.0029E9AC@de.ibm.com>
	<alpine.LFD.2.00.1005200950410.3368@localhost.localdomain>
	<OFCBBE5EB9.FD616EDA-ONC1257729.0030B539-C1257729.0031FB06@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darren Hart <dvhltc@us.ibm.com>, dvhltc@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
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

Jan-Bernd,

On Thu, 20 May 2010, Jan-Bernd Themann wrote:

> 
> Hi Thomas
> 
> > Re: [PATCH RT] ehea: make receive irq handler non-threaded (IRQF_NODELAY)
> >
> > On Thu, 20 May 2010, Jan-Bernd Themann wrote:
> > > > > Thought more about that. The case at hand (ehea) is nasty:
> > > > >
> > > > > The driver does _NOT_ disable the rx interrupt in the card in the
> rx
> > > > > interrupt handler - for whatever reason.
> > > >
> > > > Yeah I saw that, but I don't know why it's written that way. Perhaps
> > > > Jan-Bernd or Doug will chime in and enlighten us? :)
> > >
> > > From our perspective there is no need to disable interrupts for the
> > > RX side as the chip does not fire further interrupts until we tell
> > > the chip to do so for a particular queue. We have multiple receive
> >
> > The traces tell a different story though:
> >
> >     ehea_recv_irq_handler()
> >       napi_reschedule()
> >     eoi()
> >     ehea_poll()
> >       ...
> >       ehea_recv_irq_handler()    <---------------- ???
> >         napi_reschedule()
> >       ...
> >       napi_complete()
> >
> > Can't tell whether you can see the same behaviour in mainline, but I
> > don't see a reason why not.
> 
> Is this the same interrupt we are seeing here, or do we see a second other
> interrupt popping up on the same CPU? As I said, with multiple receive
> queues
> (if enabled) you can have multiple interrupts in parallel.

According to the traces it's the very same interrupt number.

> Pleaes check if multiple queues are enabled. The following module parameter
> is used for that:
> 
> MODULE_PARM_DESC(use_mcs, " 0:NAPI, 1:Multiple receive queues, Default = 0
> ");
> 
> you should also see the number of used HEA interrupts in /proc/interrupts

I leave that for Will and Darren, they have the hardware :)

> >
> > > queues with an own interrupt each so that the interrupts can arrive
> > > on multiple CPUs in parallel.  Interrupts are enabled again when we
> > > leave the NAPI Poll function for the corresponding receive queue.
> >
> > I can't see a piece of code which does that, but that's probably just
> > lack of detailed hardware knowledge on my side.
> 
> If you mean the "re-enable" piece of code, it is not very obvious,
> you are right.  Interrupts are only generated if a particular
> register for our completion queues is written. We do this in the
> following line:
> 
>           ehea_reset_cq_ep(pr->recv_cq);
>           ehea_reset_cq_ep(pr->send_cq);
>           ehea_reset_cq_n1(pr->recv_cq);
>           ehea_reset_cq_n1(pr->send_cq);
> 
> So this is in a way an indirect way to ask for interrupts when new
> completions were written to memory. We don't really disable/enable
> interrupts on the HEA chip itself.

Ah, ok. That's after the napi_complete which looks correct.
 
> I think there are some mechanisms build in the HEA chip that should
> prevent that interrupts don't get lost. But that is something that
> is / was completely hidden from us, so my skill is very limited
> there.
>
> If more details are needed here we should involve the PHYP guys +
> eHEA HW guys if not already done. Did anyone already talk to them?

Will or Darren might have, but lets gather more information first
before we rack their nerves :)

Thanks,

	tglx
