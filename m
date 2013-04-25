Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43C412C010B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:13:46 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 02:13:43 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BFEAD19D8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 02:13:34 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P8Dd4p126518
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 02:13:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P8DcnR001677
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 02:13:39 -0600
Date: Thu, 25 Apr 2013 16:13:33 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/7] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130425081333.GA10637@shangw.(null)>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366796259-29412-5-git-send-email-shangw@linux.vnet.ibm.com>
 <1366836580.2869.16.camel@pasglop>
 <20130425080836.GA27415@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130425080836.GA27415@shangw.(null)>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 04:08:37PM +0800, Gavin Shan wrote:
>On Thu, Apr 25, 2013 at 06:49:40AM +1000, Benjamin Herrenschmidt wrote:
>>On Wed, 2013-04-24 at 17:37 +0800, Gavin Shan wrote:
>>> The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
>>> steps to handle the P/Q bits in IVE before EOIing the corresponding
>>> interrupt. The patch changes the EOI handler to cover that.
>>
>> .../...
>>

.../...

>>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>>> index a11b5a6..ea6a93d 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.c
>>> +++ b/arch/powerpc/platforms/powernv/pci.c
>>> @@ -115,6 +115,25 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
>>>  		irq_dispose_mapping(entry->irq);
>>>  	}
>>>  }
>>> +
>>> +int pnv_pci_msi_eoi(unsigned int hw_irq)
>>> +{
>>> +	struct pci_controller *hose, *tmp;
>>> +	struct pnv_phb *phb = NULL;
>>> +
>>> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>> +		phb = hose->private_data;
>>> +		if (hw_irq >= phb->msi_base &&
>>> +		    hw_irq < phb->msi_base + phb->msi_bmp.irq_count) {
>>> +			if (!phb->msi_eoi)
>>> +				return -EEXIST;
>>> +			return phb->msi_eoi(phb, hw_irq);
>>> +		}
>>> +	}
>>> +
>>> +	/* For LSI interrupts, we needn't do it */
>>> +	return 0;
>>> +}
>>
>>And a list walk ... that's not right.
>>
>>Also, you do it for all XICS interrupts, including the non-PCI ones, the
>>LSIs, etc... only to figure out that some might not be MSIs later in
>>the loop.
>>
>>Why not instead look at changing the irq_chip for the MSIs ?
>>
>>IE. When setting up the MSIs for IODA2, use a different irq_chip which
>>is a copy of the original one with a different ->eoi callback, which
>>does the original xics eoi and then the OPAL stuff ?
>>
>>You might even be able to use something like container_of to get back
>>to the struct phb, no need to iterate them all.
>>
>
>Thanks for the detailed explaining, Ben.
>
>I found irq_data hasn't been fully utilized until this moment. I already
>have code to start use that. Firstly, "irq_data" is set to the PHB OPAL ID
>or invalid value (0xffs) during mapping stage (there, we call irq_set_chip_data()
>to trace the PHB OPAL ID or invalid value). Before EOIing the interrupt, we
>will check "irq_data" and do special handling on P/Q bits if it has valid value.
>With it, the "hot" path should be fast enough and the function pointer (mentioned
>above) can be removed.
>

It should be "chip_data" (not "irq_data"). Hopefully, you haven't
get time to see the reply. Otherwise, it would a bit confused ;-)

Thanks,
Gavin
