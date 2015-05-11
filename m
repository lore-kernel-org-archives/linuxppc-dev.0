Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C14C1A0286
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:16:25 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so103143873pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 00:16:23 -0700 (PDT)
Message-ID: <55505740.3020100@ozlabs.ru>
Date: Mon, 11 May 2015 17:16:16 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 09/21] powerpc/powernv: Use PCI slot reset
 infrastructure
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-10-git-send-email-gwshan@linux.vnet.ibm.com>
 <554E0E71.2080200@ozlabs.ru> <20150511064547.GA8241@gwshan>
In-Reply-To: <20150511064547.GA8241@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2015 04:45 PM, Gavin Shan wrote:
> On Sat, May 09, 2015 at 11:41:05PM +1000, Alexey Kardashevskiy wrote:
>> On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>> For PowerNV platform, running on top of skiboot, all PE level reset
>>> should be routed to firmware if the bridge of the PE primary bus has
>>> device-node property "ibm,reset-by-firmware". Otherwise, the kernel
>>> has to issue hot reset on PE's primary bus despite the requested reset
>>> types, which is the behaviour before the firmware supports PCI slot
>>> reset. So the changes don't depend on the PCI slot reset capability
>>> exposed from the firmware.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/eeh.h               |   1 +
>>>   arch/powerpc/include/asm/opal.h              |   4 +-
>>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 206 +++++++++++++--------------
>>>   3 files changed, 102 insertions(+), 109 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>> index c5eb86f..2793d24 100644
>>> --- a/arch/powerpc/include/asm/eeh.h
>>> +++ b/arch/powerpc/include/asm/eeh.h
>>> @@ -190,6 +190,7 @@ enum {
>>>   #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
>>>   #define EEH_RESET_HOT		1	/* Hot reset			*/
>>>   #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
>>> +#define EEH_RESET_COMPLETE	4	/* PHB complete reset           */
>>>   #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
>>>   #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
>>>
>>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>>> index 042af1a..6d467df 100644
>>> --- a/arch/powerpc/include/asm/opal.h
>>> +++ b/arch/powerpc/include/asm/opal.h
>>> @@ -129,7 +129,7 @@ int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t
>>>   int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
>>>   					uint16_t dma_window_number, uint64_t pci_start_addr,
>>>   					uint64_t pci_mem_size);
>>> -int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
>>> +int64_t opal_pci_reset(uint64_t id, uint8_t reset_scope, uint8_t assert_state);
>>>
>>>   int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
>>>   				   uint64_t diag_buffer_len);
>>> @@ -145,7 +145,7 @@ int64_t opal_get_epow_status(__be64 *status);
>>>   int64_t opal_set_system_attention_led(uint8_t led_action);
>>>   int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
>>>   			    __be16 *pci_error_type, __be16 *severity);
>>> -int64_t opal_pci_poll(uint64_t phb_id);
>>> +int64_t opal_pci_poll(uint64_t id, uint8_t *val);
>>>   int64_t opal_return_cpu(void);
>>>   int64_t opal_check_token(uint64_t token);
>>>   int64_t opal_reinit_cpus(uint64_t flags);
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> index ce738ab..3c01095 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -742,12 +742,12 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
>>>   	return ret;
>>>   }
>>>
>>> -static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
>>> +static s64 pnv_eeh_poll(uint64_t id)
>>>   {
>>>   	s64 rc = OPAL_HARDWARE;
>>>
>>>   	while (1) {
>>> -		rc = opal_pci_poll(phb->opal_id);
>>> +		rc = opal_pci_poll(id, NULL);
>>>   		if (rc <= 0)
>>>   			break;
>>>
>>> @@ -763,84 +763,38 @@ static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
>>>   int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
>>>   {
>>>   	struct pnv_phb *phb = hose->private_data;
>>> +	uint8_t scope;
>>>   	s64 rc = OPAL_HARDWARE;
>>>
>>>   	pr_debug("%s: Reset PHB#%x, option=%d\n",
>>>   		 __func__, hose->global_number, option);
>>> -
>>> -	/* Issue PHB complete reset request */
>>> -	if (option == EEH_RESET_FUNDAMENTAL ||
>>> -	    option == EEH_RESET_HOT)
>>> -		rc = opal_pci_reset(phb->opal_id,
>>> -				    OPAL_RESET_PHB_COMPLETE,
>>> -				    OPAL_ASSERT_RESET);
>>> -	else if (option == EEH_RESET_DEACTIVATE)
>>> -		rc = opal_pci_reset(phb->opal_id,
>>> -				    OPAL_RESET_PHB_COMPLETE,
>>> -				    OPAL_DEASSERT_RESET);
>>> -	if (rc < 0)
>>> -		goto out;
>>> -
>>> -	/*
>>> -	 * Poll state of the PHB until the request is done
>>> -	 * successfully. The PHB reset is usually PHB complete
>>> -	 * reset followed by hot reset on root bus. So we also
>>> -	 * need the PCI bus settlement delay.
>>> -	 */
>>> -	rc = pnv_eeh_phb_poll(phb);
>>> -	if (option == EEH_RESET_DEACTIVATE) {
>>> -		if (system_state < SYSTEM_RUNNING)
>>> -			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
>>> -		else
>>> -			msleep(EEH_PE_RST_SETTLE_TIME);
>>
>>
>> These udelay() and msleep() are gone. How come they are not needed anymore?
>> Worth commenting in the commit log or remove those in a separate patch.
>>
>> I just remember you mentioning some missing delays somewhere which caused
>> NVIDIA device to issue EEH and I do not want those to disappear :)
>>
>
> Yeah, I think you're correct that it's not safe to remove this yet because
> the old firmware (without corresponding PCI hotplug changes) doesn't have
> the required delays from opal_pci_poll() yet. I'll add this in next revision.


And in a later patch you add some delays. If they are the same delays but 
in a different place, they should go to the same patch.


>
>>
>>> +	switch (option) {
>>> +	case EEH_RESET_HOT:
>>> +		scope = OPAL_RESET_PCI_HOT;
>>> +		break;
>>> +	case EEH_RESET_FUNDAMENTAL:
>>> +		scope = OPAL_RESET_PCI_FUNDAMENTAL;
>>> +		break;
>>> +	case EEH_RESET_COMPLETE:
>>> +		scope = OPAL_RESET_PHB_COMPLETE;
>>> +		break;
>>> +	case EEH_RESET_DEACTIVATE:
>>> +		return 0;
>>> +	default:
>>> +		pr_warn("%s: Unsupported option %d\n",
>>> +			__func__, option);
>>> +		return -EINVAL;
>>>   	}
>>> -out:
>>> -	if (rc != OPAL_SUCCESS)
>>> -		return -EIO;
>>>
>>> -	return 0;
>>> -}
>>> -
>>> -static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
>>> -{
>>> -	struct pnv_phb *phb = hose->private_data;
>>> -	s64 rc = OPAL_HARDWARE;
>>> +	/* Issue reset and poll until it's completed */
>>> +	rc = opal_pci_reset(phb->opal_id, scope, OPAL_ASSERT_RESET);
>>> +	if (rc > 0)
>>> +		rc = pnv_eeh_poll(phb->opal_id);
>>>
>>> -	pr_debug("%s: Reset PHB#%x, option=%d\n",
>>> -		 __func__, hose->global_number, option);
>>> -
>>> -	/*
>>> -	 * During the reset deassert time, we needn't care
>>> -	 * the reset scope because the firmware does nothing
>>> -	 * for fundamental or hot reset during deassert phase.
>>> -	 */
>>> -	if (option == EEH_RESET_FUNDAMENTAL)
>>> -		rc = opal_pci_reset(phb->opal_id,
>>> -				    OPAL_RESET_PCI_FUNDAMENTAL,
>>> -				    OPAL_ASSERT_RESET);
>>> -	else if (option == EEH_RESET_HOT)
>>> -		rc = opal_pci_reset(phb->opal_id,
>>> -				    OPAL_RESET_PCI_HOT,
>>> -				    OPAL_ASSERT_RESET);
>>> -	else if (option == EEH_RESET_DEACTIVATE)
>>> -		rc = opal_pci_reset(phb->opal_id,
>>> -				    OPAL_RESET_PCI_HOT,
>>> -				    OPAL_DEASSERT_RESET);
>>> -	if (rc < 0)
>>> -		goto out;
>>> -
>>> -	/* Poll state of the PHB until the request is done */
>>> -	rc = pnv_eeh_phb_poll(phb);
>>> -	if (option == EEH_RESET_DEACTIVATE)
>>> -		msleep(EEH_PE_RST_SETTLE_TIME);
>>> -out:
>>> -	if (rc != OPAL_SUCCESS)
>>> -		return -EIO;
>>> -
>>> -	return 0;
>>> +	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
>>>   }
>>>
>>> -static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>> +static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>>   {
>>>   	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
>>>   	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>> @@ -891,14 +845,57 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>>   	return 0;
>>>   }
>>>
>>> +static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>> +{
>>> +	struct pci_controller *hose;
>>> +	struct pnv_phb *phb;
>>> +	struct device_node *dn = dev ? pci_device_to_OF_node(dev) : NULL;
>>> +	uint64_t id = (0x1ul << 60);
>>> +	uint8_t scope;
>>> +	s64 rc;
>>
>>
>> int64_t for @rc?
>>
>>
>
> Yes.
>
>>> +
>>> +	/*
>>> +	 * If the firmware can't handle it, we will issue hot reset
>>> +	 * on the secondary bus despite the requested reset type
>>> +	 */
>>> +	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
>>> +		return __pnv_eeh_bridge_reset(dev, option);
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
>>> +	case EEH_RESET_COMPLETE:
>>> +	default:
>>> +		pr_warn("%s: Unsupported option %d on device %s\n",
>>> +			__func__, option, pci_name(dev));
>>> +		return -EINVAL;
>>> +	}
>>
>>
>> This is the same switch as earlier in this patch (slightly different order).
>> Move it and opal_pci_reset() into a helper and call it pnv_opal_pci_reset()?
>>
>>
>
> It sounds a good idea. I'll do accordingly.
>
>>> +
>>> +	hose = pci_bus_to_host(dev->bus);
>>> +	phb = hose->private_data;
>>
>> Previously you would initialize @hose and @phb where you declared those but
>> not here. If you did the same thing as before, the patch could have been
>> smaller and easier to read.
>>
>
> Sure.
>
>>> +	id |= (dev->bus->number << 24) | (dev->devfn << 16) | phb->opal_id;
>>> +	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
>>> +	if (rc > 0)
>>> +		rc = pnv_eeh_poll(id);
>>> +
>>> +	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
>>> +}
>>> +
>>>   void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>>   {
>>>   	struct pci_controller *hose;
>>>
>>>   	if (pci_is_root_bus(dev->bus)) {
>>>   		hose = pci_bus_to_host(dev->bus);
>>> -		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
>>> -		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
>>> +		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
>>> +		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
>>>   	} else {
>>>   		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>>>   		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>>> @@ -920,8 +917,9 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>>   static int pnv_eeh_reset(struct eeh_pe *pe, int option)
>>>   {
>>>   	struct pci_controller *hose = pe->phb;
>>> +	struct pnv_phb *phb;
>>>   	struct pci_bus *bus;
>>> -	int ret;
>>> +	s64 rc;
>>>
>>>   	/*
>>>   	 * For PHB reset, we always have complete reset. For those PEs whose
>>> @@ -937,43 +935,37 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
>>>   	 * reset. The side effect is that EEH core has to clear the frozen
>>>   	 * state explicitly after BAR restore.
>>>   	 */
>>> -	if (pe->type & EEH_PE_PHB) {
>>> -		ret = pnv_eeh_phb_reset(hose, option);
>>> -	} else {
>>> -		struct pnv_phb *phb;
>>> -		s64 rc;
>>> +	if (pe->type & EEH_PE_PHB)
>>
>> I would keep "{" in the line above ....
>>
>>> +		return pnv_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
>>
>> ...put "} else {" here...
>>
>> and the chunk below would become 1) very small 2) very trivial... And then
>> you could make a trivial patch which would do scope removal but without
>> functional changes. Or vice versa.
>>
>
> I intended to remove nested if(). If you really want me to change the code
> according to your comments, I'll do. Otherwise, I prefer to keep it as
> of being.


Use your best judgement :) If do shift the whole block, just make sure that 
all what you is moving and nothing is lost/added during this move.


>>>
>>> -		/*
>>> -		 * The frozen PE might be caused by PAPR error injection
>>> -		 * registers, which are expected to be cleared after hitting
>>> -		 * frozen PE as stated in the hardware spec. Unfortunately,
>>> -		 * that's not true on P7IOC. So we have to clear it manually
>>> -		 * to avoid recursive EEH errors during recovery.
>>> -		 */
>>> -		phb = hose->private_data;
>>> -		if (phb->model == PNV_PHB_MODEL_P7IOC &&
>>> -		    (option == EEH_RESET_HOT ||
>>> -		    option == EEH_RESET_FUNDAMENTAL)) {
>>> -			rc = opal_pci_reset(phb->opal_id,
>>> -					    OPAL_RESET_PHB_ERROR,
>>> -					    OPAL_ASSERT_RESET);
>>> -			if (rc != OPAL_SUCCESS) {
>>> -				pr_warn("%s: Failure %lld clearing "
>>> -					"error injection registers\n",
>>> -					__func__, rc);
>>> -				return -EIO;
>>> -			}
>>> +	/*
>>> +	 * The frozen PE might be caused by PAPR error injection
>>> +	 * registers, which are expected to be cleared after hitting
>>> +	 * frozen PE as stated in the hardware spec. Unfortunately,
>>> +	 * that's not true on P7IOC. So we have to clear it manually
>>> +	 * to avoid recursive EEH errors during recovery.
>>> +	 */
>>> +	phb = hose->private_data;
>>> +	if (phb->model == PNV_PHB_MODEL_P7IOC &&
>>> +	    (option == EEH_RESET_HOT ||
>>> +	    option == EEH_RESET_FUNDAMENTAL)) {
>>> +		rc = opal_pci_reset(phb->opal_id,
>>> +				    OPAL_RESET_PHB_ERROR,
>>> +				    OPAL_ASSERT_RESET);
>>> +		if (rc != OPAL_SUCCESS) {
>>> +			pr_warn("%s: Failure %lld clearing error "
>>> +				"injection registers on PHB#%d\n",
>>> +				__func__, rc, hose->global_number);
>>> +			return -EIO;
>>>   		}
>>> -
>>> -		bus = eeh_pe_bus_get(pe);
>>> -		if (pci_is_root_bus(bus) ||
>>> -			pci_is_root_bus(bus->parent))
>>> -			ret = pnv_eeh_root_reset(hose, option);
>>> -		else
>>> -			ret = pnv_eeh_bridge_reset(bus->self, option);
>>>   	}
>>>
>>> -	return ret;
>>> +	/* Route the reset request to PHB or upstream bridge */
>>> +	bus = eeh_pe_bus_get(pe);
>>> +	if (pci_is_root_bus(bus))
>>> +		return pnv_eeh_phb_reset(hose, option);
>>> +
>>> +	return pnv_eeh_bridge_reset(bus->self, option);
>>>   }
>>>
>>>   /**
>>>
>
> Thanks,
> Gavin
>


-- 
Alexey
