Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4546F68C.6070900@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<1162268830.25682.271.camel@localhost.localdomain>
	<4546F68C.6070900@bplan-gmbh.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 18:21:36 +1100
Message-Id: <1162279296.25682.297.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > set_irq_type() does nothing if you haven't hooked a set_type callback to
> > your irq_chip and none of yours does so just drop it for now and look at
> > how this is done in mpic or ipic. If you actually want to implement
> > proper set_type (which you might need to do if you want that code to
> > work without having the firmware pre-initialize interrupts with the
> > right type at boot), you probably want to set the handler in
> > set_irq_type().
> > 
> 
> Our Firmware wil lalways preinit correctly the hw. Moreover, chaning the 
> setting would propably rpevent PCI IRQ (as PCI are IRQ[0-3].
> 
> So I should just remove the set_irq_type() call?

Just remove it for now. I'll look into making things better later. Your
firmware might setup the stuff properly, but others will probably not
and this driver will be used by others :)

Ben.
