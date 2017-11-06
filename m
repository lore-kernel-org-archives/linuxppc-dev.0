Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVdvP3xkDzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 14:53:20 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i5so6764651pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Nov 2017 19:53:20 -0800 (PST)
Subject: Re: [RFC PATCH kernel] powerpc/pci: Get rid of unused @parent pointer
 in pci_controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>
References: <20171106032441.10031-1-aik@ozlabs.ru>
 <1509939232.2780.45.camel@kernel.crashing.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <584313dd-6f3d-9dad-d3a4-6e15cea58991@ozlabs.ru>
Date: Mon, 6 Nov 2017 14:53:12 +1100
MIME-Version: 1.0
In-Reply-To: <1509939232.2780.45.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/17 14:33, Benjamin Herrenschmidt wrote:
> On Mon, 2017-11-06 at 14:24 +1100, Alexey Kardashevskiy wrote:
>> The @parent pointer is supposed to point to a device which represents
>> a PCI controller, however it is never set to anything and remains NULL;
>> it is also quite common to pass NULL to pci_create_root_bus().
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
> 
> It's used for anything using of_pci_phb_probe() such as Cell.


ah, ok, thanks.

> 
> 
>>
>> This @parent is NULL for every PHB in garrison machines, for example.
>> Where would this pointer be really used?
>>
>> I wonder how does setting it make any difference in sysfs for CXL vphb?
>>
>> In general, I'd think that @parent makes sense and every PHB
>> has a parent device struct like any other device and the platform
>> code binds a correct device driver to a PHB and we can avoid
>> having PNV_PHB_IODA2&co switches but for some reason PHBs are
>> hardcoded in the platform code.
>>
>> ---
>>  arch/powerpc/include/asm/pci-bridge.h | 1 -
>>  arch/powerpc/kernel/pci-common.c      | 2 +-
>>  drivers/misc/cxl/vphb.c               | 3 ---
>>  3 files changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index 752718a2949d..ad88ddeaa6b7 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -60,7 +60,6 @@ struct pci_controller {
>>  #endif
>>  	struct device_node *dn;
>>  	struct list_head list_node;
>> -	struct device *parent;
>>  
>>  	int first_busno;
>>  	int last_busno;
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 02831a396419..597576777c34 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1681,7 +1681,7 @@ void pcibios_scan_phb(struct pci_controller *hose)
>>  	pci_add_resource(&resources, &hose->busn);
>>  
>>  	/* Create an empty bus for the toplevel */
>> -	bus = pci_create_root_bus(hose->parent, hose->first_busno,
>> +	bus = pci_create_root_bus(NULL, hose->first_busno,
>>  				  hose->ops, hose, &resources);
>>  	if (bus == NULL) {
>>  		pr_err("Failed to create bus for PCI domain %04x\n",
>> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
>> index 512a4897dbf6..ae3fe1563812 100644
>> --- a/drivers/misc/cxl/vphb.c
>> +++ b/drivers/misc/cxl/vphb.c
>> @@ -232,9 +232,6 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
>>  	if (!phb)
>>  		return -ENODEV;
>>  
>> -	/* Setup parent in sysfs */
>> -	phb->parent = parent;
>> -
>>  	/* Setup the PHB using arch provided callback */
>>  	phb->ops = &cxl_pcie_pci_ops;
>>  	phb->cfg_addr = NULL;


-- 
Alexey
