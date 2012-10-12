Return-Path: <bhelgaas@google.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F03322C008B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2012 05:03:37 +1100 (EST)
Received: by mail-we0-f179.google.com with SMTP id z49so1768838wey.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 11:03:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340060143.2372.50.camel@pasglop>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
 <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
 <CAErSpo6mbzqMuewBySk5kA8E9RwOVZqOEcnM4Hy541B3pta9SQ@mail.gmail.com>
 <1340060143.2372.50.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 12 Oct 2012 12:03:12 -0600
Message-ID: <CAErSpo5z1ATuoAFcYhTKDk+MSK0Z7RHOfB_gLk=6BtDgxD-=8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Mon, Jun 18, 2012 at 4:55 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-06-18 at 15:06 -0600, Bjorn Helgaas wrote:
>> We're moving the CardBus IRQ config from before pci_bus_add_devices()
>> to after.  I see why you did that: we're proposing to do the powerpc
>> DMA & IRQ setup in pci_bus_add_devices(), so we don't want to have the
>> powerpc IRQ init clobber the CardBus IRQ config.
>>
>> But a driver can claim the device as soon as we call
>> pci_bus_add_devices(), so we're potentially changing dev->irq after a
>> driver has already looked at it, which sounds like a bug.
>>
>> There are only five possibilities for powerpc pci_irq_fixup:
>>
>>       ppc47x_pci_irq_fixup
>>       mpc85xx_cds_pci_irq_fixup
>>       maple_pci_irq_fixup
>>       pmac_pci_irq_fixup
>>       rtas_msi_pci_irq_fixup
>>
>> If these were normal PCI header quirks instead, they could run
>> earlier, and we wouldn't need to move this
>> cardbus_config_irq_and_cls() call.  Is it possible to make these
>> quirks, Ben?
>
> Wait ... why are those fixups relevant ? They have to run after
> pci_read_irq_line() (which should have been called pcibios_read_irq_line
> really) but that's fine, we call both back to back....
>
> The problem has to do with the fact that we setup pdev->irq inside
> pci_bus_add_devices() with the new proposed code (the fixup itself is
> just a detail).
>
> You want cardbus to "quirk" the irq after that's been fixed up... maybe
> that's a case for moving cardbus_config_irq_and_cls() to
> pci_enable_device() ? Or add another hook inside
> pci_bus_add_devices()...

This thread has languished a long time, and I think the original
problem (hot-added e1000e devices on powerpc don't work) still exists,
doesn't it?

I'd like to get a kernel bugzilla opened so (a) this doesn't get
forgotten and (b) we can attach things like dmesg logs showing the
issue.

The current patch does this:

>        pci_bus_add_devices(bus);
> +       cardbus_config_irq_and_cls(bus, s->pci_irq);

I don't think we can do this, because pci_bus_add_devices() can bind a
driver to the device, and we can't change dev->irq after that point.

cardbus_config_irq_and_cls() has to do with the way CardBus interrupts
work, so it seems like it should be better integrated into the PCI
core.  For example, maybe it could be integrated into the
PCI_HEADER_TYPE_CARDBUS case in pci_setup_device().

I think that would still require the powerpc IRQ fixups to be done
earlier, e.g., as a header quirk or a pcibios hook.

Bjorn
