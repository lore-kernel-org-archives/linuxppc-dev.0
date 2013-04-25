Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAB3F2C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:08:47 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 04:08:44 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3E866C9001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 04:08:42 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P88gcX239474
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 04:08:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P88fDG017452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 05:08:42 -0300
Date: Thu, 25 Apr 2013 16:08:37 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/7] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130425080836.GA27415@shangw.(null)>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366796259-29412-5-git-send-email-shangw@linux.vnet.ibm.com>
 <1366836580.2869.16.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366836580.2869.16.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 06:49:40AM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-04-24 at 17:37 +0800, Gavin Shan wrote:
>> The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
>> steps to handle the P/Q bits in IVE before EOIing the corresponding
>> interrupt. The patch changes the EOI handler to cover that.
>
> .../...
>
>>  static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
>>  {
>>  	unsigned int count;
>> @@ -667,6 +681,8 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
>>  	}
>>  
>>  	phb->msi_setup = pnv_pci_ioda_msi_setup;
>> +	if (phb->type == PNV_PHB_IODA2)
>> +		phb->msi_eoi = pnv_pci_ioda_msi_eoi;
>
>Ouch, another function pointer call in a hot path...
>

Yeah. I've removed it in next version (not send out yet) :-)

>>  	phb->msi32_support = 1;
>>  	pr_info("  Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
>>  		count, phb->msi_base);
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index a11b5a6..ea6a93d 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -115,6 +115,25 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
>>  		irq_dispose_mapping(entry->irq);
>>  	}
>>  }
>> +
>> +int pnv_pci_msi_eoi(unsigned int hw_irq)
>> +{
>> +	struct pci_controller *hose, *tmp;
>> +	struct pnv_phb *phb = NULL;
>> +
>> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>> +		phb = hose->private_data;
>> +		if (hw_irq >= phb->msi_base &&
>> +		    hw_irq < phb->msi_base + phb->msi_bmp.irq_count) {
>> +			if (!phb->msi_eoi)
>> +				return -EEXIST;
>> +			return phb->msi_eoi(phb, hw_irq);
>> +		}
>> +	}
>> +
>> +	/* For LSI interrupts, we needn't do it */
>> +	return 0;
>> +}
>
>And a list walk ... that's not right.
>
>Also, you do it for all XICS interrupts, including the non-PCI ones, the
>LSIs, etc... only to figure out that some might not be MSIs later in
>the loop.
>
>Why not instead look at changing the irq_chip for the MSIs ?
>
>IE. When setting up the MSIs for IODA2, use a different irq_chip which
>is a copy of the original one with a different ->eoi callback, which
>does the original xics eoi and then the OPAL stuff ?
>
>You might even be able to use something like container_of to get back
>to the struct phb, no need to iterate them all.
>

Thanks for the detailed explaining, Ben.

I found irq_data hasn't been fully utilized until this moment. I already
have code to start use that. Firstly, "irq_data" is set to the PHB OPAL ID
or invalid value (0xffs) during mapping stage (there, we call irq_set_chip_data()
to trace the PHB OPAL ID or invalid value). Before EOIing the interrupt, we
will check "irq_data" and do special handling on P/Q bits if it has valid value.
With it, the "hot" path should be fast enough and the function pointer (mentioned
above) can be removed.

Thanks,
Gavin
