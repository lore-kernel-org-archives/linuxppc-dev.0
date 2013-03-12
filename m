Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 86D922C02F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 21:32:33 +1100 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Chen Yuanquan-B41889 <B41889@freescale.com>
Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe controllers
Date: Tue, 12 Mar 2013 11:30:18 +0100
Message-ID: <2837636.lhg2IyzI4d@pcimr>
In-Reply-To: <513EFF84.3090103@freescale.com>
References: <3E027F8168735B46AC006B1D0C7BB0020B102CFB@039-SN2MPN1-013.039d.mgd.msft.net>
 <513EFF84.3090103@freescale.com>
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

On Tuesday 12 March 2013 18:12:20 Chen Yuanquan-B41889 wrote:
> >> -----Original Message-----
> >> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> >> fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Rojhalat Ibrahim
> >> Sent: Tuesday, March 12, 2013 5:23 PM
> >> To: Kumar Gala
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe
> >> controllers
> >> 
> >> On Monday 11 March 2013 12:17:42 Kumar Gala wrote:
> >>> Rather than do it this way, we should do something like:
> >>> 
> >>> fsl_indirect_read_config() {
> >>> 
> >>> 	link check
> >>> 	if (link)
> >>> 	
> >>> 		indirect_read_config()
> >>> 
> >>> }
> >>> 
> >>> and just add fsl_indirect_{r,w}_config into fsl_pci.c
> >>> 
> >>> - k
> >> 
> >> Ok, how about this:
> Yeah, this patch can solve the problem of PCI-e bus rescan which a PCI-e
> EP is added to RC
> after RC booting up. If RC boots up without EP added, the original code
> will set the PCI-e
> bus as no link even if you add a EP to RC during RC's runtime.
> 
> Regards,
> Yuanquan
> 

Right. The EP is only added if you first do "echo 1 > /sys/bus/pci/rescan".

   Rojhalat


> >> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> >> ---
> >> 
> >>   arch/powerpc/sysdev/fsl_pci.c |   49
> >> 
> >> ++++++++++++++++++++++++++++++++++++++----
> >> 
> >>   1 file changed, 45 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/sysdev/fsl_pci.c
> >> b/arch/powerpc/sysdev/fsl_pci.c index 682084d..693db9f 100644
> >> --- a/arch/powerpc/sysdev/fsl_pci.c
> >> +++ b/arch/powerpc/sysdev/fsl_pci.c
> >> @@ -36,6 +36,8 @@
> >> 
> >>   static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
> >> 
> >> +static struct pci_ops *indirect_pci_ops;
> >> +
> >> 
> >>   static void quirk_fsl_pcie_header(struct pci_dev *dev)  {
> >>   
> >>   	u8 hdr_type;
> >> 
> >> @@ -64,6 +66,45 @@ static int __init fsl_pcie_check_link(struct
> >> pci_controller
> >> *hose)
> >> 
> >>   	return 0;
> >>   
> >>   }
> >> 
> >> +static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int
> >> devfn,
> >> +				    int offset, int len, u32 *val)
> >> +{
> >> +	struct pci_controller *hose = pci_bus_to_host(bus);
> >> +
> >> +	// check the link status
> >> +	if ((bus->number == hose->first_busno) && (devfn == 0)) {
> >> +		u32 ltssm = 0;
> >> +		indirect_pci_ops->read(bus, 0, PCIE_LTSSM, 4, &ltssm);
> >> +		if (ltssm < PCIE_LTSSM_L0) {
> >> +			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> >> +		} else {
> >> +			hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> >> +		}
> >> +	}
> >> +	return indirect_pci_ops->read(bus, devfn, offset, len, val); }
> >> +
> >> +static int fsl_indirect_write_config(struct pci_bus *bus, unsigned int
> >> devfn,
> >> +				     int offset, int len, u32 val)
> >> +{
> >> +	return indirect_pci_ops->write(bus, devfn, offset, len, val); }
> >> +
> >> +static struct pci_ops fsl_indirect_pci_ops = {
> >> +	.read = fsl_indirect_read_config,
> >> +	.write = fsl_indirect_write_config,
> >> +};
> >> +
> >> +static void __init fsl_setup_indirect_pci(struct pci_controller* hose,
> >> +					  resource_size_t cfg_addr,
> >> +					  resource_size_t cfg_data, u32 flags) {
> >> +	setup_indirect_pci(hose, cfg_addr, cfg_data, flags);
> >> +	indirect_pci_ops = hose->ops;
> >> +	hose->ops = &fsl_indirect_pci_ops;
> >> +}
> >> +
> >> 
> >>   #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
> >>   
> >>   #define MAX_PHYS_ADDR_BITS	40
> >> 
> >> @@ -461,8 +502,8 @@ int __init fsl_add_bridge(struct platform_device
> >> *pdev, int is_primary)
> >> 
> >>   	hose->first_busno = bus_range ? bus_range[0] : 0x0;
> >>   	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> >> 
> >> -	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
> >> -		PPC_INDIRECT_TYPE_BIG_ENDIAN);
> >> +	fsl_setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
> >> +			       PPC_INDIRECT_TYPE_BIG_ENDIAN);
> >> 
> >>   	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
> >>   	
> >>   		/* For PCIE read HEADER_TYPE to identify controler mode */ @@
> >> 
> >> -766,8 +807,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
> >> 
> >>   		if (ret)
> >>   		
> >>   			goto err0;
> >>   	
> >>   	} else {
> >> 
> >> -		setup_indirect_pci(hose, rsrc_cfg.start,
> >> -				   rsrc_cfg.start + 4, 0);
> >> +		fsl_setup_indirect_pci(hose, rsrc_cfg.start,
> >> +				       rsrc_cfg.start + 4, 0);
> >> 
> >>   	}
> >>   	
> >>   	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
> >> 
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@lists.ozlabs.org
> >> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
