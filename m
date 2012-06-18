Return-Path: <bhelgaas@google.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB471B6FFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 07:07:06 +1000 (EST)
Received: by lban1 with SMTP id n1so4466179lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 14:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
 <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Jun 2012 15:06:41 -0600
Message-ID: <CAErSpo6mbzqMuewBySk5kA8E9RwOVZqOEcnM4Hy541B3pta9SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
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

I'm trying to make some progress on these patches, but I'm concerned
about this bit:

> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
> index 24caeaf..a980691 100644
> --- a/drivers/pcmcia/cardbus.c
> +++ b/drivers/pcmcia/cardbus.c
> @@ -85,7 +84,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0pci_bus_size_bridges(bus);
> =A0 =A0 =A0 =A0pci_bus_assign_resources(bus);
> - =A0 =A0 =A0 cardbus_config_irq_and_cls(bus, s->pci_irq);
>
> =A0 =A0 =A0 =A0/* socket specific tune function */
> =A0 =A0 =A0 =A0if (s->tune_bridge)
> @@ -93,6 +91,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>
> =A0 =A0 =A0 =A0pci_enable_bridges(bus);
> =A0 =A0 =A0 =A0pci_bus_add_devices(bus);
> + =A0 =A0 =A0 cardbus_config_irq_and_cls(bus, s->pci_irq);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}

We're moving the CardBus IRQ config from before pci_bus_add_devices()
to after.  I see why you did that: we're proposing to do the powerpc
DMA & IRQ setup in pci_bus_add_devices(), so we don't want to have the
powerpc IRQ init clobber the CardBus IRQ config.

But a driver can claim the device as soon as we call
pci_bus_add_devices(), so we're potentially changing dev->irq after a
driver has already looked at it, which sounds like a bug.

There are only five possibilities for powerpc pci_irq_fixup:

      ppc47x_pci_irq_fixup
      mpc85xx_cds_pci_irq_fixup
      maple_pci_irq_fixup
      pmac_pci_irq_fixup
      rtas_msi_pci_irq_fixup

If these were normal PCI header quirks instead, they could run
earlier, and we wouldn't need to move this
cardbus_config_irq_and_cls() call.  Is it possible to make these
quirks, Ben?

Bjorn
