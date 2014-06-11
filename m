Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DDAB1A08A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 19:00:32 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 19:00:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A9C063578054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 19:00:26 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8iLe833226924
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:44:21 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B90PXa017777
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 19:00:26 +1000
Date: Wed, 11 Jun 2014 17:00:23 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: reduce multi-hit of pcibios_setup_device() in
 hotplug
Message-ID: <20140611090023.GA13419@richard>
References: <1399530602-4231-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1399863559.17624.66.camel@pasglop>
 <20140611071241.GA10729@richard>
 <1402471784.14780.45.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402471784.14780.45.camel@pasglop>
Cc: Bjorn Helgaas <bhelgaas@google.com>, aik@au1.ibm.com,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2014 at 05:29:44PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2014-06-11 at 15:12 +0800, Wei Yang wrote:
>
>> Sorry for the long delay. It took me some time to investigate and test the code.
>> Currently, the hotplug by qemu monitor command line has been verified. Two pci
>> device on the same bus have been hotpluged one by one successfully.
>> 
>> Another case in my mind is the EEH hotplug, which requires code in
>> Qemu/Sapphire/Kernel. I will did further test later.
>> 
>> Below is the patch which is verified in guest with monitor command line. If my
>> understanding is not correct, please let me know :-)
>
>Please verify under pHyp, the code path are a bit different.

Yep, I will test it.

>
>Cheers,
>Ben.
>
>> >From 69c5f014836b24897356731c39cbaf18f4563573 Mon Sep 17 00:00:00 2001
>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Date: Tue, 10 Jun 2014 15:28:53 +0800
>> Subject: [PATCH] powerpc/pci: Use bus->is_added in of_scan_bus() as in
>>  general platform
>> 
>> When scan the pci bus on general platform, it use bus->is_added to mark the
>> bus has been added successfully. While this flag is not used when the bus scan
>> relies on device node. Instead, it uses a particular parameter
>> "rescan_existing" to play the same role.
>> 
>> This patch enables the bus->is_added when device node is used, drops the
>> "rescan_existing" parameter. Also it skip the pcibios_setup_bus_devices()
>> procedure when bus has already been added, since the pcibios_setup_device()
>> step is done in pci_device_add() when the bus is already added.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/pci_of_scan.c |   14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
>> index 83c26d8..3e943ab 100644
>> --- a/arch/powerpc/kernel/pci_of_scan.c
>> +++ b/arch/powerpc/kernel/pci_of_scan.c
>> @@ -334,10 +334,8 @@ static struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
>>   * __of_scan_bus - given a PCI bus node, setup bus and scan for child devices
>>   * @node: device tree node for the PCI bus
>>   * @bus: pci_bus structure for the PCI bus
>> - * @rescan_existing: Flag indicating bus has already been set up
>>   */
>> -static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
>> -			  int rescan_existing)
>> +static void __of_scan_bus(struct device_node *node, struct pci_bus *bus)
>>  {
>>  	struct device_node *child;
>>  	struct pci_dev *dev;
>> @@ -356,9 +354,11 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
>>  	/* Apply all fixups necessary. We don't fixup the bus "self"
>>  	 * for an existing bridge that is being rescanned
>>  	 */
>> -	if (!rescan_existing)
>> +	if (!bus->is_added) {
>>  		pcibios_setup_bus_self(bus);
>> -	pcibios_setup_bus_devices(bus);
>> +		pcibios_setup_bus_devices(bus);
>> +		bus->is_added = 1;
>> +	}
>>  
>>  	/* Now scan child busses */
>>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>> @@ -376,7 +376,7 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
>>   */
>>  void of_scan_bus(struct device_node *node, struct pci_bus *bus)
>>  {
>> -	__of_scan_bus(node, bus, 0);
>> +	__of_scan_bus(node, bus);
>>  }
>>  EXPORT_SYMBOL_GPL(of_scan_bus);
>>  
>> @@ -390,7 +390,7 @@ EXPORT_SYMBOL_GPL(of_scan_bus);
>>   */
>>  void of_rescan_bus(struct device_node *node, struct pci_bus *bus)
>>  {
>> -	__of_scan_bus(node, bus, 1);
>> +	__of_scan_bus(node, bus);
>>  }
>>  EXPORT_SYMBOL_GPL(of_rescan_bus);
>>  
>> -- 
>> 1.7.9.5
>> 
>> >
>> >
>> >_______________________________________________
>> >Linuxppc-dev mailing list
>> >Linuxppc-dev@lists.ozlabs.org
>> >https://lists.ozlabs.org/listinfo/linuxppc-dev
>> 
>

-- 
Richard Yang
Help you, Help me
