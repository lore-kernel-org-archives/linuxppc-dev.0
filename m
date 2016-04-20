Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqT9l5RV7zDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 14:17:15 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id 184so13879191pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 21:17:15 -0700 (PDT)
Subject: Re: [PATCH v8 37/45] powerpc/powernv: Use firmware PCI slot reset
 infrastructure
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-38-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715FBBF.2000108@ozlabs.ru> <20160420023306.GD28594@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <571702C3.406@ozlabs.ru>
Date: Wed, 20 Apr 2016 14:17:07 +1000
MIME-Version: 1.0
In-Reply-To: <20160420023306.GD28594@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2016 12:33 PM, Gavin Shan wrote:
> On Tue, Apr 19, 2016 at 07:34:55PM +1000, Alexey Kardashevskiy wrote:
>> On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>> The skiboot firmware might provide the PCI slot reset capability
>>> which is identified by property "ibm,reset-by-firmware" on the
>>> PCI slot associated device node.
>>>
>>> This checks the property. If it exists, the reset request is routed
>>> to firmware. Otherwise, the reset is done by kernel as before.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++++++++++++++++++++++++-
>>>   1 file changed, 40 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> index e23b063..c8a5217 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -789,7 +789,7 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
>>>   	return ret;
>>>   }
>>>
>>> -static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>> +static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>>   {
>>>   	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
>>>   	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>> @@ -840,6 +840,45 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>>   	return 0;
>>>   }
>>>
>>> +static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
>>> +{
>>> +	struct pci_controller *hose;
>>> +	struct pnv_phb *phb;
>>> +	struct device_node *dn = pdev ? pci_device_to_OF_node(pdev) : NULL;
>>> +	uint64_t id = (0x1ul << 60);
>>
>>
>> What is this 1<<60 for?
>>
>>
>
> As you replied in other threads, it's worthy to have some macros for this
> piece of business. This bit indicates the ID of the slot behind a switch
> port. If this bit is cleared, the ID represents a PHB slot.
>
>>> +	uint8_t scope;
>>> +	int64_t rc;
>>> +
>>> +	/*
>>> +	 * If the firmware can't handle it, we will issue hot reset
>>> +	 * on the secondary bus despite the requested reset type.
>>> +	 */
>>> +	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
>>> +		return __pnv_eeh_bridge_reset(pdev, option);
>>> +
>>> +	/* The firmware can handle the request */
>>> +	switch (option) {
>>> +	case EEH_RESET_HOT:
>>> +		scope = OPAL_RESET_PCI_HOT;
>>> +		break;
>>> +	case EEH_RESET_FUNDAMENTAL:
>>> +		scope = OPAL_RESET_PCI_FUNDAMENTAL;
>>> +		break;
>>> +	case EEH_RESET_DEACTIVATE:
>>> +		return 0;
>>> +	default:
>>> +		dev_warn(&pdev->dev, "%s: Unsupported reset %d\n",
>>> +			 __func__, option);
>>
>>
>> Can the userspace trigger this case (via VFIO-EEH) and flood dmesg?
>>
>
> It depends on how you defined message flooding actually. It's abnormal
> path caused by program internal error, not external users.


Can QEMU be changed to do something special (cause reset with a wrong 
option) via VFIO/EEH interface in a loop to make this message appear? Or 
the call with a wrong option will never reach this point?


>
>>
>>
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	hose = pci_bus_to_host(pdev->bus);
>>> +	phb = hose->private_data;
>>> +	id |= (pdev->bus->number << 24) | (pdev->devfn << 16) | phb->opal_id;
>>> +	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
>>> +	return pnv_pci_poll(id, rc, NULL);
>>> +}
>>> +
>>>   static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>>>   {
>>>   	int *freset = data;
>>>
>>
>>
>> --
>> Alexey
>>
>


-- 
Alexey
