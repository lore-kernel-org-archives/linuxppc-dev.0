Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E6CF1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 09:45:01 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 08:45:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9B8C23578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 09:44:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FMio3U5702006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 09:44:58 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FMiPRx012500
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 09:44:26 +1100
Date: Tue, 16 Feb 2016 09:43:58 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/4] powerpc/powernv: Fix stale PE primary bus
Message-ID: <20160215224358.GA9417@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1454993431-17068-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <56BD7586.7060803@au1.ibm.com> <20160212060924.GA9809@gwshan>
 <1455532715.26205.9.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455532715.26205.9.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 15, 2016 at 09:38:35PM +1100, Michael Ellerman wrote:
>On Fri, 2016-02-12 at 17:09 +1100, Gavin Shan wrote:
>
>> On Fri, Feb 12, 2016 at 05:02:46PM +1100, Andrew Donnellan wrote:
>
>> > On 09/02/16 15:50, Gavin Shan wrote:
>
>> > > When PCI bus is unplugged during full hotplug for EEH recovery,
>> > > the platform PE instance (struct pnv_ioda_pe) isn't released and
>> > > it dereferences the stale PCI bus that has been released. It leads
>> > > to kernel crash when referring to the stale PCI bus.
>> > > 
>> > > This fixes the issue by correcting the PE's primary bus when it's
>> > > oneline at plugging time, in pnv_pci_dma_bus_setup() which is to
>> > > be called by pcibios_fixup_bus().
>> > > 
>> > > Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> > > Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
>> > > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> > > Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> > 
>> > I realise this has already been merged, but the following was found by
>> > Coverity:
>> > 
>
>> > > +void pnv_pci_dma_bus_setup(struct pci_bus *bus)
>> > > +{
>> > > +	struct pci_controller *hose = bus->sysdata;
>> > > +	struct pnv_phb *phb = hose->private_data;
>> > > +	struct pnv_ioda_pe *pe;
>> > > +
>> > > +	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>> > > +		if (!(pe->flags | (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)))
>> > > +			continue;
>> > 
>> > This condition is always false. I think the first "|" is supposed to be "&".
>> > 
>> 
>> Yeah, that should be "&". I think the problem isn't found when doing
>> testing in non-SRIOV environment. Thanks for pointing it out.
>> 
>> Michael, please let me know if I need send a follow-up revision to
>> correct this one? I found the first two patches have been put into
>> linux-next branch. I think we probably just need repost the correct
>> version for this one only.
>
>As it happens I needed to rebase my fixes branch anyway, so I've updated it and
>rebased. No further action required :)
>

Thanks Michael. Sorry for the rebase :-)

Thanks,
Gavin
