Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5425B1A0AF0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:36:08 +1100 (AEDT)
Received: by pacfv9 with SMTP id fv9so69224398pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 00:36:06 -0700 (PDT)
Subject: Re: [PATCH V10 06/12] powerpc/powernv: EEH device for VF
To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632E51D.30805@ozlabs.ru> <20151030065246.GC5940@richards-mbp.cn.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56331DE1.1090500@ozlabs.ru>
Date: Fri, 30 Oct 2015 18:36:01 +1100
MIME-Version: 1.0
In-Reply-To: <20151030065246.GC5940@richards-mbp.cn.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/30/2015 05:52 PM, Wei Yang wrote:
> On Fri, Oct 30, 2015 at 02:33:49PM +1100, Alexey Kardashevskiy wrote:
>> On 10/26/2015 02:15 PM, Wei Yang wrote:
>>> VFs and their corresponding pci_dn instances are created and released
>>> dynamically as their PF's SRIOV capability is enabled and disabled.
>>> The patch creates and releases EEH devices for VFs when creating and
>>> releasing their pci_dn instances, which means EEH devices and pci_dn
>>> instances have same life cycle. Also, VF's EEH device is identified
>>> by (struct eeh_dev::physfn).
>>
>>
>> The add_dev_pci_data() helper (the one you hack) does not create pci_dn
>> instances. The add_one_dev_pci_data() helper does.
>>
>
> Yes, you are right. The patch here create edev after the pci_dn is created.
>
> So which part in the log you think is not accurate?


The commit log is ok, I just thought loud that eeh_dev_init() could go to 
add_one_dev_pci_data() to make things more clear.



>>
>>>
>>> [gwshan: changelog and removed CONFIG_PCI_IOV]
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/eeh.h |  1 +
>>>   arch/powerpc/kernel/pci_dn.c   | 12 ++++++++++++
>>>   2 files changed, 13 insertions(+)
>>>
>>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>> index c5eb86f..6c383ad 100644
>>> --- a/arch/powerpc/include/asm/eeh.h
>>> +++ b/arch/powerpc/include/asm/eeh.h
>>> @@ -140,6 +140,7 @@ struct eeh_dev {
>>>   	struct pci_controller *phb;	/* Associated PHB		*/
>>>   	struct pci_dn *pdn;		/* Associated PCI device node	*/
>>>   	struct pci_dev *pdev;		/* Associated PCI device	*/
>>> +	struct pci_dev *physfn;		/* Associated PF PORT		*/
>>>   	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
>>>   };
>>>
>>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>> index f771130..f0ddde7 100644
>>> --- a/arch/powerpc/kernel/pci_dn.c
>>> +++ b/arch/powerpc/kernel/pci_dn.c
>>> @@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>>   struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>>   {
>>>   #ifdef CONFIG_PCI_IOV
>>> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>>>   	struct pci_dn *parent, *pdn;
>>> +	struct eeh_dev *edev;
>>>   	int i;
>>>
>>>   	/* Only support IOV for now */
>>> @@ -206,6 +208,9 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>>   				 __func__, i);
>>>   			return NULL;
>>>   		}
>>> +		eeh_dev_init(pdn, hose);
>>> +		edev = pdn_to_eeh_dev(pdn);
>>
>>
>> In theory, pdn_to_eeh_dev() can return NULL. In this patch, it is not clear
>> if pdn->edev gets initialized before or after add_dev_pci_data().
>>
>
> Yep, the return value should be checked.

May be BUG_ON will be enough, up to you.


>
> pdn->edev is initialized in eeh_dev_init() which is called in
> add_dev_pci_data(). The order is not clear?
>
>>
>>
>>> +		edev->physfn = pdev;
>>>   	}
>>>   #endif /* CONFIG_PCI_IOV */
>>>
>>> @@ -254,10 +259,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
>>>   	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>>>   		list_for_each_entry_safe(pdn, tmp,
>>>   			&parent->child_list, list) {
>>> +			struct eeh_dev *edev;
>>>   			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
>>>   			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
>>>   				continue;
>>>
>>> +			edev = pdn_to_eeh_dev(pdn);
>>> +			if (edev) {
>>> +				pdn->edev = NULL;
>>> +				kfree(edev);
>>> +			}
>>> +
>>>   			if (!list_empty(&pdn->list))
>>>   				list_del(&pdn->list);
>>>
>>>
>>


-- 
Alexey
