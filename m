Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E7EB3B7010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 08:58:11 +1000 (EST)
Message-ID: <1340060143.2372.50.camel@pasglop>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 Jun 2012 08:55:43 +1000
In-Reply-To: <CAErSpo6mbzqMuewBySk5kA8E9RwOVZqOEcnM4Hy541B3pta9SQ@mail.gmail.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
 <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
 <CAErSpo6mbzqMuewBySk5kA8E9RwOVZqOEcnM4Hy541B3pta9SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michal Simek <monstr@monstr.eu>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
 microblaze-uclinux@itee.uq.edu.au,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 Jesse Larrew <jlarrew@linux.vnet.ibm.com>, jbarnes@virtuousgeek.org,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-18 at 15:06 -0600, Bjorn Helgaas wrote:
> We're moving the CardBus IRQ config from before pci_bus_add_devices()
> to after.  I see why you did that: we're proposing to do the powerpc
> DMA & IRQ setup in pci_bus_add_devices(), so we don't want to have the
> powerpc IRQ init clobber the CardBus IRQ config.
> 
> But a driver can claim the device as soon as we call
> pci_bus_add_devices(), so we're potentially changing dev->irq after a
> driver has already looked at it, which sounds like a bug.
> 
> There are only five possibilities for powerpc pci_irq_fixup:
> 
>       ppc47x_pci_irq_fixup
>       mpc85xx_cds_pci_irq_fixup
>       maple_pci_irq_fixup
>       pmac_pci_irq_fixup
>       rtas_msi_pci_irq_fixup
> 
> If these were normal PCI header quirks instead, they could run
> earlier, and we wouldn't need to move this
> cardbus_config_irq_and_cls() call.  Is it possible to make these
> quirks, Ben?

Wait ... why are those fixups relevant ? They have to run after
pci_read_irq_line() (which should have been called pcibios_read_irq_line
really) but that's fine, we call both back to back....

The problem has to do with the fact that we setup pdev->irq inside
pci_bus_add_devices() with the new proposed code (the fixup itself is
just a detail).

You want cardbus to "quirk" the irq after that's been fixed up... maybe
that's a case for moving cardbus_config_irq_and_cls() to
pci_enable_device() ? Or add another hook inside
pci_bus_add_devices()...

Cheers,
Ben.
