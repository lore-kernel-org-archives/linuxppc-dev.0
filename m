Return-Path: <B31939@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 625ED2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 13:37:36 +1000 (EST)
Message-ID: <505BE102.7080701@freescale.com>
Date: Fri, 21 Sep 2012 11:37:38 +0800
From: Lian Minghaun-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl-pci: use 'Header Type' to identify PCIE mode
References: <1348039419-17798-1-git-send-email-Minghuan.Lian@freescale.com>
 <4FA47D63-B0ED-42BF-A075-174B6338A0E8@kernel.crashing.org>
In-Reply-To: <4FA47D63-B0ED-42BF-A075-174B6338A0E8@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

please see my comments inline.


On 09/19/2012 10:22 PM, Kumar Gala wrote:
> On Sep 19, 2012, at 2:23 AM, Minghuan Lian wrote:
>
>> The original code uses 'Programming Interface' field to judge if PCIE is
>> EP or RC mode, however, some latest silicons do not support this functionality.
>> According to PCIE specification, 'Header Type' offset 0x0e is used to
>> indicate header type, so change code to use 'Header Type' field to
>> judge PCIE mode. Because FSL PCI controller does not support 'Header Type',
>> patch still uses 'Programming Interface' to identify PCI mode.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>> ---
>> arch/powerpc/sysdev/fsl_pci.c |   38 +++++++++++++++++++++++---------------
>> 1 file changed, 23 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>> index c37f461..43d30df 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -38,15 +38,15 @@ static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
>>
>> static void __devinit quirk_fsl_pcie_header(struct pci_dev *dev)
>> {
>> -	u8 progif;
>> +	u8 hdr_type;
>>
>> 	/* if we aren't a PCIe don't bother */
>> 	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
>> 		return;
>>
>> 	/* if we aren't in host mode don't bother */
>> -	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
>> -	if (progif & 0x1)
>> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
>> +	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
>> 		return;
>>
>> 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>> @@ -425,7 +425,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
>> 	struct pci_controller *hose;
>> 	struct resource rsrc;
>> 	const int *bus_range;
>> -	u8 progif;
>> +	u8 hdr_type, progif;
>>
>> 	if (!of_device_is_available(dev)) {
>> 		pr_warning("%s: disabled\n", dev->full_name);
>> @@ -457,25 +457,24 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
>> 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
>> 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
>>
>> -	early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
>> -	if ((progif & 1) == 1) {
>> -		/* unmap cfg_data & cfg_addr separately if not on same page */
>> -		if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
>> -		    ((unsigned long)hose->cfg_addr & PAGE_MASK))
>> -			iounmap(hose->cfg_data);
>> -		iounmap(hose->cfg_addr);
>> -		pcibios_free_controller(hose);
>> -		return -ENODEV;
>> -	}
>> -
>> 	setup_pci_cmd(hose);
> I think we should be doing the check before we call setup_pci_cmd().  The old code didn't touch the controller registers if we where and end-point.  We should maintain that.
[Minghuan] Thanks for you pointing this.
I want to move setup_pci_cmd like this:

pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
         hose, hose->cfg_addr, hose->cfg_data);

+    setup_pci_cmd(hose);

     /* Interpret the "ranges" property */
     /* This also maps the I/O region and sets isa_io/mem_base */
     pci_process_bridge_OF_ranges(hose, dev, is_primary);

This movement will cause fsl_pcie_check_link() calling before 
setup_pci_cmd().
Is this ok?
If not, I will call setup_pci_cmd() for PCI and PCIE respectively.

>> 	/* check PCI express link status */
>> 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
>> +		/* For PCIE read HEADER_TYPE to identify controler mode */
>> +		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
>> +		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
>> +			goto no_bridge;
>> +
>> 		hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
>> 			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
>> 		if (fsl_pcie_check_link(hose))
>> 			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
>> +	} else {
>> +		/* For PCI read PROG to identify controller mode */
>> +		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
>> +		if ((progif & 1) == 1)
>> +			goto no_bridge;
>> 	}
>>
>> 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
>> @@ -494,6 +493,15 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
>> 	setup_pci_atmu(hose, &rsrc);
>>
>> 	return 0;
>> +
>> +no_bridge:
>> +	/* unmap cfg_data & cfg_addr separately if not on same page */
>> +	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
>> +	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
>> +		iounmap(hose->cfg_data);
>> +	iounmap(hose->cfg_addr);
>> +	pcibios_free_controller(hose);
>> +	return -ENODEV;
>> }
>> #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
>>
>> -- 
>> 1.7.9.5
>>
>
