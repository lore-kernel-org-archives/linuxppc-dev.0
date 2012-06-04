Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8623AB6FD4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 19:18:59 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 4 Jun 2012 03:18:55 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id F2285C90052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 05:18:51 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q549Ip59138148
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2012 05:18:52 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q549IpRK012348
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2012 03:18:51 -0600
Date: Mon, 4 Jun 2012 17:18:49 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: save P2P bridge resource if possible
Message-ID: <20120604091849.GA13569@shangw>
References: <1338797725-2231-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1338800122.7150.70.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338800122.7150.70.camel@pasglop>
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> When PCI probe flag PCI_REASSIGN_ALL_RSRC has been passed into PCI
>> core, it's hoped that all resources to be reassigned by PCI core.
>> As to particular P2P (PCI-to-PCI) bridge, the size of the corresponding
>> BAR (I/O, MMIO, prefetchable MMIO) is calculated by the resources
>> required by the PCI devices behind the P2P bridge. That means that
>> the information like start/end address retrieved from the hardware
>> registers of the P2P bridge is meainingless in the case. However,
>> we still count that in and the BARs might have been configured by
>> firmware with non-zero size. That leads to space waste.
>> 
>> The patch explicitly sets the size of P2P bridge BARs to zero in
>> case that resource reassignment is expected with PCI probe flag
>> PCI_REASSIGN_ALL_RSRC. In the result, it will save overall resource
>> required by the system without waste.
>
>Hrm... there was a reason I wasn't doing that .... but I can't
>remember what it was, it's possible it no longer applies. I'll
>have to make sure this patch is tested on various 4xx and FSL
>configs.
>

Ok. Thanks, Ben. By the way, I've tested it on Firebird-L machine
while passing PCI_REASSIGN_ALL_RSRC into PCI core. Everything looks
fine :-)

>Cheers,
>Ben.

Thanks,
Gavin

>
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/pci-common.c |   16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 8e78e93..0fe214d 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -966,13 +966,14 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
>>  		if (i >= 3 && bus->self->transparent)
>>  			continue;
>>  
>> -		/* If we are going to re-assign everything, mark the resource
>> -		 * as unset and move it down to 0
>> +		/* If we're going to reassign everything, we can
>> +		 * shrink the P2P resource to have size as being
>> +		 * of 0 in order to save space.
>>  		 */
>>  		if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
>>  			res->flags |= IORESOURCE_UNSET;
>> -			res->end -= res->start;
>>  			res->start = 0;
>> +			res->end = -1;
>>  			continue;
>>  		}
>>  
>> @@ -1234,7 +1235,14 @@ void pcibios_allocate_bus_resources(struct pci_bus *bus)
>>  		pr_warning("PCI: Cannot allocate resource region "
>>  			   "%d of PCI bridge %d, will remap\n", i, bus->number);
>>  	clear_resource:
>> -		res->start = res->end = 0;
>> +		/* The resource might be figured out when doing
>> +		 * reassignment based on the resources required
>> +		 * by the downstream PCI devices. Here we set
>> +		 * the size of the resource to be 0 in order to
>> +		 * save more space.
>> +		 */
>> +		res->start = 0;
>> +		res->end = -1;
>>  		res->flags = 0;
>>  	}
>>  
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
>
