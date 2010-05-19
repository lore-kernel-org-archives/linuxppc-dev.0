Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7954AB7D1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 07:09:00 +1000 (EST)
Date: Wed, 19 May 2010 23:08:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
In-Reply-To: <alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
Message-ID: <alpine.LFD.2.00.1005192244430.3368@localhost.localdomain>
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
	<4BF3F2DB.7030701@us.ibm.com>
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan-Bernd Themann <themann@de.ibm.com>, dvhltc@linux.vnet.ibm.com,
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

On Wed, 19 May 2010, Thomas Gleixner wrote:
> > I'm still not clear on why the ultimate solution wasn't to have XICS report
> > edge triggered as edge triggered. Probably some complexity of the entire power
> > stack that I am ignorant of.
> > 
> > > Apart from the issue of loosing interrupts there is also the fact that
> > > masking on the XICS requires an RTAS call which takes a global lock.
> 
> Right, I'd love to avoid that but with real level interrupts we'd run
> into an interrupt storm. Though another solution would be to issue the
> EOI after the threaded handler finished, that'd work as well, but
> needs testing.

Thought more about that. The case at hand (ehea) is nasty:

The driver does _NOT_ disable the rx interrupt in the card in the rx
interrupt handler - for whatever reason.

 So even in mainline you get repeated rx interrupts when packets
 arrive while napi is processing the poll, which is suboptimal at
 least. In fact it is counterproductive as the whole purpose of NAPI
 is to _NOT_ get interrupts for consecutive incoming packets while the
 poll is active.

Most of the other network drivers do:

      rx_irq()
	disable rx interrupts on card
	napi_schedule()

Now when the napi poll is done (no more packets available) then the
driver reenables the rx interrupt on the card.

Thanks,

	tglx
