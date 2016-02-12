Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AB081A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:10:25 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 16:10:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0D676357803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:10:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1C6A7rZ28573778
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:10:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1C69n1n014322
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:09:49 +1100
Date: Fri, 12 Feb 2016 17:09:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH v2 2/4] powerpc/powernv: Fix stale PE primary bus
Message-ID: <20160212060924.GA9809@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1454993431-17068-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <56BD7586.7060803@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BD7586.7060803@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 12, 2016 at 05:02:46PM +1100, Andrew Donnellan wrote:
>On 09/02/16 15:50, Gavin Shan wrote:
>>When PCI bus is unplugged during full hotplug for EEH recovery,
>>the platform PE instance (struct pnv_ioda_pe) isn't released and
>>it dereferences the stale PCI bus that has been released. It leads
>>to kernel crash when referring to the stale PCI bus.
>>
>>This fixes the issue by correcting the PE's primary bus when it's
>>oneline at plugging time, in pnv_pci_dma_bus_setup() which is to
>>be called by pcibios_fixup_bus().
>>
>>Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
>I realise this has already been merged, but the following was found by
>Coverity:
>
>>+void pnv_pci_dma_bus_setup(struct pci_bus *bus)
>>+{
>>+	struct pci_controller *hose = bus->sysdata;
>>+	struct pnv_phb *phb = hose->private_data;
>>+	struct pnv_ioda_pe *pe;
>>+
>>+	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>+		if (!(pe->flags | (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)))
>>+			continue;
>
>This condition is always false. I think the first "|" is supposed to be "&".
>

Yeah, that should be "&". I think the problem isn't found when doing
testing in non-SRIOV environment. Thanks for pointing it out.

Michael, please let me know if I need send a follow-up revision to
correct this one? I found the first two patches have been put into
linux-next branch. I think we probably just need repost the correct
version for this one only.

Thanks,
Gavin

>-- 
>Andrew Donnellan              Software Engineer, OzLabs
>andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
>+61 2 6201 8874 (work)        IBM Australia Limited
