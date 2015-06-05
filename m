Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B487A1A089C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 06:18:34 +1000 (AEST)
Message-ID: <1433535495.4526.107.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 42/42] pci/hotplug: PowerPC PowerNV PCI hotplug driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org
Date: Sat, 06 Jun 2015 06:18:15 +1000
In-Reply-To: <20150605201110.GP3631@google.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-43-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150605201110.GP3631@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-06-05 at 15:11 -0500, Bjorn Helgaas wrote:

> You didn't add this, but "pcibios_add_pci_devices" doesn't seem like the
> right name.  "pcibios" generally refers to an arch-specific hook that's
> called by the generic PCI core.  In this case, pcibios_add_pci_devices()
> contains powerpc-specific code, and it's only called from powerpc code, so
> I think using "pcibios_" in the name is a bit misleading.

Maybe but just calling it pci_add_* makes it easy to confuse with a core
function and ppc_add_* is gross :-)

> > +	/* Remove all devices behind the slot */
> > +	pci_lock_rescan_remove();
> > +	pcibios_remove_pci_devices(slot->bus);
> 
> Same comment for pcibios_remove_pci_devices().  It would be better if the
> name didn't suggest that this was part of the pcibios_ interface between
> the PCI core and the arch code, because it's not.
> 
> > +	/* Slot indentifier */
> 
> s/indentifier/identifier/
> 
> > +	if (!php_slot_get_id(dn, &id))
> > +		return NULL;
> > +
> 
> > +	/* PCI bus */
> > +	bus = pcibios_find_pci_bus(dn);
> 
> And pcibios_find_pci_bus() (it's also powerpc-specific).

This one could actually move to of_pci.c and be generic, something like
of_pci_node_to_bus()

Ben.
