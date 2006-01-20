Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 15D46681B8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 22:16:40 +1100 (EST)
Date: Fri, 20 Jan 2006 12:16:38 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137708554.12998.31.camel@localhost.localdomain>
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
Message-ID: <17310.1137755798@www009.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> Datum: Fri, 20 Jan 2006 09:09:13 +1100
> 
> > > Makes sense, since this value is right in the middle of your RAM :)
> > > What does the firmware sets the base register too ?
> > I did a readout of all AGP related registers and the base register was
> > set to 0x0, so the firmware doesn't set it up at all.
> > 
> > > Can't you try to allocate some resource in the PCI area that isn't
> > > already occupied instead ?
> > I though the GART base address should be in memory space!?
> 
> Euh... I was talking about the aperture base, not the GART base... (One
> is the address one the bus where the AGP area will be visible, the other
> is where the GART will be in memory, that is the table that contains the
> mapping between AGP pages and memory pages).
Doh! :) Actually I meant the aperture base. That was a communication error
between brain and hands. :) 

> > Sorry for this dumb question: how can I allocate a resource in the PCI
> > area? I'm not yet familiar with the whole Linux PCI/MM API. :) With
> > something like pci_alloc_consistent()?
> 
> Nope... look at drivers/pci/setup-res.c how it does for allocating new
> resources for PCI devices.
I guess you mean something like this code snipped from the efficeon-agp.c
source code (with pci_assign_resource()):

---

/*
 * The following fixes the case where the BIOS has "forgotten" to
 * provide an address range for the GART.
 * 20030610 - hamish@zot.org
 */
r = &pdev->resource[0];
if (!r->start && r->end) {
   if(pci_assign_resource(pdev, 0)) {
      printk(KERN_ERR PFX "could not assign resource 0\n");
      return -ENODEV;
   }
}

/*
 * If the device has not been properly setup, the following will catch
 * the problem and should stop the system from crashing.
 * 20030610 - hamish@zot.org
 */
if (pci_enable_device(pdev)) {
   printk(KERN_ERR PFX "Unable to Enable PCI device\n");
   return -ENODEV;
}

/* Fill in the mode register */
if (cap_ptr) {
   pci_read_config_dword(pdev,
   bridge->capndx+PCI_AGP_STATUS, &bridge->mode);
}

pci_set_drvdata(pdev, bridge);

----

BTW: I took a look at the PCI resources list of the AmigaOne and found out
that the resources of the AGP graphic card are allocated to bus 0 (PCI
only). IMHO their allocation should be assigned to bus 1 (AGP) (at least
this is the case on x86!?), so I think this should be fixed. Is my
assumption correct?

Thanks!

Gerhard

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
