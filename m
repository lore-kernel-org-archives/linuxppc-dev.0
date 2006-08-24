Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58C0F67C24
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 13:46:42 +1000 (EST)
Subject: Re: [PATCH 2/3] Fix MPC834x SYS platform to get IRQ data from
	device tree and use new IRQ layer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20060823203937.578cae45.kim.phillips@freescale.com>
References: <20060823203937.578cae45.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 13:46:26 +1000
Message-Id: <1156391186.8433.168.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +void __init mpc83xx_pcibios_fixup(void)
> +{
> +	struct pci_dev *dev = NULL;
> +
> +	/* map all the PCI irqs */
> +	dev = NULL;
> +	for_each_pci_dev(dev)
> +		pci_read_irq_line(dev);
> +}
> +
Some seriously redundant assignements above :) I'm not even sure we need
the initial assignement at all in the first place anyway.

Appart from that, looks good.

Cheers,
Ben.
