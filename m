Return-Path: <nd@bplan-gmbh.de>
Date: Tue, 31 Oct 2006 08:09:04 +0100 (MET)
Message-ID: <4546F68C.6070900@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<1162268830.25682.271.camel@localhost.localdomain>
In-Reply-To: <1162268830.25682.271.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------020805090003080903000501"
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

This is a multi-part message in MIME format.
--------------020805090003080903000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Mon, 2006-10-30 at 00:10 +0100, Nicolas DET wrote:
> 
>> +/*
>> + * void call to be used for .ack in the irq_chip_ops
>> + * indeed, some of our irq does noy need ack
>> + * but the kernel call .ack if it's valid or not
>> +*/
>> +
>> +static void mpc52xx_voidfunc(unsigned int virq)
>> +{
>> +#ifdef DEBUG
>> +       int irq;
>> +       int l2irq;
>> +
>> +       irq = irq_map[virq].hwirq;
>> +       l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
>> +
>> +       pr_debug("%s: irq=%x, l2=%d\n", __func__, irq, l2irq);
>> +#endif
>> +}
> 
> As I said on IRC, we might be able to get away without that one, but
> that's not urgent.

Already done.

> 
>> +       irq = irq_map[virq].hwirq;
>> +       l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
>> +
>> +       pr_debug("%s: irq=%x, l2=%d\n", __func__, irq, l2irq);
>> +
>> +       if (l2irq != 0)
>> +               BUG();
> 
> Use BUG_ON(l2irq != 0); instead, generates better code (though I don't
> think you really need to keep those checks once you've verified things
> work fine).
> 

Ok.

>> +       set_irq_chip_and_handler(virq, good_irqchip, good_handle);
>> +       set_irq_type(virq, type);
> 
> set_irq_type() does nothing if you haven't hooked a set_type callback to
> your irq_chip and none of yours does so just drop it for now and look at
> how this is done in mpic or ipic. If you actually want to implement
> proper set_type (which you might need to do if you want that code to
> work without having the firmware pre-initialize interrupts with the
> right type at boot), you probably want to set the handler in
> set_irq_type().
> 

Our Firmware wil lalways preinit correctly the hw. Moreover, chaning the 
setting would propably rpevent PCI IRQ (as PCI are IRQ[0-3].

So I should just remove the set_irq_type() call?

Regards

--------------020805090003080903000501
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------020805090003080903000501--
