Return-Path: <benh@kernel.crashing.org>
Subject: Re: OpenPIC / CPM2 PIC and cascading interrupt priorities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Knispel <gknispel@proformatique.com>
In-Reply-To: <20090215055040.41672e36@xilun.lan.proformatique.com>
References: <20090215055040.41672e36@xilun.lan.proformatique.com>
Content-Type: text/plain
Date: Mon, 16 Feb 2009 08:04:20 +1100
Message-Id: <1234731860.26036.95.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
> {
> 	int cascade_irq;
> 
> 	while ((cascade_irq = cpm2_get_irq()) >= 0)
> 		generic_handle_irq(cascade_irq);
> 
> 	desc->chip->eoi(irq);
> }

You can try doing an early EOI see that helps. Ie, stick it inside the loop,
after cpm_2_get_irq() and before generic_handle_irq() and see if that helps,
but make sure you do that EOI only once, ie, only on the first iteration.

Depending on how the CPM2 works, you may also be able to just get rid
of the loop... ie, if CPM2 output is level sensitive.

Ben.
