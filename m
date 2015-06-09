Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2B5C1A0DDE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 16:11:57 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 9 Jun 2015 16:11:53 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9C52E2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 16:11:50 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t596BgOH917848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 16:11:50 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t596BHgh006083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 16:11:17 +1000
Date: Tue, 9 Jun 2015 16:10:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, aik@ozlabs.ru, panto@antoniou-consulting.com,
 robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v5 31/42] powerpc/pci: Move pcibios_find_pci_bus() around
Message-ID: <20150609061052.GA387@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-32-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150605194730.GO3631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150605194730.GO3631@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 05, 2015 at 02:47:30PM -0500, Bjorn Helgaas wrote:
>"Move pcibios_find_pci_bus() from pSeries to generic powerpc code"?
>
>On Thu, Jun 04, 2015 at 04:42:00PM +1000, Gavin Shan wrote:
>> The patch moves pcibios_find_pci_bus() to PPC kerenl directory so
>
>s/kerenl/kernel/
>

Thanks. I'll fix it in next revision.

Thanks,
Gavin

>> that it can be reused by hotplug code for pSeries and PowerNV
>> platform at the same time.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>> v5:
>>   * Derived from PATCH[v4 12/21]
>> ---
>>  arch/powerpc/kernel/pci-hotplug.c          | 36 ++++++++++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/pci_dlpar.c | 32 --------------------------
>>  2 files changed, 36 insertions(+), 32 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>> index ca392fc..1482bc1 100644
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
>> index 5d4a3df..906dbaa 100644
>> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
>> @@ -34,38 +34,6 @@
>>  
>>  #include "pseries.h"
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
>> -- 
>> 2.1.0
>> 
>
