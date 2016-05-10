Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r45tr5c8QzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 03:33:08 +1000 (AEST)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 10 May 2016 14:33:03 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DEFA21DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 13:32:54 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4AHX1el65732720
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 14:33:01 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4AHX00O026742
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 14:33:00 -0300
Subject: Re: [PATCH v5] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1460670924-16845-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160502165739.GD24851@localhost>
Cc: mikey@neuling.org, frederic.barrat@fr.ibm.com, linux-pci@vger.kernel.org,
 mrochs@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com, paulus@samba.org,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <57321B4A.1000201@linux.vnet.ibm.com>
Date: Tue, 10 May 2016 14:32:58 -0300
MIME-Version: 1.0
In-Reply-To: <20160502165739.GD24851@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/02/2016 01:57 PM, Bjorn Helgaas wrote:
> On Thu, Apr 14, 2016 at 06:55:24PM -0300, Guilherme G. Piccoli wrote:
>> The domain/PHB field of PCI addresses has its value obtained from a
>> global variable, incremented each time a new domain (represented by
>> struct pci_controller) is added on the system. The domain addition
>> process happens during boot or due to PCI device hotplug.
>>
>> As recent kernels are using predictable naming for network interfaces,
>> the network stack is more tied to PCI naming. This can be a problem in
>> hotplug scenarios, because PCI addresses will change if devices are
>> removed and then re-added. This situation seems unusual, but it can
>> happen if a user wants to replace a NIC without rebooting the machine,
>> for example.
>>
>> This patch changes the way PCI domain values are generated: now, we use
>> device-tree properties to assign fixed PHB numbers to PCI addresses
>> when available (meaning pSeries and PowerNV cases). We also use a bitmap
>> to allow dynamic PHB numbering when device-tree properties are not
>> used. This bitmap keeps track of used PHB numbers and if a PHB is
>> released (by hotplug operations for example), it allows the reuse of
>> this PHB number, avoiding PCI address to change in case of device remove
>> and re-add soon after. No functional changes were introduced.
>>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>
> I assume the powerpc guys will take care of this.  Let me know if you
> need me to do anything.

Thanks very much Bjorn! I sent this to PCI list to let you know, since 
this modification is PCI nearly related. But it is truly something 
specific to powerpc, so you're right, the linuxpcc-dev list folks will 
take care.

Cheers,


Guilherme

>
>> ---
>>   arch/powerpc/kernel/pci-common.c | 66 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 63 insertions(+), 3 deletions(-)
>>
>> v5:
>>    * Improved comments.
>>
>>    * Changed the the Fixed PHB Numbering to set the PHB number bit
>>    on the bitmap anyway, avoiding issues when system has virtual PHBs.
>>
>>    * Changed the device-tree check order - now, firstly we check for
>>    "ibm,opal-phbid" and if it's not available, we try the pSeries case.
>>
>> v4:
>>    * Minor change (if/else nesting rearranged).
>>
>> v3:
>>    * Made the bitmap static.
>>
>>    * Rearranged if/else statements of Fixed PHB checking.
>>
>>    * Improved bitmap checkings, by removing loop and using instead the
>>    find_first_zero_bit() function.
>>
>>    * Removed the single-statement function release_phb_number() by
>>    adding its logic directly into pcibios_free_controller().
>>
>>    *Added check for bitmap size before clearing bit, avoiding memory
>>    corruption.
>>
>> v2:
>>    * Added the Fixed PHB Numbering mechanism based on device-tree
>>    properties.
>>
>>    * Changed list approach to bitmap on the Dynamic PHB Numbering
>>    mechanism.
>>
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 0f7a60f..ad423c1 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -41,11 +41,17 @@
>>   #include <asm/ppc-pci.h>
>>   #include <asm/eeh.h>
>>
>> +/* hose_spinlock protects accesses to the the phb_bitmap. */
>>   static DEFINE_SPINLOCK(hose_spinlock);
>>   LIST_HEAD(hose_list);
>>
>> -/* XXX kill that some day ... */
>> -static int global_phb_number;		/* Global phb counter */
>> +/* For dynamic PHB numbering on get_phb_number(): max number of PHBs. */
>> +#define	MAX_PHBS	8192
>> +
>> +/* For dynamic PHB numbering: used/free PHBs tracking bitmap.
>> + * Accesses to this bitmap should be protected by hose_spinlock.
>> + */
>> +static DECLARE_BITMAP(phb_bitmap, MAX_PHBS);
>>
>>   /* ISA Memory physical address */
>>   resource_size_t isa_mem_base;
>> @@ -64,6 +70,55 @@ struct dma_map_ops *get_pci_dma_ops(void)
>>   }
>>   EXPORT_SYMBOL(get_pci_dma_ops);
>>
>> +/* get_phb_number() function should run under locking
>> + * protection, specifically hose_spinlock.
>> + */
>> +static int get_phb_number(struct device_node *dn)
>> +{
>> +	const __be64 *prop64;
>> +	const __be32 *regs;
>> +	int phb_id = 0;
>> +
>> +	/* Try fixed PHB numbering first, by checking archs and reading
>> +	 * the respective device-tree properties. Firstly, try PowerNV by
>> +	 * reading "ibm,opal-phbid", only present in OPAL environment.
>> +	 */
>> +	prop64 = of_get_property(dn, "ibm,opal-phbid", NULL);
>> +	if (prop64) {
>> +		phb_id = (int)(be64_to_cpup(prop64) & 0xFFFF);
>> +
>> +	} else if (machine_is(pseries)) {
>> +		regs = of_get_property(dn, "reg", NULL);
>> +		if (regs)
>> +			phb_id = (int)(be32_to_cpu(regs[1]) & 0xFFFF);
>> +	} else {
>> +		goto dynamic_phb_numbering;
>> +	}
>> +
>> +	/* If we have a huge PHB number obtained from device-tree, no need
>> +	 * to worry with the bitmap. Otherwise, we need to be sure we're
>> +	 * not trying to use the same PHB number twice.
>> +	 */
>> +	if (phb_id < MAX_PHBS) {
>> +		if (test_bit(phb_id, phb_bitmap))
>> +			goto dynamic_phb_numbering;
>> +		set_bit(phb_id, phb_bitmap);
>> +	}
>> +
>> +	return phb_id;
>> +
>> +	/* If not pSeries nor PowerNV, or if fixed PHB numbering tried to add
>> +	 * the same PHB number twice, then fallback to dynamic PHB numbering.
>> +	 */
>> +dynamic_phb_numbering:
>> +
>> +	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
>> +	BUG_ON(phb_id >= MAX_PHBS); /* Reached maximum number of PHBs. */
>> +	set_bit(phb_id, phb_bitmap);
>> +
>> +	return phb_id;
>> +}
>> +
>>   struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
>>   {
>>   	struct pci_controller *phb;
>> @@ -72,7 +127,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
>>   	if (phb == NULL)
>>   		return NULL;
>>   	spin_lock(&hose_spinlock);
>> -	phb->global_number = global_phb_number++;
>> +	phb->global_number = get_phb_number(dev);
>>   	list_add_tail(&phb->list_node, &hose_list);
>>   	spin_unlock(&hose_spinlock);
>>   	phb->dn = dev;
>> @@ -94,6 +149,11 @@ EXPORT_SYMBOL_GPL(pcibios_alloc_controller);
>>   void pcibios_free_controller(struct pci_controller *phb)
>>   {
>>   	spin_lock(&hose_spinlock);
>> +
>> +	/* Clear bit of phb_bitmap to allow reuse of this PHB number. */
>> +	if (phb->global_number < MAX_PHBS)
>> +		clear_bit(phb->global_number, phb_bitmap);
>> +
>>   	list_del(&phb->list_node);
>>   	spin_unlock(&hose_spinlock);
>>
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
