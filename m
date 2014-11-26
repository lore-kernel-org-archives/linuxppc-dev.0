Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402891A0259
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 11:08:34 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 10:08:33 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B17932CE8070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 11:08:31 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQ08VLm42205270
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 11:08:31 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQ08U88020551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 11:08:31 +1100
Date: Wed, 26 Nov 2014 11:08:30 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] powerpc/pci: Move pcibios_find_pci_bus() around
Message-ID: <20141126000830.GA21766@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416869365-7671-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416956310.5089.5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416956310.5089.5.camel@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 09:58:30AM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2014-11-25 at 09:49 +1100, Gavin Shan wrote:
>> The patch moves pcibios_find_pci_bus() to PPC kerenl directory so
>> that it can be reused by hotplug code for pSeries and PowerNV
>> platform at the same time.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>

Thanks, Ben. But Michael needn't pick it up and merge it as the left
patches need reworks to some extent...

Thanks,
Gavin

>> ---
>>  arch/powerpc/kernel/pci-hotplug.c          | 36 ++++++++++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/pci_dlpar.c | 32 --------------------------
>>  2 files changed, 36 insertions(+), 32 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>> index 5b78917..6e2b4e3 100644
>> --- a/arch/powerpc/kernel/pci-hotplug.c
>> +++ b/arch/powerpc/kernel/pci-hotplug.c
>> @@ -21,6 +21,42 @@
>>  #include <asm/firmware.h>
>>  #include <asm/eeh.h>
>>  
>> +static struct pci_bus *find_pci_bus(struct pci_bus *bus,
>> +				    struct device_node *dn)
>> +{
>> +	struct pci_bus *tmp, *child = NULL;
>> +	struct device_node *busdn;
>> +
>> +	busdn = pci_bus_to_OF_node(bus);
>> +	if (busdn == dn)
>> +		return bus;
>> +
>> +	list_for_each_entry(tmp, &bus->children, node) {
>> +		child = find_pci_bus(tmp, dn);
>> +		if (child)
>> +			break;
>> +	}
>> +
>> +	return child;
>> +}
>> +
>> +/**
>> + * pcibios_find_pci_bus - find PCI bus according to the given device node
>> + * @dn: Device node
>> + *
>> + * Find the corresponding PCI bus according to the given device node.
>> + */
>> +struct pci_bus *pcibios_find_pci_bus(struct device_node *dn)
>> +{
>> +	struct pci_dn *pdn = PCI_DN(dn);
>> +
>> +	if (!pdn  || !pdn->phb || !pdn->phb->bus)
>> +		return NULL;
>> +
>> +	return find_pci_bus(pdn->phb->bus, dn);
>> +}
>> +EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
>> +
>>  /**
>>   * pcibios_release_device - release PCI device
>>   * @dev: PCI device
>> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
>> index 89e2381..98c50bc 100644
>> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
>> @@ -32,38 +32,6 @@
>>  #include <asm/firmware.h>
>>  #include <asm/eeh.h>
>>  
>> -static struct pci_bus *
>> -find_bus_among_children(struct pci_bus *bus,
>> -                        struct device_node *dn)
>> -{
>> -	struct pci_bus *child = NULL;
>> -	struct pci_bus *tmp;
>> -	struct device_node *busdn;
>> -
>> -	busdn = pci_bus_to_OF_node(bus);
>> -	if (busdn == dn)
>> -		return bus;
>> -
>> -	list_for_each_entry(tmp, &bus->children, node) {
>> -		child = find_bus_among_children(tmp, dn);
>> -		if (child)
>> -			break;
>> -	};
>> -	return child;
>> -}
>> -
>> -struct pci_bus *
>> -pcibios_find_pci_bus(struct device_node *dn)
>> -{
>> -	struct pci_dn *pdn = dn->data;
>> -
>> -	if (!pdn  || !pdn->phb || !pdn->phb->bus)
>> -		return NULL;
>> -
>> -	return find_bus_among_children(pdn->phb->bus, dn);
>> -}
>> -EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
>> -
>>  struct pci_controller *init_phb_dynamic(struct device_node *dn)
>>  {
>>  	struct pci_controller *phb;
>
>
