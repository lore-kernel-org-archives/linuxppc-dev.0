Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp7v65DMnzDqyh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 01:15:14 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6BFE8pB088669
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 11:15:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243eucek77-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 11:15:11 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 11 Jul 2016 09:15:10 -0600
Subject: Re: [PATCH] rpaphp: fix slot registration for multiple slots under a
 PHB
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
References: <1468019987-1733-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <57803DD2.601@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 mdroth@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 11 Jul 2016 08:15:07 -0700
MIME-Version: 1.0
In-Reply-To: <57803DD2.601@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5783B7FB.1010007@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2016 04:57 PM, Nathan Fontenot wrote:
> On 07/08/2016 06:19 PM, Tyrel Datwyler wrote:
>> PowerVM seems to only ever provide a single hotplug slot per PHB.
>> The under lying slot hotplug registration code assumed multiple slots,
>> but the actual implementation is broken for multiple slots. This went
>> unnoticed for years due to the nature of PowerVM as mentioned
>> previously. Under qemu/kvm the hotplug slot model aligns more with
>> x86 where multiple slots are presented under a single PHB. As seen
>> in the following each additional slot after the first fails to
>> register due to each slot always being compared against the first
>> child node of the PHB in the device tree.
>>
>> [    6.492291] rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
>> [    6.492569] rpaphp: Slot [Slot 0] registered
>> [    6.492577] rpaphp: pci_hp_register failed with error -16
>> [    6.493082] rpaphp: pci_hp_register failed with error -16
>> [    6.493138] rpaphp: pci_hp_register failed with error -16
>> [    6.493161] rpaphp: pci_hp_register failed with error -16
>>
>> The registration logic is fixed so that each slot is compared
>> against the existing child devices of the PHB in the device tree to
>> determine present slots vs empty slots.
>>
>> [   38.481750] rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
>> [   38.482004] rpaphp: Slot [C0] registered
>> [   38.482127] rpaphp: Slot [C1] registered
>> [   38.482241] rpaphp: Slot [C2] registered
>> [   38.482356] rpaphp: Slot [C3] registered
>> [   38.482495] rpaphp: Slot [C4] registered
>>
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/hotplug/rpaphp_slot.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
>> index 6937c72..c90fa8d 100644
>> --- a/drivers/pci/hotplug/rpaphp_slot.c
>> +++ b/drivers/pci/hotplug/rpaphp_slot.c
>> @@ -117,8 +117,10 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
>>  int rpaphp_register_slot(struct slot *slot)
>>  {
>>  	struct hotplug_slot *php_slot = slot->hotplug_slot;
>> +	struct device_node *child;
>> +	u32 my_index;
>>  	int retval;
>> -	int slotno;
>> +	int slotno = -1;
>>
>>  	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
>>  		__func__, slot->dn->full_name, slot->index, slot->name,
>> @@ -130,10 +132,15 @@ int rpaphp_register_slot(struct slot *slot)
>>  		return -EAGAIN;
>>  	}
>>
>> -	if (slot->dn->child)
>> -		slotno = PCI_SLOT(PCI_DN(slot->dn->child)->devfn);
>> -	else
>> -		slotno = -1;
>> +	for_each_child_of_node(slot->dn, child) {
>> +		retval = of_property_read_u32(child, "my,ibm-drc-index", &my_index);
> 
> Shouldn't this be reading ibm,my-drc-index? instead of my,ibm-drc-index.

Doh, indeed it should.

-Tyrel

> 
> -Nathan
> 
>> +		if (my_index == slot->index) {
>> +			slotno = PCI_SLOT(PCI_DN(child)->devfn);
>> +			of_node_put(child);
>> +			break;
>> +		}
>> +	}
>> +
>>  	retval = pci_hp_register(php_slot, slot->bus, slotno, slot->name);
>>  	if (retval) {
>>  		err("pci_hp_register failed with error %d\n", retval);
>>
> 
