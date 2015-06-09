Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AACF1A0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 16:11:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 9 Jun 2015 16:11:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6617B2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 16:11:28 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t596BINa38666374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 16:11:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t596Atnc023326
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 16:10:56 +1000
Date: Tue, 9 Jun 2015 16:10:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org
Subject: Re: [PATCH v5 42/42] pci/hotplug: PowerPC PowerNV PCI hotplug driver
Message-ID: <20150609061030.GB30787@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-43-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150605201110.GP3631@google.com>
 <1433535495.4526.107.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433535495.4526.107.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 06, 2015 at 06:18:15AM +1000, Benjamin Herrenschmidt wrote:
>On Fri, 2015-06-05 at 15:11 -0500, Bjorn Helgaas wrote:
>
>> You didn't add this, but "pcibios_add_pci_devices" doesn't seem like the
>> right name.  "pcibios" generally refers to an arch-specific hook that's
>> called by the generic PCI core.  In this case, pcibios_add_pci_devices()
>> contains powerpc-specific code, and it's only called from powerpc code, so
>> I think using "pcibios_" in the name is a bit misleading.
>
>Maybe but just calling it pci_add_* makes it easy to confuse with a core
>function and ppc_add_* is gross :-)
>
>> > +	/* Remove all devices behind the slot */
>> > +	pci_lock_rescan_remove();
>> > +	pcibios_remove_pci_devices(slot->bus);
>> 
>> Same comment for pcibios_remove_pci_devices().  It would be better if the
>> name didn't suggest that this was part of the pcibios_ interface between
>> the PCI core and the arch code, because it's not.
>> 
>> > +	/* Slot indentifier */
>> 
>> s/indentifier/identifier/
>> 
>> > +	if (!php_slot_get_id(dn, &id))
>> > +		return NULL;
>> > +
>> 
>> > +	/* PCI bus */
>> > +	bus = pcibios_find_pci_bus(dn);
>> 
>> And pcibios_find_pci_bus() (it's also powerpc-specific).
>
>This one could actually move to of_pci.c and be generic, something like
>of_pci_node_to_bus()
>

Thanks, Ben. I'll rename those functions as below if Bjorn won't object:

pcibios_add_pci_devices()           pci_add_pci_devices()
pcibios_remove_pci_devices()        pci_remove_pci_devices()
pcibios_find_pci_bus()              of_node_to_pci_bus()

Thanks,
Gavin

>Ben.
>
>
