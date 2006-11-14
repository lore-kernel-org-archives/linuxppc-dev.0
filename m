Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABD9467D55
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 16:46:05 +1100 (EST)
Subject: Re: [PATCH] Powerpc: Make pci_read_irq_line the default: on
	mpc7448hpc2 board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1163482111.3748.15.camel@localhost.localdomain>
References: <1161141538.24931.9.camel@localhost.localdomain>
	<1161949906.25263.19.camel@localhost.localdomain>
	<1161960682.25801.4.camel@localhost.localdomain>
	<1163482111.3748.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 16:45:52 +1100
Message-Id: <1163483152.5940.106.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"Alexandre.Bounine@tundra.com" <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Good. Same comments as with Vitaly though :-)

> +static void pci_irq_host_unmap(struct irq_host *h, unsigned int virq)
> +{
> +	/* Make sure irq is masked in hardware */
> +	
> +	tsi108_pci_int_mask(virq);
> +
> +	/* remove chip and handler */
> +	set_irq_chip_and_handler(virq, NULL, NULL);
> +
> +	/* Make sure it's completed */
> +	synchronize_irq(virq);
> +}

You probably don't need that... the generic code should do the above
just fine unless something is wrong in which case we should fix it.

> +static int pci_irq_host_match(struct irq_host *h, struct device_node *node)
> +{
> +	return pci_irq_node == NULL || pci_irq_node == node;
> +}

You probably don't want the NULL test here.

Cheers,
Ben.
