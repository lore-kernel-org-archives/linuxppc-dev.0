Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E29111A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:03:45 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 12 Feb 2016 16:03:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6D2EA2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:03:43 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1C63SBl21692446
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:03:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1C63AnU000953
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:03:10 +1100
Subject: Re: [PATCH v2 2/4] powerpc/powernv: Fix stale PE primary bus
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1454993431-17068-2-git-send-email-gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56BD7586.7060803@au1.ibm.com>
Date: Fri, 12 Feb 2016 17:02:46 +1100
MIME-Version: 1.0
In-Reply-To: <1454993431-17068-2-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/02/16 15:50, Gavin Shan wrote:
> When PCI bus is unplugged during full hotplug for EEH recovery,
> the platform PE instance (struct pnv_ioda_pe) isn't released and
> it dereferences the stale PCI bus that has been released. It leads
> to kernel crash when referring to the stale PCI bus.
>
> This fixes the issue by correcting the PE's primary bus when it's
> oneline at plugging time, in pnv_pci_dma_bus_setup() which is to
> be called by pcibios_fixup_bus().
>
> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

I realise this has already been merged, but the following was found by 
Coverity:

> +void pnv_pci_dma_bus_setup(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose = bus->sysdata;
> +	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_ioda_pe *pe;
> +
> +	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> +		if (!(pe->flags | (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)))
> +			continue;

This condition is always false. I think the first "|" is supposed to be "&".

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
