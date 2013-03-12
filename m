Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8ED2E2C02A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 23:12:29 +1100 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Chen Yuanquan-B41889 <B41889@freescale.com>
Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe controllers
Date: Tue, 12 Mar 2013 13:12:24 +0100
Message-ID: <2873445.Me6lNrj5eu@pcimr>
In-Reply-To: <513F0B8B.4090607@freescale.com>
References: <3E027F8168735B46AC006B1D0C7BB0020B102CFB@039-SN2MPN1-013.039d.mgd.msft.net>
 <2837636.lhg2IyzI4d@pcimr> <513F0B8B.4090607@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 12 March 2013 19:03:39 Chen Yuanquan-B41889 wrote:
> On 03/12/2013 06:30 PM, Rojhalat Ibrahim wrote:
> > On Tuesday 12 March 2013 18:12:20 Chen Yuanquan-B41889 wrote:
> >>>> -----Original Message-----
> >>>> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> >>>> fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Rojhalat Ibrahim
> >>>> Sent: Tuesday, March 12, 2013 5:23 PM
> >>>> To: Kumar Gala
> >>>> Cc: linuxppc-dev@lists.ozlabs.org
> >>>> Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe
> >>>> controllers
> >>>> 
> >>>> On Monday 11 March 2013 12:17:42 Kumar Gala wrote:
> >>>>> Rather than do it this way, we should do something like:
> >>>>> 
> >>>>> fsl_indirect_read_config() {
> >>>>> 
> >>>>> 	link check
> >>>>> 	if (link)
> >>>>> 	
> >>>>> 		indirect_read_config()
> >>>>> 
> >>>>> }
> >>>>> 
> >>>>> and just add fsl_indirect_{r,w}_config into fsl_pci.c
> >>>>> 
> >>>>> - k
> >>>> 
> >>>> Ok, how about this:
> >> Yeah, this patch can solve the problem of PCI-e bus rescan which a PCI-e
> >> EP is added to RC
> >> after RC booting up. If RC boots up without EP added, the original code
> >> will set the PCI-e
> >> bus as no link even if you add a EP to RC during RC's runtime.
> >> 
> >> Regards,
> >> Yuanquan
> > 
> > Right. The EP is only added if you first do "echo 1 >
> > /sys/bus/pci/rescan".
> > 
> >     Rojhalat
> 
> The following patch can solve your issue of "only added if you first ...":

Actually I don't have a problem with having to do a rescan before the device 
is added. In my case the device is a FPGA which is configured at runtime. So I 
can simply trigger the rescan after configuration.

For my purposes the patch I proposed is sufficient for now.
The additional changes suggested by you should probably go into separate 
patches.

   Rojhalat


> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5b3771a..c1298d0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -730,11 +730,12 @@ int __devinit pci_scan_bridge(struct pci_bus *bus,
> struct
> 
>                  /* Prevent assigning a bus number that already exists.
>                   * This can happen when a bridge is hot-plugged */
> -               if (pci_find_bus(pci_domain_nr(bus), max+1))
> -                       goto out;
> -               child = pci_add_new_bus(bus, dev, ++max);
> -               if (!child)
> -                       goto out;
> +               child = pci_find_bus(pci_domain_nr(bus), max+1);
> +               if (!child) {
> +                       child = pci_add_new_bus(bus, dev, ++max);
> +                       if (!child)
> +                               goto out;
> +               }
>                  buses = (buses & 0xff000000)
> 
>                        | ((unsigned int)(child->primary) <<  0)
>                        | ((unsigned int)(child->secondary) <<  8)
> 
> There are still some issues about powerpc PCI-e rescan. For example, add
> a Intel e1000e
> ethernet card or silicon PCI-e_sata to powerpc PCI-e slot and boot the
> board. The EP can
> work well with their driver. But if you "echo 1 >
> /sys/bus/pci/device/xxx/remove" which
> corresponds to Intel e1000e ethernet card or  silicon PCI-e_sata, then
> "echo 1" to rescan,
> the device can be rescanned, but it will fail to load the corresponded
> driver due to hw_irq
> and dma_set_mask error. The following  patch can solve the problem, but
> not a good method
> to solve it.
> 
> diff --git a/arch/powerpc/kernel/pci-common.c
> b/arch/powerpc/kernel/pci-common.c
> index 2476a32..f9b7f0f 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1557,6 +1557,19 @@ int pcibios_enable_device(struct pci_dev *dev,
> int mask)
>                  if (ppc_md.pcibios_enable_device_hook(dev))
>                          return -EINVAL;
> 
> +       if (!dev->is_added) {
> +               set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
> +
> +               set_dma_ops(&dev->dev, pci_dma_ops);
> +               set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
> +
> +               if (ppc_md.pci_dma_dev_setup)
> +                       ppc_md.pci_dma_dev_setup(dev);
> +
> +               pci_read_irq_line(dev);
> +               if (ppc_md.pci_irq_fixup)
> +                       ppc_md.pci_irq_fixup(dev);
> +       }
>          return pci_enable_resources(dev, mask);
>   }
> 
> 
> Regards,
> Yuanquan
> 
> >>>> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> >>>> ---
> >>>> 
> >>>>    arch/powerpc/sysdev/fsl_pci.c |   49
> >>>> 
> >>>> ++++++++++++++++++++++++++++++++++++++----
> >>>> 
> >>>>    1 file changed, 45 insertions(+), 4 deletions(-)
> >>>> 
> >>>> diff --git a/arch/powerpc/sysdev/fsl_pci.c
> >>>> b/arch/powerpc/sysdev/fsl_pci.c index 682084d..693db9f 100644
> >>>> --- a/arch/powerpc/sysdev/fsl_pci.c
> >>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
> >>>> @@ -36,6 +36,8 @@
> >>>> 
> >>>>    static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
> >>>> 
> >>>> +static struct pci_ops *indirect_pci_ops;
> >>>> +
> >>>> 
> >>>>    static void quirk_fsl_pcie_header(struct pci_dev *dev)  {
> >>>>    
> >>>>    	u8 hdr_type;
> >>>> 
> >>>> @@ -64,6 +66,45 @@ static int __init fsl_pcie_check_link(struct
> >>>> pci_controller
> >>>> *hose)
> >>>> 
> >>>>    	return 0;
> >>>>    
> >>>>    }
> >>>> 
> >>>> +static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int
> >>>> devfn,
> >>>> +				    int offset, int len, u32 *val)
> >>>> +{
> >>>> +	struct pci_controller *hose = pci_bus_to_host(bus);
> >>>> +
> >>>> +	// check the link status
> >>>> +	if ((bus->number == hose->first_busno) && (devfn == 0)) {
> >>>> +		u32 ltssm = 0;
> >>>> +		indirect_pci_ops->read(bus, 0, PCIE_LTSSM, 4, &ltssm);
> >>>> +		if (ltssm < PCIE_LTSSM_L0) {
> >>>> +			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> >>>> +		} else {
> >>>> +			hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> >>>> +		}
> >>>> +	}
> >>>> +	return indirect_pci_ops->read(bus, devfn, offset, len, val); }
> >>>> +
> >>>> +static int fsl_indirect_write_config(struct pci_bus *bus, unsigned int
> >>>> devfn,
> >>>> +				     int offset, int len, u32 val)
> >>>> +{
> >>>> +	return indirect_pci_ops->write(bus, devfn, offset, len, val); }
> >>>> +
> >>>> +static struct pci_ops fsl_indirect_pci_ops = {
> >>>> +	.read = fsl_indirect_read_config,
> >>>> +	.write = fsl_indirect_write_config,
> >>>> +};
> >>>> +
> >>>> +static void __init fsl_setup_indirect_pci(struct pci_controller* hose,
> >>>> +					  resource_size_t cfg_addr,
> >>>> +					  resource_size_t cfg_data, u32 flags) {
> >>>> +	setup_indirect_pci(hose, cfg_addr, cfg_data, flags);
> >>>> +	indirect_pci_ops = hose->ops;
> >>>> +	hose->ops = &fsl_indirect_pci_ops;
> >>>> +}
> >>>> +
> >>>> 
> >>>>    #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
> >>>>    
> >>>>    #define MAX_PHYS_ADDR_BITS	40
> >>>> 
> >>>> @@ -461,8 +502,8 @@ int __init fsl_add_bridge(struct platform_device
> >>>> *pdev, int is_primary)
> >>>> 
> >>>>    	hose->first_busno = bus_range ? bus_range[0] : 0x0;
> >>>>    	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> >>>> 
> >>>> -	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
> >>>> -		PPC_INDIRECT_TYPE_BIG_ENDIAN);
> >>>> +	fsl_setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
> >>>> +			       PPC_INDIRECT_TYPE_BIG_ENDIAN);
> >>>> 
> >>>>    	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
> >>>>    	
> >>>>    		/* For PCIE read HEADER_TYPE to identify controler mode */ @@
> >>>> 
> >>>> -766,8 +807,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
> >>>> 
> >>>>    		if (ret)
> >>>>    		
> >>>>    			goto err0;
> >>>>    	
> >>>>    	} else {
> >>>> 
> >>>> -		setup_indirect_pci(hose, rsrc_cfg.start,
> >>>> -				   rsrc_cfg.start + 4, 0);
> >>>> +		fsl_setup_indirect_pci(hose, rsrc_cfg.start,
> >>>> +				       rsrc_cfg.start + 4, 0);
> >>>> 
> >>>>    	}
> >>>>    	
> >>>>    	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
> >>>> 
> >>>> _______________________________________________
> >>>> Linuxppc-dev mailing list
> >>>> Linuxppc-dev@lists.ozlabs.org
> >>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >> 
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@lists.ozlabs.org
> >> https://lists.ozlabs.org/listinfo/linuxppc-dev
